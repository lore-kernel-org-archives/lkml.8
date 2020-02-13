Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC1C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2B1206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607591;
	bh=ON+3G+hJbKkT+2LuEtLzWfkjK9GflaxmVD4AfwgcIZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKaUOX9qQkKqKnsoyTYHyXgffroziJ2h+t+HEpb9ohU5Hja+yAkfjpu2j+YccAQNG
	 Daw1Z6z7SdT8FrvMENOH/2qJy41JGsIigTui4/my1RbRVL7aelnvHck61hqYt8PUI/
	 qX2sbosMLcY+8H7A1/gAoR2eSjoQk8QkXN+fJFDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbgBMP0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgBMPYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B97624689;
        Thu, 13 Feb 2020 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607490;
        bh=ON+3G+hJbKkT+2LuEtLzWfkjK9GflaxmVD4AfwgcIZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3Ho+CUOEMhe911I6NreX1/KE34pzBfC5RZHis+jsHDdElrqrEKkdTmvjcvR4Cpdg
         81JTM9J3VhYVGo4IaRvzs5+wW+z0ZXJWfWUzzwx6hpKQ+kLME6Vg79wQnfSxaz+6Y9
         F3BusYmj0lUQ+AfqfpsL6lz1btLW8hY3rzuLR2vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 039/173] ubifs: Reject unsupported ioctl flags explicitly
Date:   Thu, 13 Feb 2020 07:19:02 -0800
Message-Id: <20200213151943.789180373@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

commit 2fe8b2d5578d7d142982e3bf62e4c0caf8b8fe02 upstream.

Reject unsupported ioctl flags explicitly, so the following command
on a regular ubifs file will fail:
	chattr +d ubifs_file

And xfstests generic/424 will pass.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/ioctl.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -28,6 +28,11 @@
 #include <linux/mount.h>
 #include "ubifs.h"
 
+/* Need to be kept consistent with checked flags in ioctl2ubifs() */
+#define UBIFS_SUPPORTED_IOCTL_FLAGS \
+	(FS_COMPR_FL | FS_SYNC_FL | FS_APPEND_FL | \
+	 FS_IMMUTABLE_FL | FS_DIRSYNC_FL)
+
 /**
  * ubifs_set_inode_flags - set VFS inode flags.
  * @inode: VFS inode to set flags for
@@ -166,6 +171,9 @@ long ubifs_ioctl(struct file *file, unsi
 		if (get_user(flags, (int __user *) arg))
 			return -EFAULT;
 
+		if (flags & ~UBIFS_SUPPORTED_IOCTL_FLAGS)
+			return -EOPNOTSUPP;
+
 		if (!S_ISDIR(inode->i_mode))
 			flags &= ~FS_DIRSYNC_FL;
 


