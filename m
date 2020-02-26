Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D8C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0721927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI67dM+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgBZB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:56:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43533 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgBZB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:56:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so562324pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SoVH2C+rKg4FGK3xYkqD+KKbNwXIXz2f79nVDo9rwKQ=;
        b=VI67dM+segR/c3+bl2J96hci5cMAVql+i9EtsyQ9hn9Q7gXDPupD4DhJrcvmeMAM5c
         xR18tzMFrXQaWF/vd7wV/ciqI16SOm9SiTPdx7szgWljBDn32tKmYJioYle9q3Tx2T/k
         TeT8eqKsMydBz0V40bOG7DRjsSA45HfGnzFE8GMsmCBtCSeuAeO65piFBjm+kIINnIhE
         EzQrQUKCuUV0GmjcHH7lpX1mgOgPisqQ4OCr+rbmz2K0vp/nMEB+kWLJAU4r7AWeVvxU
         1BLE+x2eMOkBEPOLMZNsCJGk6rW/mG8PeLFkbyPionGp+8s8fb1UeIRuotY0Nw/R74O6
         GICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoVH2C+rKg4FGK3xYkqD+KKbNwXIXz2f79nVDo9rwKQ=;
        b=K02urwvLLxHPWbx9v3wA3XNC8Hi6ZQmRKrcHg8KWK7ynM7HgvU2QJvlpgTAo+C7kSP
         rUlqFL8NZKDHAV21N4iTPeDBdT566xHgqEln0+KmOkOXoddHTl9gG/g+/CxvFIlLsaGx
         hWlHbfmX62tXXDqvyKg+KQDk5H0vVzh7D4nZ3ij8IcR6+rgtc5Og8LmouLt5lEpi5lSS
         gpIO3fog8kl6W3t3YzsY0c622zAa0pn2+oRalB0w/FabY8c98JOGvo0bEUj93ehTa0iX
         VnTRtgZ/xovYEawJgqaWOpS234+Sn5+fELkVptlrgk59vBcCiyDVkkkzve6wtQ7+ec3n
         taHA==
X-Gm-Message-State: APjAAAUDA9PFGibihJHlASkirtkFn+Me+nrReVFASwOjgA4THsg6GWDM
        U7euaEwrly6yIGqau5rm9tpmOQ==
X-Google-Smtp-Source: APXvYqy5PwA6Yy/fU+UIx9A1fkCVws/3zWtGUio/noc5VbkNBk2DUZ50Bnvz/AwCz3zrllEwPlWSyA==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr1687636pfq.157.1582682169560;
        Tue, 25 Feb 2020 17:56:09 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id h13sm360541pjc.9.2020.02.25.17.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:56:08 -0800 (PST)
Date:   Tue, 25 Feb 2020 17:56:06 -0800
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: --orphan-handling=warn
Message-ID: <20200226015606.ij7wn7emuj4bfkvn@google.com>
References: <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
 <20200225182951.GA1179890@rani.riverdale.lan>
 <202002251140.4F28F0A4F@keescook>
 <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
 <202002251358.EDA50C11F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202002251358.EDA50C11F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kees is working on a series to just be explicit about what sections
> > are ordered where, and what's discarded, which should better handle
> > incompatibilities between linkers in regards to orphan section
> > placement and "what does `*` mean."  Kees, that series can't come soon
> 
> So, with my series[1] applied, ld.bfd builds clean. With ld.lld, I get a
> TON of warnings, such as:
> 
> (.bss.rel.ro) is being placed in '.bss.rel.ro'

.bss.rel.ro (SHT_NOBITS) is lld specific. GNU ld does not have it. It is
currently used for copy relocations of symbols in read-only PT_LOAD
segments. If a relro section's statically relocated data is all zeros,
we can move the section to .bss.rel.ro

> (.iplt) is being placed in '.iplt'
> (.plt) is being placed in '.plt'
> (.rela.altinstr_aux) is being placed in '.rela.altinstr_aux'
> (.rela.altinstr_replacement) is being placed in
> '.rela.altinstr_replacement'
> (.rela.altinstructions) is being placed in '.rela.altinstructions'
> (.rela.apicdrivers) is being placed in '.rela.apicdrivers'
> (.rela__bug_table) is being placed in '.rela__bug_table'
> (.rela.con_initcall.init) is being placed in '.rela.init.data'
> (.rela.cpuidle.text) is being placed in '.rela.text'
> (.rela.data..cacheline_aligned) is being placed in '.rela.data'
> (.rela.data) is being placed in '.rela.data'
> (.rela.data..percpu) is being placed in '.rela.data..percpu'
> (.rela.data..percpu..page_aligned) is being placed in '.rela.data..percpu'
> ...

