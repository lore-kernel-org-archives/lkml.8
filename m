Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DC2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD4B206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8Ku15Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgDMPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbgDMPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:34:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5828C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:34:57 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so3499019plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghs4l4nI57la7hO/6EnhN56epQlSYo2HQcGuqn9At3E=;
        b=o8Ku15VylZmW9RmUdw3LqYItOHWR5uR+BhCzrC4IOozU56RYAeexGHQrmUeAjY0cUB
         oqwdCBwanWaSy1xBLCk53ZHMr0WWy/+2ket481Z6niFhhrc1+dWnLe5NB0+Nn1LJ6biM
         pe8iK7TQ1s0nB7ksBzQ942wAKyrtwrXKLYFgYaIvevq/AR/mS2kBX0vDrjFGK53Lf7p7
         c7GfBtx0lCLZqVjnntovV3+Cf4/aC7VzdGF04fTeHCWdsbTI9HSsEVToZFo+vKm/F9Gx
         IpT1KUmj0ARujnTGKsn2qx/2/EzWBZVSaTzIWz6v5uatfnpEq/LCceAV5vOou0azpcxt
         5mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ghs4l4nI57la7hO/6EnhN56epQlSYo2HQcGuqn9At3E=;
        b=KDBnudZrv108q/ffeM8bYv1rCqBGRo1WJpJw2VaaO3xkMdkAZmWtPgIduA7fStlIeD
         DXVlaXXYUtDRuqg70UcLlopHo4tDbBPi1D+msk9TrBNEDKRJiEaOeXQh9tXp8gt0yD/o
         eFQNSI8SMI2B7kMCxCjzMl7xlzwSKCGu0/BYnynxj/YGov4ULCSzvVntkmCuupQssqu4
         fFM9EUyUHn2BqmmMC08sP2CSLDMb1BZKlVthFGnL5bkUjJ2T7dX1yLUVJd5+a5x5nUua
         Likd4/UNF5KmlHDsoakKdYL3z1o4grFMPkbCrnF0tNYsv9CPlg9/4PM12U0bj2atVCWQ
         pnsQ==
X-Gm-Message-State: AGi0PuaaxnEafjBHywEg9i90eJHfsiU5I7P+ipYaCy5NoGM8W6qB1GRO
        zzqm2yBb0bSGVRHwfoQBcitoiA==
X-Google-Smtp-Source: APiQypI6Dvk7gIIjLIxzrGkUSM2NUDSzxSvhD2oYSFiXn15uxg9GYJwz0R4Bsuz7njjnFBRvvCEVGw==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr17038570plr.76.1586792096747;
        Mon, 13 Apr 2020 08:34:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id q12sm8205213pgi.86.2020.04.13.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:34:56 -0700 (PDT)
Date:   Mon, 13 Apr 2020 08:34:53 -0700
From:   Fangrui Song <maskray@google.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: Truncate link address into 32bit for 32bit
 kernel
Message-ID: <20200413153453.zi4jvu3c4ul23e23@google.com>
References: <20200413062651.3992652-1-jiaxun.yang@flygoat.com>
 <alpine.LFD.2.21.2004130736410.851719@eddie.linux-mips.org>
 <20200413153205.4ee52239@flygoat-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200413153205.4ee52239@flygoat-x1e>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13, Jiaxun Yang wrote:
>On Mon, 13 Apr 2020 07:59:29 +0100 (BST)
>"Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>
>> On Mon, 13 Apr 2020, Jiaxun Yang wrote:
>>
>> > LLD failed to link vmlinux with 64bit load address for 32bit ELF
>> > while bfd will strip 64bit address into 32bit silently.
>> > To fix LLD build, we should truncate load address provided by
>> > platform into 32bit for 32bit kernel.
>>
>> Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>
>>
>> > diff --git a/arch/mips/kernel/vmlinux.lds.S
>> > b/arch/mips/kernel/vmlinux.lds.S index a5f00ec73ea6..5226cd8e4bee
>> > 100644 --- a/arch/mips/kernel/vmlinux.lds.S
>> > +++ b/arch/mips/kernel/vmlinux.lds.S
>> > @@ -55,7 +55,7 @@ SECTIONS
>> >  	/* . = 0xa800000000300000; */
>> >  	. = 0xffffffff80300000;
>> >  #endif
>> > -	. = VMLINUX_LOAD_ADDRESS;
>> > +	. = VMLINUX_LINK_ADDRESS;
>>
>>  The CONFIG_BOOT_ELF64 cruft right above it looks interesting to me,
>> never have ever been used.  We have had the current arrangement since:
>
>It confused me either.
>It's only used by SGI so probably it's time to rename it as
>BOOT_SEG_ELF64.
>
>Wish someone could clarify what is it.
>
>Thanks.

Agreed that -Ttext in

arch/mips/boot/compressed/Makefile
100:      cmd_zld = $(LD) $(KBUILD_LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T $< $(vmlinuzobjs-y) -o $@

and a few other places are brittle. They need to be replaced with Output Section Address:
(https://sourceware.org/binutils/docs/ld/Output-Section-Address.html
https://github.com/llvm/llvm-project/blob/master/lld/docs/ELF/linker_script.rst#output-section-address)

-Ttext changes the address of .text . This can lead to the change of the
address of the text segment (RX), but this is not guaranteed (many
sections can be placed before .text and they are not affected).
See https://reviews.llvm.org/D70468 "[ELF] Error if -Ttext-segment is specified"


Reviewed-by: Fangrui Song <maskray@google.com>

>>
>> commit 923ec3d20eef9e36456868b590873ce39f17fe71
>> Author: Ralf Baechle <ralf@linux-mips.org>
>> Date:   Wed Nov 6 22:16:38 2002 +0000
>>
>>     Define load address in linker script instead of relying on the
>>     deprecated and notoriously unreliable option -Ttext.
>>
>> and previously `-Ttext' was used with this script anyway, though not
>> very long, as the script was entirely ignored until:
>>
>> commit 7a782968041ffc4c2d89816238e2f8ea5cceddba
>> Author: Ralf Baechle <ralf@linux-mips.org>
>> Date:   Thu Oct 31 23:54:21 2002 +0000
>>
>>     Merge with Linux 2.5.36.
>>
>>   Maciej
>
>--
>Jiaxun Yang
