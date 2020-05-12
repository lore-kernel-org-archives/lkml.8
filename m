Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B913C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QMRj3KeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgELWxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgELWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:53:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B440C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:53:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so6793527iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbksr85X1t9NeTW2nK2Gw8Z3WTyso7gugVZpgKykZDw=;
        b=QMRj3KeSy3swo2oLnAkMXF6O9qLOuI1O4A/Y5gC61yBgZeVtW9UbbdQ7RrMAQvFBqv
         Srvk+f4ITY4C7BJFYwcibovAUP++bCVr+pTcnyKtOjQAUsQQ+6J/cDTodCVRDHADrGqG
         rlPnwp1yiBZrnmX5p9dXiySdpxOMoOTdKgWoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbksr85X1t9NeTW2nK2Gw8Z3WTyso7gugVZpgKykZDw=;
        b=EO8z3ODstxGDY2hYAh5CO8ibkVXFtmgPoS1V69R1EHUlN/+WL576cxazQkU16Zij4V
         g6W7OFteEemRz5eXrKfCe5f4vNhl4KJMIz3tv+X0btQK4O5h6MDbDSMP3SBWDFQMhHHk
         psnpm1PnsLjv6+/nuTlZfEbucGiobS6wXVoretQb9eDUzXsgbkykAjutQM6UPnkJvRMS
         7lf6W6oSTNwMhuvTIDp291yo9sA+v580DCBft9BS6eaLQhQfEXBEtFoEczDM/unj78NL
         oTYuJG4veVZfjLS/hnliEhP2Y+QVvYvj2FvIaV3vGQvzPqU6V9vpJBghFoX0mW16OOvp
         cOGw==
X-Gm-Message-State: AGi0Pub4PYY0eyajPsVLBzaJqs4mrOqMy3YXexnv/1OnMW8uVi0u53C0
        n018A4oFU7tG183SqPAWUXlIX3Rl+6ew/O5/gfFFlQ==
X-Google-Smtp-Source: APiQypIhCDJ21tBkwqWH+vwILqA9HOMVsY2ZF1oAcrxSNyf6NfGGsxusSYew2fGc38GsAJ15okrtHB06h8dqDuygzpA=
X-Received: by 2002:a5e:8411:: with SMTP id h17mr1790878ioj.1.1589323982360;
 Tue, 12 May 2020 15:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com> <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com> <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72> <20200512214342.GA89170@google.com>
 <d1809f12-77a3-65e4-7af2-bdd87c48ada7@gmail.com>
In-Reply-To: <d1809f12-77a3-65e4-7af2-bdd87c48ada7@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 12 May 2020 18:52:49 -0400
Message-ID: <CAEXW_YQfUFQmfyj9NnkJKcSH7-15FjEbFDP=GoYRR9OCwyJOWw@mail.gmail.com>
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 5:49 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Tue, 12 May 2020 17:43:42 -0400, Joel Fernandes wrote:
> > On Tue, May 12, 2020 at 09:30:22AM -0700, Paul E. McKenney wrote:
> >> On Tue, May 12, 2020 at 11:41:01AM -0400, Joel Fernandes wrote:
> >>> On Tue, May 12, 2020 at 11:07 AM Akira Yokosawa <akiyks@gmail.com> wrote:
> >>>>
> >>>> From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
> >>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> Date: Mon, 11 May 2020 22:06:46 -0400
> >>>> Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
> >>>>
> >>>> Since this test returned to tools/memory-model/, make sure that it is
> >>>> at least referenced from Documentation/litmus-tests/'s README.
> >>>>
> >>>> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> >>>> [Alan: grammar nit]
> >>>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >>>> ---
> >>>> I said in the earlier message:
> >>>>
> >>>>> The explanation under tools/memory-model/litmus-tests/README also need the same
> >>>>> rewording.
> >>>>
> >>>> , but obviously I was confused. It is good as is.
> >>>>
> >>>> This is on top of my earlier patch series.
> >>>>
> >>>> Joel, Alan, does this work with you?
> >>>
> >>> Yes, thanks a lot for doing it. Paul are you Ok with it too?
> >>
> >> Looks good to me!
> >>
> >> Could one of you please send a patch series and instructions, which I
> >> -think- will be of the form:
> >>
> >> o    Revert a5cca3485d92 ("Documentation: LKMM: Move
> >>      MP+onceassign+derefonce to new litmus-tests/rcu/")
> >>
> >> o    Apply a series of patches.
> >
> > Rebased Akira's 3 and my 1 on top of your /dev branch with the ordering done as above:
>
> Oh, I missed the reordering part in my PATCH RESEND series.
>

That's Ok, I took care of it ;-) You passed me the ball, I hit it into the goal.

> Paul, it's up to you which you pull/apply.

Indeed! ;-)

 - Joel


>
>         Thanks, Akira
>
> >
> > Could you pull?
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch for-paul-dev)
> >
> > Thanks!
> >
> >  - Joel
> >
