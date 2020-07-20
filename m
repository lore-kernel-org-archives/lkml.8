Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52F2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CjuyLSvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgGTQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:44:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14165 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbgGTPlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595259703; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zyH7f0j1Zl1XaF/dWFxsiYKuhloakssbIQW2PQAFye8=; b=CjuyLSvUkiTNf422rRZairrZNZNzubbOnBmazEHXSrxHaCjKggNgMtL3YlkQ4AgmLiTRd/x8
 FRU+e2NauoLNg6tXDJIfk1DDTaRf0j6aIva3MlXCV69hg5xdYEu4/ujlbaySJZ1nsHhpAjbS
 pVO84t5slqtCDdbpya7G8xdw9Co=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f15bb35d50c36e72976c796 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 15:41:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8D91C43469; Mon, 20 Jul 2020 15:41:34 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AB58C43395;
        Mon, 20 Jul 2020 15:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AB58C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        iommu@lists.linux-foundation.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 13/13] arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
Date:   Mon, 20 Jul 2020 09:40:47 -0600
Message-Id: <20200720154047.3611092-14-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720154047.3611092-1-jcrouse@codeaurora.org>
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
split pagetables and per-instance pagetables for drm/msm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 759cdd0b002b..d883144360aa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3981,7 +3981,7 @@ opp-257000000 {
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,adreno-smmu", "qcom,smmu-v2";
 			reg = <0 0x5040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.25.1

