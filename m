Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2094C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAC2246A1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f02XpK2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAWSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:18:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38233 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgCAWSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:18:47 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so7658132ilq.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idl6CAZ4ITJuBYPn9L4mQrfqGQ3iPRLrH1VIVeU0Djc=;
        b=f02XpK2ejCZoNah0VS/D/BTPPXjnnwlxaKHbPLZ1gNzdM8WoIRfmLM97gRYrrkNYzb
         /4UEOO6pkK9VGFzE/xMp8jBkDU7yhZBwVQMTYnUPS6N5I0l3ISvaWhDH1glPSAAsCRCS
         8YaVQcO/YyHQfzdaQOdKtLXt4hhcm3zjX+xPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idl6CAZ4ITJuBYPn9L4mQrfqGQ3iPRLrH1VIVeU0Djc=;
        b=anhPt8Du0jylS7ZAgCtrDhs/2t97CvMXhjbBX6TZuEDqCMGM1U/7zdGRI25ic+sw/F
         WK91E7iLqURFt/+Jzd+KC0SID/fUYnq0kn4/GwRF9oqn0hrNQ6gASTXPYrrp5aMnGSAH
         nUYehWZVFW8MuZO6OuPgq5BzArZgs+ydmIhkaokkxhUPSCdxsU518LvbKI+baX2ivqgH
         kXHCUbzn0n97ZhFL7CA3GREbWV2bp1KVHukwnYfQA1RUryhC1YHZBpMEPTuaB9yB8HgV
         ve7/xCTrlLGMJWR7cBQXQV9FESabsTCBFeLfk/ksLwxVnAnkx/Naw8tRxU7PxPPHMjha
         inLA==
X-Gm-Message-State: APjAAAU9Du8pEuOlklHG7EWurvzkd6m9+TM5ptKBmrLWGC/sQHevAucu
        ZDCD+/TALsQJt05uxugT9qAwJ2fM9e6jboUgpof83w==
X-Google-Smtp-Source: APXvYqwLnS0nfF1/cQS73Q2LPYiqa+EUG8rSDYv9Fre1Q/MkLceZD9/brJKRSb0IQJQPd3q9fUNP9keq8GFm1k6ZCHQ=
X-Received: by 2002:a92:3cd7:: with SMTP id j84mr15067873ilf.176.1583101127203;
 Sun, 01 Mar 2020 14:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com>
 <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
 <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org> <CAJZ5v0jTSKd_23fJhM+XUmFX_yTjcD+c_s1Jvi3HA1EmXPkzZw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTSKd_23fJhM+XUmFX_yTjcD+c_s1Jvi3HA1EmXPkzZw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 1 Mar 2020 17:18:36 -0500
Message-ID: <CAEXW_YRL0kum5yVm+9V8i_PK2FcHfPeUOxJKZ+T8P3zqhATxJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 4:23 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Mar 1, 2020 at 9:53 PM <joel@joelfernandes.org> wrote:
> >
> >
> >
> > On March 1, 2020 3:12:53 PM EST, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail.com> wrote:
> > >>
> > >> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > >>
> > >> This patch passes the cond argument to list_for_each_entry_rcu()
> > >> to fix the following false-positive lockdep warnings:
> > >>
> > >> [  330.302784] =============================
> > >> [  330.302789] WARNING: suspicious RCU usage
> > >> [  330.302796] 5.6.0-rc1+ #5 Not tainted
> > >> [  330.302801] -----------------------------
> > >> [  330.302808] drivers/base/power/main.c:326 RCU-list traversed in
> > >non-reader section!!
> > >>
> > >> [  330.303303] =============================
> > >> [  330.303307] WARNING: suspicious RCU usage
> > >> [  330.303311] 5.6.0-rc1+ #5 Not tainted
> > >> [  330.303315] -----------------------------
> > >> [  330.303319] drivers/base/power/main.c:1698 RCU-list traversed in
> > >non-reader section!!
> > >>
> > >> [  331.934969] =============================
> > >> [  331.934971] WARNING: suspicious RCU usage
> > >> [  331.934973] 5.6.0-rc1+ #5 Not tainted
> > >> [  331.934975] -----------------------------
> > >> [  331.934977] drivers/base/power/main.c:1238 RCU-list traversed in
> > >non-reader section!!
> > >>
> > >> [  332.467772] WARNING: suspicious RCU usage
> > >> [  332.467775] 5.6.0-rc1+ #5 Not tainted
> > >> [  332.467775] -----------------------------
> > >> [  332.467778] drivers/base/power/main.c:269 RCU-list traversed in
> > >non-reader section!!
> > >
> > >I don't see these warnings in the kernels run locally here.
> > >
> > >What do you do to get them?
> > >
> > >Joel, any comments here?
> >
> > You have to enable lockdep in your config. Does your setup have that?
>
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y

This should be it. I am not sure what else Madhuparna did to trigger
it. Madhuparna, could you elaborate?

thanks,

 - Joel
