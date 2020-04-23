Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15808C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0016120780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgDWXIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:08:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50936 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728663AbgDWXG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:59 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvk-0004xG-Jw; Fri, 24 Apr 2020 00:06:52 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvj-00E73X-S3; Fri, 24 Apr 2020 00:06:51 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Max Kellermann" <max@duempel.org>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>
Date:   Fri, 24 Apr 2020 00:07:46 +0100
Message-ID: <lsq.1587683028.937457411@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 239/245] [media] drivers/media/media-devnode: clear
 private_data before put_device()
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Kellermann <max@duempel.org>

commit bf244f665d76d20312c80524689b32a752888838 upstream.

Callbacks invoked from put_device() may free the struct media_devnode
pointer, so any cleanup needs to be done before put_device().

Signed-off-by: Max Kellermann <max@duempel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/media-devnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/media-devnode.c
+++ b/drivers/media/media-devnode.c
@@ -197,10 +197,11 @@ static int media_release(struct inode *i
 	if (mdev->fops->release)
 		mdev->fops->release(filp);
 
+	filp->private_data = NULL;
+
 	/* decrease the refcount unconditionally since the release()
 	   return value is ignored. */
 	put_device(&mdev->dev);
-	filp->private_data = NULL;
 	return 0;
 }
 

