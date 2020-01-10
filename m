Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B45FC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C102080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPsxAOdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgAJA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:28:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39245 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgAJA2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:28:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so52261eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK07dG9mS/i6t5DE8qmxV0Tg9yfN7MAs/hz7qzpudL4=;
        b=UPsxAOdUQON+FR7w22H7DQOXhIuTtYc6PmzaFpKapcLEEDcu8VMwaxdTNV+Xq1yAOx
         fA4KYSLvgUDS7iMJ66tdLniB4FfwqFrDa4vvjNbLauE3aycCDyJfvhIm07PTLVycCsnf
         1g2VHo7KNWC4MunVPYa6VL0r7BtNiVpI567rgr0xL+GhDC3IN9S4ckIdqZAnO1oxCQTL
         bWM3i5B9Bg8usNme7XWiwfLMoFYOmPR844+Rw1dKSLUtudJfzAW2IXLVzCMpCWQzhf1c
         BCbG1myvcy3dzB23Zs0QZ+N7skreF52WJCOXbEQjOshrfrwRMnM7XtTLVPT0boqtyLKX
         ld0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK07dG9mS/i6t5DE8qmxV0Tg9yfN7MAs/hz7qzpudL4=;
        b=b/c4BU1Rjl7VE44gAa7zhFnaEH9rc+zoQpU8u0anTb9sZISu8HwXtkLvo1ABp0IM51
         M06TieW+iJ8jeUNr0oEtbK6QSjgaWGECmsPe9PIOxBnXNMO6bVC3LphDbbWETWxID//r
         gwr7vm4UtZ2x1Ndx26wnbnS773ylw3ZcU8NrdE5fVvoieb/pw4rx4TiumBpERq4QSKZT
         vTgEklEFq5IM5v9Aq3i0iIYHXpuMADhOEkrKW006C+zaqDThrOcCETvpBWXA88fSGo5e
         SnaUHl2/8ZcRJokns9wrGAv9seHz9M7HBMTNNfw+2znckhQ4FFVFdLOGuq5MYLzyeZj8
         Mnkw==
X-Gm-Message-State: APjAAAUxVp8Z6sbLrc/z9x8FJeEf0HsbFUCEpWGdIiEwGUuBtyV/z0s+
        YdTAdKD7zn0bnshPrt3/uNm8fvy890uo8JZzDZA=
X-Google-Smtp-Source: APXvYqyTpGDs94DxDuzM33I28G6l7opgYXI3yi8+fRZmsrI8GAn8omoeBcR4IHCIY9AgBow09tedzqJ55ScIUb2jXvs=
X-Received: by 2002:aa7:c694:: with SMTP id n20mr501233edq.95.1578616133224;
 Thu, 09 Jan 2020 16:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 9 Jan 2020 16:28:40 -0800
Message-ID: <CAHbLzkr=P38zJMpNVtw9oKMT65hwq6ie85h-fRi7rpZyf4A71g@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 2:57 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> We observed kcompactd hung at __lock_page():
>
>  INFO: task kcompactd0:57 blocked for more than 120 seconds.
>        Not tainted 4.19.56.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  kcompactd0      D    0    57      2 0x80000000
>  Call Trace:
>   ? __schedule+0x236/0x860
>   schedule+0x28/0x80
>   io_schedule+0x12/0x40
>   __lock_page+0xf9/0x120
>   ? page_cache_tree_insert+0xb0/0xb0
>   ? update_pageblock_skip+0xb0/0xb0
>   migrate_pages+0x88c/0xb90
>   ? isolate_freepages_block+0x3b0/0x3b0
>   compact_zone+0x5f1/0x870
>   kcompactd_do_work+0x130/0x2c0
>   ? __switch_to_asm+0x35/0x70
>   ? __switch_to_asm+0x41/0x70
>   ? kcompactd_do_work+0x2c0/0x2c0
>   ? kcompactd+0x73/0x180
>   kcompactd+0x73/0x180
>   ? finish_wait+0x80/0x80
>   kthread+0x113/0x130
>   ? kthread_create_worker_on_cpu+0x50/0x50
>   ret_from_fork+0x35/0x40
>
> which faddr2line maps to:
>
>   migrate_pages+0x88c/0xb90:
>   lock_page at include/linux/pagemap.h:483
>   (inlined by) __unmap_and_move at mm/migrate.c:1024
>   (inlined by) unmap_and_move at mm/migrate.c:1189
>   (inlined by) migrate_pages at mm/migrate.c:1419
>
> Sometimes kcompactd eventually got out of this situation, sometimes not.
>
> I think for memory compaction, it is a best effort to migrate the pages,
> so it doesn't have to wait for I/O to complete. It is fine to call
> trylock_page() here, which is pretty much similar to
> buffer_migrate_lock_buffers().
>
> Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> check for it.

But this changed the semantics of MIGRATE_SYNC_LIGHT which means
blocking on most operations but not ->writepage. When
MIGRATE_SYNC_LIGHT is used it means compaction priority is increased
(the initial priority is ASYNC) due to whatever reason (i.e. not
enough clean, non-writeback and non-locked pages to migrate). So, it
has to wait for some pages to try to not backoff pre-maturely.

If I read the code correctly, buffer_migrate_lock_buffers() also
blocks on page lock with non-ASYNC mode.

Since v5.1 Mel Gorman improved compaction a lot. So, I'm wondering if
this happens on the latest upstream or not.

And, did you figure out who is locking the page for such long time? Or
there might be too many waiters on the list for this page?

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 86873b6f38a7..df60026779d2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1010,7 +1010,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>         bool is_lru = !__PageMovable(page);
>
>         if (!trylock_page(page)) {
> -               if (!force || mode == MIGRATE_ASYNC)
> +               if (!force || mode == MIGRATE_ASYNC
> +                          || mode == MIGRATE_SYNC_LIGHT)
>                         goto out;
>
>                 /*
> --
> 2.21.1
>
>
