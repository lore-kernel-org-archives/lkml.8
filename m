Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A144120760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoK74LkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgFIQN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:13:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50658 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731093AbgFIQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPVVcRFgzz+szQgQMLyZwoek+uHNhgwrukerrAxYQdk=;
        b=GoK74LkCv7DrzfypbZEYSAwV3kWushThN1Tto0xPH7bklxFoTMxp+K0to6Tn2N4Jzs3OAT
        ocGjcZVCZqbcLUvVZbpro5l3DxS7dPdAET4tP/HNFYBvGEZqe1e0MC+04gAuuYl59sBDF2
        WRdnSqTzJ99zhzWjBHUShB1Gi8L4AsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-rbQADSm2NGKGPzs9WeSxVw-1; Tue, 09 Jun 2020 12:13:22 -0400
X-MC-Unique: rbQADSm2NGKGPzs9WeSxVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66911835B40;
        Tue,  9 Jun 2020 16:13:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 748BA6298C;
        Tue,  9 Jun 2020 16:13:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/6] afs: Fix file locking
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>,
        Dave Botsch <botsch@cnf.cornell.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:19 +0100
Message-ID: <159171919967.3038039.17802563446058952615.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix AFS file locking to use the correct vnode pointer and remove a member
of the afs_operation struct that is never set, but it is read and followed,
causing an oops.

This can be triggered by:

	flock -s /afs/example.com/foo sleep 1

when it calls the kernel to get a file lock.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Dave Botsch <botsch@cnf.cornell.edu>
---

 fs/afs/flock.c    |    2 +-
 fs/afs/internal.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 70e518f7bc19..71eea2a908c7 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -71,7 +71,7 @@ static void afs_schedule_lock_extension(struct afs_vnode *vnode)
 void afs_lock_op_done(struct afs_call *call)
 {
 	struct afs_operation *op = call->op;
-	struct afs_vnode *vnode = op->lock.lvnode;
+	struct afs_vnode *vnode = op->file[0].vnode;
 
 	if (call->error == 0) {
 		spin_lock(&vnode->lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e1621b0670cc..519ffb104616 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -795,7 +795,6 @@ struct afs_operation {
 			struct afs_read *req;
 		} fetch;
 		struct {
-			struct afs_vnode *lvnode;	/* vnode being locked */
 			afs_lock_type_t type;
 		} lock;
 		struct {


