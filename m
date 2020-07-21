Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA3E2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Y5Fi9v2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGUHeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUHeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:34:12 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k+NHKxDCnl5MkrAMPujZSqjRAZLgNEEutC2amRb708k=; b=Y5Fi9v2I5dwBCIUuLbGG8QXEDL
        ptnc2hmX+MGQKklEOc+bXv8+HanpXrPeQngRrbs4fJmjVObti9x8Egl+jGArkMZhIlln8YYo/y/jm
        /Xvgwb/BShpzoJXlTt1G9nIysmPEi4P1GgxTV8MHRM5fR72WeJ8fecqcz+xxWf67pR9U=;
Received: from p200300ccff1230001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:3000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jxmmu-0002tx-7R; Tue, 21 Jul 2020 09:34:08 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jxmmt-0005yX-Pm; Tue, 21 Jul 2020 09:34:07 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net, m.felsch@pengutronix.de
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] mfd: rn5t618: Make restart handler atomic safe
Date:   Tue, 21 Jul 2020 09:34:02 +0200
Message-Id: <20200721073402.22925-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The restart handler is executed during the shutdown phase which is
atomic/irq-less. The i2c framework supports atomic transfers since
commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic
transfers") to address this use case. Using i2c regmap in that
situation is not allowed:

[  165.177465] [ BUG: Invalid wait context ]
[  165.181479] 5.8.0-rc3-00003-g0e9088558027-dirty #11 Not tainted
[  165.187400] -----------------------------
[  165.191410] systemd-shutdow/1 is trying to lock:
[  165.196030] d85b4438 (rn5t618:170:(&rn5t618_regmap_config)->lock){+.+.}-{3:3}, at: regmap_update_bits_base+0x30/0x70
[  165.206573] other info that might help us debug this:
[  165.211625] context-{4:4}
[  165.214248] 2 locks held by systemd-shutdow/1:
[  165.218691]  #0: c131c47c (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x204
[  165.227405]  #1: c131efb4 (rcu_read_lock){....}-{1:2}, at: __atomic_notifier_call_chain+0x0/0x118
[  165.236288] stack backtrace:
[  165.239174] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.8.0-rc3-00003-g0e9088558027-dirty #11
[  165.248220] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[  165.254330] [<c0112110>] (unwind_backtrace) from [<c010bfa0>] (show_stack+0x10/0x14)
[  165.262084] [<c010bfa0>] (show_stack) from [<c058093c>] (dump_stack+0xe8/0x120)
[  165.269407] [<c058093c>] (dump_stack) from [<c01835a4>] (__lock_acquire+0x81c/0x2ca0)
[  165.277246] [<c01835a4>] (__lock_acquire) from [<c0186344>] (lock_acquire+0xe4/0x490)
[  165.285090] [<c0186344>] (lock_acquire) from [<c0c98638>] (__mutex_lock+0x74/0x954)
[  165.292756] [<c0c98638>] (__mutex_lock) from [<c0c98f34>] (mutex_lock_nested+0x1c/0x24)
[  165.300769] [<c0c98f34>] (mutex_lock_nested) from [<c07593ec>] (regmap_update_bits_base+0x30/0x70)
[  165.309741] [<c07593ec>] (regmap_update_bits_base) from [<c076b838>] (rn5t618_trigger_poweroff_sequence+0x34/0x64)
[  165.320097] [<c076b838>] (rn5t618_trigger_poweroff_sequence) from [<c076b874>] (rn5t618_restart+0xc/0x2c)
[  165.329669] [<c076b874>] (rn5t618_restart) from [<c01514f8>] (notifier_call_chain+0x48/0x80)
[  165.338113] [<c01514f8>] (notifier_call_chain) from [<c01516a8>] (__atomic_notifier_call_chain+0x70/0x118)
[  165.347770] [<c01516a8>] (__atomic_notifier_call_chain) from [<c0151768>] (atomic_notifier_call_chain+0x18/0x20)
[  165.357949] [<c0151768>] (atomic_notifier_call_chain) from [<c010a828>] (machine_restart+0x68/0x80)
[  165.367001] [<c010a828>] (machine_restart) from [<c0153224>] (__do_sys_reboot+0x11c/0x204)
[  165.375272] [<c0153224>] (__do_sys_reboot) from [<c0100080>] (ret_fast_syscall+0x0/0x28)
[  165.383364] Exception stack(0xd80a5fa8 to 0xd80a5ff0)
[  165.388420] 5fa0:                   00406948 00000000 fee1dead 28121969 01234567 73299b00
[  165.396602] 5fc0: 00406948 00000000 00000000 00000058 be91abc8 00000000 be91ab60 004056f8
[  165.404781] 5fe0: 00000058 be91aabc b6ed4d45 b6e56746

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- keep comments

 drivers/mfd/rn5t618.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index f69450543091..e3882557fced 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -82,7 +82,7 @@ static const struct regmap_irq_chip rc5t619_irq_chip = {
 	.mask_invert = true,
 };
 
-static struct rn5t618 *rn5t618_pm_power_off;
+static struct i2c_client *rn5t618_pm_power_off;
 static struct notifier_block rn5t618_restart_handler;
 
 static int rn5t618_irq_init(struct rn5t618 *rn5t618)
@@ -115,13 +115,38 @@ static int rn5t618_irq_init(struct rn5t618 *rn5t618)
 
 static void rn5t618_trigger_poweroff_sequence(bool repower)
 {
+	int ret;
+
 	/* disable automatic repower-on */
-	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_REPCNT,
-			   RN5T618_REPCNT_REPWRON,
-			   repower ? RN5T618_REPCNT_REPWRON : 0);
+	ret = i2c_smbus_read_byte_data(rn5t618_pm_power_off, RN5T618_REPCNT);
+	if (ret < 0)
+		goto err;
+
+	ret &= ~RN5T618_REPCNT_REPWRON;
+	if (repower)
+		ret |= RN5T618_REPCNT_REPWRON;
+
+	ret = i2c_smbus_write_byte_data(rn5t618_pm_power_off,
+					RN5T618_REPCNT, (u8)ret);
+	if (ret < 0)
+		goto err;
+
 	/* start power-off sequence */
-	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_SLPCNT,
-			   RN5T618_SLPCNT_SWPWROFF, RN5T618_SLPCNT_SWPWROFF);
+	ret = i2c_smbus_read_byte_data(rn5t618_pm_power_off, RN5T618_SLPCNT);
+	if (ret < 0)
+		goto err;
+
+	ret |= RN5T618_SLPCNT_SWPWROFF;
+
+	ret = i2c_smbus_write_byte_data(rn5t618_pm_power_off,
+					RN5T618_SLPCNT, (u8)ret);
+	if (ret < 0)
+		goto err;
+
+	return;
+
+err:
+	dev_alert(&rn5t618_pm_power_off->dev, "Failed to shutdown (err = %d)\n", ret);
 }
 
 static void rn5t618_power_off(void)
@@ -194,7 +219,7 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	rn5t618_pm_power_off = priv;
+	rn5t618_pm_power_off = i2c;
 	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
 		if (!pm_power_off)
 			pm_power_off = rn5t618_power_off;
@@ -216,9 +241,7 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c)
 
 static int rn5t618_i2c_remove(struct i2c_client *i2c)
 {
-	struct rn5t618 *priv = i2c_get_clientdata(i2c);
-
-	if (priv == rn5t618_pm_power_off) {
+	if (i2c == rn5t618_pm_power_off) {
 		rn5t618_pm_power_off = NULL;
 		pm_power_off = NULL;
 	}
-- 
2.20.1

