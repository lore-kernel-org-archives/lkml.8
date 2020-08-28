Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF110C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05D1207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhpFyMUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgH1Nxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgH1Nx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:53:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9DC06121B;
        Fri, 28 Aug 2020 06:53:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s19so1607954eju.6;
        Fri, 28 Aug 2020 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BsvSCf6Oxm1voeABbB7CdX3byuKaze3qDjclCol3Tzg=;
        b=LhpFyMUW7+cLkrtU0cHc2qKqzwGS5Vgxu9SSPs6tR2VL2u3DFyN8RxzSJ5mnckrMJb
         agFrM686c9Zt9evIsysql7LLGsk5fnbGItq3FOiXF6RNoaAp5aEU7qqXVvtDT8HyDEPT
         GpY3Q4F6+qNIZzWGcdPbSzU0HElREJpe5eZYJRDDQdOOEDXfW0+E0mMSsiiTi2tUu+NB
         wjvT4A2oo07zZehSgXrIztuxIs/+g7AXmsrgI5ToSc7KxXszZDfebekLvYbm6DPRCZVS
         Q8kxV8Q91W89rofRgei6lSpvK8DfRBTI659xiMGDujj9gNbsI04lFT0Vb9emJFm17n3M
         R5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsvSCf6Oxm1voeABbB7CdX3byuKaze3qDjclCol3Tzg=;
        b=kkqwrlBhn/os62zvDhTkVwEQeFMiq4Pr2pNF+vOxJlPIjIxlknl8hrfwulM0rrzm7X
         RUevfdrmR1e7IcMYhjXNt9VuyC0txNSNHcFa0INjH4t4WMpFj255Zv1RM1gcVsE0Qq+5
         /MqSBMe4uKNH0rnh5ZKXp/C9/rJg9Tj5Ij+nvzNn+s4Yo1BpEQW9bykK9BaI/85gPI5i
         frizN6dr3rHjSgtIDs8Dgh6rS2B4/0MdK3Tt5FzCuFwVb6uWTQKx6mBDkmiP85SQz46G
         PRxo/b8EeHx6f9BAzNza9zCOBJE1Aq9Bweo/Ntl6opl/uVKvB1fcKH0gEzrQAWga08W4
         nWgQ==
X-Gm-Message-State: AOAM531APBUnItyOBfCc7PN7R3tZOyhgvvReLoAd2gW+/3jiqeBDCfe9
        iyKRkhQsPy38IdmRiPYntzU=
X-Google-Smtp-Source: ABdhPJyf3pdgw6sOwc+9jGXm1GWx/NL7CadUHYcQkvlLjJZTuhsHW/CAXGSXTgPjXZASqmUpl3QPxg==
X-Received: by 2002:a17:906:b086:: with SMTP id x6mr2045012ejy.204.1598622804098;
        Fri, 28 Aug 2020 06:53:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f20sm981624ejq.60.2020.08.28.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:53:23 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH v2 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt specifiers
Date:   Fri, 28 Aug 2020 16:53:17 +0300
Message-Id: <43702e492090417a490ba4cd81990a05aeea9f48.1598621459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPI interrupts for cortex-a9 were incorrectly specified, fix them.

Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5ceb6cc4451d..1dbe4e8b38ac 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -84,21 +84,21 @@ scu: scu@b0020000 {
 		global_timer: timer@b0020200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0xb0020200 0x100>;
-			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 			status = "disabled";
 		};
 
 		twd_timer: timer@b0020600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xb0020600 0x20>;
-			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 			status = "disabled";
 		};
 
 		twd_wdt: wdt@b0020620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0xb0020620 0xe0>;
-			interrupts = <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 			status = "disabled";
 		};
 
-- 
2.28.0

