Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC01C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F09205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDfdJkOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCQIeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:34:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44932 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgCQIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584434042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PSv8VeOYJuoOz6tIXCbXt0QkRfe/tTdz8LKpb1tyPY=;
        b=NDfdJkOlKHkVBYenoCUCehQHsqo/1kI25VPI17YGzA4KV0o/ch43WQI0eXBVJe2GGHjoFu
        ZgR5OGNiXnMlHHFd3IcK2IT7ny5XmunwkCBqER+X2AYhZzlzNviku9gy+pMDZ9g0gBsdTX
        1xaZkbpxgh9PLhvBIH0cYu84F916WIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-eMGhW-TZP5WTbc6WXXwR9A-1; Tue, 17 Mar 2020 04:32:38 -0400
X-MC-Unique: eMGhW-TZP5WTbc6WXXwR9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABD48010C7;
        Tue, 17 Mar 2020 08:32:35 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B49260BF3;
        Tue, 17 Mar 2020 08:32:33 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] ns: prepare time namespace for clone3()
Date:   Tue, 17 Mar 2020 09:30:41 +0100
Message-Id: <20200317083043.226593-2-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable clone3()ing a process directly into a new time namespace with
a clock offset, this changes the time namespace code by renaming the
variable proc_timens_offset (which was used to set a timens offset via
/proc) to set_timens_offset to avoid confusion why it will be used in
clone3() without being related to /proc.

This also moves out the code of actually setting the clock offsets to
its own function to be later used via clone3().

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 fs/proc/base.c                 |   4 +-
 include/linux/time_namespace.h |  16 +++--
 kernel/time/namespace.c        | 126 +++++++++++++++++----------------
 3 files changed, 78 insertions(+), 68 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c7c64272b0fa..2ca68f11ff0e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1554,7 +1554,7 @@ static ssize_t timens_offsets_write(struct file *fi=
le, const char __user *buf,
 				    size_t count, loff_t *ppos)
 {
 	struct inode *inode =3D file_inode(file);
-	struct proc_timens_offset offsets[2];
+	struct set_timens_offset offsets[2];
 	char *kbuf =3D NULL, *pos, *next_line;
 	struct task_struct *p;
 	int ret, noffsets;
@@ -1572,7 +1572,7 @@ static ssize_t timens_offsets_write(struct file *fi=
le, const char __user *buf,
 	ret =3D -EINVAL;
 	noffsets =3D 0;
 	for (pos =3D kbuf; pos; pos =3D next_line) {
-		struct proc_timens_offset *off =3D &offsets[noffsets];
+		struct set_timens_offset *off =3D &offsets[noffsets];
 		int err;
=20
 		/* Find the end of line and ensure we don't look past it */
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespac=
e.h
index 824d54e057eb..fb4ca4402a2a 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -30,6 +30,15 @@ struct time_namespace {
=20
 extern struct time_namespace init_time_ns;
=20
+/*
+ * This structure is used to set the time namespace offset
+ * via /proc as well as via clone3().
+ */
+struct set_timens_offset {
+	int			clockid;
+	struct timespec64	val;
+};
+
 #ifdef CONFIG_TIME_NS
 extern int vdso_join_timens(struct task_struct *task,
 			    struct time_namespace *ns);
@@ -54,13 +63,8 @@ static inline void put_time_ns(struct time_namespace *=
ns)
=20
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)=
;
=20
-struct proc_timens_offset {
-	int			clockid;
-	struct timespec64	val;
-};
-
 int proc_timens_set_offset(struct file *file, struct task_struct *p,
-			   struct proc_timens_offset *offsets, int n);
+			   struct set_timens_offset *offsets, int n);
=20
 static inline void timens_add_monotonic(struct timespec64 *ts)
 {
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 12858507d75a..839efa7c6886 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -307,6 +307,69 @@ static int timens_install(struct nsproxy *nsproxy, s=
truct ns_common *new)
 	return 0;
 }
=20
+static int timens_set_offset(struct task_struct *p, struct time_namespac=
e *ns,
+		struct set_timens_offset *offsets, int noffsets)
+{
+	struct timespec64 tp;
+	int i, err;
+
+	for (i =3D 0; i < noffsets; i++) {
+		struct set_timens_offset *off =3D &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&tp);
+			break;
+		case CLOCK_BOOTTIME:
+			ktime_get_boottime_ts64(&tp);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (off->val.tv_sec > KTIME_SEC_MAX ||
+		    off->val.tv_sec < -KTIME_SEC_MAX)
+			return -ERANGE;
+
+		tp =3D timespec64_add(tp, off->val);
+		/*
+		 * KTIME_SEC_MAX is divided by 2 to be sure that KTIME_MAX is
+		 * still unreachable.
+		 */
+		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
+			return -ERANGE;
+	}
+
+	mutex_lock(&offset_lock);
+	if (ns->frozen_offsets) {
+		err =3D -EACCES;
+		goto out_unlock;
+	}
+
+	err =3D 0;
+	/* Don't report errors after this line */
+	for (i =3D 0; i < noffsets; i++) {
+		struct set_timens_offset *off =3D &offsets[i];
+		struct timespec64 *offset =3D NULL;
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			offset =3D &ns->offsets.monotonic;
+			break;
+		case CLOCK_BOOTTIME:
+			offset =3D &ns->offsets.boottime;
+			break;
+		}
+
+		*offset =3D off->val;
+	}
+
+out_unlock:
+	mutex_unlock(&offset_lock);
+
+	return err;
+}
+
 int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc =3D &nsproxy->time_ns_for_children->ns;
