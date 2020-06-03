Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6AD20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DRiF0BIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFCSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:52:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:52:29 -0400
Received: from zn.tnic (p200300ec2f0b2300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36D0A1EC0136;
        Wed,  3 Jun 2020 20:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591210348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LvxZ35mGfJQ6YYXayA/jTe4NV7Rrhjm8YI3+1Qt5HL4=;
        b=DRiF0BIZXQSCuVHtt46FtPXxYHH4+sgx+/nDrLdh3hKZSBaYTzNqB0iKMhBgl3ZMpHP3yE
        C6qf37ndrqFev6s2lSdID0UWQno6Sw9MCwVnzmR4E0V9Mfr5c7lF9VO0kBVYBMx673Fkcp
        QBBZq6XNNRsBwvegkrZow5plJlcVdm8=
Date:   Wed, 3 Jun 2020 20:52:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200603185220.GA20613@zn.tnic>
References: <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514110537.GC4280@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:05:38PM +0100, Will Deacon wrote:
> Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
> and the behaviour for __always_inline is:
> 
>   * An __always_inline function inlined into a __no_sanitize function is
>     not instrumented
>   * An __always_inline function inlined into an instrumented function is
>     instrumented
>   * You can't mark a function as both __always_inline __no_sanitize, because
>     __no_sanitize functions are never inlined
> 
> GCC, on the other hand, may still inline __no_sanitize functions and then
> subsequently instrument them.

Yeah, about that: I've been looking for a way to trigger this so that
I can show preprocessed source to gcc people. So do you guys have a
.config or somesuch I can try?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
