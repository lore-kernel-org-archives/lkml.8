Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88120C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5860820857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gQEGEDdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEGPCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:02:30 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44973 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727810AbgEGPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:02:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588863749; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DjP1W3zJv/dOZ5LhbYVvKQs1ZCKiV2ra1DV+bMPxgPI=; b=gQEGEDdWdrBS3f5tfjJfBV6GU7MwzzVIKM9XowENZNA5VB0eagJDauV23SHGfYpR4mI9eDno
 XnDUWFuFHBcWKyyDjWtpNdqlopOq5YaOy1sCTJ3dDAIt3k/PJxEmoteC+fu1vPJJWTGBYimA
 /ilXJH+PNsTiPxcANycw1nHhWC0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb422c6.7f7d8cd4e4c8-smtp-out-n02;
 Thu, 07 May 2020 15:01:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 618F8C38563; Thu,  7 May 2020 15:01:25 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FF6AC3855E;
        Thu,  7 May 2020 15:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FF6AC3855E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org, mka@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V6 2/3] dt-bindings: geni-se: Add interconnect binding for GENI QUP
Date:   Thu,  7 May 2020 20:30:46 +0530
Message-Id: <1588863647-17240-3-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588863647-17240-1-git-send-email-akashast@codeaurora.org>
References: <1588863647-17240-1-git-send-email-akashast@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the interconnect and interconnect-names properties
for the GENI QUP.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
Changes in V5:
 - Add interconnect property for QUP wrapper (parent node).
 - Add minItems = 2 for interconnect property in child nodes

Changes in V6:
 - As per Rob's comment added minItems = 2 for interconnect-names.

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
