Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE0C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260DE2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIfzL5aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHaKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:11:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:11:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so5224883ioo.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k+KQgm9kL6xww1fb1hoPu9g9hiRqIgB5Qw8A8UEDhE=;
        b=aIfzL5aqvj0wBTArEigzQuLx+zj75KaYySwRSY8/D4rEZysbo2YOlmDn+O1NMl8vDM
         wVvXXeDT8UIyWHwaxU3JDGMWQZEH/3qv7/ddqX1Y8Ge5N1GQk29uRiXZLFavn7Jtw1Yl
         4WIgcwjkYWw3jHV7fV2Q3fGerCWhDu/X80Me9Zf6PUYl++z4GD2hfwqfMegD1+t49mdi
         Y9MYAqysWoR9+12U/HG7VbDYTJ8SaCzdeelRfonWTCnvA9GISHk9Rw9qzcaoeuzdBw+i
         J8DwuTUifhuovofDUayp3GKiKl7bT9B6348vTH2bmq991ewpk7NviidcDXKTYUTirrLn
         t94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k+KQgm9kL6xww1fb1hoPu9g9hiRqIgB5Qw8A8UEDhE=;
        b=fWp+unj774ticx5OCvzc8G6fjTqQ6d4AsYMZoIfyZO7yoYyUFf++s3yM25j2Wsp2BO
         Iksw1xdHjjJUCOSRqG6nxIUc7ftUF7z8w51b2IaDK5/rMoc8LCWJlf/v62y54slQtKrz
         mH/2/tiruGTg7EEYDs55SqX07TucYDd9mSgkLe+Utb3Vy/shunof6y4iusCHNj70uIpr
         0klute1OK+KsKRv8oqky47/lpCVjfNSTeexkNXccmLEan46iJsQ1rYhNin/IIIVh+eQv
         0k39qwENXO9DrB+m4dbP4/0NkOyH0UUb+ao6DeW8X/+ZO6Imbgwv9qwaNKOG4V1RCc6v
         0ziQ==
X-Gm-Message-State: AOAM532Sf6+ZUBo8AkMjNRJW7yFpBEQ1yZRWWFwiUMMd+Kl4/R8uwZiQ
        CE0QZzd5H9TxVXksSFx4wbrI0yLzWCmYOShtzGIXlI6duwQ=
X-Google-Smtp-Source: ABdhPJxJ681pHHMHEeJmyAbxBqrvgyKgkzH+yeDo1dHdsAqBtZbasXyu/MHqugwTFLjVIviPZUxFwhhqdJr2qcTpt28=
X-Received: by 2002:a5e:8707:: with SMTP id y7mr653272ioj.49.1598868659544;
 Mon, 31 Aug 2020 03:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200819101157.12723-1-david@redhat.com> <20200819101157.12723-4-david@redhat.com>
In-Reply-To: <20200819101157.12723-4-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 31 Aug 2020 12:10:48 +0200
Message-ID: <CAM9Jb+gYu2eYh5jx1mFC2AxHh1=RVMK--bphJ1v1Y+sGV9iXYA@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] mm/memory_hotplug: simplify checking if all
 pages are isolated in offline_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages(). We no longer need walk_system_ram_range() and can
> call test_pages_isolated() directly.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6856702af68d9..f64478349148d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1384,17 +1384,6 @@ offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
>         return 0;
>  }
>
> -/*
> - * Check all pages in range, recorded as memory resource, are isolated.
> - */
> -static int
> -check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
> -                       void *data)
> -{
> -       return test_pages_isolated(start_pfn, start_pfn + nr_pages,
> -                                  MEMORY_OFFLINE);
> -}
> -
>  static int __init cmdline_parse_movable_node(char *p)
>  {
>         movable_node_enabled = true;
> @@ -1579,10 +1568,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>                         reason = "failure to dissolve huge pages";
>                         goto failed_removal_isolated;
>                 }
> -               /* check again */
> -               ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -                                           NULL, check_pages_isolated_cb);
> -       } while (ret);
> +       } while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
>
>         /* Ok, all of our target is isolated.
>            We cannot do rollback at this point. */
> --
> 2.26.2

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
