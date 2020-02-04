Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37271C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F40B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usojpGLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgBDGYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:24:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42176 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:24:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so8914250pfz.9;
        Mon, 03 Feb 2020 22:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kgwt3mvUxDF/4h5A6PO11Mgg+qixlsRKZ7kH5hXHtOE=;
        b=usojpGLLj57Z3wvu2mPCgoKTiJrkEIIGLCb+lCdufsX39ROV1cpGt0BrxFzldX7piK
         69KYY/OKR14AEUECwXDl9fwl6M5lbWVuk6K0YLcjp7z27uzl7b40leLw1nT88JQU4BJt
         BOiA9t5WK4qD6jS+MDypjUwLaMjB7GX3aTFvA8bWRTdZ4KDSLX6p+hMcTgZgeU31qXjb
         7DLDnpLl3xqLt/kIiuk2lGUnzPHGZS071MUFHWEHODFSrBzTA4e677xNmEvW3+w+pxlY
         MfuCIyXbARgyVPAAAWv7eUbVwjnCfgmRAbVnj1v3xxrOZyfaUFVsraxW3u2A4Mq4raSS
         pcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kgwt3mvUxDF/4h5A6PO11Mgg+qixlsRKZ7kH5hXHtOE=;
        b=aNk6IWHpWBPlXLTUbc6pPgSq0VIl2uhxDW32n6DhVOhv/5gBzqXDJwu1Mwx368SEGK
         fvydJn53Ct8OzEfdmwFNr+SD3sx8kU0fLp+WjE7gtyg33x3KdysCpdK4YknXSX5SDOD9
         QzAU8XIJVdTdLyHQki9R0cYRLjj/1b1wtP6s3ZTxeGGM/ZTADq4adsd4myPVYkvhAenl
         SQx9pKyY8nCRxtispHowUhsjFUIldCl9669KvMljJU0eI2vmDAqQWtdkrpzfe520Zr7i
         drehjl+zrGgcrHpx8ZjVyrItCveqzqLLQ/cGE9IFwgVNos/NPLry1GgqGTc4y91w3NYK
         +A9w==
X-Gm-Message-State: APjAAAX6rUDicFxHPK94GtyeEE2nM4UX6o6+FXmw9c+Tq7dgt7ig3Jkc
        d8iOIvxIRp9hd4MGyI7Rkjs=
X-Google-Smtp-Source: APXvYqye5zn8oWPNMoqgG54z3RMcKwJ+WnAZWJRv0bFoDAjW2POnyjov/s7WAlqBAsIgAe47CwAOQQ==
X-Received: by 2002:a63:3487:: with SMTP id b129mr29614510pga.320.1580797463177;
        Mon, 03 Feb 2020 22:24:23 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id u26sm21880240pfn.46.2020.02.03.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:24:22 -0800 (PST)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        rostedt@goodmis.org, sj38.park@gmail.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] mm/damon: Add a tracepoint for result writing
Date:   Tue,  4 Feb 2020 06:23:08 +0000
Message-Id: <20200204062312.19913-8-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204062312.19913-1-sj38.park@gmail.com>
References: <20200204062312.19913-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON's result buffer writing.  It is
called for each writing of the DAMON results and print the result data.
Therefore, it would be used to easily integrated with other tracepoint
supporting tracers such as perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon.c                   |  4 ++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..fb33993620ce
--- /dev/null
+++ b/include/trace/events/damon.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM damon
+
+#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DAMON_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(damon_write_rbuf,
+
+	TP_PROTO(void *buf, const ssize_t sz),
+
+	TP_ARGS(buf, sz),
+
+	TP_STRUCT__entry(
+		__dynamic_array(char, buf, sz)
+	),
+
+	TP_fast_assign(
+		memcpy(__get_dynamic_array(buf), buf, sz);
+	),
+
+	TP_printk("dat=%s", __print_hex(__get_dynamic_array(buf),
+			__get_dynamic_array_len(buf)))
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index f1d7200f3936..c2a098843936 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,8 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#define CREATE_TRACE_POINTS
+
 #include <linux/damon.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -20,6 +22,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <trace/events/damon.h>
 
 #define damon_get_task_struct(t) \
 	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
@@ -553,6 +556,7 @@ static void damon_flush_rbuffer(struct damon_ctx *ctx)
  */
 static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
 {
+	trace_damon_write_rbuf(data, size);
 	if (!ctx->rbuf_len || !ctx->rbuf)
 		return;
 	if (ctx->rbuf_offset + size > ctx->rbuf_len)
-- 
2.17.1

