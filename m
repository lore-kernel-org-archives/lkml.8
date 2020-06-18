Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D300C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F204821582
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592439324;
	bh=LVRbfx6McmO1jwjifbKoEBkqjsNkCuJXna8m0BidZao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ars8vdsUG3LX1bJ27xRxsb4b6cXRZIsduwMz5RnqERAkxJhfKSFSSKr8nBURLuHS8
	 266l8hPlWJO/RODHYE2+iS8s7DXsK0ku+ln8d8D0LojcJ6BwAb8/pL0RFFVEXlJIBr
	 QfAZmX1ow8yvbZlY3BOPneHASTxehxVcmQ7zTHhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFRAPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgFRAPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:15:21 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9F520739;
        Thu, 18 Jun 2020 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592439319;
        bh=LVRbfx6McmO1jwjifbKoEBkqjsNkCuJXna8m0BidZao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yNpIs/c7jHDsjCx7w0HytsPRi8J91hCTwaETaezANMahGrfjU1M1dXeo5XgmQdWfH
         TFIHsmkhRPRqM8aLHlrNBpHaExi45mINWgvmDt+/XIacQ/eSHzhMRlPIoGAcSzx0j7
         4KM5tSk9/ScAUfYh09lmXSou9jCFOFqDu6zebxRQ=
Date:   Wed, 17 Jun 2020 17:15:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: skip ->watermark_boost for atomic
 order-0 allocations-fix
Message-Id: <20200617171518.96211e345de65c54b9343a3a@linux-foundation.org>
In-Reply-To: <31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org>
References: <31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 17:39:47 +0530 Charan Teja Kalla <charante@codeaurora.org> wrote:

> When boosting is enabled, it is observed that rate of atomic order-0
> allocation failures are high due to the fact that free levels in the
> system are checked with ->watermark_boost offset. This is not a problem
> for sleepable allocations but for atomic allocations which looks like
> regression.
> 
> This problem is seen frequently on system setup of Android kernel
> running on Snapdragon hardware with 4GB RAM size. When no extfrag event
> occurred in the system, ->watermark_boost factor is zero, thus the
> watermark configurations in the system are:
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 0
> 
> After launching some memory hungry applications in Android which can
> cause extfrag events in the system to an extent that ->watermark_boost
> can be set to max i.e. default boost factor makes it to 150% of high
> watermark.
>    _watermark = (
>           [WMARK_MIN] = 1272, --> ~5MB
>           [WMARK_LOW] = 9067, --> ~36MB
>           [WMARK_HIGH] = 9385), --> ~38MB
>    watermark_boost = 14077, -->~57MB
> 
> With default system configuration, for an atomic order-0 allocation to
> succeed, having free memory of ~2MB will suffice. But boosting makes
> the min_wmark to ~61MB thus for an atomic order-0 allocation to be
> successful system should have minimum of ~23MB of free memory(from
> calculations of zone_watermark_ok(), min = 3/4(min/2)). But failures are
> observed despite system is having ~20MB of free memory. In the testing,
> this is reproducible as early as first 300secs since boot and with
> furtherlowram configurations(<2GB) it is observed as early as first
> 150secs since boot.
> 
> These failures can be avoided by excluding the ->watermark_boost in
> watermark caluculations for atomic order-0 allocations.
> 

Some description of the changes in this version would help.

Below is the overall patch as it would land in mainline.  For
reviewers, please.

From: Charan Teja Reddy <charante@codeaurora.org>
Subject: mm, page_alloc: skip ->waternark_boost for atomic order-0 allocations

When boosting is enabled, it is observed that rate of atomic order-0
allocation failures are high due to the fact that free levels in the
system are checked with ->watermark_boost offset.  This is not a problem
for sleepable allocations but for atomic allocations which looks like
regression.

This problem is seen frequently on system setup of Android kernel running
on Snapdragon hardware with 4GB RAM size.  When no extfrag event occurred
in the system, ->watermark_boost factor is zero, thus the watermark
configurations in the system are:

   _watermark = (
          [WMARK_MIN] = 1272, --> ~5MB
          [WMARK_LOW] = 9067, --> ~36MB
          [WMARK_HIGH] = 9385), --> ~38MB
   watermark_boost = 0

After launching some memory hungry applications in Android which can cause
extfrag events in the system to an extent that ->watermark_boost can be
set to max i.e.  default boost factor makes it to 150% of high watermark.

   _watermark = (
          [WMARK_MIN] = 1272, --> ~5MB
          [WMARK_LOW] = 9067, --> ~36MB
          [WMARK_HIGH] = 9385), --> ~38MB
   watermark_boost = 14077, -->~57MB

With default system configuration, for an atomic order-0 allocation to
succeed, having free memory of ~2MB will suffice.  But boosting makes the
min_wmark to ~61MB thus for an atomic order-0 allocation to be successful
system should have minimum of ~23MB of free memory(from calculations of
zone_watermark_ok(), min = 3/4(min/2)).  But failures are observed despite
system is having ~20MB of free memory.  In the testing, this is
reproducible as early as first 300secs since boot and with furtherlowram
configurations(<2GB) it is observed as early as first 150secs since boot.

These failures can be avoided by excluding the ->watermark_boost in
watermark caluculations for atomic order-0 allocations.

[charante@codeaurora.org: fix suggested by Mel Gorman]
  Link: http://lkml.kernel.org/r/31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org
[akpm@linux-foundation.org: fix comment grammar, reflow comment]
Link: http://lkml.kernel.org/r/1589882284-21010-1-git-send-email-charante@codeaurora.org
Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-skip-waternark_boost-for-atomic-order-0-allocations
+++ a/mm/page_alloc.c
@@ -3580,7 +3580,7 @@ bool zone_watermark_ok(struct zone *z, u
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				unsigned long mark, int highest_zoneidx,
-				unsigned int alloc_flags)
+				unsigned int alloc_flags, gfp_t gfp_mask)
 {
 	long free_pages = zone_page_state(z, NR_FREE_PAGES);
 	long cma_pages = 0;
@@ -3602,8 +3602,23 @@ static inline bool zone_watermark_fast(s
 				mark + z->lowmem_reserve[highest_zoneidx])
 		return true;
 
-	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
-					free_pages);
+	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
+					free_pages))
+		return true;
+	/*
+	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
+	 * when checking the min watermark. The min watermark is the
+	 * point where boosting is ignored so that kswapd is woken up
+	 * when below the low watermark.
+	 */
+	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
+		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
+		mark = z->_watermark[WMARK_MIN];
+		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
+					alloc_flags, free_pages);
+	}
+
+	return false;
 }
 
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
@@ -3747,7 +3762,8 @@ retry:
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
-				       ac->highest_zoneidx, alloc_flags)) {
+				       ac->highest_zoneidx, alloc_flags,
+				       gfp_mask)) {
 			int ret;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
_

