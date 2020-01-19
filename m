Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECD6C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CE9206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kGJSwti9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgASNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 08:13:56 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:38758 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727586AbgASNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:13:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579439633; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=5+GZjw2TCHeQIbwTltRSDntorXWcIHggVUbgZKjVq54=; b=kGJSwti9CC9WOGUKh638/HDmu37CVRxYq3ggN5w5Sz/VlUMhQVs0bLvDpjyuGEzg0wbJrA/3
 3TZ74Ep2TGTnCxtTdE28tY7Cs8yP9DMhD0xuLMn66aTOvIpWurkjtr1iehLdkoVLl2jz2lSk
 LApNfCeWkFgLA6DzfkRFy6zR7CY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e24560f.7f3802f673e8-smtp-out-n02;
 Sun, 19 Jan 2020 13:13:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD2A7C447A6; Sun, 19 Jan 2020 13:13:50 +0000 (UTC)
Received: from srichara1-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F2A7C4479C;
        Sun, 19 Jan 2020 13:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F2A7C4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        sricharan@codeaurora.org
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: [PATCH V6 3/5] dt-bindings: qcom: Add ipq6018 bindings
Date:   Sun, 19 Jan 2020 18:43:19 +0530
Message-Id: <1579439601-14810-4-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579439601-14810-1-git-send-email-sricharan@codeaurora.org>
References: <1579439601-14810-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new ipq6018 SOC/board device tree bindings.

Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 529d924..164177e 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -28,6 +28,7 @@ description: |
         apq8074
         apq8084
         apq8096
+        ipq6018
         ipq8074
         mdm9615
         msm8916
@@ -41,6 +42,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         cdp
+        cp01-c1
         dragonboard
         hk01
         idp
@@ -150,4 +152,10 @@ properties:
           - enum:
               - qcom,sc7180-idp
           - const: qcom,sc7180
+
+      - items:
+          - enum:
+              - qcom,ipq6018-cp01-c1
+          - const: qcom,ipq6018
+
 ...
-- 
2.7.4
