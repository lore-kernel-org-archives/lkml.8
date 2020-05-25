Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF22068D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1bvHWQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgEYIUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgEYIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:20:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:20:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j145so15437087oib.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Azh7Qf5VqGk1C5GHmcLCjaOZm5RvD53r5M4Q66y5N4E=;
        b=G1bvHWQvaSzoekxw3mZ7s4c83ovTLXsKLzv3enF9zYsC9+tgS2i9AW2iOGqlowFhri
         k3mmhKEAGjbvtDNLBBW/BRGvs2DlJTdM/dD0lpKbvlHbUxo79Kxm+tn9tsp4R6wT9i1m
         Sfa1KVv6reJKwKFn9um4GzRQps/Atzo6MTEzmzLE8GDBznrbiP/L4IyPmL7OOVDrFUcI
         P9KG7fskRERGdWqROan1hpxepyqr/pEh1t37fif2YcbKYS4aFtmWkEmjcyNRHsjLxPg+
         S8QumjJdluVOXzH+A7bUuxxUdRKmjJQaKv/KzyH7owfz3PuF4U9wT+0u4+YSwupJ3ZTJ
         eS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Azh7Qf5VqGk1C5GHmcLCjaOZm5RvD53r5M4Q66y5N4E=;
        b=L69eXWOaM0evB7Yc8y9TPzFuqqgMCrV+2F1GU6+PHmsU6YOuRuVf5F3T/USU5EQnFH
         3JCEu0S++l0iXTDwDO2KwcQbluBZM6/F6u0CZPFHUc6GTQDC4w/flbxBgjbIOAPeetL+
         SPlS30O4wsDj7DE+sLEE3LQ81499tR8dPNuXN4uOMxGHpdxglLd1kKVwFhQrHuP6AuTI
         WF4kfS603Ck23tB1gPdiM8m9UgCPx4GVaCWaJlByRAlmDyQ4Vr4evbp/kUfW8rapOn6x
         AU8zyGadJ5dKN0eH83SuwTzps0Z8iqmV01SYsSky3HFdsDgUn4pwaXKyKCNxNrba8jbO
         52kw==
X-Gm-Message-State: AOAM533TEw3/jXpJf37lrMh2vWpPRZ2VyqsMoKifj+ybjbTgjJPhTuOv
        c0i/mQMmGmUecnzea8jJIvxAaow5YyakU7Dnf7N1WA==
X-Google-Smtp-Source: ABdhPJzPfGvkXoAEO6zWx5fGwS/RRPJEryJvMFIXf0ksHObwHtbFS1z8Vgxvdql1XeVzo3PZPlnI/SPaIp2bNYA9MjI=
X-Received: by 2002:aca:d0d:: with SMTP id 13mr2336227oin.172.1590394841810;
 Mon, 25 May 2020 01:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200522033119.1bbd99c5@canb.auug.org.au> <20200521173520.GL6608@willie-the-truck>
 <20200522171708.5f392fde@canb.auug.org.au> <20200522174944.1a1732fa@canb.auug.org.au>
 <20200523001223.GA23921@paulmck-ThinkPad-P72> <20200523064643.GA27431@zn.tnic>
 <87a71zq8ml.fsf@nanos.tec.linutronix.de> <20200523150614.GP2869@paulmck-ThinkPad-P72>
 <871rnaqxor.fsf@nanos.tec.linutronix.de> <20200523212345.GR2869@paulmck-ThinkPad-P72>
 <20200525003706.GA13789@paulmck-ThinkPad-P72>
In-Reply-To: <20200525003706.GA13789@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 May 2020 10:20:29 +0200
Message-ID: <CANpmjNMjvJqVFiY+xSUK=oePP9TsDzZHVh6XKM77ar5fh_fdFQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tip tree
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 at 02:37, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, May 23, 2020 at 02:23:45PM -0700, Paul E. McKenney wrote:
> > On Sat, May 23, 2020 at 09:05:24PM +0200, Thomas Gleixner wrote:
> > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > > On Sat, May 23, 2020 at 11:54:26AM +0200, Thomas Gleixner wrote:
> > > >> core/rcu is the one which diverged and caused the merge conflict with
> > > >> PPC to happen twice. So Paul needs to remove the stale core/rcu bits and
> > > >> rebase on the current version (which is not going to change again).
> > > >
> > > > So there will be another noinstr-rcu-* tag, and I will rebase on top
> > > > of that, correct?  If so, fair enough!
> > >
> > > Here you go: noinstr-rcu-220-05-23
> > >
> > > I wanted this to be 2020 and not 220 but I noticed after pushing it
> > > out. I guess it still does the job :)
> >
> > Now -that- is what I call an old-school tag name!!!  ;-)
> >
> > I remerged, rebased, and pushed to -rcu branch "dev".
> >
> > If it survives testing, I will reset -rcu branch "rcu/next" as well.
>
> And passed!  The compile times are back to their old selves on my
> laptop as well.
>
> Thank you for setting this up, Thomas!!!

I just noticed that -rcu and -tip both still have their own version of
"ubsan, kcsan: Don't combine sanitizer with kcov on clang". For there
to not be any conflicts in -next, "ubsan, kcsan: Don't combine
sanitizer with kcov on clang" could be dropped from -rcu.

Thanks,
-- Marco
