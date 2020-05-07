Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AB1C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59092080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588840663;
	bh=UfbG32gghEnagxdM/s07RMhpIOEDCca3UVjRhkdrfA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K3PHk2k7mFD78Y4/qAslU/H+2IF3e4brx5YrdFzvzCSwdoTTuH91P8QHmqxwzGfbm
	 7aIIzYO7xDokvc4LtJhDSm5SLVwLnDHRSrwTF/QlM1QVoAoi2PM63cUHcSTYv1JzfC
	 k6rcUkn40ElutZYOM09ABx1CYS3WUNoLKuvzMGyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGIhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgEGIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:37:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FA82078C;
        Thu,  7 May 2020 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588840661;
        bh=UfbG32gghEnagxdM/s07RMhpIOEDCca3UVjRhkdrfA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YThvRAXTq/axvNiQxDIgMsKSH75GoJAMMVFJySLe+uVCUTq7iUq88GILs6BOyM+X
         asd4QgHl3ocvp+CbSFScegyXFuiCm/7QBw/QnYnzvuzEJlD/9kPlspqPiKJcfL4kgw
         Gvf3mvDdhrZjtAlXoCZHPKvWEB4sKspWBbNUyqQI=
Date:   Thu, 7 May 2020 09:37:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/mm: Remove add_huge_page_size()
Message-ID: <20200507083737.GB28215@willie-the-truck>
References: <20200506064635.20114-1-gshan@redhat.com>
 <fa3ad75d-9c4d-d6c9-1664-53b4c9770c6b@arm.com>
 <20200506071927.GB7021@willie-the-truck>
 <e13bb496-7988-e096-2131-78c004231f27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13bb496-7988-e096-2131-78c004231f27@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:15:59AM +1000, Gavin Shan wrote:
> On 5/6/20 5:19 PM, Will Deacon wrote:
> > On Wed, May 06, 2020 at 12:36:43PM +0530, Anshuman Khandual wrote:
> > > 
> > > 
> > > On 05/06/2020 12:16 PM, Gavin Shan wrote:
> > > > The function add_huge_page_size(), wrapper of hugetlb_add_hstate(),
> > > > avoids to register duplicated huge page states for same size. However,
> > > > the same logic has been included in hugetlb_add_hstate(). So it seems
> > > > unnecessary to keep add_huge_page_size() and this just removes it.
> > > 
> > > Makes sense.
> > > 
> > > > 
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > ---
> > > >   arch/arm64/mm/hugetlbpage.c | 18 +++++-------------
> > > >   1 file changed, 5 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > > > index bbeb6a5a6ba6..ed7530413941 100644
> > > > --- a/arch/arm64/mm/hugetlbpage.c
> > > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > > @@ -441,22 +441,14 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
> > > >   	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > > >   }
> > > > -static void __init add_huge_page_size(unsigned long size)
> > > > -{
> > > > -	if (size_to_hstate(size))
> > > > -		return;
> > > > -
> > > > -	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> > > > -}
> > > > -
> > > >   static int __init hugetlbpage_init(void)
> > > >   {
> > > >   #ifdef CONFIG_ARM64_4K_PAGES
> > > > -	add_huge_page_size(PUD_SIZE);
> > > > +	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> > > >   #endif
> > > > -	add_huge_page_size(CONT_PMD_SIZE);
> > > > -	add_huge_page_size(PMD_SIZE);
> > > > -	add_huge_page_size(CONT_PTE_SIZE);
> > > > +	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);
> > > > +	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> > > > +	hugetlb_add_hstate(CONT_PTE_SHIFT);
> > 
> > Something similar has already been done in linux-next.
> > 
> 
> Thanks, Will. I didn't check linux-next before posting this patch.
> Please ignore it then :)
> 
> > > Should these page order values be converted into macros instead. Also
> > > we should probably keep (CONT_PTE_SHIFT + PAGE_SHIFT - PAGE_SHIFT) as
> > > is to make things more clear.
> > 
> > I think the real confusion stems from us not being consistent with your
> > *_SHIFT definitions on arm64. It's madness for CONT_PTE_SHIFT to be smaller
> > than PAGE_SHIFT imo, but it's just cosmetic I guess.
> > 
> 
> Yeah, Do you want me to post a patch, to fix it?

Let's wait until 5.8 is out the door first, since we've already got a fair
amount of activity in this area and it would be a pity if we broke something
as a result of cleanup!

Cheers,

Will
