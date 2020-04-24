Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CCA20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teIk66Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgDXMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgDXMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:39:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19320C09B045;
        Fri, 24 Apr 2020 05:39:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so10512742wmh.3;
        Fri, 24 Apr 2020 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/5FhewZOjMa+L+2tqcMzJgPUq1JNbdQFqoKSCaQXbEM=;
        b=teIk66JmO3IgWg1GspSg6VCLItxXTdO1u7eb8fUFMU1hNrcoBYZXDVZoLV6cPR1RMF
         Kv31jgC7+Q1/s/yQIy2NIpwJ59DdnE6U7NT6Y4kyOGlze/NKDXRptsRrBeFKR8xRbz5g
         glrUypL0KSIC7WPE1M6ct55WNR0c5Xt31WsWb75eFEBgstEfRymNxjm0e92XKYLn72YP
         yYcmw+lf3k92IBqkoaICC04Hb40kMPASXUwBBIeZAqw+k6hGmE8dGn94vUO+9/uk/+Gn
         Z5mJsfiT2cciloi5lMLEwBDP3dlkGN305mOnuo/C6bthykIkjf5IWmEYSYCuGJXxjPut
         fmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/5FhewZOjMa+L+2tqcMzJgPUq1JNbdQFqoKSCaQXbEM=;
        b=PioyfhNtE+rku3ur8NPYPPvAi+atCJiQkanWcqwCMTWKiFk9v95CXTtFjNoYoBz3D1
         ym/aIgSZieOMU8K4oMbYfVPDi1m3NUP/RFE3gemZ9XQ2P/ifLjFQULQFKqtrzpJpOz9m
         o1qv7ao6G0z3QMp0sB7yjaYHQNwryF6JMA1w1xNReqbRsytJi34U3auYcI0CZOdTT8rw
         6FLpwQnKewwh8Z1Dh56ywx6Ey1tp0eO+SnyoewoPIejxSfr23EVYvsN5cDDfxRBOMfs/
         GHcqx9qRs3DGue4fXjsA+bwl/0YsIoUK2slbklC7spYC0b6s8pBnnlz0F4zVc2l+N3g+
         qenQ==
X-Gm-Message-State: AGi0PuZxSFWDnQCx4QRiLr0/DIxSwMSEi5ZsD3SPCAtN/uXiB2fRZwnj
        SsaLSCZwK9dzHoZfWT6a/Mc=
X-Google-Smtp-Source: APiQypKzAVcFFjXq84S98O4oSdfTNcU47XV/qwKDcg5zoIea/Yi23V/u7OuB9vSrNLmWi+JIwU/mEg==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr10328859wml.135.1587731973727;
        Fri, 24 Apr 2020 05:39:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b12sm9136457wro.18.2020.04.24.05.39.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:39:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
Date:   Fri, 24 Apr 2020 14:39:23 +0200
Message-Id: <20200424123923.8192-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-0:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-1:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-0:
'#address-cells' is a required property
arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-1:
'#address-cells' is a required property

The $nodename pattern for spi nodes is
"^spi(@.*|-[0-9a-f])*$". To prevent warnings rename
'spi-0' and 'spi-1' pinctrl sub nodenames to
'spi0' and 'spi1' in 'rk322x.dtsi'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 06172ebbf..e3b27da0a 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1020,7 +1020,7 @@
 			};
 		};
 
-		spi-0 {
+		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins = <0 RK_PB1 2 &pcfg_pull_up>;
 			};
@@ -1038,7 +1038,7 @@
 			};
 		};
 
-		spi-1 {
+		spi1 {
 			spi1_clk: spi1-clk {
 				rockchip,pins = <0 RK_PC7 2 &pcfg_pull_up>;
 			};
-- 
2.11.0

