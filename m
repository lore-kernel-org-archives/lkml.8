Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5110C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B726B2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwFPoBAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBEKO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:14:27 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:57737 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBEKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:14:27 -0500
Received: by mail-wm1-f73.google.com with SMTP id t17so773533wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 02:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UD8MX0T3MUe53I3VyW0MK1QJ1j+hRM6tFiKLV9YX/IY=;
        b=AwFPoBAg8AfduU6mluO6q+xjnj/6ZfjQZ+9nrwOWG61fIjhJciOZHfryjbpHdwebfu
         FsHYigug2st//KQ1hLkVUz10cwkuIMtayfO9Ia8+FhC5c3gsu1084MtjZMRoq1wb8rad
         I2lqokjXVTbAQ+l7C+0GboJ6RMoYzZcN/IEqb5pMK6+iNvZ9y4gl7Cf6hnN2fFwzRze0
         9dYzLXNjrUgdpFILRZuUtSQibIEE/2yJ0XoZkgmQzDPwZsAQ8xdr4/QhYKowcR1DtOQL
         J6E5kguzuYx8TV3gyXengbPpy8NKoEDET3BBRXvwxwwxtb+6yxW8Hqfjd8eizQZ9ndU8
         qWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UD8MX0T3MUe53I3VyW0MK1QJ1j+hRM6tFiKLV9YX/IY=;
        b=XXwIDJHlMEUFjKSIOWitS/d+2n/Vl9rbQSE6zFbfzZm4JOnnm7oKZl29qc5RwmiCGK
         2Rgs2Kd0eXhr9OR926dpVN7F6xZlod+hjUSbuY4R2yFikIFZMjjdc6XVkIBpCcv3G++e
         ACkyodbBDo9HTpPYIreOS1sdVweXMr9+LN1d6iqGgNEIVUYxY678AXfQgMtkYL73OryN
         9pudEZ7ZMInh8S7PT5i8WQOa2UnJPRM298o9TTPSknyU5uJVWoOzzyGIdOfVwSelhZPz
         +3PAAT0o5nFtNdEV0kMxToznUCYXkFMbLWMe1KqbuZIq5LMdvP0YqgTFBuOw2DECenH3
         OVvA==
X-Gm-Message-State: APjAAAVUBPTuWzI1IFuFNW1ZesS2rtTZuc0OJZ3xPltjppJTOGBbx0W7
        ZDC1eaaSvho1FxfXFVmmELkbXjH+OA==
X-Google-Smtp-Source: APXvYqy1evs9nqE3YFwxxphgSKWYDq28pTy5VyvSWYSqjQVWCQuCLxqO8WRG+1uVGPkXve9fDTNJ4H8ugw==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr26978829wru.422.1580897664980;
 Wed, 05 Feb 2020 02:14:24 -0800 (PST)
Date:   Wed,  5 Feb 2020 11:14:19 +0100
Message-Id: <20200205101419.149903-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kcsan: Fix 0-sized checks
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instrumentation of arbitrary memory-copy functions, such as user-copies,
may be called with size of 0, which could lead to false positives.

To avoid this, add a comparison in check_access() for size==0, which
will be optimized out for constant sized instrumentation
(__tsan_{read,write}N), and therefore not affect the common-case
fast-path.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c |  7 +++++++
 kernel/kcsan/test.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e3c7d8f34f2ff..82c2bef827d42 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -455,6 +455,13 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 	atomic_long_t *watchpoint;
 	long encoded_watchpoint;
 
+	/*
+	 * Do nothing for 0 sized check; this comparison will be optimized out
+	 * for constant sized instrumentation (__tsan_{read,write}N).
+	 */
+	if (unlikely(size == 0))
+		return;
+
 	/*
 	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
 	 * user_access_save, as the address that ptr points to is only used to
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
index cc6000239dc01..d26a052d33838 100644
--- a/kernel/kcsan/test.c
+++ b/kernel/kcsan/test.c
@@ -92,6 +92,16 @@ static bool test_matching_access(void)
 		return false;
 	if (WARN_ON(matching_access(9, 1, 10, 1)))
 		return false;
+
+	/*
+	 * An access of size 0 could match another access, as demonstrated here.
+	 * Rather than add more comparisons to 'matching_access()', which would
+	 * end up in the fast-path for *all* checks, check_access() simply
+	 * returns for all accesses of size 0.
+	 */
+	if (WARN_ON(!matching_access(8, 8, 12, 0)))
+		return false;
+
 	return true;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

