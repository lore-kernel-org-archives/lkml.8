Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703AFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D033207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WRFLWp1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgE0G2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:28:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55536 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbgE0G2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:28:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590560895; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=1JU5P6SSJi3Mzo/Vr/khHl0YlT5LryxGbyA3I2UXqIQ=; b=WRFLWp1EmCdvH3Sbl8XrNwZ4qL0bsgJ4N/9+LxmNUL8yTAtXwxfLGwE7E02cnvjW1Bt1PoIv
 KrRmFRy3Dm+t2uh50K9T2l1JnkBP3Aham1PCCSzB8xgHtbdnCgGcL/C2hVtmpjNigsQh3LmL
 kHz+dA+1oManoma764zdL8ZCUP4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ece08783131442d9566f518 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 06:28:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 019D5C433CB; Wed, 27 May 2020 06:28:08 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94953C433C6;
        Wed, 27 May 2020 06:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94953C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        msavaliy@codeaurora.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V7 2/3] dt-bindings: geni-se: Add interconnect binding for GENI QUP
Date:   Wed, 27 May 2020 11:57:43 +0530
Message-Id: <1590560864-27037-3-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590560864-27037-1-git-send-email-akashast@codeaurora.org>
References: <1590560864-27037-1-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect and interconnect-names properties
for the GENI QUP.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in V5:
 - Add interconnect property for QUP wrapper (parent node).
 - Add minItems = 2 for interconnect property in child nodes

Changes in V6:
 - As per Rob's comment added minItems = 2 for interconnect-names.

Changes in V7:
 - No change.

 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 885966f..b19505b 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -46,6 +46,12 @@ properties:
 
   ranges: true
 
+  interconnects:
+    maxItems: 1
+
+  interconnect-names:
+    const: qup-core
+
 required:
   - compatible
   - reg
@@ -73,6 +79,17 @@ patternProperties:
         description: Serial engine core clock needed by the device.
         maxItems: 1
 
+      interconnects:
+         minItems: 2
+         maxItems: 3
+
+      interconnect-names:
+         minItems: 2
+         items:
+           - const: qup-core
+           - const: qup-config
+           - const: qup-memory
+
     required:
       - reg
       - clock-names
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

