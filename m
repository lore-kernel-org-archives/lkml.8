Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9719BC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A41218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkQEYk3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBFVc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:32:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BN/T3iMnshevhsyreqpehr4+Oh90ZbYGm4K+QPmJ9jM=; b=HkQEYk3NOb8LurbbgnSTfjHPrQ
        JN9NrBJ4Sv6+SJ0w98XBDtUuGXXCd6d58f198Hbo37Io7B9400fEXAd9srxLhxe1bW9p0N1k/XKNh
        KezL8bg3sjH7Fku6t2ezLJZ8y4TIXvq4Cz0Z1ZkzC8bgxGfmY50z34fdYAUvlRQ71TC+vbAw1dRjP
        oRj1jKUChwM1VIEPbPvKZf1Qj2ZDLIhv2xt2fbXEylMZZ/8jTgRAnPCiylS+8Rf3JaI5LA6KnxUOc
        DQ4xxaEmYujFG3hy7gtGT+dxjic1Qa/mCTgCrAwsL9kR/yaEOACH/awyZLveYpuf/sd5za29tHrcW
        eDs/rClA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izolb-0007wN-Lu; Thu, 06 Feb 2020 21:32:55 +0000
Date:   Thu, 6 Feb 2020 13:32:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
Message-ID: <20200206213255.GC8731@bombadil.infradead.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
 <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
 <20200204215319.GO8731@bombadil.infradead.org>
 <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
 <2ba63021-d05c-a648-f280-6c751e01adf6@oracle.com>
 <20200206203945.GZ8731@bombadil.infradead.org>
 <5e7800f2-3df3-a597-c164-5537b7f66417@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7800f2-3df3-a597-c164-5537b7f66417@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 01:23:21PM -0800, Mike Kravetz wrote:
> On 2/6/20 12:39 PM, Matthew Wilcox wrote:
> > On Wed, Feb 05, 2020 at 05:36:44PM -0800, Mike Kravetz wrote:
> >> The value of min_free_kbytes is calculated in two routines:
> >> 1) init_per_zone_wmark_min based on available memory
> >> 2) set_recommended_min_free_kbytes may reserve extra space for
> >>    THP allocations
> >>
> >> In both of these routines, a user defined min_free_kbytes value will
> >> be overwritten if the value calculated in the code is larger. No message
> >> is logged if the user value is overwritten.
> >>
> >> Change code to never overwrite user defined value.  However, do log a
> >> message (once per value) showing the value calculated in code.
> > 
> > But what if the user set min_free_kbytes to, say, half of system memory,
> > and then hot-unplugs three quarters of their memory?  I think the kernel
> > should protect itself against such foolishness.
> 
> I'm not sure what we should set it to in this case.  Previously you said,
> 
> >> I'm reluctant to suggest we do a more complex adjustment of the value
> >> (eg figure out what the adjustment would have been, then apply some
> >> fraction of that adjustment to keep the ratios in proportion) because
> >> we don't really know why they adjusted it.
> 
> So, I suspect you would suggest setting it to the default computed value?
> But then, when do we start adjusting?  What if they only remove a small
> amount of memory?  And, then add the same amount back in?

I don't know about the default computed value ... we don't seem to have
any protection against the user setting min_free_kbytes to double the
amount of memory in the machine today.  Which would presumably cause
problems if I asked to maintain 32GB free at all times on my 16GB laptop?

Maybe we should have such protection?

> BTW - In the above scenario existing code would not change min_free_kbytes
> because the user defined value is greater than value computed in code.

True!
