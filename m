Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70655206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmAYUqgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393541AbgDOGSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393532AbgDOGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:18:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA281C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:18:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e16so6046652pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkl10Cz89PxNK00JZOBTsHnbblTiD2dR/VYKfmoWYdU=;
        b=PmAYUqgMIm7buzRUbJ94sSiP02xMd9oFKm/AKIrNKp8AO23Vu46zAqeEbJLnVfk+2c
         SrDIGkG04rLNj3M/isN70vAqNM+O+1WfZLlJf7FUX5uWsltqR+R7z3x+lphLQSSxakiL
         kP3Ci9OxgG7JKXIbDljtZM/Bga9Ia9Ct4B5AS9yH8RiVEgspY/O5UMMhpDUZ48dMbAJe
         IhCTqDRdsTEqoyJ0emTsVS7ZmypMzS0RclcXE7skH6cJBOjOPwSCq5xxpiBe4YgD6yBy
         h12r7VdIUxA9XRjLrFWHyeZBRicQPxpEh9DUoWb/ul1Gk8dJCwwWU8MdGuOYk7KcUl5k
         HKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkl10Cz89PxNK00JZOBTsHnbblTiD2dR/VYKfmoWYdU=;
        b=i72Nm8VJ+RQuSexBITOon4++ttvxorxOlDIN7TWQ1ANEMW37bEhys9RqzpXHjm8VZc
         ZN9sc923gRgrOjzkrKNeyUcVM6J4lK67H/lOg0UnjtonAgvOaIDxmGNojyR+N0Fk/ibI
         VyUspLc4xmwtbGaKpgu84ThvEEHaOY7b+3Zwau49CLP2M1+dQWyLWfzvXileGjzxKMSH
         dpxdrtYA1ZusYJkTjgf1Nzv+91J6wSrlKiRJZE+qaD86JZL2bMwg27qSRjPvefiUvvAB
         1ZoDb+XnuCSvVK8ljInBseipBZj6xdE3LqICe5pK3n1k5U+SkZQXsrZV576JoxpMGnuA
         ETwg==
X-Gm-Message-State: AGi0PubSfP6/mQ9gBwsvPByXtd5zGkqKx6PlHOlSthAFyFhkLFuZ4WuW
        o9d0znclQsEsWgRtvpIZbN4LQA==
X-Google-Smtp-Source: APiQypICygrk8WWztHh8B+PvhlktIQrAWT9e1dq6A0clSm4oBo2OaRo4Y8sTKiUIqAJ8dA2V1eZH3Q==
X-Received: by 2002:a17:90a:46cf:: with SMTP id x15mr4628788pjg.77.1586931509211;
        Tue, 14 Apr 2020 23:18:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l64sm14313644pjb.44.2020.04.14.23.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:18:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250: Add cpufreq hw node
Date:   Tue, 14 Apr 2020 23:18:06 -0700
Message-Id: <20200415061806.740965-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpufreq HW device node to scale 4-Silver/3-Gold/1-Gold+ cores
on SM8250 SoCs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d7b2049f339c..e62e77ff48c2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -41,6 +41,7 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -56,6 +57,7 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -68,6 +70,7 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -80,6 +83,7 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -92,6 +96,7 @@ CPU4: cpu@400 {
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -104,6 +109,7 @@ CPU5: cpu@500 {
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -117,6 +123,7 @@ CPU6: cpu@600 {
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -129,6 +136,7 @@ CPU7: cpu@700 {
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -499,6 +507,19 @@ frame@17c2d000 {
 			};
 		};
 
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,cpufreq-hw";
+			reg = <0 0x18591000 0 0x1000>,
+			      <0 0x18592000 0 0x1000>,
+			      <0 0x18593000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1",
+				    "freq-domain2";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.24.0

