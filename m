Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1287BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E570E20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4Ojel12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHUHF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgHUHF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:05:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE08C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:05:58 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so850838otc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpCnqjLumk9/Y3NhZ+CrjOKofnQIK37Yvqj+XWx5hQ8=;
        b=K4Ojel12gKh4nwoGJBD0es7Rh5fcPjf9aBtCccLxZkO66z7ddyWFrZ3gRbura0McD4
         giZzgtkm2+lzNSSQrarb+nNSGnpm5WIXpS26JEhH/MWeJeODi8tm8GsRS8mx4GhQcQAj
         /4ngQoaf90SpesDpwIchvRzoCpHN7ZZ5zR/bUCMbpn81kReKrsGlgajML/jgs65msvrQ
         E7vVtTmBQqcpvuvfu03TxALJB1SouwD8PVYpLHqaPNY0gO7DwKQwXiKlUO4ofqDgbAe3
         ngx2YX7/s/yzmFIvYmWXraBLihiPhgcw6teaOSpKlPiuyfAx3MJbZGftTDCuiS6CPv4x
         7uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpCnqjLumk9/Y3NhZ+CrjOKofnQIK37Yvqj+XWx5hQ8=;
        b=ahfJCSRl4eGloVaH2cw+GLsoXXxDsCh/DVnT/dM33e3cUEEUAHL8kcv0lYtueQxjyZ
         hvzEPpFvTllzT/idhrkMcXqYyHAjXKCwHBGEd9zmSOehOrYVTF1k/L1KXVGmeXIVN9MB
         k3h/sggpb03cUZstmMRiC4nuZ6Igx9bJD5Pxo2ySdA/ANuuH4J0SfKwWaHlskWs36FBi
         5pZnEaJHhUlyrXP2iLBB/ta30hD/9HTvVPHAu8UjcJt6qJzmouv2Ne1n35JvwrSQUu2a
         bVJEMsFYkFP4YW1+8pVdpKnt9xfQITVnTe9pkiVT5DUIiYiRFj1JoK5mtREDvgseFXqm
         3ZYw==
X-Gm-Message-State: AOAM532lUVhI85vbxjstfL3IvDHjIniGn6PqwjNV5lVwezppDbZ+kFzR
        +2WiAd6BJiKVVf7QwMlzNLQOkno+IJUkVaOlZ2963/KyBVg=
X-Google-Smtp-Source: ABdhPJwLVxJTFWfmDvZN/HlMbn33X5V3EVbXrdeO2UK5IFLGRPyN89v0w8Ne7rN5bjP24u9EwVOtx1CZwcTa5gIQPDU=
X-Received: by 2002:a9d:739a:: with SMTP id j26mr1100354otk.17.1597993557707;
 Fri, 21 Aug 2020 00:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200820073031.886217423@infradead.org> <20200820103643.1b9abe88@oasis.local.home>
 <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
 <20200820172046.GA177701@elver.google.com> <20200821065413.GG1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200821065413.GG1362448@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 Aug 2020 09:05:46 +0200
Message-ID: <CANpmjNOnopd8usQJk0Y1mxSNrQ15e0GboNfwop4qUDCwMnQQZQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rjw@rjwysocki.net,
        Joel Fernandes <joel@joelfernandes.org>, svens@linux.ibm.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 at 08:54, <peterz@infradead.org> wrote:
>
> On Thu, Aug 20, 2020 at 07:20:46PM +0200, Marco Elver wrote:
> > From 4ec9dd472c978e1eba622fb22bc04e4357f10421 Mon Sep 17 00:00:00 2001
> > From: Marco Elver <elver@google.com>
> > Date: Thu, 20 Aug 2020 19:06:09 +0200
> > Subject: [PATCH] sched: Turn inline into __always_inline due to noinstr use
> >
> > is_idle_task() may be used from noinstr functions such as
> > irqentry_enter(). Since the compiler is free to not inline regular
> > inline functions, switch to using __always_inline.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Fair enough I suppose; didn't that generate an objtool warning on your
> build? (of course that requires PARAVIRT=n, I should get back to fixing
> that)

It does now after turning on VMLINUX_VALIDATION.

Although note that this patch (and the other, which I'll send
separately) wasn't required after the rcuidle fix. I suppose there is
still a small chance things can go wrong though, but syzkaller wasn't
able to find such a case (yet).

Thanks,
-- Marco
