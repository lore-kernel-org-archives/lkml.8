Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B9B2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp/B0PBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgAJBBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:01:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43398 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgAJBBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:01:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so354639oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 17:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWgqW0TgD4TOVFlB5rMaOLZ+hTh/cuW3Reu5skzL6P8=;
        b=Mp/B0PBjeTl4dixKIdkVGVSWPy5op+1f2GYYte8HGNwE6u2sbKhyIm4ByMjqUaWnvh
         WSRH7fFF2ChtoDmmScfg4cqp+QNA1wpXIenolwjA31u0xO/nfncH1PtD/37KeP7L4n6J
         Vo/U/jB/o//GdPl3myOmSgP9MoEf6O6VpsyzDPoxqLwABTMCskv6WJjccHYoPfOvg8V8
         zzOl5sPtWz81IYrY7iGaBJlXkrxcOGyApfdp5//qy54Ch/GMdUzzsKJY1yY3AcyXyJL8
         TrwW4CJxRF4D4yF6j6caaUpZCYEC/kKMqatBWxxTomw4Gilp1s0X+ZUdMACn48iOMGaA
         vlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWgqW0TgD4TOVFlB5rMaOLZ+hTh/cuW3Reu5skzL6P8=;
        b=jsNlTMxS/TClzXPYwQck5nSFG+53zWIANF8EBPMhedq/h+fqeYm8b0AwzwhOmcN/Ew
         GUuTSHSv56CkLw32jmZKfAn6NnLIyQjcEbMZqkDiYKMSu1AeiMUavGOkKJD4E1bkgIdC
         +kPgwNRnwkjm3iqzPLg4F33cXlQFB4mpUX2SUuhLN4tHgawAz7Ac0V2nKUO4mjlWE6T5
         0Y69fFHv+jcxTa7ORKq1ZxQ3A4axYxzqIu5hYB6QoR0JebpKLmaSN4e9nji+eaJvHFrH
         a2k4WeqSPSIi6EBBJ6ABOGp12tbYPIEseUN3X90C5zU43wJi5totwEwR2kLularZ5d2r
         n8mA==
X-Gm-Message-State: APjAAAU8qfp+jJX8BKUdykcn1g7C00B4IklT1K8rsH4XIMU+dEjMkXQF
        1IcyqY2kpuFAJVcmF1OLciEENVX6YnXvu7+esPQ=
X-Google-Smtp-Source: APXvYqwrVYiE61iO9OfkncCVq1VkUlyIDIYLVX+WzDh7DP04+T1fqp7ocgTh5cvIyWbxxq2aM1NUxBqym/gayJRdplg=
X-Received: by 2002:a05:6830:18f1:: with SMTP id d17mr500030otf.298.1578618105919;
 Thu, 09 Jan 2020 17:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com> <CAHbLzkr=P38zJMpNVtw9oKMT65hwq6ie85h-fRi7rpZyf4A71g@mail.gmail.com>
In-Reply-To: <CAHbLzkr=P38zJMpNVtw9oKMT65hwq6ie85h-fRi7rpZyf4A71g@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 9 Jan 2020 17:01:34 -0800
Message-ID: <CAM_iQpWvrR9cVA31tD7Mvx0yTN=NDXQ-NMYStH9UB3Rb6WzmeA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 4:28 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Jan 9, 2020 at 2:57 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > We observed kcompactd hung at __lock_page():
> >
> >  INFO: task kcompactd0:57 blocked for more than 120 seconds.
> >        Not tainted 4.19.56.x86_64 #1
> >  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >  kcompactd0      D    0    57      2 0x80000000
> >  Call Trace:
> >   ? __schedule+0x236/0x860
> >   schedule+0x28/0x80
> >   io_schedule+0x12/0x40
> >   __lock_page+0xf9/0x120
> >   ? page_cache_tree_insert+0xb0/0xb0
> >   ? update_pageblock_skip+0xb0/0xb0
> >   migrate_pages+0x88c/0xb90
> >   ? isolate_freepages_block+0x3b0/0x3b0
> >   compact_zone+0x5f1/0x870
> >   kcompactd_do_work+0x130/0x2c0
> >   ? __switch_to_asm+0x35/0x70
> >   ? __switch_to_asm+0x41/0x70
> >   ? kcompactd_do_work+0x2c0/0x2c0
> >   ? kcompactd+0x73/0x180
> >   kcompactd+0x73/0x180
> >   ? finish_wait+0x80/0x80
> >   kthread+0x113/0x130
> >   ? kthread_create_worker_on_cpu+0x50/0x50
> >   ret_from_fork+0x35/0x40
> >
> > which faddr2line maps to:
> >
> >   migrate_pages+0x88c/0xb90:
> >   lock_page at include/linux/pagemap.h:483
> >   (inlined by) __unmap_and_move at mm/migrate.c:1024
> >   (inlined by) unmap_and_move at mm/migrate.c:1189
> >   (inlined by) migrate_pages at mm/migrate.c:1419
> >
> > Sometimes kcompactd eventually got out of this situation, sometimes not.
> >
> > I think for memory compaction, it is a best effort to migrate the pages,
> > so it doesn't have to wait for I/O to complete. It is fine to call
> > trylock_page() here, which is pretty much similar to
> > buffer_migrate_lock_buffers().
> >
> > Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> > check for it.
>
> But this changed the semantics of MIGRATE_SYNC_LIGHT which means
> blocking on most operations but not ->writepage. When
> MIGRATE_SYNC_LIGHT is used it means compaction priority is increased
> (the initial priority is ASYNC) due to whatever reason (i.e. not
> enough clean, non-writeback and non-locked pages to migrate). So, it
> has to wait for some pages to try to not backoff pre-maturely.

Thanks for explaining MIGRATE_SYNC_LIGHT. I didn't dig the history
of MIGRATE_SYNC_LIGHT.

>
> If I read the code correctly, buffer_migrate_lock_buffers() also
> blocks on page lock with non-ASYNC mode.
>
> Since v5.1 Mel Gorman improved compaction a lot. So, I'm wondering if
> this happens on the latest upstream or not.

Unfortunately we can't test upstream kernel because:
1) We don't know how to reproduce it.
2) It is not easy to deploy upstream kernel in our environment.


>
> And, did you figure out who is locking the page for such long time? Or
> there might be too many waiters on the list for this page?

I tried to dump the process stacks after we saw the hung task
with /proc/X/stack (apparently sysrq is not an option for production),
but I didn't find anything useful. I didn't see any other process
hung in lock_page() either, all mm-related kernel threads were sleeping
(non-D) at the time I debugged. So, it is possible there was some place
missing a unlock_page() too, which is too late to debug after the hung
task was reported.

Thanks.
