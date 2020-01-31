Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2586C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F7A20663
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfdjNZQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgAaRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:23:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46816 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgAaRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:23:08 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so7228373otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3eHMCz/DL6XKCObRC8HT/xmU629kDpPS8BllHn4ZIY=;
        b=RfdjNZQ8bvVaoDW2tBkd8ObQ3Df9woPqcG7rD/P+yVDUgwHYVdnqTf4wS4vGpje/oC
         52ZUxHE8y1eWjgokzZYU5XyHdbFpYVeaRdRV563u/ybcsOLHxvX2BCbHswAXRSSNQDR9
         tWA3HIDcws9ikr3dLiqNxpTZBgowoMcAThnMmpzS6zSbTO5VEIBYBr1Jad9GM4hwOg3I
         DMYgKPOLMOH3+LKOVMgUewrLau/1PnSh76EwG0Mz0zSt8T/lBsDUVK9WAy3SXX2tuW2+
         oXnXx1JsfIw60HJW8QNnBt2Nt2IshNfYLAMoCxPm66143Rh2iLzmTAv+SwRmWam6KxfT
         qTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3eHMCz/DL6XKCObRC8HT/xmU629kDpPS8BllHn4ZIY=;
        b=TJMN68out+vUUYoiFuLcOVBwx6TjQOrV7DTRI53dJ/ub0esBghxDJ6YYmKnC5ObfWr
         7LQY+w6vUV39TiQb4/rB5ySWlq5IBaH6k9ogg6nDu1uby4JdytUTUmcAaPmk6qNBx6sb
         y5SYqneMidJRwnjnnkmhTADl3iwNikV+g7fJJh+VYDJCYXiCxv9MExGmzDZH8oSZ0aez
         65Lt+f5vkw8+tL807CgjU1UiFQqlDECMzxwXsVzgDt7g99NHGlDz/OF5B/XHCT+DFFRE
         e6k6Kz2GnOhyhOQDnw96JF9HtpUR5cAC0pxTC+5XdyAs7yAFMeexr7xJYkoqLu03A64r
         zcAg==
X-Gm-Message-State: APjAAAVi8VRm545hKwL6Dlur/tH0Va1VCsdMJ7a/UJW2lasDIYQv+qC9
        4AFGZnH6PWGS+Y72fBCQVzzVtCW/0oGBhHPl+cah6Q==
X-Google-Smtp-Source: APXvYqztAPaGUr9zCgUHGpLpgenSB+fGB0gVHJN1+1lSaDoBA4wWnW6i/5S0y4QNkI/2168d8JE9oH99Yij15pqQkcg=
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr8900368oto.30.1580491386018;
 Fri, 31 Jan 2020 09:23:06 -0800 (PST)
MIME-Version: 1.0
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com> <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz> <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
 <20200131160151.GB4520@dhcp22.suse.cz> <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
In-Reply-To: <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 31 Jan 2020 09:22:55 -0800
Message-ID: <CALvZod6H4thR6_Ky9Qhj4+U2S7i94ed6adpTXorPgZawkiAcGA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 8:09 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> mm: Allocate shrinker_map on appropriate NUMA node
>
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>
> Despite shrinker_map may be touched from any cpu
> (e.g., a bit there may be set by a task running
> everywhere); kswapd is always bound to specific
> node. So, we will allocate shrinker_map from
> related NUMA node to respect its NUMA locality.
> Also, this follows generic way we use for allocation
> memcg's per-node data.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
