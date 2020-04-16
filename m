Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9CEC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37832221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044284;
	bh=wPHOVAT1nWAxAKObuRYdWZJIJmnR133/qj0QvNNtEyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHMAydQMrMYLm4++W8HY1EZFvylf7MKvz8tmf5MIflxYdkPfvcIQ73S8uexzKu4Ga
	 nslwyN2cqH7S/iHdtCIXjexaQZKLtGQa4k9aefeFHGD3N3JDZbvzqueRdt9hMz12Yt
	 pi64r9NmNZ4gt6+aitW3wRBmGCUtmb2G4GwacIcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897615AbgDPNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895456AbgDPNaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:30:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8467B221F4;
        Thu, 16 Apr 2020 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043815;
        bh=wPHOVAT1nWAxAKObuRYdWZJIJmnR133/qj0QvNNtEyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmlf3PWohuQCcRwJKamWrSljC7OEaiI4W6lrpBlCDjVlTzzjGtPlu/plp+RdqHwlW
         3f45ib3I6mfe/OjUKsc8W0mS3+TCu3u20h8utKamial5jwpx6Wsx/jXZ6XDstmteiV
         Ts8w7OeOLkX6V2/oGC3uHkfPCdA6Yjk9pyN4Ghw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 110/146] NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
Date:   Thu, 16 Apr 2020 15:24:11 +0200
Message-Id: <20200416131257.704261675@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
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
@@ -432,6 +432,7 @@ nfs_destroy_unlinked_subrequests(struct
 		}
 
 		subreq->wb_head = subreq;
+		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
 			nfs_release_request(subreq);


