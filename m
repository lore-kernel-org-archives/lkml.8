Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D622C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55317208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlBqajpx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OduDJY7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgGaJ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbgGaJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:16 -0400
Date:   Fri, 31 Jul 2020 09:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VnaD553HlsVhTidsBlA6RgjwGJCOfCtgC9mDVjsDgUg=;
        b=IlBqajpxPsLsxixRDLVtNnO5V8SkFDFpeVn7r0R1xOH79dqiTvE6rGXV8LL9Jp5KiObSNN
        GL5AcSVtlBTmpHFTnaxkgjCGwoOtgcCeXCm2l69xZ503JcK2GrwU+nvwR9+m8TxbgFYNC9
        ezu9GUqxk648WsE9k9UcKWyKDO90NF1iMijf/rb5Q3N1XO0UPWZz0YEjdLytIA42eoj1XJ
        0VggFn2PvodbXyoSE8Khs8DKCi5Hrx935P/Xz4sUr8fpoWhwcY0CZym0H+nEz1c8Es2A7T
        VuStfNkcKNIPg3DEEkyJ6uZHle/pD7MdR86Gxyqf2R6sRQnw+dMmgDLwbI4AYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VnaD553HlsVhTidsBlA6RgjwGJCOfCtgC9mDVjsDgUg=;
        b=OduDJY7gzWe4QYHQQufmOozxIdsgW5lvoXxIYmk2KBGQ4LoWeJEoMO10VPZwUnIaJeHLbY
        t+HpjLTOPgcaEiBA==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib/test_vmalloc.c: Add test cases for kvfree_rcu()
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739456.4006.7812905871271833589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     da4fc00abb97ce1269b0940abe86e25456e28424
Gitweb:        https://git.kernel.org/tip/da4fc00abb97ce1269b0940abe86e25456e28424
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:48:00 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:26 -07:00

lib/test_vmalloc.c: Add test cases for kvfree_rcu()

Introduce four new test cases for testing the kvfree_rcu()
interface. Two of them belong to single argument functionality
and another two for 2-argument functionality.

The aim is to stress and check how kvfree_rcu() behaves under
different load and memory conditions and analyze its performance
throughput.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_vmalloc.c | 103 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 8 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index ddc9685..5cf2fe9 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/rwsem.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
 
 #define __param(type, name, init, msg)		\
 	static type name = init;				\
@@ -35,14 +37,18 @@ __param(int, test_loop_count, 1000000,
 
 __param(int, run_test_mask, INT_MAX,
 	"Set tests specified in the mask.\n\n"
-		"\t\tid: 1,   name: fix_size_alloc_test\n"
-		"\t\tid: 2,   name: full_fit_alloc_test\n"
-		"\t\tid: 4,   name: long_busy_list_alloc_test\n"
-		"\t\tid: 8,   name: random_size_alloc_test\n"
-		"\t\tid: 16,  name: fix_align_alloc_test\n"
-		"\t\tid: 32,  name: random_size_align_alloc_test\n"
-		"\t\tid: 64,  name: align_shift_alloc_test\n"
-		"\t\tid: 128, name: pcpu_alloc_test\n"
+		"\t\tid: 1,    name: fix_size_alloc_test\n"
+		"\t\tid: 2,    name: full_fit_alloc_test\n"
+		"\t\tid: 4,    name: long_busy_list_alloc_test\n"
+		"\t\tid: 8,    name: random_size_alloc_test\n"
+		"\t\tid: 16,   name: fix_align_alloc_test\n"
+		"\t\tid: 32,   name: random_size_align_alloc_test\n"
+		"\t\tid: 64,   name: align_shift_alloc_test\n"
+		"\t\tid: 128,  name: pcpu_alloc_test\n"
+		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
+		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
+		"\t\tid: 1024, name: kvfree_rcu_1_arg_slab_test\n"
+		"\t\tid: 2048, name: kvfree_rcu_2_arg_slab_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -316,6 +322,83 @@ pcpu_alloc_test(void)
 	return rv;
 }
 
+struct test_kvfree_rcu {
+	struct rcu_head rcu;
+	unsigned char array[20];
+};
+
+static int
+kvfree_rcu_1_arg_vmalloc_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_2_arg_vmalloc_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = vmalloc(1 * PAGE_SIZE);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p, rcu);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_1_arg_slab_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p);
+	}
+
+	return 0;
+}
+
+static int
+kvfree_rcu_2_arg_slab_test(void)
+{
+	struct test_kvfree_rcu *p;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -1;
+
+		p->array[0] = 'a';
+		kvfree_rcu(p, rcu);
+	}
+
+	return 0;
+}
+
 struct test_case_desc {
 	const char *test_name;
 	int (*test_func)(void);
@@ -330,6 +413,10 @@ static struct test_case_desc test_case_array[] = {
 	{ "random_size_align_alloc_test", random_size_align_alloc_test },
 	{ "align_shift_alloc_test", align_shift_alloc_test },
 	{ "pcpu_alloc_test", pcpu_alloc_test },
+	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test },
+	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test },
+	{ "kvfree_rcu_1_arg_slab_test", kvfree_rcu_1_arg_slab_test },
+	{ "kvfree_rcu_2_arg_slab_test", kvfree_rcu_2_arg_slab_test },
 	/* Add a new test case here. */
 };
 
