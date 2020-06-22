Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D6CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCE120739
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOojp91P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFVMli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgFVMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:41:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCD0C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so5404847pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVIUeXQMCzWAcTP6WaAZI7/yPZyluiCjZUpguitY3Jw=;
        b=ZOojp91Pido+aL3yZ7zrmjtfRZ8Rj0b57hyjeHOQp6DeGl5HWGlCbn6CRDcFZ6x2TQ
         OGjgXQAYk9vb5Z6Pns/GOLInjxC0/4F9IVjUZpuj15j7HlFCH5reerk6T/pN0KRwU9Bb
         u0IQ2vcQpjjAP0z87Lus7w/xu7CknL7VSWrti80qeROkDVNoS2gM/1P7lJEnzGJzzQM9
         LBbyXm4aUXqYMGPsMUFksBvsmj1K3Rcs4ic+kxJypBQ3w16Q6rm7xi0l9Ul4OM168xVh
         PjeK/Shfu4r4EkO4Yt9B0Jb4KqSMnjckWITV77AdmF5ymk/DolM516H29m3oan9c6RWv
         +jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVIUeXQMCzWAcTP6WaAZI7/yPZyluiCjZUpguitY3Jw=;
        b=Cehvj1wh2m+o813/4h5KB/IW85Th13vNkvl5b8vhbIUoyKyNtQsSOPBBG8Nj6SFTao
         FJ7G9Gl7o939cBW3Jt/cv0PTg7fwDMgGJkKARNfq6UrHvTohZHLIUqmhLoLSLoPhOa5c
         mBMc6AfEIE99jM9xCzGGiz4nUo+CD74LIEt3EjrxqJ4F2lqUXvP0V11QaAgxMEt13Bxl
         1/MwtWlxuc/ZoYOT3MJnEAWGQJdXm3NOZLcAi4RXYNnA7Vl4ptX06rUyCxg+4Cp0rPWk
         5QRb2lr4+L+lHnqAO7t0xo9DGOsVgvQ1KpyYeonYHwkpwTOFvpx770n7TCW2lSBeE0yg
         ggCw==
X-Gm-Message-State: AOAM532YRamVZzSDABohQuEdu6E+1xS51rKPPXjXoRK3BMjlLW+uUiYw
        ur98ztPHtlsXoEf1NA0Lee0Y2g==
X-Google-Smtp-Source: ABdhPJyKEJiZz5eiUolIb6ebzSomKmKeC2lbQasGljaZr3D0E5NLOjUhinZlJgNU+qTJaWl0NaR8gQ==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr20562410pfk.126.1592829691927;
        Mon, 22 Jun 2020 05:41:31 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id i62sm14590581pfg.90.2020.06.22.05.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:41:31 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v5 3/4] arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
Date:   Mon, 22 Jun 2020 18:11:09 +0530
Message-Id: <20200622124110.20971-4-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622124110.20971-1-sumit.semwal@linaro.org>
References: <20200622124110.20971-1-sumit.semwal@linaro.org>
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
  [sumits: Updated for better compatible strings and names]

---
v5: sumits: removed interrupt-names, since there is only one
            interrupt per node
v4: sumits: removed labibb label which is not needed
v3: sumits: updated interrupt-names as per review comments
v2: sumits: updated for better compatible string and names
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 23f9146a161e..d016b12967eb 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -25,5 +25,17 @@ pmi8998_lsid1: pmic@3 {
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
 	};
 };
-- 
2.27.0

