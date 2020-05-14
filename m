Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0092E2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482419;
	bh=dmKkOEPjX4LthcX5VeXmmzZybGQIaDpfw/FE7fFRzuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdZQW342hmZdOFzBDhokXfrXWrDbzEL3plAPZIWc3+pf7jEItEe6MwyMK3tpeVv4T
	 R2cr1kDgrDLJKGUQqrFi+g9YcX714wevf/KNLNVlB79EE/ZcrnISQQndbnz9S6jIgz
	 3S4Q9t5O7+vUCGI/ujYgsuWSZBiHBnFcbHQy5uWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgENSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgENSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4186206DC;
        Thu, 14 May 2020 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482405;
        bh=dmKkOEPjX4LthcX5VeXmmzZybGQIaDpfw/FE7fFRzuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NptH02gecPG2PWCHCq541W5sMGq4lDJ0a6CRD6FQazmQ8v1M05h6hVVRs52ojdyS+
         T1uFv8w0eEJmKpZDCwhZqF2IyiEtv6jooTiliUWrhN3OzaA724ZJ0KqxRliW/1EeHT
         v+109oZKuyHguP+lD9YHV8xerjpEkvcwmK3NHzTw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 11/49] configfs: fix config_item refcnt leak in configfs_rmdir()
Date:   Thu, 14 May 2020 14:52:32 -0400
Message-Id: <20200514185311.20294-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cf7b7e1d5bd72..cb733652ecca6 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1519,6 +1519,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_lock(&configfs_dirent_lock);
 		configfs_detach_rollback(dentry);
 		spin_unlock(&configfs_dirent_lock);
+		config_item_put(parent_item);
 		return -EINTR;
 	}
 	frag->frag_dead = true;
-- 
2.20.1

