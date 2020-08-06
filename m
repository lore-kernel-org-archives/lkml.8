Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3297C35276
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCB7230FF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgHFJ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:26:13 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:29415 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgHFJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:25:06 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Aug 2020 02:25:02 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Aug 2020 02:25:00 -0700
Received: from gokulsri-linux.qualcomm.com ([10.201.2.207])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Aug 2020 14:54:40 +0530
Received: by gokulsri-linux.qualcomm.com (Postfix, from userid 432570)
        id 143F0219E6; Thu,  6 Aug 2020 14:54:38 +0530 (IST)
From:   Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org, gokulsri@codeaurora.org
Subject: [PATCH 1/3] dt-bindings: qcom: Add ipq8074 bindings
Date:   Thu,  6 Aug 2020 14:54:36 +0530
Message-Id: <1596705878-12385-2-git-send-email-gokulsri@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596705878-12385-1-git-send-email-gokulsri@codeaurora.org>
References: <1596705878-12385-1-git-send-email-gokulsri@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new device-tree bindings for boards
HK10-C1 and HK10-C2 based on ipq8074 SoC.

Signed-off-by: Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 6031aee..7b294be 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -47,6 +47,8 @@ description: |
         cp01-c1
         dragonboard
         hk01
+        hk10-c1
+        hk10-c2
         idp
         liquid
         mtp
@@ -148,6 +150,8 @@ properties:
       - items:
           - enum:
               - qcom,ipq8074-hk01
+              - qcom,ipq8074-hk10-c1
+              - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
       - items:
-- 
2.7.4

