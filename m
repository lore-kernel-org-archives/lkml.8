Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47807C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110D920738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVdUzGKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgEVXm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:42:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42855 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387450AbgEVXmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590190971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvt4UZgNmiEvzFjT7wOhOAQp8UtUprbYOh2ZRPuINeU=;
        b=cVdUzGKFIrGpiPdcnkJlFELFcp7UmHhTaCS0YmtNaXnzFyZu03UjsmbIS45LM5arm7BdAX
        IbH92IuzBMZiH9lpdOdEC6A6aUFfekfh6CBag0hlVeeebzwy91tqhRjFrOpT4aGRhvF/40
        v7MOXvrJU856GfaNJ1MiDB1BUv7eVMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-DdEutajJOLmChGIqFI7AUw-1; Fri, 22 May 2020 19:42:49 -0400
X-MC-Unique: DdEutajJOLmChGIqFI7AUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50417460;
        Fri, 22 May 2020 23:42:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D33F10013C0;
        Fri, 22 May 2020 23:42:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/2] rxrpc: Fix a memory leak in rxkad_verify_response()
 [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Markus Elfring <Markus.Elfring@web.de>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 23 May 2020 00:42:46 +0100
Message-ID: <159019096638.999797.12399237571817646198.stgit@warthog.procyon.org.uk>
In-Reply-To: <159019095229.999797.5088700147400532632.stgit@warthog.procyon.org.uk>
References: <159019095229.999797.5088700147400532632.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

A ticket was not released after a call of the function
"rxkad_decrypt_ticket" failed. Thus replace the jump target
"temporary_error_free_resp" by "temporary_error_free_ticket".

Fixes: 8c2f826dc3631 ("rxrpc: Don't put crypto buffers on the stack")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Markus Elfring <Markus.Elfring@web.de>
---

 net/rxrpc/rxkad.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 098f1f9ec53b..52a24d4ef5d8 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1148,7 +1148,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free_resp;
+		goto temporary_error_free_ticket;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
@@ -1230,7 +1230,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 temporary_error_free_ticket:
 	kfree(ticket);
-temporary_error_free_resp:
 	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as


