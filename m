Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B417C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A3E20700
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGQiUsJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgDYOiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:38:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C82C09B04B;
        Sat, 25 Apr 2020 07:38:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so15017374wrt.1;
        Sat, 25 Apr 2020 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=biH+0Hq+KFxUENm9j1osu5bV9OSz14Gyl0yY3KBBFzU=;
        b=FGQiUsJz1DJdOU4aO8/4AqLbPHoWHwIxq5qoq/tqkZLC6rVDhcb38vvj/iAoP5hZYu
         duQ2y6wDLf+L0EbvJ0E1JkYMuR7jzSUXNEawNDfMTfk6RN1Ty4vVZ5u7XbWiFTlXu/0N
         K5RT4Xe2hJcpvYyXkOKKWw7GSR5SOW93OIMUeVJmz4/ISn+DtDday9k8UNI6ZgK4rBPg
         FjUv7npiIKVQLDMcXcdOlSJtBkZP8AMcKBlo2gWKwSu1HwfCpIn+rx45skgd+IIrEkZI
         orGTUY6R4GQqZUICb6YixeLhATsRgjkbf1q0LFLyl+BTG/X3l2hRG9h57or4AqT7xEGU
         6rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=biH+0Hq+KFxUENm9j1osu5bV9OSz14Gyl0yY3KBBFzU=;
        b=HAQ5G0AJxS1JQnyz3RXsaeYVkPKTYb9mmt+vxTQW9JK4eHt53LuJevzsEWRXUl4b4H
         lRtUqkyd9x0WqviWy2iUs1oeo7636MCD8afdusx+qVD4Wob4XsSI8I7+ojsofT2lJ3Ir
         j+ILf79DPzqiX5lj7n4ioWmDpLb+hCxOU+IuIgptLNMWQ+RezNpXKbS20f3IDgrF9Dpo
         UE8QADmEhxYMRJml75QhUB0mwm5xR6lzFQVn7EMcnzEeUrajn2++9IEk1tXIn33YvhmD
         5E3mmi33HJXwCGz0DItJN2TGsDf+eRBZ97HVnEquu9TJnCv6LTxEl//p79zAjexwhFn6
         IhhA==
X-Gm-Message-State: AGi0PuYrfko9vzZTLfggcXg+pgbF2oO91mf56fDd/BlwJn49KKm3BEtY
        iT2BEhN+YHL3WQT+3p/yHRo=
X-Google-Smtp-Source: APiQypI1PZr71kxZ6u3RtjCr6IZCMHu+P3s3ugg7H6oMtBvZjl6Y1B94I3JpK//BSH+Rw9hHJxni/w==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr16903547wrr.216.1587825524488;
        Sat, 25 Apr 2020 07:38:44 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t67sm8029319wmg.40.2020.04.25.07.38.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 07:38:43 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: swap interrupts interrupt-names rk3399 gpu node
Date:   Sat, 25 Apr 2020 16:38:37 +0200
Message-Id: <20200425143837.18706-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dts files with Rockchip rk3399 'gpu' nodes were manually verified.
In order to automate this process arm,mali-midgard.txt
has been converted to yaml. In the new setup dtbs_check with
arm,mali-midgard.yaml expects interrupts and interrupt-names values
in the same order. Fix this for rk3399.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/
arm,mali-midgard.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 74f2c3d49..a08340fc8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1883,10 +1883,10 @@
 	gpu: gpu@ff9a0000 {
 		compatible = "rockchip,rk3399-mali", "arm,mali-t860";
 		reg = <0x0 0xff9a0000 0x0 0x10000>;
-		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "gpu", "job", "mmu";
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
 		power-domains = <&power RK3399_PD_GPU>;
-- 
2.11.0

