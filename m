Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1481E206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 21:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgFNVyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:54:09 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:41050 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgFNVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 17:54:09 -0400
Received: by mail-lf1-f49.google.com with SMTP id u16so8371704lfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 14:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exuwoJRcicaA0UCuHwfbQdxe2r5HN92fxJmC6sAbWzI=;
        b=CaT6xpuZiTte0b2JCUJofgY+CWE4Nzh5Gz2bnfypLkk/1I8JshVByig1mXCYmi2T5o
         pjA2wDwNrPw6hZR5aKNALwaYYol88iSzMR6Z4FFow9Rec9SyhHEpr9TKY7BML8IFCN9S
         r1gPbMAVp2etKqCyJ6rBnEBCCPpxdVm9SngcqQ6ImcEPhUM3FHwgchYoHie4LNg0K3G7
         Xss6fkzEUpIqopRA7BmdwuciHRe1LRGydRWVXhE3IOPC24ef0FfgbLLmVDn4lPTtahuS
         bvqCgZyy4BxzcCaiYzwUQixMDGn1cWy58B/HmoU+k+SqD8ZQwaMwskUNaOar5HZNLySA
         wFtA==
X-Gm-Message-State: AOAM5319LvPcu9qVyL4FVLtTnN4gYlZNUJ0YRTzUmNQMhz600qeMCtAS
        owFF0Yt6KAh4+ty6azuTy0kzo2bw9Hw=
X-Google-Smtp-Source: ABdhPJz1YZTJNXqbMcTdX5Y2lYQHHOcc8cpxCKrcEhwrlQvnmP0ytzbdjeQZbhp7FMrpAuh2f6jEYQ==
X-Received: by 2002:a19:8305:: with SMTP id f5mr5845453lfd.173.1592171645720;
        Sun, 14 Jun 2020 14:54:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id g5sm3467254ljk.93.2020.06.14.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 14:54:04 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] coccinelle: api: add kzfree script
Date:   Mon, 15 Jun 2020 00:54:14 +0300
Message-Id: <20200614215414.40034-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - memset_explicit() added
 - kvfree_sensitive() added
 - forall added to r1
 - ... between memset and kfree added
Changes in v3:
 - Explicit filter for definitions instead of !(file in "...") conditions
 - type T added to match casts
 - memzero_explicit() patterns fixed
 - additional rule "cond" added to filter false-positives

 scripts/coccinelle/api/kzfree.cocci | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..4758ca5a781e
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree, kvfree_sensitive rather than memset or
+/// memzero_explicit followed by kfree
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kzfree, kvfree_sensitive
+//
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+@initialize:python@
+@@
+# kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
+filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@cond@
+position ok;
+@@
+
+if (...)
+  \(memset@ok\|memzero_explicit@ok\)(...);
+
+@r depends on !patch forall@
+expression E;
+position p : script:python() { relevant(p) };
+position m != cond.ok;
+type T;
+@@
+
+(
+* memset@m((T)E, 0, ...);
+|
+* memzero_explicit@m((T)E, ...);
+)
+  ... when != E
+      when strict
+* \(kfree\|vfree\|kvfree\)(E)@p;
+
+@rp_memzero depends on patch@
+expression E, size;
+position p : script:python() { relevant(p) };
+type T;
+@@
+
+- memzero_explicit((T)E, size)@p;
+  ... when != E
+      when strict
+- \(kfree\|vfree\|kvfree\)(E);
++ kvfree_sensitive(E, size);
+
+@rp_memset depends on patch@
+expression E, size;
+position p : script:python() { relevant(p) };
+type T;
+@@
+
+- memset((T)E, size)@p;
+  ... when != E
+      when strict
+(
+- kfree(E);
++ kzfree(E);
+|
+- \(vfree\|kvfree\)(E);
++ kvfree_sensitive(E, size);
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING: opportunity for kzfree/kvfree_sensitive")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING: opportunity for kzfree/kvfree_sensitive")
-- 
2.26.2

