Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C35EC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281C2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUJ1Crbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgAKAcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:32:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40779 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgAKAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:32:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id c77so3491434oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qkq+ill4mw21asn1jGzrbHev354Cv7yYYkumxsmn7qE=;
        b=SUJ1Crbxo+JhreidikZr+xD56eG5N3ZUkKE+PxTaLrgla9kzwhY+qAFb6OSYxKacXW
         Y8cdbDnPT4fXD3uubkkR/Iz/r0rGeyVyHvZKM9zhnUkZsKlb7UTtl3UBD3aRUREcV8S+
         djmybLR6D9HhzFYcBNbKvdAMtyPuqCvWEjGXEfi+HJNpfe3Fnzbuh9hUGukZJLAo6lSL
         coK8siBnGv3FWFm/bymuXY+PNqOdwQHPjpmC1jpVERSiYghUparhkbG6EvMWh+6f14mv
         VYMXt+lZobQCtQrabG3UhrOL8T2yOzm03BwHqTzcVrDlAmirvOug7tPjFRYOhaiKsFXy
         8MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qkq+ill4mw21asn1jGzrbHev354Cv7yYYkumxsmn7qE=;
        b=iTeO5+nyHOPR9Lcsrr/gdni/Jor/Csai8dHMMwCuXOweDMi6+itmaP/rXtdlYCXvkF
         RGTX3oCMePuQW3j4wab0RW5oPQa4kQcgvc4gf1L10exW5Hp0xJHmH9IuwAKcc+IRUgTX
         nPgkoEBKW/42GOzTuXjAqRNP1LlJ9fq9KsW3K+Y/Shyky86kzG4FXIDiW73yNjoKzNqw
         F8J+k83y6ffwnSgSeEPFaKZGtyFQqH0OGwtXqX0Vw528QoFOlqwJ1ty1S4YDgwkpFmU6
         C3dRcB2XOw+oCQ/nJUTQhWtcotsSVy0+OkiVHE2md0B9PFrXzDquLoSSkM+CtAj9HehS
         BtmA==
X-Gm-Message-State: APjAAAXxhkazVjkH/g3umSNvmGHMWCaG4VBWcCbaucm2MoA8MbuClpsT
        HUDQzLJ7gb8MJ8xnjgXRRxB2/PslPfoD9YBBT5SipQ==
X-Google-Smtp-Source: APXvYqwiufQpfXRvqWewxCo42gqUPUH4TuDJVGH1esybfgoL9WaMY9PMa1zee1+mx39ateymDISSHZKn/8oZhfrJs0M=
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr4314680oih.79.1578702770015;
 Fri, 10 Jan 2020 16:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-7-guro@fb.com>
In-Reply-To: <20200109202659.752357-7-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:32:38 -0800
Message-ID: <CALvZod6nXeGec1djkd_u6NoaatX3b_cVMuxqwSZRCvNFUW7ZWw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: kmem: rename (__)memcg_kmem_(un)charge_memcg()
 to __memcg_kmem_(un)charge()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> Drop the _memcg suffix from (__)memcg_kmem_(un)charge functions.
> It's shorter and more obvious.
>
> These are the most basic functions which are just (un)charging the
> given cgroup with the given amount of pages.
>
> Also fix up the corresponding comments.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
