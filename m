Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68168C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4362072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlkMbdSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgFHJNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:13:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29836 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728939AbgFHJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591607621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jh8LbcA7hJ1LBJfJIeXznQlrjaryCQ2h2QNPAiccPU=;
        b=ZlkMbdSHlX7Ln+89TMTkuo2/CpUGWWx7tTlxyRnC984R56vIgzLwQFyx+kJTw/mwvSEwkM
        g5fycUgxm3rpXgj0NhL4c/IH41EoEbptqhFPp4u3KsAq5he3J8iYv7jhNbuJtvVYplrdrJ
        Eshym+jFzrCPJ3X6+asBPucaEGbQ65A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-rYnTrcm5N9u9pRTAl4TyCA-1; Mon, 08 Jun 2020 05:13:39 -0400
X-MC-Unique: rYnTrcm5N9u9pRTAl4TyCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 542138014D4;
        Mon,  8 Jun 2020 09:13:38 +0000 (UTC)
Received: from epycfail.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11CF77B5FB;
        Mon,  8 Jun 2020 09:13:35 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib: Fix bitmap_cut() for partial overlapping case
Date:   Mon,  8 Jun 2020 11:13:28 +0200
Message-Id: <003e38d4428cd6091ef00b5b03354f1bd7d9091e.1591606281.git.sbrivio@redhat.com>
In-Reply-To: <cover.1591606281.git.sbrivio@redhat.com>
References: <cover.1591606281.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov reports that bitmap_cut() will not produce the right outcome
if src and dst partially overlap, with src pointing at some location
after dst, because the memmove() affects src before we store the bits
that we need to keep, that is, the bits preceding the cut -- as long as
the beginning of the cut is not aligned to a long.

Fix this by storing those bits before the memmove().

Note that this is just a theoretical concern so far, as the only user
of this function, pipapo_drop() from the nftables set back-end
implemented in net/netfilter/nft_set_pipapo.c, always supplies entirely
overlapping src and dst.

Reported-by: Yury Norov <yury.norov@gmail.com>
Fixes: 2092767168f0 ("bitmap: Introduce bitmap_cut(): cut bits and shift remaining")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 lib/bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa342d6..c5712e8f4c38 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -211,13 +211,13 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
 	unsigned long keep = 0, carry;
 	int i;
 
-	memmove(dst, src, len * sizeof(*dst));
-
 	if (first % BITS_PER_LONG) {
 		keep = src[first / BITS_PER_LONG] &
 		       (~0UL >> (BITS_PER_LONG - first % BITS_PER_LONG));
 	}
 
+	memmove(dst, src, len * sizeof(*dst));
+
 	while (cut--) {
 		for (i = first / BITS_PER_LONG; i < len; i++) {
 			if (i < len - 1)
-- 
2.26.2

