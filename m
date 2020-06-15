Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BFAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFDC20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLHaE0ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgFOATS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgFOATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:19:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9773C05BD43;
        Sun, 14 Jun 2020 17:19:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so15511713ejc.3;
        Sun, 14 Jun 2020 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0r9iOjFzMyP9orIqp35ZxhdsurjuUHNXHC7X6YpTCNA=;
        b=OLHaE0oujambTdR5fUzLPNY+xGy8cNztQ/QRj/xWiARpec8TI8NPIj2rIS7zGYwGMF
         Oezm8ZEVwxNcqba0U+4OU7heUgeZy8Vu1XIDNutk1izjR/4CVscHdL4+2JNNV/MfTP8w
         CIpEGnlRwWOur8eWrqfPR62Ydhn7+dkHlWo969GgTgKSRIeg+BGeYymkx9g9ZxGqR+Zi
         bUnJeUtX47s4gbJ4l3YXhXyHaAzleNLnEpEkCnWKHmHkOl4oMSFx/4hSRHDa+Zy+l2ES
         TM6/1Sxa+qCD5vPRkUTo92kTXavnQL+ASKdtnRjmSViwirY6SjqpMet4Vuax9xZK1VDX
         pyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0r9iOjFzMyP9orIqp35ZxhdsurjuUHNXHC7X6YpTCNA=;
        b=MwRVq27hTu2f9gSBVU+R6v2+CJZmgE1Hb7P+3aY6HHvThUL4SiKl0htearTIC0eJA/
         CuqHRb+IKGoBUH4ncO5iXH2IYauVdCo0T4QYuDo4DokMeoMRsCZLeIGsHyjiAvFec7/U
         YpAk+L0iMnABG93YefsCLAoUY3yvDOR5kzr7ARTjhAxLZEq6gouo8xs0TLaGoJLP6b2f
         NFjwDL11ectgBnILPlrL6P8XYEWmtQOOJpPsNH6iDB2XAbH/AnaOOq/nLqjVgf6kzeYl
         BpnK3EQz1UQucxmFkcnblyn7/pcmJ2qyaeE5wo9HUDjC7L1zeKJn0cq2Q2KPaMZS0FSw
         8Ndw==
X-Gm-Message-State: AOAM532XX/AIt/gW8dgUcFiBAqwWrcNzQe6w6wm0ds+okPmyAY+cW4qi
        R9yygwz2x47tusRtr3adOiw4v+Ga
X-Google-Smtp-Source: ABdhPJwy1wndRX/MiUX8uHnTMYW88GE9JUTflT6oiLn8v0zhffnmY+Pw4D1NF/fpJGJ38rgOSoppdg==
X-Received: by 2002:a17:906:b817:: with SMTP id dv23mr22846154ejb.185.1592180353497;
        Sun, 14 Jun 2020 17:19:13 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id m30sm7450666eda.16.2020.06.14.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 17:19:13 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt specifiers
Date:   Mon, 15 Jun 2020 03:19:08 +0300
Message-Id: <41463413d6b756e9d24f8807cf95ddd98591b990.1592123160.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPI interrupts for cortex-a9 were incorrectly specified, fix them.

Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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
2.27.0

