Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF81AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C120897
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VkBFBYfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIIUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:03:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45998 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:03:30 -0400
Received: from zn.tnic (p200300ec2f0ae700897556713e13a596.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e700:8975:5671:3e13:a596])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDB851EC0284;
        Wed,  9 Sep 2020 22:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599681807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WuLhwOH4c/kFAZ1PFUixa6QF6rwcqteTpHh91pUKe9o=;
        b=VkBFBYfqjG3gUfDd3NyabLLhRDklJ/XuxTw02b36E2Q5vhn5BRv9nhZympLqcBjDB0D38w
        bQlPncpVer9vtiB4D8iVgfoCWjF2Stqa6DEQLiHfdERWHTqgkXKy0P5gRpbyH/CTxWuBfU
        4zg5sZUuoG9Vzd407Er5qWZEnm2EO6U=
Date:   Wed, 9 Sep 2020 22:03:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200909200321.GG12237@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:20:51AM -0700, Luck, Tony wrote:
> Do we think there will be other places where we want this
> MSR-or-die behaviour?

MSR-or-die - I like that. That belongs on a T-shirt. :-)

> If there are, then most of this belongs elsewhere from
> arch/x86/kernel/cpu/mce/core.c

Yeah, I can't think of any other users needing this ATM. But if they do,
lifting those and moving them somewhere else is trivial.

> The "_once" version seems a little pointless when the next statement
> in the function is "panic()".

True, removed.

> "warn" seems understated for an error that is going to crash the system.
> Just go for "pr_emerg()".

Done.

> There seems no consistency on using "rIP" or "RIP" ... but I think "RIP"
> is slightly ahead.

The "r" in rIP means that it can be RIP or EIP and that code builds on
32-bit too.

> nitpick: I don't thing Architectural needs to be capitalized.

Done.

> Ugh. Is this why you have warn_once() ... because panic might return?

People tend to put all kinds of things in panic() and I want to make
sure that even if it returns for whatever reason, at some point in
the future, we don't make any further progress here. Think of it as a
paranoid precation of sorts...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
