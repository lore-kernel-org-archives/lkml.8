Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7216C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B121721841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSM4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:56:07 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:60145 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:56:05 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jQ9UO-0001Lu-NN; Sun, 19 Apr 2020 14:56:02 +0200
Received: from [130.255.73.16] (helo=v01.28459.vpscontrol.net)
        by www31.flk1.host-h.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1jQ9UK-0008SM-3f; Sun, 19 Apr 2020 14:55:56 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] ARM: dts: rockchip: add rga node for rk322x
Date:   Sun, 19 Apr 2020 12:51:33 +0000
Message-Id: <20200419125134.29923-2-justin.swartz@risingedge.co.za>
In-Reply-To: <558b35c3-7f75-8d0d-048b-c55c06fa8a53@gmail.com>
References: <558b35c3-7f75-8d0d-048b-c55c06fa8a53@gmail.com>
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0c6d8zDasFm/nDPEg7mmhmypSDasLI4SayDByyq9LIhVh5Ui7mI7WeR2
 i/gtiekj80TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7uDjV/sFUXQr+CDrNQuIHgQg
 mAX8Bxy/iUu0ThNZg0jxJtcVJProrT987X1VDPOqN+OoDzRTdku7DidYUZdNf38Sp7Of4wP429AA
 f49baR+f3He7jw4SoVhmTJ/3eP9ORQWVx8ds1M4qmk3/bYr2p8zbg4Paoa3pNVQ0zl7t/+UfQLYB
 qEPnp1U88kqVD8AM2G81dFO0E3gi+MOI1foZYzDggRXhpvoPtF3cVkniFXU3qJSqpdJudO6+rkiw
 E5i8Wl78Q18OeOfsy4h7jF1Uv9lnibl3vcBqVmvQB4A18aeGb1pbVH+fmeedmNxjZxYfAVXirbLu
 Jjy3NtnGWLbnBGfrUBEXB2fYGLNieGQuoHtJvp0r29Rf3ZjFwL+MhHEWw/0qBlNDp8uABz3dkWV+
 ttWGem52QLIiDo2hv5/Q58JTycYLFeAN4+MGwnsp7SkU6CLbyF0Zq4b1/7rjUzETJrWks4pbbQJq
 6gWopI3ep45X19ZysgQ+31LcAX8eoFXAhohfegXGH2GIVQVglJFbK771YV8YbC29CtmpcTqTfSIf
 CWq9oj7OiT8GwpAriB+3/81I3rvR8KJ2fK9jiDYgijyqqY0rATpzHKGfmtNsYTr4SmDZ/bGW8xZC
 RRs6ZD24UhFcZZEpLhnBCwImTQNvxaLyCc35VA7RvW/HGiGqxL09Cymermt8NAa/gGopT3kKfO4C
 gvcKmV0o9jYzsFpuc43pp/LzIs3ornuRuAAdgrkq+6l7ZLNYJcf7Z6PCydDzoYZgInuDxgFOs7AZ
 TwbwMaed1BaNkB2/QnXFItfl/CWoqsuchW3gOtGiIBZ3paVR38NrFoXSENXH6UXfnav35JPA4YfM
 6tBkXsqvKY6zoLLTPpuFqUUQz+mM8JAD4ECWNo09vb0YLIRnK477e9Xake5PIWKjIXX7qe2zOXoS
 foxI4G0yjIWrwiqa2StnnXPZTM4T14CV/aqGw5avoywT/WbjO41FyBEqIaDudcVplPE6wCr6GXU1
 lCw88ijyus1sGnWknJqS8gGhNQxpB5P3qu7c1xMljx2PG/R+pKBSKy8hXOgvE1zSS7XUhkYEQYeb
 3jR5NeVaJQBh0uawl0Cg8j+knAzOA9mmoJvkuhKHiekUuskYaI6ERCKp8gXWqnT9kLHhStr5fiGK
 7KncpWELuTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node to define the presence of RGA, a 2D raster graphic
acceleration unit.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/arm/boot/dts/rk322x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 4e90efdc9..ce88f5bd6 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -621,6 +621,16 @@
 		status = "disabled";
 	};
 
+	rga: rga@20060000 {
+		compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
+		reg = <0x20060000 0x1000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru SRST_RGA_H>;
+		reset-names = "core", "axi", "ahb";
+	};
+
 	iep_mmu: iommu@20070800 {
 		compatible = "rockchip,iommu";
 		reg = <0x20070800 0x100>;
-- 
2.11.0

