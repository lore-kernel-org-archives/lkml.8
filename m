Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C04C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B0E24697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaQwtQAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1KtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:49:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36966 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgB1KtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:49:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so2442380oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqdR1FawIDcIjcDWnx2zMMW5yAMtp4uyQmYJLmHNyd8=;
        b=iaQwtQAwDokvpkvWtIBMKO18MBEUopLMOwY9kq5JljpHlqghSzpzTp05zUOBKX2UEB
         Hki8du07pvSvsc2LTNwO3MwSZwjMC/0tN2RTSIR/VslJnKL0e8tocfEjzO92MwzYqQF2
         bgIDhZUCF4QVFg8pm48+sSE89EuR3eTPVtXIR8lQv3AK0H7RwH9fYPXdVvhVYaWq9IWO
         ueLfIzlutMBh/lGXQH59NzcJvK5dR12h6t1jPhkXlBg0Ep0dQcy++eJluetM321O694/
         1F3Tl2bl05QUq1rXWwIPNeuxfEQ7xmih5ZOorVWIr/tS99pYhJGvIvPOri0DL+geVl/1
         poUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqdR1FawIDcIjcDWnx2zMMW5yAMtp4uyQmYJLmHNyd8=;
        b=crrFoIYLexM3zqrEQVNVW+jm6qh3QFmwhW0JSfPhks4bIc7gvosglttdSN92rashd3
         mhwPJTe/FsOetWo7nqYqwHjWdjwjL624zKLQasnwvxvDu84vJJAEMDEscaGQsCDej5z4
         7tK16YcwRDSQWTPz/M6qdzTMv+WukrFkcysM4kBgiJbGMnX3s+HmEyPuQ9tdHnLtXPEZ
         1tISMaT53oNkW0J9YfotOaBZXd/97uMUjjYAhYevgDYoyLZdcnK1ya76HwFO9ar5C5cR
         Yz/0PboheBxk53MTM4mY3qbwG5X1/7ety4obIQU1wILNEsHjaIy5lQB8pLOFBP582jgX
         ZEfw==
X-Gm-Message-State: APjAAAW0UNhieSGdnqs7SvJRGbhSOE2SUAt3RT3HA0lBGiqgdQEGkGnk
        c5fhjM+z6CzNP4jsL6lyGMQvO/lhOOQ33kfEdnQwUtQX
X-Google-Smtp-Source: APXvYqxQL6CLzR9Ev8U0HMJC6wiM0zIinQqhyFi62qJn3GpWoGc6pgY/YDb7QjypTAohz7rkgxsaQGw1WqcqZT4LehU=
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr2640215oij.121.1582886957457;
 Fri, 28 Feb 2020 02:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20200228044018.1263-1-cai@lca.pw>
In-Reply-To: <20200228044018.1263-1-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Feb 2020 11:49:06 +0100
Message-ID: <CANpmjNNe4OebUdTR5Z=23FK55gXOJmzdnEfXt8_3xjQ0P+foFA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: annotate data races for lru_rotate_pvecs
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 05:40, Qian Cai <cai@lca.pw> wrote:
>
> Read to lru_add_pvec->nr could be interrupted and then write to the same
> variable. The write has local interrupt disabled, but the plain reads
> result in data races. However, it is unlikely the compilers could
> do much damage here given that lru_add_pvec->nr is a "unsigned char" and
> there is an existing compiler barrier. Thus, annotate the reads using the
> data_race() macro. The data races were reported by KCSAN,

Note that, the fact that the writer has local interrupts disabled for
the write is irrelevant because it's the interrupt that triggered
while the read was happening that led to the concurrent write.

I assume you ran this with CONFIG_KCSAN_INTERRUPT_WATCHER=y?  The
option is disabled by default (see its help-text). I don't know if we
want to deal with data races due to interrupts right now, especially
those that just result in 'data_race' annotations. Thoughts?

Thanks,
-- Marco

