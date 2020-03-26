Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F65AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB3320748
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRmLOlrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgCZPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:24:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20293 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgCZPYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585236257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YdGaHErKXgEwjwVvT/7qOUW9k9MHjlnqc5eXCmmHhD0=;
        b=gRmLOlrAOjF6bI8BYYBVUfyYsqT4R6frWAgaGVYf4S6KRHS4eVGPpvkI61AqlcRfG50WKX
        XV3Xj3k5XrR4/VuTZinTzEWpo8nXfZ4qv09A/w2XmWJp3oFm+Gd24cbEf4QQDrxsmAFnx2
        qKKeqof4cNYazsCenxbIaaMGgrLU8P4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-bks26o97PL-5hfP-8EpW8Q-1; Thu, 26 Mar 2020 11:24:10 -0400
X-MC-Unique: bks26o97PL-5hfP-8EpW8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47770800D48;
        Thu, 26 Mar 2020 15:24:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1BE5DA7B;
        Thu, 26 Mar 2020 15:24:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix unpinned address list during probing
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:24:07 +0000
Message-ID: <158523624758.896230.14212353217852133608.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When it's probing all of a fileserver's interfaces to find which one is
best to use, afs_do_probe_fileserver() takes a lock on the server record
and notes the pointer to the address list.  It doesn't, however, pin the
address list, so as soon as it drops the lock, there's nothing to stop the
address list from being freed under us.

Fix this by taking a ref on the address list inside the locked section and
dropping it at the end of the function.

Fixes: 3bf0fb6f33dd ("afs: Probe multiple fileservers simultaneously")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 fs/afs/fs_probe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index cfe62b154f68..e1b9ed679045 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -145,6 +145,7 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 	read_lock(&server->fs_lock);
 	ac.alist = rcu_dereference_protected(server->addresses,
 					     lockdep_is_held(&server->fs_lock));
+	afs_get_addrlist(ac.alist);
 	read_unlock(&server->fs_lock);
 
 	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
@@ -163,6 +164,7 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 
 	if (!in_progress)
 		afs_fs_probe_done(server);
+	afs_put_addrlist(ac.alist);
 	return in_progress;
 }
 


