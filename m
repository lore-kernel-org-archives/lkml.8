Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51185C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AA22253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="emoyzERP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAUJvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:51:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAUJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vUHBLbLhjyX4/SbY4q0MCiU+xt76lqs8Hy6X88cWrUs=; b=emoyzERPXmgfEdcmBsCTVlGwD
        yvTrzWRe7fSWou2IcshDCfiyaJ2mXyGHuLjM554HGqo0JeViQFP0tWGGoEev2SKUkHkXo+yXWWwAE
        uCr97qhCHyvdN2vstC64M5i8Xef03Rw9Y3jos4wd5yx4RvgePsG97Fr3e9wutfD9uoUvQXTWh3Jat
        8OMHFPOtUQmCmCYkQOtJ4OtdEn26AyH8RKzCPAdLoa6YAjd2E+v2GFDo1O+QNyFIMt2coOlTgqUO0
        ijOzebkZ1WGX0N3BybW+6aNzJnL1RkR0yZEXpbGE8rL/YSCN8PVn2df18xtlRguwl/InjFhdnRrVV
        4eOG/WeDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itqBR-0003zD-3h; Tue, 21 Jan 2020 09:50:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0967B300B8D;
        Tue, 21 Jan 2020 10:49:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 191E820983E34; Tue, 21 Jan 2020 10:50:51 +0100 (CET)
Date:   Tue, 21 Jan 2020 10:50:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: fix a data race in cpa_inc_4k_install
Message-ID: <20200121095051.GG14914@hirez.programming.kicks-ass.net>
References: <20200121041200.2260-1-cai@lca.pw>
 <20200121072744.GA7808@zn.tnic>
 <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPFRCRg9wnFwyJpZVg8Urb9HAdZ++e3xbh1LXPjgAs4kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:19:18AM +0100, Marco Elver wrote:
> On Tue, 21 Jan 2020 at 08:27, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Jan 20, 2020 at 11:12:00PM -0500, Qian Cai wrote:
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index 20823392f4f2..31e4a73ae70e 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
> > >
> > >  static inline void cpa_inc_4k_install(void)
> > >  {
> > > -     cpa_4k_install++;
> > > +     WRITE_ONCE(cpa_4k_install, READ_ONCE(cpa_4k_install) + 1);
> 
> As I said in my email that you also copied to the message, this is
> just a stats counter. For the general case, I think we reached
> consensus that such accesses should intentionally remain data races:
>   https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/T/#u
> 
> Either you can use the data_race() macro, making this
> 'data_race(cpa_4k_install++)' -- this effectively documents the
> intentional data race --

Yes, that sounds useful.

But this patch, as presented, is just plain wrong. It doesn't fix
anything.
