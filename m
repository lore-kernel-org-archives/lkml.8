Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE990C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858B3214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0j1yzIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBFN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:57:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727549AbgBFN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580997467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tNitUKzW+cLVaYZXngjqBsDD3mUQWjU26WqjKMzRiTQ=;
        b=U0j1yzIT32XTRVEKHjdsuZIrXcVJSN6wgQOheOpxz5gUpkt8ZJLrKqjWWlAMxsv/925+UY
        cdG7p0L6J9xJgldoP/TCeJdFZaInQFK+K0R29MU+hnd91yknT1LJYSM5Ow9X5ubrpt8+T9
        2PHiH9IxK+krWPPfenPLLXwGoPQ9tgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-igue8FV3Owm0OYEOZdQa3g-1; Thu, 06 Feb 2020 08:57:44 -0500
X-MC-Unique: igue8FV3Owm0OYEOZdQa3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12D5A8010E6;
        Thu,  6 Feb 2020 13:57:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A83183B3;
        Thu,  6 Feb 2020 13:57:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix call RCU cleanup using non-bh-safe locks
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Feb 2020 13:57:40 +0000
Message-ID: <158099746025.2198892.1158535190228552910.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_rcu_destroy_call(), which is called as an RCU callback to clean up a
put call, calls rxrpc_put_connection() which, deep in its bowels, takes a
number of spinlocks in a non-BH-safe way, including rxrpc_conn_id_lock and
local->client_conns_lock.  RCU callbacks, however, are normally called from
softirq context, which can cause lockdep to notice the locking
inconsistency.

To get lockdep to detect this, it's necessary to have the connection
cleaned up on the put at the end of the last of its calls, though normally
the clean up is deferred.  This can be induced, however, by starting a call
on an AF_RXRPC socket and then closing the socket without reading the
reply.

Fix this by having rxrpc_rcu_destroy_call() punt the destruction to a
workqueue if in softirq-mode and defer the destruction to process context.

Note that another way to fix this could be to add a bunch of bh-disable
annotations to the spinlocks concerned - and there might be more than just
those two - but that means spending more time with BHs disabled.

Note also that some of these places were covered by bh-disable spinlocks
belonging to the rxrpc_transport object, but these got removed without the
_bh annotation being retained on the next lock in.

Fixes: 999b69f89241 ("rxrpc: Kill the client connection bundle concept")
Reported-by: syzbot+d82f3ac8d87e7ccbb2c9@syzkaller.appspotmail.com
Reported-by: syzbot+3f1fd6b8cbf8702d134e@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Hillf Danton <hdanton@sina.com>
---

 net/rxrpc/call_object.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index dbdbc4f18b5e..c9f34b0a11df 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -562,11 +562,11 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace op)
 }
 
 /*
- * Final call destruction under RCU.
+ * Final call destruction - but must be done in process context.
  */
-static void rxrpc_rcu_destroy_call(struct rcu_head *rcu)
+static void rxrpc_destroy_call(struct work_struct *work)
 {
-	struct rxrpc_call *call = container_of(rcu, struct rxrpc_call, rcu);
+	struct rxrpc_call *call = container_of(work, struct rxrpc_call, processor);
 	struct rxrpc_net *rxnet = call->rxnet;
 
 	rxrpc_put_connection(call->conn);
@@ -578,6 +578,22 @@ static void rxrpc_rcu_destroy_call(struct rcu_head *rcu)
 		wake_up_var(&rxnet->nr_calls);
 }
 
+/*
+ * Final call destruction under RCU.
+ */
+static void rxrpc_rcu_destroy_call(struct rcu_head *rcu)
+{
+	struct rxrpc_call *call = container_of(rcu, struct rxrpc_call, rcu);
+
+	if (in_softirq()) {
+		INIT_WORK(&call->processor, rxrpc_destroy_call);
+		if (!rxrpc_queue_work(&call->processor))
+			BUG();
+	} else {
+		rxrpc_destroy_call(&call->processor);
+	}
+}
+
 /*
  * clean up a call
  */


