Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F059C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE73C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519108;
	bh=uHX7TvSgWnYmcj7c26XlmNYzCakZEYH1/8/nBDkDzJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ujI/GTPWLhb39pFbHgxyElWpOXP9J7G99y/UlTCzU+RIt9VoHuQ5lgkiS4ylplLK4
	 kq6lk06IPHO+RFGL00rbUR6g/bDPPjuFMpZnfLxjLMyk5jPfr/fvMU3RHDYYUA4J/1
	 97aaLW7Xe4FPuBDlDC5agCGcOpksjNm7O9fyQoTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXEi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38628 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so4696660pfc.5;
        Sun, 23 Feb 2020 20:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rW1SGohx9pQ7VHt5AYJmC28iFhWzk0/jK0wiqsp7RDQ=;
        b=swwubmlVKtOmrSu2TYxSyPvdCLLvfkOHuLgXwa1wh1k9q1FCaAm94Xog+InU3illg1
         hI6Eb4+JIupFMCKobgqHStocXddJeEUIdDdnsnj+gUKMPdFCIuS/OZTWV/m7ouSzbiUC
         m84YJss8s3kk1GXNIWZD15M/cXz0wD7xKUOUuiNCKJVOrc6yPnAVbJFb9kzJtko+ikPi
         jcMuRDG4XidTvVUOQcdHE9EJhoG2TzG8dXT9V2+g4pEDTB3R5nshYTc5ZpAl/eK70ecn
         UQJbSkiwnG3pGKDGKL2yPjmGn98PmmchJTpGy6/cYpVw1+D9ZPo+aq8PHZRplI/xiHsF
         B/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rW1SGohx9pQ7VHt5AYJmC28iFhWzk0/jK0wiqsp7RDQ=;
        b=nU4QxUysU8zCuF3IKQl6NPuApTrt+mYaTZQsQ84H/BR0Ea0OFuDwQ2iubBiK6H5epp
         PzWzRCfkiTSwUGgg4U6IEkil9qkt7W1pAjNPhK+q89011d4qigdyY1FkrinflKE8S/kY
         ZxVyBatIHWZW7zUKy0omWbNBuYiX+d8qRmWGsA4Dkimu3renXGbu1+csUWAWDOkFHWBV
         n1pMh2sdOBTC+64RvGouEnemnANy78evJVoRsxtXou8+YZD7yppx9Dugf/0PX18Ye1eQ
         Fv+ApIsUW6zJ4tJzte3esC1NJ5ztohPq0xq+KcGwYsJBXAsWM72rTJFEYg2n6Qd0niQx
         ixmQ==
X-Gm-Message-State: APjAAAVCtT3U76nH23U/iQd/CXQT+ZkUG9XKXCbf/wX3smu3q1Jnk0WJ
        wnybep9AcfKnh48UZCiFfJw=
X-Google-Smtp-Source: APXvYqxeTtHeODxKcklN9imNEzTs7MVJ1iw9lkAvo1GwgvLOrCiC4oabym8gl23ZJV9102JW1jlIZg==
X-Received: by 2002:a63:3688:: with SMTP id d130mr51677974pga.422.1582519097308;
        Sun, 23 Feb 2020 20:38:17 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:16 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 05/10] perf tools: Maintain cgroup hierarchy
Date:   Mon, 24 Feb 2020 13:37:44 +0900
Message-Id: <20200224043749.69466-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
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
index 12e466d1ec3b..3c99f228e749 100644
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
index 6242a9215df7..d299dc25001f 100644
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
index 2c3223bec561..644cbc813e9e 100644
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
2.25.0.265.gbab2e86ba0-goog