>  BUG: KCSAN: data-race in lru_add_drain_cpu / rotate_reclaimable_page
>
>  write to 0xffff9291ebcb8a40 of 1 bytes by interrupt on cpu 23:
>   rotate_reclaimable_page+0x2df/0x490
>   pagevec_add at include/linux/pagevec.h:81
>   (inlined by) rotate_reclaimable_page at mm/swap.c:259
>   end_page_writeback+0x1b5/0x2b0
>   end_swap_bio_write+0x1d0/0x280
>   bio_endio+0x297/0x560
>   dec_pending+0x218/0x430 [dm_mod]
>   clone_endio+0xe4/0x2c0 [dm_mod]
>   bio_endio+0x297/0x560
>   blk_update_request+0x201/0x920
>   scsi_end_request+0x6b/0x4a0
>   scsi_io_completion+0xb7/0x7e0
>   scsi_finish_command+0x1ed/0x2a0
>   scsi_softirq_done+0x1c9/0x1d0
>   blk_done_softirq+0x181/0x1d0
>   __do_softirq+0xd9/0x57c
>   irq_exit+0xa2/0xc0
>   do_IRQ+0x8b/0x190
>   ret_from_intr+0x0/0x42
>   delay_tsc+0x46/0x80
>   __const_udelay+0x3c/0x40
>   __udelay+0x10/0x20
>   kcsan_setup_watchpoint+0x202/0x3a0
>   __tsan_read1+0xc2/0x100
>   lru_add_drain_cpu+0xb8/0x3f0
>   lru_add_drain+0x25/0x40
>   shrink_active_list+0xe1/0xc80
>   shrink_lruvec+0x766/0xb70
>   shrink_node+0x2d6/0xca0
>   do_try_to_free_pages+0x1f7/0x9a0
>   try_to_free_pages+0x252/0x5b0
>   __alloc_pages_slowpath+0x458/0x1290
>   __alloc_pages_nodemask+0x3bb/0x450
>   alloc_pages_vma+0x8a/0x2c0
>   do_anonymous_page+0x16e/0x6f0
>   __handle_mm_fault+0xcd5/0xd40
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
>
>  read to 0xffff9291ebcb8a40 of 1 bytes by task 37761 on cpu 23:
>   lru_add_drain_cpu+0xb8/0x3f0
>   lru_add_drain_cpu at mm/swap.c:602
>   lru_add_drain+0x25/0x40
>   shrink_active_list+0xe1/0xc80
>   shrink_lruvec+0x766/0xb70
>   shrink_node+0x2d6/0xca0
>   do_try_to_free_pages+0x1f7/0x9a0
>   try_to_free_pages+0x252/0x5b0
>   __alloc_pages_slowpath+0x458/0x1290
>   __alloc_pages_nodemask+0x3bb/0x450
>   alloc_pages_vma+0x8a/0x2c0
>   do_anonymous_page+0x16e/0x6f0
>   __handle_mm_fault+0xcd5/0xd40
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
>
>  2 locks held by oom02/37761:
>   #0: ffff9281e5928808 (&mm->mmap_sem#2){++++}, at: do_page_fault
>   #1: ffffffffb3ade380 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part
>  irq event stamp: 1949217
>  trace_hardirqs_on_thunk+0x1a/0x1c
>  __do_softirq+0x2e7/0x57c
>  __do_softirq+0x34c/0x57c
>  irq_exit+0xa2/0xc0
>
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 23 PID: 37761 Comm: oom02 Not tainted 5.6.0-rc3-next-20200226+ #6
>  Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> BTW, while at it, I had also looked at other pagevec there, but could
> not tell for  sure if they could be interrupted resulting in data races,
> so I leave them out for now.
>
>  mm/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index cf39d24ada2a..c922f99dab85 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -599,7 +599,8 @@ void lru_add_drain_cpu(int cpu)
>                 __pagevec_lru_add(pvec);
>
>         pvec = &per_cpu(lru_rotate_pvecs, cpu);
> -       if (pagevec_count(pvec)) {
> +       /* Disabling interrupts below acts as a compiler barrier. */
> +       if (data_race(pagevec_count(pvec))) {
>                 unsigned long flags;
>
>                 /* No harm done if a racing interrupt already did this */
> @@ -744,7 +745,7 @@ void lru_add_drain_all(void)
>                 struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>
>                 if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
> -                   pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
> +                   data_race(pagevec_count(&per_cpu(lru_rotate_pvecs, cpu))) ||
>                     pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
>                     pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
>                     pagevec_count(&per_cpu(lru_lazyfree_pvecs, cpu)) ||
> --
> 2.21.0 (Apple Git-122.2)
>
