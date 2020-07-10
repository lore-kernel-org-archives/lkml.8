Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9B8207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nCInmr7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGJB51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:57:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61278 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgGJB5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:57:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594346245; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=u8uz0uMN/xy7PGwmfxG8bfDIz484M6eYVSKAENLu8us=; b=nCInmr7cAZju3G1pXugZwOjt3Kn1QHgYFtiG6JxiZsjI7zNDH+ivBmDe7hVLlUukYRNeK0iA
 PjMRFLWF55u4uZ8g6xzXQMriP8VB0oNoHdLgKKJ+fLB+VTYcoO7Vh+cHKkosj/y1nFzoBaAK
 Aossbd8QiwE77TDbZItYpFS31ZQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f07caf3bca1ed3155803d08 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 01:57:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D4D0C43395; Fri, 10 Jul 2020 01:57:06 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5B6DC43391;
        Fri, 10 Jul 2020 01:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5B6DC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 2/6] dt-bindings: interconnect: Add property to set BCM TCS wait behavior
Date:   Thu,  9 Jul 2020 18:56:48 -0700
Message-Id: <20200710015652.19206-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200710015652.19206-1-mdtipton@codeaurora.org>
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,tcs-wait" property to set which TCS should wait for completion
when triggering.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index 5971fc1df08d..f0c3d6b01831 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -21,6 +21,16 @@ properties:
     enum:
       - qcom,bcm-voter
 
+  qcom,tcs-wait:
+    description: |
+      Optional mask of which TCSs (Triggered Command Sets) wait for completion
+      upon triggering. In most cases, it's necessary to wait in both the AMC
+      and WAKE sets to ensure resources are available before use. If a specific
+      RSC and its use cases can ensure sufficient delay by other means, then
+      this can be overridden to reduce latencies.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: QCOM_ICC_TAG_ACTIVE_ONLY
+
 required:
   - compatible
 
@@ -39,7 +49,10 @@ examples:
   # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
   - |
 
+    #include <dt-bindings/interconnect/qcom,icc.h>
+
     disp_bcm_voter: bcm_voter {
         compatible = "qcom,bcm-voter";
+        qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
     };
 ...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

