Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7BC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADE520775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550272;
	bh=N5J9ZYL1hq7IPOPZg5qQPF4MWiEvJy7wIJMDw9IxfVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OU8/EkICFSOPMGOfgFtxqm3apgjxHeRsBnce6RHG3w6TIeb7ukGDFmdFM71LXvqNs
	 lbrMezYuKMoHc0XzAqGkB38LYxcwPFhMJQZMr47oZVVwlfwkyaLYcpocwMHEuU209P
	 ngL/G6KVO1TL0cB8SVeVvGiK3eTQSu8Pk3ql1gqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgDVKLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgDVKLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A432075A;
        Wed, 22 Apr 2020 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550265;
        bh=N5J9ZYL1hq7IPOPZg5qQPF4MWiEvJy7wIJMDw9IxfVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3JqBX7zJ6PIn2x5uWmLdh4TloleuI/avZAVx5d6qhE5AXqsKvRsnahVy7RDMo17u
         Akg/X/2ND78qe7se5zEeArzRdF7f5psE5PbHQx32Aw/BcG/jU3/sRTWpg/cvU9e07A
         XgfoytA0Khl+sqJq+MO6vQt4ofCQEUwMWLT0lBqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.14 076/199] NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
Date:   Wed, 22 Apr 2020 11:56:42 +0200
Message-Id: <20200422095105.739175307@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit add42de31721fa29ed77a7ce388674d69f9d31a4 upstream.

When we detach a subrequest from the list, we must also release the
reference it holds to the parent.

Fixes: 5b2b5187fa85 ("NFS: Fix nfs_page_group_destroy() and nfs_lock_and_join_requests() race cases")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -422,6 +422,7 @@ nfs_destroy_unlinked_subrequests(struct
 		}
 
 		subreq->wb_head = subreq;
+		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
 			nfs_release_request(subreq);


