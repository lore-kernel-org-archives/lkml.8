Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF15C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC66520716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gT/XthbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgICOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgICOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:22:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2DCC061A15
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:44:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n22so2734996edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsPnpLathKjXprbkqY+YKBNSJFUri0XqOdwMusVjvXU=;
        b=gT/XthbVd8CL1/XQCWf2oVysDBfnhEQ2b93QTis/AEooCJw9Ac3pkjj2Sl/rWyMgvZ
         0Vyf1iHaeFVj7xVcqYSEEn8LH0GUDNm81bHwVAf011MvPvb34vUAm7476fTz41Ks6r4g
         c04+FoDx3Zi5UjAxseKWfeLBnfMFmr3gw5/4SIlQYeY1/oMpkdtEL+M1Btf6Plsp3xz0
         SaSm3YxrDJPpuG8IwiX1Iw5nkerOknoezzUiLAPOLfCEm6WVBV5NvEvKIdmRFf709593
         GlIt9Ut4aXS5TKdKulFyXU1mdTegLQQJc3JXQ4D/KkbT+LOw5OmA5y+BzIFClqeSZMK8
         8ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsPnpLathKjXprbkqY+YKBNSJFUri0XqOdwMusVjvXU=;
        b=MYS5qXPUgwyxf9hQhu1WWN0KJLiZ4IEOY+qMCh8TKnevKDQwRKPYIaorEjfk0VEIQV
         RyIB9upi5xr6s3g2JVaZ9tbVPkARwVQJQSTg6qF0WLJsz4TfVyUHPAR7841d9ZwyNZHQ
         Tw+ktajnD/+NJOTjyhcnTNq0v6T3ADKQFf9oh6k1dYNonKQypSsano6//QrUmrkFip75
         TjbxOFgFEMg3iBNo9iM9+HRaC9eXd5VERTzVGHYWBoEP1MOoEzoUfzO5Q7+U4VPvRM9f
         yeOa9H9ddxTxrxxJ9tfuL0OxxjrPMQPFrhKFJjFhXNNuMHNkGI3buOnOYv/Cr1O3TG2I
         AtCg==
X-Gm-Message-State: AOAM532jwG+7XJFHZ8WR+B+ZVVulp6YEUBw1Ofeyf+aVP3wMrc3rf0Va
        YEYYFFisjxe10Ufeh1sPmXxX0W2R8WjB0VBK1JAx+w==
X-Google-Smtp-Source: ABdhPJwHLlMV4LeAnjwm5fA6g1O/lUEdcG7wQTFuZXrfgiz8luar5x9cBzY0V1waO35RDKFjCV2vi/FHzdtLgzYO5tg=
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr2917778edx.346.1599140643210;
 Thu, 03 Sep 2020 06:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com> <20200903070733.GO4617@dhcp22.suse.cz>
In-Reply-To: <20200903070733.GO4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Sep 2020 09:43:27 -0400
Message-ID: <CA+CK2bDqwFoeq_-Eji3oW4EycZkg-NorDCCi4Q4MeyagqVbPEQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal, I will add your comments.

Pasha

On Thu, Sep 3, 2020 at 3:07 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 01-09-20 08:46:15, Pavel Tatashin wrote:
> [...]
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index e9d5ab5d3ca0..d6d54922bfce 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1575,6 +1575,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
> >               /* check again */
> >               ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> >                                           NULL, check_pages_isolated_cb);
> > +             /*
> > +              * per-cpu pages are drained in start_isolate_page_range, but if
> > +              * there are still pages that are not free, make sure that we
> > +              * drain again, because when we isolated range we might
> > +              * have raced with another thread that was adding pages to
> > +              * pcp list.
>
> I would also add
>                  * Forward progress should be still guaranteed because
>                  * pages on the pcp list can only belong to MOVABLE_ZONE
>                  * because has_unmovable_pages explicitly checks for
>                  * PageBuddy on freed pages on other zones.
> > +              */
> > +             if (ret)
> > +                     drain_all_pages(zone);
> >       } while (ret);
> >
> >       /* Ok, all of our target is isolated.
> > --
> > 2.25.1
> >
>
> --
> Michal Hocko
> SUSE Labs
