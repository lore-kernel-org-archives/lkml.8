Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1385C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A668722314
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpzcXXfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBOAEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:04:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34618 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBOAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:04:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id j16so10860948otl.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sc3eN5qofsLsz0odXUjAXrrQtgiKgF8fh8BjuXC2JWY=;
        b=OpzcXXfkrp7UFH3ZK85YabQ88elz5XA6OO/FPNgHZkCMW/kxBKWveumbeQjL/Xav1P
         ty+v6E4VESghdBWneJyGKa+igJclsO2a1+3vswIplonbl5S+KcdbSPQ9MRbF18yIlU2I
         dgnwRWUtwnZt3zXEGFDhMWGJh9u+i42Mcn1kCybLYVgeQiyhHacQ7TUUdM+4+U56jaqy
         d9tdMOE3jWZIvcihxvFqfE8ew7Nux205pr5nJLrYaZCkhW/yXfL3YjxoECuwcIckYZHm
         qFG5VsR/2Ok/XAzuGw700He0YIDDQ1KHzWkBVK+S3C0h01QsVZVUYaSQ4MPyi0ROMS+g
         hsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sc3eN5qofsLsz0odXUjAXrrQtgiKgF8fh8BjuXC2JWY=;
        b=ESbY+Xjlw76oZOkTaWcDzQPD65AXzpqiVNDPbBXmSZW/4l3IqnVfuBT5C4dT7FirhB
         aP7Ahx8Cft8GsrjLbYVtWKJAcoSsmhPKOxNajmGE/RY2PKe2oIZ6dNc6qRX/8D2ist6b
         aAJxaJvA2XXM0JfNihqDEkRmCEywOTfaPvwIgUx57wK1Zl/oNmp9IPr29NPq4//Y6irE
         batU9GMCMJ7uTYmnmz5Rn3AhHj0ugsomuWwrdvjV4eYDlmqGYVezl+PYCdqGwEJpAGOv
         /aPVqd7hGt0DjHCiPj31RCSujdjXGXCM2QyW7WlOb6boZON4YJ26R4yec8KsSuD+ZRb9
         76Nw==
X-Gm-Message-State: APjAAAW8VmFBqZM2AMrwKpnpSSjlsAVWcRyZOOF6cT5pOIPSvZxRnX3L
        Sjpr8M2P63Z533crXW4MCCLrJOLhmCCHhg0X7c31Og==
X-Google-Smtp-Source: APXvYqzAjeek3/OrstwZ6dIH3DyJHOy/lz/gOfLKkozBzmnuWgnJCL9xr1l1yC1jWdBYvGnudU8ofd4dG/8syTmByoQ=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr4317523otq.191.1581725071308;
 Fri, 14 Feb 2020 16:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
 <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com> <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com>
In-Reply-To: <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 16:04:20 -0800
Message-ID: <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Eric Dumazet <edumazet@google.com>
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

On Fri, Feb 14, 2020 at 3:12 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 2:48 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> >
> > I think in the current code if the association is skipped at
> > allocation time then the sock will remain unassociated for its
> > lifetime.
> >
> > Maybe we can add the association in the later stages but it seems like
> > it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
> > mem_cgroup_sk_alloc()"").
>
> Half TCP sockets are passive, so this means that 50% of TCP sockets
> won't be charged.
> (the socket cloning always happens from BH context)
>
> I think this deserves a comment in the changelog or documentation,
> otherwise some people might think
> using memcg will make them safe.

Thanks I will update the changelog. Also is inet_csk_accept() the
right place for delayed cgroup/memcg binding (if we decide to do
that). I am wondering if we can force charge the memcg during late
binding to cater the issue fixed in edbe69ef2c90f.

Shakeel
