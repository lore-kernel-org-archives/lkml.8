Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6392322B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtFTtyLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgH0P4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgH0Pz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598543758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HzUnybaSeSD+XI9aTe79I48ZH38uKEPOpQGgJzoSsCo=;
        b=XtFTtyLlncG6KRLrOTcoYJBgUEjOZSazdHbUKwxhXwx79PF0Xm40sx158DyS7Eyuez1Gw5
        1UjEgpxsr3Us+Jp77mTXQO8k9Muioby5tfJydLp/EkH8w+OMdA3oFXpAQLq4dB/3mFj7qV
        lLkJa/AWwSNmYmozvy6YGiNfAi33Z4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111--yrSFVVpPci3gsvCPJ4yEQ-1; Thu, 27 Aug 2020 11:55:53 -0400
X-MC-Unique: -yrSFVVpPci3gsvCPJ4yEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEA2410ABDCC;
        Thu, 27 Aug 2020 15:55:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97E291972A;
        Thu, 27 Aug 2020 15:55:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix memory leak in rxkad_verify_response()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, dinghao.liu@zju.edu.cn
Date:   Thu, 27 Aug 2020 16:55:46 +0100
Message-ID: <159854374644.1432629.4927711289531557914.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

Fix a memory leak in rxkad_verify_response() whereby the response buffer
doesn't get freed if we fail to allocate a ticket buffer.

Fixes: ef68622da9cc ("rxrpc: Handle temporary errors better in rxkad security")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/rxkad.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 52a24d4ef5d8..e08130e5746b 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1137,7 +1137,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = -ENOMEM;
 	ticket = kmalloc(ticket_len, GFP_NOFS);
 	if (!ticket)
-		goto temporary_error;
+		goto temporary_error_free_resp;
 
 	eproto = tracepoint_string("rxkad_tkt_short");
 	abort_code = RXKADPACKETSHORT;
@@ -1230,6 +1230,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 temporary_error_free_ticket:
 	kfree(ticket);
+temporary_error_free_resp:
 	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as


