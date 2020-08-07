Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E038C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625A12086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kC/tsEMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHGVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgHGV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:29:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251BC061A2D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:29:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v11so4324062ybm.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YqcIVHjBu4NPaIW6FP/UQkn1mH1Qjgwx8CMe4FP79m0=;
        b=kC/tsEMJKSSFTlfYQ75Bn0L/DjLRTDD0Y8p3TmDAWsIkMY2zUSRHdR9qspxmpESMV1
         AGyJvORrpQmokA+/mFqp3MI9XFQCYXXCINiLLgA5qUCc482Cn88dlyNtpSZ8ZYaTvWdt
         Vb+1QpePZ3pesgDCHtlgI5q2es8R9rRdgGwmiMZXXWVo2c08wP/BqwaOAKfMeWuBi279
         18BzEk6nuFCp89CXK0kgczMt0Pt34W1I3FCBEuxIEAFQ5oinTQijsNNtS3j7cchgC9y9
         oCA2evl6PMZfioWngsEPF3kXhutd7PecJMyg9cjGKCEPldQhAsShAY8SEpHKIUHGbGVH
         /aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YqcIVHjBu4NPaIW6FP/UQkn1mH1Qjgwx8CMe4FP79m0=;
        b=DxmF63xUfqdjvvlcEdDkTNYox0a1dU3w70PSx/CSG2is6KnKJ8zB3lWy1ykbrNgGJA
         m1tGAtTv5XomPqHgkpCAyKpsWoqX3e2wiXRfYCPZhSCWl0NgJCpm/O/gM9kCOqXaWvQ0
         FKOLdxtMp9tIgZcH+uiGmFaBxgE+A9VT320DdYhtXVvTe6/jK3h764Ihn/j1SxAk+63t
         snp/3Nvpql+aidgukmoo0f/6TPFgqm0nVxuEwjo+U8Z4351hqfHO0uP499ZFvMIrL+8D
         UEfE+YuQFK45YssVWBH66OJVF3WeEoJIFyL1gqMLpzCzsDCVrpJE69WqN+0Q6LS+BDGL
         XF2A==
X-Gm-Message-State: AOAM530uNyVicNe/tVFBesUYTqq/Nu2uK+AhKuejgfTMih8cN2XSnD+o
        oEqWHlVEdYk43CqThZ19ES1l2/zqy2QEQhYevC6lppF71XxoKlqTupqHLl/pjK2pUollx7yJhuZ
        9W67NTNmIARPzImTf+atq5KL20iaCy9B9tMICznMo6NFirAtlt+4KymzxYp/3TuyxHCesgAk=
X-Google-Smtp-Source: ABdhPJzL7no4SqOfner8mZRGL7LSd6SVD5kl+gmR3qkYIa0Eg/JlfzKIvlPGiL5n0PLe+YI5aoTTct88tJhU
X-Received: by 2002:a25:8105:: with SMTP id o5mr2771130ybk.495.1596835778097;
 Fri, 07 Aug 2020 14:29:38 -0700 (PDT)
Date:   Fri,  7 Aug 2020 14:29:11 -0700
In-Reply-To: <20200807212916.2883031-1-jwadams@google.com>
Message-Id: <20200807212916.2883031-3-jwadams@google.com>
Mime-Version: 1.0
References: <20200807212916.2883031-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 2/7] core/metricfs: add support for percpu metricfs files
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple mechanism for exporting percpu data through metricfs.
The API follows the existing metricfs pattern.  A percpu file is
defined with:

    METRIC_EXPORT_PERCPU_INT(name, desc, fn)
    METRIC_EXPORT_PERCPU_COUNTER(name, desc, fn)

The first defines a file for exposing a percpu int.  The second is
similar, but is for a counter that accumulates since boot.  The
'name' is used as the metricfs file.  The 'desc' is a description
of the metric.  The 'fn' is a callback function to emit a single
percpu value:

    void (*fn)(struct metric_emitter *e, int cpu);

The callback must call METRIC_EMIT_PERCPU_INT with the value for
the specified CPU.

Signed-off-by: Jonathan Adams <jwadams@google.com>

---

jwadams@google.com: rebased to 5.6-pre6, renamed funcs to start with
	metric_.  This is work originally done by another engineer at
	google, who would rather not have their name associated with this
	patchset. They're okay with me sending it under my name.
---
 include/linux/metricfs.h | 28 +++++++++++++++++++
 kernel/metricfs.c        | 58 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/include/linux/metricfs.h b/include/linux/metricfs.h
index 65a1baa8e8c1..f103dc8c44ec 100644
--- a/include/linux/metricfs.h
+++ b/include/linux/metricfs.h
@@ -22,6 +22,19 @@ void metric_exit_##name(void) \
 	metric_unregister(metric_##name); \
 }
 
