Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACCFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09E2205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/btNyd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCQIcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:32:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45275 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgCQIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584433971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B30EhhKM5AsSI9qMebkF/7kWnysbBmtvN7O1KfNWzpI=;
        b=X/btNyd4GgxB79jgQs81VHBL/LEqRLnuBEGfXrUuxTL3tKJ2eufPdA/xtljVTQR1ku3T3+
        1ELKzeSF2fJ1LCpJeYWy84SpUIicIWAqvGk3nNLUzPH8IG8R+yTCFZLQJNC6BmlmLqdqPS
        wff3ZjD3upS+UVMjhOjfyF7L4qI2Agk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-1oI6Dtg6N9-SsQIhHNpniQ-1; Tue, 17 Mar 2020 04:32:46 -0400
X-MC-Unique: 1oI6Dtg6N9-SsQIhHNpniQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE58C1B2C981;
        Tue, 17 Mar 2020 08:32:44 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCF4C60BF3;
        Tue, 17 Mar 2020 08:32:39 +0000 (UTC)
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
Subject: [PATCH 2/4] clone3: allow creation of time namespace with offset
Date:   Tue, 17 Mar 2020 09:30:42 +0100
Message-Id: <20200317083043.226593-3-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends clone3() to support the time namespace via CLONE_NEWTIME.
In addition to creating a new process in a new time namespace this
allows setting the clock offset in the newly created time namspace.

The time namespace allows to set an offset for two clocks.
CLOCK_MONOTONIC and CLOCK_BOOTTIME.

This clone3() extension also offers setting both offsets through the
newly introduced clone_args members timens_offset and
timens_offset_size.

timens_offset:      Pointer to an array of clock offsets for the
                    newly created process in a time namespaces.
                    This requires that a new time namespace has been
                    requested via CLONE_NEWTIME. It is only possible
                    to set an offset for CLOCK_MONOTONIC and
                    CLOCK_BOOTTIME. The array can therefore never
                    have more than two elements.
                    clone3() expects the array to contain the
                    following struct:
                    struct set_timens_offset {
                            int clockid;
                            struct timespec val;
                    };

timens_offset_size: This defines the size of the array referenced
                    in timens_offset. Currently this is limited
                    to two elements.

To create a new process using clone3() in a new time namespace with
clock offsets, something like this can be used:

  struct set_timens_offset timens_offset[2];

  timens_offset[0].clockid =3D CLOCK_BOOTTIME;
  timens_offset[0].val.tv_sec =3D -1000;
  timens_offset[0].val.tv_nsec =3D 42;
  timens_offset[1].clockid =3D CLOCK_MONOTONIC;
  timens_offset[1].val.tv_sec =3D 1000000;
  timens_offset[1].val.tv_nsec =3D 37;

  struct _clone_args args =3D {
    .flags =3D CLONE_NEWTIME,
    .timens_offset =3D ptr_to_u64(timens_offset),
    .timens_offset_size =3D 2;
  };

Although the command-line tool unshare only supports setting the offset
in seconds and not nanoseconds, it is possible to set nanoseconds using
the /proc interface of the time namespace. Therefore (and for CRIU) it
probably makes sense to offer nanoseconds also via clone3().

The main motivation for the clone3() integration is to enable CRIU to
restore time namespaces. Not sure how useful the restoration of the
nanosecond value for CRIU is, as during the time the process is paused
by CRIU the clock will continue to run, so that the nanosecond value
will not be the same as when the process has been paused. Between
pausing the process and reading all time namespace information for all
paused process the nanosecond value will change, so that CRIU will never
be able to restore a process with exactly the same nanosecond value the
process had when it was paused. It will make sure, however, that the
nanosecond value will not jump back. So maybe it is useful for CRIU in
the end.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 include/linux/nsproxy.h          |  4 +++-
 include/linux/sched/task.h       |  3 +++
 include/linux/time_namespace.h   |  7 +++++--
 include/uapi/linux/sched.h       | 19 +++++++++++++++++
 kernel/fork.c                    | 35 ++++++++++++++++++++++++++++++--
 kernel/nsproxy.c                 |  5 +++--
 kernel/time/namespace.c          | 11 +++++++++-
 tools/include/uapi/linux/sched.h |  1 +
 8 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 074f395b9ad2..3c032bf7758a 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -11,6 +11,7 @@ struct ipc_namespace;
 struct pid_namespace;
 struct cgroup_namespace;
 struct fs_struct;
