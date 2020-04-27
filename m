Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B7C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A3D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgD0Ogz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:36:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60249 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgD0Ogy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:36:54 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jT4sK-0006lv-Hp; Mon, 27 Apr 2020 14:36:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH] nsproxy: attach to namespaces via pidfds
Date:   Mon, 27 Apr 2020 16:36:46 +0200
Message-Id: <20200427143646.619227-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For quite a while we have been thinking about using pidfds to attach to
namespaces. This patchset has existed for about a year already but we've
wanted to wait to see how the general api would be received and adopted.
Now that more and more programs in userspace have started using pidfds
for process management it's time to send this one out.

This patch makes it possible to use pidfds to attach to the namespaces
of another process, i.e. they can be passed as the first argument to the
setns() syscall. When only a single namespace type is specified the
semantics are equivalent to passing an nsfd. That means
setns(nsfd, CLONE_NEWNET) equals setns(pidfd, CLONE_NEWNET). However,
when a pidfd is passed, multiple namespace flags can be specified in the
second setns() argument and setns() will attach the caller to all the
specified namespaces all at once or to none of them. If 0 is specified
together with a pidfd then setns() will interpret it the same way 0 is
interpreted together with a nsfd argument, i.e. attach to any/all
namespaces.

The obvious example where this is useful is a standard container
manager interacting with a running container: pushing and pulling files
or directories, injecting mounts, attaching/execing any kind of process,
managing network devices all these operations require attaching to all
or at least multiple namespaces at the same time. Given that nowadays
most containers are spawned with all namespaces enabled we're currently
looking at at least 14 syscalls, 7 to open the /proc/<pid>/ns/<ns>
nsfds, another 7 to actually perform the namespace switch. With time
namespaces we're looking at about 16 syscalls.
(We could amortize the first 7 or 8 syscalls for opening the nsfds by
 stashing them in each container's monitor process but that would mean
 we need to send around those file descriptors through unix sockets
 everytime we want to interact with the container or keep on-disk
 state. Even in scenarios where a caller wants to join a particular
 namespace in a particular order callers still profit from batching
 other namespaces. That mostly applies to the user namespace but
 all container runtimes I found join the user namespace first no matter
 if it privileges or deprivileges the container.)
With pidfds this becomes a single syscall no matter how many namespaces
are supposed to be attached to.
A decently designed, large-scale container manager usually isn't the
parent of any of the containers it spawns so the containers don't die
when it crashes or needs to update or reinitialize. This means that
for the manger to interact with containers through pids is inherently
racy especially on systems where the maximum pid number is not
signficianly bumped. This is even more problematic since we often spawn
and manage thousands or ten-thousands of containers. Interacting with a
container through a pid thus can become risky quite quickly. Especially
since we allow for an administrator to enable advanced features such as
syscall interception where we're performing syscalls in lieu of the
container. In all of those cases we use pidfds if they are available and
we pass them around as stable references. Using them to setns() to the
target process namespaces is as reliable as using nsfds. Either the
target process is already dead and we get ESRCH or we manage to attach
to its namespaces but we can't accidently attach to another process'
namespaces. So pidfds lend themselves to be used with this api.

