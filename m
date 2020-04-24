Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3037CC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E33320728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfZTp1r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDXPUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:20:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728078AbgDXPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587741648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCXBrdRVsySd/WwGvg6OF0IE99GGjSbx68WGqJoAVXk=;
        b=TfZTp1r/zNQkZSSal555QY/pGGH4M0UCSoOa5WJuKoeORacAR2r753K0lh3Z6ztLAQg2p0
        QObjglY6JMsG/WlK2Ripxh1XnCcSwHBICqjGPOqKNF3ArxtsvBeFZzxRaIb8ZDAhdb4vuZ
        iKW3sFKvSJx3XpPKbGbBEHlW3dbKfH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-5de4YK42OkSJ1I7pWNXceg-1; Fri, 24 Apr 2020 11:20:46 -0400
X-MC-Unique: 5de4YK42OkSJ1I7pWNXceg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F69C100A693;
        Fri, 24 Apr 2020 15:20:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB8275D9CC;
        Fri, 24 Apr 2020 15:20:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 8/8] afs: Show more information in /proc/net/afs/servers
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Fri, 24 Apr 2020 16:20:44 +0100
Message-ID: <158774164414.3619859.10925543612058268605.stgit@warthog.procyon.org.uk>
In-Reply-To: <158774158625.3619859.10579201535876583842.stgit@warthog.procyon.org.uk>
References: <158774158625.3619859.10579201535876583842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show more information in /proc/net/afs/servers to make it easier to see
what's going on with the server probing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 9bce7898cd7d..1d21465a4108 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -378,21 +378,22 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	int i;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 REF ACT ADDR\n");
+		seq_puts(m, "UUID                                 REF ACT\n");
 		return 0;
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
 	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %3d %pISpc%s\n",
+	seq_printf(m, "%pU %3d %3d\n",
 		   &server->uuid,
 		   atomic_read(&server->ref),
-		   atomic_read(&server->active),
-		   &alist->addrs[0].transport,
-		   alist->preferred == 0 ? "*" : "");
-	for (i = 1; i < alist->nr_addrs; i++)
-		seq_printf(m, "                                             %pISpc%s\n",
-			   &alist->addrs[i].transport,
+		   atomic_read(&server->active));
+	seq_printf(m, "  - ALIST v=%u osp=%u r=%lx f=%lx\n",
+		   alist->version, atomic_read(&server->probe_outstanding),
+		   alist->responded, alist->failed);
+	for (i = 0; i < alist->nr_addrs; i++)
+		seq_printf(m, "    [%x] %pISpc%s\n",
+			   i, &alist->addrs[i].transport,
 			   alist->preferred == i ? "*" : "");
 	return 0;
 }


