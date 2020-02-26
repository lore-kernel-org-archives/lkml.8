Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C5C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ACC24680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpYsbsRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgBZQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:16:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728736AbgBZQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ywx1qIVqpeFVyk5FdbSzu1McnsKdZIvwvf+WZMVi7Zs=;
        b=gpYsbsRZEKnhyGP3Xfsrec2yH0Iw2PhJcJTqje4Hh2WLV1W0g15YJsIN3AowKCLeoJK3tg
        cVIq7ksyGbvvdjDuuua5QJEbp6/Nm9PlNtIFt06nLc8kpjXZuohblmW8Hqe3YcPFNG8JN7
        aj7vnIrokk1aLSIpKy06afTFiqpCMPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-K7C2TJKJPyaLBrctJLBKxQ-1; Wed, 26 Feb 2020 11:15:53 -0500
X-MC-Unique: K7C2TJKJPyaLBrctJLBKxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3873F800D6C;
        Wed, 26 Feb 2020 16:15:51 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFD6F60BE1;
        Wed, 26 Feb 2020 16:15:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 11/11] fs/dcache: Track # of negative dentries reclaimed & killed
Date:   Wed, 26 Feb 2020 11:14:04 -0500
Message-Id: <20200226161404.14136-12-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The negative dentry reclaim process gave no visible indication that
it was being activated. In order to allow system administrator to
see if it is being activated as expected, two new debugfs variables
"negative_dentry_reclaimed" and "negative_dentry_killed" are now added
to report the total number of negative dentries that have been reclaimed
and killed. These debugfs variables are only added after the negative
dentry reclaim mechanism is activated for the first time.

In reality, the actual number may be slightly less than the reported
number as not all the negative dentries passed to shrink_dentry_list()
and __dentry_kill() can be successfully reclaimed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index fe48e00349c9..471b51316506 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -33,6 +33,7 @@
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
 #include <linux/jump_label.h>
+#include <linux/debugfs.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -136,6 +137,8 @@ static DEFINE_PER_CPU(long, nr_dentry_negative);
 int dcache_dentry_dir_max_sysctl;
 EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
 static int negative_dentry_dir_max __read_mostly;
+static unsigned long negative_dentry_reclaim_count;
+static atomic_t negative_dentry_kill_count;
 #define	DENTRY_DIR_MAX_MIN	0x100
 
 static LLIST_HEAD(negative_reclaim_list);
@@ -204,6 +207,7 @@ int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
 {
 	int old = dcache_dentry_dir_max_sysctl;
 	int ret;
+	static bool debugfs_file_created;
 
 	ret = proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 
@@ -219,6 +223,14 @@ int proc_dcache_dentry_dir_max(struct ctl_table *ctl, int write,
 		return -EINVAL;
 	}
 
+	if (!debugfs_file_created) {
+		debugfs_create_ulong("negative_dentry_reclaimed", 0400, NULL,
+				     &negative_dentry_reclaim_count);
+		debugfs_create_u32("negative_dentry_killed", 0400, NULL,
+				   (u32 *)&negative_dentry_kill_count.counter);
+		debugfs_file_created = true;
+	}
+
 	negative_dentry_dir_max = dcache_dentry_dir_max_sysctl;
 	if (!old && dcache_dentry_dir_max_sysctl)
 		static_branch_enable(&negative_reclaim_enable);
@@ -1542,6 +1554,8 @@ static void negative_reclaim_workfn(struct work_struct *work)
 		kfree(dentry_node);
 		cond_resched();
 	}
+	if (quota < MAX_DENTRY_RECLAIM)
+		negative_dentry_reclaim_count += MAX_DENTRY_RECLAIM - quota;
 }
 
 /*
@@ -1609,6 +1623,7 @@ static void negative_reclaim_check(struct dentry *parent, struct dentry *child)
 			rcu_read_unlock();
 			__dentry_kill(child);
 			dput(parent);
+			atomic_inc(&negative_dentry_kill_count);
 			return;
 		}
 		spin_unlock(&child->d_lock);
-- 
2.18.1

