Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B0420812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIqH0Ku/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgFIKSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgFIKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A9C08C5C2;
        Tue,  9 Jun 2020 03:18:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so7839912pld.13;
        Tue, 09 Jun 2020 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ZU81gDLD05tzXgioqFPIFyl/4tbhqSTfVFHFtk6IdQ=;
        b=bIqH0Ku/BOXm3Pkhhqhlzm+QHO0b3jM1Xu5fvEw/1EhvAF/q/hD1zHYZe9vMy2YaKB
         CVgD/PJTz1wRw/cIZzRFpAzvE5ZGsPENuVoz68VaTTUX7QmcQSG6hXML9qcfdMugiSWV
         UTsZHDiAJokSKCdQz9Je8j+KH72RYxy2eKUAn72MMBkQuh9+HTM306XxMrBVR0Cd5uIl
         o7N3bzjbrElqRYfphghg9/STBE7Bbn4u2qZ3e559TMYlJ4g5x2xUs0xDAxo+c4cot5Q8
         o5iNHy2IF+rJtlZXPyIrdRL6coqBVfKiCo2ob1mX1u0yQ8SGCFM11BB1D6YPV1cr4tVA
         h7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ZU81gDLD05tzXgioqFPIFyl/4tbhqSTfVFHFtk6IdQ=;
        b=ev8eViwc106I1TJMQU1MoNUB8ZVaZTPqWMTJUnNV2Vzxz9JlM+aeVY8jnwwBAe3eed
         t+j0tI5RlaZlwfpQIdcZQXEBYiiYkJ5Y056tDcK7ljxVscWS6Eg6qPJ/e1Vo0NaX2Gnb
         c7chmKGemHQbGllRQXvBx8z/ohJfBwOuSMz+OnAJfvjbpqhteHbL5s95ofqS4d/BrZ7y
         k8iDDlrIV6hYK+/C00YDdfUrqbkFt49axHrbWwWnqb9dJWVGLrYZrlyiKs2V5Q7lxz8E
         9KAVAVm//agxachuf7sTc59wfSfePrjbHMgs4YAdvpXtq0u4HTyEZebI5bFlcn2KIYmV
         Gw3A==
X-Gm-Message-State: AOAM533z0XwaR3h2rkMwj30QmJo27f8CiYjVhKEdxGrCeCv20rnnj1cz
        TGRqZZyvCEp/LJQBJfkl4eA=
X-Google-Smtp-Source: ABdhPJyoAWtyxCfMzgPci09grbLn2MVlv6EBn2AhJJ30ydBC/j2lx2PS2QWZ9Xo56JZvwp9PbWaMbw==
X-Received: by 2002:a17:90a:a405:: with SMTP id y5mr3907791pjp.15.1591697881130;
        Tue, 09 Jun 2020 03:18:01 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:00 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Tue,  9 Jun 2020 15:47:06 +0530
Message-Id: <1591697830-16311-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DMA controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v3:
	* Fixed typo in commit message.
	* Placed owl-s700-powergate.h in alphabetical order.
Changes since v2:
        * added power-domain property as sps
          is enabled now and DMA needs it.
Changes since v1:
        * No Change.
Changes since RFC:
        * No Change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index f8eb72bb4125..2c78caebf515 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/owl-s700-powergate.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
 
 / {
@@ -244,5 +245,19 @@
 				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		dma: dma-controller@e0230000 {
+			compatible = "actions,s700-dma";
+			reg = <0x0 0xe0230000 0x0 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <10>;
+			dma-requests = <44>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S700_PD_DMA>;
+		};
 	};
 };
-- 
2.7.4

