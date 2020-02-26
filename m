Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FCC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367C124670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd5s++nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBZQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:15:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727917AbgBZQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=uJRtUtLfopxQegOvimJxYCld7I/ihswh3Wfa9C5dXY4=;
        b=Xd5s++njXwNc2s7v78x2sG5HebonNDAfUAXcAuEObJ5a3ApFYmj53myNyGaOPlY0Z9B7NF
        MKZqdpfEf/d2kxPSf6LEqE5Bbijy8Igc9aqgPlaEOp1lncx0dkWi3a566IavCZKbWjFJt+
        cuJ5nzcZLXbh9RFzs/MEC5H2Xib+aug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-IKwj9E_NMjSaT0s4LK-7Tg-1; Wed, 26 Feb 2020 11:15:14 -0500
X-MC-Unique: IKwj9E_NMjSaT0s4LK-7Tg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24792107ACCA;
        Wed, 26 Feb 2020 16:15:11 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7B460BE1;
        Wed, 26 Feb 2020 16:15:09 +0000 (UTC)
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
Subject: [PATCH 04/11] fs/dcache: Add sysctl parameter dentry-dir-max
Date:   Wed, 26 Feb 2020 11:13:57 -0500
Message-Id: <20200226161404.14136-5-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of positive dentries in a system is limited by the actual
number of files in the system. The number of negative dentries, however,
has no such limit. As a result, it is possible that a system can have a
significant amount of memory tied up in negative dentries. For example,
running a negative dentry generator on a 4-socket 256GB x86-64 system,
the system can use up more than 150GB of memory in dentries and more
than 200GB in slabs and almost running out of free memory before memory
reclaim kicks in.

There are two major problems with having too many negative dentries:

 1) When a filesystem with too many negative dentries is being unmounted,
    the process of draining the dentries associated with the filesystem
    can take some time. To users, the system may seem to hang for
    a while.  The long wait may also cause unexpected timeout error or
    other warnings.  This can happen when a long running container with
    many negative dentries is being destroyed, for instance.

 2) Tying up too much memory in unused negative dentries means there
    are less memory available for other use. Even though the kernel is
    able to reclaim unused dentries when running out of free memory,
    it will still introduce additional latency to the application
    reducing its performance.

This patch introduces a new sysctl parameter "dentry-dir-max" to
/proc/sys/fs. This syctl parameter represents a soft limit on the
total number of negative dentries allowable under any given directory.
Any non-negative integer is allowed. The default is 0 which means there
is no limit.

The actual negative dentry reclaim process to enforce the limit will
be done in a later patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 18 ++++++++++++++++++
 fs/dcache.c                             | 10 ++++++++++
 kernel/sysctl.c                         | 10 ++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..7274a7b34ee4 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -28,6 +28,7 @@ Currently, these files are in /proc/sys/fs:
 
 - aio-max-nr
 - aio-nr
+- dentry-dir-max
 - dentry-state
 - dquot-max
 - dquot-nr
@@ -60,6 +61,23 @@ raising aio-max-nr does not result in the pre-allocation or re-sizing
 of any kernel data structures.
 
 
+dentry-dir-max
+--------------
+
+This integer value specifies a soft limit on the maximum number
+of negative dentries that are allowed under any given directory.
+A negative dentry contains filename that is known to be nonexistent
+in the directory.  No restriction is placed on the number of positive
+dentries as it is naturally limited by the number of files in the
+directory.
+
+The default value is 0 which means there is no limit.  Any non-negative
+value is allowed.  However, internal tracking is done on all dentry
+types. So the value given, if non-zero, should be larger than the
+number of files in a typical large directory in order to reduce the
+tracking overhead.
+
+
 dentry-state
 ------------
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 0ee5aa2c31cf..8f3ac31a582b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -123,6 +123,16 @@ static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
 static DEFINE_PER_CPU(long, nr_dentry_negative);
 
+/*
+ * dcache_dentry_dir_max_sysctl:
+ *
+ * This is sysctl parameter "dentry-dir-max" which specifies a limit on
+ * the maximum number of negative dentries that are allowed under any
+ * given directory.
+ */
+int dcache_dentry_dir_max_sysctl __read_mostly;
+EXPORT_SYMBOL_GPL(dcache_dentry_dir_max_sysctl);
+
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..cd0a83ff1029 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -118,6 +118,7 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
 #endif
+extern int dcache_dentry_dir_max_sysctl;
 
 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -127,6 +128,7 @@ static int sixty = 60;
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static int __maybe_unused zero;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
@@ -1949,6 +1951,14 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "dentry-dir-max",
+		.data		= &dcache_dentry_dir_max_sysctl,
+		.maxlen		= sizeof(dcache_dentry_dir_max_sysctl),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+	},
 	{ }
 };
 
-- 
2.18.1

