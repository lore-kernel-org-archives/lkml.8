Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA89D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158806;
	bh=Vl8864OaSzhAnynTV0EF7M1t8xh75VBVyVfpYeE4Evk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qNvqzxQARjd5qxcB6G9966Bn+KFwpfn/vDauQqxvIw/vSiv/3/C+hZRZiMBOQhknz
	 s3irFNKu4+w0yYS1KXutgyfL8ek5lMtkz6f9D/nyWp+0xNBzp/Wr5A9YDnmbHxL8/Q
	 mCmhUe21ysJtFyYUL4p1YqSV+w19+7x8bn2iiOEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgFZIGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgFZIGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD30E2076E;
        Fri, 26 Jun 2020 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158801;
        bh=Vl8864OaSzhAnynTV0EF7M1t8xh75VBVyVfpYeE4Evk=;
        h=From:To:Cc:Subject:Date:From;
        b=ww+y/Lhe/I7wYmf3a46opoyBCDWv4aZ2DiIkIfl36CvHQ5Yg4LsSBw+ik3bk9IBc3
         Zg9iv45+oqtb2fPXTMvfrEFIJEQ016OE2t+IVd326/zLxU/X8QKF0YSj7NylNBC7eI
         Qn4ex8rIecHRIjVsyS1eN9RYDqwVnS1mZQJAQ2ew=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: hisilicon: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:37 +0200
Message-Id: <20200626080637.4191-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/hi3620.dtsi     | 2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index 9c207a690df5..f0af1bf2b4d8 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -71,7 +71,7 @@
 		interrupt-parent = <&gic>;
 		ranges = <0 0xfc000000 0x2000000>;
 
-		L2: l2-cache {
+		L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0x100000 0x100000>;
 			interrupts = <0 15 4>;
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 696e6982a688..3ee7967c202d 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -381,7 +381,7 @@
 			interrupts = <1 13 0xf01>;
 		};
 
-		l2: l2-cache {
+		l2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a10000 0x100000>;
 			interrupts = <0 15 4>;
-- 
2.17.1

