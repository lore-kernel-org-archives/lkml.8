Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9ADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5905B207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597232496;
	bh=5YX5niBl40sLTixVJb38NAzplBnuVRS5SOdlAs8pcfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NBrmbDeFGIMxp9gQgA211T79a4cOAM4f3f0BUn9JqSOmPqWZ09C0a7mFOPIKCRKZl
	 HwDgHj0UDhIqmha/V7haZZLgO+MHTLVHpSrZsw1rlSvZo+gn66lV79jQQkpp4wRORR
	 SDbS8DWCqhxDPL1njpVve66ij6xVwHYbN9wCToD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHLLld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:41:33 -0400
Received: from linux-8ccs.fritz.box (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4A1207DA;
        Wed, 12 Aug 2020 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597232492;
        bh=5YX5niBl40sLTixVJb38NAzplBnuVRS5SOdlAs8pcfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtxgXJIfWi+bmYCxC5hLfm19wRO4rQy1kYT6WryNKHeYjweVUM4yRQ/dQU8FNJjt6
         Z6PkBVWxpvO97j8zqRUw0pOpLdmw0mYonr6UBnJ0XKK3E2YlkigDx73/grpmp6f/JH
         mHkuIqjaRXvQ92iedpPaTVdRNUOOTqTFBhSxUpAM=
Date:   Wed, 12 Aug 2020 13:41:27 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     peterz@infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, binutils@sourceware.org
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200812114127.GA10824@linux-8ccs.fritz.box>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan>
 <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs>
 <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net>
 <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
 <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
 <20200812104005.GN2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200812104005.GN2674@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 5.8.0-rc6-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ peterz@infradead.org [12/08/20 12:40 +0200]:
>On Wed, Aug 12, 2020 at 10:56:56AM +0200, Ard Biesheuvel wrote:
>> The module .lds has BYTE(0) in the section contents to prevent the
>> linker from pruning them entirely. The (NOLOAD) is there to ensure
>> that this byte does not end up in the .ko, which is more a matter of
>> principle than anything else, so we can happily drop that if it helps.
>>
>> However, this should only affect the PROGBITS vs NOBITS designation,
>> and so I am not sure whether it makes a difference.
>>
>> Depending on where the w^x check occurs, we might simply override the
>> permissions of these sections, and strip the writable permission if it
>> is set in the PLT handling init code, which manipulates the metadata
>> of all these 3 sections before the module space is vmalloc'ed.
>
>What's curious is that this seems the result of some recent binutils
>change. Every build with binutils-2.34 (or older) does not seem to
>generate these as WAX, but has the much more sensible WA.
>
>I suppose we can change the kernel check and 'allow' W^X for 0 sized
>sections, but I think we should still figure out why binutils-2.35 is
>now generating WAX sections all of a sudden, it might come bite us
>elsewhere.

I have just tested with binutils-2.35 and am observing the same
behavior. Both .plt and .text.ftrace_trampoline end up with
SHT_PROGBITS and are marked 'WAX'. With binutils-2.34 they keep the
NOBITS designation.

I had thought NOLOAD implies NOBITS, but that doesn't seem to be the
case anymore? I tinkered with module.lds a bit and noticed that the
name of the section seems to matters. So this:

  SECTIONS {
      .plt (NOLOAD) : { BYTE(0) }
      .init.plt (NOLOAD) : { BYTE(0) }
      .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
+     .test (NOLOAD) : { BYTE(0) }
+     .text.test (NOLOAD) : { BYTE(0) }
+     .plt.test (NOLOAD) : { BYTE(0) }
  }

Yielded the following:

  [22] .plt              PROGBITS        0000000000000340 000e40 000001 00 WAX  0   0  1
  [23] .init.plt         NOBITS          0000000000000341 000e41 000001 00  WA  0   0  1
  [24] .text.ftrace_trampoline PROGBITS        0000000000000342 000e41 000001 00 WAX  0   0  1
  [25] .test             NOBITS          0000000000000343 000e42 000001 00  WA  0   0  1
  [26] .text.test        PROGBITS        0000000000000344 000e42 000001 00 WAX  0   0  1
  [27] .plt.test         NOBITS          0000000000000345 000e43 000001 00  WA  0   0  1

So ".plt" and any section starting with ".text" were automatically
designated as SHT_PROGBITS and given the executable flag. It appears
the NOLOAD directive has been ignored or overridden in the case of
these sections. I am not sure if this is a bug in binutils or if this
behavior is intentional.

I tried to grok the changelog between 2.34 and 2.35 but could not find
anything glaringly obvious that would cause this change. CC'ing the
binutils mailing list, hopefully that's the right place to ask.

Jessica
