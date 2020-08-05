Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803AD22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWCdHI/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHEWuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHEWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:50:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1449C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 15:50:25 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k35so27787700qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7O3UtfnS/mNLmFOS+lsZ1i4Dn60nUb+QzLe2DjT4KBg=;
        b=CWCdHI/c+etNs1XZU07tYKaYttKUL9hZyLnr7FbZTjWadegAJfcNrihtWA8srTg1+i
         pGgUriwEDnS4Ktwn8UYKQdg9shWVj7ZZvzeGiwX0O0QYZCIvZ9FbCVZxqH7YEpZURUYN
         mM974U/73V/vydWMZKEfvFWxKNgm1JnQLh/gCfequG4hp6DDUo776BxS0uvI1RNY7CiG
         g0xzPs7/LtQOJFeb2WyJHjRzCj6hHWSxU4dFnkP4KAEnnpVOHYMh5C+fc0+q72qfGhz7
         J3R1v9I+Q7tYxgnrRzaVPzTZwBa4YLfXyh03iO9VpE6hNHQ8mG+GwCt0M+j8wwN+5+QP
         WtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7O3UtfnS/mNLmFOS+lsZ1i4Dn60nUb+QzLe2DjT4KBg=;
        b=mvGAjkEL3DOS1mJKibUvLdZm79rU5j8seo0hvodmJ50DFvlhUmbdq9P2wOglMdPJUP
         jAMB9av9AMgEKDg290DSzxCoR87xI5YYubjJHlPVf7lxB3cAmjNgpv9KSqYeFyAdKFlE
         jkWwBz/Nwcz/xTOcVhIpA6188CVT0qI4lOqA7T1Ljb1kOXUhnU6J8GzTTvLlG06Lvwwc
         QjpORiJYmg/yEXu42ZCfJdnzJI7QqwqNQLU1nPMQxpGNL5FQHEO8dA6aqUEb7OgwtLGZ
         eEUo5dLg6xNut1cXyk9lr2wSnktaHPPUWnKyrpLj2vO6HHdvv/2VAiGZ76Tf0+eKcYkc
         0rjw==
X-Gm-Message-State: AOAM532ApN8JD29qCnwiHsrcwZU61beFtLUVeZ1vBx0lQvCqjmjMlQmo
        eSJjE++oYF0ilXpRRIs3umwXX4HMJDbH4a+wq0U=
X-Google-Smtp-Source: ABdhPJyQXLTYjM6TqUweQc16QWwQBIceCnx9d8Jac3bT5VxdhwSINOugDy09sztt4I38wu3ql5UTAzb1NPhR4Hx2N5c=
X-Received: by 2002:ad4:564d:: with SMTP id bl13mr5864367qvb.60.1596667824695;
 Wed, 05 Aug 2020 15:50:24 -0700 (PDT)
Date:   Wed,  5 Aug 2020 15:50:14 -0700
Message-Id: <20200805225015.2847624-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] scripts/gdb: fix python 3.8 SyntaxWarning
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Aymeric Agon-Rambosson <aymeric.agon@yandex.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the observed warnings:
scripts/gdb/linux/rbtree.py:20: SyntaxWarning: "is" with a literal. Did
you mean "=="?
  if node is 0:
scripts/gdb/linux/rbtree.py:36: SyntaxWarning: "is" with a literal. Did
you mean "=="?
  if node is 0:

It looks like this is a new warning added in Python 3.8. I've only seen
this once after adding the add-auto-load-safe-path rule to my ~/.gdbinit
for a new tree.

Cc: Stephen Boyd <swboyd@chromium.org>
Fixes: commit 449ca0c95ea2 ("scripts/gdb: add rb tree iterating utilities")
Link: https://adamj.eu/tech/2020/01/21/why-does-python-3-8-syntaxwarning-for-is-literal/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/gdb/linux/rbtree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
index c4b991607917..fe462855eefd 100644
--- a/scripts/gdb/linux/rbtree.py
+++ b/scripts/gdb/linux/rbtree.py
@@ -17,7 +17,7 @@ def rb_first(root):
         raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
 
     node = root['rb_node']
-    if node is 0:
+    if node == 0:
         return None
 
     while node['rb_left']:
@@ -33,7 +33,7 @@ def rb_last(root):
         raise gdb.GdbError("Must be struct rb_root not {}".format(root.type))
 
     node = root['rb_node']
-    if node is 0:
+    if node == 0:
         return None
 
     while node['rb_right']:
-- 
2.28.0.163.g6104cc2f0b6-goog

