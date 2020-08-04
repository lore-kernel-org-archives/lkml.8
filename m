Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C463222C9F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHDM3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:29:16 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43328 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:29:15 -0400
X-Greylist: delayed 1109 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 08:29:15 EDT
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id BA5D53AD4D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:57:54 +0000 (UTC)
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4EC79FF805;
        Tue,  4 Aug 2020 11:56:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: at91: pm: remove unnecessary at91sam9x60_idle
Date:   Tue,  4 Aug 2020 13:56:22 +0200
Message-Id: <20200804115622.63232-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_do_idle() is already the default action for arm_pm_idle, there is no
need to open code it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/mach-at91/pm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 074bde64064e..19cc0d5b149b 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -557,11 +557,6 @@ static void at91rm9200_idle(void)
 	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
 }
 
-static void at91sam9x60_idle(void)
-{
-	cpu_do_idle();
-}
-
 static void at91sam9_idle(void)
 {
 	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
@@ -842,7 +837,7 @@ void __init sam9x60_pm_init(void)
 
 	at91_pm_modes_init();
 	at91_dt_ramc();
-	at91_pm_init(at91sam9x60_idle);
+	at91_pm_init(NULL);
 
 	soc_pm.ws_ids = sam9x60_ws_ids;
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
-- 
2.26.2

