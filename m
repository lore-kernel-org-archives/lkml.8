Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15624C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F263C2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHCK4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:56:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43105 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:56:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so20230652lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMWR59ppgwvDkLer5o1rKBFEg1vToLpYYmzQrSMwZDA=;
        b=eRUqCCTmW7PQ7kVVunyZzd6xAsS5J3Al6NeLdWLug8J+Fh2n85scALuOAOheJy0jMD
         lAR2w6Nsdu6jywVV6yoVzn88pTjecDkUe0YPKWlXAL716ftN07DwnpIgprotqR1WLoxJ
         CqgysDTzxc3iDcFVq/R4pVN3bzwuAZ1VtaeIdj25dOARmr4lTaZgS/Gxg7YFiwgAIQ4h
         lD/zcBtGk172quYUulROuf8dCZGuT8qET7zVe5Rk8JnPSO5tqpLBLcVtC9kpSNRHj4Ts
         YQ0Tgf+JH9zW0vlF3H15maFYmC3whBmJJ3H0WTjqCtzxeYcnT8fVyiyxkLOpOYwa0CQH
         +XWQ==
X-Gm-Message-State: AOAM530WtdiHwFy18zC0sALaPoJpj+D2x3vcy10NsWM6c0GwnIjXZWh0
        gmq/c2SqnByi0Ef9fLEQgp0IGTAi
X-Google-Smtp-Source: ABdhPJzpYVnZgPuVjD+eeb26rEsIXasQclbm8WTkDfDp5i5cUFrnfCSrvUWAc4ACFTmaGAAlzfFE5A==
X-Received: by 2002:a19:c206:: with SMTP id l6mr8177709lfc.152.1596452171263;
        Mon, 03 Aug 2020 03:56:11 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id d5sm878932ljc.80.2020.08.03.03.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 03:56:10 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: add kvmalloc script
Date:   Mon,  3 Aug 2020 13:56:01 +0300
Message-Id: <20200803105601.12162-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggest kvmalloc instead of opencoded kmalloc && vmalloc condition.

Signed-off-by: Denis Efremov <efremov@linux.com>
---

If coccinelle fails with "Segmentation fault" during analysis, then
one needs to increase stack limit, e.g. ulimit -s 32767.

Current, I've sent only one patch for this rule and will send the rest
after the merge window. https://lkml.org/lkml/2020/7/31/986

 scripts/coccinelle/api/kvmalloc.cocci | 127 ++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..76d6aeab7c09
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find conditions in code for kmalloc/vmalloc calls.
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
+position p;
+@@
+
+(
+* if (\(size <= E1\|size < E1\|size == E1\|size > E1\) || ...)@p {
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
+* if (\(!E\|E == NULL\))@p {
+    ...
+*   E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@depends on patch@
+expression E, E1, flags, size, node;
+identifier x;
+type T;
+@@
+
+(
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kmalloc(size, flags);
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (\(!E\|E == NULL\))
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (\(!x\|x == NULL\))
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (\(!E\|E == NULL\))
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (\(!x\|x == NULL\))
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!E\|E == NULL\))
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!x\|x == NULL\))
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!E\|E == NULL\))
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!x\|x == NULL\))
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

