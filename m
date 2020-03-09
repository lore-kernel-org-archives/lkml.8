Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1391C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A757B24656
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgCITnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:43:42 -0400
Received: from v6.sk ([167.172.42.174]:34678 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCITnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:42 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1561F61305;
        Mon,  9 Mar 2020 19:43:40 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/17] ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
Date:   Mon,  9 Mar 2020 20:42:47 +0100
Message-Id: <20200309194254.29009-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309194254.29009-1-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks are in fact slightly different on MMP3. In particular, PLL2 is
fixed to a different frequency, there's an extra PLL3, and the GPU
clocks are configured differently.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 59a108e49b41e..3e28f0dc9df41 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -531,7 +531,7 @@ l2: l2-cache-controller@d0020000 {
 		};
 
 		soc_clocks: clocks@d4050000 {
-			compatible = "marvell,mmp2-clock";
+			compatible = "marvell,mmp3-clock";
 			reg = <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
 			      <0xd4015000 0x1000>;
-- 
2.25.1

