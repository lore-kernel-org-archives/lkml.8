Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD61C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7CF222C8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y76pStqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgFSWjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:39:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729400AbgFSWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592606381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxUyiYLffvi8OTheuzrtW+/yF8SoBV+CkNicnEmyAWE=;
        b=Y76pStqYoDI9VLOH4r0K8uBfaeCWUcypQYxCdawjg4thE/wi7KbDN3jUv6Jvj3afucvZCT
        SJXv/3l/axm3/jBwXIWXh3hxx2+lP96e57ESRK3FzaveU6nrcEUwew20700CTQsr03r64f
        Gm+IjJ6todh+GAOvJB2h1jYQ0myZRhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-nDuYzNbXMAKBMiMbBlarRg-1; Fri, 19 Jun 2020 18:39:39 -0400
X-MC-Unique: nDuYzNbXMAKBMiMbBlarRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B5C184D150;
        Fri, 19 Jun 2020 22:39:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57FDD19C4F;
        Fri, 19 Jun 2020 22:39:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix hang on rmmod due to outstanding timer
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 23:39:36 +0100
Message-ID: <159260637654.2218312.15803998774310526664.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fileserver probe timer, net->fs_probe_timer, isn't cancelled when the
kafs module is being removed and so the count it holds on
net->servers_outstanding doesn't get dropped..  This causes rmmod to wait
forever.  The hung process shows a stack like:

	afs_purge_servers+0x1b5/0x23c [kafs]
	afs_net_exit+0x44/0x6e [kafs]
	ops_exit_list+0x72/0x93
	unregister_pernet_operations+0x14c/0x1ba
	unregister_pernet_subsys+0x1d/0x2a
	afs_exit+0x29/0x6f [kafs]
	__do_sys_delete_module.isra.0+0x1a2/0x24b
	do_syscall_64+0x51/0x95
	entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by:

 (1) Attempting to cancel the probe timer and, if successful, drop the
     count that the timer was holding.

 (2) Make the timer function just drop the count and not schedule the
     prober if the afs portion of net namespace is being destroyed.

Also, whilst we're at it, make the following changes:

 (3) Initialise net->servers_outstanding to 1 and decrement it before
     waiting on it so that it doesn't generate wake up events by being
     decremented to 0 until we're cleaning up.

 (4) Switch the atomic_dec() on ->servers_outstanding for ->fs_timer in
     afs_purge_servers() to use the helper function for that.

Fixes: f6cbb368bcb0 ("afs: Actively poll fileservers to maintain NAT or firewall openings")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c |   11 ++++++++++-
 fs/afs/internal.h |    1 +
 fs/afs/main.c     |    3 +++
 fs/afs/server.c   |    3 ++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index b34f74b0f319..5d9ef517cf81 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -314,7 +314,7 @@ void afs_fs_probe_timer(struct timer_list *timer)
 {
 	struct afs_net *net = container_of(timer, struct afs_net, fs_probe_timer);
 
-	if (!queue_work(afs_wq, &net->fs_prober))
+	if (!net->live || !queue_work(afs_wq, &net->fs_prober))
 		afs_dec_servers_outstanding(net);
 }
 
@@ -458,3 +458,12 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, bool is_intr)
 		return -ETIME;
 	return -EDESTADDRREQ;
 }
+
+/*
+ * Clean up the probing when the namespace is killed off.
+ */
+void afs_fs_probe_cleanup(struct afs_net *net)
+{
+	if (del_timer_sync(&net->fs_probe_timer))
+		afs_dec_servers_outstanding(net);
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 573a5922c3bb..d520535ddb62 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1065,6 +1065,7 @@ extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
 extern void afs_probe_fileserver(struct afs_net *, struct afs_server *);
 extern void afs_fs_probe_dispatcher(struct work_struct *);
 extern int afs_wait_for_one_fs_probe(struct afs_server *, bool);
+extern void afs_fs_probe_cleanup(struct afs_net *);
 
 /*
  * inode.c
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 9c79c91e8005..31b472f7c734 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -100,6 +100,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	timer_setup(&net->fs_timer, afs_servers_timer, 0);
 	INIT_WORK(&net->fs_prober, afs_fs_probe_dispatcher);
 	timer_setup(&net->fs_probe_timer, afs_fs_probe_timer, 0);
+	atomic_set(&net->servers_outstanding, 1);
 
 	ret = -ENOMEM;
 	sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
@@ -130,6 +131,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 
 error_open_socket:
 	net->live = false;
+	afs_fs_probe_cleanup(net);
 	afs_cell_purge(net);
 	afs_purge_servers(net);
 error_cell_init:
@@ -150,6 +152,7 @@ static void __net_exit afs_net_exit(struct net *net_ns)
 	struct afs_net *net = afs_net(net_ns);
 
 	net->live = false;
+	afs_fs_probe_cleanup(net);
 	afs_cell_purge(net);
 	afs_purge_servers(net);
 	afs_close_socket(net);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 039e3488511c..e82e452e2612 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -605,11 +605,12 @@ void afs_purge_servers(struct afs_net *net)
 	_enter("");
 
 	if (del_timer_sync(&net->fs_timer))
-		atomic_dec(&net->servers_outstanding);
+		afs_dec_servers_outstanding(net);
 
 	afs_queue_server_manager(net);
 
 	_debug("wait");
+	atomic_dec(&net->servers_outstanding);
 	wait_var_event(&net->servers_outstanding,
 		       !atomic_read(&net->servers_outstanding));
 	_leave("");


