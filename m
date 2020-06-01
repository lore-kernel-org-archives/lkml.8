Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42852077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035011;
	bh=eh0C+0x9mVrpmssuTcn3nRjVa4S+T2umUEJ6R35Nwt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oD6Wix2wFGC9lhtCJ4480AmQBHokgDYdkax9GM8Q6eV4+8vKUWyPnhFEDXsILRH3f
	 FE7dBFiR42XFMr8UBdM31iwO/mkjkFxfkosTkE4eyp7U1BVbGtctBSXhNA3Au8qnhf
	 7gMZYn6eF5kOND/ulDNjJnDROVKlFiKU3z/aSakk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgFASKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbgFASJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:09:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEC720872;
        Mon,  1 Jun 2020 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034995;
        bh=eh0C+0x9mVrpmssuTcn3nRjVa4S+T2umUEJ6R35Nwt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkRS+VKrcq54r6POyT5IfRVcLUIbe8apYsMs5Y0GDRNn2dYYRObAYWa9VVZpwo8je
         70IlTjH/cz80PsPlw/quJGZJQO3BsGaLxqwZT38aZf5U/yK1OL37Cs+atZnIG4zIxC
         FwmeMorbQ5h9P2fSEGFmqhjrUMsALqPaPDf3+FS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Maret <mathieu.maret@gmail.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/142] Input: evdev - call input_flush_device() on release(), not flush()
Date:   Mon,  1 Jun 2020 19:53:43 +0200
Message-Id: <20200601174044.622686044@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Shanks <bshanks@codeweavers.com>

[ Upstream commit 09264098ff153f60866039d60b31d39b66f55a31 ]

input_flush_device() should only be called once the struct file is being
released and no open descriptors remain, but evdev_flush() was calling
it whenever a file descriptor was closed.

This caused uploaded force-feedback effects to be erased when a process
did a dup()/close() on the event FD, called system(), etc.

Call input_flush_device() from evdev_release() instead.

Reported-by: Mathieu Maret <mathieu.maret@gmail.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
Link: https://lore.kernel.org/r/20200421231003.7935-1-bshanks@codeweavers.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/evdev.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index cb6e3a5f509c..0d57e51b8ba1 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -326,20 +326,6 @@ static int evdev_fasync(int fd, struct file *file, int on)
 	return fasync_helper(fd, file, on, &client->fasync);
 }
 
-static int evdev_flush(struct file *file, fl_owner_t id)
-{
-	struct evdev_client *client = file->private_data;
-	struct evdev *evdev = client->evdev;
-
-	mutex_lock(&evdev->mutex);
-
-	if (evdev->exist && !client->revoked)
-		input_flush_device(&evdev->handle, file);
-
-	mutex_unlock(&evdev->mutex);
-	return 0;
-}
-
 static void evdev_free(struct device *dev)
 {
 	struct evdev *evdev = container_of(dev, struct evdev, dev);
@@ -453,6 +439,10 @@ static int evdev_release(struct inode *inode, struct file *file)
 	unsigned int i;
 
 	mutex_lock(&evdev->mutex);
+
+	if (evdev->exist && !client->revoked)
+		input_flush_device(&evdev->handle, file);
+
 	evdev_ungrab(evdev, client);
 	mutex_unlock(&evdev->mutex);
 
@@ -1310,7 +1300,6 @@ static const struct file_operations evdev_fops = {
 	.compat_ioctl	= evdev_ioctl_compat,
 #endif
 	.fasync		= evdev_fasync,
-	.flush		= evdev_flush,
 	.llseek		= no_llseek,
 };
 
-- 
2.25.1



