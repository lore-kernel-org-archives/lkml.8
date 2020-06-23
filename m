Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB290C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFEE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QtmHx3lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgFWTNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:13:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387410AbgFWTNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:13:40 -0400
Received: from zn.tnic (p200300ec2f0d4700041724098f895483.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:417:2409:8f89:5483])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 513CC1EC0390;
        Tue, 23 Jun 2020 21:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592939619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/I5adJWVlizMAa4fiImCIi1s26c5ZZwkiuFsdR3mo+4=;
        b=QtmHx3lkSwCJidAclfNs5jLHgXjkUt15HmMPt7F3u/BzvYFk5tUoyeXiBQ1W25tUaGEb95
        y/XFoLOUWkYQ3v3S9uXIfs0iwCDSyCWO22MAdB3d+gOgFjwSMcuXzIlFGr14qit6/0h0ts
        b9A/hM76dazcGYo4CM8tXvHziRCyLXo=
Date:   Tue, 23 Jun 2020 21:13:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200623191336.GK32590@zn.tnic>
References: <20200622190149.GL32200@zn.tnic>
 <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic>
 <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
 <20200623184726.GI32590@zn.tnic>
 <CAKwvOdnt+8RR=1JPjDNaVY8T1K7wmqFjSGM7XNUUGRb=t1hiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnt+8RR=1JPjDNaVY8T1K7wmqFjSGM7XNUUGRb=t1hiWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:07:13PM -0700, Nick Desaulniers wrote:
> You already have a conditional below for CC_IS_GCC; just add an else
> and unconditionally add -msse2.  You *should* use -msse2 for GCC 7.1+
> IMO.

Why if one can write it more compact with cc-option?

FPU_CFLAGS += $(call cc-option,-msse2,)

> Note that Clang has -mstack-alignment=8 whereas GCC has
> -mpreferred-stack-boundary=3.  (Clang is a value in bytes, GCC is 2^X
> bytes)

Sure, the stack boundary setting is GCC only.

> I recommend a version check for GCC < 7.1, or simply disabling the
> self test if the version of GCC used is older than 7.1.

See Andy's suggestion upthread.

And I agree too that using cc-option is better than simply tying it to a
compiler version. Who knows what compiler has what backported. In such
cases a version number means nothing.

> ^ looks familiar ;)

It has been pasted around the kernel, I came to realize today. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
