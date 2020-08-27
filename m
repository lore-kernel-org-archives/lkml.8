Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9424FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFBF2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze/678Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgH0PGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:06:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728054AbgH0PEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598540672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdm9WK0HbRbhxXWmnqqpGSJlMjLuGv5UGh3nDalBgjY=;
        b=Ze/678Ql+4ubiX98++HR5PokP7RHI8wYtS6H8LycocgVSrU/B0thxfrcisGNw+oHr8D2zV
        vfwHC+8nVlno613zkfqMWQdYJQ/A+1hRNHXgW+5ru7lEdxYjvpg0yg0qYjvPLIpJdqatuT
        bS+tnKh0jLlAcPhWWFstKq+GCg2d39s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Dx804broM5Gr4T0lqYMUzA-1; Thu, 27 Aug 2020 11:04:26 -0400
X-MC-Unique: Dx804broM5Gr4T0lqYMUzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F27B894C14;
        Thu, 27 Aug 2020 15:03:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57F075D9E8;
        Thu, 27 Aug 2020 15:03:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/7] rxrpc: Make rxrpc_kernel_get_srtt() indicate validity
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 16:03:54 +0100
Message-ID: <159854063448.1382667.12985881361440373925.stgit@warthog.procyon.org.uk>
In-Reply-To: <159854061331.1382667.9693163318506702951.stgit@warthog.procyon.org.uk>
References: <159854061331.1382667.9693163318506702951.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix rxrpc_kernel_get_srtt() to indicate the validity of the returned
smoothed RTT.  If we haven't had any valid samples yet, the SRTT isn't
useful.

Fixes: c410bf01933e ("rxrpc: Fix the excessive initial retransmission timeout")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c       |    4 ++--
 fs/afs/vl_probe.c       |    4 ++--
 include/net/af_rxrpc.h  |    2 +-
 net/rxrpc/peer_object.c |   16 +++++++++++++---
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 5d9ef517cf81..e7e98ad63a91 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -161,8 +161,8 @@ void afs_fileserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	rtt_us = rxrpc_kernel_get_srtt(call->net->socket, call->rxcall);
-	if (rtt_us < server->probe.rtt) {
+	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
+	    rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index e3aa013c2177..081b7e5b13f5 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -92,8 +92,8 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	rtt_us = rxrpc_kernel_get_srtt(call->net->socket, call->rxcall);
-	if (rtt_us < server->probe.rtt) {
+	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
+	    rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		alist->preferred = index;
 		have_result = true;
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 91eacbdcf33d..f6abcc0bbd6e 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -59,7 +59,7 @@ bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
 void rxrpc_kernel_end_call(struct socket *, struct rxrpc_call *);
 void rxrpc_kernel_get_peer(struct socket *, struct rxrpc_call *,
 			   struct sockaddr_rxrpc *);
-u32 rxrpc_kernel_get_srtt(struct socket *, struct rxrpc_call *);
+bool rxrpc_kernel_get_srtt(struct socket *, struct rxrpc_call *, u32 *);
 int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
 			       unsigned int);
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index ca29976bb193..68396d052052 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -502,11 +502,21 @@ EXPORT_SYMBOL(rxrpc_kernel_get_peer);
  * rxrpc_kernel_get_srtt - Get a call's peer smoothed RTT
  * @sock: The socket on which the call is in progress.
  * @call: The call to query
+ * @_srtt: Where to store the SRTT value.
  *
- * Get the call's peer smoothed RTT.
+ * Get the call's peer smoothed RTT in uS.
  */
-u32 rxrpc_kernel_get_srtt(struct socket *sock, struct rxrpc_call *call)
+bool rxrpc_kernel_get_srtt(struct socket *sock, struct rxrpc_call *call,
+			   u32 *_srtt)
 {
-	return call->peer->srtt_us >> 3;
+	struct rxrpc_peer *peer = call->peer;
+
+	if (peer->rtt_count == 0) {
+		*_srtt = 1000000; /* 1S */
+		return false;
+	}
+
+	*_srtt = call->peer->srtt_us >> 3;
+	return true;
 }
 EXPORT_SYMBOL(rxrpc_kernel_get_srtt);


