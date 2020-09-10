Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA5C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E22080A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmMaQTpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIJFzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgIJFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:52:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F88C061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:52:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so2484213pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQ5RKmS6pDbUQyOR1reW8QcgTmZ3QbuMfyCvjVJys1k=;
        b=JmMaQTpcWlQdVWzzQUWeWUAMF6TMJc5rUxqmlWgp9xV+xGaCgBSn/BzISiXSclnAlO
         RWqpCLpN8lve7BMIIhMG9ouo68Gxu7vADafkzo8nb8mcFFY/fLzKLHCK3jzQ8h2jtim+
         /9eBzhlC9JOY80cI2QoUnsqwS7NXDm4Mi6yBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQ5RKmS6pDbUQyOR1reW8QcgTmZ3QbuMfyCvjVJys1k=;
        b=tONiM5ZwY0lAQ0wz3te1BDA2SXKxEm33H65NAquoLlyFYYiyws67pdojG4lFYUTnDV
         IIPS1MOVBe5dehKFXyTvdlpCyg8zLEC0Y+8RbJkpyISvIYhDGSSzP4W72flNnP1cL4iQ
         nb4uUzUMCRoBFAfL7mxLPJ51UA+lNU1G7/tYEBP59Q6Rn3OgLZlRzTJc5hM1SiM8Wntz
         VbczmWyu6WkwPtD9+OBCN59s4nQNjpILNGQ96Edi1Qm+JdI6cuhRc4I5Wcoz5bEBLbzn
         jCx0C+9dFvnBgAYYCQ7VVyOsrdLQqgCDpCDymNXZamqFOfOo/U3LrTbSL6kubOzJ9Ynh
         V3yQ==
X-Gm-Message-State: AOAM532obIxiuyi6Y0EaHXlq5KnXh0PAXFuoi8uxRiUqfs8Nrrv6K2ch
        0B2xm5fGdhQGlBF96srD23ClGlpy6s0zMw==
X-Google-Smtp-Source: ABdhPJyj40jL/KztQMjitxczn6JOkJRE4hwbvePfjzdT2rVq69pgtbM9YlxHjn1lwODWSnmTQlinNw==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr3840429plt.75.1599717167810;
        Wed, 09 Sep 2020 22:52:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j11sm3751317pgh.8.2020.09.09.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 22:52:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 1/2] idr: Document calling context for IDA APIs mustn't use locks
Date:   Wed,  9 Sep 2020 22:52:45 -0700
Message-Id: <20200910055246.2297797-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for these functions indicates that callers don't need
to hold a lock while calling them, but that documentation is only in one
place under "IDA Usage". Let's state the same information on each IDA
function so that it's clear what the calling context requires.
Furthermore, let's document ida_simple_get() with the same information
so that callers know how this API works.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Tri Vo <trong@android.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/idr.h | 9 ++++++---
 lib/idr.c           | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 3ade03e5c7af..b235ed987021 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -263,7 +263,8 @@ void ida_destroy(struct ida *ida);
  *
  * Allocate an ID between 0 and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -280,7 +281,8 @@ static inline int ida_alloc(struct ida *ida, gfp_t gfp)
  *
  * Allocate an ID between @min and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -297,7 +299,8 @@ static inline int ida_alloc_min(struct ida *ida, unsigned int min, gfp_t gfp)
  *
  * Allocate an ID between 0 and @max, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
diff --git a/lib/idr.c b/lib/idr.c
index c2cf2c52bbde..3fa8be43696f 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -372,7 +372,8 @@ EXPORT_SYMBOL(idr_replace);
  * Allocate an ID between @min and @max, inclusive.  The allocated ID will
  * not exceed %INT_MAX, even if @max is larger.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -479,7 +480,8 @@ EXPORT_SYMBOL(ida_alloc_range);
  * @ida: IDA handle.
  * @id: Previously allocated ID.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  */
 void ida_free(struct ida *ida, unsigned int id)
 {
@@ -531,7 +533,8 @@ EXPORT_SYMBOL(ida_free);
  * or freed.  If the IDA is already empty, there is no need to call this
  * function.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  */
 void ida_destroy(struct ida *ida)
 {

base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
-- 
Sent by a computer, using git, on the internet

