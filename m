Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEDC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCA724653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyP5fnk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBZUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:02:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38536 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBZUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:02:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so652005oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYPZLk9fblhfI7X9fM3xbDPsnJvljmxVNytskCU+vlA=;
        b=UyP5fnk2tcq/pPIf8UiuwxkR5072gZy0q/BJ2uagssjQU8qPl2XlFZef/INcAqm/G/
         AIzv7Fc+eTguGy7/felWPoIFpMQfSwUovQC59vXMK3nK9Vld9VdxSJVDicbvgWOoN9Hc
         lp6Ttr3B2PC+IVX+BU48YAaEoSpQUtEPZEVOyu252uIIjzfQutowIm9kF5gwglA+Mga6
         WWmBOfvwOmDJ4tDldTih3mXrVaeidJaV15tBRGEoVRZ4mnxtChsEM3sWHWTcRg38Tv9P
         1liVai5ZMM8MDyDZbBiD/OsEkAEtf+9uLwxyaxcV1jCFl7V2wMCKotF0lyMmLkNbF9cb
         35sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYPZLk9fblhfI7X9fM3xbDPsnJvljmxVNytskCU+vlA=;
        b=nPXjBftR4MV5rQAv3b/8zykD6HBS7JQ6FVlM1/XtwygS4t+iCCiRSLAKN+pZxzXNJ9
         uUV+tfNyrQkDe+Zdz1l5P8ipq0u4y0n8tVhSzhChios+W6vcshbCcVlIpENbKl2HLVjY
         oBBJu+gs7PK8ARflH5DOD8/wv/oFRrB2loj85y/BwE/uneZQp1xg6L6JwiqF1QWEMYUJ
         oBHJ5MAJdFMX/tqwoQJewHz87lkrJznkF+e5N1E7DKaXOAe08FEk87OppluCuQf5KW6n
         pj5MI1qekbkbPFw40i0bHtWV21P0+BoKcmOm4We0E7wcmQZxL2a5AqErrrPC5ot3QLwn
         N5wQ==
X-Gm-Message-State: APjAAAVQlW4OHBQfQCwRsIeyZcF0D/PahPyWC+ekeOmUfwWBw+gsNzkn
        egjh5kAnpIgSwj6zPCe9XbOyUCNiZfrvqGj8YbcD9w==
X-Google-Smtp-Source: APXvYqwWb32V/0K0pdQElKXeofe1I4diMq4dFnLk2SNlKDa4ZAncUqcmsHgASgI17lp4ZQoieYvDqTld7vL+VECLrE4=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr356628otq.191.1582747362553;
 Wed, 26 Feb 2020 12:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221014604.126118-1-shakeelb@google.com> <20200226.110749.77396284962321904.davem@davemloft.net>
In-Reply-To: <20200226.110749.77396284962321904.davem@davemloft.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 12:02:31 -0800
Message-ID: <CALvZod5TsauERhaCqa1OZp4FaX4nq_UBL84=siESEG=Uk4LYuQ@mail.gmail.com>
Subject: Re: [PATCH v3] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:07 AM David Miller <davem@davemloft.net> wrote:
>
> From: Shakeel Butt <shakeelb@google.com>
> Date: Thu, 20 Feb 2020 17:46:04 -0800
>
> > We are testing network memory accounting in our setup and noticed
> > inconsistent network memory usage and often unrelated cgroups network
> > usage correlates with testing workload. On further inspection, it
> > seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> > IRQ context specially for cgroup v1.
> >
> > mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in IRQ context
> > and kind of assumes that this can only happen from sk_clone_lock()
> > and the source sock object has already associated cgroup. However in
> > cgroup v1, where network memory accounting is opt-in, the source sock
> > can be unassociated with any cgroup and the new cloned sock can get
> > associated with unrelated interrupted cgroup.
> >
> > Cgroup v2 can also suffer if the source sock object was created by
> > process in the root cgroup or if sk_alloc() is called in IRQ context.
> > The fix is to just do nothing in interrupt.
> >
> > WARNING: Please note that about half of the TCP sockets are allocated
> > from the IRQ context, so, memory used by such sockets will not be
> > accouted by the memcg.
>
> Then if we do this then we have to have some kind of subsequent change
> to attach these sockets to the correct cgroup, right?

Currently we can potentially charge wrong cgroup. With this patch that
will be fixed but potentially half of sockets remain unaccounted. I
have a followup (incomplete) patch [1] to fix that. I will send the
next version soon.

[1] https://lore.kernel.org/linux-mm/20200222010456.40635-1-shakeelb@google.com/
