Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F20206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="APGtOQgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHCHZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:25:35 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:18587 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHCHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596439532; x=1627975532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FR4Uar89M801Ogjt06aJ8ElOzC2Rm5sCdn/Dj7DNFlI=;
  b=APGtOQgA76iGD6Mbin+MrkAvw5MCsJtBC9a6kOQMeo67hmLyo1wVcgI8
   lamosaEBDcQQGcP7daZvcbDekhXxaoKeKikIRwjRDDknU+L8bau0VoCUm
   JOZysZQXQXx2+RIfnOWMjLe3YjqipoVtB6aMiK4NoXpk2a5Dk2qJyTk9P
   CK4yBmpWoh5cq54snf5lg2EItMzREHIxZBHmBd+g49yiVjqbv9X7voxoR
   6GAwVvao2eCSJkrewKIuEwW+nig4j5Knya8QshO2UbqVCwlIkdm5zMPho
   l0e0kJn59p0zwFO0t+5eEeXXOdS1GtX/99wfrIxsitdx9Up7t0V40yfVV
   A==;
IronPort-SDR: GosEPmJBhxETLcwKwNGZ//r3creh5djcPbrjWXnu8vtM9ty8iWuuS2OVhhAIS9wUr+aOUaBEoE
 mOq56HyuvWPq7KlwAqc7WOizyJHsu+XznJ0DSvE7GJuzPVTUsuzFf+pVZGAqXuug7+ybfdFxIh
 XUk4I1EOodMRMJfDU7hlzGMkb0dd8OOcsXlY4fWx3zm45ouiRptiCf/CVVhsvD9/GSyyZIfPVm
 MdzhF5vEvlqQj+rAOjQZE3/RueIUfYWLda6wVmn6rX5DFR3v6YusuNJKqbni7i05dK94qTvO67
 B90=
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="90194271"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2020 00:25:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 00:25:31 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 3 Aug 2020 00:25:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ARM: at91: pm: put node after its usage
Date:   Mon, 3 Aug 2020 10:25:17 +0300
Message-ID: <1596439517-12993-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node_and_match() returns a node pointer with refcount
incremented. Use of_node_put() after the node has been used.

Fixes: 13f16017d3e3f ("ARM: at91: pm: Tie the USB clock mask to the pmc")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index caf87efc7eeb..3d2ee8273b4c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -849,6 +849,7 @@ static void __init at91_pm_init(void (*pm_idle)(void))
 
 	pmc_np = of_find_matching_node_and_match(NULL, atmel_pmc_ids, &of_id);
 	soc_pm.data.pmc = of_iomap(pmc_np, 0);
+	of_node_put(pmc_np);
 	if (!soc_pm.data.pmc) {
 		pr_err("AT91: PM not supported, PMC not found\n");
 		return;
-- 
2.7.4

