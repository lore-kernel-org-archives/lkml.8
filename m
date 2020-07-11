Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24816C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED31B2078D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI+5RvQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGKDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGKDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:25:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D8C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:25:00 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g139so4255687lfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CSoNKqf2/F0Tp9hw/Q3tOqmnKdqJohhTGwykA5078E=;
        b=UI+5RvQlJ7Y4QrAO5eQmJs5SxFTK/evUap+folss4m3gXvNyiErzjs9cgqLbt1+WBw
         jFy/83zKBi7lPpxgS651R89gffrCvA3YIJYDUiy4T5l8u91TUmrWw6Du5owAiBX1V5nF
         M+QeZqFW4xn2glgMfN9eg/zIoq7cq38ThTMTnNkpNmICH6KQEiiO5aRdFkfY2mkwgceQ
         oHiWi8S0q3tMRPAZmvpcTtzIWvwGh09/4B29R7CSsNMu4rWnN8kjhfojUi3aVnBfwBkX
         qqTGf+nMWjW4wtY3Xq1+aAGAQNQ6Rqs0JZeaWIEWgI59Mf+0Kpinv/MU76AihdXgclva
         F1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CSoNKqf2/F0Tp9hw/Q3tOqmnKdqJohhTGwykA5078E=;
        b=dL0hpyTrSnRDy727kgZehl07zfRcZ9RO7Gou/hz0Q/N/4z9XFxKx9VmO06ZVHA+vt8
         Xqn3XFqacApnqn2DE+Zo2V/JciwUCBYIHS3P65uCuJS7/Yo7WqA/S8jbGQJW4OBAkyk/
         BRRfICBf7+NtKz7JOQiykOD+CChiGuB/m7tnopi5W3BBdG7cr5bBGNN70/lLdmQHi03A
         R55+3XHHQiGQxb3HeSkBLmkHdzCYL/Aal2iA4vnvp9xo2zchYdnB2x8I79MdY6jmd+GD
         FX5q8i7DIC6h4B7eneNexASKM2OvHLASOz7wtpeuSxQ1BGV3epriJG62KsLpkOnQaB/n
         AnTQ==
X-Gm-Message-State: AOAM532ZaXa+VRvId34EvLBdtLqDX/x4HNIeWpE2qZ31ecuIZ9ZhSPJo
        ogFtav9yQFcLlngbPVPWSrXXFCq8MUBPvhxC0qhDCA==
X-Google-Smtp-Source: ABdhPJy0KtX0wD02BqHvdV4WP9jlGiyLFJKoXzUPvHEy9ODhEGagwn6D7dnj57cxdy/l3dIUlSkjrETKVulpVw/1HWQ=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr44598950lfq.3.1594437899004;
 Fri, 10 Jul 2020 20:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200711011459.1159929-1-shakeelb@google.com> <20200711023151.GA388137@carbon.lan>
In-Reply-To: <20200711023151.GA388137@carbon.lan>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jul 2020 20:24:47 -0700
Message-ID: <CALvZod7vYmGBdfsJFxR5ZN_Ot_Qe7v2kHHiMt_+VXKPbhWZqqw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: consistent update to pgrefill
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 7:32 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jul 10, 2020 at 06:14:59PM -0700, Shakeel Butt wrote:
> > The vmstat pgrefill is useful together with pgscan and pgsteal stats to
> > measure the reclaim efficiency. However vmstat's pgrefill is not updated
> > consistently at system level. It gets updated for both global and memcg
> > reclaim however pgscan and pgsteal are updated for only global reclaim.
> > So, update pgrefill only for global reclaim. If someone is interested in
> > the stats representing both system level as well as memcg level reclaim,
> > then consult the root memcg's memory.stat instead of /proc/vmstat.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> So you went into the opposite direction from the "previous version"
> ( https://lkml.org/lkml/2020/5/7/1464 ) ?
>

Yes because we already had those stats in the root memcg and exposing
root memcg's memory.stat resolved the issue.

> Acked-by: Roman Gushchin <guro@fb.com>

Thanks a lot.
