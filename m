Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C328C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgFOKVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:21:17 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44217 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgFOKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:21:15 -0400
Received: by mail-lj1-f169.google.com with SMTP id c17so18459145lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaCS27d5Mrh3uWKULq1Vh+J0+BIEQ7fy6JbxwE4oROw=;
        b=Nm6ELNlQsNDkvbz6E9Y1+WJilBXs2BhHOI2VfAqV0IBx8CrPlGNbSJdCWIbSsIdZJW
         6k5imsKlfJTjMJWGy7GFhk9JGAs79X1cQ+meFVRvxGRURmg/bd6INFgRrf4scV5bWaao
         0ss1KO8nhPHNHh7ld7vHumGIOVrd/t3ajvOr8CEeGOo7uzw0q2WyLhQQBqfsdMOc0Vhn
         GnNycauOnPrfDYoM1dSCVFsD7OJmMe8dzLbxspp4XRCwp/zOhMAeqJyqBu9igr2V9mdf
         1/35C22/QYZitT22hMxSa8m0lslVmE9d5KChYfTumvoVdjwLWoA1z3N5kP4I805DB+sZ
         VpKA==
X-Gm-Message-State: AOAM533eaC9HlbZus28+qBShlSSkSFlw7jwxm1bAwpV14NBDVZ2D+Gsw
        eHfehyNjgeY/XIyF0hmqhPI=
X-Google-Smtp-Source: ABdhPJyK9gauooFsvdM++fovyBVIzX0nMneGpVK9FWUdVfGSCd3cxXAa0xX0xEYt4eEZr2uKAcPtBg==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr13549548ljk.240.1592216470211;
        Mon, 15 Jun 2020 03:21:10 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id l16sm3717858lji.138.2020.06.15.03.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:21:09 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH] coccinelle: misc: add array_size_dup script to detect missed overlow checks
Date:   Mon, 15 Jun 2020 13:20:45 +0300
Message-Id: <20200615102045.4558-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect an opencoded expression that is used before or after
array_size()/array3_size()/struct_size() to compute the same size.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/array_size_dup.cocci | 347 +++++++++++++++++++
 1 file changed, 347 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci

diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
new file mode 100644
index 000000000000..08919a938754
--- /dev/null
+++ b/scripts/coccinelle/misc/array_size_dup.cocci
@@ -0,0 +1,347 @@
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
+expression as.E1;
+expression subE2 <= as.E2;
+expression as.E2;
+expression E3;
+position p1, p2;
+@@
+
+* E1 * E2@p1
+  ... when != \(E1\|E2\|subE1\|subE2\)=E3
+      when != \(E1\|E2\|subE1\|subE2\)+=E3
+      when != \(E1\|E2\|subE1\|subE2\)-=E3
+      when != \(E1\|E2\|subE1\|subE2\)*=E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@as_prev@
+expression subE1 <= as.E1;
+expression as.E1;
+expression subE2 <= as.E2;
+expression as.E2;
+expression E3;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\)=E3
+      when != \(E1\|E2\|subE1\|subE2\)+=E3
+      when != \(E1\|E2\|subE1\|subE2\)-=E3
+      when != \(E1\|E2\|subE1\|subE2\)*=E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* E1 * E2@p2
+
+@as_dup@
+expression subE1 <= as.E1;
+expression as.E1;
+expression subE2 <= as.E2;
+expression as.E2;
+expression E3;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\)=E3
+      when != \(E1\|E2\|subE1\|subE2\)+=E3
+      when != \(E1\|E2\|subE1\|subE2\)-=E3
+      when != \(E1\|E2\|subE1\|subE2\)*=E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@as3@
+expression E1, E2, E3;
+@@
+
+array3_size(E1, E2, E3)
+
+@as3_next@
+expression subE1 <= as3.E1;
+expression as3.E1;
+expression subE2 <= as3.E2;
+expression as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E3;
+expression E4;
+position p1, p2;
+@@
+
+* E1 * E2 * E3@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@as3_prev@
+expression subE1 <= as3.E1;
+expression as3.E1;
+expression subE2 <= as3.E2;
+expression as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E3;
+expression E4;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* E1 * E2 * E3@p2
+
+@as3_dup@
+expression subE1 <= as3.E1;
+expression as3.E1;
+expression subE2 <= as3.E2;
+expression as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E3;
+expression E4;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@ss@
+expression E1, E2, E3;
+@@
+
+struct_size(E1, E2, E3)
+
+@ss_next@
+expression subE1 <= ss.E1;
+expression ss.E1;
+expression subE2 <= ss.E2;
+expression ss.E2;
+expression subE3 <= ss.E3;
+expression ss.E3;
+expression E4;
+position p1, p2;
+@@
+
+* E1 * E2 + E3@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@ss_prev@
+expression subE1 <= ss.E1;
+expression ss.E1;
+expression subE2 <= ss.E2;
+expression ss.E2;
+expression subE3 <= ss.E3;
+expression ss.E3;
+expression E4;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* E1 * E2 + E3@p2
+
+@ss_dup@
+expression subE1 <= ss.E1;
+expression ss.E1;
+expression subE2 <= ss.E2;
+expression ss.E2;
+expression subE3 <= ss.E3;
+expression ss.E3;
+expression E4;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)+=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)-=E4
+      when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\)*=E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+msg = "WARNING: array_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
+
+@script:python depends on report@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
+
+@script:python depends on report@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+msg = "WARNING: same array_size (line %s)" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+msg = "WARNING: same array_size (line %s)" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
+
+
+@script:python depends on report@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+msg = "WARNING: array3_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
+
+@script:python depends on report@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
+
+@script:python depends on report@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+msg = "WARNING: same array3_size (line %s)" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
+
+
+@script:python depends on report@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+msg = "WARNING: struct_size is used down the code (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
+
+@script:python depends on report@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
+
+@script:python depends on report@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+msg = "WARNING: same struct_size (line %s)" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
-- 
2.26.2

