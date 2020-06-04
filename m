Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D746A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgFDUtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:49:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35794 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgFDUtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:49:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id 82so4455913lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGhAdvcQJQ2qMPulVRPuuC9wYcPzRQ4SOxiHdw45kYM=;
        b=Rx6cKCqd6GLxJkkbEh+7jkyBvQarmb3ap/bySXiH1OYCiEaNs8qXYvBlusOEMnqmdC
         cyrW/C/IDAQ5EEE6RZ968aR/Hp8nMYOJselMMx3QpAjHyTL5OKNTutEE5+BvXPq7sSFQ
         WxFX60FbRni68/JEJcVTScOG30JJUkMqZD4MHOos4XVTTQ0ItCj9qJl6fNiaw3H+X/76
         VkadSS/cXAXsKdQzkAtIMRZg8Vpks0wH2x2/qrM1fbtLaXAsYOpn1ulr9n7aeXeo5h26
         cVS2pLHHhi0g+vnRfpu3lGt6HvYFc8nk6BJGpCkp/UvgWo4kmNExY54y61pTrYz9LX5s
         j0mg==
X-Gm-Message-State: AOAM5334h6X2RrTQgPz01zuhmX/JrzjxRco6BBdvezPEF7Fz+D3c3jUd
        +xXWFPHZpsr+sIefpZzCKCWAaHT3
X-Google-Smtp-Source: ABdhPJyMSXyrh8zAP1X2eBLQS0LzwEa5XF3RYVMhR17BKJpMawdEDFDPGOJ0CTh+/xaOHWtXK/1zUA==
X-Received: by 2002:a05:6512:110e:: with SMTP id l14mr3258264lfg.25.1591303757728;
        Thu, 04 Jun 2020 13:49:17 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id b144sm155718lfg.82.2020.06.04.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:49:15 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: api: add kzfree script
Date:   Thu,  4 Jun 2020 23:48:46 +0300
Message-Id: <20200604204846.15897-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for memset()/memset_explicit() with 0 followed by
kfree()/vfree()/kvfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
- memset_explicit() added
- kvfree_sensitive() added
- forall added to r1
- ... between memset and kfree added
  Unfortunately, it doesn't work as I would expect it to in "patch"
  mode. I've added my comment about it in the rule. It can be safely
  removed from the patch if I misunderstood something.

Another "strange" behaviour that I faced that r2 rule works only if I
write 2 expression lines:
expression *E;
expression size;
If I try to use a single line "expression *E, size;" then r2 matches nothing.

 scripts/coccinelle/api/kzfree.cocci | 65 +++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..5c7e4bb13bb7
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree, kvfree_sensitive rather than memset or
+/// memset_explicit with 0 followed by kfree
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
+
+// Ignore kzfree definition
+// Ignore kasan test
+@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
+expression *E;
+position p;
+@@
+
+* \(memset\|memset_explicit\)(E, 0, ...);
+  ... when != E
+      when strict
+* \(kfree\|vfree\|kvfree\)(E)@p;
+
+@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression *E;
+expression size;
+@@
+
+- \(memset\|memset_explicit\)(E, 0, size);
+/// Unfortunately, it doesn't work as in !patch mode.
+/// spatch (v1.0.8) should patch 4 functions in linux 5.7 with this rule
+/// and uncommented "when" lines. With only "... when != E" line 2 functions
+/// are patched, none with "when strict". 3 functions patch is produced by the
+/// rule with "when" lines commented out.
+//  ... when != E
+//      when strict
+(
+- kfree(E);
++ kzfree(E);
+|
+- vfree(E);
++ kvfree_sensitive(E, size);
+|
+- kvfree(E);
++ kvfree_sensitive(E, size);
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
-- 
2.26.2

