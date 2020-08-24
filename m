Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF461C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BF022B49
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258326;
	bh=QNFI7UwkzHpeEeP4WV7EBOwHIbcHMhRpqohCeXwFHBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IO0nPYktHmDppINZf8cHM6bj2WwCx34KPeg/NG5Hog3LlaGc1ocWR+FGxVz4rjZXZ
	 /zc1Lt+4Wx81JhmK6vrUfLSkqyZARRylAI5J9dfXjK/Ym5X2br/ZA+1LBb4avJ4opY
	 7XrfIoAuQd+8VZ+TaDxm16cRPlQB72IqZ2cYFSyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHXIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgHXIif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039F42177B;
        Mon, 24 Aug 2020 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258315;
        bh=QNFI7UwkzHpeEeP4WV7EBOwHIbcHMhRpqohCeXwFHBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBuxz3HGhUy90yqWg0YnwqPCGtxMp2LTNmoxDEncKQShoJ+4fwVef4uUxw35PrILV
         9zWIFI/p4UVKkR0GLxTS2D8ROVCBryBMCGGfBaouZLnFbqWPzGhlwrPLa8+yCAJ2aj
         yuvED2jFZcxcln29+opnVkIFW0N7bBZY6lhBfFbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Botsch <botsch@cnf.cornell.edu>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 124/148] afs: Fix key ref leak in afs_put_operation()
Date:   Mon, 24 Aug 2020 10:30:22 +0200
Message-Id: <20200824082419.953664165@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit ba8e42077bbe046a09bdb965dbfbf8c27594fe8f ]

The afs_put_operation() function needs to put the reference to the key
that's authenticating the operation.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/fs_operation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 24fd163c6323e..97cab12b0a6c2 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -235,6 +235,7 @@ int afs_put_operation(struct afs_operation *op)
 	afs_end_cursor(&op->ac);
 	afs_put_serverlist(op->net, op->server_list);
 	afs_put_volume(op->net, op->volume, afs_volume_trace_put_put_op);
+	key_put(op->key);
 	kfree(op);
 	return ret;
 }
-- 
2.25.1



