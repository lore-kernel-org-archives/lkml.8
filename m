Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B50C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B9020885
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593128256;
	bh=XPRK0sq0Rv/u4HT/KZE++IRrJWscCGZFPdc0LLn7yJ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sg81Yt//Ogj1SkAV3KZkOGrbfKoaRhZuQiuR41rukJHh7xEDb6QGWTuJk7vMr4X2Q
	 s/xuCDwnNrWbAmNDvks5+ftpspmA1yRonFm3/2bgQqdMlVbN5x1oEwooiUj7FFET99
	 iohGN/2IXAN4pht3r8LxAFy/SGMMUkv1ujBcT358=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFYXhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgFYXhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:37:34 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008652084D;
        Thu, 25 Jun 2020 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593128253;
        bh=XPRK0sq0Rv/u4HT/KZE++IRrJWscCGZFPdc0LLn7yJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=H+OacQV4B6rSiPM6i7vxqwJNYLit5laXMLXIrKiutIqIgWiNcfJv9bDeME2SxDSKX
         65gr6qKqOguPP+HBR0Uzve0q0x7aYJWyqjfYNWzteAR9EjK21EuJixh4hDk/uQtw8E
         lakz1y711WfQxXekCriyRE8M23FYwtBi85CUizZs=
From:   Jeff Layton <jlayton@kernel.org>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
Subject: [PATCH v2] sync.2: syncfs() now returns errors if writeback fails
Date:   Thu, 25 Jun 2020 19:37:31 -0400
Message-Id: <20200625233731.61555-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch has been merged for v5.8 that changes how syncfs() reports
errors. Change the sync() manpage accordingly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/sync.2 | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

 v2: update the NOTES verbiage according to Eric's suggestion

diff --git a/man2/sync.2 b/man2/sync.2
index 7198f3311b05..61e994c5affc 100644
--- a/man2/sync.2
+++ b/man2/sync.2
@@ -86,11 +86,26 @@ to indicate the error.
 is always successful.
 .PP
 .BR syncfs ()
-can fail for at least the following reason:
+can fail for at least the following reasons:
 .TP
 .B EBADF
 .I fd
 is not a valid file descriptor.
+.TP
+.B EIO
+An error occurred during synchronization.
+This error may relate to data written to any file on the filesystem, or on
+metadata related to the filesytem itself.
+.TP
+.B ENOSPC
+Disk space was exhausted while synchronizing.
+.TP
+.BR ENOSPC ", " EDQUOT
+Data was written to a files on NFS or another filesystem which does not
+allocate space at the time of a
+.BR write (2)
+system call, and some previous write failed due to insufficient
+storage space.
 .SH VERSIONS
 .BR syncfs ()
 first appeared in Linux 2.6.39;
@@ -121,6 +136,13 @@ or
 .BR syncfs ()
 provide the same guarantees as fsync called on every file in
 the system or filesystem respectively.
+.PP
+In mainline kernel versions prior to 5.8,
+.\" commit 735e4ae5ba28c886d249ad04d3c8cc097dad6336
+.BR syncfs ()
+will only fail when passed a bad file descriptor (EBADF). In 5.8
+and later kernels, it will also report an error if one or more inodes failed
+to be written back since the last syncfs call.
 .SH BUGS
 Before version 1.3.20 Linux did not wait for I/O to complete
 before returning.
-- 
2.26.2

