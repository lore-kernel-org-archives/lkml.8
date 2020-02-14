Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94EDC3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A6420656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700018;
	bh=HsuiAuVjmyGRZWe1R+q2TUvEJVaGifg/AmwPAD21etU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fB2pxhfAijQHvzr1oslMjw8AQYCSv37KLO1dC7AJtwCGrNKGE1dsGZWY9DcNLmk4+
	 PW4F20sUF90nFXasmqKjQkL2uI0uFEYLtZPkvGgDWV24LH+vR3TSJx4DBJMZ8DLmQY
	 Z1v/A3lTPEdQMyqSX7mBj7DSFTAMtQ12hj8sMEac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392374AbgBNQOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392243AbgBNQOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2402D246C2;
        Fri, 14 Feb 2020 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696846;
        bh=HsuiAuVjmyGRZWe1R+q2TUvEJVaGifg/AmwPAD21etU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGc/LcyG3yQEGE5zQuf11ZobhFVfWo1bm2v1BS5xLYD4MX2UwfjS09WdD9rqpb0a3
         MMDqKwjG43NPZ2Oie+OeYf5YTI0bSMkat2oVQBePY84pIRBfov+YYNYHfPNwTo3/o7
         fMW9FR8TakzWdNtLJsevIA92Oz8f9aQBwW1IlYEE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 108/252] orinoco: avoid assertion in case of NULL pointer
Date:   Fri, 14 Feb 2020 11:09:23 -0500
Message-Id: <20200214161147.15842-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 2c7dd2a7350c1..b704e4bce171d 100644
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

