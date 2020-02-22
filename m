Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F973C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D68208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jsob8vt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBVGz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:55:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgBVGz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:55:28 -0500
Received: from zn.tnic (p200300EC2F1C5400284D3F3FD3B9EA68.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:5400:284d:3f3f:d3b9:ea68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B54651EC05FD;
        Sat, 22 Feb 2020 07:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582354526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6uugywjmabDqx6fKLmBOr1M10mUKtzr6ahR9wgIuTjE=;
        b=Jsob8vt+NOx4VTXZP/fgxAGhnZYcbKUSNS6X7XxPTHs9e8fgC+dku9W4+vCPphDri2z/5h
        6ybAyqoVOVU0NaWyKjjFvEpLpundLmCpb5z4uF9ljj4+j1EDo503/T9pYXzxtvXvTbEU4g
        HHJtw03EAvK7/rtQzB5d000rqXN7ZBA=
Date:   Sat, 22 Feb 2020 07:55:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222065521.GA11284@zn.tnic>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:08:45PM -0700, Nathan Chancellor wrote:
> On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
> > Discarding the sections that are unused in the compressed kernel saves
> > about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  arch/x86/boot/compressed/vmlinux.lds.S | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 508cfa6828c5..12a20603d92e 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -73,4 +73,9 @@ SECTIONS
> >  #endif
> >  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> >  	_end = .;
> > +
> > +	/* Discard all remaining sections */
> > +	/DISCARD/ : {
> > +		*(*)
> > +	}
> >  }
> > -- 
> > 2.24.1
> > 
> 
> This patch breaks linking with ld.lld:
> 
> $ make -j$(nproc) -s CC=clang LD=ld.lld O=out.x86_64 distclean defconfig bzImage
> ld.lld: error: discarding .shstrtab section is not allowed

Well, why is it not allowed? And why isn't the GNU linker complaining?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
