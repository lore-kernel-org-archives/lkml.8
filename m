Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE709C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F1B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KjQcFdqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgAMNnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:43:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMNnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:43:16 -0500
Received: from zn.tnic (p200300EC2F05D3007144E525CFA9AFEA.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:7144:e525:cfa9:afea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 056271EC0273;
        Mon, 13 Jan 2020 14:43:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578922994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m8/BsA7p571dMLjHMqqm9mlcA20gY/0wO94EJdWdxx0=;
        b=KjQcFdqeFpRAT4SVTi4d1mVgS2uZyxYAI7Wu2XOwncMfrVFqUzFVxArY3EOCFl9HPqb6ll
        RfAl9igokR6xwB41N582lnDSpZBX5aCf6osSx4/sWAnW719RPWBXnXSx7z/hiq7Y7EfAL1
        K2/LvEuhRjUlwLwJoEaBgDitPFo5tQQ=
Date:   Mon, 13 Jan 2020 14:43:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200113134306.GF13310@zn.tnic>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200111172047.GA2688392@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:20:48PM -0500, Arvind Sankar wrote:
> I'm not sure if that's the same issue. The root cause for the one I
> reported is described in more detail in [1], and the change that makes
> these symbols no longer absolute is commit d2667025dd30 in binutils-gdb
> (sourceware.org seems to be taking too long to respond from here so I
> don't have the web link).

My binutils guy says that the proper fix should be to make those two
symbols section-relative, i.e., move _etext at the end of the .text
section and so on.

Please check whether this fixes the build issue too because if it does,
it would be The RightThing(tm).

> I'm running gentoo, but building the kernel using binutils-2.21.1
> compiled from the GNU source tarball, and gcc-4.6.4 again compiled from
> source. (It's not something I normally need but I was investigating
> something else to see what exactly happens with older toolchains.)
> 
> I used the below to compile the kernel (I added in
> readelf/objdump/objcopy just now, and it does build until the relocs
> error). The config is x86-64 defconfig with CONFIG_RETPOLINE overridden
> to n (since gcc 4.6.4 doesn't support retpoline).
> 
> make O=~/kernel64 -j LD=~/old/bin/ld AS=~/old/bin/as READELF=~/old/bin/readelf \
> 	OBJDUMP=~/old/bin/objdump OBJCOPY=~/old/bin/objcopy GCC=~/old/bin/gcc

Make this all part of your commit message because it explains in detail
how exactly you've triggered it so that anyone else reading this can
reproduce her/himself.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
