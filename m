Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D084CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9B2206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c09D4NeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFKUue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:50:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgFKUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591908629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WiqAKX8M8YviG7Tbo/GYvrzXUaaZrl2SYDgy+2zqrSA=;
        b=c09D4NeW9LYluLqx1+49DKvekcqRkkD1UFsJbSG/YFaVNiqdEr9H6B3d/ER8c+Gj6wMSsY
        oLw5uUhyGOgBu/761SmwOXS/rxwH62nEKzkrj2aQc4k+PEvict8qtMCaOs1sEykCleAxgp
        75t0H4CQNI9AtHUl9XqrijKtqQ9p904=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Wxgoyl3SPIi3Trf1vTxaBw-1; Thu, 11 Jun 2020 16:50:28 -0400
X-MC-Unique: Wxgoyl3SPIi3Trf1vTxaBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B711683DB79;
        Thu, 11 Jun 2020 20:50:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79E8F7B5FB;
        Thu, 11 Jun 2020 20:50:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_store_data() to set mtime in new operation
 descriptor
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Jun 2020 21:50:24 +0100
Message-ID: <159190862462.3556446.3460202501713546446.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_store_data() so that it sets the mtime in the new operation
descriptor otherwise the mtime on the server gets set to 0 when a write is
stored to the server.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 97bccde3298b..768497f82aee 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -447,6 +447,7 @@ static int afs_store_data(struct address_space *mapping,
 	op->store.last = last;
 	op->store.first_offset = offset;
 	op->store.last_to = to;
+	op->mtime = vnode->vfs_inode.i_mtime;
 	op->ops = &afs_store_data_operation;
 
 try_next_key:


