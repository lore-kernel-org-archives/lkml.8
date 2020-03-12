Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70151C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3874A205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZX+ugbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCLVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:37:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726481AbgCLVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584049019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=o0KJvs5Tn9ZRXYpDxYyGbc0Z0po25d7YTKzjpj8ERqU=;
        b=FZX+ugbjJawiEhRRXzI2Li4o6JzBGoME2HFLs44/JLQDvT/7ej89HWq/cOzcuLV0EGJ9Id
        ee4upRcBxbiUQZukVYfhI8TCjrK9iat/yzepEujtocnTNrW4UvPIfzrxZ23kyqMvoPNqJK
        50oda6hkUu/B4IwO8mZ/Umy10Kgam2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-jGvZjzwnPsqBl7sVisqPlA-1; Thu, 12 Mar 2020 17:36:57 -0400
X-MC-Unique: jGvZjzwnPsqBl7sVisqPlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03599107ACC9;
        Thu, 12 Mar 2020 21:36:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE89292D1C;
        Thu, 12 Mar 2020 21:36:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Use kfree_rcu() instead of casting kfree() to
 rcu_callback_t
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Jann Horn <jannh@google.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Mar 2020 21:36:53 +0000
Message-ID: <158404901390.1220563.13542240512778767032.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

afs_put_addrlist() casts kfree() to rcu_callback_t. Apart from being wrong
in theory, this might also blow up when people start enforcing function
types via compiler instrumentation, and it means the rcu_head has to be
first in struct afs_addr_list.

Use kfree_rcu() instead, it's simpler and more correct.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/addr_list.c |    2 +-
 fs/afs/internal.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index df415c05939e..de1ae0bead3b 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -19,7 +19,7 @@
 void afs_put_addrlist(struct afs_addr_list *alist)
 {
 	if (alist && refcount_dec_and_test(&alist->usage))
-		call_rcu(&alist->rcu, (rcu_callback_t)kfree);
+		kfree_rcu(alist, rcu);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1d81fc4c3058..35f951ac296f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -81,7 +81,7 @@ enum afs_call_state {
  * List of server addresses.
  */
 struct afs_addr_list {
-	struct rcu_head		rcu;		/* Must be first */
+	struct rcu_head		rcu;
 	refcount_t		usage;
 	u32			version;	/* Version */
 	unsigned char		max_addrs;


