Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F8BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46ED720878
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034273;
	bh=w7DJnZMmhCocz2csBVNNPUMzJF7l7UZPIEyYgpL5EQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nqoDbZMpvv3XhZzNeHxvJVDadWJ2kfsPWIP1rM+ZmXTqLV6eOn3P3QrY7Cmz2a84k
	 0XQt7E+mu7fG0HEOUNEGcyAEQJQbxHFc0eaMwXzC3V6rKEqbnyxYG7Jewrohwucw/U
	 r+bAQTQzGprX6Ss3FKdUhlYmEu0NswRGOAmea6Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgFAR5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgFAR5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:57:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE058206E2;
        Mon,  1 Jun 2020 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034268;
        bh=w7DJnZMmhCocz2csBVNNPUMzJF7l7UZPIEyYgpL5EQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSoDgPWeBef4fArJ7DylQcmyVNyqM2OoX7Lo636NuAfTeRiwYpFfu+CjeSSy+aUWW
         sAgeHyBt5OYdMjRrPMhBoChe3Wi4DHaqLYZggMlzoDsbtk5dPUcMetd6P1zm3f6yCg
         Y1TEhuhc4nX5rhEiNWfshpKrMmBvV4a7nU2F2gCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        kbuild test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/61] usb: gadget: legacy: fix redundant initialization warnings
Date:   Mon,  1 Jun 2020 19:53:25 +0200
Message-Id: <20200601174015.089331120@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d13cce757954fa663c69845611957396843ed87a ]

Fix the following cppcheck warnings:

drivers/usb/gadget/legacy/inode.c:1364:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1331:15: note: value is initialized
 int    value = -EOPNOTSUPP;
              ^
drivers/usb/gadget/legacy/inode.c:1364:8: note: value is overwritten
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1817:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EINVAL;
       ^
drivers/usb/gadget/legacy/inode.c:1787:18: note: value is initialized
 ssize_t   value = len, length = len;
                 ^
drivers/usb/gadget/legacy/inode.c:1817:8: note: value is overwritten
 value = -EINVAL;
       ^
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Felipe Balbi <balbi@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index b8534d3f8bb0..cb02e9ecd8e7 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1364,7 +1364,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	req->buf = dev->rbuf;
 	req->context = NULL;
-	value = -EOPNOTSUPP;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1788,7 +1787,7 @@ static ssize_t
 dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 {
 	struct dev_data		*dev = fd->private_data;
-	ssize_t			value = len, length = len;
+	ssize_t			value, length = len;
 	unsigned		total;
 	u32			tag;
 	char			*kbuf;
-- 
2.25.1



