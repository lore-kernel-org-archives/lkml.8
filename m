Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB84C433FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4C52065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM5hEzlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGRJUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19EC0619D2;
        Sat, 18 Jul 2020 02:20:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so7630637pjb.5;
        Sat, 18 Jul 2020 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NviHgVjQuLhyVmkMejGiB4uUEB9WSVa/9K89QO1Z6/I=;
        b=ZM5hEzloNLoubWfThl0I5dMBiNGbpj9DKGspRnyV8UUzXDQe3d/EJMi7efD+x2u+xF
         ADbidj8qK8bHRy78+YNMxoyuT3c7ldE6qCtN/IXtaqt7w6gHIVvTx+EiUCpyjZ4MWY+R
         ki0wVBCMiam4VSAajGm6kjDk0jxU1O78nd31qw9RGyEV5REhc+fvLABEdEkDL/+3HzVC
         1uueZZkggn6ZGBmfKSc35mT3bEpDElG+zp2YqnWJXEKtIuMpNx3kkefIqSBACSZisf6R
         bZTXjzvpXZ1ZhcMejWI3RmcW6WsW1Cgy4f0ucedeM5/qu3h8GEmORS5ty4ZpPDxIoI+F
         +Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NviHgVjQuLhyVmkMejGiB4uUEB9WSVa/9K89QO1Z6/I=;
        b=dOCsmFt7zE/zDGFTeETAwKZoj55aKGU+GxEpVo9WMdWFvkTVbAYm1sIR74NuRji0h3
         7ueiuNkQisLodFoO1P/xxd0No/r3MtXy25uvFz3RV9X6BFoxelTSbVRw4mjYZ+lpUkQ8
         JIwP7VxBukRByFAGDhOwkRdrftuEhg25D+dT/wiWNgx4kYrBkx6iu5TxmMC60Ql06osV
         V8vT8hxME4AbGHjdgSbaJe8TComMVz5R0xn1yLJrWbv4EdELfH3lq4UtUWOVNiD9OeNF
         MjbBEoYMMEa9Pp7dCf3soJsbtkjlOXLQJ7eHQ56Ic+Dhrquvs3lxxcre/RvhUGw+Yuwt
         C7Ug==
X-Gm-Message-State: AOAM530ZgCjvTAVzwYkh80VISqmFtGylWP205C25Pb7qvXRsXeWxr8yu
        FjN0SIBk0nyAK3ejgHJhL7g=
X-Google-Smtp-Source: ABdhPJxRdlZFbb/t7neWxYozgmgI5MV4OV5IXTLjyB4u0x7K7aV8E8sKRr+rwIYz+sWqHJb11bPzSw==
X-Received: by 2002:a17:902:c402:: with SMTP id k2mr10664183plk.184.1595064050702;
        Sat, 18 Jul 2020 02:20:50 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:50 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
Date:   Sat, 18 Jul 2020 14:49:34 +0530
Message-Id: <1595063974-24228-11-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds uSD support for Cubieboard7 board based on Actions Semi
S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
added yet, fixed regulator has been used as a regulator node.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v5:
	* Removed the Fixed regulators as these are 
	  not needed.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * No change.
Changes since RFC:
        * No change.
---
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 63e375cd9eb4..eaaf8f876203 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -13,6 +13,7 @@
 
 	aliases {
 		serial3 = &uart3;
+		mmc0 = &mmc0;
 	};
 
 	chosen {
@@ -81,6 +82,14 @@
 			bias-pull-up;
 		};
 	};
+
+	mmc0_default: mmc0_default {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+	};
 };
 
 &timer {
@@ -90,3 +99,16 @@
 &uart3 {
 	status = "okay";
 };
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	bus-width = <4>;
+};
+
diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 9ed88aafc2da..ba498cf9217d 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s700-powergate.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
-- 
2.7.4

