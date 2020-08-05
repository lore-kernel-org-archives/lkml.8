Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0434C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9D21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VEbCDDcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHEIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:37:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:44287 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHEIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596616622; x=1628152622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+IPl0FIkZ9+NRg1yGIgTYyq7rEVyBkg+Vqdb8FB9KYw=;
  b=VEbCDDcEE2eb8vHbpY4SaCwlB8V6HOdD0bEHB+sO2GAj9eLUk6V+kbKZ
   1gNqjanL9C14Y2Flabv0VqMCfilWABK57H6h9fJIUF1kNDqtKt+fKo4Yz
   t/CQF6w039owbwJwyp0THkRdLXHXtH2agoDezymi8cBL1LiqarVw/8/zz
   twKALNxNZW/jlgGL6TSqEgMGCtZVECTgt3EszRSL3Hy6RmjLFMHf8QGiS
   dWbAJVp9bY7WlXAUH1w7+MhFsmPJ6zhxeVL9/qcFHC/N63zE8oGhUf4DG
   QX+RMkqbHZ044kTgrgM2+Veywo5ZBj+TC2KM837yvmLtq4i109lYWQXYV
   w==;
IronPort-SDR: pLWiRqhSzlo8L2+fizFrgwfWB5gQLdCQSCs+z7Cjmx82bTb+qnKxqrmJmn9UsafK8NK40b3hWx
 XpZPmA7CsT7CSROCMGUXbqheF1YwtJNw2vg3W/vpTsQjIi4nQhKwdXah/gHAPcxv1ahjcM2+x/
 qdlq8WVqqUyj9MEIUGkMmrbSh361QcxTpQRGjPOscbTZ2hWIMHKYQeF9fXvg4yhx//OspzT+Z+
 G30Y1RxBCPxdfgRxAOiKoqJURd92MITyQZ8J9pQZZ3NrJwr07RHCoHakwOZDSZgGB8t7N/GMz1
 oIQ=
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="85916982"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2020 01:37:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 5 Aug 2020 01:36:59 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 5 Aug 2020 01:36:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/3] ARM: at91: pm: add per soc validation of pm modes
Date:   Wed, 5 Aug 2020 11:36:49 +0300
Message-ID: <1596616610-15460-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all SoCs supports all the PM mode. User may end up settings,
e.g. backup mode, on a non SAMA5D2 device, but the mode to not be valid.
If backup mode is used on a devices not supporting it there will be no
way of resuming other than rebooting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 04fdcbd57100..4aaab918f982 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -785,6 +785,51 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ /* sentinel */ },
 };
 
+static void __init at91_pm_modes_validate(const int *modes, int len)
+{
+	u8 i, standby = 0, suspend = 0;
+	int mode;
+
+	for (i = 0; i < len; i++) {
+		if (standby && suspend)
+			break;
+
+		if (modes[i] == soc_pm.data.standby_mode && !standby) {
+			standby = 1;
+			continue;
+		}
+
+		if (modes[i] == soc_pm.data.suspend_mode && !suspend) {
+			suspend = 1;
+			continue;
+		}
+	}
+
+	if (!standby) {
+		if (soc_pm.data.suspend_mode == AT91_PM_STANDBY)
+			mode = AT91_PM_ULP0;
+		else
+			mode = AT91_PM_STANDBY;
+
+		pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
+			pm_modes[soc_pm.data.standby_mode].pattern,
+			pm_modes[mode].pattern);
+		soc_pm.data.standby_mode = mode;
+	}
+
+	if (!suspend) {
+		if (soc_pm.data.standby_mode == AT91_PM_ULP0)
+			mode = AT91_PM_STANDBY;
+		else
+			mode = AT91_PM_ULP0;
+
+		pr_warn("AT91: PM: %s mode not supported! Using %s.\n",
+			pm_modes[soc_pm.data.suspend_mode].pattern,
+			pm_modes[mode].pattern);
+		soc_pm.data.suspend_mode = mode;
+	}
+}
+
 static void __init at91_pm_init(void (*pm_idle)(void))
 {
 	struct device_node *pmc_np;
@@ -826,6 +871,14 @@ void __init at91rm9200_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
 		return;
 
+	/*
+	 * Force STANDBY and ULP0 mode to avoid calling
+	 * at91_pm_modes_validate() which may increase booting time.
+	 * Platform supports anyway only STANDBY and ULP0 modes.
+	 */
+	soc_pm.data.standby_mode = AT91_PM_STANDBY;
+	soc_pm.data.suspend_mode = AT91_PM_ULP0;
+
 	at91_dt_ramc();
 
 	/*
@@ -838,9 +891,14 @@ void __init at91rm9200_pm_init(void)
 
 void __init sam9x60_pm_init(void)
 {
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
+	};
+
 	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
 		return;
 
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init();
 	at91_dt_ramc();
 	at91_pm_init(at91sam9x60_idle);
@@ -854,26 +912,46 @@ void __init at91sam9_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
 		return;
 
+	/*
+	 * Force STANDBY and ULP0 mode to avoid calling
+	 * at91_pm_modes_validate() which may increase booting time.
+	 * Platform supports anyway only STANDBY and ULP0 modes.
+	 */
+	soc_pm.data.standby_mode = AT91_PM_STANDBY;
+	soc_pm.data.suspend_mode = AT91_PM_ULP0;
+
 	at91_dt_ramc();
 	at91_pm_init(at91sam9_idle);
 }
 
 void __init sama5_pm_init(void)
 {
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST,
+	};
+
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
 		return;
 
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_dt_ramc();
 	at91_pm_init(NULL);
 }
 
 void __init sama5d2_pm_init(void)
 {
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST, AT91_PM_ULP1,
+		AT91_PM_BACKUP,
+	};
+
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init();
-	sama5_pm_init();
+	at91_dt_ramc();
+	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sama5d2_ws_ids;
 	soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
-- 
2.7.4

