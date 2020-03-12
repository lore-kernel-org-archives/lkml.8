Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98557C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F47B206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4rQxAGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCLOao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:30:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54296 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgCLOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so6328199wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrNGkCGGs9iZ9NyVy5uKVQ/RwyzbDUi+g2m1wLgGoLw=;
        b=D4rQxAGFy94k2dAHm0ROepPHj2K7vit2D6GE1QsoJFz91IrG5EF84ZhJ+JfYj+4S+t
         J5Syzl8Bb8S9ZTld5nfdGPhlZOkgSHJd0pTzuqZXEjzDvxR4m4bOHTkZxEpreEuNTobS
         qGGGJb5UXvN7Z+OVXlGvfn95cIBiT45kzk+ze3D/vZ9MkDd6VmxiUGT8JOUz8be/jYp1
         V5IVRirZAVqJlvm0xzefqxJPAqb6Kf9o+uCYfemYlCIa3UZQwfB0uev1xZc12Eg7KqFx
         xdWqnJSZy2dYWrvWDo+BXoh9wDZCCJGfoZmSGp5eDmWK8HlCX8hclbhim9jmLcZF4nr4
         D+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrNGkCGGs9iZ9NyVy5uKVQ/RwyzbDUi+g2m1wLgGoLw=;
        b=kz/mCRa6BAyJS0fEF+OizOlU3PbaeGnGXKQBjIQXrTKzZ849zntK8HbpC2KPLtZXuO
         lCuVQNdCRtyV7i+ojNHnEkkdi3SGt8FUDc00ZJSfo2D5n8o1V4SJZbAnnIjNAozLo4Ey
         /wr6IsSuwcHtlItTuyq6OpUnqxRSiV4M5HvwNj5z/yiCySCH79w8ifFLVhSBEcGtvOdR
         bnsLxYB+DXw1exoFfa1USsRInoCz6gckMen/cKWa3VW3cwXs8whc9pe8IaiHVec/wG+B
         51XBsJ15mFBIcWLTKQYdzuYzX32ML9XB9jOdzJVs780oqsy32g+kxRF10uglD7V4LOPG
         fwSg==
X-Gm-Message-State: ANhLgQ2fdbGGGBz4GR1mub09bc61r6hOniBovuwzEwBXLfzxioScieq8
        Q/fa+qpv50XuGBNeECkiw0hFdg==
X-Google-Smtp-Source: ADFU+vuJj0o8QlwG2W3+jIY/Xgyi3mnCHF/7Y+tx6b0KN47miv5zepvBtXsr3VgPnZUh/MK0yaDsnw==
X-Received: by 2002:a1c:418b:: with SMTP id o133mr5313833wma.165.1584023440172;
        Thu, 12 Mar 2020 07:30:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v8sm72860454wrw.2.2020.03.12.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:30:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] arm64: dts: qcom: sdm845: add apr nodes
Date:   Thu, 12 Mar 2020 14:30:21 +0000
Message-Id: <20200312143024.11059-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
References: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 3f9fb719bfaa..5b7626f2a27b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -491,6 +492,57 @@
 			label = "lpass";
 			qcom,remote-pid = <2>;
 			mboxes = <&apss_shared 8>;
+
+			apr {
+				compatible = "qcom,apr-v2";
+				qcom,glink-channels = "apr_audio_svc";
+				qcom,apr-domain = <APR_DOMAIN_ADSP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				qcom,intents = <512 20>;
+
+				apr-service@3 {
+					reg = <APR_SVC_ADSP_CORE>;
+					compatible = "qcom,q6core";
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+				};
+
+				q6afe: apr-service@4 {
+					compatible = "qcom,q6afe";
+					reg = <APR_SVC_AFE>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6afedai: dais {
+						compatible = "qcom,q6afe-dais";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#sound-dai-cells = <1>;
+					};
+				};
+
+				q6asm: apr-service@7 {
+					compatible = "qcom,q6asm";
+					reg = <APR_SVC_ASM>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6asmdai: dais {
+						compatible = "qcom,q6asm-dais";
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#sound-dai-cells = <1>;
+						iommus = <&apps_smmu 0x1821 0x0>;
+					};
+				};
+
+				q6adm: apr-service@8 {
+					compatible = "qcom,q6adm";
+					reg = <APR_SVC_ADM>;
+					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					q6routing: routing {
+						compatible = "qcom,q6adm-routing";
+						#sound-dai-cells = <0>;
+					};
+				};
+			};
+
 			fastrpc {
 				compatible = "qcom,fastrpc";
 				qcom,glink-channels = "fastrpcglink-apps-dsp";
-- 
2.21.0

