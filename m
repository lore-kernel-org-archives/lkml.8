Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9946220776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ugrb0QqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgEZQ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgEZQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:28:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF01C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=suOooOcNSKyFICMWbxMpUFg1suvhpJtkun3SmXbqCrg=; b=Ugrb0QqIocIMnls/zFRcMWGt8j
        5TBxG/cxm/Ofpxm3bSOcfZ2HzlMuXxz/xIxh9BrEm6u0zYGCwQe7/Qql5JPZtNJ4dKKQhoeiQcseB
        uDeDwWtVxgIdDHNwpa8cXzgL+c/KIm2ndmgCGk5NQbEWOj6uOsA1snbcSlWeyVH0Cgc9ceWUb+r6U
        NQps9CfhBeAxLWoJFa+YpaSp9Ebeh1Sn8OK4+6vAlZO8sYeKB4DZXLJgGAlPIB337tfti8TTcVY12
        TPNk/OmW9arl/cMn9kQ0GDIyjK6Vbjm0oXPVnLjHvsIQzpSMCciCssYYys4mO8VCzR3LmcpQaCuqd
        jPZpUXoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcQy-0006Ou-Dw; Tue, 26 May 2020 16:28:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74E0D30047A;
        Tue, 26 May 2020 18:28:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 604C420FF7929; Tue, 26 May 2020 18:28:06 +0200 (CEST)
Date:   Tue, 26 May 2020 18:28:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     x86@kernel.org, sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        laijs@linux.alibaba.com
Subject: Re: x86/entry vs kgdb
Message-ID: <20200526162806.GD325280@hirez.programming.kicks-ass.net>
References: <20200525083605.GB317569@hirez.programming.kicks-ass.net>
 <20200525091832.GE325303@hirez.programming.kicks-ass.net>
 <20200526161621.7ucj5jn6rm5yednb@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161621.7ucj5jn6rm5yednb@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:16:21PM +0100, Daniel Thompson wrote:
> On Mon, May 25, 2020 at 11:18:32AM +0200, Peter Zijlstra wrote:
> > On Mon, May 25, 2020 at 10:36:05AM +0200, Peter Zijlstra wrote:
> > > Hi!
> > > 
> > > Since you seem to care about kgdb, I figured you might want to fix this
> > > before I mark it broken on x86 (we've been considering doing that for a
> > > while).
> > > 
> > > AFAICT the whole debugreg usage of kgdb-x86_64 is completely hosed; it
> > > doesn't respsect the normal exclusion zones as per arch_build_bp_info().
> > > 
> > > That is, breakpoints must never be in:
> > > 
> > >   - in the cpu_entry_area
> > >   - in .entry.text
> > >   - in .noinstr.text
> > >   - in anything else marked NOKPROBE
> > > 
> > > by not respecting these constraints it is trivial to completely and
> > > utterly hose the machine. The entry rework that is current underway will
> > > explicitly not deal with #DB triggering in any of those places.
> > 
> > This also very much includes single stepping those bits.  Which KGDB
> > obviously also does not respects.
> 
> For breakpoints there's already a pre-poke validation hook that
> architectures can override if they want to. I can modify the default
> implementation to include checking the nokprobe list.

Excellent, and I suppose the arch callback should be changed to share
code with arch_build_bp_info(), which Lai was extending here:

  https://lkml.kernel.org/r/20200526014221.2119-1-laijs@linux.alibaba.com

> Stepping is a bit more complex. There are hooks for some of the
> underlying work but not pre-step validation hook. I'll see if we can add
> one.

That'd be great; because where we're going getting this wrong is
insta-fail.

Another point to look at is the whole dbg_is_early; I suspect that's
similarly wrecked, the entry code isn't more robust early on.
