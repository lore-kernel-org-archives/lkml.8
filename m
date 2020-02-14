Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EDAC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7T9OJLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgBNVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:00:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36149 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgBNVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:00:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so10475412otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DMurB2EcIliipQAm/Fyz3iYQa8JFCY3mjh5m99SUJQ=;
        b=K7T9OJLg4Rd6RuoeGZfJRBGbV7nSZMbJ5Vfkg9phnHv4jBT/9bBmEuX7Ysbb7zSCfq
         2s+cMkr/gk9UaS2jQgaY4MoqrLuxyZxKIBNhGOf2D64qdFVNqOKzpV14sAYT0iHNnM4l
         lyzdxLTmt1uf3N/8m89DK6/febbiFEDywSo/UGz5XRmKsA8ecZHAr6YVgqG/2c8L9Ie2
         lmVDfCT4+tNZ14mSY+CSv1w+C5mhumA18t6gnUWBqmdmA91FK6d6fbiUWXJCtFdm0RNG
         YnUxig7JD1deO+/D/aY8AFrxQmrDEkq5L6qeijk4AHlMztzl8h84OP5LzX5rK/NmK5f/
         fqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DMurB2EcIliipQAm/Fyz3iYQa8JFCY3mjh5m99SUJQ=;
        b=oM9Djd+h3ZfVPw2PSPDQMJl4ZbewAjF9EYUYzgN0I2hnvRLsrIh0FnjZgQEWaCbu6w
         YgfZx6fV28cZp5qdYTS2Uz13Wzt1Rfj/PVTf3duEdjWyYBwTXZqAkG62Rdd4OV9RAQk/
         FE1GWTejE5HQSiObevIA2puOLDjXETVQGiQ/nUnGaEz/vch8OIVQm/njqKs5JSgPVgLz
         wwNfpGwkqvNmcHG4XkEJEjgAkkFCuR6L5yPaHUUk+PUHCgKIW/ot2Balm4ljig7KYYXA
         UZKJUHbRQZZ0QWVEI/8iCf0VEGyIab5clrRwPJVkUuYGRXxbM15FBDbMnXqdOW17OeGW
         o4/A==
X-Gm-Message-State: APjAAAX2sVRCwTLtDo8htr2VibFSwQL1YhBRcFjtij6iOMxlxilekcLY
        dYDmRgElqc9cz1/09opPzpDxHk5NAVlRiMCbwFP1Aw==
X-Google-Smtp-Source: APXvYqwVLssaKbrmX/2dVzzlIfrCtRMpETQMFACNwFjNeW45I2jNMr2nyglMTtsq4MTz7pBu11KLlg1FFHUUKP9tKjM=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr3941956ota.127.1581714042131;
 Fri, 14 Feb 2020 13:00:42 -0800 (PST)
MIME-Version: 1.0
References: <7ff9e944-1c6c-f7c1-d812-e12817c7a317@oracle.com> <20200214204544.231482-1-almasrymina@google.com>
In-Reply-To: <20200214204544.231482-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 14 Feb 2020 13:00:31 -0800
Message-ID: <CAHS8izMjyLzCsSga59dE+zDC3sLBuA=_u4EtsShN+EZQ1EQitw@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: fix CONFIG_CGROUP_HUGETLB ifdefs
To:     linux-mm@kvack.org, linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:46 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Fixes an #ifdef bug in the patch referred to below that was
> causing a build error when CONFIG_DEBUG_VM &&
> !CONFIG_CCGROUP_HUGETLB.
>
> Fixes: b5f16a533ce8a ("hugetlb: support file_region coalescing again")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/hugetlb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ee6d262fe6ac0..95d34c58981d2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -289,7 +289,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
>  #endif
>  }
>
> -#ifdef CONFIG_DEBUG_VM
> +#if defined(CONFIG_DEBUG_VM) && defined(CONFIG_CGROUP_HUGETLB)
>  static void dump_resv_map(struct resv_map *resv)
>  {
>         struct list_head *head = &resv->regions;
> @@ -325,6 +325,10 @@ static void check_coalesce_bug(struct resv_map *resv)
>                 }
>         }
>  }
> +#else
> +static void check_coalesce_bug(struct resv_map *resv)
> +{
> +}
>  #endif
>
>  static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
> @@ -431,9 +435,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>         }
>
>         VM_BUG_ON(add < 0);
> -#ifdef CONFIG_DEBUG_VM
>         check_coalesce_bug(resv);
> -#endif
>         return add;
>  }
>
> --
> 2.25.0.265.gbab2e86ba0-goog
