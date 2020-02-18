Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1BC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF1F2464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056248;
	bh=q78o6HQ0yfZG7Zp7kLt0nFtwq1+DanlptBtvtQKA9rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/y6W+Iq97ndqCeDf3sVp5D1Rc8CGqADHLUSLfqTovo/4dNYj8QCsLKCzALvH4LT/
	 77LArDHxWb7AYjFrBaAf70Y2WpxzSbN7SUS6sUkARxvr75oo5YiL4nN9ZW/Ar67sWj
	 yU2+YdCtbJBA0l0Mlp6U7gZe4x6AqvHOAcgFWReQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgBRUD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgBRUDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:03:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5101D21D56;
        Tue, 18 Feb 2020 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056232;
        bh=q78o6HQ0yfZG7Zp7kLt0nFtwq1+DanlptBtvtQKA9rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IprRHr+ZWnnSutS8Jws/fVJW7hdHq4Z3JO7fz9x/d/TS+YZgQTjLHArg6b/HY5QJq
         y8jUhVnTguw8d/fK86mFyAPeBSXVwgbuc9/jFpehO8GOuZ3gqCoMA2wJEmQl+fesLq
         9iSIP12v9UpCDCUVNDKOqD6EzUxa/dZeQFxaO1Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 78/80] NFSv4: Add accounting for the number of active delegations held
Date:   Tue, 18 Feb 2020 20:55:39 +0100
Message-Id: <20200218190439.243798210@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

[ Upstream commit d2269ea14ebd2a73f291d6b3a7a7d320ec00270c ]

In order to better manage our delegation caching, add a counter
to track the number of active delegations.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 5f02d922f2173..8e322bacde699 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -25,13 +25,29 @@
 #include "internal.h"
 #include "nfs4trace.h"
 
-static void nfs_free_delegation(struct nfs_delegation *delegation)
+static atomic_long_t nfs_active_delegations;
+
+static void __nfs_free_delegation(struct nfs_delegation *delegation)
 {
 	put_cred(delegation->cred);
 	delegation->cred = NULL;
 	kfree_rcu(delegation, rcu);
 }
 
+static void nfs_mark_delegation_revoked(struct nfs_delegation *delegation)
+{
+	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
+		delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
+		atomic_long_dec(&nfs_active_delegations);
+	}
+}
+
+static void nfs_free_delegation(struct nfs_delegation *delegation)
+{
+	nfs_mark_delegation_revoked(delegation);
+	__nfs_free_delegation(delegation);
+}
+
 /**
  * nfs_mark_delegation_referenced - set delegation's REFERENCED flag
  * @delegation: delegation to process
@@ -348,7 +364,8 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
 		delegation->stateid.seqid = update->stateid.seqid;
 		smp_wmb();
 		delegation->type = update->type;
-		clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
+		if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
+			atomic_long_inc(&nfs_active_delegations);
 	}
 }
 
@@ -428,6 +445,8 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	rcu_assign_pointer(nfsi->delegation, delegation);
 	delegation = NULL;
 
+	atomic_long_inc(&nfs_active_delegations);
+
 	trace_nfs4_set_delegation(inode, type);
 
 	spin_lock(&inode->i_lock);
@@ -437,7 +456,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 out:
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
-		nfs_free_delegation(delegation);
+		__nfs_free_delegation(delegation);
 	if (freeme != NULL) {
 		nfs_do_return_delegation(inode, freeme, 0);
 		nfs_free_delegation(freeme);
@@ -765,13 +784,6 @@ static void nfs_client_mark_return_unused_delegation_types(struct nfs_client *cl
 	rcu_read_unlock();
 }
 
-static void nfs_mark_delegation_revoked(struct nfs_server *server,
-		struct nfs_delegation *delegation)
-{
-	set_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
-	delegation->stateid.type = NFS4_INVALID_STATEID_TYPE;
-}
-
 static void nfs_revoke_delegation(struct inode *inode,
 		const nfs4_stateid *stateid)
 {
@@ -799,7 +811,7 @@ static void nfs_revoke_delegation(struct inode *inode,
 		}
 		spin_unlock(&delegation->lock);
 	}
-	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
+	nfs_mark_delegation_revoked(delegation);
 	ret = true;
 out:
 	rcu_read_unlock();
@@ -838,7 +850,7 @@ void nfs_delegation_mark_returned(struct inode *inode,
 			delegation->stateid.seqid = stateid->seqid;
 	}
 
-	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
+	nfs_mark_delegation_revoked(delegation);
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
-- 
2.20.1



