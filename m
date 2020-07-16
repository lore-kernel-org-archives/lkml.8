Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E2320787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0eJf1YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGPEVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgGPEVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:21:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s9so5666273ybj.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Db+rdJzVsVadbu0BHlNrIH6C9D6Gk0kU0eYJ13OSzw8=;
        b=B0eJf1YBX/Lo+BBodqJYBYhOnp2Tm0+ZoiwongPu5M8ntYb0kA8JNA06xloYqDPpuP
         Mtu1naE954uQNuTED3DZaPdkDgKExKIR1WsVGMYt5SdABRvAK553ch4l2mdRbipQ/zLp
         wcBm/xX+1jdjfOmCktWDFzZ1I2Yk0r9+5olSOJyIYnRpxHJPe77mi0JoKjRGADt3db5E
         Ra/Kf0lb/AySw01rh8brZztqxtGSf0w5WR66gJgOhVXYJndY8s4PZdCjJDeNClQJzJmS
         Yb6FWYDK2elei0o9CNtLT1pJxbuYqdwpML24KtcWqtaI7RKFMFQ4wPPuoFSVz2XkoJR+
         vKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Db+rdJzVsVadbu0BHlNrIH6C9D6Gk0kU0eYJ13OSzw8=;
        b=XOj0ylWEqwhg5ZwyG3C/NkReWfJQoVXQOQmHFMeLpY0RD92Fy6gmf2z+6Z3Qwunsy1
         18oE8CHdVA+Uhuo3D8KujTM2q7a1Ko9VxgBnC1douKyUVSMBSdvKylTbc0EbfT8zeWQE
         bsiR2mimV/+zxNlU7XObU4kcRR0zMSPl7eGGkFX6LOGhg7J8J1+taEhN1/6VTt7mQ+g8
         ahta4FuRPT3Hhvi3qEVNab9TLavnJNs5Zr/6dMxZ8GhbU5u+D15+Nv6nW7MD0vH1qfyx
         6WAT3vxWLO2513cw7BtzCUt9Q6b6i8c9P70NFawUGePn0by8JZ5TtIgjn6GIabWj9TeZ
         78/Q==
X-Gm-Message-State: AOAM5300d9UxRQIKIqWfWC7qgwX1cN6smiVQvmoqxdANuwy0tPTxaq8g
        pY/2UOhxEatiY3Z5LXZQFV/wHNXvUcQKWME=
X-Google-Smtp-Source: ABdhPJxw9TSo27Nppgi18vjTCW6ENkTRBxVnmYCPiEz1dkpPFlcFSL3SuIiZFOps9muOJLp1qlDzj2i777BYSeQ=
X-Received: by 2002:a25:ac66:: with SMTP id r38mr3804732ybd.105.1594873266503;
 Wed, 15 Jul 2020 21:21:06 -0700 (PDT)
Date:   Wed, 15 Jul 2020 21:20:53 -0700
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
Message-Id: <20200716042053.1927676-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 4/4] regulator: core: Add voltage support for sync_state() callbacks
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following example:
- regulator-X is provided by device-X.
- regulator-X is a supplier to device-A, device-B and device-C.
- device-A is off/inactive from boot.
- device-B and device-C are left on/active by the bootloader
- regulator-X is left on boot by the bootloader at 2000 mV to supply
  device-B and device-C.

Example boot sequence:
1. device-X is probed successfully.
2. device-B is probed by driver-B
   a. driver-B gets regulator-X
   b. driver-B votes on regulator-X
   c. driver-B lowers device-B performance point.
   d. driver-B lowers voltage vote to 1000 mV.
   e. regulator-X voltage is lowered to 1000 mV.
3. System crashes or device-C becomes unreliable because regulator-X
   voltage was lowered to 1000 mV when device-C still needed it at 2000 mV

The issue reported by Marek Szyprowski [1] between vdd_int and vdd_arm
is very similar to example 2, except driver-B lowers the voltage of
device-C due to a regulator coupling instead of a direct request from
driver-B.

This patch addresses the problem in the example by:
1. When a boot-on regulator is registered, a minimum voltage limit that
   matches the boot time voltage is placed on the regulator.

2. When the regulator_sync_state() callback comes, the minimum voltage
   limit is removed along with the rest of the boot limits.

So with this patch and regulator_cleanup_timeout=0, the example will
work as follows:

1. device-X is probed successfully.
   a. regulator-X is registered.
   b. Since regulator-X is on, a minimum voltage of 2000 mV is made by
      the BOOT-LIMITS consumer.
   c. Since regulator-X is on, an enable vote is made by the BOOT-LIMITS
      consumer.
2. device-B is probed by driver-B
   a. driver-B gets regulator-X
   b. driver-B votes on regulator-X
   c. driver-B lowers device-B performance point.
   d. driver-B lowers voltage vote to 1000 mV.
   e. regulator-X voltage is NOT lowered to 1000 mV.
3. device-C is probed by driver-C
   a. Does stuff similar to device-B.
4. Since all consumers of device-X have probed, device-X gets
   sync_state() callback which is a call to regulator_sync_state():
   a. BOOT-LIMITS removes enable vote for regulator-X
   b. regulator-X remains on becaue device-B and device-C have their
      enable votes in.
   c. BOOT-LIMITS consumer is freed.
   d. regulator-X voltage drops is lowered to 1000 mV.
5. The system is stable because regulator-X voltage is NOT lowered to
   1000 mV when device-C still needed it at 2000 mV.

[1] - https://lore.kernel.org/lkml/20200605063724.9030-1-m.szyprowski@samsung.com/#t
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f10ef6ec1af1..9b70295820f3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1783,6 +1783,8 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
  */
 static void regulator_add_boot_limits(struct regulator_dev *rdev)
 {
+	int boot_uV;
+
 	/* We already set up boot limits. */
 	if (rdev->boot_limits)
 		return;
@@ -1815,6 +1817,13 @@ static void regulator_add_boot_limits(struct regulator_dev *rdev)
 	}
 	rdev->open_count++;
 
+	if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
+		boot_uV = regulator_get_voltage_rdev(rdev);
+		if (boot_uV > 0)
+			regulator_set_voltage(rdev->boot_limits, boot_uV,
+								 INT_MAX);
+	}
+
 	if (regulator_enable(rdev->boot_limits)) {
 		dev_err(&rdev->dev, "Unable to set boot limits\n");
 		destroy_regulator(rdev->boot_limits);
@@ -1847,10 +1856,12 @@ static int regulator_del_boot_limits(struct regulator_dev *rdev, bool handoff)
 		return 0;
 
 	rdev_info(rdev, "removing boot limits\n");
-	if (!handoff)
+	if (!handoff) {
 		regulator_disable(rdev->boot_limits);
-	else
+		regulator_set_voltage(rdev->boot_limits, 0, INT_MAX);
+	} else {
 		rdev->use_count--;
+	}
 	destroy_regulator(rdev->boot_limits);
 	/*
 	 * Set it to an error value so that boot limits can't be set again once
-- 
2.28.0.rc0.105.gf9edc3c819-goog