Apart from significiantly reducing the number of syscalls from double
digit to single digit which is a decent reason post-spectre/meltdown
this also allows to switch to a set of namespaces atomically, i.e.
either attaching to all the specified namespaces succeeds or we fail. If
we fail we haven't changed a single namespace. There are currently three
namespaces that can fail (other than for ENOMEM which really is not
very interesting since we then have other problems anyway) for
non-trivial reasons, user, mount, and pid namespaces. We can fail to
attach to a pid namespace if it is not our current active pid namespace
or a descendant of it. We can fail to attach to a user namespace because
we are multi-threaded, because our current mount namespace shares
filesystem state with other tasks, or because we're trying to setns()
to the same user namespace, i.e. the target task has the same user
namespace as we do. We can fail to attach to a mount namespace because
it shares filesystem state with other tasks or because we fail to lookup
the new root for the new mount namespace. In most non-pathological
scenarios these issues can be somewhat mitigated. But there's e.g.
still an inherent race between trying to setns() to the mount namespace
of a task and that task spawning a child with CLONE_FS. If that process
runs in a new user namespace we must have already setns()ed into the new
user namespace otherwise we fail to attach to the mount namespace. There
are other cases similar to that and we've had issues where we're
half-attached to some namespace and failing in the middle. I've talked
about some of these problem during the hallway track (something only the
pre-COVID-19 generation will remember) of Plumber in Los Angeles in
2018(?). Even if all these issues could be avoided with super careful
userspace coding it would be nicer to have this done in-kernel. There's
not a lot of cost associated with this extension for the kernel and
pidfds seem to lend themselves nicely for this.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
If we agree that this is useful than I'd pick this up for for v5.8.
There's probably some smart trick around nsproxy and pidns life-cycle
management that I'm missing but I tried to be conservative wrt to taking
references.
---
 fs/namespace.c                |   5 ++
 fs/nsfs.c                     |   7 +-
 include/linux/mnt_namespace.h |   2 +
 include/linux/proc_fs.h       |   6 ++
 kernel/nsproxy.c              | 132 +++++++++++++++++++++++++++++++---
 5 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a28e4db075ed..1b120e134ea0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1733,6 +1733,11 @@ static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 	return container_of(ns, struct mnt_namespace, ns);
 }
 
+struct ns_common *mnt_ns_to_common(struct mnt_namespace *mnt)
+{
+	return &mnt->ns;
+}
+
 static bool mnt_ns_loop(struct dentry *dentry)
 {
 	/* Could bind mounting the mount namespace inode cause a
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 4f1205725cfe..b023c1a367c8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -229,6 +229,11 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
 	return res;
 }
 
+bool proc_ns_file(const struct file *file)
+{
+	return file->f_op == &ns_file_operations;
+}
+
 struct file *proc_ns_fget(int fd)
 {
 	struct file *file;
@@ -237,7 +242,7 @@ struct file *proc_ns_fget(int fd)
 	if (!file)
 		return ERR_PTR(-EBADF);
 
-	if (file->f_op != &ns_file_operations)
+	if (!proc_ns_file(file))
 		goto out_invalid;
 
 	return file;
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 35942084cd40..664dd3b06f34 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -6,10 +6,12 @@
 struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
+struct ns_common;
 
 extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
 extern void put_mnt_ns(struct mnt_namespace *ns);
+extern struct ns_common *mnt_ns_to_common(struct mnt_namespace *);
 
 extern const struct file_operations proc_mounts_operations;
 extern const struct file_operations proc_mountinfo_operations;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 45c05fd9c99d..acfd5012db4e 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -104,6 +104,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    proc_write_t write,
 						    void *data);
 extern struct pid *tgid_pidfd_to_pid(const struct file *file);
+extern bool proc_ns_file(const struct file *file);
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
@@ -159,6 +160,11 @@ static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
 	return ERR_PTR(-EBADF);
 }
 
+static inline bool proc_ns_file(const struct file *file)
+{
+	return false;
+}
+
 #endif /* CONFIG_PROC_FS */
 
 struct net;
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index ed9882108cd2..9bc211009a29 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
@@ -257,21 +258,133 @@ void exit_task_namespaces(struct task_struct *p)
 	switch_task_namespaces(p, NULL);
 }
 
