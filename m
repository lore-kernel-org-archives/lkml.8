Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B02C35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89B921556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ8OHWkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgBYHbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:31:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46850 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgBYHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:31:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so6421975pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4N8z5kQWQjqOs6F36q6PQQ1lO/cJgAg0HVku/E/BN+0=;
        b=QQ8OHWkdBG2r8gt2OWLjHMtThV1aUhIYTCVCtuECGVfxVuKmpj4LA/DtB2O4ItdMMq
         Um0Xmim2pfMfLF5z+7kUzJP7vRinRYPgwAVMSisj+ODsgBkIKGAYZ4vvpoK6UNLfSE67
         n28Ti6r9nh/qNgLzgbsqsneHF/j46oUze74nnad07bnMtLhy6PPSVKGQaFfqC4f3Uzuq
         vkEBtiylQZTQoFTl3Wo8A7WQTQptDW9SMr4mo6GN2co59Uqv89lqdNFlmF+9smgNcvFv
         f9UG/nY9RxTR8gPcWR2+h2l8MbRjj0Vui10ox8VliYkdvY11SNN+LUhVEpLGhi0ipu+N
         mWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4N8z5kQWQjqOs6F36q6PQQ1lO/cJgAg0HVku/E/BN+0=;
        b=pY7FqfHTXcz88LwpANYYttE0rtg7g4UNCSU8nV4u3hugTcOGC94COQ7nYEEPxPJfgI
         5wYIbvkx/3rv4GxG/JN8+u5BJelsMh60luMVEcjF66TXsWNuqhLkJrrlhlNoKp6zVtk+
         2yDu6GS5+RWkR0gSLbINvHj45hjS0tR0SjWklMhmDHfvnk1YPvwV76QP1HMk5Ux3UGNF
         0T76GOnACEiRvDL2nhkCk+BOt6rlX2uzl1ZzR7pEs1wHEr+fr+6L6fcKndwB3yKtTXMS
         t9J2O0s6LaCivVNZXohMQkyBhNlurSCaywbN3pWIfFi1i3//52vW+/O2O4vx/ve7rjko
         fP5A==
X-Gm-Message-State: APjAAAUypnnJHjX+ygnmO9bHVYLZQQKhUtESvZdNft9RbqAtq70Jw/df
        HIpuFVqY4eRjhnUCftKd2JQqc13Yx24=
X-Google-Smtp-Source: APXvYqwQ7koTIjUZfRToCb1oUcFA3QrQCVAQI8hxdg/I/xk5PpPdHuA0TimSBAG1X0YstEsva/lhbg==
X-Received: by 2002:a63:fe14:: with SMTP id p20mr53434255pgh.94.1582615895997;
        Mon, 24 Feb 2020 23:31:35 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id c1sm15646260pfa.51.2020.02.24.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:31:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: thermal: tsens: Make dtbs_check pass for msm8916 tsens
Date:   Tue, 25 Feb 2020 13:01:21 +0530
Message-Id: <bb22a39aaf0ab16db225976efc2ff348de2dfed9.1582615616.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582615616.git.amit.kucheria@linaro.org>
References: <cover.1582615616.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8916-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8916-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8916-tsens' is not one of
['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9f31064f2374..1748ea3f4b4f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -860,7 +860,7 @@
 		};
 
 		tsens: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8916-tsens";
+			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-- 
2.20.1

