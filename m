Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2817C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82DB20769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmTprzgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgDHP5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:57:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgDHP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I046T5NYEXXComMYfFLIbN9Cazs44K1u/PrUj66bzFg=; b=HmTprzgO5Copd6ZM1O4M8f7lqo
        f8qIXu5dpV028o2e5sdn8xVqUUhTBYMQR+GMGt+hJ1IJecOoARrlIKWLg415az9UIqcusPvyl8uz+
        miEvVeFzuoWIwXHmxbpQn9kXE0Zas5RB8foRfxDbRqXEE1JvZqQnSEP/BR14QJ8RGny6GZPORiuzW
        3zPAsgt0GKmqaDA5wfUroIwZzNwWqa5Oyt6/WJuuqfiC3vdwvl5PUdye6VavZzTWOkYtVAE4iIArN
        cvABGFvjeu//zLY3E1yYaVOEUFd/poCBrOiG2T2x6VW/3y6aif4Ofo8fqQH8SGVdD4lSSL/d/1spP
        ewOsulXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMD4r-00074a-PV; Wed, 08 Apr 2020 15:57:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD0BA300130;
        Wed,  8 Apr 2020 17:57:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE5DA2BB02700; Wed,  8 Apr 2020 17:57:19 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:57:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
Message-ID: <20200408155719.GQ20730@hirez.programming.kicks-ass.net>
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200408153249.GA26619@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408153249.GA26619@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:32:49PM +0200, Jessica Yu wrote:
> +++ Peter Zijlstra [03/04/20 19:13 +0200]:
> > 
> > We're very close to enforcing W^X memory, refuse to load modules that
> > violate this principle per construction.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > kernel/module.c |   25 +++++++++++++++++++++++++
> > 1 file changed, 25 insertions(+)
> > 
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2044,9 +2044,29 @@ static void module_enable_x(const struct
> > 	frob_text(&mod->core_layout, set_memory_x);
> > 	frob_text(&mod->init_layout, set_memory_x);
> > }
> > +
> > +static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> > +				       char *secstrings, struct module *mod)
> > +{
> > +	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
> > +	int i;
> > +
> > +	for (i = 0; i < hdr->e_shnum; i++) {
> > +		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx)
> > +			return -ENOEXEC;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Just to clarify, did we want to enforce this only when
> CONFIG_STRICT_MODULE_RWX=y?  Because here it's still in the
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX block.
> 
> Unfortunately, when we add module_enforce_rwx_sections() in the
> CONFIG_STRICT_MODULE_RWX block, we'll need two empty stubs, one for
> !CONFIG_ARCH_HAS_STRICT_MODULE_RWX and one for !CONFIG_STRICT_MODULE_RWX.
> 
> This is because the CONFIG_STRICT_MODULE_RWX block is currently nested
> within ARCH_HAS_STRICT_MODULE_RWX :/

Yeah, so the primary reason it's under that ARCH_HAS thing is indeed the
mess and the extra stub required (I'm a lazy sod at times).

I then rationalized this decision to myself that having it under
ARCH_HAS give a more consistent module loading behaviour.

But I really don't care too much, my most my .config's have
CONFIG_MODULE=n, and the ones that do not very much have the STRICT_RWX
set.

Put it where you think it's best.

Thanks!
