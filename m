Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D67C20706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TblBEYYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgDYWRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:17:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgDYWRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:17:41 -0400
Received: from zn.tnic (p200300EC2F2A110011AF566E608DBC7E.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:1100:11af:566e:608d:bc7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 882CE1EC0CFA;
        Sun, 26 Apr 2020 00:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587853059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dL/4+F/i9p4Rl9Mx/xjx1nvt6QzxFIox9qHe7WXmyFs=;
        b=TblBEYYVBE117oRluNpJNENnYeOMCXqC/PfzHUdL+2vSRmqMvQy+meocoqlRkiQ6dm3Iwc
        L2W0F0ifdIT+uqXVrfbz3xnhSFDCv99NuSUY4gzMe4QZkhhdVsZeF9dp1iEu+D0o330Nwx
        iTAQdlLBKNKi+8JkcWTj55M/pDBeSUs=
Date:   Sun, 26 Apr 2020 00:17:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>, jgross@suse.com,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Michael Matz <matz@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200425221728.GE24294@zn.tnic>
References: <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic>
 <20200425150440.GA470719@rani.riverdale.lan>
 <20200425173140.GB24294@zn.tnic>
 <20200425183701.GE17645@gate.crashing.org>
 <20200425185313.GD24294@zn.tnic>
 <20200425191549.GF17645@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200425191549.GF17645@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 02:15:49PM -0500, Segher Boessenkool wrote:
> My point is that you should explain at *every use* of this why you cannot
> have tail calls *there*.  This is very unusual, after all.
> 
> There are *very* few places where you want to prevent tail calls, that's
> why there is no attribute for it.

Well, there is only one reason *why* so far - to prevent the stack
canary cookie from being checked before returning from the function
which set it. That could be explained once over the macro definition so
that it can be looked up.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
