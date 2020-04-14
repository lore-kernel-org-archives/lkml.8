Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3178C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF48B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="UXsJOXIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439917AbgDNMKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729842AbgDNMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:10:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD133C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:10:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so12886268ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAdVxxSK6UzybtZESb3uXkMXP8dhayxHiMBPeS5kvUk=;
        b=UXsJOXIe8Eifex9TCUfwki7mv+EZmx/jqu4JkkaKE9/C3kFVVSJLzxbf1tHMrKrQug
         qgHamelknoE44KAA3kHNmTdoIePmtz9vycqFHzFaHCRi9ffZq879LzAwVt5iqK90fJ3U
         5Q0SCVNMA5zjL/aG93IsbXxsh1Qm9UdDyIh88ZpNzX7W4C6GvcDZYDarzpt5rp3rXcdr
         Wf1O4OEr+fEqT0aXOwTYzN3/9GUDcICMbQF5XfHaB9zQ5mAks+MxkRZGGYRPn/1hOTVJ
         Bh9TxqRBiXrl1tph0YcYQqrNwYpKBIa5nHPGZ+DCYfM0WLczeTALMk0tyl0TLlvgIpzW
         vUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAdVxxSK6UzybtZESb3uXkMXP8dhayxHiMBPeS5kvUk=;
        b=bt71thXbxSHF28Jhld4XlmGJ7OBqgWrrOAHDC0BWbwpf5I1TfJtKx27zY+tUfz7J7C
         v2tH3bDBzKc8lDZzXXjyx9QA2QKzrzUwDUH3clyvCw9btFCEbX0oaEDqkwec/7fDWark
         /Vn70KBfeOiUdPK3wFr/D5sKnHiaqtBlyStjvNMzRqHLiMlqgK8N1kHf/GP6NQ4f+v7g
         qUghhFB0O/e2dpp1wy3O/F7++7ELEMcm4bWZe0qrSCMkftOh6xkokxOvvAmTw+QauqUu
         7X37NQRx3f3aYu0AP6GZXXlHArc1pKcM2igAr31IFtvhdfxpnNY+wVYsKRbUlNY61mED
         xRIw==
X-Gm-Message-State: AGi0PuZniKtGBlWUWCzBGcSJ3yuHBGjNKcYzoG/mcZwc3wOUiceaSvAX
        T5xTy0i+7EtfgYHXOaxTIWVbCehXU/aY65EoXgA1BQ==
X-Google-Smtp-Source: APiQypLGxrdeIAqKDuz8J7dHMNCNliab8V1lHrPvVF9wPSALeTIZ7l/PJ0lcxD0CjYGKrmpmMHbAQBT2l9+/UnJ4Z9Q=
X-Received: by 2002:a02:cca3:: with SMTP id t3mr12777843jap.3.1586866221756;
 Tue, 14 Apr 2020 05:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200414062050.66644-1-songmuchun@bytedance.com> <ecfc9354-5dba-8e24-f9db-295a2a5d1b4f@redhat.com>
In-Reply-To: <ecfc9354-5dba-8e24-f9db-295a2a5d1b4f@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 20:09:45 +0800
Message-ID: <CAMZfGtXnVG8Uny5qnFvHuJqu8UBnatDbfx5kyRQZfDtrGoqwvA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/ksm: Fix kernel NULL pointer
 dereference at 0000000000000040
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:48 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 14.04.20 08:20, Muchun Song wrote:
> > The find_mergeable_vma can return NULL. In this case, it leads
> > to crash when we access vma->vm_mm(which's offset is 0x40) in
> > write_protect_page. And this case did happen on our server. The
> > following calltrace is captured in kernel 4.19 with ksm enabled.
> > So add a vma check to fix it.
> >
> > --------------------------------------------------------------------------
> >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] SMP NOPTI
> >   CPU: 9 PID: 510 Comm: ksmd Kdump: loaded Tainted: G OE 4.19.36.bsk.9-amd64 #4.19.36.bsk.9
> >   Hardware name: FOXCONN R-5111/GROOT, BIOS IC1B111F 08/17/2019
> >   RIP: 0010:try_to_merge_one_page+0xc7/0x760
> >   Code: 24 58 65 48 33 34 25 28 00 00 00 89 e8 0f 85 a3 06 00 00 48 83 c4
> >         60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 46 08 a8 01 75 b8 <49>
> >         8b 44 24 40 4c 8d 7c 24 20 b9 07 00 00 00 4c 89 e6 4c 89 ff 48
> >   RSP: 0018:ffffadbdd9fffdb0 EFLAGS: 00010246
> >   RAX: ffffda83ffd4be08 RBX: ffffda83ffd4be40 RCX: 0000002c6e800000
> >   RDX: 0000000000000000 RSI: ffffda83ffd4be40 RDI: 0000000000000000
> >   RBP: ffffa11939f02ec0 R08: 0000000094e1a447 R09: 00000000abe76577
> >   R10: 0000000000000962 R11: 0000000000004e6a R12: 0000000000000000
> >   R13: ffffda83b1e06380 R14: ffffa18f31f072c0 R15: ffffda83ffd4be40
> >   FS: 0000000000000000(0000) GS:ffffa0da43b80000(0000) knlGS:0000000000000000
> >   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000000000040 CR3: 0000002c77c0a003 CR4: 00000000007626e0
> >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >   PKRU: 55555554
> >   Call Trace:
> >     ? follow_page_pte+0x36d/0x5e0
> >     ksm_scan_thread+0x115e/0x1960
> >     ? remove_wait_queue+0x60/0x60
> >     kthread+0xf5/0x130
> >     ? try_to_merge_with_ksm_page+0x90/0x90
> >     ? kthread_create_worker_on_cpu+0x70/0x70
> >     ret_from_fork+0x1f/0x30
> > --------------------------------------------------------------------------
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Xiongchun duan <duanxiongchun@bytedance.com>
>
> ^ why this signed-off ?
>

Because I have a partner. And I just sent the v2 patch which updates the
commit message and patch subject. Thanks for your review.

> > ---
> >  mm/ksm.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index a558da9e71770..69b2f85e22d5b 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -2112,8 +2112,11 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
> >
> >               down_read(&mm->mmap_sem);
> >               vma = find_mergeable_vma(mm, rmap_item->address);
> > -             err = try_to_merge_one_page(vma, page,
> > -                                         ZERO_PAGE(rmap_item->address));
> > +             if (vma)
> > +                     err = try_to_merge_one_page(vma, page,
> > +                                     ZERO_PAGE(rmap_item->address));
> > +             else
> > +                     err = -EFAULT;
> >               up_read(&mm->mmap_sem);
> >               /*
> >                * In case of failure, the page was not really empty, so we
> >
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
