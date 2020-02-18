Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA77C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488CD206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qZRHe97W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRKp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:45:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRKp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:45:58 -0500
Received: from zn.tnic (p200300EC2F0C1F003890503FBB74C433.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:3890:503f:bb74:c433])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4F7E1EC0CBD;
        Tue, 18 Feb 2020 11:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582022757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MniJx5EUkDA02LoDvBaCsdxNfVPX/sQJ7VGNHV/WtG0=;
        b=qZRHe97WrVyaJUsoYTk9jNHsVIS+lMHo0c4S4aEGXMYU0Lfbk5eOv7oAMNU1u0DzkBlaZ1
        ndziXWV/hL7mddjGzgil+7Ld9J3zwkCy/60Xv2sqaN39uqk4nGPS66+AarpFnC+kNf9YjR
        fwuzZmkzw/YCNqZqLLcPHgV1VQ1Imww=
Date:   Tue, 18 Feb 2020 11:45:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86: Don't declare __force_order in kaslr_64.c
Message-ID: <20200218104552.GA14449@zn.tnic>
References: <20200124181811.4780-1-hjl.tools@gmail.com>
 <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
 <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
 <CAMe9rOrtj-Hrr6tmSrwg_V9bawXXB2WjsSedL=aCaaH-=ZSKsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMe9rOrtj-Hrr6tmSrwg_V9bawXXB2WjsSedL=aCaaH-=ZSKsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:44:30AM -0800, H.J. Lu wrote:
> This updated patch fixed a typo in Subject: "care" -> "declare".
>
> From c8c26194cf5a344cd53763eaaf16c3ab609736f4 Mon Sep 17 00:00:00 2001
> From: "H.J. Lu" <hjl.tools@gmail.com>
> Date: Thu, 16 Jan 2020 12:46:51 -0800
> Subject: [PATCH] x86: Don't declare __force_order in kaslr_64.c
> 
> GCC 10 changed the default to -fno-common, which leads to
> 
>   LD      arch/x86/boot/compressed/vmlinux
> ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
> make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1
> 
> Since __force_order is already provided in pgtable_64.c, there is no
> need to declare __force_order in kaslr_64.c.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

What is Yu-cheng's SOB supposed to mean here?

The only case where it would make sense is if he's sending this patch
but he isn't. So what's up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
