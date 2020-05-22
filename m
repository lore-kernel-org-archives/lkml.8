Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177DE2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159166;
	bh=rRFUb/wbJRkRGlyUCAj7rEc44u/e82cJaNwDolypntk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NRuyNbxTWLNCAciFhr3R7teKlbqgEhSw5PSjhiXvzMHmjjXGtBt7aSKGdSXPb5nWl
	 QQeIM94ZrUsshvTeSjR/ikbCsWWcCUNnMPPAHQnNb+OLupwsC5VItb7v6hODTU20TD
	 kSKzBx3D3V54xJNmx9dnKWqiy0g8ZJy0D7wwvASM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgEVOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbgEVOwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:52:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D0022472;
        Fri, 22 May 2020 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159132;
        bh=rRFUb/wbJRkRGlyUCAj7rEc44u/e82cJaNwDolypntk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgxQQYRw+dqUSCDDbQ4+vaYhWeohs2MR9vaJlUu06yxi16VC8rYJizn/UpUMVIUYD
         Bh+awTPMGBYXm25ZysWIlFvoXa3r4UwPcruUdCrVPlbL0rn07i7RgcpBdYLYt8Cqk0
         tTwMs/akXa8BRIWiKGza4ffOoUQ3PmXGjKCnRsFw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        kbuild test robot <lkp@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/5] usb: gadget: legacy: fix redundant initialization warnings
Date:   Fri, 22 May 2020 10:52:06 -0400
Message-Id: <20200522145207.435314-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145207.435314-1-sashal@kernel.org>
References: <20200522145207.435314-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 81f3c9cb333c..b95900168a6b 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1360,7 +1360,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	req->buf = dev->rbuf;
 	req->context = NULL;
-	value = -EOPNOTSUPP;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1806,7 +1805,7 @@ static ssize_t
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

