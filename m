Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95959207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a740NAoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBRnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIBRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:43:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED810C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:43:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so7910622ejr.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMtrzgDPO6AmfI9ZPBSjKxXAd2ee14HiYfSbmhtlU0o=;
        b=a740NAoedXkRok+5UfNBY1sTSlo7bklHmwoPOuittzrLsAFwAioFf57AzFa7yphWkP
         XJzZYoZyU07EX4V2EGo4ZHIvwbG0/TOxEOJZQPuk6Pwru4va9hmOCKChvUxFLG5ViCa4
         Avfk07uILC759ju3dAYVr7tND9/cO/OBPsYas1P+tAipN+q4tuy4Rx4ej4E1A2nv/k8B
         8/Rp/6uW0NoC7F0Q7r6dgE9kO3EK1HhaJbFn1NL4hNh46QA+usJ+I5RFsVYJfNOGw2uu
         yq/4s5V/YLDpYZ9B98t8Y0Y9fBxiTKUe6w5RxivGgy5sfwN4DGisCnb52N+imfOUkDpn
         xgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMtrzgDPO6AmfI9ZPBSjKxXAd2ee14HiYfSbmhtlU0o=;
        b=dddQu4EGXYlZ6Fv5rV06jF7xeH0ox4x6dVT59FzQpqF77uCxx8b0HSYDZPIkdGBJ70
         fLHTqwX+662bP842v/HzAwNnyNnYv05kfSrPs0Bix/3uKkyFKY6aQBUQf3U49QFATL97
         wUOJuyR8PjagH93Dn41mwtH02kbd+fPUQaJgOMnffS0lVBU53od2jDY7vOf4pf4movFT
         FCq6mB+AprXKG4WMbHrc2EnVHCFZP5059DZT63Me7xTePK347i66C64FFIQGoez0kzHP
         WOH167+iywrWdEUJb1/CIM8g0buTDncrWBxUq5X2EM2B0x2PBfyfUOaWjhsU2Ta6nStT
         Lluw==
X-Gm-Message-State: AOAM531NoTomSEMn29cq0aXZs+jC5/tQFszksdnSTJbxkxPXBayADAzJ
        qsYBbRWuVDWXWdrRlRp3S+7MjYq/le1vX/AoNuk=
X-Google-Smtp-Source: ABdhPJxmIK8odO2VkYlxX0ps8YQ8kne3FIuthQ1TDFr5/VmkZPJAhnVx4eJe+tQVmA/23SIxUM0/JjFsC4NGcSfnzgQ=
X-Received: by 2002:a17:907:2173:: with SMTP id rl19mr1111153ejb.514.1599068614629;
 Wed, 02 Sep 2020 10:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <159905616280.521200.12444250032673650063.stgit@warthog.procyon.org.uk>
In-Reply-To: <159905616280.521200.12444250032673650063.stgit@warthog.procyon.org.uk>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Sep 2020 10:43:22 -0700
Message-ID: <CAHbLzkpL+657FqvvkATq8NiVwioeiovg=972RsktuW5n+3D+pg@mail.gmail.com>
Subject: Re: [PATCH] Fix khugepaged's request size in collapse_file()
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 7:16 AM David Howells <dhowells@redhat.com> wrote:
>
> collapse_file() in khugepaged passes PAGE_SIZE as the number of pages to be
> read ahead to page_cache_sync_readahead().  It seems this was expressed as a
> number of bytes rather than a number of pages.
>
> Fix it to use the number of pages to the end of the window instead.
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  mm/khugepaged.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6d199c353281..f2d243077b74 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1706,7 +1706,7 @@ static void collapse_file(struct mm_struct *mm,
>                                 xas_unlock_irq(&xas);
>                                 page_cache_sync_readahead(mapping, &file->f_ra,
>                                                           file, index,
> -                                                         PAGE_SIZE);
> +                                                         end - index);
>                                 /* drain pagevecs to help isolate_lru_page() */
>                                 lru_add_drain();
>                                 page = find_lock_page(mapping, index);
>
>
>
