Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC98DC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993FE20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdNs98hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBVHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:02:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33102 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:02:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so4026376oig.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wp8VhtMOgSbmaayvgbvSF3iGsyK4mtaSOsHdOnwnL5c=;
        b=cdNs98hUFMWKQv+dkcrjJVcyz6Jrh7Fa4M+rs/3ujLEjcYxm4Pt6YxKRRZKOTh99uR
         ul+OKf7FzlidVyjBcfPtCBEk7c1MERz+tNqiGCsn3xLZIFFXYHZ9665is2WpOzxzHPuE
         cdyPHW5wzDvaMDcARa7L/FQOign/yosAi5L47iVU44S/DUKVorHSOG+mA7w7y1ZkZ6md
         pzvfE4NPDYrczj4/gOoV/ew1CQcRGIzIRvXv9gq+Vz8BzWgTnEf2VB7SRr/6eiNhAzAK
         JFEPzWLeeD3IkwJGthrM7hTsb8MnnbL6KgSvhnOHpgFQ5p5iPHptC/kzYb47aV4fDN/4
         KkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wp8VhtMOgSbmaayvgbvSF3iGsyK4mtaSOsHdOnwnL5c=;
        b=MZzlovc4JFC/8V3tQfbdH14rbBOypZS20S/9NW6Q+Z8ZAotI3rpjRO1vqm0mAOf7vg
         wuPext/L7b0b2vENf6q2EZAqHcmdeKTuwgZb75B5xy48vb7Bw7RF1ByopShZGzJoxgcc
         cjW3GW/4r/PGUhQheyMTTUwZnLm5hcAwJoGmJWsVWAqd6v04HPfvlyeaXSg7Ki4wPu5i
         S4Jz//OPTyNmHr4eXkav03BaStaJPN3sgdTwiLMD3Baz7wEYER0HK2cOg+8e+si1fShD
         JN7urb8gYjKg+qrMnoLmutQJvY+zboDQnpYB+V57Qol8qabMGu9q3Zl5VOAMMHcMxPoh
         XBFQ==
X-Gm-Message-State: APjAAAWVfIfStetq9TDEIKND8YSuhFf+Dpc6AH93G0UoKshbF4rSqhrr
        V+AdVRcWLHeChFLLNrvGl2U=
X-Google-Smtp-Source: APXvYqxd5/ZPn8+fJoBTNiMOsDOmGcU3aMNKnPgF8TIfiuhAaqqEL7DsLrVPHu0agUzE4LtkBuEAeA==
X-Received: by 2002:a05:6808:3ae:: with SMTP id n14mr5256926oie.63.1582354940912;
        Fri, 21 Feb 2020 23:02:20 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j13sm1743835oij.56.2020.02.21.23.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 23:02:20 -0800 (PST)
Date:   Sat, 22 Feb 2020 00:02:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222065521.GA11284@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 07:55:21AM +0100, Borislav Petkov wrote:
> On Fri, Feb 21, 2020 at 10:08:45PM -0700, Nathan Chancellor wrote:
> > On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
> > > Discarding the sections that are unused in the compressed kernel saves
> > > about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
> > > 
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > ---
> > >  arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 508cfa6828c5..12a20603d92e 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -73,4 +73,9 @@ SECTIONS
> > >  #endif
> > >  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> > >  	_end = .;
> > > +
> > > +	/* Discard all remaining sections */
> > > +	/DISCARD/ : {
> > > +		*(*)
> > > +	}
> > >  }
> > > -- 
> > > 2.24.1
> > > 
> > 
> > This patch breaks linking with ld.lld:
> > 
> > $ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
> > ld.lld: error: discarding .shstrtab section is not allowed
> 
> Well, why is it not allowed? And why isn't the GNU linker complaining?

No idea, unfortunately I am not a linker expert and the patch that
changes this in lld does not really explain why it adds this
restriction:

https://github.com/llvm/llvm-project/commit/1e799942b37d04f30b73f6a9e792d551dadafeea

CC'ing Fangrui as I don't know George's email and he is usually
responsive to ld.lld issues/questions.

Cheers,
Nathan
