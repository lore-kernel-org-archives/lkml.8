Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BBF206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMJiI0fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgFHJNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:13:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729182AbgFHJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591607623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yE6jzGV3dtRng04wVyZqLe9T3LKLbT2cdMorMj/BpO4=;
        b=WMJiI0fq94mmclYz3+UdgIjp9FNi2TS6OJSueMia79xwcSlRwzxuKxSTcUENOcgD7UpDou
        Yb69co00gI291rnbj/WEYH4m3Xr18CMG8osn+CTNIMr+FB2EaixBS17D91z88M5OZkB2iR
        XX2pfQR5mFpq7lQWg1rRyJMfJr1bJto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-vMmm-hlqOQ6jNrroDawP4w-1; Mon, 08 Jun 2020 05:13:41 -0400
X-MC-Unique: vMmm-hlqOQ6jNrroDawP4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE4B107ACCD;
        Mon,  8 Jun 2020 09:13:40 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B82617F4ED;
        Mon,  8 Jun 2020 09:13:38 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib: Add test for bitmap_cut()
Date:   Mon,  8 Jun 2020 11:13:29 +0200
Message-Id: <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
In-Reply-To: <cover.1591606281.git.sbrivio@redhat.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on an original patch by Yury Norov: introduce a test for
bitmap_cut() that also makes sure functionality is as described for
partially overlapping src and dst.

Co-authored-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 lib/test_bitmap.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..2c16adec5922 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -610,6 +610,65 @@ static void __init test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
+struct test_bitmap_cut {
+	unsigned int first;
+	unsigned int cut;
+	unsigned int nbits;
+	unsigned long in[4];
+	unsigned long expected[4];
+};
+
+static struct test_bitmap_cut test_cut[] = {
+	{  0,  0,  8, { 0x0000000aUL, }, { 0x0000000aUL, }, },
+	{  0,  0, 32, { 0xdadadeadUL, }, { 0xdadadeadUL, }, },
+	{  0,  3,  8, { 0x000000aaUL, }, { 0x00000015UL, }, },
+	{  3,  3,  8, { 0x000000aaUL, }, { 0x00000012UL, }, },
+	{  0,  1, 32, { 0xa5a5a5a5UL, }, { 0x52d2d2d2UL, }, },
+	{  0,  8, 32, { 0xdeadc0deUL, }, { 0x00deadc0UL, }, },
+	{  1,  1, 32, { 0x5a5a5a5aUL, }, { 0x2d2d2d2cUL, }, },
+	{  0, 15, 32, { 0xa5a5a5a5UL, }, { 0x00014b4bUL, }, },
+	{  0, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
+	{ 15, 15, 32, { 0xa5a5a5a5UL, }, { 0x000125a5UL, }, },
+	{ 15, 16, 32, { 0xa5a5a5a5UL, }, { 0x0000a5a5UL, }, },
+	{ 16, 15, 32, { 0xa5a5a5a5UL, }, { 0x0001a5a5UL, }, },
+
+	{ BITS_PER_LONG, BITS_PER_LONG, BITS_PER_LONG,
+		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
+		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
+	},
+	{ 1, BITS_PER_LONG - 1, BITS_PER_LONG,
+		{ 0xa5a5a5a5UL, 0xa5a5a5a5UL, },
+		{ 0x00000001UL, 0x00000001UL, },
+	},
+
+	{ 0, BITS_PER_LONG * 2, BITS_PER_LONG * 2 + 1,
+		{ 0xa5a5a5a5UL, 0x00000001UL, 0x00000001UL, 0x00000001UL },
+		{ 0x00000001UL, },
+	},
+	{ 16, BITS_PER_LONG * 2 + 1, BITS_PER_LONG * 2 + 1 + 16,
+		{ 0x0000ffffUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL, 0x5a5a5a5aUL },
+		{ 0x2d2dffffUL, },
+	},
+};
+
+static void __init test_bitmap_cut(void)
+{
+	unsigned long b[4], *in = &b[1], *out = &b[0];	/* Partial overlap */
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
+		struct test_bitmap_cut *t = &test_cut[i];
+
+		memcpy(in, t->in, sizeof(t->in));
+
+		bitmap_cut(out, in, t->first, t->cut, t->nbits);
+		if (!bitmap_equal(out, t->expected, t->nbits)) {
+			pr_err("bitmap_cut failed: expected %*pb, got %*pb\n",
+			       t->nbits, t->expected, t->nbits, out);
+		}
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +682,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_bitmap_cut();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

