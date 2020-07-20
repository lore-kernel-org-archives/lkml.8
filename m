Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0DC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B1722B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QGiHRvim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGTHow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:44:52 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E8C061794;
        Mon, 20 Jul 2020 00:44:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 28B571FECA;
        Mon, 20 Jul 2020 07:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1595231092; bh=7kyPXpWNdFxYWiKuEJD7T9ohyci+Zzk/Mord055cn14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGiHRvimFif+6ui1w210g82PhjIKuMgNS5QzoufU1NHVbu2NXXuET4esRqDaDy3dD
         eYnFJkQbyJXF0VXoT8gbhElokXEQ9FPF9tGb3/OQ96/lJy2ZV2Wx6GYXAecHFYyzCq
         qTrvUMiO7Y09xv9rgoTdwz9hwaS4GmIe+VWaHd1M6+kj68DQh5TcH5ZJfLFIWX5qrO
         82Hm+sk4J8cUbZYD+1R6IptCHlSHeSxpRL0QFWZjVP+udWJoTvCNjlUePtXXVWZ6Ni
         TmZ5iQns4oVaa03gBJBV34MRUGw0h7wGl51NFEa7taJR0V5mbPlhmLGfmTg5+HDCEf
         ZsKdB0FE5icdg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] MIPS: Loongson64: DTS: Fix ISA range for RS780E PCH
Date:   Mon, 20 Jul 2020 15:42:37 +0800
Message-Id: <20200720074249.596364-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200720074249.596364-1-jiaxun.yang@flygoat.com>
References: <20200720074249.596364-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ranges should express the actual physical address on bus.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/boot/dts/loongson/rs780e-pch.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
index d4c803d74036..99174b52dfb8 100644
--- a/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/rs780e-pch.dtsi
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

