Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A8EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07117206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yW6Vofu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbgDCRI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:08:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgDCRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hDLEXGgzViXf1DCMcUvy65LKYBSnQEyHhsdc8RLosOM=; b=yW6Vofu5kRfWmF438nd/cZzufr
        xy6DkKg78VB3MynYBQr5D35pzeoH6K0APvY3Sb7cmS5iJ7M8uTo0XNxwozEB5bKaNY0ROw7E3S/E5
        9G696kzpf9TeGkf/LRpO6epo/Gh5s3ZIUiQw7FgW2cv0p+S0f5Ue8DgLzVzKqVBDMIO0oHXIF9T8u
        N+7QgFTvdY0bIQh8eOyA2dPCDbBVFaAOmm8ctGzCUIhpdZ7WyWQatHJAYhxqbun9jzlEkxh5YQkdw
        ht0/Lam0bNfY+aPgMAWWB5GFflqXPtWkwOIzipGajGdL3ZR8Ur2p9rYuJpw90zBYh9FDpzuiVvhBU
        3wFXBUKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPoK-0003kI-BL; Fri, 03 Apr 2020 17:08:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B611B30477A;
        Fri,  3 Apr 2020 19:08:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A78D22B124EC1; Fri,  3 Apr 2020 19:08:50 +0200 (CEST)
Date:   Fri, 3 Apr 2020 19:08:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200403170850.GA20730@hirez.programming.kicks-ass.net>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403165631.hrxxm3pnzqa4vxln@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:56:31AM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> > 
> > We're very close to enforcing W^X memory, refuse to load modules that
> > violate this principle per construction.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/module.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2044,9 +2044,28 @@ static void module_enable_x(const struct
> >  	frob_text(&mod->core_layout, set_memory_x);
> >  	frob_text(&mod->init_layout, set_memory_x);
> >  }
> > +
> > +static int module_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> > +			       char *secstrings, struct module *mod)
> 
> A verb would be nice: "module_enforce_rwx_sections"?
> 
> Shouldn't this be under STRICT_MODULE_RWX instead of
> ARCH_HAS_STRICT_MODULE_RWX?
> 
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < hdr->e_shnum; i++) {
> > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> > +			return -ENOEXEC;
> 
> I think you only want the error when both are set?
> 
> 		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))
> 

Duh. yes. Let me respin.
