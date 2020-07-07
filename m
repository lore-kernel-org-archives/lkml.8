Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7A520672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhYp699P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgGGVON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGGVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:14:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE77C061755;
        Tue,  7 Jul 2020 14:14:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so7980238pls.4;
        Tue, 07 Jul 2020 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2+tqe21qhAOiH0l/I+PzAW0UhiNgCEO1jIRYTAAZAI=;
        b=BhYp699PAyfhJbI2NcQi+BBRu6ESaeQ0Dk+5sWhNM25YpVSoJJQ4qD5C5VSzE/NRbV
         FvAM/U1SNVekNztRzi5+ai14QfY8+6K/WFuWfqqlVop/9bGe9iRPYT1gYKezUaRQZfZL
         52x0glrflQQvxZvRIFiCxvSY6zBclDiU4oqaDEnjWvxkAZ+2MIsMYuS0VsAQYl34QqFc
         s/ZlfOcL1VfOLLpV3O0wqL4gyYOfQ5Xj5OsyPx6xycEr33t7joVdwIAeTr40xjSj5R2D
         SlahK12/h92idEDTK2MBJijkthqww1o+bseK7SwRNQ81OmeFF89HwaRdJzQgr0IfYv/I
         8/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2+tqe21qhAOiH0l/I+PzAW0UhiNgCEO1jIRYTAAZAI=;
        b=ZEzUO+ADYp8NQhdZVe/GIwSU8zrxtpdj1IAYDHGFTLlthCivLU9lKQtVulrP74eteH
         2ECn6/H/mBai9f9CnmT6nY2kuseP7QMDqeoNwQqXWDBvH8UQ6d+HyD1epI2C5Rias3ju
         JWhpImNBmGoAzpLgpAKEna0TpIemJM4h2xk0WULjJn1cszmSvtr5uo1T6tIMaq58ncSh
         umVtIuanSoXuROoUINZvwxJhKJGMXSRdGWspc9OLIepI4tDDIJqwM2qMyJ3o78DowAvF
         36bmXd/ku3l/B0ZS1BPy/vSSrsV4j1B9puZdeKoIgjHMb6EodBAUd9NCaruwGuCfEo4D
         39Wg==
X-Gm-Message-State: AOAM530t6eQExok6BEVjXG8RBmNHC1hxG8JX0FryY1Md9munm5NzAkQE
        CUY8qNpRd5RZIFrgNXyLwcQ=
X-Google-Smtp-Source: ABdhPJypp1jon8+zZ1AEDaZFdpozZIkuo8WzTmd1YTGM66MFSdc27aYoyPiMIdH9fnkH2Bz7avOUZw==
X-Received: by 2002:a17:90b:1283:: with SMTP id fw3mr6105611pjb.112.1594156452179;
        Tue, 07 Jul 2020 14:14:12 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id 27sm3263682pjg.19.2020.07.07.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:14:11 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] ARM: dts: vfxxx: Add node for CAAM
Date:   Tue,  7 Jul 2020 14:13:59 -0700
Message-Id: <20200707211359.29906-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add node for CAAM device in NXP Vybrid SoC.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Chris Healy <cphealy@gmail.com>

v2:
- fixup commit to show that this patch is from Andrey Smirnov.

---
 arch/arm/boot/dts/vfxxx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2d547e7b21ad..0fe03aa0367f 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -729,6 +729,28 @@
 				dma-names = "rx","tx";
 				status = "disabled";
 			};
+
+			crypto: crypto@400f0000 {
+				compatible = "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400f0000 0x9000>;
+				ranges = <0 0x400f0000 0x9000>;
+				clocks = <&clks VF610_CLK_CAAM>;
+				clock-names = "ipg";
+
+				sec_jr0: jr0@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr1@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
 		};
 	};
 };
-- 
2.21.3

