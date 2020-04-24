Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F67AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AF120776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NtY+hhn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgDXKyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:54:13 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3BC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Xa2PUMRqvFJR5GwWTaYEgHQNPO5CXK8JGRyEXAVy64=; b=NtY+hhn0FtOdG+6yBaAhPrZSgI
        ywkvKZ5g6k9+9XxJlPM4Kf0Ip/BFfYCQg8SZvKqLHPBcSEA18GsUtxMhJabuCmZ18LvEp4JhvdVrq
        exmRqYmiYgr3lhnEnMvJNxSoWXnH5qyyGncL6qGH12rlJOWIS7FOVDgMgTA8QxkZaS2HV3eNk1qo2
        /TIpyzI3fgyv9N/9/Eu9CgG7JlyxR/yCGF32kvdp1/H/KiN3WXuBKLWMSO/V2P+gx3ILtxkGw/iV+
        0+OCT6bqmFjD09/5lSFHlpAZU+6/hMV3LvTfblt7w/YWWTSEWbGcqJKX8ismo3gCECQnYfnwafmN8
        wAns82Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRvxp-0007lg-18; Fri, 24 Apr 2020 10:53:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 287F6306108;
        Fri, 24 Apr 2020 12:53:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 112922392DE86; Fri, 24 Apr 2020 12:53:43 +0200 (CEST)
Date:   Fri, 24 Apr 2020 12:53:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] x86/mm/cpa: Flush direct map alias during cpa
Message-ID: <20200424105343.GA20730@hirez.programming.kicks-ass.net>
References: <20200423031355.23955-1-rick.p.edgecombe@intel.com>
 <20200423084114.GS20713@hirez.programming.kicks-ass.net>
 <f1c60f169231ecf65facb9b6c1af96ef75a0eb78.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c60f169231ecf65facb9b6c1af96ef75a0eb78.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:02:26PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2020-04-23 at 10:41 +0200, Peter Zijlstra wrote:
> > Wouldn't something like so make more sense?
> 
> Yes. Dave had commented on whether a smaller fix would be better for
> backports if needed. Since that diff is the whole fix, do you want to
> take it from here or should I put it in a patch?

I've made it look like this. Holler if you need it changed ;-)

---
Subject: x86/mm/cpa: Flush direct map alias during cpa
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Wed, 22 Apr 2020 20:13:55 -0700

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

As an optimization, cpa_flush() was changed to optionally only flush
the range in @cpa if it was small enough.  However, this range does
not include any direct map aliases changed in cpa_process_alias(). So
small set_memory_() calls that touch that alias don't get the direct
map changes flushed. This situation can happen when the virtual
address taking variants are passed an address in vmalloc or modules
space.

In these cases, force a full TLB flush.

Note this issue does not extend to cases where the set_memory_() calls are
passed a direct map address, or page array, etc, as the primary target. In
those cases the direct map would be flushed.

Fixes: 935f5839827e ("x86/mm/cpa: Optimize cpa_flush_array() TLB invalidation")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -43,7 +43,8 @@ struct cpa_data {
 	unsigned long	pfn;
 	unsigned int	flags;
 	unsigned int	force_split		: 1,
-			force_static_prot	: 1;
+			force_static_prot	: 1,
+			force_flush_all		: 1;
 	struct page	**pages;
 };
 
@@ -355,10 +356,10 @@ static void cpa_flush(struct cpa_data *d
 		return;
 	}
 
-	if (cpa->numpages <= tlb_single_page_flush_ceiling)
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
-	else
+	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
+	else
+		on_each_cpu(__cpa_flush_tlb, cpa, 1);
 
 	if (!cache)
 		return;
@@ -1598,6 +1599,8 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
+
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
 		if (ret)
 			return ret;
@@ -1618,6 +1621,7 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		cpa->force_flush_all = 1;
 		/*
 		 * The high mapping range is imprecise, so ignore the
 		 * return value.
