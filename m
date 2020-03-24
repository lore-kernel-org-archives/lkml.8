Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5241C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B4920719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 23:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlgbV5xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCXXty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:49:54 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34027 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgCXXtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:52 -0400
Received: by mail-qv1-f67.google.com with SMTP id o18so96658qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXqXTT1DtLqmzmjkBBjicSNrZ08h/rCoq4NTECASZpg=;
        b=MlgbV5xu2HcOCHYISh0rVhd+WtayGujV639SF0pMVYOPBWa9mmR3nMtF48SELl2ysP
         7G21E1OdkwGZSy8BHKsRbU0l/TTeqe66xOfovpT5JymE1R6no9KvAqXN5IfRxgwxRn97
         E6dZgY8mKO4RwVKCG5Lat9F3akPYWk2QWKHUMe0tUMM5jUjxLFD3wDZ4nK8Vzj7It+Dv
         7loXXUmJGjeZaWnONh6H9nkOXpGfPgDZlcaVnB2eDGupFlcIhHIbMo+FxrC7Qh7DfVQ+
         k9MY6g9tzLyPCH21xYXbIhpTC2HD2Ne50xls6DqInS9w30jAM/in/lVeIsXKZq6LR2qG
         ETsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXqXTT1DtLqmzmjkBBjicSNrZ08h/rCoq4NTECASZpg=;
        b=fBVul6PQ2zgEXxvpqoSXvlW/zEu4CmDcCMZD/XgvjXdeF3KAnKcfhwN2HqMAAWnj+q
         9+0SKoepJPIeFG3ohK0TjFR/VckE7EOdmNRVZa2l355XfygI97XOzTSjBy5yTER5zS2Z
         sUOh32i31C8mIrHzilNiLhNaOaCUyrWVXChQy/ze1U1z5ByPqx4ZQxUHQUQ4Z7/6PI1m
         1wr7QtZb94F92yrVG6xZxEDLbLPDuO0cku+KtlUm9eHiOaL2fe9QbiliujbrbiSxXs9u
         aJDFF5X1d3JvzZobFGI5kh0uMtSvvOgTeV9wx+3KP5M42mBTmRnxmCfbFzEY9lbjB63G
         Weyg==
X-Gm-Message-State: ANhLgQ2x3J8XmIBk9wP2mqftms4VBrQrcx1cEditjXG36W/wiChh/Xm0
        kXBRydex/Vp+WsXJCT85tXA=
X-Google-Smtp-Source: ADFU+vuIJBh70Otd4fILE2e+dqN3YxFo09aCCJYbQPKmRh8Kj1efsqpVmSl0JkK7bkpITDRiLc1OOg==
X-Received: by 2002:ad4:5427:: with SMTP id g7mr694573qvt.23.1585093790911;
        Tue, 24 Mar 2020 16:49:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d25sm13238573qtj.86.2020.03.24.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 16:49:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 24 Mar 2020 19:49:48 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200324234947.GA3373941@rani.riverdale.lan>
References: <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
 <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic>
 <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
 <20200324164812.GG22931@zn.tnic>
 <20200324214204.GB3220053@rani.riverdale.lan>
 <CAHk-=wiFfi8J+vMccQ5VYZMecxyAeA9Cpt-Kui-GHZBbB29OhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFfi8J+vMccQ5VYZMecxyAeA9Cpt-Kui-GHZBbB29OhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:14:38PM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 2:42 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > This is just a documentation patch right?
> 
> That patch, yes.
> 
> However, there's a second patch that knows that if we have binutils >=
> 2.22, then we don't need to check for AVX2 or ADX support, because we
> know it's there.
> 
>            Linus

Ok. But if you're otherwise ok taking those AVX2/ADX patches for 5.7, as
noted in my other email [1], the x86 build has been broken with
binutils <= 2.22 since v5.3.

[1] https://lore.kernel.org/lkml/20200324220147.GA3253486@rani.riverdale.lan/
