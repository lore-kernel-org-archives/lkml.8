Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52D1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A32820838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YxjIiKkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHJUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:09:24 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:39720 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgHJUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:09:23 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQRrK1fWRz5m;
        Mon, 10 Aug 2020 22:09:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597090161; bh=x2W1ts7k6Q36bs2XZvdlym6exqyAoh+vsYhpJCbyDaU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=YxjIiKkp6ikJP1O/C4DC/cC5avVYsTqzIGXH+BSAc/cd7ZQp3/WRkB/dsFrQmXRgQ
         4dBAr40teWQ4MtEcy4DRZ3q6asi1TeBdRQjKV+tI9FGf6VgN187Baco+mi9ADivpIx
         N9Fn4kwHACbkyaSagbXAJWM218+Nk4/2myrXfNjcwEmHUjCk338+YqkZbfZuf62OYG
         jJtxvPZhVeV3NMgF5VUHSU+WTbGe1CeIPsYN64kOtB5mfWV8o19I6nWT8tOfDE2/uG
         puDu6XkQHfov9dsOEtlbu51gbKn0y8t7bNz7NE7RqFV7Vq0ZP/Ps2s6VjtcswGLz1I
         3vhfdhQan/TpA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 22:09:21 +0200
Message-Id: <501708a0f23b9d0a0dd63b38e03bf620f5018e35.1597089543.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [RFC PATCH 1/3] regulator: allocate memory outside of regulator_list
 mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating memory with regulator_list_mutex held makes lockdep unhappy
when memory pressure makes the system do fs_reclaim on eg. eMMC using
a regulator. Push the lock inside regulator_init_coupling() after the
allocation.

======================================================
WARNING: possible circular locking dependency detected
5.7.13+ #533 Not tainted
------------------------------------------------------
kswapd0/383 is trying to acquire lock:
cca78ca4 (&sbi->write_io[i][j].io_rwsem){++++}-{3:3}, at: __submit_merged_write_cond+0x104/0x154
but task is already holding lock:
c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50
which lock already depends on the new lock.
the existing dependency chain (in reverse order) is:
-> #2 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire.part.11+0x40/0x50
       fs_reclaim_acquire+0x24/0x28
       __kmalloc+0x54/0x218
       regulator_register+0x860/0x1584
       dummy_regulator_probe+0x60/0xa8
[...]
other info that might help us debug this:

Chain exists of:
  &sbi->write_io[i][j].io_rwsem --> regulator_list_mutex --> fs_reclaim

Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(regulator_list_mutex);
                               lock(fs_reclaim);
  lock(&sbi->write_io[i][j].io_rwsem);
 *** DEADLOCK ***

1 lock held by kswapd0/383:
 #0: c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50
[...]

Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2ee109950352..915a727d8fc7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4900,7 +4900,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 static int regulator_init_coupling(struct regulator_dev *rdev)
 {
 	struct regulator_dev **coupled;
-	int err, n_phandles;
+	int err = 0, n_phandles;
 
 	if (!IS_ENABLED(CONFIG_OF))
 		n_phandles = 0;
@@ -4911,6 +4911,7 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 	if (!coupled)
 		return -ENOMEM;
 
+	mutex_lock(&regulator_list_mutex);
 	rdev->coupling_desc.coupled_rdevs = coupled;
 
 	/*
@@ -4923,19 +4924,21 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 
 	/* regulator isn't coupled */
 	if (n_phandles == 0)
-		return 0;
+		goto out;
 
-	if (!of_check_coupling_data(rdev))
-		return -EPERM;
+	if (!of_check_coupling_data(rdev)) {
+		err = -EPERM;
+		goto out;
+	}
 
 	rdev->coupling_desc.coupler = regulator_find_coupler(rdev);
 	if (IS_ERR(rdev->coupling_desc.coupler)) {
 		err = PTR_ERR(rdev->coupling_desc.coupler);
 		rdev_err(rdev, "failed to get coupler: %d\n", err);
-		return err;
 	}
-
-	return 0;
+out:
+	mutex_unlock(&regulator_list_mutex);
+	return err;
 }
 
 static int generic_coupler_attach(struct regulator_coupler *coupler,
@@ -5135,9 +5138,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
 	ret = regulator_init_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	if (ret < 0)
 		goto wash;
 
-- 
2.20.1

