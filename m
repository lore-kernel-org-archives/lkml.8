Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33966C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8320767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1ym/P6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437620AbgDOFri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408015AbgDOFr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:47:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD5C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:47:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so842717plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbCLHFwgNaw3ZaUwaZNGYdMdqu/fhnEMqK0b1QVqZFU=;
        b=e1ym/P6fygMoKKZH0+G14RZAeJsDa5QGU9ZOIJkpCxsqyGYu1BHQAeJESmWzwsd36V
         Ywa7cE+V4CiGIS6Nbenlmu+c6xPeBkJAC3Yo+PZhCOjb/dxrY5+uwUh1qCw9TI/62/eU
         zC1fFdDt7Tso56yJwsBGYP8kLLl7UNwO8t9tW7hkMCqY7WMKHxw8p+6JX6gGwN6TFMYL
         5WHg3K0MN9RN2fQgd4kYl71nlvEsHqnusZgl4bMIjMPKZd+sfxLDpXiV41L21J3N9999
         gFZ8WksZs+8P5bqbJB5Xkv5X8tU93C5UIgDqXILGYggU7PQsu7/IPIKuCS63W4Jq9Xap
         DNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbCLHFwgNaw3ZaUwaZNGYdMdqu/fhnEMqK0b1QVqZFU=;
        b=gOyT/L1/Dt83al2i/BOWpb7DdXOltzQJHDFfqxGoalrnQUShjeQjC0QYPhHxv/c+aH
         Xh4amMKxhPq+yJG7bfg4uuSlGUtle5SCJseqrpeEhvmA+xRMG4TaSvN9GYG9GSAsHwZS
         FO5Tm6HOSdXQ53NGtuGrffk1WRk+pmsI33Zl8osXV3oDefPapZccrvAiwECJPLZlGPZN
         HYuI7ULx7+iezPEG8nPalQW/A2Buxi5VwYPThAyAH8pqOuONN/ao515kUFzdhszpVzee
         UJTielFPbXhQXr9hm4CHbbvxYPon94ti9Rdu8dseUBCPDaph7N/FXPOSA0ay4B8HTO3u
         Ckyg==
X-Gm-Message-State: AGi0PubJ0nFFa+7+61f6ERaGFGJP3+dYqkZljO01LGjHWdNKyud/diti
        6XIq1Dxg1dZpEDW4a7WIvt+EgQ==
X-Google-Smtp-Source: APiQypLaaaRD6tAlETGmsRLyfzqLu30J+TcGAOihkWaMHSv/hOxYRgiC1NVlECpycdABMCEphvy+qw==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr3479658plo.260.1586929646167;
        Tue, 14 Apr 2020 22:47:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 17sm7773904pgg.76.2020.04.14.22.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:47:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8250: Fix PDC compatible and reg
Date:   Tue, 14 Apr 2020 22:47:03 -0700
Message-Id: <20200415054703.739507-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pdc node suffers from both too narrow compatible and insufficient
cells in the reg, fix these.

Fixes: 60378f1a171e ("arm64: dts: qcom: sm8250: Add sm8250 dts file")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 891d83b2afea..2a7eaefd221d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -314,8 +314,8 @@ intc: interrupt-controller@17a00000 {
 		};
 
 		pdc: interrupt-controller@b220000 {
-			compatible = "qcom,sm8250-pdc";
-			reg = <0x0b220000 0x30000>, <0x17c000f0 0x60>;
+			compatible = "qcom,sm8250-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>, <126 716 12>;
 			#interrupt-cells = <2>;
-- 
2.24.0

