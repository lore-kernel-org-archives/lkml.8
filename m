Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC6DC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237DC2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpBw6538"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgBYMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:08:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54448 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgBYMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1167312pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPkKnyITMi7kXeWtbSlS/aIAUZOsi+vJbY5BLkxXdmQ=;
        b=EpBw6538rnAvkt2GJlJB2sFwMEpU+JHMH9OIxpEBoxI13fUpcFrldhEepNuSMMOLfU
         XYzWiDBt2TNO1/UK5UoKBkdeClU51ocNdXx9fSmeTfhKNt10DT0Dhp8UIQIVwNHSLL0u
         HRQluTrB29LpziFReImfOnqQ+cpr7rPrcumQmfDGfPqCsUl7eObphCuWFwZ1wQx08ENS
         xr3iuAiFLcQCeKkl1JYlxCLLOennjXG281tkqBDG8HzVxuvetLgi2+iDIJMqY3DA/zYv
         Qa5SKYV1zIpv6zeIzq91CeczSXYjsm4ro79V1Y78NS66sAuxwjkBxki8SlwZHXIXwvry
         4PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPkKnyITMi7kXeWtbSlS/aIAUZOsi+vJbY5BLkxXdmQ=;
        b=CAbEyT5q+w4Rippe/6adFDwg0Sl/HSeqrUKk5ovibXL5L6ZGpdGmL3lANSC42x3gWg
         yPMuz0aVKWwBII49VEalzz3TCu8sk7ipPK3yIDz1+zTpeUfD0kgO0H/ll0iSCykPfRnJ
         1rp34AU/JTikJMr5B46zMUHSOHV3UECgwE5x6F+Di+JYUH7WsLeFOtSzi+FCRtPFZifW
         U5E002JNmK0t/5xgituo6EbNL/fYf6PvmsEKvb3DrjHAZDb6l7/wUjz/YG3/cRhA8YUT
         agoD+eZvWBnXCKA+SuXTzTk5UHR8em1r7KKlqDOwipeMjW6h5lJyuIVj5MmY0gekkBqT
         Lr4w==
X-Gm-Message-State: APjAAAXBFt2S0365pcjdp2oXZsJb6VgNBSpsRnOP8Hd1re0mZ8HJwBGE
        75YRwFcVb8DcUI4jpdu4broHrCJ0FdA=
X-Google-Smtp-Source: APXvYqzSXHtUg1rAdmq8DqLm/jer+WoTdPtlDSk8bCpUE7WDHqnB1AdPOkApe299Vzns2CmCYgsVvw==
X-Received: by 2002:a17:90a:ac18:: with SMTP id o24mr4939205pjq.33.1582632522438;
        Tue, 25 Feb 2020 04:08:42 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id w128sm15175130pgb.55.2020.02.25.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 04:08:41 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: thermal: tsens: Make dtbs_check pass for msm8916 tsens
Date:   Tue, 25 Feb 2020 17:38:28 +0530
Message-Id: <33b60b91ee43359d7507054e9b95c3078fd5cda3.1582632110.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582632110.git.amit.kucheria@linaro.org>
References: <cover.1582632110.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom-tsens binding requires a SoC-specific and a TSENS
family-specific binding to be specified in the compatible string.

Since them family-specific binding is not listed in the .dtsi file, we
see the following warnings in 'make dtbs_check'. Fix them.

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

