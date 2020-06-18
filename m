Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5C7212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFRKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:24:20 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36702 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFRKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:23:43 -0400
Received: by mail-lf1-f43.google.com with SMTP id c21so3153706lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubgAniuLZwUefX9aPUKilP2kkhN35Iuff9mjSqyql7k=;
        b=Ub3QDkEkHyUNMF5dun93zgcGKovmInoZROM5J3YX6oz40nQiXT8AM9HZm1jZf/mosl
         1SdOqCoB+CvKFwzGbwltHakO8gN038P+0nB+WQZY59lvpn0Eh5zR5OzsKZtipfSXGblK
         VvYZjUbvd+g50OZ2TmRqLvWfUtfMOmJZ/wu5PEeG3G5TA8/ZodFrN2ho3i3Jaayux/Jx
         Bd7KD8hv+HJcf5eXem9co0SG1G0ZvUrtZIzxkVIYnzZYglK2V/pO1WuAv47nfyryXbIZ
         kN8QaX8sfRSSE5I/c/wXhBiglzOhCZ1BTM9gfIgDBrjs+rvRN5UNLKih0LxGwbnR6U1h
         jdVg==
X-Gm-Message-State: AOAM533lzOVAGM1CWtdPCvvURz9vduevwMUnQ1fqPDUPdQhlIUulCuyq
        WCtgQxGDXljkcW8zPno9TAw=
X-Google-Smtp-Source: ABdhPJyHZwVg/wsvx7Lo95dRSERAP076Soy/X4/VnowSrs0AGcQdBE10aNp54yu2cNcAx4SXqni7TA==
X-Received: by 2002:a05:6512:308e:: with SMTP id z14mr2000619lfd.29.1592475819472;
        Thu, 18 Jun 2020 03:23:39 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.195])
        by smtp.googlemail.com with ESMTPSA id z13sm657226lfd.7.2020.06.18.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:23:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] coccinelle: misc: add array_size_dup script to detect missed overlow checks
Date:   Thu, 18 Jun 2020 13:23:08 +0300
Message-Id: <20200618102308.7305-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect an opencoded expression that is used before or after
array_size()/array3_size()/struct_size() to compute the same size.

Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - python rules moved next to SmPL patterns
 - assignment operator used
 - struct_size patterns fixed to check only E3, since
   E1, E2 are sizeofs of a structure and a member
   of a structure

 scripts/coccinelle/misc/array_size_dup.cocci | 309 +++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci

diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
new file mode 100644
index 000000000000..c5214310285c
--- /dev/null
+++ b/scripts/coccinelle/misc/array_size_dup.cocci
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for array_size(), array3_size(), struct_size() duplicates.
+/// Three types of patterns for these functions:
+///  1. An opencoded expression is used before array_size() to compute the same size
+///  2. An opencoded expression is used after array_size() to compute the same size
+///  3. Consecutive calls of array_size() with the same values
+/// From security point of view only first case is relevant. These functions
+/// perform arithmetic overflow check. Thus, if we use an opencoded expression
+/// before a call to the *_size() function we can miss an overflow.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers --no-loops
+
+virtual context
+virtual report
+virtual org
+
+@as@
+expression E1, E2;
+@@
+
+array_size(E1, E2)
+
+@as_next@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@script:python depends on report@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: array_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: array_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@as_prev@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* E1 * E2@p2
+
+@script:python depends on report@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: array_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: array_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@as_dup@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@script:python depends on report@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same array_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same array_size (line {p1[0].line})")
+
+@as3@
+expression E1, E2, E3;
+@@
+
+array3_size(E1, E2, E3)
+
+@as3_next@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2 * E3@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@as3_prev@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* E1 * E2 * E3@p2
+
+@script:python depends on report@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: array3_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: array3_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@as3_dup@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same array3_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same array3_size (line {p1[0].line})")
+
+@ss@
+expression E1, E2, E3;
+@@
+
+struct_size(E1, E2, E3)
+
+@ss_next@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2 + E3@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@ss_prev@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* E1 * E2 + E3@p2
+
+@script:python depends on report@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: struct_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: struct_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@ss_dup@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same struct_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same struct_size (line {p1[0].line})")
-- 
2.26.2

