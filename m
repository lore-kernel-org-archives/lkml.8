Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D083C35E1C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3292073D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811750;
	bh=5ZhS83xKSd69Gd6diFUVn9rulU3syIPi3/tE+VyKn6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dZas64eaPE17VA0hnyQTHr9a98yzJgRKVWq6bKqiXu9pznYrqg975N4L6NcUsDtvq
	 /7TfRlZLJzAgN5iwjza0bXAbo6mjEYF3mzwUjyA4gDEjr6VKuBgQ/8o2M2tz0KJbQ+
	 KrrU5cbXXcRvmiqPMZtrNRuDZgeTu46ahxV9JRmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgB0Nzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgB0Nzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3B82073D;
        Thu, 27 Feb 2020 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811746;
        bh=5ZhS83xKSd69Gd6diFUVn9rulU3syIPi3/tE+VyKn6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttkqiGyshh6oK4IvakGYUoI2ktavkwq05UZnZatXdsqOKCE6/hjAElW1HFs3ZeIC6
         Q1H+oSt+e2JZTb7kWJ58m1KwWa4a06JGoV9RceyASouzdnLvFt7xaAlpRYuGd5tX9g
         qHNwjQ+zQwTgC+XvSdwkZfozBRNXg2Y0S0CaiVCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 086/237] orinoco: avoid assertion in case of NULL pointer
Date:   Thu, 27 Feb 2020 14:35:00 +0100
Message-Id: <20200227132303.386135791@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
index 95015d74b1c0e..5a64674a5c8da 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -1364,7 +1364,8 @@ static int ezusb_init(struct hermes *hw)
 	int retval;
 
 	BUG_ON(in_interrupt());
-	BUG_ON(!upriv);
+	if (!upriv)
+		return -EINVAL;
 
 	upriv->reply_count = 0;
 	/* Write the MAGIC number on the simulated registers to keep
-- 
2.20.1



