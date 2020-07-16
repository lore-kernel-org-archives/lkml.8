Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB90F20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594887172;
	bh=DU9UumKlPvL+1fCVdqR/xdZoxBSrtF6C3UAH9rPIJVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PkHTIEYMwWxKVdoWI19Xjkq4SJeSn4FZTgKzrVoSlYlnMMgVO9pb7OpbyYi/deuG
	 V9aQEwklalLpARX2Vy8CGLQ67C7q/W42OdgQobmlRyi3agHROQYo8yfEOorJYuHNRZ
	 SH2aTzI1KXbPEKIhscHXg/jBcohmMCxCgSxuM4Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGPIMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgGPIMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:12:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FFC206F4;
        Thu, 16 Jul 2020 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594887169;
        bh=DU9UumKlPvL+1fCVdqR/xdZoxBSrtF6C3UAH9rPIJVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktHFTMZlp38AK5ttG0tgP1Tt6CYadea+52Kjtp6iZhaWlJaYUb4r7JFd8hxG2drQ4
         D5b3tkQx8MEJIXgUlwRzEJBp5buChqiXd1iVOz1FLyq9cRZgdHeK2Qa7PbNQKk4aMx
         o+3lkyCOBpgsASbpCN34U0D7g5eIHdtGhyObAdNk=
Date:   Thu, 16 Jul 2020 09:12:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        Roman Gushchin <guro@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
Message-ID: <20200716081243.GA6561@willie-the-truck>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:59:24AM -0700, Mike Kravetz wrote:
> On 7/15/20 1:18 AM, Will Deacon wrote:
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index f24acb3af741..a0007d1d12d2 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -3273,6 +3273,9 @@ void __init hugetlb_add_hstate(unsigned int order)
> >>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
> >>  					huge_page_size(h)/1024);
> > 
> > (nit: you can also make hugetlb_cma_reserve() static and remote its function
> > prototypes from hugetlb.h)
> 
> Yes thanks.  I threw this together pretty quickly.
> 
> > 
> >> +	if (order >= MAX_ORDER && hugetlb_cma_size)
> >> +		hugetlb_cma_reserve(order);
> > 
> > Although I really like the idea of moving this out of the arch code, I don't
> > quite follow the check against MAX_ORDER here -- it looks like a bit of a
> > hack to try to intercept the "PUD_SHIFT - PAGE_SHIFT" order which we
> > currently pass to hugetlb_cma_reserve(). Maybe we could instead have
> > something like:
> > 
> > 	#ifndef HUGETLB_CMA_ORDER
> > 	#define HUGETLB_CMA_ORDER	(PUD_SHIFT - PAGE_SHIFT)
> > 	#endif
> > 
> > and then just do:
> > 
> > 	if (order == HUGETLB_CMA_ORDER)
> > 		hugetlb_cma_reserve(order);
> > 
> > ? Is there something else I'm missing?
> > 
> 
> Well, the current hugetlb CMA code only kicks in for gigantic pages as
> defined by the hugetlb code. For example, the code to allocate a page
> from CMA is in the routine alloc_gigantic_page().  alloc_gigantic_page()
> is called from alloc_fresh_huge_page() which starts with:
> 
>         if (hstate_is_gigantic(h))
>                 page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
>         else
>                 page = alloc_buddy_huge_page(h, gfp_mask,
>                                 nid, nmask, node_alloc_noretry);
> 
> and, hstate_is_gigantic is,
> 
> static inline bool hstate_is_gigantic(struct hstate *h)
> {
>         return huge_page_order(h) >= MAX_ORDER;
> }
> 
> So, everything in the existing code really depends on the hugetlb definition
> of gigantic page (order >= MAX_ORDER).  The code to check for
> 'order >= MAX_ORDER' in my proposed patch is just following the same
> convention.

Fair enough, and thanks for the explanation. Maybe just chuck a comment in,
then? Alternatively, having something like:

static inline bool page_order_is_gigantic(unsigned int order)
{
	return order >= MAX_ORDER;
}

static inline bool hstate_is_gigantic(struct hstate *h)
{
	return page_order_is_gigantic(huge_page_order(h));
}

and then using page_order_is_gigantic() to predicate the call to
hugetlb_cma_reserve? Dunno, maybe it's overkill. Up to you.

> I think the current dependency on the hugetlb definition of gigantic page
> may be too simplistic if using CMA for huegtlb pages becomes more common.
> Some architectures (sparc, powerpc) have more than one gigantic pages size.
> Currently there is no way to specify that CMA should be used for one and
> not the other.  In addition, I could imagine someone wanting to reserve/use
> CMA for non-gigantic (PMD) sized pages.  There is no mechainsm for that today.
> 
> I honestly have not heard about many use cases for this CMA functionality.
> When support was initially added, it was driven by a specific use case and
> the 'all gigantic pages use CMA if defined' implementation was deemed
> sufficient.  If there are more use cases, or this seems too simple we can
> revisit that decision.

Agreed, I think your patch is an improvement regardless of that.

Will
