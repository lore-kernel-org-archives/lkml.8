Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63EC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBF82081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQXv020x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBOALi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:11:38 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44709 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgBOALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:11:37 -0500
Received: by mail-yb1-f194.google.com with SMTP id f21so5656038ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qj2zBbkIxBGfCERuHV86VP5E7OnuA4mxy13S+8Juj1A=;
        b=mQXv020xrGiFQVRcG+t3iVDyjz5L4TGdw0U6fbXeCwxrDC4hDSpg0HBUuUifRpC35r
         IAr+R+LZdTurVkQIlblgBmObc9b8hX5L2QMJXSgw+ykNNQcG5LVdhpwoKmSquITh5FDc
         me1wYFI8+0AcXmPj9ameun83h8tbAFaCzlBQVnK9wL0CfDhdWHFsRLu+6RaIUliQg3mx
         FEvcu8Ar1zcLaMHBuLvh3rsYsOfl0C2RlyfjNt65BG+ROrPNebXJjL0UYf9LxR0gYO5q
         4Entvu6OAzKq+H8KYWL1LRp/fdJbWViG6JTmq3xbcl9LNkt596K8wSd8/aHFGmc4lO1e
         VG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj2zBbkIxBGfCERuHV86VP5E7OnuA4mxy13S+8Juj1A=;
        b=n1GVeyTBRadKXh2/8rRgp1Y3uWzWiBC96WyBAJMa5mZZNmhC8VpIwrPiRIJFtZwWBb
         uEOp1YJHsahGHFu7afllTGobnTCvg6Ifz+P9Xip7bCQ8B8raWfKx3VR+tB8d+YLoHEsv
         jLhofQmxjGmCKSA5SBbhMaCqAB0ODq1S5GtRJZ5ZsCH7UQd15DuiYzlOy+6gOSKXrwX8
         EOIE8LOdjG/GPDf39FPCe1sDhmdzMDGMV+kVjwTxwGeHt5fgb23gynONF8UgLnrTQvf7
         toanAkw7SXwFPYNYfIIFGfBpxbvUNDauG1/gI5jv+GP44iC8h5DtYNin1bV8O2Ljw0Zb
         gqQg==
X-Gm-Message-State: APjAAAUrS0TNvALHDNOj0C4Oq5hPWaFCXJbAifFYj49QaaMpCkySW6/I
        fdPIcj2RDZrjIBGL6Y/4tSo2Tm2jx3VFDPngw2cCBA==
X-Google-Smtp-Source: APXvYqwRusIwUk6lCNfxmnhsTV8VjQlzho9wFmoZfuZX08t6lIpHqT7y+O10DM3NmqSYkj2omYk5blRS2XoRospyutQ=
X-Received: by 2002:a25:b949:: with SMTP id s9mr5305834ybm.274.1581725496112;
 Fri, 14 Feb 2020 16:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
 <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com>
 <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com> <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
In-Reply-To: <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Feb 2020 16:11:24 -0800
Message-ID: <CANn89iKq5r7aCDdpTXzfvDbhHYgnTGhgyTG5_rLbcSeeF8uJJQ@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 4:04 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 3:12 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 2:48 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > >
> > > I think in the current code if the association is skipped at
> > > allocation time then the sock will remain unassociated for its
> > > lifetime.
> > >
> > > Maybe we can add the association in the later stages but it seems like
> > > it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
> > > mem_cgroup_sk_alloc()"").
> >
> > Half TCP sockets are passive, so this means that 50% of TCP sockets
> > won't be charged.
> > (the socket cloning always happens from BH context)
> >
> > I think this deserves a comment in the changelog or documentation,
> > otherwise some people might think
> > using memcg will make them safe.
>
> Thanks I will update the changelog. Also is inet_csk_accept() the
> right place for delayed cgroup/memcg binding (if we decide to do
> that). I am wondering if we can force charge the memcg during late
> binding to cater the issue fixed in edbe69ef2c90f.
>

Yes, this is exactly why accept() would be the natural choice.

You  do not want to test/change the binding at sendmsg()/recvmsg() time, right ?