+#define METRIC_EXPORT_PERCPU(name, desc, fn, cumulative) \
+static struct metric *metric_##name; \
+void metric_init_##name(struct metricfs_subsys *parent) \
+{ \
+	metric_##name = metric_register_percpu(__stringify(name), (parent), \
+					(desc), (fn), \
+					(cumulative), THIS_MODULE); \
+} \
+void metric_exit_##name(void) \
+{ \
+	metric_unregister(metric_##name); \
+}
+
 /*
  * Metricfs only deals with two types: int64_t and const char*.
  *
@@ -47,6 +60,11 @@ void metric_exit_##name(void) \
 	METRIC_EXPORT_GENERIC(name, (desc), (fname0), (fname1), (fn), \
 				true, false)
 
+#define METRIC_EXPORT_PERCPU_INT(name, desc, fn) \
+	METRIC_EXPORT_PERCPU(name, (desc), (fn), false)
+#define METRIC_EXPORT_PERCPU_COUNTER(name, desc, fn) \
+	METRIC_EXPORT_PERCPU(name, (desc), (fn), true)
+
 /* Subsystem support. */
 /* Pass NULL as 'parent' to create a new top-level subsystem. */
 struct metricfs_subsys *metricfs_create_subsys(const char *name,
@@ -69,6 +87,8 @@ struct metric_emitter;
 	metric_emit_int_value((e), (v), (f0), (f1))
 #define METRIC_EMIT_STR(e, v, f0, f1) \
 	metric_emit_str_value((e), (v), (f0), (f1))
+#define METRIC_EMIT_PERCPU_INT(e, cpu, v) \
+	metric_emit_percpu_int_value((e), (cpu), (v))
 
 /* Users don't have to call any functions below;
  * use the macro definitions above instead.
@@ -77,6 +97,7 @@ void metric_emit_int_value(struct metric_emitter *e,
 			   int64_t v, const char *f0, const char *f1);
 void metric_emit_str_value(struct metric_emitter *e,
 			   const char *v, const char *f0, const char *f1);
+void metric_emit_percpu_int_value(struct metric_emitter *e, int cpu, int64_t v);
 
 struct metric *metric_register(const char *name,
 			       struct metricfs_subsys *parent,
@@ -98,6 +119,13 @@ struct metric *metric_register_parm(const char *name,
 				    bool is_cumulative,
 				    struct module *owner);
 
+struct metric *metric_register_percpu(const char *name,
+			       struct metricfs_subsys *parent,
+			       const char *description,
+			       void (*fn)(struct metric_emitter *e, int cpu),
+			       bool is_cumulative,
+			       struct module *owner);
+
 void metric_unregister(struct metric *m);
 
 #endif /* _METRICFS_H_ */
diff --git a/kernel/metricfs.c b/kernel/metricfs.c
index 676b7b04aa2b..992fdd9a4d0a 100644
--- a/kernel/metricfs.c
+++ b/kernel/metricfs.c
@@ -76,6 +76,8 @@ struct metric {
 	bool is_string;
 	bool is_cumulative;
 	bool has_parm;
+	bool is_percpu;
+	void (*percpu_fn)(struct metric_emitter *e, int cpu);
 
 	/* dentry for the directory that contains the metric */
 	struct dentry *dentry;
@@ -285,6 +287,19 @@ void metric_emit_str_value(struct metric_emitter *e, const char *v,
 }
 EXPORT_SYMBOL(metric_emit_str_value);
 
+void metric_emit_percpu_int_value(struct metric_emitter *e, int cpu, int64_t v)
+{
+	char *ckpt = e->buf;
+	bool ok = true;
+
+	ok &= emit_int(e, cpu);
+	ok &= emit_string(e, " ");
+	ok &= emit_int(e, v);
+	ok &= emit_string(e, "\n");
+	if (!ok)
+		e->buf = ckpt;
+}
+
 /* Contains file data generated at open() */
 struct metricfs_file_private {
 	size_t bytes_written;
@@ -400,11 +415,15 @@ static int metricfs_fields_open(struct inode *inode, struct file *filp)
 	}
 	ok &= emit_string(&e, "value\n");
 
-	if (m->fname0)
-		ok &= emit_string(&e, "str ");
-	if (m->fname1)
-		ok &= emit_string(&e, "str ");
-	ok &= emit_string(&e, (m->is_string) ? "str\n" : "int\n");
+	if (m->is_percpu) {
+		ok &= emit_string(&e, "int int\n");
+	} else {
+		if (m->fname0)
+			ok &= emit_string(&e, "str ");
+		if (m->fname1)
+			ok &= emit_string(&e, "str ");
+		ok &= emit_string(&e, (m->is_string) ? "str\n" : "int\n");
+	}
 
 	/* Emit all or nothing. */
 	if (ok) {
@@ -640,6 +659,35 @@ struct metric *metric_register(const char *name,
 }
 EXPORT_SYMBOL(metric_register);
 
+static void metric_emit_percpu(struct metric_emitter *e)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		e->metric->percpu_fn(e, cpu);
+}
+
+struct metric *metric_register_percpu(const char *name,
+				struct metricfs_subsys *parent,
+				const char *description,
+				void (*fn)(struct metric_emitter *e, int cpu),
+				bool is_cumulative,
+				struct module *owner)
+{
+	struct metric *metric =
+		metric_register(name, parent, description,
+				"cpu", NULL,
+				metric_emit_percpu,
+				false,
+				is_cumulative, owner);
+	if (metric) {
+		metric->is_percpu = true;
+		metric->percpu_fn = fn;
+	}
+	return metric;
+}
+EXPORT_SYMBOL(metric_register_percpu);
+
 struct metric *metric_register_parm(const char *name,
 				    struct metricfs_subsys *parent,
 				    const char *description,
-- 
2.28.0.236.gb10cc79966-goog

