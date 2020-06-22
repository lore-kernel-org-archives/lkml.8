Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73669C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512D02075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyC9ZJIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgFVW1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbgFVW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0ECC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:39 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so17116196oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl9uIyo+81Kkn9LPrLZQmLI21MHmbpgl+yYUpQGnN0M=;
        b=YyC9ZJIf7yEFPHVB9ErBo2jQ2wjzoF5MCWGI1Ho73ZhuZ4iyw5QXxwELQGSZsPDNyx
         C/wrPYw9NhxpkOjteWE0ZT8hTmoLfTU+a0+uVTB6Dgci0w/D+A71nBjr0yFtrFzMOIrf
         xnz+1T4TACfydiayKTHan1ynoE8Nn+1VFZeRPYKzpwrofX8GiCV2UOSxvy94hMCCCsR1
         fSv2P3l9cQJbyEto9/PXdORiXmjDTCbeU64oZCjPJHaXg0Vz56RkaqOykS4/k5c/U/kQ
         z5tgzTahnS37p2LtZmvIiZ6c+bTOoWKs+7B2U5+2RI9OVTxlO2doiTPVM9RFAFesoXNY
         B7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl9uIyo+81Kkn9LPrLZQmLI21MHmbpgl+yYUpQGnN0M=;
        b=G7I3IyA5pg5dRJOanAokUb9t5uoGCHGvvL7ftIzS9hLYTc2NgS4Cv3JoMqpopFExLV
         /1P1DsezRMun8XQlkVSRgHVv4GvMC10N4PeqO2eQLVGJ0qiIQsUJOjI2SRYXSDCanovI
         wdatQyhh9YDfUVMYwwA9j2UT7ZXEj1rj3FEaQhjel7/fNlgK3CDgUT/GxC/SN2HIrd4t
         AZshH7DE2rYKxFFzl2o/Gm+2s8sGb72RNNr6sUq9NW061Igbh8NQ5enhZddxhYfQQyJj
         HwFpMxkqqNBMrSUc2TksjZwnEBYLn0OFKPgR+PCy46jVlXJY4qO9RHTBEEB1/7KvpoRr
         iEdw==
X-Gm-Message-State: AOAM533frL3ICc5SKF5EX+V+HUPw+fp/yZP/46KyzwHq4BrdeSvVtOXC
        OjrFkhyozQ0skHtZmHA7MhuAUQ==
X-Google-Smtp-Source: ABdhPJyn/9Xqo0aTMQp64EFk5vVQwwz3C0Eg/qigMPVi8Ezp+p1m4QTNrp2FUyu4T5Va0pjV/BAr5w==
X-Received: by 2002:aca:d883:: with SMTP id p125mr464423oig.100.1592864858557;
        Mon, 22 Jun 2020 15:27:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] arm64: dts: qcom: sm8250-mtp: Drop PM8150 ldo11
Date:   Mon, 22 Jun 2020 15:27:42 -0700
Message-Id: <20200622222747.717306-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8150 ldo11 on the MTP is wired to VDD_SSC_CX and controlled in levels,
rather than as a regulator. As such it's available from the rpmhpd as
the SM8250_LCX power domain.

Fixes: ec13d5c23a33 ("arm64: dts: qcom: sm8250-mtp: Add pm8150, pm8150l and pm8009")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 2fc9e7ff0060..63d259931c4d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -140,13 +140,6 @@ vreg_l10a_1p8: ldo10 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
-		vreg_l11a_0p75: ldo11 {
-			regulator-name = "vreg_l11a_0p75";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
 		vreg_l12a_1p8: ldo12 {
 			regulator-name = "vreg_l12a_1p8";
 			regulator-min-microvolt = <1800000>;
-- 
2.26.2

