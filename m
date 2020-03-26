Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBEC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435D020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtuxyn2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCZKjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:39:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45970 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgCZKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:39:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so4337936lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1nvTnoCdWzSt0oHKZjHPnc/m+ldEqWok6iLJxV16c8=;
        b=jtuxyn2RGigj4WE+BY0Jr4pcVfFLWirXBwB3qOghvRq9f9cI9+t38QsTJ5tHrDcOlK
         5Y+f63gauIUOiX2V0tuO/ZHHqt9nNiGNx0ZvuDYmrH+RCMljyZZ9XSAbBW3dPzhTaihs
         8tYMK0EYSrJcEBdqzXyRXRv/T78p7xmX3pXe3muGOxLAw9VNu0V6BUu65SoWRtISazio
         WrwbZmq7elu9SWDPOgkt5Nfk5l4bMHVBe/tOp9STCBLPwJfJz1kBZwnfvkOZhVGr8SWf
         SBNwq2Bm2gejiWybDekvNug8Skdhuoqa3viZ4mW0T0pjU8eZyfZZUb5NxK4ez2pGakDU
         9GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1nvTnoCdWzSt0oHKZjHPnc/m+ldEqWok6iLJxV16c8=;
        b=WKS4uLl1vdi5oWROhJlF+2j+UPUTasgwX6KdsYkzeKpZHrPZh2Sfoi5vs0qbenVd6m
         m/zMSSIapQUNRylzhDc/0Qld06UUhlsed9tfijlHiSOkt63AVeBRCZ+GUkrJ291SvbNA
         Lc49tAzdg8mclEkEO6bnTOW1afCuR02S9ZTRj2mJw0Xey7ApL3vLB4OcPAGsKZhfFU60
         9cYUj9u2qWfVhjxagWn+nG6EWDvhxPeW8fBj62D53BEqgJ1xlxef29eWG1PC5BMuvasy
         JzOR7Vh5Y2vSZCJHa2n4cBBuj0j8wYnE7x56zPlrmj2hqxlOTxvwvxjM3fjVo3oTv1bw
         hL8A==
X-Gm-Message-State: AGi0PuYO+3tukt265ViDjd/IRjtIi4SGCHItD2C1LaXohkB5mnvAEAkX
        metgs/IJ6WStFvrtsUDCfrRHZ7mlw+Q=
X-Google-Smtp-Source: APiQypKPRE2ON6aRzwMK+AUU7LYcWJMEfSh1WYF2TLyJKwBLHVzPo6b48DjcDDQ+Pxb87nT7P4Rg0Q==
X-Received: by 2002:ac2:5edc:: with SMTP id d28mr750380lfq.59.1585219178402;
        Thu, 26 Mar 2020 03:39:38 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id h3sm1304008lfk.30.2020.03.26.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:39:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: msm8916: Conform to the domain-idle-state binding
Date:   Thu, 26 Mar 2020 11:39:31 +0100
Message-Id: <20200326103932.5809-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326103932.5809-1-ulf.hansson@linaro.org>
References: <20200326103932.5809-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the domain-idle-state DT binding got converted to the json-schema, a few
minor changes were introduced. For example, the states needs to be
specified within a separate node, named domain-idle-states. Let's conform
to the updated binding.

This also silence the below errors for msm8916 from of 'make dtbs_check':
idle-states: cluster-retention:compatible:0: 'arm,idle-state' was expected
idle-states: cluster-gdhs:compatible:0: 'arm,idle-state' was expected

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index a88a15f2352b..e7ff8701eed3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -165,6 +165,9 @@
 				min-residency-us = <2000>;
 				local-timer-stop;
 			};
+		};
+
+		domain-idle-states {
 
 			CLUSTER_RET: cluster-retention {
 				compatible = "domain-idle-state";
-- 
2.20.1

