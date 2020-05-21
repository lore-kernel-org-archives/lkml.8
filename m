Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A21C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1F520721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dUszdQwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgEUIgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:36:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63630 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728708AbgEUIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:36:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590050195; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=aZo+KSybveCXJFPXyoW8aJ7eC6Kn0YlHOsLwiJxxttA=; b=dUszdQwX7QAFN0I1KNQQLrfbKdhzH2HFzY31aAJQ71rslhnJ5rskfGlqh6+nIo4giMPlnvjz
 sK28J8wrMqRp8+qWpAUkm4paiUniDysrdnccxJ8VjmQs2wIGCGp/LlQj8n7XO7gYYtj+pROv
 nxBfEvs4oPbrRkcV2kRBjXFGDOw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec63d80eb073d56915bfc98 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 08:36:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9EF42C43395; Thu, 21 May 2020 08:36:15 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2EA8C433CA;
        Thu, 21 May 2020 08:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2EA8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2 3/3] dt-bindings: usb: dwc3: Add entry for tx-fifo-resize
Date:   Thu, 21 May 2020 01:36:09 -0700
Message-Id: <1590050169-30747-4-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590050169-30747-1-git-send-email-wcheng@codeaurora.org>
References: <1590050169-30747-1-git-send-email-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-introduce the comment for the tx-fifo-resize setting for the DWC3
controller.  This allows for vendors to control if they require the TX FIFO
resizing logic on their HW, as the default FIFO size configurations may
already be sufficient.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9..489f5da 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -105,7 +105,7 @@ Optional properties:
 			1-16 (DWC_usb31 programming guide section 1.2.3) to
 			enable periodic ESS TX threshold.
 
- - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
  - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
 			register, undefined length INCR burst type enable and INCRx type.
 			When just one value, which means INCRX burst mode enabled. When
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

