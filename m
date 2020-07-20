Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC912065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261626;
	bh=hRF5xXYQb2JblcGP2n9ndxkhrq+atP2E9XBJF5Slttc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=00vaWKmVmtCR4JO/PY7OPFlCGV2+Wc/oGGLJ1MUBFMM4xQzvjb/0V90CT5ixS0NuS
	 BVjCHcsFXggwjxuQBFYfi98a2mftUXUohaFFw9zTCojrthSow00FXmkWr3HRGivpAC
	 wcMGDorV02pOJmjZHkVv+rM8qvpr3U5/GfsjzSgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbgGTQNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbgGTQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:13:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37BA120734;
        Mon, 20 Jul 2020 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261619;
        bh=hRF5xXYQb2JblcGP2n9ndxkhrq+atP2E9XBJF5Slttc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs7HX4Af+pBmUgtgo+lTTGDoewf0yUX8KYrvKw4uzj91QKlBI5fGkYLeimdCg329H
         biZ1XE7xs1wJ31FjnlKHcYI9D912b/KzeI8DQH4b8Eo+QNddh12zi3EHxq2O1rINFY
         QrCLxCV3yPBz4+THGlecoxLRgxuZ1t6DqCEGS8qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Priebe <s.priebe@profihost.ag>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.7 182/244] fuse: ignore data argument of mount(..., MS_REMOUNT)
Date:   Mon, 20 Jul 2020 17:37:33 +0200
Message-Id: <20200720152834.497235240@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit e8b20a474cf2c42698d1942f939ff2128819f151 upstream.

The command

  mount -o remount -o unknownoption /mnt/fuse

succeeds on kernel versions prior to v5.4 and fails on kernel version at or
after.  This is because fuse_parse_param() rejects any unrecognised options
in case of FS_CONTEXT_FOR_RECONFIGURE, just as for FS_CONTEXT_FOR_MOUNT.

This causes a regression in case the fuse filesystem is in fstab, since
remount sends all options found there to the kernel; even ones that are
meant for the initial mount and are consumed by the userspace fuse server.

Fix this by ignoring mount options, just as fuse_remount_fs() did prior to
the conversion to the new API.

Reported-by: Stefan Priebe <s.priebe@profihost.ag>
Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: <stable@vger.kernel.org> # v5.4
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -468,6 +468,13 @@ static int fuse_parse_param(struct fs_co
 	struct fuse_fs_context *ctx = fc->fs_private;
 	int opt;
 
+	/*
+	 * Ignore options coming from mount(MS_REMOUNT) for backward
+	 * compatibility.
+	 */
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return 0;
+
 	opt = fs_parse(fc, fuse_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;


