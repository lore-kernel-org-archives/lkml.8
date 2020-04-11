Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E778C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3439620692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YjjzxNeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDKIE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25069 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgDKIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592266; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nn24KJxCv5CBH4kdVxNd2V5W0FeWkwt+MwdO1L8CEGs=; b=YjjzxNeOv+o15nKOH45LXTkOLYYIxRlHwS/6iA0hX2gFeoiGuMChVEmBPvn8j/QEs1C4BCJq
 FhVVOOhcx7oKY5Zo91qvov4O3GEz1RpUzqkSbuFOrAULlNCV3j1kLo9bNfahPZ+fatdFRuFw
 GUGCM3BPWp+z+twuEsqh1T7NP5c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e917a0a.7ff5c7bb8df8-smtp-out-n05;
 Sat, 11 Apr 2020 08:04:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38EE6C433CB; Sat, 11 Apr 2020 08:04:25 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75C85C43636;
        Sat, 11 Apr 2020 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75C85C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 07/11] Documentation: dt-bindings: sound: Add details for new dai properties
Date:   Sat, 11 Apr 2020 13:32:47 +0530
Message-Id: <1586592171-31644-8-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes related to new sub node defining MI2S dai's properties. Such
properties needs to be configured via board specific dts files.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index a87a406..727ec03 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -16,6 +16,8 @@ description: |
   configure Low-Power Audio Interface(LPAIF) core registers across different
   IP versions.
 
+  See also dt-bindings/sound/qcom,lpass.h.
+
 properties:
   compatible:
     enum:
@@ -69,6 +71,30 @@ properties:
   '#sound-dai-cells':
     const: 1
 
+  dai-name:
+    - description: Each node represents an MI2S dai and conatins dai specific
+        properties that may change with board layout & dai connections.
+    - type: object
+    - properties:
+      id:
+        - description: dai id among one of value defined in header
+        - type: u32
+      qcom,spkmode-mask:
+        - description: mask defining data lines used for speaker
+        - type: u32
+      qcom,micmode-mask:
+        - description: mask defining data lines used for mic
+        - type: u32
+      qcom,wssrc-mask:
+        - description: mask defining word-select source internal/extrnal on dai
+        - type: u32
+      qcom,loopback-mask:
+        - description: mask defining loopback enable/disable on dai
+        - type: u32
+
+      required:
+        - id
+
 required:
   - compatible
   - reg
@@ -101,3 +127,10 @@ examples:
 	#sound-dai-cells = <1>;
 	qcom,adsp = <&adsp>;
 
+        prim-mi2s@0 {
+		id = <MI2S_PRIMARY>;
+		qcom,spkmode-mask = <SD1>;
+		qcom,micmode-mask = <SD0>;
+                qcom,wssrc-mask = <INTERNAL>;
+                qcom,loopback-mask = <DISABLE>;
+	};
-- 
1.9.1
