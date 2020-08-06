Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24126C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB3F22CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeE7SgCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHFAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHFAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:14:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B80C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:14:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b127so41433400ybh.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YqcIVHjBu4NPaIW6FP/UQkn1mH1Qjgwx8CMe4FP79m0=;
        b=FeE7SgCz8WWFMkou9Tnr78Mwm3q6vCAhlVZTyqYKFbxu8i2KzChMjJkvNcMyciabDp
         xo7h/UsxZbk61KSYwVKvQZ/ZDHlP+z39FmRFy6VI8LOC5rxUMwqerJg588DPlJ2gGy1d
         DrxYXj4s0BsYe9XSRQhGNNllRdRmP/UReGayc3uv10mRbE8iNeZBXOKovpSgaT5ImYX9
         HHvT/SFMAZQKWLkjec56uONDfcny+55j3abdPzK+/vScstVN4GHCvCNQrrksmL7Vt+Yu
         7Evn07eYh5Jl4SrXJUEJiu0VqV0NemvNu1LDDG3KJjl1GS03uOdEAzKKLFx1mDx8qWua
         9tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YqcIVHjBu4NPaIW6FP/UQkn1mH1Qjgwx8CMe4FP79m0=;
        b=knnJN08rdW2XMtIrKEXk1XgjZnWUqIrHB6TKNjTZjgaboJnDmAuyct6WcQYo49CaUd
         6rajInvIE6lP6WmBg24I2ABgaVQVLV7tm19hGNeFsIfA9+kp7CHyb2ntcPYxaguRCYjE
         islf0dL58e/afnwVCnoU9nqaZ5WVHYvyuYrucbPtP31EZa8aEm6Gd05RML6Rk87MCdkv
         /Pflx9UzXZYysavKuOQAfTu/NCoM0n6ypEYlp4txnWwOwO8UP4lR/X7bcMUdgED0KK6L
         jIwhNW6BiH5tCY9jvP538oTUjuGHmfPvqLygn+n+79dxxpl/khUg47irgXstCRXqLdr4
         G3HA==
X-Gm-Message-State: AOAM533VKtZacAMK7rRt/5wcNsFKEr4X0lchQtod2UmBmuGXK09IZE9s
        HQ0MiuM5nS7KTTKZEIEhhxxqnkO0RHYFdrseO+1Uhf93R4r3llyqsh9I4xtvSJQgPQ1Bkkhj11U
        75UjkZGm006ZfLlYNgk1aaYEGmzuSj5yffr8JS84uxwfO6J9nd8Qn0k+gA/p1sQBBKtSGkLQ=
X-Google-Smtp-Source: ABdhPJxLtShr6LPizfcQkY9DLVyYaO9zyiwlYpw33yQivltE7+HhqBxo6h2zQ/va2DUbdvQgX0CpfQoMLmgL
X-Received: by 2002:a25:1f55:: with SMTP id f82mr9113960ybf.103.1596672881738;
 Wed, 05 Aug 2020 17:14:41 -0700 (PDT)
Date:   Wed,  5 Aug 2020 17:14:26 -0700
In-Reply-To: <20200806001431.2072150-1-jwadams@google.com>
Message-Id: <20200806001431.2072150-3-jwadams@google.com>
Mime-Version: 1.0
References: <20200806001431.2072150-1-jwadams@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [RFC PATCH 2/7] core/metricfs: add support for percpu metricfs files
From:   Jonathan Adams <jwadams@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