+struct set_timens_offset;
=20
 /*
  * A structure to contain pointers to all per-process
@@ -67,7 +68,8 @@ extern struct nsproxy init_nsproxy;
  *
  */
=20
-int copy_namespaces(unsigned long flags, struct task_struct *tsk);
+int copy_namespaces(unsigned long flags, struct task_struct *tsk,
+	struct set_timens_offset *offsets, int noffsets);
 void exit_task_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new=
);
 void free_nsproxy(struct nsproxy *ns);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f1879884238e..45c0e83d52ec 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -9,6 +9,7 @@
=20
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <linux/time.h>
=20
 struct task_struct;
 struct rusage;
@@ -29,6 +30,8 @@ struct kernel_clone_args {
 	pid_t *set_tid;
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
+	struct set_timens_offset *timens_offset;
+	size_t timens_offset_size;
 };
=20
 /*
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespac=
e.h
index fb4ca4402a2a..9261ca1070c9 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -53,7 +53,8 @@ struct time_namespace *copy_time_ns(unsigned long flags=
,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct kref *kref);
-int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
+		   struct set_timens_offset *offsets, int noffsets);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
=20
 static inline void put_time_ns(struct time_namespace *ns)
@@ -121,7 +122,9 @@ struct time_namespace *copy_time_ns(unsigned long fla=
gs,
 }
=20
 static inline int timens_on_fork(struct nsproxy *nsproxy,
-				 struct task_struct *tsk)
+				 struct task_struct *tsk,
+				 struct set_timens_offset *offsets,
+				 int noffsets)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 2e3bc22c6f20..c9b36ef647cc 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -81,6 +81,22 @@
  * @set_tid_size: This defines the size of the array referenced
  *                in @set_tid. This cannot be larger than the
  *                kernel's limit of nested PID namespaces.
+ * @timens_offset:      Pointer to an array of clock offsets for the
+ *                      newly created process in a time namespaces.
+ *                      This requires that a new time namespace has been
+ *                      requested via CLONE_NEWTIME. It is only possible
+ *                      to set an offset for CLOCK_MONOTONIC and
+ *                      CLOCK_BOOTTIME. The array can therefore never
+ *                      have more than two elements.
+ *                      clone3() expects the array to contain the
+ *                      following struct:
+ *                      struct set_timens_offset {
+ *                              int clockid;
+ *                              struct timespec val;
+ *                      };
+ * @timens_offset_size: This defines the size of the array referenced
+ *                      in @timens_offset. Currently this is limited
+ *                      to two elements.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -97,11 +113,14 @@ struct clone_args {
 	__aligned_u64 tls;
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+	__aligned_u64 timens_offset;
+	__aligned_u64 timens_offset_size;
 };
 #endif
=20
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 96 /* sizeof third published struct */
=20
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index 60a1295f4384..f80aca79d263 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <linux/time_namespace.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -2081,7 +2082,8 @@ static __latent_entropy struct task_struct *copy_pr=
ocess(
 	retval =3D copy_mm(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_signal;
-	retval =3D copy_namespaces(clone_flags, p);
+	retval =3D copy_namespaces(clone_flags, p, args->timens_offset,
+			args->timens_offset_size);
 	if (retval)
 		goto bad_fork_cleanup_mm;
 	retval =3D copy_io(clone_flags, p);
@@ -2604,6 +2606,7 @@ noinline static int copy_clone_args_from_user(struc=
t kernel_clone_args *kargs,
 	int err;
 	struct clone_args args;
 	pid_t *kset_tid =3D kargs->set_tid;
+	struct set_timens_offset *ktimens_offset =3D kargs->timens_offset;
=20
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -2623,6 +2626,23 @@ noinline static int copy_clone_args_from_user(stru=
ct kernel_clone_args *kargs,
 	if (unlikely(args.set_tid && args.set_tid_size =3D=3D 0))
 		return -EINVAL;
=20
+	/*
+	 * Currently the time namespace supports setting two clocks:
+	 * CLOCK_MONOTONIC and CLOCK_BOOTTIME
+	 */
+	if (unlikely(args.timens_offset_size > 2))
+		return -EINVAL;
+
+	if (unlikely(!args.timens_offset && args.timens_offset_size > 0))
+		return -EINVAL;
+
+	if (unlikely(args.timens_offset && args.timens_offset_size =3D=3D 0))
+		return -EINVAL;
+
+	if (unlikely((args.timens_offset && args.timens_offset_size)
+				&& !(args.flags & CLONE_NEWTIME)))
+		return -EINVAL;
+
 	/*
 	 * Verify that higher 32bits of exit_signal are unset and that
 	 * it is a valid signal
@@ -2641,6 +2661,7 @@ noinline static int copy_clone_args_from_user(struc=
t kernel_clone_args *kargs,
 		.stack_size	=3D args.stack_size,
 		.tls		=3D args.tls,
 		.set_tid_size	=3D args.set_tid_size,
+		.timens_offset_size =3D args.timens_offset_size,
 	};
=20
 	if (args.set_tid &&
@@ -2648,7 +2669,15 @@ noinline static int copy_clone_args_from_user(stru=
ct kernel_clone_args *kargs,
 			(kargs->set_tid_size * sizeof(pid_t))))
 		return -EFAULT;
=20
+	if (args.timens_offset &&
+		copy_from_user(ktimens_offset,
+			u64_to_user_ptr(args.timens_offset),
+			(kargs->timens_offset_size *
+			 sizeof(struct set_timens_offset))))
+		return -EFAULT;
+
 	kargs->set_tid =3D kset_tid;
+	kargs->timens_offset =3D ktimens_offset;
=20
 	return 0;
 }
@@ -2691,7 +2720,7 @@ static bool clone3_args_valid(struct kernel_clone_a=
rgs *kargs)
 	 * - make the CLONE_DETACHED bit reuseable for clone3
 	 * - make the CSIGNAL bits reuseable for clone3
 	 */
-	if (kargs->flags & (CLONE_DETACHED | CSIGNAL))
+	if (kargs->flags & ((CLONE_DETACHED | CSIGNAL) & ~CLONE_NEWTIME))
 		return false;
=20
 	if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) =3D=3D
@@ -2725,8 +2754,10 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *=
, uargs, size_t, size)
=20
 	struct kernel_clone_args kargs;
 	pid_t set_tid[MAX_PID_NS_LEVEL];
+	struct set_timens_offset timens_offset[2];
=20
 	kargs.set_tid =3D set_tid;
+	kargs.timens_offset =3D timens_offset;
=20
 	err =3D copy_clone_args_from_user(&kargs, uargs, size);
 	if (err)
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index ed9882108cd2..0f041ae3313a 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -146,7 +146,8 @@ static struct nsproxy *create_new_namespaces(unsigned=
 long flags,
  * called from clone.  This now handles copy for nsproxy and all
  * namespaces therein.
  */
-int copy_namespaces(unsigned long flags, struct task_struct *tsk)
+int copy_namespaces(unsigned long flags, struct task_struct *tsk,
+		struct set_timens_offset *offsets, int noffsets)
 {
 	struct nsproxy *old_ns =3D tsk->nsproxy;
 	struct user_namespace *user_ns =3D task_cred_xxx(tsk, user_ns);
@@ -178,7 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_=
struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
=20
-	ret =3D timens_on_fork(new_ns, tsk);
+	ret =3D timens_on_fork(new_ns, tsk, offsets, noffsets);
 	if (ret) {
 		free_nsproxy(new_ns);
 		return ret;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 839efa7c6886..f4fdf9b0b411 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -370,7 +370,8 @@ static int timens_set_offset(struct task_struct *p, s=
truct time_namespace *ns,
 	return err;
 }
=20
-int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk,
+		struct set_timens_offset *offsets, int noffsets)
 {
 	struct ns_common *nsc =3D &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns =3D to_time_ns(nsc);
@@ -380,6 +381,14 @@ int timens_on_fork(struct nsproxy *nsproxy, struct t=
ask_struct *tsk)
 	if (nsproxy->time_ns =3D=3D nsproxy->time_ns_for_children)
 		return 0;
=20
+	if (noffsets) {
+		if (!ns_capable(ns->user_ns, CAP_SYS_TIME))
+			return -EPERM;
+		err =3D timens_set_offset(tsk, ns, offsets, noffsets);
+		if (err)
+			return err;
+	}
+
 	timens_set_vvar_page(tsk, ns);
=20
 	err =3D vdso_join_timens(tsk, ns);
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/=
sched.h
index 2e3bc22c6f20..501b44e6be97 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -102,6 +102,7 @@ struct clone_args {
=20
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 96 /* sizeof third published struct */
=20
 /*
  * Scheduling policies
--=20
2.24.1

