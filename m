Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC20C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579265137;
	bh=52weG7mBhiLrAZ4hQCT4ua9dMLjf94HUuSpVb7mHV88=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tIMWAb2HiSmL78pH7cugrCMnhxzTx5axOH7LAJZDANEJZMzmN7d1mMU3xYd5qc63/
	 8ykVf6bFnjmIUIK2bygK2IYwwzbWmgNfjSbC/Zmlt0gxzJNSHIuZFnWi+3ktZ0QxYU
	 DNqEvxPZOn+LNfsgJybNI7HulR4Ju6NfbgQqe00Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQMph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgAQMpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:45:36 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB2620730;
        Fri, 17 Jan 2020 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579265135;
        bh=52weG7mBhiLrAZ4hQCT4ua9dMLjf94HUuSpVb7mHV88=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kzusg6VG5yderSNBUkZ/BHF1JljB4S4kBxcgq0DEjVZmhYx+eN43nAsl4J0jWqSoW
         fDuxyLxFC++iv8beFTJZTWvEEPE1i6e2c+RIrdyLr1nyPly3D01T+QhiczsWgDKsfj
         lNq95wnJg3KeYiJKK4TL7GZh/RaItUa8HwkA+VAA=
Date:   Fri, 17 Jan 2020 12:45:30 +0000
From:   Will Deacon <will@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200117124529.GD8199@willie-the-truck>
References: <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org>
 <20200109083254.GA7280@willie-the-truck>
 <20200110160549.GA25437@willie-the-truck>
 <CA+CK2bAy-vfoz3kgUjZB74Hrobgu-a8H4pv6RbA_tbq++NWz5g@mail.gmail.com>
 <20200113112105.GB2337@willie-the-truck>
 <20200114053825.GC28530@linaro.org>
 <20200116180857.GA22420@willie-the-truck>
 <20200117063832.GQ28530@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117063832.GQ28530@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:38:33PM +0900, AKASHI Takahiro wrote:
> On Thu, Jan 16, 2020 at 06:08:58PM +0000, Will Deacon wrote:
> > On Tue, Jan 14, 2020 at 02:38:26PM +0900, AKASHI Takahiro wrote:
> > > On Mon, Jan 13, 2020 at 11:21:06AM +0000, Will Deacon wrote:
> > > > On Fri, Jan 10, 2020 at 11:19:16AM -0500, Pavel Tatashin wrote:
> > > > > On Fri, Jan 10, 2020 at 11:05 AM Will Deacon <will@kernel.org> wrote:
> > > > > > On Thu, Jan 09, 2020 at 08:32:54AM +0000, Will Deacon wrote:
> > > > > > > On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> > > > > > > > On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > > > > > > > > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > > > > > > > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > > > > > > > > index 12a561a54128..d24b527e8c00 100644
> > > > > > > > > > --- a/arch/arm64/include/asm/kexec.h
> > > > > > > > > > +++ b/arch/arm64/include/asm/kexec.h
> > > > > > > > > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > > > > > > > > >  struct kimage_arch {
> > > > > > > > > >         void *dtb;
> > > > > > > > > >         unsigned long dtb_mem;
> > > > > > > > > > +       /* Core ELF header buffer */
> > > > > > > > > > +       void *elf_headers;
> > > > > > > > > > +       unsigned long elf_headers_mem;
> > > > > > > > > > +       unsigned long elf_headers_sz;
> > > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > This conflicts with the cleanup work from Pavel. Please can you check my
> > > > > > > > > resolution? [1]
> > > > > > > >
> > > > > > > > I don't know why we need to change a type of dtb_mem,
> > > > > > > > otherwise it looks good.
> > > > > > > >
> > > > > > > > (I also assume that you notice that kimage_arch is of no use for kexec.)
> > > > > > >
> > > > > > > Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
> > > > > > > to drop Pavel's patch altogether in light of your changes, we can do that
> > > > > > > instead.
> > > > > > >
> > > > > > > Thoughts?
> > > > > >
> > > > > > Well, I've reverted the cleanup patch so please shout if you'd prefer
> > > > > > something else.
> > > > > 
> > > > > As I understand, the only concern was the type change for dtb_mem.
> > > > > This was one of the review comments for my patch
> > > > > https://lore.kernel.org/lkml/20191204155938.2279686-21-pasha.tatashin@soleen.com/
> > > > > 
> > > > > (I believe it was from Marc Zyngier), I add a number of new fields,
> > > > > and they all should be phys_addr_t, this is why I change dtb_mem to
> > > > > phys_addr_t to be consistent.
> > > > 
> > > > Sure, but I've only queued the first part of your series and that cleanup
> > > > patch doesn't make a lot of sense when applied against Akashi's work. I'm
> > > > happy to take stuff on top if you both agree to it, but having half of the
> > > > struct use unsigned long and the other half use phys_addr_t is messy.
> > > 
> > > Logically, whether dtb_mem is a "unsigned long" or phys_addr_t doesn't
> > > matter unless the kernel is compiled under LLP64.
> > > As far as the existing kexec code, either generic or arm64-specific,
> > > is concerned, however, "unsigned long is widely used as a physical address
> > > (For example, see kexec_buf definition) over the code.
> > > 
> > > (Oops, reboot_code_buffer_phys is a phys_addr_t :)
> > > 
> > > So as long as my kexec_file (and associated kdump) patch comes first
> > > before Pavel's, I'd like to keep using "unsigned long".
> > > Then, you can change "unsigned long" to phys_addr_t in your patch
> > > for whatever reason it is.
> > > 
> > > Please note that, if you want to do that, it would be better to modify
> > > not only kimage_arch but also all the occurrences of "unsigned long"
> > > to phys_addr_t for maintaining the integrity.
> > > 
> > > In addition, in my kexec_file kdump code, I still believe that
> > > "#ifdef CONFIG_KEXEC_FILE" should stay before the definition of
> > > kimage_arch as kimage_arch is of no use for normal kexec code.
> > > 
> > > Again,
> > > "#ifdef" statement may be moved forward once additional fields be
> > > added later by Pavel's patch, say, "[PATCH v8 15/25] arm64: kexec:
> > > move relocation function setup" for any reason.
> > > 
> > > I believe that this way gives us a logical and consistent view of
> > > history of changes.
> > > Make sense?
> > 
> > This is a bit much to stick in a merge commit, so I'll stick with the revert
> > for now and you can send patches on top if you want it changed.
> 
> Are you asking me or Pavel? And on top of which branch?

I'm not asking anything ;p

But by "you" I mean both of you (the joys of ambiguous English). In other
words, I've reverted the patch [1], but I'm happy to take other patches on
top providing that you both agree with each other on what you want to do.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/kexec/cleanup&id=1595fe299eb5a664c754eaf48bc178c0d664e1cf
