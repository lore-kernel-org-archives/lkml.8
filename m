Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24D020731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeBZUJfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD1UaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD1UaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:30:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE09C03C1AB;
        Tue, 28 Apr 2020 13:30:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 188so210395wmc.2;
        Tue, 28 Apr 2020 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D7lH5jpMtckNSFWtOtcaCj8HA5zjfrZB2xijxB3Vzwk=;
        b=eeBZUJfzaTbrABWRoPU8NpncQs7kH6G4ugk7Vdy4CgWduJ2L96HkVafVsAmiprSt65
         9sdZEOKk45ypC0Ahk3ZWmgoBY4USteNEaXkSzQ7TGF/HUVgD0sBqKuJOnhyZU/FfRtr1
         XB+C9EH+gDAB91vMTiqzRTHY+KcGPqXzXENrxGIwsf0L/lgMhhAJyK/wbWulRNSbU7G7
         /m4ea26kvZYKE64YEBG6d1bstbkbmi5VAEA4mZVFAkV4e/0B2UQUKf00dyo2UyoYHQo/
         tG1GdmPO056n4QKILjfUYJ+tI5hIVPiITw+fE/U/TVZ68f/b9XdEsfJkrkYT5OEj2VnS
         TpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D7lH5jpMtckNSFWtOtcaCj8HA5zjfrZB2xijxB3Vzwk=;
        b=rqnCUrX7pMa49AFAZh4gxoVdaVgHBOTgfEI2pRR4En9jRCwY4Ntj+DpCCYO8+rIKep
         GnHm4Y/+OlRYgCxpFWbxb1k+vHqHeZ+Xv0U+cn31PdDb2x3YehyOy6ApfRKE889I5+r4
         nGKRXSrybBXPOp4iyRMF2Uz3ZIMTkcQN7YUaUUQC9Mj1S2ALl+3A6pjPkHxWXRhDYEhd
         XATLY15Elw+i+6h/t8J6r1KTXh3mgKHA4spHeU1nKiYOgYMRBE5cNYKve9qm3BA8pN7S
         QxqG2pxncy3cSrXXnqSFxhjpukX+ETwkk/n2rzBtMZx7Ztv5pyQLF3jfeqwTmmn/UxNV
         G4bg==
X-Gm-Message-State: AGi0Pub7WxJUcczV4Md9PQGFklHU7UxG3eMvWy7GnAbYERrw+c5B8Uod
        r06SDgSgU3ed7TZRu9AzgkE=
X-Google-Smtp-Source: APiQypISF7Ph82vT5pmWbVwsK1+ILae0VWTNn0sORfI+E79t5C6YH1tBk0jHRXhMF5Te8XG8lhktdg==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr6011138wmc.146.1588105812727;
        Tue, 28 Apr 2020 13:30:12 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 1sm4797801wmz.13.2020.04.28.13.30.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 13:30:12 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3399: fix pd_tcpc0 and pd_tcpc1 node position
Date:   Tue, 28 Apr 2020 22:30:03 +0200
Message-Id: <20200428203003.3318-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200428203003.3318-1-jbx6244@gmail.com>
References: <20200428203003.3318-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pd_tcpc0 and pd_tcpc1 nodes are currently a sub node of pd_vio.
In the rk3399 TRM figure of the 'Power Domain Partition' and in the
table of 'Power Domain and Voltage Domain Summary' these power domains
are positioned directly under VD_LOGIC, so fix that in 'rk3399.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 37279db53..a4dc1bf2e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1056,6 +1056,16 @@
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
 			};
+			pd_tcpc0@RK3399_PD_TCPD0 {
+				reg = <RK3399_PD_TCPD0>;
+				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
+					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
+			};
+			pd_tcpc1@RK3399_PD_TCPD1 {
+				reg = <RK3399_PD_TCPD1>;
+				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
+					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+			};
 			pd_usb3@RK3399_PD_USB3 {
 				reg = <RK3399_PD_USB3>;
 				clocks = <&cru ACLK_USB3>;
@@ -1088,16 +1098,6 @@
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
-				pd_tcpc0@RK3399_PD_TCPD0 {
-					reg = <RK3399_PD_TCPD0>;
-					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
-						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
-				};
-				pd_tcpc1@RK3399_PD_TCPD1 {
-					reg = <RK3399_PD_TCPD1>;
-					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
-						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
-				};
 				pd_vo@RK3399_PD_VO {
 					reg = <RK3399_PD_VO>;
 					#address-cells = <1>;
-- 
2.11.0

