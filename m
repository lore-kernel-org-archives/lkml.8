Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB32C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39B72080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ipts9aI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBCKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:31:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgBCKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580725858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCLKGSqMaV4qZrcygd/MqiNrWGKg5U4tuMzI7W//FPE=;
        b=Ipts9aI/3qfWAJ8uwxjkj2JRUjcrWDPu6mJ14IRr6aUNPAC5/PGioonSLP1e8PHKXpMaVz
        5ECAfGhHR4QeESHbiTEI2P8l+7eulLULU9Vjoh6N1SvzbrebhQQjAKGACj8BBGMLfMh/4Z
        BVeKlmQpQ5FBDX5SxWqtwNOx+rL7YqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-aDSi7BMRMNOumPCYsDuLOw-1; Mon, 03 Feb 2020 05:30:54 -0500
X-MC-Unique: aDSi7BMRMNOumPCYsDuLOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5664613E6;
        Mon,  3 Feb 2020 10:30:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9344789A99;
        Mon,  3 Feb 2020 10:30:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 1/4] rxrpc: Fix use-after-free in rxrpc_put_local() ver #2
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Feb 2020 10:30:51 +0000
Message-ID: <158072585191.743488.10422251782960804156.stgit@warthog.procyon.org.uk>
In-Reply-To: <158072584492.743488.4616022353630142921.stgit@warthog.procyon.org.uk>
References: <158072584492.743488.4616022353630142921.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix rxrpc_put_local() to not access local->debug_id after calling
atomic_dec_return() as, unless that returned n==0, we no longer have the
right to access the object.

Fixes: 06d9532fa6b3 ("rxrpc: Fix read-after-free in rxrpc_queue_local()")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/local_object.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 36587260cabd..3aa179efcda4 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -364,11 +364,14 @@ void rxrpc_queue_local(struct rxrpc_local *local)
 void rxrpc_put_local(struct rxrpc_local *local)
 {
 	const void *here = __builtin_return_address(0);
+	unsigned int debug_id;
 	int n;
 
 	if (local) {
+		debug_id = local->debug_id;
+
 		n = atomic_dec_return(&local->usage);
-		trace_rxrpc_local(local->debug_id, rxrpc_local_put, n, here);
+		trace_rxrpc_local(debug_id, rxrpc_local_put, n, here);
 
 		if (n == 0)
 			call_rcu(&local->rcu, rxrpc_local_rcu);


