Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A212076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586991199;
	bh=WdDt++T0TbKV96xjyLypO9w7oBncQPpiZTQa5qF/uEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fOUhgEvMFLOoxzADiDDK0aV76//4FWsHvs3aeK6ecdSYb2ANuBRlL2LG1PN0q5ojS
	 H3LTKo8tthBnNC16HYLhXI/fKrivKn/V5KJVV3rv+9nY1R598TBfwAne8TnaMTTAWR
	 5WJXbTvEnpu94T1MIIn8/qHxScnQMoZDLX2r6tpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgDOWxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDOWxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:53:01 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154B32076D;
        Wed, 15 Apr 2020 22:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586991180;
        bh=WdDt++T0TbKV96xjyLypO9w7oBncQPpiZTQa5qF/uEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIObiXjJioAOylPSwb0uL8ZY5Jwv8Walwio8CdnTXmOhiWN8gyyAgoGVZGkMpaA4t
         07pbJX77HmtdWrT+ZbXYCTIJcefzia9KIUsWVkIvYME/dHKVqFQzERCUjjUcp2VTzF
         pgVIjOakDbN+TjBYQ9w/O6i/Rke3pMTE6SIM5lqk=
Date:   Wed, 15 Apr 2020 15:52:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 6/8] khugepaged: Allow to collapse PTE-mapped
 compound pages
Message-Id: <20200415155259.8be9887c64b1420cfc9b9655@linux-foundation.org>
In-Reply-To: <20200415215205.eaihc5snfe4ffhju@box>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
        <20200413125220.663-7-kirill.shutemov@linux.intel.com>
        <20200415144426.a146ef173140f5bc396a6dcd@linux-foundation.org>
        <20200415215205.eaihc5snfe4ffhju@box>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 00:52:05 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Wed, Apr 15, 2020 at 02:44:26PM -0700, Andrew Morton wrote:
> > On Mon, 13 Apr 2020 15:52:18 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > 
> > > We can collapse PTE-mapped compound pages. We only need to avoid
> > > handling them more than once: lock/unlock page only once if it's present
> > > in the PMD range multiple times as it handled on compound level. The
> > > same goes for LRU isolation and putback.
> > > 
> > > ...
> > >
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -515,17 +515,30 @@ void __khugepaged_exit(struct mm_struct *mm)
> > >  
> > >  static void release_pte_page(struct page *page)
> > >  {
> > > -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> > 
> > I have
> > 
> > 	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_lru(page));
> > 
> > here.  Is there some prerequisite which I wasn't able to find?
> 
> The patchset is on top of v5.6. It has been changed since. See
> 9de4f22a60f7 ("mm: code cleanup for MADV_FREE").
> 
> Look like a trivial fixup is required.

[7/8] makes a big mess.  Can we please have a v4?
