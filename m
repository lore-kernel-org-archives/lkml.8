Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25116C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5DA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJPiX4Ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgANFjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:39:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40327 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANFjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:39:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so5848813pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7n7f6CO+MVHSnzRHpdk3x7t2oPCQj5a+pENYzfOC30=;
        b=YJPiX4Ge01qi2cDTShLqn/kh8bn3kNpTe5wc6z/fyvCC9EDLk8Rmj0/aHpYr/8VEnV
         YgRfBvDscL6BZ77SuTmaBS/tzT4b3aYb/dPDxvP1bIOoqHvbAwBa7c/JN/2A7YFYN1xl
         wDdCTjGzHguRdQQvj6H5wwLErsVRa8E1qKtUw+g8/hmPUWofSJdFNSfZrSVVo3OiQuHG
         8GO31cKYHdcndYcuBoGB1dfAgfV52zThePZTYGmm5TPq1Ikq/t3J0NPSQ7DxMHrtyzpN
         /z9qoQ+GcscNZOsihnHhrxHfIFF9Y5j74lHiAx7Ng2p2+Yb/gCNsfgdJQb0+vf4wfy7w
         Z61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=b7n7f6CO+MVHSnzRHpdk3x7t2oPCQj5a+pENYzfOC30=;
        b=mFxbYzRGl8mA5g7fGB3Fh+pheXFS2Qy1gCkYQe1b6LUb/s1xUi8aYd5DvZxFJG0EVA
         FyX0vgd3R42iR7Kh+UZ64l4WS7IXECieSLAIYxtQB7ZrQw5MQs1r1lejlTCNfEsykmwJ
         bfWMc9mfMHfACFgu6x64GSwapD8Jdodw10L3c1sVrteqksEixEYAMwFCUgp3v4dmrn/b
         GP1HlOcsnNazS+vd0uGRh9GNEdjktrGcWfjTCs0UEYnsRTSi7lxnJZk59WwTgF5twhBx
         rRta+0osYHQxXwpDqyrKU5UO7LmT/AyatRQ0BinPR0o0CBv1EvAfDx6dKqdYtMQlE/Ca
         SN5Q==
X-Gm-Message-State: APjAAAUfGeZW3or9UlqJe0sb6PXBLD2425NWslr/S/Ji/NSOkHQlpq6c
        Wn2sfySEHmDtqO/0WP+Z/g3Akg==
X-Google-Smtp-Source: APXvYqzdkeUzjHA8klmXiM9MmZ8IBJ7Myn8KLjVg80cTCkgU0kSt6TFpBU5rwYA56+DKgb5tSJo/vw==
X-Received: by 2002:a62:be12:: with SMTP id l18mr24082217pff.226.1578980342200;
        Mon, 13 Jan 2020 21:39:02 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y5sm5803030pfn.185.2020.01.13.21.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 21:39:01 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:38:26 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200114053825.GC28530@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org>
 <20200109083254.GA7280@willie-the-truck>
 <20200110160549.GA25437@willie-the-truck>
 <CA+CK2bAy-vfoz3kgUjZB74Hrobgu-a8H4pv6RbA_tbq++NWz5g@mail.gmail.com>
 <20200113112105.GB2337@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113112105.GB2337@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will, Pavel,

On Mon, Jan 13, 2020 at 11:21:06AM +0000, Will Deacon wrote:
> On Fri, Jan 10, 2020 at 11:19:16AM -0500, Pavel Tatashin wrote:
> > On Fri, Jan 10, 2020 at 11:05 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Jan 09, 2020 at 08:32:54AM +0000, Will Deacon wrote:
> > > > On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> > > > > On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > > > > > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > > > > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > > > > > index 12a561a54128..d24b527e8c00 100644
> > > > > > > --- a/arch/arm64/include/asm/kexec.h
> > > > > > > +++ b/arch/arm64/include/asm/kexec.h
> > > > > > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > > > > > >  struct kimage_arch {
> > > > > > >         void *dtb;
> > > > > > >         unsigned long dtb_mem;
> > > > > > > +       /* Core ELF header buffer */
> > > > > > > +       void *elf_headers;
> > > > > > > +       unsigned long elf_headers_mem;
> > > > > > > +       unsigned long elf_headers_sz;
> > > > > > >  };
> > > > > >
> > > > > > This conflicts with the cleanup work from Pavel. Please can you check my
> > > > > > resolution? [1]
> > > > >
> > > > > I don't know why we need to change a type of dtb_mem,
> > > > > otherwise it looks good.
> > > > >
> > > > > (I also assume that you notice that kimage_arch is of no use for kexec.)
> > > >
> > > > Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
> > > > to drop Pavel's patch altogether in light of your changes, we can do that
> > > > instead.
> > > >
> > > > Thoughts?
> > >
> > > Well, I've reverted the cleanup patch so please shout if you'd prefer
> > > something else.
> > 
> > As I understand, the only concern was the type change for dtb_mem.
> > This was one of the review comments for my patch
> > https://lore.kernel.org/lkml/20191204155938.2279686-21-pasha.tatashin@soleen.com/
> > 
> > (I believe it was from Marc Zyngier), I add a number of new fields,
> > and they all should be phys_addr_t, this is why I change dtb_mem to
> > phys_addr_t to be consistent.
> 
> Sure, but I've only queued the first part of your series and that cleanup
> patch doesn't make a lot of sense when applied against Akashi's work. I'm
> happy to take stuff on top if you both agree to it, but having half of the
> struct use unsigned long and the other half use phys_addr_t is messy.

Logically, whether dtb_mem is a "unsigned long" or phys_addr_t doesn't
matter unless the kernel is compiled under LLP64.
As far as the existing kexec code, either generic or arm64-specific,
is concerned, however, "unsigned long is widely used as a physical address
(For example, see kexec_buf definition) over the code.

(Oops, reboot_code_buffer_phys is a phys_addr_t :)

So as long as my kexec_file (and associated kdump) patch comes first
before Pavel's, I'd like to keep using "unsigned long".
Then, you can change "unsigned long" to phys_addr_t in your patch
for whatever reason it is.

Please note that, if you want to do that, it would be better to modify
not only kimage_arch but also all the occurrences of "unsigned long"
to phys_addr_t for maintaining the integrity.

In addition, in my kexec_file kdump code, I still believe that
"#ifdef CONFIG_KEXEC_FILE" should stay before the definition of
kimage_arch as kimage_arch is of no use for normal kexec code.

Again,
"#ifdef" statement may be moved forward once additional fields be
added later by Pavel's patch, say, "[PATCH v8 15/25] arm64: kexec:
move relocation function setup" for any reason.

I believe that this way gives us a logical and consistent view of
history of changes.
Make sense?

Thanks,
-Takahiro Akashi


> Will
