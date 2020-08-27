Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35F12075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYMYeWcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgH0J1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgH0J1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:27:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEAC061264;
        Thu, 27 Aug 2020 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cbkbj9n8n3AMTxZpJL8iKP1ExJYrvJSewIYwEkXDWlc=; b=oYMYeWcS5GPq0zqTS9H03jKfiM
        ZS8DT+uU2qnSvCgVslIG2rxMlkmBNIabvCnRj/S+CNFX3j5TacjM53XNqoP5Vii8r4lvSSH6nakdE
        EGhwk1zfbNJcfAswUfjtPnca9kR7WceFtdvJZCZBY2zaX0a2+nNQy0niMsS8Sz9dEK+cCt2O6lcct
        R0kTZpy0dKZp9EmOplkDhfomirTSKEsxQS5T8ncWqeuY6GI4Q/wwJO80PegSsXB5O1wBI4vwlI7IL
        xWKtznPrRceAblMEbDrxnI/stnU7a6pJwP49WJjfFh9snBYBWvupfs0AlM3lzjHVp+jcDuUmNoJsp
        KGputAPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBEBw-0005mz-5D; Thu, 27 Aug 2020 09:27:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C4CE301A66;
        Thu, 27 Aug 2020 11:27:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FE122C30F37F; Thu, 27 Aug 2020 11:27:30 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:27:30 +0200
From:   peterz@infradead.org
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/topology: Move sd_flag_debug out of
 linux/sched/topology.h
Message-ID: <20200827092730.GI1362448@hirez.programming.kicks-ass.net>
References: <20200825133216.9163-1-valentin.schneider@arm.com>
 <159851487090.20229.14835640470330793284.tip-bot2@tip-bot2>
 <CAHp75VfJumPP=wKuU=OjFB11RUhPp0_5_+ogupQLFeEWKfbybA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfJumPP=wKuU=OjFB11RUhPp0_5_+ogupQLFeEWKfbybA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:50:07AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 27, 2020 at 10:57 AM tip-bot2 for Valentin Schneider
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the sched/core branch of tip:
> 
> > Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20200825133216.9163-1-valentin.schneider@arm.com
> 
> Hmm... I'm wondering if this bot is aware of tags given afterwards in
> the thread?

Sorry, your tag came in after I'd already queued the lot.
