Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4088A206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DU6VdXVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgHKCSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKCSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:18:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Du/q5LRry+qwFWg6D6J8n4Tp2lbFgXQBONbvdq1RoxI=; b=DU6VdXVNYZ6+poWCe2ftF7+x8H
        Ey7kVel5MfLktVad/pRiJMx/jGRB+gMTi72Ivuor5BsMxMXpv4SWEFpkM5+/3/e/LLoDCcAMjZpQv
        uBCgLBaPozqoo5QkGAef1fw/WTWfzXtD9HkbG8QMckOqqY7NKaszJR9jK3cpjw4/36GpOyo+2ePgF
        eQGXUDnnB7rSF84RDy4rsY1dnhlxDIADwM9cN+r8gGzXWm1Yq2/SvcGrS1FL19DWojLvVwCS6dHpZ
        VF/0v3DQ8GkQbrf1sz4DJZNjiZDU3ONSGfkjRi0ZDor3ROhjn/kJBx/3aPg5Au3VMLrtUPXuKsX25
        1ANR2K5g==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Jrb-0006nt-T6; Tue, 11 Aug 2020 02:18:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH] fs: afs: delete repeated words in comments
Date:   Mon, 10 Aug 2020 19:18:01 -0700
Message-Id: <20200811021801.24930-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words {the, consider} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
---
 fs/afs/flock.c  |    2 +-
 fs/afs/rotate.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/afs/flock.c
+++ linux-next-20200807/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_v
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
--- linux-next-20200807.orig/fs/afs/rotate.c
+++ linux-next-20200807/fs/afs/rotate.c
@@ -236,7 +236,7 @@ bool afs_select_fileserver(struct afs_op
 
 		case VMOVED:
 			/* The volume migrated to another server.  We consider
-			 * consider all locks and callbacks broken and request
+			 * all locks and callbacks broken and request
 			 * an update from the VLDB.
 			 *
 			 * We also limit the number of VMOVED hops we will
