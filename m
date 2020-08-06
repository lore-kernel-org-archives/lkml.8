Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55AA2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RM9tinec";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RoTG50Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgHFWLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:11:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHFWLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:11:41 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596751898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LP3eXKkhQT+uVGZyZBVGAcBptR0qjU15+7WUxkvMxZA=;
        b=RM9tinecELmqpzagbxC0vGibPLqnkHV/ZEh+MKJKvauCxAKyRyV1YDIvKt+fedFEDi0GJz
        xXhp8Jy3ZJWFX/7d/d2J2zD8ZVt5kKdiqAidRUg344fhdbezl1hIaf1VpqHscaQeLkIcIG
        cfKwpx5htIAWw1rys1VX4CTzKdw+AxPd2+bYKGy5rJ5uoHRzB1BjtfaAfQFCtmDnufq1mG
        y+wo98LoYN+G+vZMteQveUK2JgsgJ8U46eHFXqf0+ltSCnBgGI80UytKInziheumLUh07B
        lXtq72zay5DOBz7ad2kBqkNvDqElofqdn/lho2gQRsveIlsUOSFQDIGiIVK6Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596751898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LP3eXKkhQT+uVGZyZBVGAcBptR0qjU15+7WUxkvMxZA=;
        b=RoTG50WgGzRBvHPy9R9e44YbK02gl79OeRSbNP76IjIKiz5ID7hqiI1cZPNZMcw+UFvg78
        tANbj0UxPLiyNhAQ==
To:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
In-Reply-To: <20200527135329.1172644-1-arnd@arndb.de>
References: <20200527135329.1172644-1-arnd@arndb.de>
Date:   Fri, 07 Aug 2020 00:11:38 +0200
Message-ID: <878serh1b9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> When using the clang integrated assembler, we get a reference
> to __force_order that should normally get ignored in a few
> rare cases:
>
> ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
>
> Add a 'static' definition so any file in which this happens can
> have a local copy.

That's a horrible hack.

And the only reason why it does not trigger -Wunused-variable warnings
all over the place is because it's "referenced" in unused inline
functions and then optimized out along with the unused inlines.

>   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
>   * due to an undefined symbol. Define it to make these ancient GCCs
>   work.

Bah, we really should have moved straight to GCC5 instead of upping it
just to 4.9

> + *
> + * Clang sometimes fails to kill the reference to the dummy variable, so
> + * provide an actual copy.

Can that compiler be fixed instead?

Aside of that is there a reason to make this 'static' thing wrapped in
#ifdeffery? A quick check with GCC8.3 just works. But maybe 4.9 gets
unhappy. Can't say due to: -ENOANCIENTCOMPILER :)

Thanks,

        tglx
