Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A172C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C862053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944984;
	bh=EEWGFIUWt643IFNaKOFYAZVIQZJxmAKypLrHFL18Eb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2r08Fy1dcv+WL6Gh3ZWOENhYWouuMrCkO6+5g5acQfgxSv6BevZSt6DusMHDFTz7w
	 8MiG/qBqtJQJJ4cpZf4MwbEDOFGn9qzBd64ka5IzdmB2O5FKJXfEJb7mkW7AjiZcly
	 5liD0ZptKYDR9agmUpFjNWZWE9xYhEdQesg93W+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbgFWUnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392465AbgFWUm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E362070E;
        Tue, 23 Jun 2020 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944977;
        bh=EEWGFIUWt643IFNaKOFYAZVIQZJxmAKypLrHFL18Eb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2XAYjqbvoZvffQMIYKhavZ8RJDoiJYlDv2iW8dfttcjiIQYHxFZYIQ0ePjsccKbN
         32mdYr3QNpsS0yq+apwsKz9cH2W29ZTuj5ZOMIdqsaDcwY65v4s09aN9ZN1XpYqIpD
         8HRO4VKqkeCm482zlMb00lIbD4KGXHnFBuT9sYPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 168/206] afs: Fix non-setting of mtime when writing into mmap
Date:   Tue, 23 Jun 2020 21:58:16 +0200
Message-Id: <20200623195325.281409856@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit bb413489288e4e457353bac513fddb6330d245ca ]

The mtime on an inode needs to be updated when a write is made into an
mmap'ed section.  There are three ways in which this could be done: update
it when page_mkwrite is called, update it when a page is changed from dirty
to writeback or leave it to the server and fix the mtime up from the reply
to the StoreData RPC.

Found with the generic/215 xfstest.

Fixes: 1cf7a1518aef ("afs: Implement shared-writeable mmap")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e00461a6de9aa..53f329f61cc37 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -792,6 +792,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 			     vmf->page->index, priv);
 	SetPagePrivate(vmf->page);
 	set_page_private(vmf->page, priv);
+	file_update_time(file);
 
 	sb_end_pagefault(inode->i_sb);
 	return VM_FAULT_LOCKED;
-- 
2.25.1



