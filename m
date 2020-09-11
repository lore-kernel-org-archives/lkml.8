Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFF8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B455521D47
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1V65bei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIKQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIKQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:02:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F13C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:50:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so11598194wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT31LQihlGES3XBi9qi6rIDEsIrCyiWiwAwPBPR3FeQ=;
        b=O1V65bei9i+sAdwH/CWpyxW5mBTdKr/oOaga84JeTelaHyfsHbulHu4x1iUSu5PWK2
         8vksMccmoRfyYbwYegP9AdphFhNWTKXe/Ud/fs/LobE1sR2XCFz6woi0kFSObnj+ranY
         1wXHE+6dl1Fc1xwZL1jdEIi/Nrv0m0EMOzEjR5J5dUfpZ+GDrNLH3roHYiQ2qaeIkz4h
         YHwE7jLB9eARe7ME9vznJ23vwzMX1LnXAjaf0ePo7iZJrrLyYRpVqO81k86HxyML9B1U
         BAm15l6t4fCQpoD3pjNoTwGpgD4ukZBf9e7i60l8R59qsGUS1t0gpwtFDUshlqvBx/aR
         hrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT31LQihlGES3XBi9qi6rIDEsIrCyiWiwAwPBPR3FeQ=;
        b=Yf80AOZerkUs0ziNQygelvDAHdpNqQVVRtfqCE2hAbcbYBs56rP7+8cILVXDL1lNEa
         EzKloJH8+wjhwwblAFR71mTOvSw1Xkyt9H1KI20WTu7+H2Jvm8Fb60syaefUkLMUecEN
         lhBtkklyAkj7GydN45brs9wD++W8D3VgVbDPmN45+OkPeNFgTdm2PiSXCyFdZZPEAjUZ
         SxU/FjXhvVmOEVMNZhDzexhE0VuJdDTJpU+UtC+KGLjaAC1z2eiUoZ+RvpvZqADUe3J5
         0n3mEoZxFo2cESzZBBnj6Yo/akU06lGTnCmqMJ/mqJ1dCnRLT7k+ka77KtePIYb7c2Cx
         ze2g==
X-Gm-Message-State: AOAM530pAtxnP+VuGQbScDTcKTHcPWmxxoB290eFBIISdF71+KsOpa4s
        7nc5tbnKpj4haoq5GMMicayW3bLxc1G7gkH2
X-Google-Smtp-Source: ABdhPJzgUZhv9R/6x7e+9tAD5bHrnj1uOz2SsmxNk4a9JkcFXFmrLU8LQvEveulMScnLKVKsnh4ywA==
X-Received: by 2002:adf:94c1:: with SMTP id 59mr2348866wrr.29.1599832207377;
        Fri, 11 Sep 2020 06:50:07 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id w14sm4865331wrk.95.2020.09.11.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:50:06 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Denis Efremov <efremov@linux.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: kzfree.cocci: Deprecate use of kzfree
Date:   Fri, 11 Sep 2020 14:49:42 +0100
Message-Id: <20200911134956.60910-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
treewide: rename kzfree() to kfree_sensitive()"). It is currently just a
legacy alias for kfree_sensitive(), which achieves the same thing.

Update kzfree.cocci accordingly:
1) Replace instances of kzfree with kfree_sensitive
2) Merge different rules for memset/memset_explicit as kzfree and
   kfree_sensitive are now equivalent
3) Rename script to kfree_sensitive.cocci

In addition:
4) Move the script to the free/ subfolder, where it would seem to fit
   better

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .../kfree_sensitive.cocci}                    | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)
 rename scripts/coccinelle/{api/kzfree.cocci => free/kfree_sensitive.cocci} (59%)

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/free/kfree_sensitive.cocci
similarity index 59%
rename from scripts/coccinelle/api/kzfree.cocci
rename to scripts/coccinelle/free/kfree_sensitive.cocci
index 33625bd7cec9..a87f93f2ed5c 100644
--- a/scripts/coccinelle/api/kzfree.cocci
+++ b/scripts/coccinelle/free/kfree_sensitive.cocci
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// Use kzfree, kvfree_sensitive rather than memset or
-/// memzero_explicit followed by kfree
+/// Use k{,v}free_sensitive rather than memset or memzero_explicit followed by
+/// k{,v}free
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
 //
-// Keywords: kzfree, kvfree_sensitive
+// Keywords: kfree_sensitive, kvfree_sensitive
 //
 
 virtual context
@@ -18,7 +18,7 @@ virtual report
 @initialize:python@
 @@
 # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
-filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+filter = frozenset(['kmalloc_oob_in_memset', 'kfree_sensitive', 'kvfree_sensitive'])
 
 def relevant(p):
     return not (filter & {el.current_element for el in p})
@@ -53,34 +53,16 @@ position m != cond.ok;
 type T;
 @@
 
+(
 - memzero_explicit@m((T)E, size);
-  ... when != E
-      when strict
-// TODO: uncomment when kfree_sensitive will be merged.
-// Only this case is commented out because developers
-// may not like patches like this since kzfree uses memset
-// internally (not memzero_explicit).
-//(
-//- kfree(E)@p;
-//+ kfree_sensitive(E);
-//|
-- \(vfree\|kvfree\)(E)@p;
-+ kvfree_sensitive(E, size);
-//)
-
-@rp_memset depends on patch@
-expression E, size;
-position p : script:python() { relevant(p) };
-position m != cond.ok;
-type T;
-@@
-
+|
 - memset@m((T)E, 0, size);
+)
   ... when != E
       when strict
 (
 - kfree(E)@p;
-+ kzfree(E);
++ kfree_sensitive(E);
 |
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
@@ -91,11 +73,11 @@ p << r.p;
 @@
 
 coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for k{,v}free_sensitive")
 
 @script:python depends on org@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for k{,v}free_sensitive")
-- 
2.28.0

