Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA8AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A10720721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNIbu+Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgAKA1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:27:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46059 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgAKA1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:27:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so3457423oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/gZ8+YmCdyaB0LsPIOJsTXh1S5MOPke76VouPArXYA=;
        b=eNIbu+Unv7jQV7eEVof+W8r6x+EpEkEP6HLMuArZHYFk5IZey1lNEbYorTiYznFfXW
         Dhv3A0MBWzjg32jPzZweiSelZ6T1m5ddK5Q4m6ib6fay71vH8KZ+UG2pD1ip+GhqwQkb
         Abm0uDVdav4i4C2XgNGGk7Ql8cQCW0uTWxBJles36SDz2C+jlSWR4enz0F+snPKPRVm4
         BdJXMA2DubS6zajxK/K8wwUlf2fTjbInuIa/VyNGuv+6aT0+E/u/MTEPKM1wQOabaL7h
         Lcf5Bd/waIaxQclCtVN8rkx3lLkvJVWXWjwZDyqqckvjJ3N2j7ZhvqQzUlUY8rFyi3tf
         Fgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/gZ8+YmCdyaB0LsPIOJsTXh1S5MOPke76VouPArXYA=;
        b=j1O4/1MdJ8IH+Qvgc78N50evHxGLpWxHMtF/m3UKcPQdXP8z3j+Rk/X9yrxmSr4Wgr
         pQfdTYhVC0qXIyrAE1zXBvNKQzEhxirB7ioyDul6adf9/LzA/ljhwY5kdnK5HbSzjpU2
         7J3RkDAABU45a/qMul0P3tWuK+FP7hyvUkKkl32s1VVL2ovQwkSsyuc+9pKkYpfbB/01
         Yt4xrDk+TgJqTYd3neCOxVxQMWyC3GUy0eQ3r4FbpuVl4QpkzXZhSGl7P5eIG2gfFx74
         RkoYqC+GifJSFfTXVQFJWHJWHogF7hPZnOLj4Oiu3eN3gijvxtU74olOE/6iBedo0aKo
         w4WA==
X-Gm-Message-State: APjAAAWk6ek7LvBVq2EJbtJbcbM6FZqcv87yfDs/HIWt8tNjs394Z7lP
        hWkiRmYCFa/pl61LKT9IzTBBuvZxe/VXmcHG+o+FWQ==
X-Google-Smtp-Source: APXvYqy/sWM+PzWK65Xe3fa0nvjGpP9Am72o94boWr2hCvr9F/yRRVdZ9q2K21iU+B5tIUrcFRhzpKsCc5K9wGyojPY=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr4249051oie.144.1578702449833;
 Fri, 10 Jan 2020 16:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-5-guro@fb.com>
In-Reply-To: <20200109202659.752357-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:27:18 -0800
Message-ID: <CALvZod7KfMposazfAYFUakmF0D---B-UxbGskAfHEE5KUSd_ig@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: kmem: switch to nr_pages in (__)memcg_kmem_charge_memcg()
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
> These functions are charging the given number of kernel pages to the
> given memory cgroup. The number doesn't have to be a power of two.
> Let's make them to take the unsigned int nr_pages as an argument
> instead of the page order.
>
> It makes them look consistent with the corresponding uncharge
> functions and functions like: mem_cgroup_charge_skmem(memcg, nr_pages).
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
