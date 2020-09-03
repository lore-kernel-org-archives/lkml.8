Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209892137B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oi4BCKxJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="duOw6gOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgICKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgICKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:16:38 -0400
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Sep 2020 03:16:37 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C576C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 03:16:37 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4BhxLV20rdzKmhM;
        Thu,  3 Sep 2020 12:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1599127631; bh=uPRu15iu9NZFBlW05yO/MFmr1prkiYcom
        8kWWbBofgY=; b=oi4BCKxJ6h84IxGnDVzSeP32+I8N/A+HLERJoy308Gj2HDWYB
        5aH88uxpWrchOfeVbTIkWQT+0e7gtGBW+C8QBQWtjm2BD3rz+ZZQr5JfENUwLVrl
        QEFBAYFSYjQIDzh7CEYarmL/AzCpJap9y/Gv7HtJREf3TdIVH1mXq1xCzCSsrtWy
        dhtNgHkMozM/X3uoUUvDXZYsUc3TbFLSK1drY+oSXzlhd8GHyNnX3wI7dbYtgtLi
        dM5XYgZ3167Cb4vZiBT1VuWaUPZc22jPndRpV++qauCbYm7SMcsKAKHaN5LHdLGf
        0rkVOSvuzVp80TKcEJBgPx+Oz0PwJ9nswpOJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1599127632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uRunYgfPTMbFCOkTvboIdP7wPVCW0P5BS85r7326lm0=;
        b=duOw6gOraQwlvpOMHymG+F/qxE38L2Ht8unce3RYesX29vS47pvNeLllflXinI0y8V/ZGg
        nNplafFucsyWP2amwPS6S28RCE4LFncLs/KBPoOxV2yW2Jpv7WRmK3NYmEuRW1JrCJECvG
        CG3hIpDwDvpRjGxki/fOUq3vfnmSa9av4GhGKNI6kMTfnQ3HCpfVQ8T1OdVdbj5/k/724Z
        OApWFGQcrxbUYrlttflHeRt6AN+MX08+80rOzADTTU1bqTXP/BGTLyMvnIhz3TAOr3iumq
        tBoJrNht9X/WCOOx/+ooHaLxcLkrA0rIbPJ/H40OTElRIPkfcY7UacrvuGa96g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id klCFu_Vvn-y3; Thu,  3 Sep 2020 12:07:11 +0200 (CEST)
Date:   Thu, 3 Sep 2020 12:07:08 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200903100708.GA466735@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.91 / 15.00 / 15.00
X-Rspamd-Queue-Id: 32FD91268
X-Rspamd-UID: 206056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change H2+/H3 clocks to 8 steps from 528 MHz up to 1200 MHz to support a
more fine-grained powersave setup. The SoCs are made for 1296 MHz, so
these clocks are still in a safe range. Tested on a NanoPi Duo and
OrangePi Zero.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4e89701df91f..5517fcc02b7d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-648000000 {
-			opp-hz = /bits/ 64 <648000000>;
+		opp-528000000 {
+			opp-hz = /bits/ 64 <528000000>;
+			opp-microvolt = <1020000 1020000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-624000000 {
+			opp-hz = /bits/ 64 <624000000>;
 			opp-microvolt = <1040000 1040000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1060000 1060000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000 1100000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
+		opp-912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1140000 1140000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
 		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000 1200000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1240000 1240000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1300000 1300000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
 	};
 
 	cpus {
-- 
2.28.0

