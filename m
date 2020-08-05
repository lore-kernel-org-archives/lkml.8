Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C83521744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LIIi9pXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHEIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:37:23 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53869 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgHEIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596616623; x=1628152623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Es/AESjvOGxiOJk/uRAnyFyd7n9LRD5gxJGqirrLrQg=;
  b=LIIi9pXcg6slhVTLDpO2LdPyt4k0awDJuldCUyP8DQvC1XIcRcALGv9c
   rGWdrgcpw5Oq0YQ6lYWWLMTJkT2Dq43HgtzlVYqX6aSZVs2JKreJXBOoR
   12n3OSwcBGwL0Fx3Fnqy85hC5elyxvJfIXwCxhyGv5CGzxRqYgdYfyaY5
   ERd+0eiunbeTSGl3x4JiL26n2I5uXzxAE9T9N8pv12Ffoorx4QZGNyCPo
   /aQn1Fv05LmAA1XmBeDAtrPlE+G1coBFgbQiTCroc/MA5koTpZ1vFMa3t
   4JrhaBcNdknd77zvqQhzUVPXXc22E9q7i2qnIqgIdjwXqc0KXZ6KbxiqX
   A==;
IronPort-SDR: h9vNGQhJ24Sdyg/dA7FhkwEAb5rXXkh2lndvQRC4FM2RLbov7TXaQzovMxVxuch7x6Jr2qyieP
 3Yv9lmFiBCixF0KacKg1vQdjp8omJRiY+mIZKjQaTQiGztstYHjDqROF+KSZDiekyXnM86sbM2
 ayf8Oibdq0XZoN9VN0L5go3FbEkbU3VcrfPA2jtPTVFxPW0giy1qFsg/KT0mjeMzDkUzlrJMGt
 N44FRYy5a+wLlA8HMmmYY8MGW0E8j8caMkyavJzDCwxOgq/lFFdYjTU5CwwfC5BVNzDyyVweJ6
 nhM=
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="84485790"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2020 01:37:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 5 Aug 2020 01:37:02 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 5 Aug 2020 01:36:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/3] ARM: at91: pm: of_node_put() after its usage
Date:   Wed, 5 Aug 2020 11:36:50 +0300
Message-ID: <1596616610-15460-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
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
index 4aaab918f982..9f1101de80c6 100644
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

