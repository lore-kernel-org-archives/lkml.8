Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593ACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673D20882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgATMKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:30 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61387 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgATMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:28 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 7uWZxqxXTzVOUckY5yUPHSL//1igAEY6svuwCf3BMtOSNvoc8FhBiEwOBc6S8k0zlxCt6/eSyh
 dlJmOI2NZIE/YogHGPlzWKtrk/y67u5hR/ZlEmUlxi+bUXXTCe6k8e5XkAhTkZAXYB6VfRogrS
 XkUqP5SqkRrmW0Oc9WnEbH63B7nKj037Hw0xKzqjvuDBqBrBzRtv4CrpbEATzUlUfpINcuhNlR
 r6Q25vpn566Q0kSlhvkLSgc4VS8GUxWiczyNkRUmg5AN4Ont8dWKeuBtD7hpvz88/dm/BqIvtg
 X7k=
X-IronPort-AV: E=Sophos;i="5.70,341,1574146800"; 
   d="scan'208";a="61577370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:26 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/8] ARM: at91: pm: add pmc_version member to at91_pm_data
Date:   Mon, 20 Jan 2020 14:10:04 +0200
Message-ID: <1579522208-19523-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used to differentiate b/w different PLLs settings to be
applied in the final/first steps of the suspend/resume process by doing
PLL specific configurations.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c              | 7 +++++++
 arch/arm/mach-at91/pm.h              | 1 +
 arch/arm/mach-at91/pm_data-offsets.c | 2 ++
 arch/arm/mach-at91/pm_suspend.S      | 4 ++++
 include/linux/clk/at91_pmc.h         | 3 +++
 5 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index ae7b148febd9..074bde64064e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -737,28 +737,34 @@ static void __init at91_pm_modes_init(void)
 struct pmc_info {
 	unsigned long uhp_udp_mask;
 	unsigned long mckr;
+	unsigned long version;
 };
 
 static const struct pmc_info pmc_infos[] __initconst = {
 	{
 		.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP,
 		.mckr = 0x30,
+		.version = AT91_PMC_V1,
 	},
 
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
 		.mckr = 0x30,
+		.version = AT91_PMC_V1,
 	},
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP,
 		.mckr = 0x30,
+		.version = AT91_PMC_V1,
 	},
 	{	.uhp_udp_mask = 0,
 		.mckr = 0x30,
+		.version = AT91_PMC_V1,
 	},
 	{
 		.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
 		.mckr = 0x28,
+		.version = AT91_PMC_V2,
 	},
 };
 
@@ -797,6 +803,7 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 	pmc = of_id->data;
 	soc_pm.data.uhp_udp_mask = pmc->uhp_udp_mask;
 	soc_pm.data.pmc_mckr_offset = pmc->mckr;
+	soc_pm.data.pmc_version = pmc->version;
 
 	if (pm_idle)
 		arm_pm_idle = pm_idle;
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 6f7f4236865a..218e8d1a30fb 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -34,6 +34,7 @@ struct at91_pm_data {
 	unsigned int standby_mode;
 	unsigned int suspend_mode;
 	unsigned int pmc_mckr_offset;
+	unsigned int pmc_version;
 };
 #endif
 
diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
index dfcbe626865c..82089ff258c0 100644
--- a/arch/arm/mach-at91/pm_data-offsets.c
+++ b/arch/arm/mach-at91/pm_data-offsets.c
@@ -14,6 +14,8 @@ int main(void)
 	DEFINE(PM_DATA_SFRBU,		offsetof(struct at91_pm_data, sfrbu));
 	DEFINE(PM_DATA_PMC_MCKR_OFFSET,	offsetof(struct at91_pm_data,
 						 pmc_mckr_offset));
+	DEFINE(PM_DATA_PMC_VERSION,	offsetof(struct at91_pm_data,
+						 pmc_version));
 
 	return 0;
 }
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 64460b4e0fc1..5fa0c2aa10f7 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -95,6 +95,8 @@ ENTRY(at91_pm_suspend_in_sram)
 	str	tmp1, .pm_mode
 	ldr	tmp1, [r0, #PM_DATA_PMC_MCKR_OFFSET]
 	str	tmp1, .mckr_offset
+	ldr	tmp1, [r0, #PM_DATA_PMC_VERSION]
+	str	tmp1, .pmc_version
 	/* Both ldrne below are here to preload their address in the TLB */
 	ldr	tmp1, [r0, #PM_DATA_SHDWC]
 	str	tmp1, .shdwc
@@ -542,6 +544,8 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .mckr_offset:
 	.word 0
+.pmc_version:
+	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 390437887b46..f3d691fc5f29 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -12,6 +12,9 @@
 #ifndef AT91_PMC_H
 #define AT91_PMC_H
 
+#define AT91_PMC_V1		(1)			/* PMC version 1 */
+#define AT91_PMC_V2		(2)			/* PMC version 2 [SAM9X60] */
+
 #define	AT91_PMC_SCER		0x00			/* System Clock Enable Register */
 #define	AT91_PMC_SCDR		0x04			/* System Clock Disable Register */
 
-- 
2.7.4

