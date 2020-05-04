Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C6C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EA320707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbV667a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEDTYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:24:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3921DC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:24:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so10871837ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPSIuUKl40zjMTrFqmrp2gFzjgO0Cf6BRDzGoK+tDWg=;
        b=GbV667a2pWz8YlwID7RIjSxS3EhvbGG2eVTfjeZbnaIQt36eX7hiNgbdWKkgMsOAkc
         Pd4c3Z36tS9zp5i+DSGGNzKx3LApW78iueZL2oOKHKQNXDEONAYw9/ZwJiiU/GAIcLEA
         IqcfxVY1ivCJBbIP2ttRlcjLxsjcr/HGVZqBdV7VXMRvuze/dDQrmnz2PCC0tEfr2wGb
         GlO3dsxskMpwBK8J2EqhuA7PAfU5gFeu1qFNUvc5mLxqLM98jDrtc9gQJG8j1w9P435i
         7YmVNH9IMNHBLHEYXaU5eSxODFeYdzQ8b6i7xQ8eLdZfq67RRTA5e8VMKA/kl+4zKZjE
         Murw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPSIuUKl40zjMTrFqmrp2gFzjgO0Cf6BRDzGoK+tDWg=;
        b=JmMNFvVaPMA+Kz91dnSIBgxTXl8Qq3HPx8/mByxejBqzDlTFB4+2nAInJUElk8cKnP
         t9duHy2X3uRZKkKEqYHpu9jRiqQtvexR2JG5VSezJkRpgzwyAwUBhPnlvobKyfvy6u8i
         GNeOb88gLo4F48Dtg0++ehaTFMiETEu8q0OHUEGY/SuzzKp3Qeh9q4vYnAnJVGHceAdJ
         hrFAyBlF4Qr7VU2jxEmXOV7nGGwU3KweON8awpfOco7Wn/JyY6wa/+YWS+S4KuDfLl67
         OaQtbgS+vHR7pQRD2TieIMWqnsUTLsnlz5mQgQqZpQ7ocRERZ2yAiq4Zpv0kOYqXp+/O
         qUeQ==
X-Gm-Message-State: AGi0PubGyq+i6xfI9kjdFalQZFuyYMyzw84p9ZrC/ILlc5KmJNDrovop
        gghCMcBSq2Ne7OPVRW+RViUQL5cR31wopPKMGKTiEQ==
X-Google-Smtp-Source: APiQypK4k05/C2I/yimUeRPIsrYih0ut0hSKIXH2CCGt3+KnrSP6gGhNuIc5dVPg4hLorIO9oSIUzNKPjU1zs0K4BW4=
X-Received: by 2002:a2e:9255:: with SMTP id v21mr11042631ljg.222.1588620243090;
 Mon, 04 May 2020 12:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz> <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz> <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
In-Reply-To: <20200504160613.GU22838@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 4 May 2020 12:23:51 -0700
Message-ID: <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 04-05-20 08:35:57, Shakeel Butt wrote:
> > On Mon, May 4, 2020 at 8:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 04-05-20 07:53:01, Shakeel Butt wrote:
> [...]
> > > > I am trying to see if "no eligible task" is really an issue and should
> > > > be warned for the "other use cases". The only real use-case I can
> > > > think of are resource managers adjusting the limit dynamically. I
> > > > don't see "no eligible task" a concerning reason for such use-case.
> > >
> > > It is very much a concerning reason to notify about like any other OOM
> > > situation due to hard limit breach. In this case it is worse in some
> > > sense because the limit cannot be trimmed down because there is no
> > > directly reclaimable memory at all. Such an oom situation is
> > > effectivelly conserved.
> > > --
> >
> > Let me make a more precise statement and tell me if you agree. The "no
> > eligible task" is concerning for the charging path but not for the
> > writer of memory.max. The writer can read the usage and
> > cgroup.[procs|events] to figure out the situation if needed.
>
> I really hate to repeat myself but this is no different from a regular
> oom situation.

Conceptually yes there is no difference but there is no *divine
restriction* to not make a difference if there is a real world
use-case which would benefit from it.

> Admin sets the hard limit and the kernel tries to act
> upon that.
>
> You cannot make any assumption about what admin wanted or didn't want
> to see.

Actually we always make assumptions on how the feature we implement
will be used and as new use-cases come the assumptions evolve.

> We simply trigger the oom killer on memory.max and this is a
> documented behavior. No eligible task or no task at all is a simply a
> corner case

For "sweep before tear down" use-case this is not a corner case.

> when the kernel cannot act and mentions that along with the
> oom report so that whoever consumes that information can debug or act on
> that fact.
>
> Silencing the oom report is simply removing a potentially useful
> aid to debug further a potential problem.

*Potentially* useful for debugging versus actually beneficial for
"sweep before tear down" use-case. Also I am not saying to make "no
dumps for memory.max when no eligible tasks" a set in stone rule. We
can always reevaluate when such information will actually be useful.

Johannes/Andrew, what's your opinion?
