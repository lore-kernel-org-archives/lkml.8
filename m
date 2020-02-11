Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CDC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720852082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krxFBIuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgBKAwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:52:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41759 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgBKAwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:52:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so2666103pgf.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8+iy7pVN4WE3jutHz5qWVqRqdhsfXVc/4DMY70bYKQ=;
        b=krxFBIuL7oKSbZcqFj1jVnlp3lrMP84d2IGovq34cVVYAhbvsdfo2xtjVTuHRHzcHW
         Ul+m25Diga040b2BWpWkTKMuejH24MHC0kNpWlKeJwBi3MP+dMUEqF3MEl8/CBnBC3zW
         j2n+5n9RHv5Sb0Q0QX0XqOn9Y0AajR7nTvj4/oy0ApKii9/kxslgo6ryTuzKttiA3Zly
         Ymv+snierXvMsL+GsvI2XTVOIn0mV9aJoFfJJBlB1XaUMnagRi/2QabexTPgGnBmVCga
         lgoOfBo9Mz7BvDwu9YUlpEfdRWYuyYnkOqex7849I5GyGINClDwrfnkM8So0t/cIYNro
         Limg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8+iy7pVN4WE3jutHz5qWVqRqdhsfXVc/4DMY70bYKQ=;
        b=Nog6W1PqhtKpEkSrnRTz1Do0Ik1dumi3bkI3n7CRmqUmbiRP9VcfyE9tkVG9W/6VBp
         NzOUyL5PjBgYFv2fTBVBhxR/0T0TYaAjeWpPp2VitLju7FUSBHYjkN+t7gzC5T4RdiiZ
         afJsOJtGY2R5SWud9TSsOertD3Ptkv0Q8WuTGV/fdJUn0Lrf7EPa5R6D83hbBiUOQQSe
         ebTZ81mBmLkwGd96BDYTHnO5wH9AgnaiZVREpldZLnU2At9d1u3/tPe9v7sPHcOKaxX6
         PNjDvwMQiQZKDJU1lekA2RoH7kbpggVmDyj9SG7uhdEvN+79qj6sHKO34nRQU6sG7WqX
         qp6g==
X-Gm-Message-State: APjAAAV3Y6OknbfOddx8aU0KMNpWFACHuNsiNXNtS5K0HstbRLRYFLMM
        IDoijyzPzf+VaosdOqcPNcODvw==
X-Google-Smtp-Source: APXvYqwzEs01mneR4MjC/kY7F3XwSiwiWb6bslc15hzLTqaoTFJRvKVCPb8EQ9uh+djJtwD3r9r7kQ==
X-Received: by 2002:a63:2f46:: with SMTP id v67mr4526056pgv.220.1581382335751;
        Mon, 10 Feb 2020 16:52:15 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q21sm1538480pff.105.2020.02.10.16.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 16:52:15 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v3 5/8] arm64: dts: qcom: sdm845: Add IMEM and PIL info region
Date:   Mon, 10 Feb 2020 16:50:56 -0800
Message-Id: <20200211005059.1377279-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
References: <20200211005059.1377279-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on SDM845 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Replace offset with reg

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d42302b8889b..3443d989976c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3018,6 +3018,19 @@ spmi_bus: spmi@c440000 {
 			cell-index = <0>;
 		};
 
+		imem@146bf000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x146bf000 0 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pil-reloc@94c {
+				compatible ="qcom,pil-reloc-info";
+				reg = <0x94c 200>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
-- 
2.24.0

