Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B544C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED3C208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YkxfGdWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgHDLQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:16:01 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42932 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgHDLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596539582; x=1628075582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cABTCBkYCZRK9yGKmo95ajZBgIwDxSEMc4wqVo78+9g=;
  b=YkxfGdWG2O2uyCPWAofpMDN7MmVVBPJkWcXB+XNMXbCxXTxtTsbfPW0w
   yOjg9Pz3hV/eZRoChltTJWClAmDn5Tz81FJ66QlnB7fmHYE1AmfXXzfOo
   vbQGttm2r+gRWKitePNmsIUnoE5qJvyMgyWCMP+5XIqYJ2CjlOjpk5ii/
   R5dVFJ0PlREbbsyK9EVDeQa9i2aHZn2iEGFsGuT3naQuV58oDGp9xwDJw
   aoxnv1kV+mPsVJWqWDsVBiI+55lOLJf4K0QPpXINHbiGXYgdzxqHXIuu4
   BHm7t/VOL4m5yu3GzOAe+tN3izBI08sKObwAFiGsDFYBK3YFlXU1F9iUf
   A==;
IronPort-SDR: U5FIzf9eO09nF7yxc2ErkzzGE+AyObXpRESQoG2nHrvOCj3mowVlPyl3AJgPqJsgXNgpVHObcy
 dwUQ33U/IkHESI15DQYWNd8k3EEwpXDNutIm54JQEANsiC7mqasE1TvgvAbUm+dGzBX42TwnMr
 5LxG6C3Ou7qqIAXyJle+qFT0fR1Q8uKVGo/QgSOoBQIaXbO88dnSrHdrncvVd1dbRaPpQr7R9P
 jn2q6ytoEfLkcNbAZk7hDAJLgoF3Bmwtgc0dmCJwaVArv8oxHzXG5DWcVv2szkBEv5MFiBAMZ/
 U5w=
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="86626294"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 04:07:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 04:07:49 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 4 Aug 2020 04:07:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <wenyou.yang@atmel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/3] ARM: at91: pm: of_node_put() after its usage
Date:   Tue, 4 Aug 2020 14:07:38 +0300
Message-ID: <1596539258-20719-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put node after it has been used.

Fixes: 13f16017d3e3f ("ARM: at91: pm: Tie the USB clock mask to the pmc")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 51902c4c9bb4..e332c6b1548c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -841,6 +841,7 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 
 	pmc_np = of_find_matching_node_and_match(NULL, atmel_pmc_ids, &of_id);
 	soc_pm.data.pmc = of_iomap(pmc_np, 0);
+	of_node_put(pmc_np);
 	if (!soc_pm.data.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
-- 
2.7.4

