Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26230C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018AB22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260107;
	bh=xYNtf1K9Clxoc111B6sXE1QVfCLFVpgTKazDwptjWFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hfITBd0Z2jXsCxdKV2rWKjc4JFWlR+ZqMExdI5yNkHzc9Hkb/6tIpAwIyVNpQDP7S
	 NoxJ3pqmPyV1+090uUUybDTQ9wgWQk7q7HzT769268mTtMzzcqm8BsGOcKcIGKo3xN
	 IkGjWWNbIIoCZ/H82qmL1FhB8SH6NPAUfOY4BA5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgGTPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbgGTPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:48:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031EA22CAF;
        Mon, 20 Jul 2020 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260102;
        bh=xYNtf1K9Clxoc111B6sXE1QVfCLFVpgTKazDwptjWFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKNqzX02VAQYAs1JGzbGZvScfDJqm7I9ot8+zVEsuOw4DhY4XR9b5vQjere6P8/MO
         G5OHrYnPMkEbzRTs125E8MTL99HzE8oFTAfMMVuItu7/cLmX5pl4htwG/Hdtf1aeO/
         UFfKUQJRQoArOTGhnM4dxiKEOvOa/ndjFdzFNOFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chirantan Ekbote <chirantan@chromium.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 107/125] fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS
Date:   Mon, 20 Jul 2020 17:37:26 +0200
Message-Id: <20200720152808.195336396@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chirantan Ekbote <chirantan@chromium.org>

commit 31070f6ccec09f3bd4f1e28cd1e592fa4f3ba0b6 upstream.

The ioctl encoding for this parameter is a long but the documentation says
it should be an int and the kernel drivers expect it to be an int.  If the
fuse driver treats this as a long it might end up scribbling over the stack
of a userspace process that only allocated enough space for an int.

This was previously discussed in [1] and a patch for fuse was proposed in
[2].  From what I can tell the patch in [2] was nacked in favor of adding
new, "fixed" ioctls and using those from userspace.  However there is still
no "fixed" version of these ioctls and the fact is that it's sometimes
infeasible to change all userspace to use the new one.

Handling the ioctls specially in the fuse driver seems like the most
pragmatic way for fuse servers to support them without causing crashes in
userspace applications that call them.

[1]: https://lore.kernel.org/linux-fsdevel/20131126200559.GH20559@hall.aurel32.net/T/
[2]: https://sourceforge.net/p/fuse/mailman/message/31771759/

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
Fixes: 59efec7b9039 ("fuse: implement ioctl support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/file.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -17,6 +17,7 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/fs.h>
 
 static const struct file_operations fuse_direct_io_file_operations;
 
@@ -2534,7 +2535,16 @@ long fuse_do_ioctl(struct file *file, un
 		struct iovec *iov = iov_page;
 
 		iov->iov_base = (void __user *)arg;
-		iov->iov_len = _IOC_SIZE(cmd);
+
+		switch (cmd) {
+		case FS_IOC_GETFLAGS:
+		case FS_IOC_SETFLAGS:
+			iov->iov_len = sizeof(int);
+			break;
+		default:
+			iov->iov_len = _IOC_SIZE(cmd);
+			break;
+		}
 
 		if (_IOC_DIR(cmd) & _IOC_WRITE) {
 			in_iov = iov;


