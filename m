Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07317C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AEB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Q3AFN5Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502471AbgDNNCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502372AbgDNNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:01:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:01:56 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e4so9535337ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zyeYMBiZ7mbLAhDaBruYWCix3rdWMBYNww9cQF5pTg=;
        b=Q3AFN5IoWsmLuGbfJMknS+4eK5SKwEYNdDjDtHmK79XnOpMkDoA6sCplhBXWSUiYLF
         glxxxKdCSw1JLfM1Fsv3khF+ynyElC5fh0mZkfU1EcjJJuwjYilEgZsSQcMZPBlweyB4
         fmGAQTHc7YAoFxI76hvFKwnNqqwslQbu5kgC04gih2DGoHy3qhUj50fjUnyqFNohQKLt
         62yE4mgNzUDMMhcUwOedk7MShJVD6v+St96RPT01u1f6BKcJPdE1/TktTr1g9iLwTfH1
         7x0rGzc9y63wkL3Ob6d84lQ+ykiL6g+9e5ox8/dFWUOiXJ6Uav/YEQhJ0ZcIJBFBaukD
         1unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zyeYMBiZ7mbLAhDaBruYWCix3rdWMBYNww9cQF5pTg=;
        b=apRwBqKXcFBAW9venUfhqBF3aiQbFH1xr92/tezYFIx8hxJRaFRcb+qZKnEKszJ0bY
         jyfJdb7ZT2Mydfqdw2/a0msyB747LWzEJPB5x7KPD1REnX9y0MtOOm43nTgoPpG558BK
         eJfIUxo1lOI3r45HMul4e006saXI/ZAQActZAC1vR9v0BZCbgRm7BUgHhr0V0mbzgp4u
         MLd8e6lZtSQb3DEiTFtCwCrwiTy+gPLHOUI76dw2nc9uvh4xoGEF3Qz8d5OmLqbzAcMG
         DohyZEs+yowDt+aFEV3K5WMM4kNv5uzTD8L+RiH5gnS2RBb7CrNCAtwbWilAqvEItdvJ
         vU9A==
X-Gm-Message-State: AGi0Puaj/4v1wQvP+x4cIY14UDrhbT5RuDvGitKWKkqhelEIsr9HyUPx
        jzENfatiyviny6fifIqB9X4aNj0tkvgPmcun0/UtNg==
X-Google-Smtp-Source: APiQypK/rt/43+1B/TcFGkTZRqd7u4Nt5XX2Ti1tGVnMbPfH7K2bSLMzJV4Scxi2cE1qB84QrUc6gWQ+EINE4YrwhoM=
X-Received: by 2002:a92:5b56:: with SMTP id p83mr96528ilb.70.1586869315654;
 Tue, 14 Apr 2020 06:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200414062050.66644-1-songmuchun@bytedance.com>
 <ecfc9354-5dba-8e24-f9db-295a2a5d1b4f@redhat.com> <CAMZfGtXnVG8Uny5qnFvHuJqu8UBnatDbfx5kyRQZfDtrGoqwvA@mail.gmail.com>
 <f4657c41-b724-30df-86c2-cf3de1873fd9@redhat.com>
In-Reply-To: <f4657c41-b724-30df-86c2-cf3de1873fd9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 21:01:19 +0800
Message-ID: <CAMZfGtX=-umUc1kyO+ca5qzQt+tP+uYGFv1XRoZMypcHHXD60Q@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 8:23 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 14.04.20 14:09, Muchun Song wrote:
> > On Tue, Apr 14, 2020 at 7:48 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 14.04.20 08:20, Muchun Song wrote:
> >>> The find_mergeable_vma can return NULL. In this case, it leads
> >>> to crash when we access vma->vm_mm(which's offset is 0x40) in
> >>> write_protect_page. And this case did happen on our server. The
> >>> following calltrace is captured in kernel 4.19 with ksm enabled.
> >>> So add a vma check to fix it.
> >>>
> >>> --------------------------------------------------------------------------
> >>>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
> >>>   PGD 0 P4D 0
> >>>   Oops: 0000 [#1] SMP NOPTI
> >>>   CPU: 9 PID: 510 Comm: ksmd Kdump: loaded Tainted: G OE 4.19.36.bsk.9-amd64 #4.19.36.bsk.9
> >>>   Hardware name: FOXCONN R-5111/GROOT, BIOS IC1B111F 08/17/2019
> >>>   RIP: 0010:try_to_merge_one_page+0xc7/0x760
> >>>   Code: 24 58 65 48 33 34 25 28 00 00 00 89 e8 0f 85 a3 06 00 00 48 83 c4
> >>>         60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 46 08 a8 01 75 b8 <49>
> >>>         8b 44 24 40 4c 8d 7c 24 20 b9 07 00 00 00 4c 89 e6 4c 89 ff 48
> >>>   RSP: 0018:ffffadbdd9fffdb0 EFLAGS: 00010246
> >>>   RAX: ffffda83ffd4be08 RBX: ffffda83ffd4be40 RCX: 0000002c6e800000
> >>>   RDX: 0000000000000000 RSI: ffffda83ffd4be40 RDI: 0000000000000000
> >>>   RBP: ffffa11939f02ec0 R08: 0000000094e1a447 R09: 00000000abe76577
> >>>   R10: 0000000000000962 R11: 0000000000004e6a R12: 0000000000000000
> >>>   R13: ffffda83b1e06380 R14: ffffa18f31f072c0 R15: ffffda83ffd4be40
> >>>   FS: 0000000000000000(0000) GS:ffffa0da43b80000(0000) knlGS:0000000000000000
> >>>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>   CR2: 0000000000000040 CR3: 0000002c77c0a003 CR4: 00000000007626e0
> >>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>   PKRU: 55555554
> >>>   Call Trace:
> >>>     ? follow_page_pte+0x36d/0x5e0
> >>>     ksm_scan_thread+0x115e/0x1960
> >>>     ? remove_wait_queue+0x60/0x60
> >>>     kthread+0xf5/0x130
> >>>     ? try_to_merge_with_ksm_page+0x90/0x90
> >>>     ? kthread_create_worker_on_cpu+0x70/0x70
> >>>     ret_from_fork+0x1f/0x30
> >>> --------------------------------------------------------------------------
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> Signed-off-by: Xiongchun duan <duanxiongchun@bytedance.com>
> >>
> >> ^ why this signed-off ?
> >>
> >
> > Because I have a partner. And I just sent the v2 patch which updates the
> > commit message and patch subject. Thanks for your review.
>
> Then we use Co-developed-by AFAIK instead.
>

Thanks a lot. I will fix it.

-- 
Yours,
Muchun
