Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AF220702
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222326;
	bh=erU36mSuWyFSClo7QW4jYPmaXV6VmAAt49OmgnJyu0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFKEpMN19L0egwt7yeReEUnnu6pIlenTTMteSCrSbk0MLZUUhcnhDu9CMguVM7FK5
	 Y2XPDz7lITjfSGWWy4vxHKlQTjO1a8+SzQhjrjyojp0hc0tlsPfcDfdwyEY8gLcN3b
	 YImde3LLyn88JHL0UPfnPTlvRzrrl0nk1ITz3deU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgA1Oip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbgA1OSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:18:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68AB21739;
        Tue, 28 Jan 2020 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221092;
        bh=erU36mSuWyFSClo7QW4jYPmaXV6VmAAt49OmgnJyu0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGPjj74uEN4Ox2P5gDfjg3nWCpZAqeeAp9yHxaVWWmvWRAdKf23bEMx4vi5sHp/b2
         WomrtCxxwJk3xrrxlaqAsnAbZA1/KN9cwKC5rMnRbnt1hlCgnpMgnnbkcvrIehcC8Y
         6E2t4FjXJoJsHv+bLnr6GWGQdJnoJrahRECLK4kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 086/271] NFS: Fix a soft lockup in the delegation recovery code
Date:   Tue, 28 Jan 2020 15:03:55 +0100
Message-Id: <20200128135858.977014036@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 6f9449be53f3ce383caed797708b332ede8d952c ]

Fix a soft lockup when NFS client delegation recovery is attempted
but the inode is in the process of being freed. When the
igrab(inode) call fails, and we have to restart the recovery process,
we need to ensure that we won't attempt to recover the same delegation
again.

Fixes: 45870d6909d5a ("NFSv4.1: Test delegation stateids when server...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 20 ++++++++++++--------
 fs/nfs/delegation.h |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 9a8830a0f31f9..014039618cff0 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -234,6 +234,8 @@ static struct inode *nfs_delegation_grab_inode(struct nfs_delegation *delegation
 	spin_lock(&delegation->lock);
 	if (delegation->inode != NULL)
 		inode = igrab(delegation->inode);
+	if (!inode)
+		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 	spin_unlock(&delegation->lock);
 	return inode;
 }
@@ -867,10 +869,11 @@ restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		list_for_each_entry_rcu(delegation, &server->delegations,
 								super_list) {
-			if (test_bit(NFS_DELEGATION_RETURNING,
-						&delegation->flags))
-				continue;
-			if (test_bit(NFS_DELEGATION_NEED_RECLAIM,
+			if (test_bit(NFS_DELEGATION_INODE_FREEING,
+						&delegation->flags) ||
+			    test_bit(NFS_DELEGATION_RETURNING,
+						&delegation->flags) ||
+			    test_bit(NFS_DELEGATION_NEED_RECLAIM,
 						&delegation->flags) == 0)
 				continue;
 			if (!nfs_sb_active(server->super))
@@ -975,10 +978,11 @@ restart:
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		list_for_each_entry_rcu(delegation, &server->delegations,
 								super_list) {
-			if (test_bit(NFS_DELEGATION_RETURNING,
-						&delegation->flags))
-				continue;
-			if (test_bit(NFS_DELEGATION_TEST_EXPIRED,
+			if (test_bit(NFS_DELEGATION_INODE_FREEING,
+						&delegation->flags) ||
+			    test_bit(NFS_DELEGATION_RETURNING,
+						&delegation->flags) ||
+			    test_bit(NFS_DELEGATION_TEST_EXPIRED,
 						&delegation->flags) == 0)
 				continue;
 			if (!nfs_sb_active(server->super))
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 2c6cb7fb7d5ee..f72095bf9e107 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -33,6 +33,7 @@ enum {
 	NFS_DELEGATION_RETURNING,
 	NFS_DELEGATION_REVOKED,
 	NFS_DELEGATION_TEST_EXPIRED,
+	NFS_DELEGATION_INODE_FREEING,
 };
 
 int nfs_inode_set_delegation(struct inode *inode, struct rpc_cred *cred, struct nfs_openres *res);
-- 
2.20.1



