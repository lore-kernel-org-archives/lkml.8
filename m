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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0092CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE3F20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldnO9VgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFYXej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFYXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB7C08C5DB;
        Thu, 25 Jun 2020 16:34:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so5550698edr.9;
        Thu, 25 Jun 2020 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbtFhwo2fqQ8/gIQgNvQA6jb7MjlC2oHnaaRv7v1IUo=;
        b=ldnO9VgUnPRlM0asTZaaEc2D2+1BkErEk8Wq/t1JV2XrdY1YjANNycFLuF1kKkkcwM
         VWoqDCHHhN7Iq0DWvWzaS782ICjfhUfRNP+VfqfeAQUR0mGJbD96Q7vkKHR7yMSdd018
         90BcpxYOgNpifjj+VQvCyMrwyG2ugEsfqY60faFNOk8U8n/c42fPhMfZ2Wm11pA6b+Uu
         tONPQvQ9lyAWIghb+tBw36kzy7VKz74+0wNYMugurbBkrR+wjRo6glNpheaRmD0z5FrT
         MpPTjTWV9lT3zcl26jUvOnl8X+GJ6HAxI4P/uc20QS3ohVfe/rHAPIZkpApmjPDmevTJ
         E3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbtFhwo2fqQ8/gIQgNvQA6jb7MjlC2oHnaaRv7v1IUo=;
        b=rQ96ApwFDfhEZyZI6I8djd7om/WZ4GAE90PqEa0BXL1+snRWJJCcF+DqZWWTeKiOeq
         ofTaDbxX98SX8IGHYgFMrD9pKft+YsK+7lkS5Y6zthJfYSIMkwU2fL4wtk35CR3aZBxZ
         5m79Nt1WBCJdpRGf+Wkm4sxVNf7aZ5TuY+EU99p7eloBvW1VMmu3Ow9D+QuvvXYb564A
         xktBcgWy478sVZ9pAjkzltj1ekUIRd7Y4C2hbSTBg/43MlHl3r6HAZ37vKC6A/qSttLU
         OrYJl5vT+NzN1FIO22BQNFqFt0E0PlZm/TPC0kJW9Oouj/W4AC/6xg3qbrCacaYIBhSG
         XWMw==
X-Gm-Message-State: AOAM532QYsiu+glWekd6FAGb5M5BX341dz3QXBCTrORqY1WXqA1U1HcT
        AH0BnAogLqxjSlyBDvreh6o=
X-Google-Smtp-Source: ABdhPJx/Z+V6dongyc+gNDpn266XZKl1yKO7u1kobgHr9fEes9jS5c1xw6LxssdD8sy66tVcIBF51A==
X-Received: by 2002:aa7:c314:: with SMTP id l20mr708636edq.150.1593128067121;
        Thu, 25 Jun 2020 16:34:27 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:26 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 02/10] arm: dts: owl-s500: Set UART clock refs from CMU
Date:   Fri, 26 Jun 2020 02:34:14 +0300
Message-Id: <7b861eee0a83ccc2ad3c17319e06a175dc6e856c.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable using Clock Management Unit clocks for every UART node
of the Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5d5ad9db549b..ac3d04c75dd5 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -131,6 +131,7 @@ uart0: serial@b0120000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0120000 0x2000>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART0>;
 			status = "disabled";
 		};
 
@@ -138,6 +139,7 @@ uart1: serial@b0122000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0122000 0x2000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART1>;
 			status = "disabled";
 		};
 
@@ -145,6 +147,7 @@ uart2: serial@b0124000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0124000 0x2000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART2>;
 			status = "disabled";
 		};
 
@@ -152,6 +155,7 @@ uart3: serial@b0126000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0126000 0x2000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART3>;
 			status = "disabled";
 		};
 
@@ -159,6 +163,7 @@ uart4: serial@b0128000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0128000 0x2000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART4>;
 			status = "disabled";
 		};
 
@@ -166,6 +171,7 @@ uart5: serial@b012a000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012a000 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART5>;
 			status = "disabled";
 		};
 
@@ -173,6 +179,7 @@ uart6: serial@b012c000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012c000 0x2000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART6>;
 			status = "disabled";
 		};
 
-- 
2.27.0

