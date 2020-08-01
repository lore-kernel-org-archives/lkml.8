Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C889BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FC92076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 03:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Hxmr/4CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHADcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 23:32:45 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38478 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728540AbgHADcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 23:32:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252763; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=CbeBO8xpIFHbSr+KJL7IVqqXy/0RcXGTzAtyWv4Pr3o=; b=Hxmr/4CBTJ53u/sJQ71oV+bG8BB05lievpQIdOglcFE98tEuNgR9P0NCay7XY1FFmAvBVMtp
 20okJnpBYlEQhQrrA7y9oETew9ZsJ2FX99p2o+zet2snCyKefEYcrI/ybzTDehzQLn6M08Nx
 VEl369iLSMaHtrj56AuuFeihUd0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f24e24a710a7a29d5f38083 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1FADC433CA; Sat,  1 Aug 2020 03:32:25 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36B06C43391;
        Sat,  1 Aug 2020 03:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36B06C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 2/6] dt-bindings: interconnect: Add property to set BCM TCS wait behavior
Date:   Fri, 31 Jul 2020 20:32:11 -0700
Message-Id: <20200801033215.1440-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200801033215.1440-1-mdtipton@codeaurora.org>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
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
 .../bindings/interconnect/qcom,bcm-voter.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index 5971fc1df08d..e23df4836c6f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -21,6 +21,23 @@ properties:
     enum:
       - qcom,bcm-voter
 
+  qcom,tcs-wait:
+    description: |
+      Optional mask of which TCSs (Triggered Command Sets) wait for completion
+      upon triggering. If not specified, then the AMC and WAKE sets wait for
+      completion. The mask bits are available in the QCOM_ICC_TAG_* defines.
+
+      The AMC TCS is triggered immediately when icc_set_bw() is called. The
+      WAKE/SLEEP TCSs are triggered when the RSC transitions between active and
+      sleep modes.
+
+      In most cases, it's necessary to wait in both the AMC and WAKE sets to
+      ensure resources are available before use. If a specific RSC and its use
+      cases can ensure sufficient delay by other means, then this can be
+      overridden to reduce latencies.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
 
@@ -39,7 +56,10 @@ examples:
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

