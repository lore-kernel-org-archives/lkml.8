Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F1C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF422072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTqZK5/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgAKBsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:48:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgAKBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:48:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so1977396pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:cc:from:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=xEZ6TEzAcDzhzB7iwisnARr6r+Hw8zTAaf/XQmWu/70=;
        b=LTqZK5/dcOSC7BlHX1eRCVTfFJj4gXD+eEYavKPVdBTdMsmKAUXKpKrODMWQC/pefJ
         wANAEZX7/h7TUa2q9MxK2BGYrn3t+8GZw4cF0aCC+9vz9XvDd7P7wsL8bOqIqNT6dZT1
         RoDuL/x2J4VnomuP6EfnUQeDK9drlC6gsD8VESfGjOcwVWkNZNKhVXpf/gxMNvFfPbPy
         wtvDI95jbz1wXjmly5NFhqa3bCuqAFkaek6Kj6jWgH/XETIdO7gtWXfC1aKbeF+vpmju
         DNX8BgAYKT8vPnBlbb6MjfhY325zT5jiUuf3ZycN2m41LZBqQy757Vl9D8d6+qC0g1XS
         FBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=xEZ6TEzAcDzhzB7iwisnARr6r+Hw8zTAaf/XQmWu/70=;
        b=Wq1bv1+1A/hEE20o805TJ38yYvuUNnNVAGBRTE8qBVjg1dnNeI+y2gkr3A08ZpH6Od
         t5MD0BNUV2R5KJyPOtQCq8dBcMSV8IOjoHMrssf9NtsO01k9xC6OC8B1dz02dXZfQ59Y
         H9GTD5bVTV78B7D7fnQXXBP7rmp9Km3U+PMTsGu7fd61q6BUxjaCW5yKKXgtb/VZj3Rf
         BO6h+IzSAGkFI3HUqIkWpAICt3JZC3OAvoF+4I3SXVRBZZzQR9Yn3QcukaBBJ3rIAgsd
         cNl9d439E1+vV2ZHLk3Tj+FWFvn9RWbOkk67im/D4x/+K3mhvvHGLx3EW6IuYz7YPHww
         zMSw==
X-Gm-Message-State: APjAAAUOxtq6AuGzaGgPAF/x5BdIeWBoSUrkJVMZ2yERYdFrJupK17XA
        iugLpM4jfXg3o/YWIUSl0tLwzQ==
X-Google-Smtp-Source: APXvYqyz00jbWGgySO8fqGSl+7swYcbEUDhauDDXKaFWJcBtF2PpYFpiqVpiofq7GexquwmDCGKNiA==
X-Received: by 2002:a62:be09:: with SMTP id l9mr7386269pff.57.1578707310530;
        Fri, 10 Jan 2020 17:48:30 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id c68sm4542405pfc.156.2020.01.10.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:48:30 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:48:30 -0800 (PST)
X-Google-Original-Date: Fri, 10 Jan 2020 17:48:28 PST (-0800)
Subject:     Re: [PATCH v2] riscv: keep 32-bit kernel to 32-bit phys_addr_t
CC:     Olof Johansson <olof@lixom.net>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001101709090.2113@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001101709090.2113@viisi.sifive.com>
  <20200106232024.97137-1-olof@lixom.net> <20200106231611.10169-1-olof@lixom.net>
  <mhng-d39bd2da-7e27-484a-b8f8-a96edf1336c0@palmerdabbelt-glaptop>
Message-ID: <mhng-5513ef23-bcce-4e33-8f59-193d550e4156@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 17:14:46 PST (-0800), Paul Walmsley wrote:
> On Fri, 10 Jan 2020, Palmer Dabbelt wrote:
>
>> On Mon, 06 Jan 2020 15:20:24 PST (-0800), Olof Johansson wrote:
>> > While rv32 technically has 34-bit physical addresses, no current platforms
>> > use it and it's likely to shake out driver bugs.
>> >
>> > Let's keep 64-bit phys_addr_t off on 32-bit builds until one shows up,
>> > since other work will be needed to make such a system useful anyway.
>> >
>> > PHYS_ADDR_T_64BIT is def_bool 64BIT, so just remove the select.
>> >
>> > Signed-off-by: Olof Johansson <olof@lixom.net>
>> > ---
>> >
>> > v2: Just remove the select, since it's set by default if CONFIG_64BIT
>> >
>> >  arch/riscv/Kconfig | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index a31169b02ec06..569fc6deb94d6 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -12,8 +12,6 @@ config 32BIT
>> >
>> >  config RISCV
>> >  	def_bool y
>> > -	# even on 32-bit, physical (and DMA) addresses are > 32-bits
>> > -	select PHYS_ADDR_T_64BIT
>> >  	select OF
>> >  	select OF_EARLY_FLATTREE
>> >  	select OF_IRQ
>>
>> I gave 5.5-rc5 a quick test on a 32-bit QEMU with 8GiB of RAM and the system
>> wouldn't boot, so we've got at least some bugs floating around somewhere.
>> Given that this doesn't work I don't see any reason to keep it around as an
>> option, as if someone wants to make it work there's a lot more to do than make
>> things compile.
>>
>> I've put this on for-next.  If anyone cares about 34-bit physical addresses on
>> rv32 then now is the right time to speak up... ideally by fixing it :)
>
> You know, if, according to
>
> https://freenode.logbot.info/riscv/20200106
>
> the main reason for doing this is to avoid autobuilder warnings, I'd be
> tempted to suggest we leave it in there so people have some incentive to
> go fix the real bugs ;-)
>
> (that said, the patch is basically okay by me until at least QEMU is
> fixed or hardware appears)

I think it's unlikely to be a QEMU bug, as it starts printing messages from the
payload and then hangs.  By the point QEMU is executing instructions it doesn't
really care about pointers any more and is just doing whatever the instructions
say to do.  It's possible QEMU decided to alias memory and blow everything up,
but I feel like that would manifest after Linux prints some messages.  Writing
this I feel like I've debugged that before...

If I had to bet I'd put the bug in OpenSBI, but only because I don't see any
Linux messages.  Specifically, I'd bet that someone did something like

    for (size_t i = 0; i < get_memory_size_from_fdt(); i += PAGE_SIZE)
       memory_base[i + K], for small values of K

which would blow up for some configurations of 34-bit memory sizes and 32-bit
size_t, given how the compiler likes to optimize things.  That definately
happens early in the kernel boot, but IIRC we print a message after mapping a
fixed number of pages (though that code was changed recently so I don't
remember how it works now).

I'd actually tested this before Olof brought up the issue and just put it in
the "I guess just don't do that" pile, but when he mentioned it was breaking
builds I remember chasing around some early kernel boot issue last time I
accidentally turned on a lot of memory and figured it's probably best to just
bail on the whole thing anyway.  IIRC part of the feedback on the original
and while it'd be nice to have (which is probably why I ignored the feedback) I
feel like there's more important ways to spend our time -- like getting a
32-bit userspace.

That said, I'd be happy to make this selectable by menuconfig.  Presumably it's
not that much work to chase around the drivers that blow up and add something
like "depends 64BIT || PHYS_ADDR_T_32BIT" until randconfig builds stop failing,
but I feel like that's as far as this is likely to go in the forseeable future.

Either way, I guess this is a good reminder it's better to remain causal.  I
suppose I'll try to do so in the future :)
