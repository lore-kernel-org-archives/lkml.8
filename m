Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131ECC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19A12468B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1S1MtSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgBZQPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:15:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727917AbgBZQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=6Nj8aozQ7eWo4g5FoVKfC5j2jdSztjGAeiNGp+btRF0=;
        b=W1S1MtSeFtBRSKQALEzdMKMe6nyVSmJDTcrf+eyt7J4DWtmeQ/dLPdQeV9/4B/aWlHocat
        Qs3jE472yQcKfrFyXNGPUEA6ORjLzodxn1DdQltpR84ZUUn51F5yKRFJfe6fG4DvJduBi5
        v96mf2x2D+QiIRNqSWy9Mdhlesvpnkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-DAuDgxLROc2L7z0rH_u6rw-1; Wed, 26 Feb 2020 11:15:27 -0500
X-MC-Unique: DAuDgxLROc2L7z0rH_u6rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247448018A1;
        Wed, 26 Feb 2020 16:15:25 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DB3F60BE1;
        Wed, 26 Feb 2020 16:15:13 +0000 (UTC)
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
Subject: [PATCH 06/11] fs/dcache: directory opportunistically stores # of positive dentries
Date:   Wed, 26 Feb 2020 11:13:59 -0500
Message-Id: <20200226161404.14136-7-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For directories that contain large number of files (e.g. in thousands),
the number of positive dentries that will never be reclaimed by
the negative dentry reclaiming process may approach or even exceed
"dentry-dir-max". That will unnecessary cause the triggering of the
reclaim process even if there aren't that many negative dentries that
can be reclaimed.

This can impact system performance. One possible way to solve this
problem is to somehow store the number of positive or negative dentries
in the directory dentry itself. The negative dentry count can change
frequently, whereas the positive dentry count is relatively more stable,

Keeping an accurate count of positive or negative dentries can be
costly. Instead, an estimate of the positive dentry count is computed
in the scan loop of the negative dentry reclaim work function.

That computed value is then stored in the trailing end of the d_iname[]
array if there is enough space for it. This value is then used to
estimate the number of negative dentries in the directory to be compare
against the "dentry-dir-max" value.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 01c6d7277244..c5364c2ed5d8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1294,6 +1294,60 @@ struct reclaim_dentry
 	struct dentry *parent_dir;
 };
 
+/*
+ * If there is enough space at the end of d_iname[] of a directory dentry
+ * to hold an integer. The space will be used to hold an estimate of the
+ * number of positive dentries in the directory. That number will be
+ * subtracted from d_nchildren to see if the limit has been exceeded and
+ * the number of excess negative dentries to be reclaimed.
+ */
+struct d_iname_count {
+	unsigned char d_dummy[DNAME_INLINE_LEN - sizeof(int)];
+	unsigned int d_npositive;
+};
+
+static inline bool dentry_has_npositive(struct dentry *dentry)
+{
+	int len = dentry->d_name.len;
+
+	BUILD_BUG_ON(sizeof(struct d_iname_count) != sizeof(dentry->d_iname));
+
+	return (len >= DNAME_INLINE_LEN) ||
+	       (len < DNAME_INLINE_LEN - sizeof(int));
+}
+
+static inline unsigned int read_dentry_npositive(struct dentry *dentry)
+{
+	struct d_iname_count *p = (struct d_iname_count *)dentry->d_iname;
+
+	return p->d_npositive;
+}
+
+static inline void set_dentry_npositive(struct dentry *dentry,
+					unsigned int npositive)
+{
+	struct d_iname_count *p = (struct d_iname_count *)dentry->d_iname;
+
+	p->d_npositive = npositive;
+}
+
+/*
+ * Get an estimated negative dentry count
+ */
+static inline unsigned int read_dentry_nnegative(struct dentry *dentry)
+{
+	return dentry->d_nchildren - (dentry_has_npositive(dentry)
+					? read_dentry_npositive(dentry) : 0);
+}
+
+/*
+ * Initialize d_iname[] to have null bytes at the end of the array.
+ */
+static inline void init_dentry_iname(struct dentry *dentry)
+{
+	set_dentry_npositive(dentry, 0);
+}
+
 /*
  * Reclaim excess negative dentries in a directory
  */
