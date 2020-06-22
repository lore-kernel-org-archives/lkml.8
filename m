Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D51C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D17820857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yK7BuJkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFVH76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgFVH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:59:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA6C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p82so4073451oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzqoVDbQzZNmNPwLRsiHsWdrSJDCtl0FBiErUw9Lnwc=;
        b=yK7BuJkfP85RyShC36Lhp2LQ9octtbXw0Kd/pRG6QS48O7IW3L8gb/gFfA0yf7sjwd
         qQ8qPI4o3Ygkgw4i0odCiSvqAKMqVALqnXOOt7P9vk+2MaXZvyjxYqzUagMI2tVgkFoB
         xOK9fZ1Gmv1MLfSlpkTKaWnZchLEmKA1x0bXIzzkFFfoTvOZj7feLHbSoa97l1QyQ5O9
         0XxyCjm6upqXL3kR4YePhnZ84lZpjyM9GWyqRkzcrX7YNGPBLn8oHNGSwBOBzAuEz3u0
         NnqlLLw9N8bE+vK2Rng5KMKZBlqZKftKhXFHYNXVvG/F9nHug00DqL4aiFpfgM0Orqzj
         VbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzqoVDbQzZNmNPwLRsiHsWdrSJDCtl0FBiErUw9Lnwc=;
        b=pHgYMBwi4Xr86TJ54s2HdUhc7tfza2Y+w996Y96Y6KQ9YHVvxXGt1FryJlJMo8nGSO
         TiOEOy0ILMsSbnK8GFnIstsJunKO1nCCBGoIfkcvuxP4CRusZcDPqdgByW8jCMmX/xDE
         7dPNqtl/W4WYCv4kEbKRaO+8G6FLZljwbFjnjG68EQF5gI/Tv3HBuDDBlnKl1qXWRW4p
         UJaHsJS40R1JyEY/LHv12LU+CKtAwe2w26ERAVcEuEa/UEALZEPTqWJGWR+WclT54FBE
         4lrHyWVtxZvEr+zB3mNR/6CnPXYhuS5pqW5Rym4op8/fJ2v+AYu6L3SaJSoa1bVXhEAE
         LFfg==
X-Gm-Message-State: AOAM531vPmPJpUme+Z+eiw4RRjy2s1+Mzn0Czy80jL9/X+Tt0U0xiGV/
        YWW2S27+s38WUvsZrTDHqAyKNg==
X-Google-Smtp-Source: ABdhPJw+bQnmJ6Pc0QpgUAdyiwiS7PZ0gYPWeLnYhVPGbWLGZYw7lGRZsHNPlC3mtT6i7n21MomKDQ==
X-Received: by 2002:aca:51ca:: with SMTP id f193mr11618906oib.170.1592812791283;
        Mon, 22 Jun 2020 00:59:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f7sm3135396otl.60.2020.06.22.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:59:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8250: Drop tcsr_mutex syscon
Date:   Mon, 22 Jun 2020 00:59:56 -0700
Message-Id: <20200622075956.171058-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622075956.171058-1-bjorn.andersson@linaro.org>
References: <20200622075956.171058-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't need the intermediate syscon to represent the TCSR
mutexes, update the dts to describe the TCSR mutex directly under /soc.

The change also fixes the sort order of the nodes.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changs since v1:
- Adjusted sort order of the nodes

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7050adba7995..67a1b6f3301b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -144,12 +144,6 @@ scm: scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -376,6 +370,12 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 			};
 		};
 
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x01f40000 0x0 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
@@ -486,11 +486,6 @@ rpmhpd_opp_turbo_l1: opp10 {
 			};
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
-			reg = <0x0 0x01f40000 0x0 0x40000>;
-		};
-
 		timer@17c20000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.26.2

