Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8FFC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1D6246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273491;
	bh=na6MCkvM/gU1JTmFSKwL58UmWb1R7nW/sp5fjyKvY64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SZdNarV+ny7BELPbTgXauGSbjDYR6htn/UeW82VWVdFrQ/nvq4XrAfEquUcM6H9nN
	 q8GK+q/7YW4Be9W1L/RhW/Swa6CfZc1OqtFRYkZkVeCVw2ZveGtiectDUcT8q95Pr5
	 pkxbXkcH/P+a36gnM4bH4Y2MqdQjl8/VFX1jzWFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgBUIYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732929AbgBUIYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:24:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903B7246A9;
        Fri, 21 Feb 2020 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273479;
        bh=na6MCkvM/gU1JTmFSKwL58UmWb1R7nW/sp5fjyKvY64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlangvg/o+TzOpJlbsG5HJ4+KYfNunkYkewad0rWPqt66Z/hw8sFmFK9CQ5lyFypm
         ZX0nmbyyJpmEJX0znu9MFlXzhV0XJnkPeKqnv8aoklNP9+MQXxOCIoE0z257nqBokF
         6oz/7RkKvJJCOa/aWjSb+vnAgEpBo1L2UabU4i/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/191] NFS: Fix memory leaks
Date:   Fri, 21 Feb 2020 08:42:39 +0100
Message-Id: <20200221072313.109685050@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 123c23c6a7b7ecd2a3d6060bea1d94019f71fd66 ]

In _nfs42_proc_copy(), 'res->commit_res.verf' is allocated through
kzalloc() if 'args->sync' is true. In the following code, if
'res->synchronous' is false, handle_async_copy() will be invoked. If an
error occurs during the invocation, the following code will not be executed
and the error will be returned . However, the allocated
'res->commit_res.verf' is not deallocated, leading to a memory leak. This
is also true if the invocation of process_copy_commit() returns an error.

To fix the above leaks, redirect the execution to the 'out' label if an
error is encountered.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 94f98e190e632..526441de89c1d 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -283,14 +283,14 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		status = handle_async_copy(res, server, src, dst,
 				&args->src_stateid);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	if ((!res->synchronous || !args->sync) &&
 			res->write_res.verifier.committed != NFS_FILE_SYNC) {
 		status = process_copy_commit(dst, pos_dst, res);
 		if (status)
-			return status;
+			goto out;
 	}
 
 	truncate_pagecache_range(dst_inode, pos_dst,
-- 
2.20.1