@@ -356,12 +419,11 @@ void proc_timens_show_offsets(struct task_struct *p=
, struct seq_file *m)
 }
=20
 int proc_timens_set_offset(struct file *file, struct task_struct *p,
-			   struct proc_timens_offset *offsets, int noffsets)
+			   struct set_timens_offset *offsets, int noffsets)
 {
 	struct ns_common *ns;
 	struct time_namespace *time_ns;
-	struct timespec64 tp;
-	int i, err;
+	int err;
=20
 	ns =3D timens_for_children_get(p);
 	if (!ns)
@@ -373,63 +435,7 @@ int proc_timens_set_offset(struct file *file, struct=
 task_struct *p,
 		return -EPERM;
 	}
=20
-	for (i =3D 0; i < noffsets; i++) {
-		struct proc_timens_offset *off =3D &offsets[i];
-
-		switch (off->clockid) {
-		case CLOCK_MONOTONIC:
-			ktime_get_ts64(&tp);
-			break;
-		case CLOCK_BOOTTIME:
-			ktime_get_boottime_ts64(&tp);
-			break;
-		default:
-			err =3D -EINVAL;
-			goto out;
-		}
-
-		err =3D -ERANGE;
-
-		if (off->val.tv_sec > KTIME_SEC_MAX ||
-		    off->val.tv_sec < -KTIME_SEC_MAX)
-			goto out;
-
-		tp =3D timespec64_add(tp, off->val);
-		/*
-		 * KTIME_SEC_MAX is divided by 2 to be sure that KTIME_MAX is
-		 * still unreachable.
-		 */
-		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
-			goto out;
-	}
-
-	mutex_lock(&offset_lock);
-	if (time_ns->frozen_offsets) {
-		err =3D -EACCES;
-		goto out_unlock;
-	}
-
-	err =3D 0;
-	/* Don't report errors after this line */
-	for (i =3D 0; i < noffsets; i++) {
-		struct proc_timens_offset *off =3D &offsets[i];
-		struct timespec64 *offset =3D NULL;
-
-		switch (off->clockid) {
-		case CLOCK_MONOTONIC:
-			offset =3D &time_ns->offsets.monotonic;
-			break;
-		case CLOCK_BOOTTIME:
-			offset =3D &time_ns->offsets.boottime;
-			break;
-		}
-
-		*offset =3D off->val;
-	}
-
-out_unlock:
-	mutex_unlock(&offset_lock);
-out:
+	err =3D timens_set_offset(p, time_ns, offsets, noffsets);
 	put_time_ns(time_ns);
=20
 	return err;

base-commit: 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238
--=20
2.24.1

