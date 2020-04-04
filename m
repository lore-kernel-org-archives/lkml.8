Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9F7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D3F206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgDDIoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41527 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDDImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNC-00011Y-0Y; Sat, 04 Apr 2020 10:41:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 390491C04E3;
        Sat,  4 Apr 2020 10:41:47 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:46 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf cgroup: Maintain cgroup hierarchy
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325124536.2800725-5-namhyung@kernel.org>
References: <20200325124536.2800725-5-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970685.28353.1240498154608229451.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d1277aa36bff4bfc1a187a469fc6a6a1d17cf59c
Gitweb:        https://git.kernel.org/tip/d1277aa36bff4bfc1a187a469fc6a6a1d17cf59c
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 25 Mar 2020 21:45:31 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf cgroup: Maintain cgroup hierarchy

Each cgroup is kept in the perf_env's cgroup_tree sorted by the cgroup
id.  Hist entries have cgroup id can compare it directly and later it
can be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200325124536.2800725-5-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c  | 80 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/cgroup.h  | 17 ++++++--
 tools/perf/util/env.c     |  2 +-
 tools/perf/util/env.h     |  6 +++-
 tools/perf/util/machine.c |  9 +++-
 5 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 5bc9d3b..b73fb78 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -191,3 +191,83 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+static struct cgroup *__cgroup__findnew(struct rb_root *root, uint64_t id,
+					bool create, const char *path)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct cgroup *cgrp;
+
+	while (*p != NULL) {
+		parent = *p;
+		cgrp = rb_entry(parent, struct cgroup, node);
+
+		if (cgrp->id == id)
+			return cgrp;
+
+		if (cgrp->id < id)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	if (!create)
+		return NULL;
+
+	cgrp = malloc(sizeof(*cgrp));
+	if (cgrp == NULL)
+		return NULL;
+
+	cgrp->name = strdup(path);
+	if (cgrp->name == NULL) {
+		free(cgrp);
+		return NULL;
+	}
+
+	cgrp->fd = -1;
+	cgrp->id = id;
+	refcount_set(&cgrp->refcnt, 1);
+
+	rb_link_node(&cgrp->node, parent, p);
+	rb_insert_color(&cgrp->node, root);
+
+	return cgrp;
+}
+
+struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
+			       const char *path)
+{
+	struct cgroup *cgrp;
+
+	down_write(&env->cgroups.lock);
+	cgrp = __cgroup__findnew(&env->cgroups.tree, id, true, path);
+	up_write(&env->cgroups.lock);
+	return cgrp;
+}
+
+struct cgroup *cgroup__find(struct perf_env *env, uint64_t id)
+{
+	struct cgroup *cgrp;
+
+	down_read(&env->cgroups.lock);
+	cgrp = __cgroup__findnew(&env->cgroups.tree, id, false, NULL);
+	up_read(&env->cgroups.lock);
+	return cgrp;
+}
+
+void perf_env__purge_cgroups(struct perf_env *env)
+{
+	struct rb_node *node;
+	struct cgroup *cgrp;
+
+	down_write(&env->cgroups.lock);
+	while (!RB_EMPTY_ROOT(&env->cgroups.tree)) {
+		node = rb_first(&env->cgroups.tree);
+		cgrp = rb_entry(node, struct cgroup, node);
+
+		rb_erase(node, &env->cgroups.tree);
+		cgroup__put(cgrp);
+	}
+	up_write(&env->cgroups.lock);
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 2ec11f0..e98d597 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -3,16 +3,19 @@
 #define __CGROUP_H__
 
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
+#include "util/env.h"
 
 struct option;
 
 struct cgroup {
-	char *name;
-	int fd;
-	refcount_t refcnt;
+	struct rb_node		node;
+	u64			id;
+	char			*name;
+	int			fd;
+	refcount_t		refcnt;
 };
 
-
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
@@ -26,4 +29,10 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
+struct cgroup *cgroup__findnew(struct perf_env *env, uint64_t id,
+			       const char *path);
+struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
+
+void perf_env__purge_cgroups(struct perf_env *env);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4154f94..fadc597 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include "bpf-event.h"
+#include "cgroup.h"
 #include <errno.h>
 #include <sys/utsname.h>
 #include <bpf/libbpf.h>
@@ -168,6 +169,7 @@ void perf_env__exit(struct perf_env *env)
 	int i;
 
 	perf_env__purge_bpf(env);
+	perf_env__purge_cgroups(env);
 	zfree(&env->hostname);
 	zfree(&env->os_release);
 	zfree(&env->version);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 11d05ae..7632075 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -88,6 +88,12 @@ struct perf_env {
 		u32			btfs_cnt;
 	} bpf_progs;
 
+	/* same reason as above (for perf-top) */
+	struct {
+		struct rw_semaphore	lock;
+		struct rb_root		tree;
+	} cgroups;
+
 	/* For fast cpu to numa node lookup via perf_env__numa_node */
 	int			*numa_map;
 	int			 nr_numa_map;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 399b473..97142e9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -33,6 +33,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <internal/lib.h> // page_size
+#include "cgroup.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -654,13 +655,19 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
-int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+int machine__process_cgroup_event(struct machine *machine,
 				  union perf_event *event,
 				  struct perf_sample *sample __maybe_unused)
 {
+	struct cgroup *cgrp;
+
 	if (dump_trace)
 		perf_event__fprintf_cgroup(event, stdout);
 
+	cgrp = cgroup__findnew(machine->env, event->cgroup.id, event->cgroup.path);
+	if (cgrp == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
