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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49272C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C6E20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQnxgMfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgIBSyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:54:44 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C674C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:54:44 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so60317ioa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF56mZMJ2WsC21vuD8YlR44aW/J9Nv1kdlXNn6+0Jmc=;
        b=NQnxgMfX9wCh2os1ZOmAHNWgN8zzEMfrZbO5AEPVjZv0XdJnxNppuiYPUOTdW6mg5a
         XHcrItkgB5FofTpctF3wGtgUhhpulJNTzJBbNdasn6xB2F0Z67jLO0I6iDmbYJfWPnk0
         hF/lbJnKwbBzFrWro3omc+6I4k9XqEHHo7Hkvd7/yUN17rMq9R6vXjp9xu3ogKcPbQmA
         azNzJyXtRcaJsFMHhh+K2Hwp1r9z1DJ9pELY+PS5qBVS7s+IxSm3p1Swdb65cIwG5bGR
         DISjcfloDr7oVm9mTR2t+3ZrTG+Ap+F7lJYGaoxLrHnbXB4RHCOwlWTf/OSFriKgbiKa
         IbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF56mZMJ2WsC21vuD8YlR44aW/J9Nv1kdlXNn6+0Jmc=;
        b=MUhJ8wt1I4rAeAPfkDir9JJ57GD5udpjb97/qVOBxPFFGMA1J0dflutTWAYXxa9fXQ
         3F3PUc1m9H1HaaEbvlPKM3am11pvT8PihfhoK//xkQ7pnGJD4EAVYk7w/6f/iW8h0D/g
         1zYw9LXLeqbVFMuea0t6hnIodwORidsJfciVEKhoQYnF0s+XqEnFLiEGh2PylsJFz07D
         IUnH6/DBk/G1eBJmTSImx1cIlUtM9BZ3hsZOSFbA0oMPdcTGklH1XMtKNEyaV0UntSYH
         41jV/JKGs4ka4wqaaN2m0AXAeiBbvBueGp4y6EEUWOnNfHzrrMYWDNNVrDSQdFIqZUx1
         SdJA==
X-Gm-Message-State: AOAM530BCH1NuA+vOqZ0G1iqQXoD3evr8i0DU4q6en3DVFM4/J2yAyxL
        evq9rcIbLoQKCCPMPWIKuEKGvbIU1r74nvKFed0=
X-Google-Smtp-Source: ABdhPJymnhlrdDdnHN9QbXZ8plCeo5oARAUu45klg6LMfnATgzaisqhmYVn2br9fNybt7R3g58duVGwp2lt3slZWmNw=
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr4419966jas.109.1599072883749;
 Wed, 02 Sep 2020 11:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <159905616280.521200.12444250032673650063.stgit@warthog.procyon.org.uk>
In-Reply-To: <159905616280.521200.12444250032673650063.stgit@warthog.procyon.org.uk>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 2 Sep 2020 20:54:32 +0200
Message-ID: <CAM9Jb+gU3KS5QV9EKfxBz6qhf+eZJ0zT+DL6Lw2K3+8qkLYPPA@mail.gmail.com>
Subject: Re: [PATCH] Fix khugepaged's request size in collapse_file()
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
