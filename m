Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D35FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A546206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTF1qbRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFNRli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:41:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726513AbgFNRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592156494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRsr9LuC4VELp7tChLYcRbjOm8Okw/vUI+n7thVRBFo=;
        b=KTF1qbRuOxbam+1T0R1IlmFuJEofbVQuv68XSHS7u6HvbuirgP9TTYxLldsPedqWTgHo4F
        ihsZblYcz+obSAd5aELjszpFd2KTbsLbSZQmq1fxODZBT3IqUiZY1mhciwy8Cu0CroxXVL
        88rkQFYta7piPCPf3iWQMs3Ql7joFu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-LZJ70modMuK8lHKFNpUqdQ-1; Sun, 14 Jun 2020 13:41:30 -0400
X-MC-Unique: LZJ70modMuK8lHKFNpUqdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1435107ACCA;
        Sun, 14 Jun 2020 17:41:28 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 643CA100164C;
        Sun, 14 Jun 2020 17:41:25 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bitmap: Add test for bitmap_cut()
Date:   Sun, 14 Jun 2020 19:40:54 +0200
Message-Id: <5fc45e6bbd4fa837cd9577f8a0c1d639df90a4ce.1592155364.git.sbrivio@redhat.com>
In-Reply-To: <cover.1592155364.git.sbrivio@redhat.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by an original patch from Yury Norov: introduce a test for
bitmap_cut() that also makes sure functionality is as described for
partially overlapping src and dst.

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
v2:
  - use expect_eq_bitmap() instead of open coding result check (Andy
    Shevchenko)
  - don't use uncommon Co-authored-by: tag (Andy Shevchenko), drop
    it altogether as Yury asked me to go ahead with this and I haven't
    heard back in a while. Patch is now rather different anyway
  - avoid stack overflow, buffer needs to be five unsigned longs and
    not four as 'in' is shifted by one, spotted by kernel test robot
    with CONFIG_STACKPROTECTOR_STRONG

 lib/test_bitmap.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..df903c53952b 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -610,6 +610,63 @@ static void __init test_for_each_set_clump8(void)
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
+	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
+		struct test_bitmap_cut *t = &test_cut[i];
+
+		memcpy(in, t->in, sizeof(t->in));
+
+		bitmap_cut(out, in, t->first, t->cut, t->nbits);
+
+		expect_eq_bitmap(t->expected, out, t->nbits);
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +680,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_bitmap_cut();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.27.0