-SYSCALL_DEFINE2(setns, int, fd, int, nstype)
+static int check_setns_flags(unsigned long flags)
+{
+	if (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC | CLONE_NEWNET |
+		      CLONE_NEWUSER | CLONE_NEWPID | CLONE_NEWCGROUP))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline bool wants_ns(int flags, int ns)
+{
+	return !flags || (flags & ns) > 0;
+}
+
+static inline int __ns_install(struct nsproxy *nsproxy, struct ns_common *ns)
+{
+	return ns->ops->install(nsproxy, ns);
+}
+
+/*
+ * Ordering is equivalent to the standard ordering used everywhere
+ * else during unshare and process creation.
+ */
+static int ns_install(struct nsproxy *nsproxy, struct pid *pid, int flags)
+{
+	int ret = 0;
+	struct task_struct *tsk;
+	struct nsproxy *nsp;
+
+	tsk = get_pid_task(pid, PIDTYPE_PID);
+	if (!tsk)
+		return -ESRCH;
+
+	get_nsproxy(tsk->nsproxy);
+	nsp = tsk->nsproxy;
+
+#ifdef CONFIG_USER_NS
+	if (wants_ns(flags, CLONE_NEWUSER)) {
+		struct user_namespace *user_ns;
+
+		user_ns = get_user_ns(__task_cred(tsk)->user_ns);
+		ret = __ns_install(nsproxy, &user_ns->ns);
+		put_user_ns(user_ns);
+	}
+#else
+	if (flags & CLONE_NEWUSER)
+		ret = -EINVAL;
+#endif
+
+	if (!ret && wants_ns(flags, CLONE_NEWNS))
+		ret = __ns_install(nsproxy, mnt_ns_to_common(nsp->mnt_ns));
+
+#ifdef CONFIG_UTS_NS
+	if (!ret && wants_ns(flags, CLONE_NEWUTS))
+		ret = __ns_install(nsproxy, &nsp->uts_ns->ns);
+#else
+	if (flags & CLONE_NEWUTS)
+		ret = -EINVAL;
+#endif
+
+#ifdef CONFIG_IPC_NS
+	if (!ret && wants_ns(flags, CLONE_NEWIPC))
+		ret = __ns_install(nsproxy, &nsp->ipc_ns->ns);
+#else
+	if (flags & CLONE_NEWIPC)
+		ret = -EINVAL;
+#endif
+
+#ifdef CONFIG_PID_NS
+	if (!ret && wants_ns(flags, CLONE_NEWPID)) {
+		struct pid_namespace *pidns;
+
+		pidns = task_active_pid_ns(tsk);
+		if (pidns) {
+			get_pid_ns(pidns);
+			ret = __ns_install(nsproxy, &pidns->ns);
+			put_pid_ns(pidns);
+		}
+	}
+#else
+	if (flags & CLONE_NEWPID)
+		ret = EINVAL;
+#endif
+
+#ifdef CONFIG_CGROUPS
+	if (!ret && wants_ns(flags, CLONE_NEWCGROUP))
+		ret = __ns_install(nsproxy, &nsp->cgroup_ns->ns);
+#else
+	if (flags & CLONE_NEWCGROUP)
+		ret = EINVAL;
+#endif
+
+#ifdef CONFIG_NET_NS
+	if (!ret && wants_ns(flags, CLONE_NEWNET))
+		ret = __ns_install(nsproxy, &nsp->net_ns->ns);
+#else
+	if (flags & CLONE_NEWNET)
+		ret = -EINVAL;
+#endif
+
+	put_task_struct(tsk);
+	put_nsproxy(nsp);
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(setns, int, fd, int, flags)
 {
 	struct task_struct *tsk = current;
 	struct nsproxy *new_nsproxy;
 	struct file *file;
-	struct ns_common *ns;
+	struct ns_common *ns = NULL;
 	int err;
 
-	file = proc_ns_fget(fd);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
 
 	err = -EINVAL;
-	ns = get_proc_ns(file_inode(file));
-	if (nstype && (ns->ops->type != nstype))
+	if (proc_ns_file(file)) {
+		ns = get_proc_ns(file_inode(file));
+		if (!flags || (ns->ops->type == flags))
+			err = 0;
+	} else if (pidfd_pid(file)) {
+		err = check_setns_flags(flags);
+	}
+	if (err)
 		goto out;
 
 	new_nsproxy = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
@@ -280,7 +393,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, nstype)
 		goto out;
 	}
 
-	err = ns->ops->install(new_nsproxy, ns);
+	if (proc_ns_file(file))
+		err = ns->ops->install(new_nsproxy, ns);
+	else
+		err = ns_install(new_nsproxy, file->private_data, flags);
 	if (err) {
 		free_nsproxy(new_nsproxy);
 		goto out;

base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.2

