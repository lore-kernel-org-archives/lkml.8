Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB3E20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521294;
	bh=/E1gjTXH8TUAn0tdJdqEaHfqZRnnrnwDEH0bruPbu3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CbGpKwN0go5ASG9sEDyw9/OFy9CmnhdgOWnwi7dfNeBZ2V5bxTf/HedGZXS4/RIJJ
	 54a48f9r0+7c17J1fPeG79gi8JP563Ir8RdBC4Dkk9Fz1MS6kigQcdjSxjzammi5Ks
	 XxpUL6DgXlU/EFwO2KV9te703R6mbTUmi334DPyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbgEZTDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391184AbgEZTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:03:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9A92086A;
        Tue, 26 May 2020 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519797;
        bh=/E1gjTXH8TUAn0tdJdqEaHfqZRnnrnwDEH0bruPbu3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTifHLpwbO1sz3bRV6+rPVUnIJnJgBX/g/QOE2ilaDQTxWhPAP0hZOMThedB6sobi
         UrP/14RRTtJMF9O9C50cD1NlpeOGheIHVUmSpiUIiYjTCZNmd+eyQgVldvsIpyvI7Y
         TXYdJV2hffCs4BgZaH6RZ9H9k6axKWAXNVL7An0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/81] configfs: fix config_item refcnt leak in configfs_rmdir()
Date:   Tue, 26 May 2020 20:52:56 +0200
Message-Id: <20200526183929.132351497@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 8aebfffacfa379ba400da573a5bf9e49634e38cb ]

configfs_rmdir() invokes configfs_get_config_item(), which returns a
reference of the specified config_item object to "parent_item" with
increased refcnt.

When configfs_rmdir() returns, local variable "parent_item" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
configfs_rmdir(). When down_write_killable() fails, the function forgets
to decrease the refcnt increased by configfs_get_config_item(), causing
a refcnt leak.

Fix this issue by calling config_item_put() when down_write_killable()
fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 2cc6b1c49d34..f9628fc20fec 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1537,6 +1537,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_lock(&configfs_dirent_lock);
 		configfs_detach_rollback(dentry);
 		spin_unlock(&configfs_dirent_lock);
+		config_item_put(parent_item);
 		return -EINTR;
 	}
 	frag->frag_dead = true;
-- 
2.25.1



