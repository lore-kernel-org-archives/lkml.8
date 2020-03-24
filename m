Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4009C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C28E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f6dU36lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgCXQ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:28:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCXQ2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:28:51 -0400
Received: from zn.tnic (p200300EC2F0BC8009042E8B149D34204.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c800:9042:e8b1:49d3:4204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B0561EC0C50;
        Tue, 24 Mar 2020 17:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585067330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J0usAIcUQuByh9u13ia7j74xd5hkNgsjvYQH1lBcdMY=;
        b=f6dU36lr8wTOzCrnIeW3gHymiN7J4DkFoOqDrq6WbjeoHd5o/tuqFRn1yOlLWeyRcj/9u2
        V+3RGQfO+7+lV/jip1I9Ckq0J3cNXJNyIwc+AZ2+40kQXOJ8nxj+RwONVL55Vk1vX850vQ
        zolEWr6NZMuVIh6SoqonPuxGw8xl9eE=
Date:   Tue, 24 Mar 2020 17:28:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        torvalds@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200324162843.GE22931@zn.tnic>
References: <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
 <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:22:53AM -0600, Jason A. Donenfeld wrote:
> Both Kees and I were pretty positive yesterday about getting this done
> in 5.7, now.

Are you or Kees going to deal with any fallout from upping the binutils
version, rushed in in the last week before the merge window?

Because I sure as hell am not. *Especially* if there's no big difference
when it goes in.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
