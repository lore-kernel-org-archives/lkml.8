Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FA3C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34B0206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqvt+EJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDIGxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:53:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgDIGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:53:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id i10so4290496wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9PzzpDG4h7junY1ixG2pd2f9fKjZJKEYtrgYcTo//Y=;
        b=aqvt+EJ6pRCu2iMeDVQQAKZB1yOW/KlH+6Tw65X4qEIwfbXOqsciX6oOI1Zyzh4bmM
         xjpt+AapVuFOw2NYSTOsODgACD2fNwynUnE9W8SX7oYU0RudU9KlAswHd4p9LhQ8ckK8
         VdIOoL1qo8HYOBKKoMHCIoSVVXGI/p3+3eIw3j5MeJ+FfAyx6osJT+8Q3fHIj3MZm+Ce
         PUF4zgyvGoclR5KudvO/CUR1dW2OHvZxhLZP/unAQBCuzBNOtJxPj6iW561aiKJrKfKk
         f/b20FTbk6dakM7dd/zRuROZ+n53irM03d1EuTiStjOdidX8kZO2G6lfRtvvh+a5m3PM
         D/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9PzzpDG4h7junY1ixG2pd2f9fKjZJKEYtrgYcTo//Y=;
        b=ab8KjuV7069eCf7xZVstsnSQ/YIQw+JCRX/1AlmNCsr5VxVNDrTjEiu6np+hLSUX/R
         fCLpmYLvycJkAL18BrUCx3mGgua9frZ83RosrDGTSA6TaDMTrID4xxUzAibzieYpbCk2
         mjRHQdVpvmDJ1DVEKp285emfRbf/IpImMDanr39h1eVbVKAYUen9f6klX0Pqe2JaHv8a
         VqzJHSWbQ6wlbDE2ZxPZTNIR05m7sUgZSqVMvMwIKXy3nm/x7vYJ0+lZVhQpumIdDh0Y
         Cl86+rE+WO30k67veiRwfbDoN02zW9sIoO08CVqefI08sZDCXoK3KwU5gM8LQINABT6x
         YTEA==
X-Gm-Message-State: AGi0PuZAnYHjadWb+klO1DSD+TwuKoZL/quREPqWL/pmNXaoSsyF/Haf
        ckTvwPm9EFXP/UcK9QKqKIYHynd5TUGwBQjQqNI=
X-Google-Smtp-Source: APiQypIEkLk4SIaqJp7AwmJjks3M/Fwjj35V75pGD46FliQMBDdYPJciiX/s0JpPTA7WmzT6dkR6If6P7hsqsyReD4A=
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr12210916wrx.196.1586415215105;
 Wed, 08 Apr 2020 23:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <02998bd4-0b82-2f15-2570-f86130304d1e@infradead.org>
In-Reply-To: <02998bd4-0b82-2f15-2570-f86130304d1e@infradead.org>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 9 Apr 2020 08:53:24 +0200
Message-ID: <CAM9Jb+jH7GvDyBjgPbOgOV0mAW0Zj9cAJCiR6ib4jHVSMcs+_w@mail.gmail.com>
Subject: Re: [PATCH -next] mm: page_alloc: fix kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add description of function parameter 'mt' to fix kernel-doc warning:
>
> ../mm/page_alloc.c:3246: warning: Function parameter or member 'mt' not described in '__putback_isolated_page'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  mm/page_alloc.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20200407.orig/mm/page_alloc.c
> +++ linux-next-20200407/mm/page_alloc.c
> @@ -3238,6 +3238,7 @@ int __isolate_free_page(struct page *pag
>   * __putback_isolated_page - Return a now-isolated page back where we got it
>   * @page: Page that was isolated
>   * @order: Order of the isolated page
> + * @mt: The page's pageblock's migratetype
>   *
>   * This function is meant to return a page pulled from the free lists via
>   * __isolate_free_page back to the free lists they were pulled from.

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
