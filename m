Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76414C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C17207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjXHtluf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgH0J6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0J6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:58:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D0C061264;
        Thu, 27 Aug 2020 02:58:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so2358397pjv.0;
        Thu, 27 Aug 2020 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsSPi3tJV6tt9MRH9X9IRqMWBLmb6vhjP03IMQT77sE=;
        b=WjXHtlufRYtaf/khSMswHWqVqBQduDN9Kgb+Bw4FEZc6pvPVLEGceIvBAlBGwuSLbe
         MNcSvM+j39nJ2sNxBc3evDkzN/I86r5/Py16Vz3wgLQ/tAcVDpwQe5limKNH9RVpnXwS
         mg5cgS1yWRSeQMb/9F+Z8cHUjsOAhBuE69X8sTqEDx8O/OHzS4xH32afcL+XZB9aQ02+
         qIlNYWrzy8KZ7+Ly2FDDuYie8fw2SeZ7/F+0BI3hjqD+jxdjGsLiwqypJiCxKqG74TvQ
         urqW5930WoJm3kvgGcyRxUaIeK8N+tTMqGNY3GbukxlfhZXfsN3QygqLwL2EHbZcdpcY
         V3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsSPi3tJV6tt9MRH9X9IRqMWBLmb6vhjP03IMQT77sE=;
        b=dQ2TOpCZ67z7HItodcdFMfo4XUt9UopI9WQS/4ATY65cPv6dF0l0je8S6C1xi8QSZu
         ee1B3P2QznE9+WnYTNqRTjnSfqkZq2Nh8HyQwj1nf9uIZSNnbDZKvyoUX8pheUjF4k8B
         YBdgTCNdVhgX9+y5rYkA0oobOfujRGJhRhA7R8zWe4KWaS/m+8R0Ril/Q1d5LS78zzt5
         4Uc8f5ChZ7ABLM+hTDLvhMbUZp6ePBlhgWhIJM+gZY9UcE79hv9+pVANhmR1fE/wgXJN
         r0xDBheoISamjwyyrHR3KFKex4UOTrPf+LU+jS8S1ED7sVdjsHLzUXUf1Tl38s/CDYAp
         C7mQ==
X-Gm-Message-State: AOAM530lXdJGyqsdvQwRt4W2Sdv9kdWEJSHvmZHaWRQFja/KRtWYsIFG
        R8WQgTW1mmqc16Jy0Q/uKhhKfE6bIXWdQ68X/FA=
X-Google-Smtp-Source: ABdhPJxBnaQ1cbucAx/3wJaRhRAn0tdxu0ryrc6qcTtQjsQSGuSpLTIErgLrborEu41xqWA6kPRlcAuseuhhubTXuRQ=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr10266874pjd.129.1598522287969;
 Thu, 27 Aug 2020 02:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200825133216.9163-1-valentin.schneider@arm.com>
 <159851487090.20229.14835640470330793284.tip-bot2@tip-bot2>
 <CAHp75VfJumPP=wKuU=OjFB11RUhPp0_5_+ogupQLFeEWKfbybA@mail.gmail.com> <20200827092730.GI1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200827092730.GI1362448@hirez.programming.kicks-ass.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 12:57:51 +0300
Message-ID: <CAHp75VdK-FMC10utfVO3+7J+UevPKDqrs+w_6XM6MsrC3CPe3g@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/topology: Move sd_flag_debug out of linux/sched/topology.h
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:27 PM <peterz@infradead.org> wrote:
>
> On Thu, Aug 27, 2020 at 11:50:07AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2020 at 10:57 AM tip-bot2 for Valentin Schneider
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the sched/core branch of tip:
> >
> > > Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
> > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20200825133216.9163-1-valentin.schneider@arm.com
> >
> > Hmm... I'm wondering if this bot is aware of tags given afterwards in
> > the thread?
>
> Sorry, your tag came in after I'd already queued the lot.

No problem, just was wondering!


-- 
With Best Regards,
Andy Shevchenko
