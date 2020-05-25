Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF33C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C3820787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NsVypL1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbgEYJSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:18:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sb77lX+DMcqY6cREpR0MjEzbsR6ud83Odwt/z0stuhI=; b=NsVypL1ygpElBuT3GTopsIuXUZ
        aOILjRmDHzsb1vyAEUwW83smtj4KlujTDWHIeyDfcOORYy/+9RJmt3v9n5jBgU9k0iN4XN26ggIrC
        gh+RHCSbZR0sOjuCyMaP000NwmGZc0BcM8mfRO8tbo2d2ydRAKAwSfOygrfndfMBO1iB7ymkx+CZK
        tKg3/kku828OUM8ahrGQLCO+6bPyEBAJs25oqdiqUCni8+7agpPgfdb2CsBzDiICojQvDEGS/mkeu
        Ym7wpoZMQKc9j37w0Bl/9Ww45a3ZAkQyrojkg+2pVGo1c1I+j4eYcwpHEvQnTOsHG9IZD+a1XxHLN
        rFtUddFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jd9Fi-0008Qe-DQ; Mon, 25 May 2020 09:18:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28B6C30018B;
        Mon, 25 May 2020 11:18:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12D81286BFC11; Mon, 25 May 2020 11:18:32 +0200 (CEST)
Date:   Mon, 25 May 2020 11:18:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     daniel.thompson@linaro.org, x86@kernel.org
Cc:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org
Subject: Re: x86/entry vs kgdb
Message-ID: <20200525091832.GE325303@hirez.programming.kicks-ass.net>
References: <20200525083605.GB317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525083605.GB317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:36:05AM +0200, Peter Zijlstra wrote:
> Hi!
> 
> Since you seem to care about kgdb, I figured you might want to fix this
> before I mark it broken on x86 (we've been considering doing that for a
> while).
> 
> AFAICT the whole debugreg usage of kgdb-x86_64 is completely hosed; it
> doesn't respsect the normal exclusion zones as per arch_build_bp_info().
> 
> That is, breakpoints must never be in:
> 
>   - in the cpu_entry_area
>   - in .entry.text
>   - in .noinstr.text
>   - in anything else marked NOKPROBE
> 
> by not respecting these constraints it is trivial to completely and
> utterly hose the machine. The entry rework that is current underway will
> explicitly not deal with #DB triggering in any of those places.

This also very much includes single stepping those bits.  Which KGDB
obviously also does not respects.

