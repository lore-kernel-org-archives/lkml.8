Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1290EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC75E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgGTQXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:23:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38851 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbgGTQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:23:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id t9so10046456lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lKzMgNHSZBwMM73IvRnAjP9uhf7arni1ElfIUbtptY=;
        b=F3j3S8bFZayIwcwZZb7GCSuxjRH3w0kWjdV1izArfMOfD32TnJDqFMesD22uA0Mtpx
         giqwbPvWSxYzbSJqoHvY98MYtwBV/N2UX4bdLSv5B/CZX9/OxNc/tlW4nnrD8oJGtKxF
         stfBrpWqC67FT4cYhQTd1GJ0cr9pOqg5dvpXgOYZ8pDrAhN6j1iUYvL5O4VMWdd7FeWn
         eKoCuu72yWqIUjEfAD7AIq0BvQeY1FOGdnIY8FTvyl7jOttdD0PXdMlNqKw81qyUK/j8
         6XMVolLxB2zEwekVB3SgfQfucbML32UcLtT6hlQcxqkFUNElJyk9Kj1UuZ8mjubVcyyE
         qi+A==
X-Gm-Message-State: AOAM533UWNinRzgvfcR9vqb7Wi2zBFxa/ozy09KT1KQGI9d+/rV9Bw1j
        6GJTSw00/EgOVHYqD3Atc2E=
X-Google-Smtp-Source: ABdhPJzjRxThU/ubx1ubrqCrZKttqYgYO0o/ua6iV1P8zBoIJT5x5Ap/Vv4slkqGwX81dZZvnnRAVg==
X-Received: by 2002:a19:414b:: with SMTP id o72mr10899004lfa.86.1595262182808;
        Mon, 20 Jul 2020 09:23:02 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:23:02 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] coccinelle: api: extend memdup_user rule with vmemdup_user()
Date:   Mon, 20 Jul 2020 19:22:15 +0300
Message-Id: <20200720162216.13248-3-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
References: <20200720162216.13248-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vmemdup_user() transformations to the memdup_user.cocci rule.
Commit 50fd2f298bef ("new primitive: vmemdup_user()") introduced
vmemdup_user(). The function uses kvmalloc with GPF_USER flag.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 0e29d41ecab8..60027e21c5e6 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -39,6 +39,28 @@ identifier l1,l2;
 -    ...+>
 -  }
 
+@depends on patch@
+expression from,to,size;
+identifier l1,l2;
+@@
+
+-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
++  to = vmemdup_user(from,size);
+   if (
+-      to==NULL
++      IS_ERR(to)
+                 || ...) {
+   <+... when != goto l1;
+-  -ENOMEM
++  PTR_ERR(to)
+   ...+>
+   }
+-  if (copy_from_user(to, from, size) != 0) {
+-    <+... when != goto l2;
+-    -EFAULT
+-    ...+>
+-  }
+
 @r depends on !patch@
 expression from,to,size;
 position p;
@@ -52,6 +74,17 @@ statement S1,S2;
    if (copy_from_user(to, from, size) != 0)
    S2
 
+@rv depends on !patch@
+expression from,to,size;
+position p;
+statement S1,S2;
+@@
+
+*  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
+   if (to==NULL || ...) S1
+   if (copy_from_user(to, from, size) != 0)
+   S2
+
 @script:python depends on org@
 p << r.p;
 @@
@@ -63,3 +96,15 @@ p << r.p;
 @@
 
 coccilib.report.print_report(p[0], "WARNING opportunity for memdup_user")
+
+@script:python depends on org@
+p << rv.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for vmemdup_user")
+
+@script:python depends on report@
+p << rv.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
-- 
2.26.2

