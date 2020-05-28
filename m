Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9165C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C319D20776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNkIsmki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbgE1XGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391546AbgE1XGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:06:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081FC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:06:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 17so685365ilj.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6efeBhEA8jJzf2TongZsZb2kdgbZpcm87yBeRzV8Z8=;
        b=rNkIsmkictXvRJP/m/oj5PkfPXtaolbz1ryoC1zATCnLBUUI6doLG4GjZQ5Oqin+ND
         kqCsQaCtltq+o8tYNedwZnMOEJB9/Rkv0mDb3xn7SbluKABQUp/CmhITSLBs9/F2PGjb
         HKvFBCSHtE4RBUXW+mPDQKbpmqw8UoVwjJDrSPxB0VHKK4N8k8HLp1I84IVB4Hrp3BVb
         C+/aINZdwV3wbbbK3gNEC21VyUhoNWV2tjEgiJqeTGeYYe+ErxdI+dACy84Jpe/mJk61
         P3uj+TjDOdl4DaV+nbrt6knNeAhH+ReGlZmaeE64xKQAYAGAOzX+K5v/WyN1cCm5dBH5
         40uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6efeBhEA8jJzf2TongZsZb2kdgbZpcm87yBeRzV8Z8=;
        b=YxAd21IgkyY6GYSJmOuev2WUUWMaL0eYaXu53WAChER7p1GP1Um0DhximaTwDRsZCG
         cYfrJtgz8zqzUEBFoFA3ngrULqQBalp7lhd0kgAvHggS5J03B0+Pe211Ik68W2ZNOyc7
         MgwzT4YFlbCBN+rzwr+vbNbTG/Jh3KfLfjp9WEzLq7l3XZBciqHTlP7mgi3R0tr2P9cR
         EjePLRXaOkuoWU4VcMMwGO0hRcKFfHvUaS+HGqhHUGchVGpbR/52AdgZjHXAnUWBx/Hq
         A93e8/bD5QVT0XCPnQzKudReGA3i+ouDnyNDoumNBGrmaGOqc0oYa5FP1o+IAHIvccsi
         kRcQ==
X-Gm-Message-State: AOAM533fCnf9Dulw/8sOXD6ZOpY9lAEvWxc0w1+ZbWhFo3s/9qKfdwug
        aQXrtERRnQjJmyOx0wWwd3kiabz5PDQCTc4shGU=
X-Google-Smtp-Source: ABdhPJxsDKPL8OE4rF6BZY8g3R4IgYZUEAO5LFnxqpeLJ2NPmbF/1ODG+oBo0rAq3gPNE5J7O3gtLYv+qofEmCkJsX4=
X-Received: by 2002:a92:c8d1:: with SMTP id c17mr4806716ilq.308.1590707166189;
 Thu, 28 May 2020 16:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200528201937.038455891@infradead.org> <CAJhGHyCua-oTww9U26CJvfojxdfQGewH1T-JUro7gLKucT2+kw@mail.gmail.com>
 <20200528224835.GU2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200528224835.GU2483@worktop.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 29 May 2020 07:05:54 +0800
Message-ID: <CAJhGHyAZVVyQx_3gEtcxF_NaOov4=oR9kN4qO4FAR==hTNa+4Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] x86/entry: disallow #DB more
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 6:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 29, 2020 at 06:42:46AM +0800, Lai Jiangshan wrote:
> > On Fri, May 29, 2020 at 4:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.
> > >
> >
> > Hello
> >
> > Will #DB be allowed in #DF?
>
> No, that whole thing is noinstr.

But it calls many functions, including die(), panic().
We don't want #DB to interfere how it die() and panic().
Since it is in fragile #DF, the #DB may mess it up and
make #DF fails to report and die.
