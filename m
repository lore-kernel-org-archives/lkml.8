Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84447C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A81E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HgIB8tvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHJUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:09:24 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:14007 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgHJUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:09:24 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQRrL08lfzMK;
        Mon, 10 Aug 2020 22:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597090162; bh=Fnc4WHjvMZAjgB4c/PoILxV1pTCz0nfrwFY78CtKeg8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=HgIB8tvMY//h1K+3QYp8JrK1suCb1EOFpMvkXA3ZbUrj0V1Lb3h71Hw3YT9vjwtY3
         c9fuob10qwrfU4pZktRqAJk5HyiPfRA6oW+FHEbcYoj6CVY0sdMQZ9KErA7agtds7Y
         EzNhRfZw33mlwrpCUWg+BoqUCbcN1TZh/LpOGUUuKmStb7SgMjmbRbvzv/SuvMC6tD
         GgrFH7AEQhWQ2ELZO7z3HVpnSVvatgyZlfVyKW21Q9YoCiwXE13pkiEYcxlLn5uT8k
         4S29I7O8BLxuiL3nd49TeZZ9moQ1tHEGBJc1aVkO7gI+eT+Xr8ZxyiP3oq+o5DBmqd
         5E+i0n8zSEIrg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 22:09:21 +0200
Message-Id: <cfbbd6fad43350395de93485ede56d61d19ffcad.1597089543.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [RFC PATCH 2/3] regulator: push enable_gpio allocation out from under
 regulator_list_mutex
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
index 915a727d8fc7..05c9657c99d9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2200,10 +2200,13 @@ EXPORT_SYMBOL_GPL(regulator_bulk_unregister_supply_alias);
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
@@ -2212,9 +2215,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
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
@@ -2222,6 +2229,10 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 update_ena_gpio_to_rdev:
 	pin->request_count++;
 	rdev->ena_pin = pin;
+
+	mutex_unlock(&regulator_list_mutex);
+	kfree(new_pin);
+
 	return 0;
 }
 
@@ -5098,9 +5109,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
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

