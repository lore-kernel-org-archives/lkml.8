Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E70C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2CE20748
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ZTCDisn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHKBHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:49 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53765 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgHKBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSV2fmhzMK;
        Tue, 11 Aug 2020 03:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108058; bh=dCmMvGwnirw/nbsi+GiAhZpwcSKaH0onmesD6dcdOvY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ZTCDisn2aiLlavqfKoX5RJX5V/CLlB1t4iosWAMbc+jOT4Xc7aiYSfiZFMhvT+sND
         SCKEFzo0WoCqY/zXYtFc85uyiNoLwX8qRq3LOe/bkEv23y0Ht0GQdltir4koJLXP5X
         0VWnFpfEjL/UrQlwLKUxMOrS5UPMv5MswdJvVDFNotsDB33SHCcAeHTYkMRumqRCSm
         pqmsFT+rvtvv8xjGUoVIbRlcBnmKHC3BpQuyFhfKvjAu9iinLnaYzYLoeeBIhQWQ2G
         6YKrcLsD4sCdNm2Qs+H1c3fwRlWcOYXOREOrXp65vu/wroYfi9gRhaEbYFO5Fe/8QQ
         7EPWA+H+5BKyg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:38 +0200
Message-Id: <a45e2e0715171228f140a0a01cc5924c5379bfa3.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/7] regulator: push allocation in
 regulator_ena_gpio_request() out of lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move another allocation out of regulator_list_mutex-protected region, as
reclaim might want to take the same lock.

WARNING: possible circular locking dependency detected
5.7.13+ #534 Not tainted
------------------------------------------------------
kswapd0/383 is trying to acquire lock:
c0e5d920 (regulator_list_mutex){+.+.}-{3:3}, at: regulator_lock_dependent+0x54/0x2c0

but task is already holding lock:
c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire.part.11+0x40/0x50
       fs_reclaim_acquire+0x24/0x28
       kmem_cache_alloc_trace+0x40/0x1e8
       regulator_register+0x384/0x1630
       devm_regulator_register+0x50/0x84
       reg_fixed_voltage_probe+0x248/0x35c
[...]
other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(regulator_list_mutex);
                               lock(fs_reclaim);
  lock(regulator_list_mutex);

 *** DEADLOCK ***
[...]
2 locks held by kswapd0/383:
 #0: c0e38518 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x50
 #1: cb70e5e0 (hctx->srcu){....}-{0:0}, at: hctx_lock+0x60/0xb8
[...]

Fixes: 541d052d7215 ("regulator: core: Only support passing enable GPIO descriptors")
[this commit only changes context]
Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
[this is when the regulator_list_mutex was introduced in reclaim locking path]

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 510d234f6c46..3dd4d4914075 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2203,10 +2203,13 @@ EXPORT_SYMBOL_GPL(regulator_bulk_unregister_supply_alias);
 static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 				const struct regulator_config *config)
 {
-	struct regulator_enable_gpio *pin;
+	struct regulator_enable_gpio *pin, *new_pin;
 	struct gpio_desc *gpiod;
 
 	gpiod = config->ena_gpiod;
+	new_pin = kzalloc(sizeof(*new_pin), GFP_KERNEL);
+
+	mutex_lock(&regulator_list_mutex);
 
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (pin->gpiod == gpiod) {
@@ -2215,9 +2218,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		}
 	}
 
-	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
-	if (pin == NULL)
+	if (new_pin == NULL) {
+		mutex_unlock(&regulator_list_mutex);
 		return -ENOMEM;
+	}
+
+	pin = new_pin;
+	new_pin = NULL;
 
 	pin->gpiod = gpiod;
 	list_add(&pin->list, &regulator_ena_gpio_list);
@@ -2225,6 +2232,10 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 update_ena_gpio_to_rdev:
 	pin->request_count++;
 	rdev->ena_pin = pin;
+
+	mutex_unlock(&regulator_list_mutex);
+	kfree(new_pin);
+
 	return 0;
 }
 
@@ -5179,9 +5190,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	}
 
 	if (config->ena_gpiod) {
-		mutex_lock(&regulator_list_mutex);
 		ret = regulator_ena_gpio_request(rdev, config);
-		mutex_unlock(&regulator_list_mutex);
 		if (ret != 0) {
 			rdev_err(rdev, "Failed to request enable GPIO: %d\n",
 				 ret);
-- 
2.20.1

