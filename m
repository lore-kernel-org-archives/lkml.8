Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D5C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6052082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5QyaoAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgDVLkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDVLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:40:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3DC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FMnNnD/g5k61t/UJVaLjWLk7lqOWCoUUvUZPwgeC4zI=; b=b5QyaoAhKw9dLQtOhIkFBippwO
        ii9AFrlgzCqp3ycOgyREkrZdoZhL+40vlAgzyNwsd8lC2nuitaPrw5xF8icyyx/CR5AuVAHPlCPin
        JABZZykr0nnT1/U1J+mFhWj0wE/pepgsfB0AxLv0tlcMSoKT1oe34v111Q5G//IZjlGMA685Kujzr
        of6ciJX2NC4TQ8udJogzxzqw5Bh0dNb26Ky/+xSDnaLWhsmLCFS4HubOtmRjyAsM5SbDt0mG/zd2w
        9jDZhknxlTk7QODtO8M5F4usKWLsQ3QUu1/Kh6IJDX/C+QYk2NDB/c7wKFw+zfCpE915DqOzoQDvz
        C3rBOJcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDjd-00075p-DO; Wed, 22 Apr 2020 11:40:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03655300739;
        Wed, 22 Apr 2020 13:40:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4EA2203AA838; Wed, 22 Apr 2020 13:40:07 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:40:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422114007.GC20730@hirez.programming.kicks-ass.net>
References: <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic>
 <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422102309.GA26846@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:23:09PM +0200, Borislav Petkov wrote:
> Ok,
> 
> let's try the simple and clean fix first. Nick, would that work on LLVM
> too?
> 
> And I hope this will remain working and the compiler won't jump over an
> inline asm and go nuts.
> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3b9bf8c7e29d..06d2e16bedbb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -266,6 +266,13 @@ static void notrace start_secondary(void *unused)
>  
>  	wmb();
>  	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
> +
> +	/*
> +	 * Prevent tail call to cpu_startup_entry() because the stack protector
> +	 * guard has been changed in the middle of this function and must not be
> +	 * checked before tail calling another function.
> +	 */
> +        asm ("");
>  }

You haz a whitespace issue there.

Also, can we get this in writing, signed in blood, from the various
compiler teams ;-)
