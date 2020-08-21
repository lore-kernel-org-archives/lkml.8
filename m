Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B535C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AE20838
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="quax3u38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHUVVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:21:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7274 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbgHUVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:21:34 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LLDwq8016961
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=D55i0VrjpMlrOb2OUAwT58YrxQDIA+sSmCrKN0Zevgc=;
 b=quax3u387BGmcNVtc7EwsMtu09ga+J/wX8TIo13DP2Rv+tz2guPwcePJ6p6HZAN2WTXc
 GtcLvqph7jaLzZZ40UEg8kPlfWcV6McDN/bB0ICqpu3hSSBuRpXowQbNFEtZoHXZmbTw
 ohXSj3xNPKALEi2R2F4bLCWcSBVTFt1v05k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 332gp81y83-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:21:30 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 21 Aug 2020 14:21:29 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id C3781347CCB3; Fri, 21 Aug 2020 14:21:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dan Schatzberg <dschatzberg@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH] mm: rework remote memcg charging API to support nesting
Date:   Fri, 21 Aug 2020 14:20:56 -0700
Message-ID: <20200821212056.3769116-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_10:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210197
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the remote memcg charging API consists of two functions:
memalloc_use_memcg() and memalloc_unuse_memcg(), which set and clear
the memcg value, which overwrites the memcg of the current task.

  memalloc_use_memcg(target_memcg);
  <...>
  memalloc_unuse_memcg();

It works perfectly for allocations performed from a normal context,
however an attempt to call it from an interrupt context or just nest
two remote charging blocks will lead to an incorrect accounting.
On exit from the inner block the active memcg will be cleared
instead of being restored.

  memalloc_use_memcg(target_memcg);

  memalloc_use_memcg(target_memcg_2);
    <...>
    memalloc_unuse_memcg();

    Error: allocation here are charged to the memcg of the current
    process instead of target_memcg.

  memalloc_unuse_memcg();

This patch extends the remote charging API by switching to a single
function: struct mem_cgroup *set_active_memcg(struct mem_cgroup *memcg),
which sets the new value and returns the old one. So a remote charging
block will look like:

  old_memcg =3D set_active_memcg(target_memcg);
  <...>
  set_active_memcg(old_memcg);

