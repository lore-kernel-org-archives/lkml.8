Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B43C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B8E24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hsabktVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAUWSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:18:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgAUWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:18:21 -0500
Received: from zn.tnic (p200300EC2F0B0400D0DA90B2E65C1373.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:d0da:90b2:e65c:1373])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FBC51EC01AD;
        Tue, 21 Jan 2020 23:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579645100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PjPHjZTCcO1Xfdc6VGvvRJ5SETWJDEcSmBfdzjuSv4M=;
        b=hsabktVCuuLbLIUesA80Vwr/7fElNFE6aXm4DfwSudNN68hllEhbXxNEEKQIqN9rbcFd08
        hgUkD/vXH/qi6amJO3LCX9KMIt11YrxB4pKTOL1dCu6kD0u+/XQ3m2Dqx48yPa7KArc35F
        2UBneNvBs2hF26ydOk/gvzQ/BUP+hg0=
Date:   Tue, 21 Jan 2020 23:18:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-ID: <20200121221814.GQ7808@zn.tnic>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic>
 <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
 <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
 <20200121154528.GK7808@zn.tnic>
 <E9162CDC-BBC5-4D69-87FB-C93AB8B3D581@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E9162CDC-BBC5-4D69-87FB-C93AB8B3D581@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:21:35PM -0500, Qian Cai wrote:
> Actually "__no_kcsan" does not work because I have

Why, because KCSAN conflicts with inlining? I'm looking at the comment
over __no_kasan_or_inline.

> CONFIG_OPTIMIZE_INLINING=y (GCC 8.3.1) here, so it has to be,
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20823392f4f2..fabbf8a33b7f 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -126,7 +126,7 @@ static inline void cpa_inc_2m_checked(void)
>         cpa_2m_checked++;
>  }
>  
> -static inline void cpa_inc_4k_install(void)
> +static inline void __no_kcsan_or_inline cpa_inc_4k_install(void)
>  {
>         cpa_4k_install++;
>  }
> 
> Are you fine with it or data_race() looks better?

This one looks marginally better because the annotation is still outside
of the function, so to speak.

Btw, looking at the other "inc" CPA statistics functions there, does it
mean that for KCSAN they all need to be annotated now too?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
