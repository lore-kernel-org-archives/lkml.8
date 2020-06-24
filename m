Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B267E20E65
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UNjfRDgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgFXC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:29:17 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30813 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388435AbgFXC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:29:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592965750; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UzcgDw9n9kBfEZNwWK3c48GGaqOX+yfmTzwzb4twqao=; b=UNjfRDgAlLxznSK5JVNxqNmnKHU3cem6dAmNIwff3IFbDz1fvN+buFVLxUxBfXKlc8D0kGBn
 6CzKFifqGJfjbTkxwzOqJc/qNlwpOpwinUJ5gZzxkjWyvSYIvT+ynKORakxXSQPOw9WuOi9c
 JSEdwUjqGJR2rLNAp4Ff+WhoUhE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ef2ba6a4c9690533a7db413 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 02:28:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61D82C433B2; Wed, 24 Jun 2020 02:28:58 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 697E1C43395;
        Wed, 24 Jun 2020 02:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 697E1C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Subject: [RFC v4 3/3] dt-bindings: usb: dwc3: Add entry for tx-fifo-resize
Date:   Tue, 23 Jun 2020 19:28:48 -0700
Message-Id: <20200624022848.7765-4-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624022848.7765-1-wcheng@codeaurora.org>
References: <20200624022848.7765-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-introduce the comment for the tx-fifo-resize setting for the DWC3
controller.  This allows for vendors to control if they require the TX FIFO
resizing logic on their HW, as the default FIFO size configurations may
already be sufficient.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9ba735..489f5da83744 100644
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

