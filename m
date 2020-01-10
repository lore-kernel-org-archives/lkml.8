Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7084C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725C206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwmYd2i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgAJW4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:56:35 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:39095 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgAJW4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:56:35 -0500
Received: by mail-pj1-f73.google.com with SMTP id c67so2185703pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O2TW+0xx2ydGA1JltCBO6ce0n6L32Sj6Px20PLkhi9o=;
        b=OwmYd2i2dRcsQOzGMX3tDQQ0hHB4UIxx9Vv0kQnOJb2Hv/Wq/TYnahbvKrmgElmGla
         DS5xGmrUEO5PVg3TRf+OsGGAyPo9YVgOqPaxtAjlGTtaDJHRNhi/Qc7GnBR2xlKNkpyv
         p3Qv5arwkGTluXHf2fgQ3xFAiQgxdAH7eLAvy2PJ/ewqMhINKfNaa5Xfhz1tkzuFn60y
         Tc6H4/M35/7nuMnNbxfRgk4PAciApfI40ZoD+dZfi8Xm4j6gs6HgxIz6na5zJJvE4BbV
         953T1GCA5Zduo6bRhpwx2SC+UUXSVXS2lsglJRsLoHuU+XGqW/f1LfHeLv3BaMRxSoDT
         tA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O2TW+0xx2ydGA1JltCBO6ce0n6L32Sj6Px20PLkhi9o=;
        b=NAWggXEUL1Bom5FaKPrahTgn4wv4DvJAeI2mw4JiUPTHl2CIAjo0XkLJeEGJBNq/l5
         PEjBkDa4nSCZSZh3rqVTR7RY+yws5sPH/YKRQ9hpT8vwRNM4+pimLYhnnqn0z1vu5xim
         HVtgNaRYo3beJBlNSIOzMefCVz61QEbjNbEJvcL4+Z5OdgzaSN4XbnQunRlLKI81F4A0
         TQEhovd8Uf7pnUeExuH74xWYtFvKbNcxg3RjTVNfXfuOLQOFilKNEgldAopmOuPoqKLg
         94s6YXOrmtV9nUMdtGT1xcIwu+1Vm59RamN9W5fCr0o0Jo9L/r6e+kMa8Ggrohrz4yUb
         gDyQ==
X-Gm-Message-State: APjAAAXMuURc/m7qfg+JqrOAR7+GNm+3s++6i8Vbo1ERQQPyZCzhVyIo
        PXMYJoO9ZLbUQ2nQA+ZEHILkLBOEsK1eAQr57go=
X-Google-Smtp-Source: APXvYqzwkm0nh3WobYMrSyPqH3avdsc/Sp2/cfmVKoeGfWsMFNsYN6ZZ/yvCZ0e/tcGXC2McPsjRwF6KGYBKZRYQ0gk=
X-Received: by 2002:a63:d108:: with SMTP id k8mr7129230pgg.434.1578696994476;
 Fri, 10 Jan 2020 14:56:34 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:56:02 -0800
Message-Id: <20200110225602.91663-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] lib/list_sort: fix function type mismatches
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        George Spelvin <lkml@sdf.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting the comparison function to a different type trips indirect call
Control-Flow Integrity (CFI) checking. Remove the additional consts from
cmp_func, and the now unneeded casts.

Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 lib/list_sort.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 52f0c258c895..b14accf4ef83 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 
 typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
-		struct list_head const *, struct list_head const *);
+		struct list_head *, struct list_head *);
 
 /*
  * Returns a list organized in an intermediate format suited
@@ -227,7 +227,7 @@ void list_sort(void *priv, struct list_head *head,
 		if (likely(bits)) {
 			struct list_head *a = *tail, *b = a->prev;
 
-			a = merge(priv, (cmp_func)cmp, b, a);
+			a = merge(priv, cmp, b, a);
 			/* Install the merged result in place of the inputs */
 			a->prev = b->prev;
 			*tail = a;
@@ -249,10 +249,10 @@ void list_sort(void *priv, struct list_head *head,
 
 		if (!next)
 			break;
-		list = merge(priv, (cmp_func)cmp, pending, list);
+		list = merge(priv, cmp, pending, list);
 		pending = next;
 	}
 	/* The final merge, rebuilding prev links */
-	merge_final(priv, (cmp_func)cmp, head, pending, list);
+	merge_final(priv, cmp, head, pending, list);
 }
 EXPORT_SYMBOL(list_sort);

base-commit: ac61145a725ab0411c5f8ed9aeca6202076ecfd8
-- 
2.25.0.rc1.283.g88dfdc4193-goog

