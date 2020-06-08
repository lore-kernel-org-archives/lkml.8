Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F012C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A59206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgFHPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:01:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42159 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgFHPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:01:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id x27so10399819lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3uqReldNyB0HkYkJlYcEfBw/J6TVeoQE4OBnMgY2IY=;
        b=pNLp5tQylCo58kUKazHE4J9sIJuhKaHjHh4r60BsioXGMA7Lh5Uz3F3FeBAM+Eg92N
         hMz1cP8JX2u6YNdxuIF8rX9ABvkSN5nugZ04Ei9Zcc14IRd9B6QsAd69b1ZBsJsmEdBF
         zTfCQK+ElHhZA44cnK6GkF7i44B190nbaTDSlJc55zwqC/1TTxkMXVK+vOlJwu2C3GD5
         3s1fhuAXhmA8BZoBdJK5eMVQOE0aoE3uxMt+m4LA1/c/AVNbcX2bmO0C+4q5iPl0qYey
         HBSmcwOqDtUAGDufUjTfg8bHVkte2RhoN/w59eZjr3IsqYfJT6p3+BzKkbTq+qOjNOou
         azaw==
X-Gm-Message-State: AOAM530VrV565CFOh92/ggQz5bOnW9CK306BS3psZaQ3hFKKfGINfl84
        pIu5BmxZ66pjM87Qz3O/hN4=
X-Google-Smtp-Source: ABdhPJyWHCy8/wE7hsGBSEHPGpnmsLlvNzzsjxBBdtrx0lMViIRDO2Nho7AT/kAF5ExIu70kR018cQ==
X-Received: by 2002:a19:cb05:: with SMTP id b5mr12963374lfg.108.1591628478293;
        Mon, 08 Jun 2020 08:01:18 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:01:17 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH v2 2/4] coccinelle: api: extend memdup_user rule with vmemdup_user()
Date:   Mon,  8 Jun 2020 18:00:36 +0300
Message-Id: <20200608150038.223747-3-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
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
index cadcc2e87881..d15c061a34ab 100644
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

