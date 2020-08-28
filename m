Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6512098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH1QcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:32:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36937 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgH1QcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:32:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id w14so1991553ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MTrVSpZ9C8pbL/8BIE49vy9556f5oKETpreng4WhtvM=;
        b=fKVRQrmnM2Rp0E2xNGeZVHdD5Qrdk/gU92L9MigEKw27EU0+kqqbvCI2eJPclOr7XN
         F0GHWsrtDbKIuJinuoTmBUFtTcX3iC3Lnv8Cz5OwHWoS8l2WC2BTWNaHYP5jhlXtQXMx
         3hYEtQv8fCj+KRvQ91p1HCVwpdcJj3cXfTbPvrSMLvC/sLezksKhVQ/YmlIiM+DgtHkg
         7b2R9XLT51ffLSTIkBe02bspoxMfiMKVI0DbKoQcbBXBO4Ol6h6o0bVPh9gUIMOqwRPw
         EfqL5MOU36OCnuMjkra4faNsIJsADT/sZn0Ln6dN/qsCNZQc1NByrC0s92mG3q9peuyT
         952w==
X-Gm-Message-State: AOAM533Vj19UIGpjpN2HUE3BcKhHD3EWeKl9zAfoT+hMrXPzFFghEj0O
        CGVtrVw5AE3+TOotD5OYtr1VDuTtO08=
X-Google-Smtp-Source: ABdhPJxVhozefzKCWuOnKCweTEB6t3+HJdnKnvpGPQLql/uMye5UbfzGnGlvc9KOk15WHazGtYLUXg==
X-Received: by 2002:a2e:918e:: with SMTP id f14mr1210827ljg.66.1598632327161;
        Fri, 28 Aug 2020 09:32:07 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id w6sm397882lfn.73.2020.08.28.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 09:32:06 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH] coccinelle: api: add flex_array_size.cocci script
Date:   Fri, 28 Aug 2020 19:31:34 +0300
Message-Id: <20200828163134.496386-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggest flex_array_size() wrapper to compute the size of a
flexible array member in a structure. The macro additionally
checks for integer overflows.

The cocci script intentionally skips cases where count argument
is not a member of a structure because this introduce false
positives.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Kees, Gustavo, may I have your acks if you find this script useful?
Currently, it emits following warnings:
./fs/select.c:994:25-26: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:711:34-35: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:722:43-44: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:738:40-41: WARNING opportunity for flex_array_size
./include/linux/avf/virtchnl.h:749:46-47: WARNING opportunity for flex_array_size
./drivers/dma/qcom/bam_dma.c:1055:35-36: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2895:45-46: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:3381:47-48: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2484:45-46: WARNING opportunity for flex_array_size
./drivers/md/dm-crypt.c:2484:45-46: WARNING opportunity for flex_array_size
./net/sched/em_canid.c:198:48-49: WARNING opportunity for flex_array_size
./include/linux/filter.h:741:42-43: WARNING opportunity for flex_array_size
./fs/aio.c:677:42-43: WARNING opportunity for flex_array_size
./include/rdma/rdmavt_qp.h:537:31-32: WARNING opportunity for flex_array_size
./include/rdma/rdmavt_qp.h:537:31-32: WARNING opportunity for flex_array_size
./lib/ts_fsm.c:311:49-50: WARNING opportunity for flex_array_size
./mm/slab.c:3407:59-60: WARNING opportunity for flex_array_size
./mm/slab.c:2139:55-56: WARNING opportunity for flex_array_size
./mm/slab.c:3407:59-60: WARNING opportunity for flex_array_size
./mm/slab.c:2139:55-56: WARNING opportunity for flex_array_size

 scripts/coccinelle/api/flex_array_size.cocci | 180 +++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 scripts/coccinelle/api/flex_array_size.cocci

diff --git a/scripts/coccinelle/api/flex_array_size.cocci b/scripts/coccinelle/api/flex_array_size.cocci
new file mode 100644
index 000000000000..b5264a826c29
--- /dev/null
+++ b/scripts/coccinelle/api/flex_array_size.cocci
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Suggest flex_array_size() wrapper to compute the size of a
+/// flexible array member in a structure. The macro additionally
+/// checks for integer overflows.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: flex_array_size
+//
+
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@decl_flex@
+identifier name, array, size;
+type TA, TS;
+@@
+
+  struct name {
+    ...
+    TS size;
+    ...
+(
+    TA array[];
+|
+    TA array[\(0\|1\)];
+)
+  };
+
+@ptr_flex@
+identifier decl_flex.name;
+identifier instance;
+@@
+
+  struct name *instance;
+
+@struct_flex@
+identifier decl_flex.name;
+identifier instance;
+@@
+
+  struct name instance;
+
+@ptr_flex_size depends on !patch@
+identifier decl_flex.array, decl_flex.size;
+identifier ptr_flex.instance;
+type decl_flex.TA;
+position p;
+@@
+
+(
+* instance->size * sizeof(TA)@p
+|
+* instance->size * sizeof(*instance->array)@p
+)
+
+@depends on patch exists@
+identifier decl_flex.array, decl_flex.size;
+identifier ptr_flex.instance;
+type decl_flex.TA;
+@@
+
+(
+- instance->size * sizeof(TA)
++ flex_array_size(instance, array, instance->size)
+|
+- instance->size * sizeof(*instance->array)
++ flex_array_size(instance, array, instance->size)
+)
+
+@struct_flex_size depends on !patch@
+identifier decl_flex.array, decl_flex.size;
+identifier struct_flex.instance;
+type decl_flex.TA;
+position p;
+@@
+
+(
+* instance.size * sizeof(TA)@p
+|
+* instance.size * sizeof(*instance->array)@p
+)
+
+@depends on patch exists@
+identifier decl_flex.array, decl_flex.size;
+identifier struct_flex.instance;
+type decl_flex.TA;
+@@
+
+(
+- instance.size * sizeof(TA)
++ flex_array_size(instance, array, instance.size)
+|
+- instance.size * sizeof(*instance->array)
++ flex_array_size(instance, array, instance.size)
+)
+
+@func_arg_flex_size depends on !patch@
+identifier decl_flex.name, decl_flex.array, decl_flex.size;
+identifier func, instance;
+type decl_flex.TA;
+position p;
+@@
+
+  func(..., struct name *instance, ...) {
+    ... when any
+(
+*   instance->size * sizeof(TA)@p
+|
+*   instance->size * sizeof(*instance->array)@p
+)
+    ...
+  }
+
+@depends on patch exists@
+identifier decl_flex.name, decl_flex.array, decl_flex.size;
+identifier func, instance;
+type decl_flex.TA;
+@@
+
+  func(..., struct name *instance, ...) {
+    ... when any
+(
+-   instance->size * sizeof(TA)
++   flex_array_size(instance, array, instance->size)
+|
+-   instance->size * sizeof(*instance->array)
++   flex_array_size(instance, array, instance->size)
+)
+    ...
+  }
+
+
+@script:python depends on report@
+p << ptr_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << ptr_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on report@
+p << struct_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << struct_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on report@
+p << func_arg_flex_size.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING opportunity for flex_array_size")
+
+@script:python depends on org@
+p << func_arg_flex_size.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING opportunity for flex_array_size")
-- 
2.26.2

