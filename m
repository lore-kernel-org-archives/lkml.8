Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8282FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DCF20842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pApeM7GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgG3QNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:13:00 -0400
Received: from crapouillou.net ([89.234.176.41]:47256 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3QM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596125562; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DzFbhkz9Uh4b/FUC/mf+N2EFMvj/8dRbxdCyrTVYgI=;
        b=pApeM7GQ0nVTiB+MgOuAX5KuTg2ek+fjXpAclwwW6HTlMFhEE5cUugCgTLhzhclhQ1FFi8
        lYSq2gvrPXQLelMT3oT6tggH+gBvI3uFqWE6LHmDwiEnjJfrpLZNpMyiheaNw9KXhsgFpc
        MeF2WRV3gZ3YLbfNMDQT5R+T3q5izhI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] MIPS: DTS: ingenic/qi,lb60: Add model and memory node
Date:   Thu, 30 Jul 2020 18:12:32 +0200
Message-Id: <20200730161233.61876-3-paul@crapouillou.net>
In-Reply-To: <20200730161233.61876-1-paul@crapouillou.net>
References: <20200730161233.61876-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a memory node, which was missing until now, and use the retail name
"Ben Nanonote" as the model, as it is way more known under that name
than under the name "LB60".

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index eda37fb516f0..bf298268f1a1 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -16,6 +16,12 @@
 
 / {
 	compatible = "qi,lb60", "ingenic,jz4740";
+	model = "Ben Nanonote";
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x2000000>;
+	};
 
 	chosen {
 		stdout-path = &uart0;
-- 
2.27.0

