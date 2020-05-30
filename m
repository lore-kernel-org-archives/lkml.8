Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7750C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF492074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgE3Uyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:54:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33458 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3Uye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:54:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id s1so3506780ljo.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMfolX8wThjJ39hizZseRxSztCFPO1pn1hg6I+CItf8=;
        b=t+dFs4xAToTiCweivmXQ23HzSqYOSZqZM5X/7ymshtamyRRb6E51qM2WOoUJOO7Ry4
         gJkXiJzT8ci8+r6acfosC3cXlLH7F5FRIevhO4rcBsPsUCM2v4808LtPoMcCzz9mzHKR
         9wIH5W0AiRnkm/4uowuGCARpnejsTHpVrZN4+R6GlJSBnOceRrekF0g2mX8lJoC3xjcY
         7oVaQvXQXHWCTejTx55dyN3Y9UE/Zr7J3ZJJz6KjsqTJARuhEWDr94MdovJwROSqroZu
         xh4XvcmU/Rpfn8T2gNH9yURD99G2ekdGF+K0ZQcoGpGVl/ylhWj88EDUVmJCMHFzfLJ0
         tXRQ==
X-Gm-Message-State: AOAM530Nxj9KM/meup7ImWA5cGxgS8yItn1XHAakAJzvsKQmB1lyzC1M
        xi73u1jcxcBsUqtmuEwUoKA=
X-Google-Smtp-Source: ABdhPJxPYaHknn01FnFquKivQn0/VA1YjDLPZh9Tb3gOcaZpaPaTlV6q/zNvgSXIbNVQcvAlBeFFhg==
X-Received: by 2002:a2e:b0f9:: with SMTP id h25mr7425165ljl.18.1590872071790;
        Sat, 30 May 2020 13:54:31 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
        by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 13:54:31 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Coccinelle: extend memdup_user rule with vmemdup_user()
Date:   Sat, 30 May 2020 23:53:48 +0300
Message-Id: <20200530205348.5812-3-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530205348.5812-1-efremov@linux.com>
References: <20200530205348.5812-1-efremov@linux.com>
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
 scripts/coccinelle/api/memdup_user.cocci | 49 +++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 49f487e6a5c8..a50def35136e 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -37,6 +37,28 @@ identifier l1,l2;
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
@@ -48,14 +70,37 @@ statement S1,S2;
    if (copy_from_user(to, from, size) != 0)
    S2
 
-@script:python depends on org@
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
+@script:python depends on org && r@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0], "WARNING opportunity for memdup_user")
 
-@script:python depends on report@
+@script:python depends on report && r@
 p << r.p;
 @@
 
 coccilib.report.print_report(p[0], "WARNING opportunity for memdup_user")
+
+@script:python depends on org && rv@
+p << rv.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for vmemdup_user")
+
+@script:python depends on report && rv@
+p << rv.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
-- 
2.26.2

