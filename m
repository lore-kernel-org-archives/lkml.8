Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08737C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEF1207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHCS54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33993 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id z14so3240074ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QdS0fy0Eqxo2sy6ZpyXla/1BB0SZsD0LwltC3usfSw=;
        b=QTzsLSomQVybgBr4LcldoQ6b/RqYdfHQUOLgV8KwkyY1CSSUCJLYWfmAPGCimdp82s
         r41cYdaXFnLoplGmmIovxeVn6kplXTv6rUrdvIzIHW1WQmwPGWDOTILmM0yyAuhEdgYn
         gtf6M1CzpGi/uPgCOHl5Za+J783KjDJ0W2dG5w5+/EmBJ+x6VnctfYWlAZ8pw5pkPtix
         UdQGIlUN/Gnoq070BvTWKlxNcomYoIIgUAuN4GOvCuK2qZfkJCammJoVAghNBb6nzxmJ
         h5oa7O40lPhV+TEzqO7DCXbMrNtyTOwtIHncMgSLyEWGnRK/9LhhDaIxMQOJguLvXEU4
         FB1Q==
X-Gm-Message-State: AOAM532bNQ9ehndCVbe4CUycULG9N53qPsJgZ+/M+o7fZ1RuDSKo4lyQ
        4dTXo8wnlnEoDhhfHYQ1jkc=
X-Google-Smtp-Source: ABdhPJwR24ba6sf0nTdpjdIarESYwacwL6Hv7073yML11fbIURk6Uk+CPKNRuICs5SO/OBiuNQXQSQ==
X-Received: by 2002:a2e:804b:: with SMTP id p11mr9084289ljg.221.1596481073216;
        Mon, 03 Aug 2020 11:57:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id r8sm3042645lfm.42.2020.08.03.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:52 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: api: add kvmalloc script
Date:   Mon,  3 Aug 2020 21:57:49 +0300
Message-Id: <20200803185749.39034-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803105601.12162-1-efremov@linux.com>
References: <20200803105601.12162-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggest kvmalloc instead of opencoded kmalloc && vmalloc condition.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - binary operator cmp added
 - NULL comparisions simplified
 - "T x" case added to !patch mode

 scripts/coccinelle/api/kvmalloc.cocci | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..20b22e3d0f74
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find if/else condition with kmalloc/vmalloc calls.
+/// Suggest to use kvmalloc instead.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@opportunity depends on !patch@
+expression E, E1, size;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier x;
+type T;
+position p;
+@@
+
+(
+* if (size cmp E1 || ...)@p {
+    ...
+*    E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+    ...
+  } else {
+    ...
+*    E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (E == NULL)@p {
+    ...
+*   E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* T x = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*         kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...);
+  ... when != x = E1
+      when != size = E1
+      when any
+* if (x == NULL)@p {
+    ...
+*   x = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@depends on patch@
+expression E, E1, flags, size, node;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier x;
+type T;
+@@
+
+(
+- if (size cmp E1)
+-    E = kmalloc(size, flags);
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, flags, node);
+)
+
+@script: python depends on report@
+p << opportunity.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << opportunity.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
-- 
2.26.2

