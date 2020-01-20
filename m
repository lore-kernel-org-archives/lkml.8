Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22EC47409
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D442C2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="dqvOmH1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATHn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:43:58 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40439 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:43:57 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so6755065pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVOHfWbnRfkMY9jVKGHgxhKH0IzU9LE8hgU/UaJj8Ts=;
        b=dqvOmH1r2nvUztCLA58ZwbEuJf7BOGi+nZoxmmYCNHHyGcka7PTp2lV5p6ZS1/syCe
         KGS/EcJNbw/j4Z4sxeSfhlGblfD0W0Kl34q6Wz3cxhLYeasgrOxerzhI9prk2Jp7fNE/
         6lhEH19aqm26US6aZi+UqHy4F0TaJV+BsT8DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVOHfWbnRfkMY9jVKGHgxhKH0IzU9LE8hgU/UaJj8Ts=;
        b=ejY+vsoGysp0RDkdxXmBpKfFx4JHlsghYoRUULJDmRSI0EU5lftCU0OSTs0XLN5hT+
         qRxsYH2RB7qjM7yMufTBICSlMs2knCruA1jy4szeQCY22ZhHupcawWpE7SAV6B2j8ytl
         0yUIWwOHJerP6HQqoURKFXjaZeQ4iB89uIeqtLGVy2svJaZwlfQO9PcjBLsOMwlMXGxZ
         kp5XCDA9OkBY5x+MT8AQgHVJ9zH7ACvumW96LOnnPty6TqDnWpsoVXcXH8UZzSKgk6mj
         ooIJMCpggk+L9kOxmtQyiQQI6QMxYjZKiJ/vRNPG6jmBTAsBdimLv1KcY1CdTZ23YHqq
         Dw/g==
X-Gm-Message-State: APjAAAWEToxBFaRK5T4yaQddkUw6o81M0TQr/sVtFdHmf/OvswRP1/ZB
        ck09CwZ+xDK0aZNX5VwW/gJI0A==
X-Google-Smtp-Source: APXvYqyZLyymGztJ/CNSEFtCTqcFFyQ8FVKljy9JVWAOg7npJe8SkBB6mSUg0KCA7RntzezXIRgmJg==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr13940869plb.171.1579506237050;
        Sun, 19 Jan 2020 23:43:57 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id b126sm5161111pga.19.2020.01.19.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:43:56 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/5] [RFC] kasan: kasan_test: hide allocation sizes from the compiler
Date:   Mon, 20 Jan 2020 18:43:41 +1100
Message-Id: <20200120074344.504-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120074344.504-1-dja@axtens.net>
References: <20200120074344.504-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're about to annotate the allocation functions so that the complier will
know the sizes of the allocated objects. This is then caught at compile
time by both the testing in copy_to/from_user, and the testing in fortify.

The simplest way I can find to obscure the size is to pass the memory
through a WRITE_ONCE/READ_ONCE pair.

Create a macro to obscure an object's size, and a kmalloc wrapper to return
an object with an obscured size. Using these is sufficient to compile without
error.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/test_kasan.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 328d33beae36..dbbecd75f1e3 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -20,9 +20,28 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vmalloc.h>
+#include <linux/compiler.h>
 
 #include <asm/page.h>
 
+/*
+ * obscure origin of a pointer, so we can test things that check
+ * the size of the underlying object
+ */
+#define OBSCURE_ORIGINAL_OBJECT(x) {	\
+	void *bounce;			\
+	WRITE_ONCE(bounce, x);		\
+	x = READ_ONCE(bounce);		\
+	}
+
+static inline void *obscured_kmalloc(size_t size, gfp_t flags)
+{
+	void *result, *bounce;
+	result = kmalloc(size, flags);
+	WRITE_ONCE(bounce, result);
+	return READ_ONCE(bounce);
+}
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
@@ -34,7 +53,7 @@ static noinline void __init kmalloc_oob_right(void)
 	size_t size = 123;
 
 	pr_info("out-of-bounds to right\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -50,7 +69,7 @@ static noinline void __init kmalloc_oob_left(void)
 	size_t size = 15;
 
 	pr_info("out-of-bounds to left\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -67,6 +86,7 @@ static noinline void __init kmalloc_node_oob_right(void)
 
 	pr_info("kmalloc_node(): out-of-bounds to right\n");
 	ptr = kmalloc_node(size, GFP_KERNEL, 0);
+	OBSCURE_ORIGINAL_OBJECT(ptr);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -86,7 +106,7 @@ static noinline void __init kmalloc_pagealloc_oob_right(void)
 	 * the page allocator fallback.
 	 */
 	pr_info("kmalloc pagealloc allocation: out-of-bounds to right\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -136,7 +156,7 @@ static noinline void __init kmalloc_large_oob_right(void)
 	 * and does not trigger the page allocator fallback in SLUB.
 	 */
 	pr_info("kmalloc large allocation: out-of-bounds to right\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -155,6 +175,7 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
 	pr_info("out-of-bounds after krealloc more\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
+	OBSCURE_ORIGINAL_OBJECT(ptr2);
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
 		kfree(ptr1);
@@ -174,6 +195,7 @@ static noinline void __init kmalloc_oob_krealloc_less(void)
 	pr_info("out-of-bounds after krealloc less\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
 	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
+	OBSCURE_ORIGINAL_OBJECT(ptr2);
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
 		kfree(ptr1);
@@ -190,7 +212,7 @@ static noinline void __init kmalloc_oob_16(void)
 	} *ptr1, *ptr2;
 
 	pr_info("kmalloc out-of-bounds for 16-bytes access\n");
-	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	ptr1 = obscured_kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
@@ -209,7 +231,7 @@ static noinline void __init kmalloc_oob_memset_2(void)
 	size_t size = 8;
 
 	pr_info("out-of-bounds in memset2\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -225,7 +247,7 @@ static noinline void __init kmalloc_oob_memset_4(void)
 	size_t size = 8;
 
 	pr_info("out-of-bounds in memset4\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -242,7 +264,7 @@ static noinline void __init kmalloc_oob_memset_8(void)
 	size_t size = 8;
 
 	pr_info("out-of-bounds in memset8\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -258,7 +280,7 @@ static noinline void __init kmalloc_oob_memset_16(void)
 	size_t size = 16;
 
 	pr_info("out-of-bounds in memset16\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -274,7 +296,7 @@ static noinline void __init kmalloc_oob_in_memset(void)
 	size_t size = 666;
 
 	pr_info("out-of-bounds in memset\n");
-	ptr = kmalloc(size, GFP_KERNEL);
+	ptr = obscured_kmalloc(size, GFP_KERNEL);
 	if (!ptr) {
 		pr_err("Allocation failed\n");
 		return;
@@ -479,7 +501,7 @@ static noinline void __init copy_user_test(void)
 	size_t size = 10;
 	int unused;
 
-	kmem = kmalloc(size, GFP_KERNEL);
+	kmem = obscured_kmalloc(size, GFP_KERNEL);
 	if (!kmem)
 		return;
 
@@ -599,7 +621,7 @@ static noinline void __init kasan_memchr(void)
 	size_t size = 24;
 
 	pr_info("out-of-bounds in memchr\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	ptr = obscured_kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	if (!ptr)
 		return;
 
@@ -614,7 +636,7 @@ static noinline void __init kasan_memcmp(void)
 	int arr[9];
 
 	pr_info("out-of-bounds in memcmp\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	ptr = obscured_kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	if (!ptr)
 		return;
 
-- 
2.20.1