This patch is heavily based on the patch by Johannes Weiner,
which can be found here: https://lkml.org/lkml/2020/5/28/806 .

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Dan Schatzberg <dschatzberg@fb.com>
---
 fs/buffer.c                          |  6 +++---
 fs/notify/fanotify/fanotify.c        |  5 +++--
 fs/notify/inotify/inotify_fsnotify.c |  5 +++--
 include/linux/sched/mm.h             | 30 ++++++++++------------------
 mm/memcontrol.c                      |  6 +++---
 5 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ac0310d24657..f1f2fb1b2432 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -842,13 +842,13 @@ struct buffer_head *alloc_page_buffers(struct page =
*page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp =3D GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg, *old_memcg;
=20
 	if (retry)
 		gfp |=3D __GFP_NOFAIL;
=20
 	memcg =3D get_mem_cgroup_from_page(page);
-	memalloc_use_memcg(memcg);
+	old_memcg =3D set_active_memcg(memcg);
=20
 	head =3D NULL;
 	offset =3D PAGE_SIZE;
@@ -867,7 +867,7 @@ struct buffer_head *alloc_page_buffers(struct page *p=
age, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
-	memalloc_unuse_memcg();
+	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 	return head;
 /*
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index c942910a8649..9167884a61ec 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -531,6 +531,7 @@ static struct fanotify_event *fanotify_alloc_event(st=
ruct fsnotify_group *group,
 	struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type, dir)=
;
 	const struct path *path =3D fsnotify_data_path(data, data_type);
 	unsigned int fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct mem_cgroup *old_memcg;
 	struct inode *child =3D NULL;
 	bool name_event =3D false;
=20
@@ -580,7 +581,7 @@ static struct fanotify_event *fanotify_alloc_event(st=
ruct fsnotify_group *group,
 		gfp |=3D __GFP_RETRY_MAYFAIL;
=20
 	/* Whoever is interested in the event, pays for the allocation. */
-	memalloc_use_memcg(group->memcg);
+	old_memcg =3D set_active_memcg(group->memcg);
=20
 	if (fanotify_is_perm_event(mask)) {
 		event =3D fanotify_alloc_perm_event(path, gfp);
@@ -608,7 +609,7 @@ static struct fanotify_event *fanotify_alloc_event(st=
ruct fsnotify_group *group,
 		event->pid =3D get_pid(task_tgid(current));
=20
 out:
-	memalloc_unuse_memcg();
+	set_active_memcg(old_memcg);
 	return event;
 }
=20
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
index a65cf8c9f600..9ddcbadc98e2 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -66,6 +66,7 @@ static int inotify_one_event(struct fsnotify_group *gro=
up, u32 mask,
 	int ret;
 	int len =3D 0;
 	int alloc_len =3D sizeof(struct inotify_event_info);
+	struct mem_cgroup *old_memcg;
=20
 	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
@@ -87,9 +88,9 @@ static int inotify_one_event(struct fsnotify_group *gro=
up, u32 mask,
 	 * trigger OOM killer in the target monitoring memcg as it may have
 	 * security repercussion.
 	 */
-	memalloc_use_memcg(group->memcg);
+	old_memcg =3D set_active_memcg(group->memcg);
 	event =3D kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
-	memalloc_unuse_memcg();
+	set_active_memcg(old_memcg);
=20
 	if (unlikely(!event)) {
 		/*
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..4c69a4349ac1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -305,38 +305,28 @@ static inline void memalloc_nocma_restore(unsigned =
int flags)
=20
 #ifdef CONFIG_MEMCG
 /**
- * memalloc_use_memcg - Starts the remote memcg charging scope.
+ * set_active_memcg - Starts the remote memcg charging scope.
  * @memcg: memcg to charge.
  *
  * This function marks the beginning of the remote memcg charging scope.=
 All the
  * __GFP_ACCOUNT allocations till the end of the scope will be charged t=
o the
  * given memcg.
  *
- * NOTE: This function is not nesting safe.
+ * NOTE: This function can nest. Users must save the return value and
+ * reset the previous value after their own charging scope is over.
  */
-static inline void memalloc_use_memcg(struct mem_cgroup *memcg)
+static inline struct mem_cgroup *
+set_active_memcg(struct mem_cgroup *memcg)
 {
-	WARN_ON_ONCE(current->active_memcg);
+	struct mem_cgroup *old =3D current->active_memcg;
 	current->active_memcg =3D memcg;
-}
-
-/**
- * memalloc_unuse_memcg - Ends the remote memcg charging scope.
- *
- * This function marks the end of the remote memcg charging scope starte=
d by
- * memalloc_use_memcg().
- */
-static inline void memalloc_unuse_memcg(void)
-{
-	current->active_memcg =3D NULL;
+	return old;
 }
 #else
-static inline void memalloc_use_memcg(struct mem_cgroup *memcg)
-{
-}
-
-static inline void memalloc_unuse_memcg(void)
+static inline struct mem_cgroup *
+set_active_memcg(struct mem_cgroup *memcg)
 {
+	return NULL;
 }
 #endif
=20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 130093bdf74b..ac5290a3f3f1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5271,12 +5271,12 @@ static struct cgroup_subsys_state * __ref
 mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent =3D mem_cgroup_from_css(parent_css);
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg, *old_memcg;
 	long error =3D -ENOMEM;
=20
-	memalloc_use_memcg(parent);
+	old_memcg =3D set_active_memcg(parent);
 	memcg =3D mem_cgroup_alloc();
-	memalloc_unuse_memcg();
+	set_active_memcg(old_memcg);
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
=20
--=20
2.26.2