I need to figure out the exact GNU ld rule for input SHT_REL[A] retained
by --emit-relocs.

   ld.bfd: warning: orphan section `.rela.meminit.text' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
   ld.bfd: warning: orphan section `.rela___ksymtab+__ctzsi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
   ld.bfd: warning: orphan section `.rela___ksymtab+__clzsi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
   ld.bfd: warning: orphan section `.rela___ksymtab+__clzdi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
   ld.bfd: warning: orphan section `.rela___ksymtab+__ctzdi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'

lld simply ignores such SHT_REL[A] when checking input section descriptions.
A .rela.foo relocating .foo will be named .rela.foobar if .foo is placed in .foobar

It makes sense for --orphan-handling= not to warn/error.
https://reviews.llvm.org/D75151

> But as you can see in the /DISCARD/, these (and all the others), should
> be getting caught:
> 
>         /DISCARD/ : {
>                 *(.eh_frame)
> +               *(.rela.*) *(.rela_*)
> +               *(.rel.*) *(.rel_*)
> +               *(.got) *(.got.*)
> +               *(.igot.*) *(.iplt)
>         }
> 
> I don't understand what's happening here. I haven't minimized this case
> nor opened an lld bug yet.

--orphan-handling was implemented per
https://bugs.llvm.org/show_bug.cgi?id=34946
It seems the reporter did not follow up after the feature was implemented.
Now we have the Linux kernel case...
Last December I encountered another case in my company.

It is pretty clear that this feature is useful and we should fix it :)

https://reviews.llvm.org/D75149

> enough. ;) (I think it's intended to help "fine grain" (per function)
> KASLR).  More comments in the other thread.

> Actually, it's rather opposed to the FGKASLR series, as for that, I need
> some kind of linker script directive like this:
> 
> 	/PASSTHRU/ : {
> 		*(.text.*)
> 	}
> 
> Where "PASSTHRU" would create a 1-to-1 input-section to output-section
> with the same name, flags, etc.

/PASSTHRU/ sections are still handled as orphan sections?
Do you restrict { } to input section descriptions, not output section
data (https://sourceware.org/binutils/docs/ld/Output-Section-Data.html#Output-Section-Data)?
or symbol assignments?

You can ask https://sourceware.org/ml/binutils/2020-02/ whether
they'd like to accept the feature request:)

(My personal feeling is that I want to see more use cases to add the new
feature...)

> ld.bfd's handling of orphan sections named .text.* is to put them each
> as a separate output section, after the existing .text output section.
> 
> ld.lld's handling of orphan sections named .text.* is to put them into
> the .text output section.

Confirmed. lld can adapt. I need to do some homework...

> For FGKASLR (as it is currently implemented[2]), the sections need to be
> individually named output sections (as bfd does it). *However*, with the
> "warn on orphans" patch, FGKASLR's intentional orphaning will backfire
> (I guess the warning could be turned off, but I'd like lld to handle
> FGKASLR at some point.)
> 
> Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> entry linker script ... made ld.lld take about 15 minutes to do the
> final link. :(

Placing N orphan sections requires O(N^2) time (in both GNU ld and lld) :(

> > Taken from the Zen of Python, but in regards to sections in linker
> > scripts, "explicit is better than implicit."
> 
> Totally agreed. I just hope there's a good solution for this PASSTHRU
> idea...
> 
> -Kees
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
> [2]
> https://github.com/kaccardi/linux/commit/127111e8c6170a130d8d12d73728e74acbe05e13

On 2020-02-25, Kees Cook wrote:
>On Tue, Feb 25, 2020 at 12:37:26PM -0800, Nick Desaulniers wrote:
>> On Tue, Feb 25, 2020 at 11:43 AM Kees Cook <keescook@chromium.org> wrote:
>> >
>> > On Tue, Feb 25, 2020 at 01:29:51PM -0500, Arvind Sankar wrote:
>> > > On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
>> > > > Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
>> > > > entry linker script ... made ld.lld take about 15 minutes to do the
>> > > > final link. :(
>> > >
>> > > Out of curiosity, how long does ld.bfd take on that linker script :)
>> >
>> > A single CPU at 100% for 15 minutes. :)
>>
>> I can see the implementers of linker script handling thinking "surely
>> no one would ever have >10k entries." Then we invented things like
>> -ffunction-sections, -fdata-sections, (per basic block equivalents:
>> https://reviews.llvm.org/D68049) and then finally FGKASLR. "640k ought
>> to be enough for anybody" and such.
>
>Heh, yeah. I had no expectation that it would work _well_; I just
>wanted to test if it _could_ work. And it did: FGKASLR up and running
>on Clang+LLD. I stopped there before attempting the next step:
>FGKASLR+LTO+CFI, which I assume would be hilariously slow linking.

Now I learned the term FGKASLR... I need to do some homework.
