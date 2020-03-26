Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D3C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5584D20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNM9owfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCZKjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:39:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33651 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgCZKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:39:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id f20so5874971ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltvILhWw+Z8JxlENYP0mAF8OSEMClYvL/9bIL1S5Kpk=;
        b=gNM9owfXJa+dSlXbbxty1r7WYn0Vre4U4J5MDJuANbo/DqAdHjITFd0aXd250+kgZa
         BBoWO6/eWsDTVUFSP/CbYcRysEhMRxz+SAH34DXnYRURMBuwtmqslM1+6iePBLm+NnpI
         VMk/rKREhpC+5kGl6T6i0CFgULvqeuk3T8xWx6XudqaneIM7NqJ3QFRVtsom69i88Lrf
         c+x/xZgFY6N2mSJbbFKPevX3hfN9H6HOHOS/yKCBYszcI2M9HrfHyBlZo8vNeKDzWlIP
         WurHB5jS3OKWqbRob4xVgl0PI2SCVzFfF5V+fZGxrn7geaztCIDWxd+6rHQk+THCqPv/
         6hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltvILhWw+Z8JxlENYP0mAF8OSEMClYvL/9bIL1S5Kpk=;
        b=Cr/wCf3UXH3uLA2xiTdvcMum0v0CtlEZMP0WtGbQDAY3HG5SfaPufB/A79Lbd0Y8fK
         U5K3meTrN/Zdjegxqrnwmd9nWlJm7CNAJWl4y3QFZ96LfiAU+3fZb1iPCpqF60jH8uT0
         j9OpxAw6vCz5MOqffk/CXhR79crOMD4y2rsnC1LJ68G4UuCr/lHxTeAMvvnIr+f1sfo4
         MakRSFHmsZzGyM6nm4SLjUhVXeo+tGsvQBBqkS4eImDu7Xk4R0mkFIpOMBJEAh09Cybq
         WmLscQWSDFk8k6/eQ0FHrbwBB9FQaUi2bgRFxLDHyLOZpHSbVaIakH0By5Ve6xbRyXdm
         n3Nw==
X-Gm-Message-State: ANhLgQ33A0v9pblDPd+r80O0AO62QNqOpqZVLkJS61A9mkKmcqRgdkJD
        TchMrNCBRiE6k7wpcA6b3IH7KHDPlMA=
X-Google-Smtp-Source: ADFU+vsLtdkgRectxhYOVDyCqiOqGpq4Xqt+Wl7DV1FV/CF1VdSJqutewgZkRdbbmLZjLm73f0qT9A==
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr5092848ljj.79.1585219179500;
        Thu, 26 Mar 2020 03:39:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id h3sm1304008lfk.30.2020.03.26.03.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:39:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: msm8916: Conform to the nodename pattern PSCI subnodes
Date:   Thu, 26 Mar 2020 11:39:32 +0100
Message-Id: <20200326103932.5809-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326103932.5809-1-ulf.hansson@linaro.org>
References: <20200326103932.5809-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subnodes for PSCI should start with "power-domain-", so let's adopt to
this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e7ff8701eed3..2fdc6aa61b83 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -191,31 +191,31 @@
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: cpu-pd0 {
+		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD1: cpu-pd1 {
+		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD2: cpu-pd2 {
+		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CPU_PD3: cpu-pd3 {
+		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&CPU_SLEEP_0>;
 		};
 
-		CLUSTER_PD: cluster-pd {
+		CLUSTER_PD: power-domain-cluster {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
 		};
-- 
2.20.1

