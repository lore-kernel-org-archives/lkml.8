Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6062081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RljKU9ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgFYXeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgFYXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F22C08C5C1;
        Thu, 25 Jun 2020 16:34:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i14so7600808ejr.9;
        Thu, 25 Jun 2020 16:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxVJdBkD56m2b+9x5uGOay3SmZuWA0sM3yEAtSY5QyU=;
        b=RljKU9urE8CLGCoVsFedilwcAgV1lqJa0aRSIlcc6sEm22hZyczA/k28i2X6NKba+1
         ZwsZ1cZkHa/hoiZx0sMfyv7GXAXy0wq8iRBXsT294xjM7gptTYSJFSjxZgtBZ6VmQuca
         C4b7lI+hYkNXmgfs126ohMzIZONgS016MKwgMCWazeLoYLXzFVv1te7C4bqlPV9ckaPS
         SMnFwbZpPQnk/7sBEBZ22bHQJtkEtagW/5I64Ur7jj1v8jJDyRCQwk97eQ50Hw5m+Ypq
         GMwb92Kz4uTcEPUe8cXQAKtGsDMxmf9o3K9fnvFHltLSk10osRrgD/cEVIOyoYVc/C+I
         imbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxVJdBkD56m2b+9x5uGOay3SmZuWA0sM3yEAtSY5QyU=;
        b=r3yS3MUHg92hvUwu11DH/ZitlxcMu/Mece4W/KFVtcZ9wdBrziK8J8spdMrHpm11/3
         S6JuKPAsy+wnLZUy1U5ctTTRcLuuSbPsRaLAHk0MJwqbQGgc68fLZK5tQ2+N3bz5sXwR
         gOXmiKxzgPrwdlY5xRCp0A1q+a0ClN2Wq5mEVqkFyP05Z5Bwjy4eUbD8EaBTCwKe+qO1
         ga7U3P1Q+itpEhylgjNR32lzVCVpuCi44V2YW8YSyN/vUpw7NK/sykkqK0+HNYqiNXdl
         qEifdk9/ElVs9JheaEbikzIcL3/GaN3xJDsjaztEXuAzcibcoPAZ2TQ5vzW0Ee/Y6TWV
         ARKg==
X-Gm-Message-State: AOAM533F+/LLVTOh6VNS2mCoILTWxrysdLuf+ct3GsWEzXFpoK/4caPM
        7K8QHCxMGrb3zXTSjaiQ+iA=
X-Google-Smtp-Source: ABdhPJw6hjRSiGRjHiiQSf58ntxNJpG22CA6Gy9Xjp3vuHUCeXGKZvspStJb8KYnDNMijQwjPlQroA==
X-Received: by 2002:a17:906:e299:: with SMTP id gg25mr195642ejb.160.1593128074386;
        Thu, 25 Jun 2020 16:34:34 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:33 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 08/10] arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
Date:   Fri, 26 Jun 2020 02:34:20 +0300
Message-Id: <1a98f4f2a8cc5d0277b93dab00b2249cad22f507.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the UART fixed clock for RoseapplePi SBC and switch to using
the clock provided by CMU.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index a2087e617cb2..800edf5d2d12 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -25,12 +25,6 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
-
-	uart2_clk: uart2-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &twd_timer {
@@ -43,5 +37,4 @@ &timer {
 
 &uart2 {
 	status = "okay";
-	clocks = <&uart2_clk>;
 };
-- 
2.27.0

