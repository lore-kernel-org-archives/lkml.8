Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE8206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bbgp8eSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgFZUBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:01:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59590 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgFZUBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:01:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593201699; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CCDJosHB5mbNTbda0xIOZV8MFSOhmNJXwZyaB7uwS4I=; b=bbgp8eSWaXiaG93Kxd0ssF6G4GVfXMrbuJTIt9TmVkJtK1Nkap7gq1xtmDDzp1F0WbkaZ7wZ
 XeTy3Cjx4ge2/Xj8sELYLM2x54Wx9a2xfvo1yUVMwB9NRFu2NmnVBYx0zazZY84IFXp3ytWo
 lyIIwX2KTjYV4gPrG0mHTRp/Mvo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ef653f56bebe35deb38d4f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 20:00:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21A3CC433A1; Fri, 26 Jun 2020 20:00:53 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16C2FC433CB;
        Fri, 26 Jun 2020 20:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16C2FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
Date:   Fri, 26 Jun 2020 14:00:37 -0600
Message-Id: <20200626200042.13713-4-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626200042.13713-1-jcrouse@codeaurora.org>
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index d7ceb4c34423..e52a1b146c97 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,10 @@ properties:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - items:
           - const: arm,mmu-500
           - const: arm,smmu-v2
-- 
2.17.1

