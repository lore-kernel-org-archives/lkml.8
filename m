Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E5CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2062076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873040;
	bh=x+kvP4e9brW1JlPST1lSzyG4S3kNdIh4EK71V63x+Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/C0i+HrSd0ZTy7FQak9+N69aUY0h7N/iIPogA15Kx12Hmh1SwLX/Eq42ZOg1XBQz
	 lxvFjUjXa0PXzbaGIjqQxLRBJpS9lB7/8bPrENrkusSF6w0KDZ2H7ZRzy9yINvcs8m
	 3sA1FHuKwTats7s8e85tj0f2ycamYE7jIWvV+QSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgFWAn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbgFWAnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7404F208A7;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873016;
        bh=x+kvP4e9brW1JlPST1lSzyG4S3kNdIh4EK71V63x+Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RU0TYdIQzEVvk8yu70xmPAUERvkqRsYIvFaaZYRHJWVF6At6DNJ3yuYQGxlJxwI4w
         JjdkjHpuK8zb4n1nwlsXc5oMmmNBENEi2w1GfYfE9EtYgil10CxK/F7Ga6bbdIWg11
         cBobReG3e0HPY18NWRD7onWxKgLTcoGti+3GLtJM=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] kcsan: Silence -Wmissing-prototypes warning with W=1
Date:   Mon, 22 Jun 2020 17:43:30 -0700
Message-Id: <20200623004333.27227-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

The functions here should not be forward declared for explicit use
elsewhere in the kernel, as they should only be emitted by the compiler
due to sanitizer instrumentation.  Add forward declarations a line above
their definition to shut up warnings in W=1 builds.

Link: https://lkml.kernel.org/r/202006060103.jSCpnV1g%lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f6794..1866baf 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -754,6 +754,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
  */
 
 #define DEFINE_TSAN_READ_WRITE(size)                                           \
+	void __tsan_read##size(void *ptr);                                     \
 	void __tsan_read##size(void *ptr)                                      \
 	{                                                                      \
 		check_access(ptr, size, 0);                                    \
@@ -762,6 +763,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	void __tsan_unaligned_read##size(void *ptr)                            \
 		__alias(__tsan_read##size);                                    \
 	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
+	void __tsan_write##size(void *ptr);                                    \
 	void __tsan_write##size(void *ptr)                                     \
 	{                                                                      \
 		check_access(ptr, size, KCSAN_ACCESS_WRITE);                   \
@@ -777,12 +779,14 @@ DEFINE_TSAN_READ_WRITE(4);
 DEFINE_TSAN_READ_WRITE(8);
 DEFINE_TSAN_READ_WRITE(16);
 
+void __tsan_read_range(void *ptr, size_t size);
 void __tsan_read_range(void *ptr, size_t size)
 {
 	check_access(ptr, size, 0);
 }
 EXPORT_SYMBOL(__tsan_read_range);
 
+void __tsan_write_range(void *ptr, size_t size);
 void __tsan_write_range(void *ptr, size_t size)
 {
 	check_access(ptr, size, KCSAN_ACCESS_WRITE);
@@ -799,6 +803,7 @@ EXPORT_SYMBOL(__tsan_write_range);
  * the size-check of compiletime_assert_rwonce_type().
  */
 #define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
+	void __tsan_volatile_read##size(void *ptr);                            \
 	void __tsan_volatile_read##size(void *ptr)                             \
 	{                                                                      \
 		const bool is_atomic = size <= sizeof(long long) &&            \
@@ -811,6 +816,7 @@ EXPORT_SYMBOL(__tsan_write_range);
 	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
 		__alias(__tsan_volatile_read##size);                           \
 	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
+	void __tsan_volatile_write##size(void *ptr);                           \
 	void __tsan_volatile_write##size(void *ptr)                            \
 	{                                                                      \
 		const bool is_atomic = size <= sizeof(long long) &&            \
@@ -836,14 +842,17 @@ DEFINE_TSAN_VOLATILE_READ_WRITE(16);
  * The below are not required by KCSAN, but can still be emitted by the
  * compiler.
  */
+void __tsan_func_entry(void *call_pc);
 void __tsan_func_entry(void *call_pc)
 {
 }
 EXPORT_SYMBOL(__tsan_func_entry);
+void __tsan_func_exit(void);
 void __tsan_func_exit(void)
 {
 }
 EXPORT_SYMBOL(__tsan_func_exit);
+void __tsan_init(void);
 void __tsan_init(void)
 {
 }
-- 
2.9.5

