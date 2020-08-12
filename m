Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B64C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D9204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597248025;
	bh=eG3MLrqj5YnC1fRgBH0kWL1AM/Z3lmWKoxz+o7N3ns0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=knANl8RmJm4Q6p8IBafq9gY46oOeZQQ4fQo5RKp/tn7m/xwvgYYQ1jjbJ9xveRwEG
	 98+VkCwweTUsUJJxVTANJqUGkgnE5uNz7yhqlcf4XIXu4GQBW93zupnWPQ6Djvr0zC
	 IiqdOHFiHaKV0sjnflnrr4dwEKhdBPduYQ43BcoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHLQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgHLQAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:00:23 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3109F2080C;
        Wed, 12 Aug 2020 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597248022;
        bh=eG3MLrqj5YnC1fRgBH0kWL1AM/Z3lmWKoxz+o7N3ns0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAPCEis8WSrev5o7mL0hm7bQSFJW5YRnSpe+8GB6P/VAcc7ZczEDVn2s6ZmOCBGFF
         ZSejeeVDqTBdUHiqNkbBKbFKfjd2v4RwSz+Do4dq+29MXsadCEZRNcCoYQomtUfGaS
         v5dXK6poViUDOS5EL9rSlXqBeIjPeBT7Vhc8Qcrs=
Date:   Wed, 12 Aug 2020 18:00:17 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Will Deacon <will@kernel.org>, peterz@infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd@arm.com
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812160017.GA30302@linux-8ccs>
References: <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
 <20200812125645.GA8675@willie-the-truck>
 <20200812141557.GQ14398@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200812141557.GQ14398@arm.com>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Szabolcs Nagy [12/08/20 15:15 +0100]:
>The 08/12/2020 13:56, Will Deacon wrote:
>> On Wed, Aug 12, 2020 at 12:40:05PM +0200, peterz@infradead.org wrote:
>> > On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
>> > > The module .lds has BYTE(0) in the section contents to prevent the
>> > > linker from pruning them entirely. The (NOLOAD) is there to ensure
>> > > that this byte does not end up in the .ko, which is more a matter of
>> > > principle than anything else, so we can happily drop that if it helps.
>> > >
>> > > However, this should only affect the PROGBITS vs NOBITS designation,
>> > > and so I am not sure whether it makes a difference.
>> > >
>> > > Depending on where the w^x check occurs, we might simply override the
>> > > permissions of these sections, and strip the writable permission if it
>> > > is set in the PLT handling init code, which manipulates the metadata
>> > > of all these 3 sections before the module space is vmalloc'ed.
>> >
>> > What's curious is that this seems the result of some recent binutils
>> > change. Every build with binutils-2.34 (or older) does not seem to
>> > generate these as WAX, but has the much more sensible WA.
>> >
>> > I suppose we can change the kernel check and 'allow' W^X for 0 sized
>> > sections, but I think we should still figure out why binutils-2.35 is
>> > now generating WAX sections all of a sudden, it might come bite us
>> > elsewhere.
>>
>> Agreed, I think it's important to figure out what's going on here before we
>> try to bodge around it.
>>
>> Adding Szabolcs, in case he has any ideas.
>>
>> To save him reading the whole thread, here's a summary:
>>
>> AArch64 kernel modules built with binutils 2.35 end up with a couple of
>> ELF sections marked as SHF_WRITE | SHF_ALLOC | SHF_EXECINSTR:
>>
>> [ 5] .plt PROGBITS 0000000000000388 01d000 000008 00 WAX  0   0  1
>> [ 6] .init.plt NOBITS 0000000000000390 01d008 000008 00  WA  0   0  1
>> [ 7] .text.ftrace_trampoline PROGBITS 0000000000000398 01d008 000008 00 WAX  0   0  1
>>
>> This results in the module being rejected by our loader, because we don't
>> permit writable, executable mappings.
>>
>> Our linker script for these entries uses NOLOAD, so it's odd to see PROGBITS
>> appearing in the readelf output above (and older binutils emits NOBITS
>> sections). Anyway, here's the linker script:
>>
>> SECTIONS {
>> 	.plt (NOLOAD) : { BYTE(0) }
>> 	.init.plt (NOLOAD) : { BYTE(0) }
>> 	.text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
>> }
>>
>> It appears that the name of the section influences the behaviour, as
>> Jessica observed [1] that sections named .text.* end up with PROGBITS,
>> whereas random naming such as ".test" ends up with NOBITS, as before.
>>
>> We've looked at the changelog between binutils 2.34 and 2.35, but nothing
>> stands out. Any clues? Is this intentional binutils behaviour?
>
>for me it bisects to
>
>https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=8c803a2dd7d3d742a3d0071914f557ef465afe71
>
>i will have to investigate further what's going on.

Thanks for the hint. I'm almost certain it's due to this excerpt from
the changelog: "we now init sh_type and sh_flags for all known ABI sections
in _bfd_elf_new_section_hook."

Indeed, .plt and .text.* are listed as special sections in bfd/elf.c.
The former requires an exact match and the latter only has to match
the prefix ".text." Since the code considers ".plt" and
".text.ftrace_trampoline" special sections, their sh_type and sh_flags
are now set by default. Now I guess the question is whether this can
be overriden by a linker script..

