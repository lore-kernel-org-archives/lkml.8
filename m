Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1678220706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENUMnGW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404714AbgFXQAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:00:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404647AbgFXQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593014431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kdnyTnxVnkPT//BmZpUifF3vPn430L7/1dAjHHZhWZg=;
        b=ENUMnGW9dZyI1QX3w0P/DD1wlaHCU6x3/y0kjZTY4jiyzwO526aI4m1D6QvTZVoOcC/Pp3
        wVbrVnt9uuxnUMsbKnfBiyj7+5WQLteYCFer0lTOVWE6eDrYhpemlF2oosElc0d4dz6Sv2
        ADxQqVtRadFFKIi5NpsJ2nSOUlTnNqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-1OUjAlkjN5-ADDM06uXK2Q-1; Wed, 24 Jun 2020 12:00:28 -0400
X-MC-Unique: 1OUjAlkjN5-ADDM06uXK2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD7F618585A0;
        Wed, 24 Jun 2020 16:00:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF902B471;
        Wed, 24 Jun 2020 16:00:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix storage of cell names
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Colin Ian King <colin.king@canonical.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Jun 2020 17:00:24 +0100
Message-ID: <159301442487.3143734.7373031577179431362.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cell name stored in the afs_cell struct is a 64-char + NUL buffer -
when it needs to be able to handle up to AFS_MAXCELLNAME (256 chars) + NUL.

Fix this by changing the array to a pointer and allocating the string.

Found using Coverity.

Fixes: 989782dcdc91 ("afs: Overhaul cell database management")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c     |    9 +++++++++
 fs/afs/internal.h |    2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 0d25565a2e37..1cdabbdeeb2c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -154,10 +154,17 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	cell->name = kmalloc(namelen + 1, GFP_KERNEL);
+	if (!cell->name) {
+		kfree(cell);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	cell->net = net;
 	cell->name_len = namelen;
 	for (i = 0; i < namelen; i++)
 		cell->name[i] = tolower(name[i]);
+	cell->name[i] = 0;
 
 	atomic_set(&cell->usage, 2);
 	INIT_WORK(&cell->manager, afs_manage_cell);
@@ -207,6 +214,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	if (ret == -EINVAL)
 		printk(KERN_ERR "kAFS: bad VL server IP address\n");
 error:
+	kfree(cell->name);
 	kfree(cell);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
@@ -489,6 +497,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(cell->net, rcu_access_pointer(cell->vl_servers));
 	afs_put_cell(cell->net, cell->alias_of);
 	key_put(cell->anonymous_key);
+	kfree(cell->name);
 	kfree(cell);
 
 	_leave(" [destroyed]");
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5892605b1a44..bf26fd28ccbd 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -390,7 +390,7 @@ struct afs_cell {
 	struct afs_vlserver_list __rcu *vl_servers;
 
 	u8			name_len;	/* Length of name */
-	char			name[64 + 1];	/* Cell name, case-flattened and NUL-padded */
+	char			*name;		/* Cell name, case-flattened and NUL-padded */
 };
 
 /*


