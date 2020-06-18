Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62E2208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiMtWaFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgFRHup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:50:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48669 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgFRHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592466642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mNDAD09ZF11gVKKLJQ7tphenyVSu5+EHhncfG5s2V8=;
        b=XiMtWaFicUV+wmxINlTig8XRG4rlWaL1KpC+y1qfGpBj/ecaHhMDmXwIRfs0J9iO8GbZGt
        P1sTQoF40sZRau/0C5nuGQUU4qmyUSZBRpcpXHcBfOG0UknqS0U7ss6iQuuCSShMmSCTve
        hOygNQHsMvhn0oZfoCCEqdmkMtDnrBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-5bX6ePhfN2KccolsBVOJlA-1; Thu, 18 Jun 2020 03:50:38 -0400
X-MC-Unique: 5bX6ePhfN2KccolsBVOJlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363C31800D42;
        Thu, 18 Jun 2020 07:50:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 684D160BF3;
        Thu, 18 Jun 2020 07:50:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/3] rxrpc: Fix afs large storage transmission performance
 drop
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Jun 2020 08:50:35 +0100
Message-ID: <159246663560.1229328.1476552302291944463.stgit@warthog.procyon.org.uk>
In-Reply-To: <159246661514.1229328.4419873299996950969.stgit@warthog.procyon.org.uk>
References: <159246661514.1229328.4419873299996950969.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ad6691d988c, which moved the modification of the status annotation
for a packet in the Tx buffer prior to the retransmission moved the state
clearance, but managed to lose the bit that set it to UNACK.

Consequently, if a retransmission occurs, the packet is accidentally
changed to the ACK state (ie. 0) by masking it off, which means that the
packet isn't counted towards the tally of newly-ACK'd packets if it gets
hard-ACK'd.  This then prevents the congestion control algorithm from
recovering properly.

Fix by reinstating the change of state to UNACK.

Spotted by the generic/460 xfstest.

Fixes: 2ad6691d988c ("rxrpc: Fix race between incoming ACK parser and retransmitter")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/call_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index aa1c8eee6557..6be2672a65ea 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -253,7 +253,7 @@ static void rxrpc_resend(struct rxrpc_call *call, unsigned long now_j)
 		 * confuse things
 		 */
 		annotation &= ~RXRPC_TX_ANNO_MASK;
-		annotation |= RXRPC_TX_ANNO_RESENT;
+		annotation |= RXRPC_TX_ANNO_UNACK | RXRPC_TX_ANNO_RESENT;
 		call->rxtx_annotations[ix] = annotation;
 
 		skb = call->rxtx_buffer[ix];


