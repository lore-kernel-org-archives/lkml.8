Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD0DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98AA20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCcGulH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgFYXeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFYXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4367C08C5C1;
        Thu, 25 Jun 2020 16:34:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so7636538ejd.0;
        Thu, 25 Jun 2020 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTpL1gD5GIJIE37fBvllr7//tnkm3Mje2qpM2UoKUL0=;
        b=MCcGulH6dRTj6Q256xnR01Ji76woRxHOyyI4xzMrBtHSCBbLKUJmU1Is6WFxZ7C5BI
         nWlpzOwxKdRvpjA1SorR6VKvUXdAtsHcCwHFEvTHQSIAWhB2ZzaKOoohlzn6zGdPLip3
         uQ7ChBA+HAH0sFIhd0+NMdQpDM/j/3TmeeEbFuyAeOHulBu54/40BDGncdc23A1zkO/+
         DRYkjKRXHxkwKCThAt75icuwfKPcBY9y8VlXd4RNcftwCuz+Pv+JgKYFp/NbzwoufNo7
         FpPasm/SvoilOxfKztX+J3gG6KX2TQkK+m+zFhkny42meaLzp22m9InjJocFn0fsvnZf
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTpL1gD5GIJIE37fBvllr7//tnkm3Mje2qpM2UoKUL0=;
        b=pWSDyjw4CdB2uQabirCkh7hk1lLcaUMS1VT/VNMcVIjc/GrS9WZ7p/ISQLkQKibwrt
         4Bd1naXo6VCmj3Rz/RnOwcuPyEEOKmwem5d3gmilQG+59yHq4HzOueGaL/5b66qQIkGp
         rI5Y1Atw8cTk7OLknHEIbFlUCrjoW5pqY8ALER881ie6PyMPns2tlCB/tcS7GgEqugTO
         SPVhwSPVDQf4K0hrlDPsD28wkJIyqFYEz8boxJh+wxeWiky09Y2aua79vrnF24MiIIbs
         UtGpTH/CQ8pcSnXOd7AMvlz/5F2pxSn2iXkB7qWOEYcPYzXDUayrrwk1TYYtmXnZOGJD
         R3bA==
X-Gm-Message-State: AOAM532cYv3sf83fXeziFg6ONm7NwvafUXZ2yrlW1+sPhbGsT1XWo4vE
        PZ1awd+lgcxLLazd4iIdN2o=
X-Google-Smtp-Source: ABdhPJzM3P9H8FjaJmzBtlI0gvL1uDPEMwhmnivaTcX/aCa074OqLYr1rnwQAPlBB9q/1B2ksQNZ2w==
X-Received: by 2002:a17:906:c24e:: with SMTP id bl14mr161159ejb.285.1593128068569;
        Thu, 25 Jun 2020 16:34:28 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:27 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 03/10] arm: dts: owl-s500: Add DMA controller
Date:   Fri, 26 Jun 2020 02:34:15 +0300
Message-Id: <53a92ab876246025cacccd1e0753b5b2910e37da.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA controller node for Actions Semi S500 SoC.

Note the Actions Semi Owl SoC's DMA driver seems to be fully compatible
with the Actions Semi S500 SoC, even though this is not explicitly
mentioned in the source code. Hence, for the moment, enable the DMA
controller node using the "actions,s900-dma" compatible string.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index ac3d04c75dd5..0f4fc5487dad 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -205,5 +205,19 @@ sps: power-controller@b01b0100 {
 			reg = <0xb01b0100 0x100>;
 			#power-domain-cells = <1>;
 		};
+
+		dma: dma-controller@b0260000 {
+			compatible = "actions,s900-dma";
+			reg = <0xb0260000 0xd00>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <12>;
+			dma-requests = <46>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S500_PD_DMA>;
+		};
 	};
 };
-- 
2.27.0

