Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3D620692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RXAQ7PG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDKIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:04:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32636 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgDKIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:04:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586592277; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CGSSIIgOQonIzRJ2aP9akavKHcdXJYuY2r+uW6Fff4s=; b=RXAQ7PG5UpsjKgKqoHJeT4EcHl2vkgwnMugLv4S7GYjEn/HNkR1+5y2+dUHXL7qBDFi8hQky
 FeQ9jeqJsqxOS9vsh2bS+HcIPSXlDeLRHsErvdaFIWcg6uM7FtD9W1nSQcvVFu/rlyes+aBE
 FfYyf6ktxiIGGHRvwC+f3mSH7R4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e917a14.7f62ea4f4c70-smtp-out-n03;
 Sat, 11 Apr 2020 08:04:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D8B8C433F2; Sat, 11 Apr 2020 08:04:35 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ajitp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F031EC43636;
        Sat, 11 Apr 2020 08:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F031EC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ajitp@codeaurora.org
From:   Ajit Pandey <ajitp@codeaurora.org>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: [PATCH 09/11] device-tree: bindings: sound: lpass-cpu: Add new compatible soc
Date:   Sat, 11 Apr 2020 13:32:49 +0530
Message-Id: <1586592171-31644-10-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7180 soc varaints of LPASS uses lpass-cpu node but required few extra
devictree configuration. Update bindings documents with sc7180 compatible
string specific dts properties.

Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
---
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index 727ec03..84bd95c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - qcom,lpass-cpu
       - qcom,apq8016-lpass-cpu
+      - qcom,lpass-cpu-sc7180
 
   reg:
     items:
@@ -68,6 +69,14 @@ properties:
     maxItems: 1
     description: Phandle for the audio DSP node
 
+  iommus:
+    maxItems: 1
+    description: Phandle to apps_smmu node with sid mask
+
+  power-domains:
+    maxItems: 1
+    description: Phandle for power domain node
+
   '#sound-dai-cells':
     const: 1
 
@@ -108,6 +117,17 @@ required:
 optional:
   - qcom,adsp
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,lpass-cpu-sc7180
+
+then:
+  required:
+    - iommus
+    - power-domains
+
 examples:
   lpass@28100000 {
 	compatible = "qcom,lpass-cpu";
@@ -120,7 +140,10 @@ examples:
 		      "mi2s-bit-clk";
 
 	interrupts = <0 85 1>;
-	interrupt-names = "lpass-irq-lpaif";
+        interrupt-names = "lpass-irq-lpaif";
+
+	iommus = <&apps_smmu 0x1020 0>;
+	power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
 
 	reg = <0x28100000 0x10000>;
 	reg-names = "lpass-lpaif";
-- 
1.9.1
