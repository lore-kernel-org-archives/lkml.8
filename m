Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB40A20722
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHDGdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:33:24 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37089 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:33:24 -0400
Received: by mail-lj1-f169.google.com with SMTP id w14so12444758ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 23:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qeu5MDd4KBBCgrdFklrimt69m51WRq2SozOPA79zyA0=;
        b=ZFtJ5wmIHfAojriwz8+ynlXzi6vWR1x21gIH+1EktMA1mQyl1HDsLWe3f792ABtxVl
         YgI9iQNlyNxEctYfeIQD51XyfI1T0kd+/tJXLJVrcmNqH3P4iRbUbw4bz0kZGYRwDdpx
         FJ3KBzYgY2osaOLLgrY3Wo2zyTLcgr8zWH4yQiPgThCF4dFjfWv6iWCPSuJUitclz2y6
         JlhJIjETMP0hRGgse6FyVTTMhMyY+1pfw2zYQ9kOACyTaBe2z2PrQao3yX+9jNNtfotK
         /PdGFR5l7nzCjAaBo4FfIMCcdDWpPBxb/EtS4EACMjZ/B1NKfR7QKSok9w5WRLqQrnrk
         fasw==
X-Gm-Message-State: AOAM530cw6L7cfnD8sijHKwqf5ufL+iuPPHzsYHKLVNNF5lG6jA3OPrx
        GyJqoUmBibqG39G/rvW/YjMsMkQE
X-Google-Smtp-Source: ABdhPJxvR5yrqcUJ2/9DRAG7rLbEfRcNzZ1De7ZgEmZ/4U/tGqD0OQCp0Yj/iwH6U1nwMTPZGQ1Rmg==
X-Received: by 2002:a2e:80a:: with SMTP id 10mr9713537lji.103.1596522800505;
        Mon, 03 Aug 2020 23:33:20 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id b16sm5086244ljk.24.2020.08.03.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 23:33:19 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] coccinelle: api: add kvmalloc script
Date:   Tue,  4 Aug 2020 09:32:45 +0300
Message-Id: <20200804063245.8383-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803105601.12162-1-efremov@linux.com>
References: <20200803105601.12162-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggest kvmalloc, kvfree instead of opencoded patterns.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - binary operator cmp added
 - NULL comparisions simplified
 - "T x" case added to !patch mode
Changes in v3:
 - kvfree rules added

 scripts/coccinelle/api/kvmalloc.cocci | 188 ++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..2cb9281cc092
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find if/else condition with kmalloc/vmalloc calls.
+/// Suggest to use kvmalloc instead. Same for kvfree.
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
+@initialize:python@
+@@
+filter = frozenset(['kvfree'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@kvmalloc depends on !patch@
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
+@kvfree depends on !patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+* if (is_vmalloc_addr(E))@p {
+    ...
+*   vfree(E)
+    ...
+  } else {
+    ... when != krealloc(E, ...)
+        when any
+*   \(kfree\|kzfree\)(E)
+    ...
+  }
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
+@depends on patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+- if (is_vmalloc_addr(E))@p
+-   vfree(E);
+- else
+-   kfree(E);
++ kvfree(E);
+
+@script: python depends on report@
+p << kvmalloc.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << kvmalloc.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on report@
+p << kvfree.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvfree")
+
+@script: python depends on org@
+p << kvfree.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvfree")
-- 
2.26.2

