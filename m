Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4BC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C3A24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FAs1em3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBSMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:09:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42532 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:09:45 -0500
Received: from zn.tnic (p200300EC2F095500D4116BB2785F22F7.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:d411:6bb2:785f:22f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9EDC1EC026F;
        Wed, 19 Feb 2020 13:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582114183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tuqPEu/tbXFvguWL1KtLykJwGQRo1OKr9KYZRZEmfcI=;
        b=FAs1em3yPn+Jl66driUC8qgDm3SC9ltDWfBGeQuO7e2BxK6yOWuggYw7CoB0pGtut6lYHn
        N0OU4q3YSRQuQdGSYFXRYwh3AeoaZksJv42D8wAvuEcQsVHN8bjVxAaUSHy/o4xxGY8mvO
        58oJaR8x7BWBu5wTYTAepJjNBuaCZa0=
Date:   Wed, 19 Feb 2020 13:09:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200219120938.GB30966@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200205162921.GA318609@rani.riverdale.lan>
 <20200218180353.GA930230@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218180353.GA930230@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 01:03:54PM -0500, Arvind Sankar wrote:
> On Wed, Feb 05, 2020 at 11:29:21AM -0500, Arvind Sankar wrote:
> > On Thu, Jan 09, 2020 at 10:02:17AM -0500, Arvind Sankar wrote:
> > > Commit 5b11f1cee579 ("x86, boot: straighten out ranges to copy/zero in
> > > compressed/head*.S") introduced a separate .pgtable section, splitting
> > > it out from the rest of .bss. This section was added without the
> > > writeable flag, marking it as read-only. This results in the linker
> > > putting the .rela.dyn section (containing bogus dynamic relocations from
> > > head_64.o) after the .bss and .pgtable sections.
> > > 
> > > When we use objcopy to convert compressed/vmlinux into a binary for the
> > > bzImage, the .bss and .pgtable sections get materialized as ~176KiB of
> > > zero bytes in the binary in order to place .rela.dyn at the correct
> > > location.
> > > 
> > > Fix this by marking .pgtable as writeable. This moves the .rela.dyn
> > > section earlier so that .bss and .pgtable are the last allocated
> > > sections and so don't appear in bzImage.
> > > 
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > ---
> > >  arch/x86/boot/compressed/head_64.S | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > > index 58a512e33d8d..6eb30f8a3ce7 100644
> > > --- a/arch/x86/boot/compressed/head_64.S
> > > +++ b/arch/x86/boot/compressed/head_64.S
> > > @@ -709,7 +709,7 @@ SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
> > >  /*
> > >   * Space for page tables (not in .bss so not zeroed)
> > >   */
> > > -	.section ".pgtable","a",@nobits
> > > +	.section ".pgtable","aw",@nobits
> > >  	.balign 4096
> > >  SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
> > >  
> > > -- 
> > > 2.24.1
> > > 
> > 
> > Gentle reminder.
> > 
> > https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu
> 
> Ping.

You keep pinging. Why? Is it a showstopper or what is the urgency here?

This is shaving off some 100 - 200 KiB from the final bzImage, AFAICT. Or
is there something more broken this is fixing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
