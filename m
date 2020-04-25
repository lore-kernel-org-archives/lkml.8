Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D0C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C468D20728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BTmQGxPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgDYRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:31:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgDYRbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:31:50 -0400
Received: from zn.tnic (p200300EC2F2A1100992835E22F06EF88.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:1100:9928:35e2:2f06:ef88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E661D1EC0CD6;
        Sat, 25 Apr 2020 19:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587835909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uFkXHVwwFH85jEcy4ns2EHqg9WJsW4QYuQw8r9bQI2U=;
        b=BTmQGxPNkg4Aex6qccxM+7l3usJmduwct1PjS327BGPnactFewmsBn0SUUBJN/bLHJm8uS
        bH1n7RXre+Ch0s1AD3P0KBwk5St68VwI+8uFYYn10XCufU/CWkI+iRdM03E3fujigj8wt4
        mpPVdtWb+IP77M7zyMU6HTk4NzaAazQ=
Date:   Sat, 25 Apr 2020 19:31:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>, boris.ostrovsky@oracle.com,
        jgross@suse.com, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425173140.GB24294@zn.tnic>
References: <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
 <20200425150440.GA470719@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425150440.GA470719@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 11:04:40AM -0400, Arvind Sankar wrote:
> I'd put the clause about stack protector being disabled and the
> tail-call one together, to make clear that you still need the never
> return and always inline bits.

Done.

> Also, this function is implemented by multiple arch's and they all
> have similar comments -- might be better to consolidate the comment in
> the generic (dummy) one in include/linux/stackprotector.h laying out
> the restrictions that arch implementations should follow?

I'm not sure gcc-10 does the same thing on other arches - I'd let gcc
guys chime in here and other arch maintainers to decide what to do.

> There's also the one in init/main.c which is used by multiple
> architectures. On x86 at least, the call to arch_call_rest_init at the
> end of start_kernel does not get tail-call optimized by gcc-10, but I
> don't see anything that actually prevents that from happening. We should
> add the asm("") there as well I think, unless the compiler guys see
> something about this function that will always prevent the optimization?

Hmm, that's what I was afraid of - having to sprinkle this around. Yah, let's
wait for compiler guys to have a look here and then maybe I'll convert that
thing to a macro called

	compiler_prevent_tail_call_opt()

or so, so that it can be sprinkled around. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
