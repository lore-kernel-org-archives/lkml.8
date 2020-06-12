Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F206C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F8D207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nXMB+gtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:48:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:48:07 -0400
Received: from zn.tnic (p200300ec2f0af40048a70bbbe71adfd0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:48a7:bbb:e71a:dfd0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E42381EC0347;
        Fri, 12 Jun 2020 19:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591984086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZKZxsM5a5G9fsFkncYcChjTgy88lxnyyigEFrVGgfRE=;
        b=nXMB+gtGmD/bUpS8O23Yll0N6ahvef0MhsPpx35tMt0gZ82RAvFjdS648eOd7ChpdZMdgf
        SGgAPxcldR5k3G4lzYAkVVlCz+KUBpDskRQisUS1H8PWq8ZKeER9hLdgsQlpQ5pPzZuLli
        q/f7NNKUDnyrOAlXrvfDJ7o3SF+Bi1M=
Date:   Fri, 12 Jun 2020 19:48:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612174801.GE22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:20:03AM -0700, Linus Torvalds wrote:
> Since you already added the filtering, this looks fairly sane.
> 
> IOW, what MSR's do we expect people to maybe write to normally? You
> added MSR_IA32_ENERGY_PERF_BIAS as an allowed MST, maybe there are
> others?

Right, this MSR is being written by cpupower in tools/. My search was
confined within the kernel source only so there very likely are others.

If we want to add others, though, I think the criteria would be, if
writing to a MSR is safe - and this is where it becomes fuzzy but to use
the above example: if all it does is give hints to the hw but the hw can
ignore those hints and there's no other effect on the hw, then those
writes are fairly safe.

I'm pretty sure we'll massage that definition of "safe" over time.

> So I'm not against this, but I suspect the whitelist should be thought
> through more,

Yap.

> and then maybe the "allow_writes" parameter should be
> yes/no/default/<msr-list>, where "default" is that list of
> known-normal MSR's.

So I know of another out-of-tree tool which has a whole whitelist
management of MSRs: https://github.com/LLNL/msr-safe

Question is, what use cases we want to support. My thinking is to start
small and then keep extending it based on use cases we want to support.

> And I suspect it's a lot longer list than your single one. IIRC,
> people were working around CPU bugs or features by doing MSR writes at
> startup.
> 
> So the first phase might be to introduce this, but have the default
> for non-recognized MSR's be "log", not "deny".

Ok. How are we going to "learn" about those non-recognized MSRs? Ask
people to send us a note to lkml so that we can fix the list once they
see the logged message?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