@@ -1302,11 +1356,11 @@ static void reclaim_negative_dentry(struct dentry *parent,
 {
 	struct dentry *child;
 	int limit = READ_ONCE(dcache_dentry_dir_max_sysctl);
-	int cnt;
+	int cnt, npositive;
 
 	lockdep_assert_held(&parent->d_lock);
 
-	cnt = parent->d_nchildren;
+	cnt = read_dentry_nnegative(parent);
 
 	/*
 	 * Compute # of negative dentries to be reclaimed
@@ -1316,6 +1370,7 @@ static void reclaim_negative_dentry(struct dentry *parent,
 		return;
 	cnt -= limit;
 	cnt += (limit >> 3);
+	npositive = 0;
 
 	/*
 	 * The d_subdirs is treated like a kind of LRU where
@@ -1327,8 +1382,10 @@ static void reclaim_negative_dentry(struct dentry *parent,
 		/*
 		 * This check is racy and so it may not be accurate.
 		 */
-		if (!d_is_negative(child))
+		if (!d_is_negative(child)) {
+			npositive++;
 			continue;
+		}
 
 		if (!spin_trylock(&child->d_lock))
 			continue;
@@ -1368,7 +1425,17 @@ static void reclaim_negative_dentry(struct dentry *parent,
 		list_cut_before(&list, &parent->d_subdirs,
 				&child->d_child);
 		list_splice_tail(&list, &parent->d_subdirs);
+
+		/*
+		 * Update positive dentry count estimate
+		 * Don't allow npositive to decay by more than 1/2.
+		 */
+		if (dentry_has_npositive(parent) &&
+		   (read_dentry_npositive(parent) > 2 * npositive))
+			npositive = read_dentry_npositive(parent) / 2;
 	}
+	if (dentry_has_npositive(parent))
+		set_dentry_npositive(parent, npositive);
 }
 
 /*
@@ -1430,16 +1497,14 @@ static void negative_reclaim_check(struct dentry *parent)
 	 */
 	if (!can_reclaim_dentry(parent->d_flags) ||
 	    (parent->d_flags & DCACHE_RECLAIMING) ||
-	    (READ_ONCE(parent->d_nchildren) <= limit))
+	    (read_dentry_nnegative(parent) <= limit))
 		goto rcu_unlock_out;
 
 	spin_lock(&parent->d_lock);
 	if (!can_reclaim_dentry(parent->d_flags) ||
 	    (parent->d_flags & DCACHE_RECLAIMING) ||
-	    (READ_ONCE(parent->d_nchildren) <= limit))
-		goto unlock_out;
-
-	if (!d_is_dir(parent))
+	    (read_dentry_nnegative(parent) <= limit) ||
+	    !d_is_dir(parent))
 		goto unlock_out;
 
 	dentry_node = kzalloc(sizeof(*dentry_node), GFP_NOWAIT);
@@ -1921,7 +1986,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	 * will still always have a NUL at the end, even if we might
 	 * be overwriting an internal NUL character
 	 */
-	dentry->d_iname[DNAME_INLINE_LEN-1] = 0;
+	init_dentry_iname(dentry);
 	if (unlikely(!name)) {
 		name = &slash_name;
 		dname = dentry->d_iname;
@@ -2991,11 +3056,18 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 		}
 	}
 	swap(dentry->d_name.hash_len, target->d_name.hash_len);
+
+	if (dentry_has_npositive(dentry))
+		set_dentry_npositive(dentry, 0);
+	if (dentry_has_npositive(target))
+		set_dentry_npositive(target, 0);
 }
 
 static void copy_name(struct dentry *dentry, struct dentry *target)
 {
 	struct external_name *old_name = NULL;
+
+	init_dentry_iname(dentry);
 	if (unlikely(dname_external(dentry)))
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
-- 
2.18.1

