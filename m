Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C0C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302F120731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrkNHj9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD1UaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD1UaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:30:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE694C03C1AB;
        Tue, 28 Apr 2020 13:30:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so197728wmc.5;
        Tue, 28 Apr 2020 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cSI0lJVql2Godh5zstmOBUn+hBPwk2VKytQsLRGY6S8=;
        b=rrkNHj9EW6rx2BahfISMNiMkVomM9Xt6MisdacEJOvmKVG8yocdgwK66FIId9zxmbC
         WbOFy0Cyrm21Gk+VSqO1SixJPBoGuPBW5WTpczsg8Qy4H/vqvru8SsP0pogxssj5DZ5l
         st7uA9aGSLzT4AbJ3VYBkKldJTat7eZhRKmk9n6jOqk4IWTKmpdHCrJtSvavf2jVWBQW
         JPXvbZgZ/FYO2n1DX6SKFfEyhv8m6hPzD+FuiZ56KXRAY2TVoZWT0uPs7bBDVSoaP5RB
         SoSkRwaobMVatYrGr6LYeUxxtA2fTU+wSTnhCmeBJuBUmpcR8sfVqUA6ffwSG7nuGCQK
         CaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cSI0lJVql2Godh5zstmOBUn+hBPwk2VKytQsLRGY6S8=;
        b=KkjWRhxnQL6FRDzwnc9drWcFORlEKW4nOO22Ov/WFKf1Dkv5yJB6NA4g2LM/BbPn/D
         B5/ueDyXjxZgyd+zKNS31kon+8KYgT3ygftpIS6s4LcqG/yjGMUFzjhKOZB4ya4G9uno
         jjdBIJJny6OlE0/vHJBATN9WnwNTmLr4rhVwVnivqmnKdizramY7rWd4O+9G8J/JgTBe
         coI7m9BVUHppyNGLNyrBkiEjwGvXt0XAVu3O9kVvhRVy6cITHk/dXy9lP/nQ6PcBXFSm
         y8f3IjmvC3nll2WTDCsd75zd87mkuIIsC2xgR5Ii3PamYAh7e5he9+QxgYiflLRY1opo
         Mxuw==
X-Gm-Message-State: AGi0PuZXK+gnY0fjkxkMDlv4PbvQxftDgpK+snXIokPibBPNkN6EYY0f
        noeBuPiFIxCIoyNLX2iRagA=
X-Google-Smtp-Source: APiQypKtek0DZbQSQGByss4wVXiUG3XROnJUmkprc3ttQG8iX87SZgIl6SM9qavb5oim4rNrmlC/Sg==
X-Received: by 2002:a7b:c459:: with SMTP id l25mr6335877wmi.52.1588105811692;
        Tue, 28 Apr 2020 13:30:11 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 1sm4797801wmz.13.2020.04.28.13.30.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 13:30:10 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date:   Tue, 28 Apr 2020 22:30:02 +0200
Message-Id: <20200428203003.3318-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pd_vio@15:
'pd_tcpc0@RK3399_PD_TCPC0', 'pd_tcpc1@RK3399_PD_TCPC1'
do not match any of the regexes:
'.*-names$', '.*-supply$', '^#.*-cells$',
'^#[a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
'^__.*__$', 'pinctrl-[0-9]+'

Fix error by replacing the wrong defines by the ones
mentioned in 'rk3399-power.h'.

make -k ARCH=arm64 dtbs_check

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2e7164c82..37279db53 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1088,12 +1088,12 @@
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
-				pd_tcpc0@RK3399_PD_TCPC0 {
+				pd_tcpc0@RK3399_PD_TCPD0 {
 					reg = <RK3399_PD_TCPD0>;
 					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
 						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
 				};
-				pd_tcpc1@RK3399_PD_TCPC1 {
+				pd_tcpc1@RK3399_PD_TCPD1 {
 					reg = <RK3399_PD_TCPD1>;
 					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
 						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
-- 
2.11.0

