Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F33C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CF92177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258367;
	bh=egZLI8/fjbloY10GvOwkNn+G+wjq30tevwSRbwaKQQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDalec/kAkRtXZPfKlr854wO6CLvCYgivEYh6g1VmUl/6koJiR+q0SUe85zMsDCJV
	 RqJSFA0DRbRwCHRgvV5DdqQ139b11tpvwNvMEDeRSHUTU8Gb1TYEe/ZyWWDxW0QhWS
	 TYQmervMlUpy3CcJETvw4ZxZEmHdMtEq2vaEALg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHXIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgHXIjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F6320FC3;
        Mon, 24 Aug 2020 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258355;
        bh=egZLI8/fjbloY10GvOwkNn+G+wjq30tevwSRbwaKQQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOo/QZbaZ9pi8egsbptWDXZkGKEc7oY5jygK84k5qDTQ9BK0lDYm+H5if8bd1fmN0
         cEHTP0UpMAx8YgEGQic/PLQiQ3yZ7DdtoMOWY1DsHd8ME55GCOvjLPcGukkHyUaBgA
         0M7Ch6BD97NWMwachrOO+VLQqndqtQS3N0+6L/MU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, stable@kernel.org,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.7 019/124] jbd2: add the missing unlock_buffer() in the error path of jbd2_write_superblock()
Date:   Mon, 24 Aug 2020 10:29:13 +0200
Message-Id: <20200824082410.364588958@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangyi (F) <yi.zhang@huawei.com>

commit ef3f5830b859604eda8723c26d90ab23edc027a4 upstream.

jbd2_write_superblock() is under the buffer lock of journal superblock
before ending that superblock write, so add a missing unlock_buffer() in
in the error path before submitting buffer.

Fixes: 742b06b5628f ("jbd2: check superblock mapped prior to committing")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20200620061948.2049579-1-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/journal.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1367,8 +1367,10 @@ static int jbd2_write_superblock(journal
 	int ret;
 
 	/* Buffer got discarded which means block device got invalidated */
-	if (!buffer_mapped(bh))
+	if (!buffer_mapped(bh)) {
+		unlock_buffer(bh);
 		return -EIO;
+	}
 
 	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))


