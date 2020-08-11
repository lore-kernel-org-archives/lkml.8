Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BA6205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHKHuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:50:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45855 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHKHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:50:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id b30so6141339lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7c9LgDQzwFBP2P6ArJr6sk6r1j+llzDsGb6lR6H9a1Q=;
        b=DXuM86OYRLMp5V2HM3q+kYMPcCYCpGkmJaowe6sielCBa7OevbluIZ4X39LLHV/mbT
         /m3Lz8Wa3GdNQgKSuSrVbFj9dLDLhFxPCwZLMdrk8OOwLbM+v7MRIe/XXGFJ0qw0gZXV
         7/XE3sriFbZGQ1E9WEXBJhEaXUChMT8hKNeJiFPjC6raWxHPJDXNMb4yEgg3ETVjYheB
         PGTMmKqswhAOZjYo9XLpFSCd8+fcPpskTSWcHZgAco1nFtDWG9wzygRyOUemiOqmUchp
         x3gUzzZNwSxPaLCcv7Pa7YNhjQjGyRSgVj2EX3yCBBTT95iQri0LlJPBLWclYRj4ITGR
         cNmg==
X-Gm-Message-State: AOAM533hsniEGTI+MYbTqjsDKtqVckAiDN+kKid4G2pYlrhtW0BCeV6J
        oC+T8FEYBk0lYfmOF+dlkB/u0G9Z
X-Google-Smtp-Source: ABdhPJxckJBrZD99vkzMZyK+yaa6woS9Ys9iCWecK6RVC95+nlUjQnGrP0mhZ4kjyiZEIGMSn83ang==
X-Received: by 2002:ac2:4542:: with SMTP id j2mr2586816lfm.110.1597132202193;
        Tue, 11 Aug 2020 00:50:02 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id z25sm9918170ljz.13.2020.08.11.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 00:50:01 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] coccinelle: api: update kzfree script to kfree_sensitive
Date:   Tue, 11 Aug 2020 10:49:53 +0300
Message-Id: <20200811074953.73994-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
renames kzfree to kfree_sensitive and uses memzero_explicit(...) instead of
memset(..., 0, ...) internally. Update cocci script to reflect these
changes.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Julia, I think you can squash this commit with original script, or I can
resend the whole script since it's not merged to the mainline.

 .../{kzfree.cocci => kfree_sensitive.cocci}   | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)
 rename scripts/coccinelle/api/{kzfree.cocci => kfree_sensitive.cocci} (70%)

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
similarity index 70%
rename from scripts/coccinelle/api/kzfree.cocci
rename to scripts/coccinelle/api/kfree_sensitive.cocci
index 33625bd7cec9..e4a066a0b77d 100644
--- a/scripts/coccinelle/api/kzfree.cocci
+++ b/scripts/coccinelle/api/kfree_sensitive.cocci
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// Use kzfree, kvfree_sensitive rather than memset or
-/// memzero_explicit followed by kfree
+/// Use kfree_sensitive, kvfree_sensitive rather than memset or
+/// memzero_explicit followed by kfree.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
 //
-// Keywords: kzfree, kvfree_sensitive
+// Keywords: kfree_sensitive, kvfree_sensitive
 //
 
 virtual context
@@ -18,7 +18,8 @@ virtual report
 @initialize:python@
 @@
 # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
-filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+filter = frozenset(['kmalloc_oob_in_memset',
+		    'kfree_sensitive', 'kvfree_sensitive'])
 
 def relevant(p):
     return not (filter & {el.current_element for el in p})
@@ -56,17 +57,13 @@ type T;
 - memzero_explicit@m((T)E, size);
   ... when != E
       when strict
-// TODO: uncomment when kfree_sensitive will be merged.
-// Only this case is commented out because developers
-// may not like patches like this since kzfree uses memset
-// internally (not memzero_explicit).
-//(
-//- kfree(E)@p;
-//+ kfree_sensitive(E);
-//|
+(
+- kfree(E)@p;
++ kfree_sensitive(E);
+|
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
-//)
+)
 
 @rp_memset depends on patch@
 expression E, size;
@@ -80,7 +77,7 @@ type T;
       when strict
 (
 - kfree(E)@p;
-+ kzfree(E);
++ kfree_sensitive(E);
 |
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
@@ -91,11 +88,11 @@ p << r.p;
 @@
 
 coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
 
 @script:python depends on org@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
-- 
2.26.2

