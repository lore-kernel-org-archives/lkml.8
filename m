Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF0C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750524656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814695;
	bh=NQhSwyYXRqDIefeJAhsB5HufY4DubhhD3WurtJ5yuNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3oZexaQCjJtnUQd94VKcesnztpEE66dnDgNkqLLM9Zq+DYhi3CTqyrdmkt3oZ+ZI
	 IKvYxQbigO82y0oGFFvvZr85ZLjakClU8ScYIU8vpN7ixvrk3tha9POZCnJnZzoZ1N
	 ehS3rHx91dzJb1P2IHgOarsAd0kg3fLt54/90OZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgB0Oox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbgB0NrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9003020578;
        Thu, 27 Feb 2020 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811240;
        bh=NQhSwyYXRqDIefeJAhsB5HufY4DubhhD3WurtJ5yuNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1iNc9/xv6cPJPX2uLGpw4OqaYyw69LMMn0xiIubpbf+R3+Bm2kTDAJMxz0bFLhpYM
         NZQqeS4MdQCzj1X61q3f+xAXFS7gvydrfF1qGoWf/XX8kAbqCgmSmJNeoUUFtZ/izq
         fuMD8MsJtPEAhyal1XA6wLf/GpJvVXt6U72S5lvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 057/165] orinoco: avoid assertion in case of NULL pointer
Date:   Thu, 27 Feb 2020 14:35:31 +0100
Message-Id: <20200227132239.764198258@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit c705f9fc6a1736dcf6ec01f8206707c108dca824 ]

In ezusb_init, if upriv is NULL, the code crashes. However, the caller
in ezusb_probe can handle the error and print the failure message.
The patch replaces the BUG_ON call to error return.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
index 8244d82629511..4e91c74fcfad9 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -1351,7 +1351,8 @@ static int ezusb_init(struct hermes *hw)
 	int retval;
 
 	BUG_ON(in_interrupt());
-	BUG_ON(!upriv);
+	if (!upriv)
+		return -EINVAL;
 
 	upriv->reply_count = 0;
 	/* Write the MAGIC number on the simulated registers to keep
-- 
2.20.1



