Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C24CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B82C207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="jMbkVBYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgGMPnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgGMPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:43:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C65C08C5DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:43:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so12622452qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SefBkkTKXeYctWnwpQcS5vaISiY7Do8N46ytSx3YzJ4=;
        b=jMbkVBYY+NXCLG9hbB+gMll4sw7qmTcsdy7tJwrMLZkoblHO09UR9DY6VZQrD5hy+9
         H+g/+KAY/XFzFbaABAMkRpPY6NU16DDTJNcGXFriLN7JIeTKi1ZCY6q50FZJ7+M+B7+x
         E97k3CHLlWYn7h5a3tW0cT2krLmPMBVSqLKyVUtlTDHpqbJNm2W7kxHybVCjP13WkVp4
         7xc651Xao1+dUsD4NAe/9qHUZoKqo0wJ3AW5AkMS3QJqsbhYm8F4WcLmNc/WQsAIFvKn
         56p/u264l25q129gOnT2fRq9NlzTsbj8EqhyogG6bV6tRIOjfdqYqzrQnPIS5sQCMHda
         Ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SefBkkTKXeYctWnwpQcS5vaISiY7Do8N46ytSx3YzJ4=;
        b=ucpAsEnsiIXkWCk2IobQpzZXrf4GneJqqEQ65x3RZBiGhoQQA5Me7E2RpG1GNsiIQZ
         KnK+UPbouHygK9xQnwSaBAsnasnTZszzDsv4SJ5ReLi3uywhpfo8QOx+A2DRmTl7pUEt
         1nsmAf+Sfb7gqep6ZhOGWiNP+Kr8dlrnMYCVFaK0Q7bds0CHtMqGJwfT9p41LvZiKXRD
         UMZu1iFb0c+a+v+bcKYQ4K7tIWra4/t76yuVuj0y3IAz3ybfl4F39l/VAzH3Xzg4glnj
         sdpPoz66fema4ICHDEVAPMYYvXzK+iDxhcGgzhczyg0NgIpaYnZNO9e65YJzv+kwPr5Q
         rCzQ==
X-Gm-Message-State: AOAM531QIb7AOyX+EqprBTSrFcqpaUzJ4k6MtVhZv/1hENs8/eiryUz+
        bytDKZJt01TszykazLnqWrU/sA==
X-Google-Smtp-Source: ABdhPJx1zGPaXKf+KbTHBqCK7f+OtWWxHy/aBw7q2ZmMFpDzVBrlTF4P7kXfB529C6L8XKJg94jnSA==
X-Received: by 2002:a05:620a:2492:: with SMTP id i18mr199672qkn.414.1594654980043;
        Mon, 13 Jul 2020 08:43:00 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id l1sm19806371qtk.18.2020.07.13.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:42:59 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8250: add interconnect nodes
Date:   Mon, 13 Jul 2020 11:41:16 -0400
Message-Id: <20200713154121.22094-8-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713154121.22094-1-jonathan@marek.ca>
References: <20200713154121.22094-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interconnect dts nodes for sm8250.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 636e2196138c..dfc1b7fa7d85 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/interconnect/qcom,sm8250.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -978,6 +979,55 @@ spi13: spi@a94000 {
 			};
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm8250-config-noc";
+			reg = <0 0x01500000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		ipa_virt: interconnect@1620000 {
+			compatible = "qcom,sm8250-ipa-virt";
+			reg = <0 0x01620000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1632000 {
+			compatible = "qcom,sm8250-system-noc";
+			reg = <0 0x01632000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e2000 {
+			compatible = "qcom,sm8250-aggre1-noc";
+			reg = <0 0x016e2000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1703000 {
+			compatible = "qcom,sm8250-aggre2-noc";
+			reg = <0 0x01703000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		compute_noc: interconnect@1733000 {
+			compatible = "qcom,sm8250-compute-noc";
+			reg = <0 0x01733000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@174a000 {
+			compatible = "qcom,sm8250-mmss-noc";
+			reg = <0 0x0174a000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -1364,6 +1414,34 @@ usb_2_ssphy: lane@88eb200 {
 			};
 		};
 
+		dc_noc: interconnect@90c0000 {
+			compatible = "qcom,sm8250-dc-noc";
+			reg = <0 0x090c0000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@9100000 {
+			compatible = "qcom,sm8250-mc-virt";
+			reg = <0 0x09100000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9121000 {
+			compatible = "qcom,sm8250-gem-noc";
+			reg = <0 0x09121000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		npu_noc: interconnect@9990000 {
+			compatible = "qcom,sm8250-npu-noc";
+			reg = <0 0x09990000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8250-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -2359,6 +2437,10 @@ rpmhpd_opp_turbo_l1: opp10 {
 					};
 				};
 			};
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
 		};
 	};
 
-- 
2.26.1

