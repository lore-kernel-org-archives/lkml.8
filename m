Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5462074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HgpR5cOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHXPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgHXPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:21:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=daY05datfojWUu99SX/bBDi3Ezv4xzpLBr6KIMHZNck=; b=HgpR5cOrdo3yFsoNbsRR31WNMB
        YAldGUUp+wOtjLBtWL9j8LDB+uhuVN/Jfa4Ls06gySftqpoKl1VvVJVWk7+/QDfxCrDTSCOTaAtp6
        E05yggVOZsGWGKEnmS673AVcV1mT6EDZdpZ/QYAfnezLkSP02eVOySTkfGEiudf0GeuuYQOLx+7Bo
        IBzOwFWXPyRXRgSpfXgdXC29MZWHEzj2OEhlD2Z8GQoAhjj4k3I5A7he8etGSvWIMdzwRZ1KSelRx
        XPo3u8uOxse8Jbs/L/x2ZG0KVs7t2sX+ryMJC6mvlojg0/iRCFYlPzz4hBK2Tcr3Qsse/KPgvWwou
        1oUYOHNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEHy-0004Wx-0A; Mon, 24 Aug 2020 15:21:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A3D6304D58;
        Mon, 24 Aug 2020 17:21:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40DE72B078EAF; Mon, 24 Aug 2020 17:21:35 +0200 (CEST)
Date:   Mon, 24 Aug 2020 17:21:35 +0200
From:   peterz@infradead.org
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     <x86@kernel.org>, Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH] x86/entry: Fix AC assertion
Message-ID: <20200824152135.GV1362448@hirez.programming.kicks-ass.net>
References: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
 <d2b0c6a5-19d8-f868-e092-e5c197ab0d0e@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b0c6a5-19d8-f868-e092-e5c197ab0d0e@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:22:06PM +0100, Andrew Cooper wrote:
> On 24/08/2020 11:14, peterz@infradead.org wrote:
> > The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
> > improve user entry sanity checks") unconditionally triggers on my IVB
> > machine because it does not support SMAP.
> >
> > For !SMAP hardware we patch out CLAC/STAC instructions and thus if
> > userspace sets AC, we'll still have it set after entry.
> 
> Technically, you don't patch in, rather than patch out.

True.

> > Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/include/asm/entry-common.h |   11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > --- a/arch/x86/include/asm/entry-common.h
> > +++ b/arch/x86/include/asm/entry-common.h
> > @@ -18,8 +18,15 @@ static __always_inline void arch_check_u
> >  		 * state, not the interrupt state as imagined by Xen.
> >  		 */
> >  		unsigned long flags = native_save_fl();
> > -		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> > -				      X86_EFLAGS_NT));
> > +		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
> > +
> > +		/*
> > +		 * For !SMAP hardware we patch out CLAC on entry.
> > +		 */
> > +		if (boot_cpu_has(X86_FEATURE_SMAP))
> > +			mask |= X86_EFLAGS_AC;
> 
> The Xen PV ABI clears AC on entry for 64bit guests, because Linux is
> actually running in Ring 3, and therefore susceptible to #AC's which
> wouldn't occur natively.

So do you then want it to be something like:

	if (boot_cpu_has(X86_FEATURE_SMAP) ||
	    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))

? Or are you fine with the proposed?
