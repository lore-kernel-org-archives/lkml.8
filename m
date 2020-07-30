Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3594DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053D222B43
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZg3x3E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgG3EVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3EVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:21:45 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FFC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:21:45 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so26872278iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xpfl3EgxCfkX2czZsyELOLTTm2Qpx8o0HHjudwK3iQ=;
        b=PZg3x3E96FLpVfIP4mXsw6BJZa4kPE724pl4xDKJ762RhlwGzZDB/XJH0kA7tI9NJk
         0ueTo6zqLNzsEUaORTov6c7u0Uq/ToqZ8Yea7HoEB9fpHbs/5BM2hiimDiS/9POw6Kf6
         oFw7JsCzJJjkwiLmiwwtgXzBOmuELSmpECDPP/7dipETJB4Wg58tR6d2cJU+uCEFRDQ5
         WG/zSQGPATkSf89kIXWxTZPldDV3JuLOJ5SrLl53a//S0Fp3w35L6VmWkMFf0mnQJQtz
         +CL/hxthboihNtBZXjHk4nzk4xKqvGnGejHab4KdvUR9nom+ka59A8bDCT6GuoLdEo/+
         PVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xpfl3EgxCfkX2czZsyELOLTTm2Qpx8o0HHjudwK3iQ=;
        b=Lkk7+C6sUGvhLGIjb0t/vlR9x542xbcjE5xfPhC2R3ZtdF/VWu73uArUpGSdCk5Xcr
         4hrlxg6km+c6V83/ZlmD01Fj3WSk2cNOQJnAP8crXG+6+J9KaSpvBYVD7rHJoDCoVqES
         8yXpUIKwv83+hO/8qrB/APfpNDR+ueG3XisbBzDYZaoAW2rwGCIMAIQJJVnRij4XUVxA
         O7ZlhwBInUgmizfU8CFP6KYZRqnQdpt65+0T30Vio53dtbdjikOfjsvdINZ+e/WkUtfC
         nViMdnAEiO+HYLrTbNyNruMM2iaZ9kME0B6aHe5YigTIz6JIGCtcNAcPQCAdULkD4M5A
         Mp+A==
X-Gm-Message-State: AOAM533mb+HzqwmgV63rDj91I96q/GdUDcqSEPCSkQvUPlI/e6HVP9on
        t7q3W7BDKiKFET0er4N79acgi1i6Y96qC7ZkA05v3olEftY=
X-Google-Smtp-Source: ABdhPJykIKJCHIXweVbFX5NqFGgm+dgBMuMyqp12O5YWh5nSx5UmBH6/j6/5tCLa+7uUqLnQcmkw5jGVyHRRpBmNCtw=
X-Received: by 2002:a02:6066:: with SMTP id d38mr1479683jaf.105.1596082904664;
 Wed, 29 Jul 2020 21:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200630142639.22770-1-david@redhat.com> <20200630142639.22770-3-david@redhat.com>
In-Reply-To: <20200630142639.22770-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 30 Jul 2020 06:21:33 +0200
Message-ID: <CAM9Jb+gGhg9umBKZRbkCDAAgqi+4VqMzN0BZ5v0hVPoR7gdhvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now, if we have two isolations racing, we might trigger the
> WARN_ON_ONCE() and to dump_page(NULL), dereferencing NULL. Let's just
> return directly.
>
> In the future, we might want to report -EAGAIN to the caller instead, as
> this could indicate a temporary isolation failure only.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f6d07c5f0d34d..553b49a34cf71 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -29,10 +29,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>         /*
>          * We assume the caller intended to SET migrate type to isolate.
>          * If it is already set, then someone else must have raced and
> -        * set it before us.  Return -EBUSY
> +        * set it before us.
>          */
> -       if (is_migrate_isolate_page(page))
> -               goto out;
> +       if (is_migrate_isolate_page(page)) {
> +               spin_unlock_irqrestore(&zone->lock, flags);
> +               return -EBUSY;
> +       }
>
>         /*
>          * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.26.2
>
>
