Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E6C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F13B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578914473;
	bh=OuK+LaRV/ZHDJhzQECD6orhexsBuPcHYw40Uzm4U2Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmM1BWfRrN6KZfifALyFKVPpvOAHqqSL20/DADXP9AR3RY8pR1L4HY5x+Q6jaHGRJ
	 kHSmoKC236ubBpCIeBqjRlbNk3Fom3QuXshvFNfngYU8yPmvjtU0q2ymQUBLQN8nxO
	 BHnwiO5+zmmTgMb+qihFBtc1Lkrhw482ZbZZVFB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgAMLVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgAMLVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:21:11 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D7B207FF;
        Mon, 13 Jan 2020 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578914471;
        bh=OuK+LaRV/ZHDJhzQECD6orhexsBuPcHYw40Uzm4U2Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWZiWF2VQAg1WiXK48ln/JbWSNhePOZDL9OZmpqs6ZtMuwXPhoh/s/yiG1rxPcjan
         AhAgqPwtbTaiAxgMUzok61pjSz/yD6JY29wiaD4yziTDV18jQOdA3mtdTR/tPOho53
         eQ0L2nzc33gVv4Sa8MX30ecHqH6a1jTFialbbA6Q=
Date:   Mon, 13 Jan 2020 11:21:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200113112105.GB2337@willie-the-truck>
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org>
 <20200109083254.GA7280@willie-the-truck>
 <20200110160549.GA25437@willie-the-truck>
 <CA+CK2bAy-vfoz3kgUjZB74Hrobgu-a8H4pv6RbA_tbq++NWz5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAy-vfoz3kgUjZB74Hrobgu-a8H4pv6RbA_tbq++NWz5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:19:16AM -0500, Pavel Tatashin wrote:
> On Fri, Jan 10, 2020 at 11:05 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jan 09, 2020 at 08:32:54AM +0000, Will Deacon wrote:
> > > On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> > > > On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > > > > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > > > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > > > > index 12a561a54128..d24b527e8c00 100644
> > > > > > --- a/arch/arm64/include/asm/kexec.h
> > > > > > +++ b/arch/arm64/include/asm/kexec.h
> > > > > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > > > > >  struct kimage_arch {
> > > > > >         void *dtb;
> > > > > >         unsigned long dtb_mem;
> > > > > > +       /* Core ELF header buffer */
> > > > > > +       void *elf_headers;
> > > > > > +       unsigned long elf_headers_mem;
> > > > > > +       unsigned long elf_headers_sz;
> > > > > >  };
> > > > >
> > > > > This conflicts with the cleanup work from Pavel. Please can you check my
> > > > > resolution? [1]
> > > >
> > > > I don't know why we need to change a type of dtb_mem,
> > > > otherwise it looks good.
> > > >
> > > > (I also assume that you notice that kimage_arch is of no use for kexec.)
> > >
> > > Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
> > > to drop Pavel's patch altogether in light of your changes, we can do that
> > > instead.
> > >
> > > Thoughts?
> >
> > Well, I've reverted the cleanup patch so please shout if you'd prefer
> > something else.
> 
> As I understand, the only concern was the type change for dtb_mem.
> This was one of the review comments for my patch
> https://lore.kernel.org/lkml/20191204155938.2279686-21-pasha.tatashin@soleen.com/
> 
> (I believe it was from Marc Zyngier), I add a number of new fields,
> and they all should be phys_addr_t, this is why I change dtb_mem to
> phys_addr_t to be consistent.

Sure, but I've only queued the first part of your series and that cleanup
patch doesn't make a lot of sense when applied against Akashi's work. I'm
happy to take stuff on top if you both agree to it, but having half of the
struct use unsigned long and the other half use phys_addr_t is messy.

Will
