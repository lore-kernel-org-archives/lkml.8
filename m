Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6E7218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXun7LEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEHUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEHUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:42:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150DBC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:42:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so1238258plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36T3AexsEvJt3RwH4PGXPZ6diqwO7avxWsaGFQ+MiUU=;
        b=IXun7LEV/KCObJbWlEipA5gWF/0RqU589NAogylgVxXAo9uExeDt7/ZMkcO+JF1EhY
         Ax7UAeqHqJRKkZFSfRJb1fSbhmNQiB+CDeUK4s2UKs0/3PmMBP418rUEQayAGhavtfdH
         UYV8mI7q5MgdZ/Esq5XSgiMZmil3I0hJ1RCIuS59eQlpxDlC6ln0I6Xoo29Fo1C8HYxT
         NwxS9v7R2jII7pSapPQxYkCr+alc++pNSgwwYLDlGqEFcixdfY6Fc2druoUHBvauYnZp
         ANEIscVwq7ygyLO6RDQ0JKXlauzrw2Buq1bqzKjr937GQ2AU3s/6KxawREQh3Ty0Rr6Q
         6u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36T3AexsEvJt3RwH4PGXPZ6diqwO7avxWsaGFQ+MiUU=;
        b=aYhffs9dkqQdo1pdxiXuUUrVTyr0qURnocSUsI81C1sqtSPtSkoYXUmbpSq3gv3NZn
         UHK+pEeKj64txkvow8wL3sIpeCKJufZBXzCbzzpLLlwGmcOUCAGL0ZKT94ApRHjtzerO
         m5emtz+dxmwdetMBaduSpbvVKJz5LizuiqGXXcHK0kVd6dea4ovO6JDVzOY3lWaUdAvT
         l+btHVo7/tIGJFGnrDRE0Y7n/5qOmCmd1YQEyfgZ0CdqXQlFul/SGk5U5MwmqHUX0alo
         1aeXi/kerOOVmKuDGcfwvilkHgS4BvnYR1TU7aihe261DH8RIMyA4Yw+20p0X83v98No
         aCBw==
X-Gm-Message-State: AGi0PuZC3OXmY3d1E+8xPxX6arFdjcalKCquVd+z8xI64FjQ2akVKjWx
        hltEBCTuRYiin73Vf9IlZFIr8Q==
X-Google-Smtp-Source: APiQypLPsB4dZpyQcDbE16I1dJ9tOnKU2QRZoZ5LoQLGaOOTYPDgmkFUqpg2GkLCM+yuGukSbDFJQw==
X-Received: by 2002:a17:902:598e:: with SMTP id p14mr4314155pli.30.1588970567490;
        Fri, 08 May 2020 13:42:47 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id h191sm2670720pfe.44.2020.05.08.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 13:42:46 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [v2 2/4] arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
Date:   Sat,  9 May 2020 02:11:58 +0530
Message-Id: <20200508204200.13481-3-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508204200.13481-1-sumit.semwal@linaro.org>
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

This patch adds devicetree nodes for LAB and IBB regulators.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

--
v2: [sumits]: updated for better compatible string and names
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 23f9146a161e..72dc5f0db3ca 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -25,5 +25,21 @@ pmi8998_lsid1: pmic@3 {
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		labibb: labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "ibb-sc-err";
+			};
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "lab-sc-err";
+			};
+		};
 	};
 };
-- 
2.26.2

