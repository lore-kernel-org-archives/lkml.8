Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URG_BIZ,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AF7206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mcna9TlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCXQsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:48:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCXQsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:48:20 -0400
Received: from zn.tnic (p200300EC2F0BC8009042E8B149D34204.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c800:9042:e8b1:49d3:4204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F3C11EC0C48;
        Tue, 24 Mar 2020 17:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585068498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eY6J1c0HfoD0Hr3Wz74OVnqF5PpXSMRKl4LpwZpxxzM=;
        b=Mcna9TlB4NFpozYUvsTpcbSOWCtO7xSlvVPPZwxhoi/96NHhqTjctSLIARgzq4oZ9dZ9T7
        o1s52yig0P08bl6amoheZSFELE5fDNoK/uzqWMIVxS3IIYbjv9gHJLPUyv1FJ8FNgtAGuT
        snsPDxZXUP+dJXAn3z8KZVv3Cb9E9bA=
Date:   Tue, 24 Mar 2020 17:48:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200324164812.GG22931@zn.tnic>
References: <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
 <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic>
 <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:37:13AM -0700, Linus Torvalds wrote:
> I think it's ok. It's not going to cause any _subtle_ failures, it's
> going to cause very clear "oh, now it doesn't build" errors.
> 
> No?
> 
> And binutils 2.23 is what, 7+ years old by now and apparently had
> known failure cases too.
> 
> But if there are silent and subtle failures, that might be a reason to
> be careful. Are there?

Well, not that I know of and that's why I'm being overly cautious. Maybe
too cautious but a lot of hectic testing of last minute fixes in the
past have taught me to take my time.

And since it doesn't really matter when the patch goes in - there's
always the next merge window - I would prefer to take our time and have
it simmer in -next for max period.

So yeah, 2.23 has been tested for a long time now and it is very likely
that nothing would happen and if you think it's ok, then sure. Then if
you happen to see urgent pull requests with build or some other fixes,
at least you'll be prepared. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
