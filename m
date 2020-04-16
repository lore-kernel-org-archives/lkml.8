Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7FAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C1521D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048107;
	bh=If3d0bFf0ABqG7dx9nfsBE7DqGX0DiVXtdEGTMR+un8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXNllkp9lIwV1fMtfLxy8OFBB9y7qVnoZZwvNoqN0NkFbskC62UT+wDBZhRdtcI5f
	 9AdFPY+woRof7l0mJtbulHXU15hcWdStEhcNxcKe81CZUvj6Rz+ZGtstECsCYdNvuX
	 H2E6Ed0KyoU287jHC6GQtGky/DChU0ZUmoQefWXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392741AbgDPOBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898143AbgDPNkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11102076D;
        Thu, 16 Apr 2020 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044437;
        bh=If3d0bFf0ABqG7dx9nfsBE7DqGX0DiVXtdEGTMR+un8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVdxwL2TV10vTk8W1QCXfO2wDHcX/1iJIgvGTVp7zDDRBv+D4kysQf7Ej2RRoxSXT
         VLZNHfhI1yy741clRLissR0Ix0aT/31wgP29DLrOk409YjrDmU+WCTmxL5Bk2j9mA4
         y+H0RUIF09L27z7Az4bWOtLUdNM67+ShuuXLr3i8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.5 218/257] NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
Date:   Thu, 16 Apr 2020 15:24:29 +0200
Message-Id: <20200416131353.238465268@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
@@ -441,6 +441,7 @@ nfs_destroy_unlinked_subrequests(struct
 		}
 
 		subreq->wb_head = subreq;
+		nfs_release_request(old_head);
 
 		if (test_and_clear_bit(PG_INODE_REF, &subreq->wb_flags)) {
 			nfs_release_request(subreq);


