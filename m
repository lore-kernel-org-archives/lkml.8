Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B48EC54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981E2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140363;
	bh=zyBV+P73UyLz8o4Hc1phk49tBfasMirh9Dv47zl+hyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XeRR4zfOvaLRRtXoowYkvxihqJeaqyM4jOGVHXQC0wjMPZ/m7EueLNn2kB/BRR7kI
	 CAAZAhRg/NW8Zz92A6SvwbOHkdo6ffWf0AtVbSkJm3CecUG4Jixa2DLV2U+Cv5oOtg
	 zMYNJlIDUJ/RRDinFp5tbltfSabtQNPuwY/JbdmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCYMqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35240 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCYMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so772827plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kW9/sLQIjwWsS2t/myeR9rhJ3uBYPvcqp7lElKcghPU=;
        b=nUOkabJMO0UME33DTztO53dOpO4Xv3QSKvPIm8h191Hjt55XDec/nj+HnMEeunycD5
         U8+ILHN3p0NqjjoxJLWdsmYHP6sX7nxk9Mv8DKnQYYPhiUAT62dkQk3/RFnqNz6LFre7
         HVQmUHTKZmFHbL21wIWh3CJFJt1tvQYxgl3WD3UzV34ShOk5/vaMxLswiFczNQbjkw20
         SoRtnPmSWTH8rHib8Z0Q9Rf9/H1PcdArPPC7LVU1DtsnEwY4P7bHiRQEKc3zj1/ijW2B
         tq4aCQCLcEIpA3sJHAEHZ47IoxypYkectx3f6JkJtVQtXNoWeeTyjbsor5YpT02TUOF0
         6X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kW9/sLQIjwWsS2t/myeR9rhJ3uBYPvcqp7lElKcghPU=;
        b=RRWMMx1FGN0bECCNKDuPZ5QVxKcE48tgk5u7mXGu2DrR8LW5+ik5QF4zZ4s87n9/xk
         XeEFPobG8jYD16weU4FraB8KHWI6XTAEZ0go/xHNJV+8KMlgWHFWiOvQqKJQnv/FBEPR
         HW8kXSjbrn/TTNdOeILHNc7zWgMdDZ8X2cc3dufep7COAqyyTgA1Zd0TMWzYIUoRKpZ6
         nLx9gblIp0SAEu7w7Y71ceVlF2AQKE8fdjgMB+A24V8mtyfSEY90RNYx6/lr0Uxee3nR
         t6/6A4h77CPOIpP5MbSCXv1GLsdAOwz7U/4B5iakC8KR6ciM1eK5Dis947T6LvMdkXHU
         U7OQ==
X-Gm-Message-State: ANhLgQ25EER8TmXGeIKeIwgB/QQJjwAS/mJZNRmAN3fpcFTg2XIA9byy
        ipYoSinwrU3zErhvB8k1jn4+6vgO
X-Google-Smtp-Source: ADFU+vss5ecwBjV2ZE7vymgXWJwj2mtYEZDVgzMIwmgL7NZ7zR49wZ+Wk7drvJUDbyWOcts8mo6DMQ==
X-Received: by 2002:a17:90a:326f:: with SMTP id k102mr3546217pjb.48.1585140359384;
        Wed, 25 Mar 2020 05:45:59 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:45:58 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date:   Wed, 25 Mar 2020 21:45:31 +0900
Message-Id: <20200325124536.2800725-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cgroup is kept in the perf_env's cgroup_tree sorted by the cgroup
id.  Hist entries have cgroup id can compare it directly and later it
can be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c  | 80 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  | 17 +++++++--
 tools/perf/util/env.c     |  2 +
 tools/perf/util/env.h     |  6 +++
 tools/perf/util/machine.c |  9 ++++-
 5 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 5bc9d3b01bd9..b73fb7823048 100644
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
index 2ec11f01090d..e98d5975fe55 100644
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
index 4154f944f474..fadc59708ece 100644
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
index 11d05ae3606a..7632075a8792 100644
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
index 399b4731b246..97142e9671be 100644
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
 
-- 
2.25.1.696.g5e7596f4ac-goog

