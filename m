Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16680C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66542076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Is7wIv1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLUry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHLUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:47:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0AC061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 13:47:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m22so3764616ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YMlwqJSUWt1i6F6iEK9tCz9nN1m89EegznfYz1dxWM0=;
        b=Is7wIv1rlekdHNR2ib1o3cMo7WVrmIWWC+LnWxvZAwG92uGCGXtX+YtRbd5ROD2lgh
         Mpge5B1FXl6BaNj26hyaOzPPnA/QNeUNdczVSHNUJaIOR0yCrpT0DSqce2Ygglc5BYhQ
         ro0sx555IRcMIxwNlNfuI02xPmAvGNvYsb++W590hadWc97jyGgtLkvZHj2gF8ZOzG++
         n115EKAR5i7tUZQBbP7f9U2RCDZrj6qoW32soFk4Ha4K37OBfgrq3+Bw86zdjTYqLCu4
         ZPqFwWhZ0aQtyUiu/o3CIhSt6o8RAzjriZE/ElCU67i76Ue+4gB1Brnbzon9m2IGI/Lx
         /H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YMlwqJSUWt1i6F6iEK9tCz9nN1m89EegznfYz1dxWM0=;
        b=czVrWi1I7vLT0SzbvVHKJTqRTIkjWEoogpGrmGLktiu+IcrKv18oi8xfOxLDkQF3kK
         xIkJC5XehG3VApAkR8r6HxLRZP4kXIexTMGRFa1mAc1rour1QKqx6V7H0QDateM4rb+w
         Y6oOLSe/XW5oBD7hpMnRn1tuaB1usnF4Nn8Byaxs6BE4zXHkm+1E5rzIIyXGrtwrHEy4
         QdJRDRVLko8rHpIvw0vd4Ie4PCmFmG68MY2TiiRnd00R2JnHELEAvlWO5pvmNkPGd7vv
         0l0ogLB3wvlVlmQfgnAugwDJxSqcgwzT+tMuh8CexEFu7N30kNAczV1bc7GWvUyq6pvd
         twKg==
X-Gm-Message-State: AOAM533KpyqgbjAk5JAZ5AWMclyUYd6Tz3Alt8HmCU8/Ozt+vHj7ieB3
        moZIQMsQfr6FaRkTXg6bGz2B7C+Z6xP7N5wQ99AWKg==
X-Google-Smtp-Source: ABdhPJzdFOd56sO3fLqOrp2lhWBF4iWcxurm5bqT8H2lGb+JKbkDtwS66QTjNiURfm9n7xaOsbyj9XgtOxBCZhFiPyc=
X-Received: by 2002:a05:651c:330:: with SMTP id b16mr461290ljp.77.1597265270865;
 Wed, 12 Aug 2020 13:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
 <20200707121422.GP5913@dhcp22.suse.cz> <CALvZod5ty=piw6czyVyMhxQMBWGghC3ujxbrkVPr0fzwqogwrw@mail.gmail.com>
 <20200811173626.GA58879@blackbook>
In-Reply-To: <20200811173626.GA58879@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 12 Aug 2020 13:47:39 -0700
Message-ID: <CALvZod4+urCc-fFcjkoNOoLLyzcAW=hr14XgmBMAP+RnEyRyfw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Aug 11, 2020 at 10:36 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hi Shakeel.
>
> On Tue, Jul 07, 2020 at 10:02:50AM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > > Well, I was talkingg about memory.low. It is not meant only to protec=
t
> > > from the global reclaim. It can be used for balancing memory reclaim
> > > from _any_ external memory pressure source. So it is somehow related =
to
> > > the usecase you have mentioned.
> > >
> >
> > For the uswapd use-case, I am not concerned about the external memory
> > pressure source but the application hitting its own memory.high limit
> > and getting throttled.
> FTR, you can transform own memory.high into "external" pressure with a
> hierarchy such as
>
>   limit-group                   memory.high=3DN+margin memory.low=3D0
>   `- latency-sensitive-group    memory.low=3DN
>   `- regular-group              memory.low=3D0
>
> Would that ensure the latency targets?
>

My concern was not "whom to reclaim from" but it was "If I use
memory.high for reclaim, processes running in that memcg can hit
memory.high and get throttled". However Roman has reduced the window
where that can happen. Anyways I will send the next version after this
merge window closes.

Shakeel
