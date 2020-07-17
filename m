Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66061C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F572065D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGQL5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:57:50 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39142 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgGQL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:57:50 -0400
Received: by mail-lj1-f174.google.com with SMTP id b25so12253739ljp.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ubfBDdW2++j5eaV9mb0eIDuZD4NKThyxipf8VY2yx0=;
        b=bcmjjTJtk0bG0o2iBrbQLkc0frX/c5bPvAovtp5Y3ixImnPjnIOusDN6snhOtXLXHR
         ycTzSSRt4LdsgY55idAVa6+/45fAoX/D6NoR4l4U5M2OHU1xb30L/1CHyGwD/lX2Ljqt
         u7knQpGdkx0MwCBTVMJW5iV2TUVNeG2EO/3qnubudbBd5YClNhoTEAtx+d/kdnuOYGsq
         dobTDFtFD39MrK1Xil85pQmnVjbFNGZEG6vz/oyXp4W2yD/uO0/p10amxJ4dD7jSrbUW
         f/B3fL/KvlHZ649Nq0CZzSJ23Cm370BdjiNuD4UxdgYQ06Ck/mID3NCJ35jdn/+PZ+iR
         jcbw==
X-Gm-Message-State: AOAM531rY0cBc7cwMaXWE+BU/Dqtw+N47WkFpwEh7jwfhypI1pVz4QEP
        FZGPH5zie1YFmmQ60nGkEi8=
X-Google-Smtp-Source: ABdhPJzuI6woF561VO0aSK2Mi9PGCPavc5qDN1Shkuu2ue5V3ygILHDv72Z111OcnNYjIQIU2oShUQ==
X-Received: by 2002:a05:651c:1106:: with SMTP id d6mr4220363ljo.214.1594987067436;
        Fri, 17 Jul 2020 04:57:47 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id f13sm1843100lfs.29.2020.07.17.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:57:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] coccinelle: api: add kzfree script
Date:   Fri, 17 Jul 2020 14:57:09 +0300
Message-Id: <20200717115709.543882-1-efremov@linux.com>
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
Changes in v4:
 - memset call fixed in rp_memset
 - @m added to rp_memset,rp_memzero rules

 scripts/coccinelle/api/kzfree.cocci | 101 ++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..33625bd7cec9
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,101 @@
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
+position m != cond.ok;
+type T;
+@@
+
+- memzero_explicit@m((T)E, size);
+  ... when != E
+      when strict
+// TODO: uncomment when kfree_sensitive will be merged.
+// Only this case is commented out because developers
+// may not like patches like this since kzfree uses memset
+// internally (not memzero_explicit).
+//(
+//- kfree(E)@p;
+//+ kfree_sensitive(E);
+//|
+- \(vfree\|kvfree\)(E)@p;
++ kvfree_sensitive(E, size);
+//)
+
+@rp_memset depends on patch@
+expression E, size;
+position p : script:python() { relevant(p) };
+position m != cond.ok;
+type T;
+@@
+
+- memset@m((T)E, 0, size);
+  ... when != E
+      when strict
+(
+- kfree(E)@p;
++ kzfree(E);
+|
+- \(vfree\|kvfree\)(E)@p;
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

