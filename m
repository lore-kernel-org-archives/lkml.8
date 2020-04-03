Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D45C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4215F20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585919926;
	bh=WqfXIrmWWvxJbbjVxq8Ax+aX7FyrSzMmutGDKxcL97g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XrZrlYB3GoWmmulKCt5zAFG7RqpcVqQLyUfvdC82VJH4fwe38xRZCed4cR31wPhD0
	 bGXeAcMBLxJvMoONcXHTJdlHXm/kLTp93PGv8t6ZLJuyr/vv8XDVFQFaKEAXwRIG6S
	 KWXgLuTAsgS3eqEAPnJcvNGNru4KdQwKXW6saAek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403965AbgDCNSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:18:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39294 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDCNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:18:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 033DH9t9027909;
        Fri, 3 Apr 2020 22:17:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 033DH9t9027909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585919830;
        bh=6SNvN4uZsUHdhQ28mSp8KyStQBpxyYCWP8kC6l/eSfI=;
        h=From:To:Cc:Subject:Date:From;
        b=uhYpip08oTMfdfXf8KHL6QegqkNA6gfAiFvhui0ahYMcbzpxCL2l+0kBcYQ/mrruC
         lHlvf61boJqmhqeXKM3t6CD4m6rQKDVyYi/7WNYY74AK/KCNYdm9w85nR0Sbx6cJfg
         8M6Zg39W3WGHxd2K+3YYXbg3G5qo24s9ZBJo3eSLQUKFVK5tDG9sgSFD8S9rxL7Jzg
         89AGfwjYIB3TSWE0HADxvPqIe7jKFrQqDLQO/AiV5xCb3kim7DrCfghjmgGPImLw2k
         pgONRMfdu6j3FQ/PIUKsWrAYWGi8CJOXcMtMNCFQxxUzk5UAN2ShA0EEyeG16nu0x6
         9PgHAHnK3q3Aw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Howells <dhowells@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: legacy: fix redundant initialization warnings from cppcheck
Date:   Fri,  3 Apr 2020 22:16:51 +0900
Message-Id: <20200403131652.8183-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I do not think this is my fault because the addressed commit did not
touch this file, but the kbuild test robot sent me this report somehow:

  https://lkml.org/lkml/2020/4/3/395

Anyway, the warnings are real, so I removed the redundant assignments.
I re-ran cppcheck and confirmed the warnings have been fixed.


 drivers/usb/gadget/legacy/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index aa0de9e35afa..3afddd3bea6e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1361,7 +1361,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	req->buf = dev->rbuf;
 	req->context = NULL;
-	value = -EOPNOTSUPP;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1784,7 +1783,7 @@ static ssize_t
 dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 {
 	struct dev_data		*dev = fd->private_data;
-	ssize_t			value = len, length = len;
+	ssize_t			value, length = len;
 	unsigned		total;
 	u32			tag;
 	char			*kbuf;
-- 
2.17.1

