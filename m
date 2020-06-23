Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50DB2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fdjvk7im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbgFWSrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:47:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733138AbgFWSrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:47:31 -0400
Received: from zn.tnic (p200300ec2f0d4700041724098f895483.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:417:2409:8f89:5483])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88D0B1EC01A8;
        Tue, 23 Jun 2020 20:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592938049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QkFRMYVTfMNN0H/vb9GoDAVhbF4wly1Sso5gzvU6uoI=;
        b=fdjvk7imesCKqa46i3s4XLCfIZt5mYbocnoDXDr7XR9iMKrsgDhA8bd/5m21WL8RWyXEd5
        x1Phrs2lxWcWyQR5uNeRMKwYT9zDpBj98hQpM7jbhiSbM0+mP8aNPgkEYccQQBtA+JJQvq
        eiNFbWeRECB7RzR1MZZKY1xYWWPUr08=
Date:   Tue, 23 Jun 2020 20:47:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200623184726.GI32590@zn.tnic>
References: <20200622190149.GL32200@zn.tnic>
 <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic>
 <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:22:53AM -0700, Andy Lutomirski wrote:
> See that same atrocious bug report.  It's the insane interaction
> between -mno-sse2 and -mpreferred-stack-boundary.  So you need to
> cc-option them both?  Or just stick with a compiler version check, I
> guess.

Yes, it was the interaction. This below seems to work. Note the "-msse"
in the first argument of cc-option which causes the compiler to error
out with

/dev/null:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12

Adding Nick for the clang side.

@Nick: I'm simply going to add -msse2 with cc-option.

Anyway, lemme test this thing a bit more.

Thx.

---

# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
# get appended last to CFLAGS and thus override those previous compiler options.
#
FPU_CFLAGS := -mhard-float -msse
FPU_CFLAGS += $(call cc-option,-msse2,)
ifdef CONFIG_CC_IS_GCC
# Stack alignment mismatch, proceed with caution.
# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
# (8B stack alignment).
# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
endif

obj-$(CONFIG_TEST_FPU) += test_fpu.o
CFLAGS_test_fpu.o += $(FPU_CFLAGS)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
