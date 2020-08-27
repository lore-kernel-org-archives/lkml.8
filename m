Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364FAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03B820678
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXle0es/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgH0PFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:05:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728218AbgH0PEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598540691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+vKV7jHyBgx5F+qwazuFqbjaX7j5NcYL/0S6PVquXg=;
        b=LXle0es/DGb9WXGGySIqX+2zFefeBcz8d8qHGFVfJDEVCKayxaCSHE3ogZwcjqj9SejyO7
        DvLCPfcHg3S7JZV+kMZ6+fe74ulSqrJb2zm5gO0BWjjd6XCoKZLQnFwUMUoykFJ5WVVv4c
        ozC+mY6FlU8cy3Q2bQ8kCAkndje0y3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-NZNetU60Nqi4EOKJWVY-PQ-1; Thu, 27 Aug 2020 11:04:48 -0400
X-MC-Unique: NZNetU60Nqi4EOKJWVY-PQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA482192AF37;
        Thu, 27 Aug 2020 15:04:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E6A07B9F4;
        Thu, 27 Aug 2020 15:04:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 7/7] afs: Fix error handling in VL server rotation
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Aug 2020 16:04:22 +0100
Message-ID: <159854066219.1382667.2526502599415329370.stgit@warthog.procyon.org.uk>
In-Reply-To: <159854061331.1382667.9693163318506702951.stgit@warthog.procyon.org.uk>
References: <159854061331.1382667.9693163318506702951.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling in the VL server rotation in the case of there being no
contactable servers is not correct.  In such a case, the records of all the
servers in the list are scanned and the errors and abort codes are mapped
and prioritised and one error is chosen.  This is then forgotten and the
default error is used (EDESTADDRREQ).

Fix this by using the calculated error.

Also we need to note whether a server responded on one of its endpoints so
that we can priorise an error from an abort message over local and network
errors.

Fixes: 4584ae96ae30 ("afs: Fix missing net error handling")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/vl_rotate.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index ab2beb4ba20e..c0458c903b31 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -263,10 +263,14 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	for (i = 0; i < vc->server_list->nr_servers; i++) {
 		struct afs_vlserver *s = vc->server_list->servers[i].server;
 
+		if (test_bit(AFS_VLSERVER_FL_RESPONDING, &s->flags))
+			e.responded = true;
 		afs_prioritise_error(&e, READ_ONCE(s->probe.error),
 				     s->probe.abort_code);
 	}
 
+	error = e.error;
+
 failed_set_error:
 	vc->error = error;
 failed:


