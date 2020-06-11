Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF0B2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4PrpNyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFKCV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:21:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF3C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:21:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so5033616ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 19:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qdV7kTEUj8MO2b1jDlzL2L6E3oB0hXT8qJRrm2qFQc=;
        b=c4PrpNydhvWfQH0v9XSMys+WCbroecCmby1mCjkKRiyuzxYR9A5GEddYQlO9jlVl/9
         PYELc1qFlanvSppAc2NDWPTFm73nOZ31dHzsD4r/hUfzhq6gDP1V+T1HNNWZ0VDboniz
         UzzQjXCduN4jtMNG5Uopb/MknTZZBJVzkwaSw4tZ2sMIZ7Fwl+/BkSNzHp2gLh4WzLsp
         utTQfkyV/0vVFWCeF4wjWR7qILW2RrzbqMNVrugPeucUAFSE72UgwX5yEapBqt6k0V23
         upNkRjq0V/feFjXxZkuVo6Xhrw4u6Vohkf/vucM36axE7rJ6fDlHVUnatnd4Y7hqeKvX
         6WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qdV7kTEUj8MO2b1jDlzL2L6E3oB0hXT8qJRrm2qFQc=;
        b=eC1OjvbnR4q0GaazdwicHjm76WUEGNuWFgpd7V3+Va9FGwhsaEhwjOghsZCdmf4rlc
         xFXxp/TSX4pDSJz10DwDHShWX8OJ3Ffi943NPsLk0kTMFhon3Qn/4/4X+6DrIAKQ6Sa4
         RGzbYixcsWbuDWzIaJyoJdIP2fDmZeaAHKPvReZshJ3h7faL+ZSVjTM5jbbn9kcY2Vi3
         iNHfwhd4LDa6TurSmRxCdhFNiOnUKvZfsLL6NgLDROnwprPg35UIvE6z+zIbIrRnYDHQ
         PdgiUFr+f1uJ35sIBF9ITlGR17MNX1nOyY2VJ3CaFn2FX+EPQuomrJp731R3LFR4PLXS
         RA5w==
X-Gm-Message-State: AOAM533DK5olSo42dp+++nUOMfUJvbwfsGDGPLC4ZE0hNuXwV1A20/oK
        u2yXKl+64xWcggeS8y68NXWrqkYiMvIVBjVIVe0ffg==
X-Google-Smtp-Source: ABdhPJyJ6thR5cdQysfqBhuFXOJjtSaKK4QLT87l9YsZ6BXGAe7BkWYvSbzgNy3CzWa/2SpSjyJwk/1kLXvtppfKx4w=
X-Received: by 2002:a05:651c:38b:: with SMTP id e11mr2003236ljp.415.1591842113338;
 Wed, 10 Jun 2020 19:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200302193630.68771-1-minchan@kernel.org> <20200302193630.68771-8-minchan@kernel.org>
In-Reply-To: <20200302193630.68771-8-minchan@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 11 Jun 2020 04:21:27 +0200
Message-ID: <CAG48ez1WfUN2eZyiQL0thsO3cYW6TgC-NzEj=gP2KfkJ7BdK=Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sj38.park@gmail.com, Minchan Kim <minchan@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 8:36 PM Minchan Kim <minchan@kernel.org> wrote:
> From: Oleksandr Natalenko <oleksandr@redhat.com>
>
> It all began with the fact that KSM works only on memory that is marked
> by madvise(). And the only way to get around that is to either:
[...]
> To overcome this restriction, lets employ a new remote madvise API. This
> can be used by some small userspace helper daemon that will do auto-KSM
> job for us.
>
> I think of two major consumers of remote KSM hints:
[...]
>   * heavy applications, that can be run in multiple instances, not
>     limited to opensource ones like Firefox, but also those that cannot be
>     modified since they are binary-only and, maybe, statically linked.

Just as a note, since you're mentioning Firefox as a usecase: Memory
deduplication between browser renderers creates new side channels and
is a questionable idea from a security standpoint. Memory
deduplication is (mostly) fine if either all involved processes are
trusted or no involved processes contain secrets, but browsers usually
run tons of untrusted code while at the same time containing lots of
valuable secrets.
