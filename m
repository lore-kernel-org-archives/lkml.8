Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2785320810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3JBwI2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgE2WDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:03:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728798AbgE2WDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqjx8LCi5mXdMGhiwM/ZBJ6vZIJseftgYdEBsT0kURk=;
        b=I3JBwI2aQWEGM0sAABsdeUpB3QTtWLCr8TAAQkT4Ju869NStPv4IXHTV3JRKDsUKeiuzkQ
        WlA8tWk4jzRGNZbL9kfGXgMbU4/QsvyhwbaXg+YYm9hNq0ww0QYCutvy/u0gVhjVI/omCe
        SpFq7VjboGIUg8RX5eciKU4Kvaggkl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-1F__QerAOliziRmCWG2k2g-1; Fri, 29 May 2020 18:03:14 -0400
X-MC-Unique: 1F__QerAOliziRmCWG2k2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD2B1005512;
        Fri, 29 May 2020 22:03:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BB135D9D7;
        Fri, 29 May 2020 22:03:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 26/27] afs: Show more a bit more server state in
 /proc/net/afs/servers
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:03:11 +0100
Message-ID: <159078979153.679399.348340971164597777.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display more information about the state of a server record, including the
flags, rtt and break counter plus the probe state for each server in
/proc/net/afs/servers.

Rearrange the server flags a bit to make them easier to read at a glance in
the proc file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |   16 ++++++++--------
 fs/afs/proc.c     |   10 +++++++---
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a4fe5d1a8b53..af0b7fca87db 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -497,15 +497,15 @@ struct afs_server {
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
-#define AFS_SERVER_FL_NOT_READY	1		/* The record is not ready for use */
-#define AFS_SERVER_FL_NOT_FOUND	2		/* VL server says no such server */
-#define AFS_SERVER_FL_VL_FAIL	3		/* Failed to access VL server */
-#define AFS_SERVER_FL_UPDATING	4
-#define AFS_SERVER_FL_NO_IBULK	7		/* Fileserver doesn't support FS.InlineBulkStatus */
+#define AFS_SERVER_FL_UPDATING	1
+#define AFS_SERVER_FL_NEEDS_UPDATE 2		/* Fileserver address list is out of date */
+#define AFS_SERVER_FL_NOT_READY	4		/* The record is not ready for use */
+#define AFS_SERVER_FL_NOT_FOUND	5		/* VL server says no such server */
+#define AFS_SERVER_FL_VL_FAIL	6		/* Failed to access VL server */
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
-#define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
-#define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
-#define AFS_SERVER_FL_NEEDS_UPDATE 12		/* Fileserver address list is out of date */
+#define AFS_SERVER_FL_IS_YFS	16		/* Server is YFS not AFS */
+#define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.InlineBulkStatus */
+#define AFS_SERVER_FL_NO_RM2	18		/* Fileserver doesn't support YFS.RemoveFile2 */
 	atomic_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 309a7b578255..22d00cf1913d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -386,9 +386,13 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   &server->uuid,
 		   atomic_read(&server->ref),
 		   atomic_read(&server->active));
-	seq_printf(m, "  - ALIST v=%u osp=%u r=%lx f=%lx\n",
-		   alist->version, atomic_read(&server->probe_outstanding),
-		   alist->responded, alist->failed);
+	seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
+		   server->flags, server->rtt, server->cb_s_break);
+	seq_printf(m, "  - probe: last=%d out=%d\n",
+		   (int)(jiffies - server->probed_at) / HZ,
+		   atomic_read(&server->probe_outstanding));
+	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx\n",
+		   alist->version, alist->responded, alist->failed);
 	for (i = 0; i < alist->nr_addrs; i++)
 		seq_printf(m, "    [%x] %pISpc%s\n",
 			   i, &alist->addrs[i].transport,


