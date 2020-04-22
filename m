Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87327C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9242070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550743;
	bh=euQa/IrC+M5frlOR1iG3WPuzEiQuZ/BuYmF5XaRlhqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hlJDWb3fOwjwsJwSSPuvB+jNnaE2Ul6kWQVHpKQLTkYv2y82+pe8KpavIrJWh3mn7
	 ae4VfJdQHWGB+BzveOsOnOS83ywi4kb393kZ5vY5PCs6mu2YBGCXOnCa2CrtBIVAqC
	 X/heXT044N0QR+HbKYNp6qqWzmSuQXRxxiWentkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgDVKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgDVKSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD412070B;
        Wed, 22 Apr 2020 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550682;
        bh=euQa/IrC+M5frlOR1iG3WPuzEiQuZ/BuYmF5XaRlhqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDB2UAp0i7Qy2IZ/Wft+v+hLFD/0S55WO5ochjy9Ulg1SQR9XXE+xNbR/oWfeeeWF
         85Hx3wqC/lZn/dU6VZ2yLq3U5j7ImgOAhkyMWXNGGA7QNdDWbAgOktVFfHWGhsX9Kd
         DUYFpEcBNpX50Iawf29+BlvKgdBz8rB0MmLz4kFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/118] NFSv4/pnfs: Return valid stateids in nfs_layout_find_inode_by_stateid()
Date:   Wed, 22 Apr 2020 11:56:52 +0200
Message-Id: <20200422095040.410692868@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit d911c57a19551c6bef116a3b55c6b089901aacb0 ]

Make sure to test the stateid for validity so that we catch instances
where the server may have been reusing stateids in
nfs_layout_find_inode_by_stateid().

Fixes: 7b410d9ce460 ("pNFS: Delay getting the layout header in CB_LAYOUTRECALL handlers")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index f39924ba050b1..fc775b0b5194f 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -130,6 +130,8 @@ static struct inode *nfs_layout_find_inode_by_stateid(struct nfs_client *clp,
 
 	list_for_each_entry_rcu(server, &clp->cl_superblocks, client_link) {
 		list_for_each_entry(lo, &server->layouts, plh_layouts) {
+			if (!pnfs_layout_is_valid(lo))
+				continue;
 			if (stateid != NULL &&
 			    !nfs4_stateid_match_other(stateid, &lo->plh_stateid))
 				continue;
-- 
2.20.1



