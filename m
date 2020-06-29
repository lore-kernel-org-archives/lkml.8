Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B76206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462319;
	bh=H4bLp+NXSxDVf8zAgb8bhAnGb5CXhl2QrEc45pTUjk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8Zp/6zVDsbWwyyYue4u8M7HFAR8qXCBR/dM5XQ8tgLahn8Fi3imlWRgKq5Ld+Vyg
	 M1RaSfvJwTwoKvkidssx+cJyUdYiKkANt9boHFEz/Epk/xi/ZYlXoFQRC/2yySclMI
	 xRgJvkiadM7rTnb9X2maRBH3dpJZcB+NBYb7tj8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbgF2UZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732542AbgF2TZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DD925364;
        Mon, 29 Jun 2020 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445225;
        bh=H4bLp+NXSxDVf8zAgb8bhAnGb5CXhl2QrEc45pTUjk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0FJ6abUCdFrKK5oNtQO7a2KlIPv0MOtL3UFSimPCcJfBv8qTp4wzpdJzMZNnC9he
         17gn0PR5asVGLXPeBuY7CMa8QAqlJ5ZdjPHx6R0t9cdwvU7KhS0f974ZvMKc1JKjUT
         FYhfk9DF2XSHrf0HtzL1s+RCYsu9yqpYSuvIXGH8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 012/191] usblp: poison URBs upon disconnect
Date:   Mon, 29 Jun 2020 11:37:08 -0400
Message-Id: <20200629154007.2495120-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 296a193b06120aa6ae7cf5c0d7b5e5b55968026e ]

syzkaller reported an URB that should have been killed to be active.
We do not understand it, but this should fix the issue if it is real.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20200507085806.5793-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/usblp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 07c3c3449147f..c578d64edc153 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -481,7 +481,8 @@ static int usblp_release(struct inode *inode, struct file *file)
 	usb_autopm_put_interface(usblp->intf);
 
 	if (!usblp->present)		/* finish cleanup from disconnect */
-		usblp_cleanup(usblp);
+		usblp_cleanup(usblp);	/* any URBs must be dead */
+
 	mutex_unlock(&usblp_mutex);
 	return 0;
 }
@@ -1397,9 +1398,11 @@ static void usblp_disconnect(struct usb_interface *intf)
 
 	usblp_unlink_urbs(usblp);
 	mutex_unlock(&usblp->mut);
+	usb_poison_anchored_urbs(&usblp->urbs);
 
 	if (!usblp->used)
 		usblp_cleanup(usblp);
+
 	mutex_unlock(&usblp_mutex);
 }
 
-- 
2.25.1

