Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCF8206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q9RW7YFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgHDLUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:20:05 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:16170 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgHDLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596539572; x=1628075572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9MZm1UgGj5YfcCP0VMF+3w2gb07kbO63MeiK9RsdE18=;
  b=Q9RW7YFcoZSAr7IyST9jap+x7suQW0jl73IRHoW22f5C7+/6EH7Wyxhr
   ntwyGWcXfmd7dGtnMkdbL5YgOGrOEDk/6b9i52X72E8GuY54F8AxaErux
   SSwY6HXyDiaKL7Ds/weguhmQeuwkQ1d7vxMVhrcaBWWEt1i3dv0KB/ZS7
   8vXI3Oq1xSXuT1/h6nHozzgV0MkOhLvnBlgDJZeSCONbkdjDLeE5iSFXX
   HYKKL1OvTtLNx7HOqbHLballP2QYhMKh6kFCD/D7deyaOCROdAtEq5+Xw
   SiEjHmEF9wcBVh3deTLTwR3OX6E9uMW9fprR4etW9k+kwJuUpLF8KVE5w
   A==;
IronPort-SDR: G3RFLD4EIj2ByIIYUM/qul8oVr4dLrl8smZ9sJ2fxGNhlgkYj6Hh/5xl1NOCTjzib826OwVtEU
 FMOikc+ZuwiahmdbARcnDwbniYe0OXZzISYXBI2+BaXev6IbRDxmcHF23CRrYFBgYyftBXqi5Q
 abDWKyVQqPa94z4ebWAsQ4lKLJkSEQpEEbuQGuiQ9crLFTcOKdZCePY/QUmBBbW9I5TGT5gcxB
 lJALgRJqMVg9Pn4Y8++8Qyfv5kjpi/K1vVLU63rb+dQRBzQfxIbnLAbN1v3T5y90Yf044lvCD8
 7p0=
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="85764513"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 04:07:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 04:07:46 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 4 Aug 2020 04:07:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <wenyou.yang@atmel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Date:   Tue, 4 Aug 2020 14:07:37 +0300
Message-ID: <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
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
 arch/arm/mach-at91/pm.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 04fdcbd57100..51902c4c9bb4 100644
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
@@ -823,9 +868,14 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 
 void __init at91rm9200_pm_init(void)
 {
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0
+	};
+
 	if (!IS_ENABLED(CONFIG_SOC_AT91RM9200))
 		return;
 
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_dt_ramc();
 
 	/*
@@ -838,9 +888,14 @@ void __init at91rm9200_pm_init(void)
 
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
@@ -851,14 +906,19 @@ void __init sam9x60_pm_init(void)
 
 void __init at91sam9_pm_init(void)
 {
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0,
+	};
+
 	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
 		return;
 
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_dt_ramc();
 	at91_pm_init(at91sam9_idle);
 }
 
-void __init sama5_pm_init(void)
+static void __init sama5_pm(void)
 {
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
 		return;
@@ -867,13 +927,32 @@ void __init sama5_pm_init(void)
 	at91_pm_init(NULL);
 }
 
+void __init sama5_pm_init(void)
+{
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0, AT91_PM_ULP0_FAST,
+	};
+
+	if (!IS_ENABLED(CONFIG_SOC_SAMA5))
+		return;
+
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+	sama5_pm();
+}
+
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
+	sama5_pm();
 
 	soc_pm.ws_ids = sama5d2_ws_ids;
 	soc_pm.config_shdwc_ws = at91_sama5d2_config_shdwc_ws;
-- 
2.7.4

