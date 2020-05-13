Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CECA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B8320575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364142;
	bh=8nWeuh1x24TWSX1tL7laF5UYkrmye3w6vE49+0gyclc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rtQ2ao9d/Ax3nO5Up5IMYMe6J2hdGDon/N/6LuxkJdJIIpDwQI6nacIzjnHqAtgzk
	 LSeImc8+AJ6GWpRDaU/RJWed8lf9PDD9TizUyO/uRt/lO0NXHLGDSX5D3X0XqkwV0A
	 s5ZU5tJc+KmQopycJYzjcIO6p98AAtNkRfgvCfJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgEMJuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbgEMJuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:50:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A3420740;
        Wed, 13 May 2020 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363407;
        bh=8nWeuh1x24TWSX1tL7laF5UYkrmye3w6vE49+0gyclc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQXZ4JT7qEV26cyj5LQ1xaoxT8RtbUpNrStVBfkgbQ7Rh/J+53a/qITnsiduNx9fl
         fWJgMbPFLYvPu5tQHJUEETvZh6yTAJUc+rJdxp4dsnoDrc5BZh2N2X7FLDzu2BRUEf
         F/bgTctTfpghbse8N2GTTjcpS1LmRThoz3gLrl9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Willard <henry.willard@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 61/90] mm: limit boost_watermark on small zones
Date:   Wed, 13 May 2020 11:44:57 +0200
Message-Id: <20200513094416.052745207@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Willard <henry.willard@oracle.com>

commit 14f69140ff9c92a0928547ceefb153a842e8492c upstream.

Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an
external fragmentation event occurs") adds a boost_watermark() function
which increases the min watermark in a zone by at least
pageblock_nr_pages or the number of pages in a page block.

On Arm64, with 64K pages and 512M huge pages, this is 8192 pages or
512M.  It does this regardless of the number of managed pages managed in
the zone or the likelihood of success.

This can put the zone immediately under water in terms of allocating
pages from the zone, and can cause a small machine to fail immediately
due to OoM.  Unlike set_recommended_min_free_kbytes(), which
substantially increases min_free_kbytes and is tied to THP,
boost_watermark() can be called even if THP is not active.

The problem is most likely to appear on architectures such as Arm64
where pageblock_nr_pages is very large.

It is desirable to run the kdump capture kernel in as small a space as
possible to avoid wasting memory.  In some architectures, such as Arm64,
there are restrictions on where the capture kernel can run, and
therefore, the space available.  A capture kernel running in 768M can
fail due to OoM immediately after boost_watermark() sets the min in zone
DMA32, where most of the memory is, to 512M.  It fails even though there
is over 500M of free memory.  With boost_watermark() suppressed, the
capture kernel can run successfully in 448M.

This patch limits boost_watermark() to boosting a zone's min watermark
only when there are enough pages that the boost will produce positive
results.  In this case that is estimated to be four times as many pages
as pageblock_nr_pages.

Mel said:

: There is no harm in marking it stable.  Clearly it does not happen very
: often but it's not impossible.  32-bit x86 is a lot less common now
: which would previously have been vulnerable to triggering this easily.
: ppc64 has a larger base page size but typically only has one zone.
: arm64 is likely the most vulnerable, particularly when CMA is
: configured with a small movable zone.

Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
Signed-off-by: Henry Willard <henry.willard@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/1588294148-6586-1-git-send-email-henry.willard@oracle.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2351,6 +2351,14 @@ static inline void boost_watermark(struc
 
 	if (!watermark_boost_factor)
 		return;
+	/*
+	 * Don't bother in zones that are unlikely to produce results.
+	 * On small machines, including kdump capture kernels running
+	 * in a small area, boosting the watermark can cause an out of
+	 * memory situation immediately.
+	 */
+	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
+		return;
 
 	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
 			watermark_boost_factor, 10000);


