Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8596B20734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="gP8tVaDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHKBIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:08:12 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:21721 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgHKBHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:40 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSV0NYDzLn;
        Tue, 11 Aug 2020 03:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108058; bh=PdvFhwzi6WSVdlVlsi5nMFE1Bfq/mqQSDVWlFsfuSO4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=gP8tVaDWNJ3kxeaDYjUXDvJVYq3wZwOZd0V4QQQuk4v7Y+hF2M2qIBu5OpvgS/YUN
         vD1UwJC4vaS/0rBDMKYxED/uN3/XXvc0Q5vIy7HyFgDrX+C3r4bHfP4l3E0mwtAobt
         b2L77+eRmyzmi359m3pRHi8gIMovp72OKXWqj1K15CmMEq9kDGczLNIaDmj4KDxDJT
         p+Krm0iREJ+0rhVDA6GNJmFdognOGgYCIKvKR0k+JqyEDYLgcW2/jVyraZEHQAUciS
         Ro64cIUf9msWPJ4Go+NXEXm9viWiF0UD2+FAQmIpIVjATQJR0OimSSm83NkJuOhCyi
         hRJs9Ui1Nd8vw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:37 +0200
Message-Id: <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/7] regulator: push allocation in regulator_init_coupling()
 outside of lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
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

Cc: stable@vger.kernel.org
Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0a32c3da0e26..510d234f6c46 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5010,7 +5010,10 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;
 
+	mutex_lock(&regulator_list_mutex);
 	rdev->coupling_desc.coupler = regulator_find_coupler(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	if (IS_ERR(rdev->coupling_desc.coupler)) {
 		err = PTR_ERR(rdev->coupling_desc.coupler);
 		rdev_err(rdev, "failed to get coupler: %d\n", err);
@@ -5218,9 +5221,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (ret < 0)
 		goto wash;
 
-	mutex_lock(&regulator_list_mutex);
 	ret = regulator_init_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	if (ret < 0)
 		goto wash;
 
-- 
2.20.1

