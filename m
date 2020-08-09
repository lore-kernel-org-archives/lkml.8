Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3275A206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHIV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 17:27:13 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38004 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 17:27:12 -0400
Received: by mail-lj1-f170.google.com with SMTP id m22so7437045ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 14:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+0cPGM3bRsE7YkU0y2eQl4qVGY5GO2VaxSnu9p+qWk=;
        b=bvTEEGRjdmMQmoWiieDZXptvFAM10aNifoYPcMgIan2n/G9AJAG+0z6pUi0aEORTUH
         O4fjnytd9+Jv1+amEBCnugLYXt5jGmkpiy1L0sDrXoFmVU9tmu+q1H01rwwYErEWLJBq
         /weV04BPN+Kt4QLaQazfpGnTz1Bck/QuhOkpDZZIkkz/n2mXRUEzNS16mBK6u93udBRe
         Ix2EnTQJNgT5S4vI5AWF6IxEBGUsBuHPwe4kZ+GmR8roLmWAxeFs+xi2XM2AsoVpg+Kt
         wNKgxKGo3KXiUyD+StXA7q0fV6vP2SIqaaNfxtcF6T0oLQO1ha8ysIyUsLrd3oLmioyS
         4iSg==
X-Gm-Message-State: AOAM5324a/Dn9vO1l6Nlsa4TtgBW6/vnRRnn9YnnP8GwzgxPjejgoRq8
        qw2b0vnejy8Hp+hpUCJ0pQo=
X-Google-Smtp-Source: ABdhPJywEO7G7AjBEBjlke7hxs6urEH6pmbyTMrO5IqAjs+lVoCFfvgzB6RBDCyMWzMcpThbsBF+9w==
X-Received: by 2002:a2e:9bc8:: with SMTP id w8mr10166240ljj.351.1597008429929;
        Sun, 09 Aug 2020 14:27:09 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id b204sm9684239lfd.48.2020.08.09.14.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 14:27:09 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH v2] coccinelle: misc: add flexible_array.cocci script
Date:   Mon, 10 Aug 2020 00:26:55 +0300
Message-Id: <20200809212655.58457-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200806220342.25426-1-efremov@linux.com>
References: <20200806220342.25426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
arrays") marks one-element and zero-length arrays as deprecated. Kernel
code should always use "flexible array members" instead.

The script warns about one-element and zero-length arrays in structs.

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - all uapi headers are now filtered-out. Unfortunately, coccinelle
   doesn't provide structure names in Location.current_element.
   For structures the field is always "something_else". Thus, there is
   no easy way to create a list of existing structures in uapi headers
   and suppress the warning only for them, but not for the newly added
   uapi structures.
 - The pattern doesn't require 2+ fields in a structure/union anymore.
   Now it also checks single field structures/unions.
 - The pattern simplified and now uses disjuction in array elements
   (Thanks, Markus)
 - Unions are removed from patch mode
 - one-element arrays are removed from patch mode. Correct patch may
   involve turning the array to a simple field instead of a flexible
   array.

On the current master branch, the rule generates:
 - context: https://gist.github.com/evdenis/e2b4323491f9eff35376372df07f723c
 - patch: https://gist.github.com/evdenis/46081da9d68ecefd07edc3769cebcf32

 scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 scripts/coccinelle/misc/flexible_array.cocci

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
new file mode 100644
index 000000000000..bf6dcda1783e
--- /dev/null
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Zero-length and one-element arrays are deprecated, see
+/// Documentation/process/deprecated.rst
+/// Flexible-array members should be used instead.
+///
+//
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@initialize:python@
+@@
+def relevant(positions):
+    for p in positions:
+        if "uapi" in p.file:
+             return False
+    return True
+
+@r depends on !patch@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  struct {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+)
+
+@depends on patch exists@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+|
+  struct {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+)
+
+@script: python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: use flexible-array member instead"
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING: use flexible-array member instead"
+coccilib.org.print_todo(p, msg)
-- 
2.26.2

