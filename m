Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838CC2D10B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3722493E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9W0BIi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgEMF5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729258AbgEMF5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:57:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B23C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so10631779pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcfzpsSQi5daWC7gaUxlctrXi7sUjiovhdgBTIYbCvY=;
        b=Z9W0BIi72UXdojVMzZWful+VXcfM/7mRwMC0X+0E84c4Aui52O/gq58ODytZaCoEpq
         lppEFJ0h7Z4GNiBHYRnIDRoFncvLX1S0EvgYazLkYCpxr+ky75g6xiaTCvd6DGe11jfb
         DZcKTjwZqlCr2Wh76Z1aIPZgIo5NPAOcGmu6gJt+5IRqROpUtzVxoWJ5lyQrNjHPPuQM
         DPQeGZnpgqSD6DfOCAehh7lBYBYMxO7K1sQTl3tKQlctMrLMkUJ5teaymmG3yFmH0W0K
         Xu5a3pwpaoK9CEqrxWI2iyKub2dQymK36F/omOttrnx8Z9CkXAzznvIQB1HJWazOIiWT
         N2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcfzpsSQi5daWC7gaUxlctrXi7sUjiovhdgBTIYbCvY=;
        b=J5q5iDX7MUKiWNX7fxjLs4Mq3FK7FHgPz06RafrgKSUEcefQvhpl4htik94LCAWkIF
         QGCarNGN6dWuDvK8cjaqGBMyVbV5YXckJcBbhvBflRBGe65QVALdOQNDun1L1nn5bz2P
         Z+HMZIHcPOEa2mj/dJN24BAwLrk3zFLUZj9tkw2XI8N5sBsku5djRndDZXG2V+ucQ0aq
         OisPk+x1VV+QsKCOuBmwkkYnkCJua0oRlSahuZRvm5ygpl0Iw/18NDaspIb4OAg3kAjy
         A+oWxNFTIYN652Qorp6ba/y6TjoVA4apFOQkU0x3mjuAjIEyCH+oGfMcFrTHCB/VbZvE
         u37g==
X-Gm-Message-State: AGi0PuaN3f3I5EdqypAYOJUEJvKxXioWllEPJaczahHSBJJG5Y7NrNtT
        2K3IlaYuPs4vLFkqCLk5skl2eg==
X-Google-Smtp-Source: APiQypJHtKHCPhkSK5TO6wa+IvZfdz4WkKAze9q1aB256pHsfLzhf5c01TqMeRxOhNxoI7RQk+FfTg==
X-Received: by 2002:a17:902:bd81:: with SMTP id q1mr23737306pls.46.1589349455552;
        Tue, 12 May 2020 22:57:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w192sm14131161pff.126.2020.05.12.22.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:57:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v5 5/5] arm64: dts: qcom: sdm845: Add IMEM and PIL info region
Date:   Tue, 12 May 2020 22:56:41 -0700
Message-Id: <20200513055641.1413100-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
References: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on SDM845 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteprocs.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- imem is no longer compatible with "syscon"

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7cce6f1b7c9e..1abbbe7a43a0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3716,6 +3716,21 @@ spmi_bus: spmi@c440000 {
 			cell-index = <0>;
 		};
 
+		imem@146bf000 {
+			compatible = "simple-mfd";
+			reg = <0 0x146bf000 0 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0 0x146bf000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
-- 
2.26.2

