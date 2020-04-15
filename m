Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22508C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042FA21556
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YN+7n4PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411256AbgDORcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:32:15 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64835 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411231AbgDORb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586971918; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wpCdJNvYZP9qF1wOYRfniOwkSK/ZZk5UjNBFMZ9bkXA=; b=YN+7n4PXrlnBtbu0lKy2+bzObsAnu12xOPbb6iCIySz1b660vnSC3fkPTFhPoyN1acpAe78H
 JuYnNPqJcTAbTlkuN63UDD/nHdyoyc0XAjXId02/CSWDiWt/4pMRgOMIJYHY0ZyNHAaj93Ms
 86ZbnKNrAJs8si8bLqRYkj3HY1U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e97450c.7f8566d05df8-smtp-out-n03;
 Wed, 15 Apr 2020 17:31:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 477CFC433BA; Wed, 15 Apr 2020 17:31:56 +0000 (UTC)
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D14ABC433F2;
        Wed, 15 Apr 2020 17:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D14ABC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v3 1/3] dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
Date:   Wed, 15 Apr 2020 23:01:44 +0530
Message-Id: <1586971906-20985-2-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
References: <1586971906-20985-1-git-send-email-pillair@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wifi-firmware subnode for the wifi node.
This wifi-firmware subnode is needed for the
targets which do not support TrustZone.

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index 71bf91f..65ee68e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -96,6 +96,17 @@ Optional properties:
 - qcom,coexist-gpio-pin : gpio pin number  information to support coex
 			  which will be used by wifi firmware.
 
+* Subnodes
+The ath10k wifi node can contain one optional firmware subnode.
+Firmware subnode is needed when the platform does not have TustZone.
+The firmware subnode must have:
+
+- iommus:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: A list of phandle and IOMMU specifier pairs.
+
+
 Example (to supply PCI based wifi block details):
 
 In this example, the node is defined as child node of the PCI controller.
@@ -196,4 +207,7 @@ wifi@18000000 {
 		memory-region = <&wifi_msa_mem>;
 		iommus = <&apps_smmu 0x0040 0x1>;
 		qcom,msa-fixed-perm;
+		wifi-firmware {
+			iommus = <&apps_iommu 0xc22 0x1>;
+		};
 };
-- 
2.7.4
