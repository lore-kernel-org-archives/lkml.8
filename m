Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE6C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6B520786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="hztAWH6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgG1PiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgG1PiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:38:04 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251EC061794;
        Tue, 28 Jul 2020 08:38:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id B6B221FF10;
        Tue, 28 Jul 2020 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1595950683; bh=faHjsuLflAVby4/VKnhqH0UJGu36leLxHCf1afaeVuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hztAWH6nLEU5wk/KWXx310rZ2Y4/2j4qWlR45pPngzHd8vHfYJxIoBNaCW2Q8fnFA
         1q56vhhno/O1Xc8aye0EUXTNzs95Zav9pfguSsQtCeqenQGWlizZgccBbbanNaXDdr
         OV9BayUwhSPmakGZiSklosg59DBoDJ+NJQNBU6/IBpFxNjMia+t+M9QwwA+UgnE1DU
         xVFVsnGnGrJRw5KgxTEXCLT7Gy48L67NbkYnDzMoLlp52TdDlKs8bZzFHLgE9Wpx+6
         WW2dM7c3tPHPOUKpBEfr3HgKaOFk5A7iK966ieIrVkqmJ6REJJdjOfPzyDHAScrX+Q
         uvHcFZIw7aXgg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] MIPS: Loongson64: DTS: Fix ISA and PCI I/O ranges for RS780E PCH
Date:   Tue, 28 Jul 2020 23:36:58 +0800
Message-Id: <20200728153708.1296374-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200728153708.1296374-1-jiaxun.yang@flygoat.com>
References: <20200728153708.1296374-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ranges should express the actual physical address on bus.
Also enlarge the PCI I/O size to the actual hardware limit.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
index d4c803d74036..871c866e0423 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
@@ -17,7 +17,7 @@ pci@1a000000 {
 
 			reg = <0 0x1a000000 0 0x02000000>;
 
-			ranges = <0x01000000 0 0x00004000 0 0x18004000 0 0x00008000>,
+			ranges = <0x01000000 0 0x00004000 0 0x18004000 0 0x0000c000>,
 				 <0x02000000 0 0x40000000 0 0x40000000 0 0x40000000>;
 		};
 
@@ -25,7 +25,7 @@ isa {
 			compatible = "isa";
 			#address-cells = <2>;
 			#size-cells = <1>;
-			ranges = <1 0 0 0 0x4000>;
+			ranges = <1 0 0 0x18000000 0x4000>;
 
 			rtc0: rtc@70 {
 				compatible = "motorola,mc146818";
-- 
2.28.0.rc1

