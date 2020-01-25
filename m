Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A52C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81FE20716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdBHZXNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgAYUMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:12:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgAYUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 15:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ey6ZYti6NmikTiCFbAyS0/OoBDRN48VTuk8yiWvC+M=; b=AdBHZXNGW9f1CstD316qvsE+S
        jQOafMmhFh9TgQBvwjTAtWSka2cq0zzLGESO6Oydi4g2eGB4J3lJuop6G2+lp0Vrmx4h1lpM6r1jg
        fCbX3OM0ntOygKPIPhJS87Fr250QTQYNX2y2yz36h730Xw6qe8syxT+EL4w++xWzSpJiwFz0gVGWs
        9Mve7AYSyxtoAlprwTrd/pBciXoDlSGielgotg9nZ+zraouLVciPvJSzfl8iX8pJEZR04B9o0xqbN
        XocwlgBOyktXbrVz3bf0oJkeKKOv7LTvAnJTwcN3uRhQlpKw0WRYkZQK2IWC0+xUPA2OvWkgd0mUh
        p5OvLh9uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivRnC-0004ZO-B4; Sat, 25 Jan 2020 20:12:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF466980E4C; Sat, 25 Jan 2020 21:12:21 +0100 (CET)
Date:   Sat, 25 Jan 2020 21:12:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125201221.GZ11457@worktop.programming.kicks-ass.net>
References: <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125104419.GA16136@zn.tnic>
 <20200125195513.GA15834@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125195513.GA15834@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 11:55:13AM -0800, Luck, Tony wrote:
> > > +static inline bool match_option(const char *arg, int arglen, const char *opt)
> > > +{
> > > +	int len = strlen(opt);
> > > +
> > > +	return len == arglen && !strncmp(arg, opt, len);
> > > +}
> > 
> > There's the same function in arch/x86/kernel/cpu/bugs.c. Why are you
> > duplicating it here?
> > 
> > Yeah, this whole chunk looks like it has been "influenced" by the sec
> > mitigations in bugs.c :-)
> 
> Blame PeterZ for that. For now I'd like to add the duplicate inline function
> and then clean up by putting it into some header file (and maybe hunting down
> other places where it could be used).

Yeah, I copy/paste cobbled that together. I figured it was easier to
'borrow' something that worked and adapt it than try and write
something new in a hurry.

> > > +	/*
> > > +	 * If this is anything other than the boot-cpu, you've done
> > > +	 * funny things and you get to keep whatever pieces.
> > > +	 */
> > > +	pr_warn("MSR fail -- disabled\n");
> > 
> > What's that for? Guests?
> 
> Also some PeterZ code. As the comment implies we really shouldn't be able
> to get here. This whole function should only be called on CPU models that
> support the MSR ... but PeterZ is defending against the situation that sometimes
> there are special SKUs with the same model number (since we may be here because
> of an x86_match_cpu() hit, rather than the architectural enumeration check).

My thinking was Virt, virt likes to mess up all msr expectations.

