Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA433C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B45F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552928;
	bh=mIVHQ0uSnkMp/t2dweUoji1QdAwBFsjSYmZqiOKQEuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZLmWaCvzqRJoFNsnmmoau8B43VXyjMHbrKbvLe5gWci5NNzbCiAJVNatrK1gZ+P9m
	 JQwRCY2W1rCybccplnbDUTMtaF0QRaqt9xIAG8UGf64uTbo+UzevLf30Ap1OxLb0de
	 zUvwi1lbdlbfgpQq/RdAuLF7wcX9fp6D7nK5Cb4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDVKHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbgDVKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E16B20575;
        Wed, 22 Apr 2020 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550013;
        bh=mIVHQ0uSnkMp/t2dweUoji1QdAwBFsjSYmZqiOKQEuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFqXqrA7NNC7JCHZayY72hEe86IIrgY35kVDqN2nrYiwuto2FsR7G6G2i/1KFzFo1
         tzKXvpIuI24uQEq3PLhLux0nt6mJMGVTScK7rC/DRMRdkWRBS3TODuuoNfXl8XUPew
         vLSg8USPOyRM9aiS9c8udPUDTkvAW+gfNX1GHvns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Gander <simon@tuxera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 056/125] hfsplus: fix crash and filesystem corruption when deleting files
Date:   Wed, 22 Apr 2020 11:56:13 +0200
Message-Id: <20200422095042.513899889@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Gander <simon@tuxera.com>

commit 25efb2ffdf991177e740b2f63e92b4ec7d310a92 upstream.

When removing files containing extended attributes, the hfsplus driver may
remove the wrong entries from the attributes b-tree, causing major
filesystem damage and in some cases even kernel crashes.

To remove a file, all its extended attributes have to be removed as well.
The driver does this by looking up all keys in the attributes b-tree with
the cnid of the file.  Each of these entries then gets deleted using the
key used for searching, which doesn't contain the attribute's name when it
should.  Since the key doesn't contain the name, the deletion routine will
not find the correct entry and instead remove the one in front of it.  If
parent nodes have to be modified, these become corrupt as well.  This
causes invalid links and unsorted entries that not even macOS's fsck_hfs
is able to fix.

To fix this, modify the search key before an entry is deleted from the
attributes b-tree by copying the found entry's key into the search key,
therefore ensuring that the correct entry gets removed from the tree.

Signed-off-by: Simon Gander <simon@tuxera.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200327155541.1521-1-simon@tuxera.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hfsplus/attributes.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -291,6 +291,10 @@ static int __hfsplus_delete_attr(struct
 		return -ENOENT;
 	}
 
+	/* Avoid btree corruption */
+	hfs_bnode_read(fd->bnode, fd->search_key,
+			fd->keyoffset, fd->keylength);
+
 	err = hfs_brec_remove(fd);
 	if (err)
 		return err;


