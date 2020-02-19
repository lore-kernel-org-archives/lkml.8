Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF773C5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E1624656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSXc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:32:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:54129 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgBSXc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:32:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 15:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="382956888"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.152]) ([10.254.209.152])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2020 15:32:54 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
To:     Yonghyun Hwang <yonghyun@google.com>,
        Moritz Fischer <mdf@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <moritzf@google.com>
References: <20200218222324.231915-1-yonghyun@google.com>
 <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
 <20200219044235.GA1397@epycbox.lan>
 <CAEauFbw_FGWuQJMpr7PgyyCAefKChXoszKAz-ykBKgxFc-aa4g@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9e3f1bb8-bbfd-174c-b7a7-617dea7c2c9a@linux.intel.com>
Date:   Thu, 20 Feb 2020 07:32:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEauFbw_FGWuQJMpr7PgyyCAefKChXoszKAz-ykBKgxFc-aa4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/2/20 2:51, Yonghyun Hwang wrote:
> Hello Lu and Moritz,
> 
> I think it's better to keep "if (level > 1)" because 
> level_to_offset_bits() returns (unsigned int) -1 * LEVEL_STRIDE if level 
> becomes 0.

@level will never be 0 in this case.

Best regards,
baolu

> 
> static inline unsigned int level_to_offset_bits(int level)
> {
>    return (level - 1) * LEVEL_STRIDE;
> }
> 
> On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org 
> <mailto:mdf@kernel.org>> wrote:
> 
>     Hi Baolu, Yonghyun
> 
>     On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
>      > Hi Yonghyun,
>      >
>      > Thanks for the patch.
>      >
>      > On 2020/2/19 6:23, Yonghyun Hwang wrote:
>      > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
>     for a huge
>      > > page onto its corresponding physical address. This commit fixes
>     the bug by
>      > > accomodating the level of page entry for the IOVA and adds
>     IOVA's lower
>      > > address to the physical address. >
>      > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
>     <mailto:yonghyun@google.com>>
>      > > ---
>      > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
>      > >   1 file changed, 9 insertions(+), 2 deletions(-)
>      > >
>      > > diff --git a/drivers/iommu/intel-iommu.c
>     b/drivers/iommu/intel-iommu.c
>      > > index 0c8d81f56a30..ed6e69adb578 100644
>      > > --- a/drivers/iommu/intel-iommu.c
>      > > +++ b/drivers/iommu/intel-iommu.c
>      > > @@ -5555,13 +5555,20 @@ static phys_addr_t
>     intel_iommu_iova_to_phys(struct iommu_domain *domain,
>      > >     struct dma_pte *pte;
>      > >     int level = 0;
>      > >     u64 phys = 0;
>      > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
>      >
>      > Why do you need a "const unsigned long" here?
> 
> 
> 
> It's because pfn_to_dma_pte() takes pfn for its second parameter as 
> "unsigned int" type and pfn is not changed in intel_iommu_iova_to_phys().
> 
>      >
>      > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>      > >             return 0;
>      > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>     &level);
>      > > -   if (pte)
>      > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
>      > > +   if (pte) {
>      > >             phys = dma_pte_addr(pte);
>      > > +           if (level > 1)
>      > > +                   phys += (pfn &
>      > > +                           ((1UL <<
>     level_to_offset_bits(level)) - 1))
>      > > +                           << VTD_PAGE_SHIFT;
>      > > +           phys += iova & (VTD_PAGE_SIZE - 1);
>      >
>      > How about
> 
>      >
>      > diff --git a/drivers/iommu/intel-iommu.c
>     b/drivers/iommu/intel-iommu.c
>      > index 9dc37672bf89..bd17c2510bb2 100644
>      > --- a/drivers/iommu/intel-iommu.c
>      > +++ b/drivers/iommu/intel-iommu.c
>      > @@ -5693,8 +5693,14 @@ static phys_addr_t
>     intel_iommu_iova_to_phys(struct
>      > iommu_domain *domain,
>      >         u64 phys = 0;
>      >
>      >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>     &level);
>      > -       if (pte)
>      > +       if (pte) {
>      > +               unsigned long offset_mask;
>      > +
>      > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
>      > +                                      VTD_PAGE_SHIFT) - 1;
>      >                 phys = dma_pte_addr(pte);
>      > +               phys += iova & (bitmask - 1);
>     Did you mean:
> 
>     phys += iova & (offset_mask - 1);
> 
>      > +       }
> 
>     At that point why not define a helper:
> 
>     static inline unsigned long offset_mask(int level)
>     {
>              return BIT_MASK(level_to_offset_bits(level) +
>     VTD_PAGE_SHIFT) - 1;
>     }
> 
>     At which point the above would reduce to:
> 
>     if (pte)
>              phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
> 
> 
> 
> Let me introduce the helper function and upstream the patch again. Thank 
> you Lu and Moritz.
> 
> 
>     I might've fatfingered something here, but you get the idea :)
> 
>     Cheers,
>     Moritz
> 
> 
> On Tue, Feb 18, 2020 at 8:42 PM Moritz Fischer <mdf@kernel.org 
> <mailto:mdf@kernel.org>> wrote:
> 
>     Hi Baolu, Yonghyun
> 
>     On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
>      > Hi Yonghyun,
>      >
>      > Thanks for the patch.
>      >
>      > On 2020/2/19 6:23, Yonghyun Hwang wrote:
>      > > intel_iommu_iova_to_phys() has a bug when it translates an IOVA
>     for a huge
>      > > page onto its corresponding physical address. This commit fixes
>     the bug by
>      > > accomodating the level of page entry for the IOVA and adds
>     IOVA's lower
>      > > address to the physical address. >
>      > > Signed-off-by: Yonghyun Hwang <yonghyun@google.com
>     <mailto:yonghyun@google.com>>
>      > > ---
>      > >   drivers/iommu/intel-iommu.c | 11 +++++++++--
>      > >   1 file changed, 9 insertions(+), 2 deletions(-)
>      > >
>      > > diff --git a/drivers/iommu/intel-iommu.c
>     b/drivers/iommu/intel-iommu.c
>      > > index 0c8d81f56a30..ed6e69adb578 100644
>      > > --- a/drivers/iommu/intel-iommu.c
>      > > +++ b/drivers/iommu/intel-iommu.c
>      > > @@ -5555,13 +5555,20 @@ static phys_addr_t
>     intel_iommu_iova_to_phys(struct iommu_domain *domain,
>      > >     struct dma_pte *pte;
>      > >     int level = 0;
>      > >     u64 phys = 0;
>      > > +   const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
>      >
>      > Why do you need a "const unsigned long" here?
>      >
>      > >     if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
>      > >             return 0;
>      > > -   pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>     &level);
>      > > -   if (pte)
>      > > +   pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
>      > > +   if (pte) {
>      > >             phys = dma_pte_addr(pte);
>      > > +           if (level > 1)
>      > > +                   phys += (pfn &
>      > > +                           ((1UL <<
>     level_to_offset_bits(level)) - 1))
>      > > +                           << VTD_PAGE_SHIFT;
>      > > +           phys += iova & (VTD_PAGE_SIZE - 1);
>      >
>      > How about
> 
>      >
>      > diff --git a/drivers/iommu/intel-iommu.c
>     b/drivers/iommu/intel-iommu.c
>      > index 9dc37672bf89..bd17c2510bb2 100644
>      > --- a/drivers/iommu/intel-iommu.c
>      > +++ b/drivers/iommu/intel-iommu.c
>      > @@ -5693,8 +5693,14 @@ static phys_addr_t
>     intel_iommu_iova_to_phys(struct
>      > iommu_domain *domain,
>      >         u64 phys = 0;
>      >
>      >         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
>     &level);
>      > -       if (pte)
>      > +       if (pte) {
>      > +               unsigned long offset_mask;
>      > +
>      > +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
>      > +                                      VTD_PAGE_SHIFT) - 1;
>      >                 phys = dma_pte_addr(pte);
>      > +               phys += iova & (bitmask - 1);
>     Did you mean:
> 
>     phys += iova & (offset_mask - 1);
> 
>      > +       }
> 
>     At that point why not define a helper:
> 
>     static inline unsigned long offset_mask(int level)
>     {
>              return BIT_MASK(level_to_offset_bits(level) +
>     VTD_PAGE_SHIFT) - 1;
>     }
> 
>     At which point the above would reduce to:
> 
>     if (pte)
>              phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;
> 
>     I might've fatfingered something here, but you get the idea :)
> 
>     Cheers,
>     Moritz
> 
