Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C30821D93
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048203;
	bh=aXyg713goSut50aAPRDt+glXl7f7FgHlgg6iIC5gabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gbOCA71EyPrHArwMD7XW1kUiNrnskbKEBmMnn3lew3YeChjebJUOSdpzc4EyBdC2w
	 5+B8BVjnzuB4Y7teQaISDVJPKs6MN2RSUlnlFaFHZcfDD1LnIh3WM/goJrbEqWCVIp
	 xoqIkhnev0LvnkBMfRLHLr3+3I0ciTRRgqMoQmJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394514AbgDPOnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406892AbgDPOAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:00:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B1E2078B;
        Thu, 16 Apr 2020 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045635;
        bh=aXyg713goSut50aAPRDt+glXl7f7FgHlgg6iIC5gabo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=askwHgje06NOtU9d7xWfpEANBmiacB27CI2iEmB5BbLDjdH/vMehJ+ZnknGW14CJA
         C+UE55J+6oi/dZWHkKdfgQNwjDr1vK5Iofl9i3BBkZ+X4nd0pAEmrtKvarHhY2Ckk4
         hW0NLYfN6DO/EIB+TLfNP3nX8dCriyOEPuGeKhKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.6 214/254] NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
Date:   Thu, 16 Apr 2020 15:25:03 +0200
Message-Id: <20200416131352.796054881@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
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
@@ -444,6 +444,7 @@ nfs_destroy_unlinked_subrequests(struct
 		}
 
 		subreq->wb_head = subreq;
+		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
 			nfs_release_request(subreq);


