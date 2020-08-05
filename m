Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3823C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DBC2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdpdWlhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHEINF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgHEIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:12:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07943C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:12:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so5384579wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQpAXAKr6GTVwsUX1cbs0chy8xDobqsX5dTE8YjHl24=;
        b=AdpdWlhXTzCcR+WzTN1v4E0OsU4J2DMIl8YWvZ3Sj9Yh7o68EKCRpwq9r+QzMLyyir
         TnwhUmcCtmDuyIcndoKOrhe1r4agoZ3COSZO9GlnjNxXvFsi70tu1i3HdomJveoMVIl2
         yOz6crp34Rxxq6WbaOtwjYoB/VsiHREjqs4FdJGIoR+wAdmw0Z46hKqRRmeop4RpGfEs
         w3tGKNfgWF4wzGDa3iRVSRqHt/rv2hL87qdjHnerIOBP/alshyNwmF54PActY99ka0bu
         u66WrEsPE3cy+d/GtaAz6i7iKyNq3QLFxTP7bPLqrk3egU+tzs7Knvn0ilnYjMdYv/Xo
         aCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQpAXAKr6GTVwsUX1cbs0chy8xDobqsX5dTE8YjHl24=;
        b=i+y6AUYoqNYs2p6poI3r6SX0eSofQ5UVodbkmWGkfmNuZTceAm2bUAGn6ggp2FTO0X
         3LkONqWYWNf1ngCg0UjOHV95/Sq1dJfat/PcBn2H3WNluBPkrSsKs4UrcY1benjcnUtW
         zyBo33808GUJDypABG0KyMsXufxsKtRi11ApdhwscsbMse11nZhdHHiEJXxvkrybzHtF
         tyGJXwvYtbCBFPZoarr3PTy+BguSpFeIV3V3z/euKkBq0YXFvS0einmU1vgzGgjZgl24
         XvYrtQAy2GRMZ9/M+zvwlPwar9or4yI2lBX3xrVj2+glW3lv86w91EyllKvOSV6adjiy
         /53A==
X-Gm-Message-State: AOAM533Ox/AEU9cBveCIeJ86faV2iXHghbiPyGxto5oH4Tu2pfwNPznc
        MEG2FUbu667hKjuZV0dHf+60Gw==
X-Google-Smtp-Source: ABdhPJzEchxyBP3fBg8aeweqi9LZ95rwdUU2Ah+J0k/rWSDJPv5NCgO6JGaZjKSIO01Vepgvc9S+mg==
X-Received: by 2002:a1c:9c91:: with SMTP id f139mr2302972wme.134.1596615172354;
        Wed, 05 Aug 2020 01:12:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a833])
        by smtp.gmail.com with ESMTPSA id e4sm1635863wru.55.2020.08.05.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 01:12:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:12:50 +0100
From:   Will Deacon <willdeacon@google.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     catalin.marinas@arm.com, Marc Zyngier <maz@kernel.org>,
        mark.rutland@arm.com, anup@brainfault.org, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        syven.wang@sifive.com
Subject: Re: [PATCH] riscv: Add sfence.vma after page table changed
Message-ID: <20200805081250.GA3064472@google.com>
References: <CAAhSdy1QbMjZxxu+wSBYr3+3oaM2Qg=_Uwj8dfQidi=ck6PV_Q@mail.gmail.com>
 <mhng-1f7adcd7-551c-4b8a-80f5-e1230b335c6a@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-1f7adcd7-551c-4b8a-80f5-e1230b335c6a@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:03:06PM -0700, Palmer Dabbelt wrote:
> > On Tue, Aug 4, 2020 at 8:32 AM Greentime Hu <greentime.hu@sifive.com> wrote:
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index f4adb3684f3d..29b0f7108054 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> > > 
> > >         ptep = &fixmap_pte[pte_index(addr)];
> > > 
> > > -       if (pgprot_val(prot)) {
> > > +       if (pgprot_val(prot))
> > >                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
> > > -       } else {
> > > +       else
> > >                 pte_clear(&init_mm, addr, ptep);
> > > -               local_flush_tlb_page(addr);
> > > -       }
> > > +       local_flush_tlb_page(addr);
> > >  }
> 
> arm64 appears to be upgrading all set_pte()s on valid kernel mappings to
> include the fence.  It looks like the message from 7f0b1bf04511 ("arm64: Fix
> barriers used for page table modifications") is out of date, as I can't find
> create_mapping() any more.  If that was some generic kernel thing then we
> should probably upgrade ours as well, but if it was arch/arm64/ code then this
> approach seems fine as __set_fixmap() isn't on the hot path -- I guess this is
> fine either way, but there may be other issues that the arm64 approach fixes.
> 
> Do you guys happen to remember what was going on here?

Basically, the architecture says we need these fences in order to guarantee
that the page-table walker sees the updated entry. Since we couldn't
tolerate spurious faults on kernel mappings, we had to add them (for
userspace we don't bother because in reality we don't tend to take the
spurious fault, and it's harmless if we do).

But having said all that, check out 42f91093b043 ("arm64: mm: Ignore spurious
translation faults taken from the kernel").

Will
