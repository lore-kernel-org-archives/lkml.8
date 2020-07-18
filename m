Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A15C433EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8260F2065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT4nc9Lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGRJUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A8C0619D2;
        Sat, 18 Jul 2020 02:20:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so7849412pgc.8;
        Sat, 18 Jul 2020 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlgQtSt8lmQHKVQg6Y2+SUeJ48KeaI0kz4R/u3ja4Go=;
        b=rT4nc9LhZf6o8r8DUb8OM8Dx4gE+t+VXyWau1AEUJKS04IPpleeNFd+PZ3JXWFU0lx
         1KOOr+XvZyaqKWWove1xqYC9wWcozkLeT5JD96K6Y/3ZgU+CeaJBjrhpZP18qRveaEA6
         sXpgAUKGFKYIzeauWupC5CuqUj1lWZN9yf6k8virMsuGlDKUgKLag7DyeG4PY6h1wVo3
         7ZZNX+KjJEmCH6NVCAV85RJyD1LZVTd7avAUVjTIVLlWgOLUdOMcqjgMWr8SpXq2rCWn
         IQAC/j+fioOB990PVb/B7V6+NPSECuJKiMV6eFdSNy0UamETDGmYl6KS4zGT6atCU6zC
         IjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dlgQtSt8lmQHKVQg6Y2+SUeJ48KeaI0kz4R/u3ja4Go=;
        b=eOP6L2LU+cP26phWeXxMiDt3X/S5FbQghQsq7FPc7TU+SMcahPRnTYJV+J9rZmuVQF
         f8JTjk4kuNI2wwylS+hOwvEq/BSaU237gY3JQNEHo4djxJn8JIelDo6qLo4JPMd0FcOV
         dlva/oyHIMgPAuJzkNlpd+OiuMs+hjQpY8kC/2PQhc88VLkAI/Vy1G5Qv3RoorfaXyzP
         i1cvgak3PyWa6Nteh/p52TU4+SqgqD5MH2CL4e/rzH1AdQ9nVXOiAbnWRu7qwLUvehl0
         96RBdm6qh38n2jbKAyaXFCsrN0XbAhbg0+hZi7qHFjVZUtgDvdXStjnfmJp9tVE/vkti
         F1Mg==
X-Gm-Message-State: AOAM533cEsc08m+mFVV8J+Z6XNnZPBhi/c6aV6+0yk2P+7+DWvnjRXA1
        deadhoD4OI5vak+cqzwIM70=
X-Google-Smtp-Source: ABdhPJwjkcJmrfPAlIMSO40Q1P0k8mY5xfVxo61WhQtpkjDIG98DhjqaaoFyfr5HNiQLHsL1LNwG5A==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr11823677pfo.48.1595064032954;
        Sat, 18 Jul 2020 02:20:32 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:32 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Sat, 18 Jul 2020 14:49:30 +0530
Message-Id: <1595063974-24228-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DMA controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * No change.
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

