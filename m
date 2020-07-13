Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D0C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0888206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh2dnYUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgGMNWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:22:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31741 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729722AbgGMNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594646538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHiDVAN+/NpycJ9K1bAeFKAt7d8Zl7wvOhlXnD93E/I=;
        b=bh2dnYUivoXpTmPdjGeMHaKdHsF0ny5TqFvR+aRQGbKItrmWfYRsSKw9VILvcxnqfX2mCa
        Jm9hDZnZWtcyN1EpEqcX0ftoGrt4g4de13y6W4c7WW4LDpPQ7hXzAJK/bdR1LaLzwxiX8t
        gZ8olusHcxjwIJHiOwPi+HeTpNQ1oug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-2lBuCZ7-NwiFq_YntMkDLg-1; Mon, 13 Jul 2020 09:22:15 -0400
X-MC-Unique: 2lBuCZ7-NwiFq_YntMkDLg-1
Received: by mail-wm1-f69.google.com with SMTP id g138so18600593wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IHiDVAN+/NpycJ9K1bAeFKAt7d8Zl7wvOhlXnD93E/I=;
        b=AdnPqaK4xCqjDae/NcOovjdMYg/mqU3O6zmpja4ylUkD1+QtAyXk5ye5TMyHF7EF4X
         a7FMwJ17PnDR1cFcCzNzAiogBLUTK9ERm6K0hPf7czdGFn1MD1qrZ6j9SWqix9QNV+Fl
         oVsYSXhAfAZ71bql2eeKsOtZe6t/SQBJ1+6/gS5Jl19g0o1XONV4jtOTkiaktjvKXSX1
         7p+91lJjFgsiATcvuJ8mMAMM40vFJo/5s4JiytlEDhWE4U1M3L6MrjiwkJh2YA99SQUC
         zTY4L40tDOybnR8i+v66fc9DxofAestAUj5OkhCv2l/eDNE4jsuolhA3L4OHl5Ssl0k8
         MIOg==
X-Gm-Message-State: AOAM5304aFO7netBQqQSRyT4tedwoVGAfLqYEICUiG/6MbWqWx6wV0aI
        C7pXC8azgOaQWtGdV9gngHy7FiLNYH28vjGnDif9MdDlxHoe2ZB36HJAHoYLmx5JuKSZ+KGSScC
        goJmHZcnTJH+T2G/+ghStx4/C
X-Received: by 2002:adf:f10a:: with SMTP id r10mr48337313wro.406.1594646533911;
        Mon, 13 Jul 2020 06:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm0qOT27kCpMTY1OC3xFic2ZegzyQksmisJV4C1SdGMg3ljlJkc6raT64MWjktjjJwMxmcUg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr48337287wro.406.1594646533607;
        Mon, 13 Jul 2020 06:22:13 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.4])
        by smtp.gmail.com with ESMTPSA id m4sm21994076wmi.48.2020.07.13.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:13 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:22:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200713132211.GB5564@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
 <20200706064557.GA26135@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706064557.GA26135@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/07/20 08:45, Juri Lelli wrote:
> On 03/07/20 19:11, He Zhe wrote:
> > 
> > 
> > On 7/3/20 4:12 PM, Juri Lelli wrote:
> > > Hi,
> > >
> > > On 10/04/20 19:47, zhe.he@windriver.com wrote:
> > >> From: He Zhe <zhe.he@windriver.com>
> > >>
> > >> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> > >> introduces a percpu counter that tracks the percpu recursion depth and
> > >> warn if it greater than zero, to avoid potential deadlock and stack
> > >> overflow.
> > >>
> > >> However sometimes different eventfds may be used in parallel. Specifically,
> > >> when heavy network load goes through kvm and vhost, working as below, it
> > >> would trigger the following call trace.
> > >>
> > >> -  100.00%
> > >>    - 66.51%
> > >>         ret_from_fork
> > >>         kthread
> > >>       - vhost_worker
> > >>          - 33.47% handle_tx_kick
> > >>               handle_tx
> > >>               handle_tx_copy
> > >>               vhost_tx_batch.isra.0
> > >>               vhost_add_used_and_signal_n
> > >>               eventfd_signal
> > >>          - 33.05% handle_rx_net
> > >>               handle_rx
> > >>               vhost_add_used_and_signal_n
> > >>               eventfd_signal
> > >>    - 33.49%
> > >>         ioctl
> > >>         entry_SYSCALL_64_after_hwframe
> > >>         do_syscall_64
> > >>         __x64_sys_ioctl
> > >>         ksys_ioctl
> > >>         do_vfs_ioctl
> > >>         kvm_vcpu_ioctl
> > >>         kvm_arch_vcpu_ioctl_run
> > >>         vmx_handle_exit
> > >>         handle_ept_misconfig
> > >>         kvm_io_bus_write
> > >>         __kvm_io_bus_write
> > >>         eventfd_signal
> > >>
> > >> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> > >> ---- snip ----
> > >> 001: Call Trace:
> > >> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> > >> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> > >> 001:  handle_rx+0xb9/0x900 [vhost_net]
> > >> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> > >> 001:  vhost_worker+0xbe/0x120 [vhost]
> > >> 001:  kthread+0x106/0x140
> > >> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> > >> 001:  ? kthread_park+0x90/0x90
> > >> 001:  ret_from_fork+0x35/0x40
> > >> 001: ---[ end trace 0000000000000003 ]---
> > >>
> > >> This patch enlarges the limit to 1 which is the maximum recursion depth we
> > >> have found so far.
> > >>
> > >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> > >> ---
> > > Not sure if this approch can fly, but I also encountered the same
> > > warning (which further caused hangs during VM install) and this change
> > > addresses that.
> > >
> > > I'd be interested in understanding what is the status of this problem/fix.
> > 
> > This is actually v2 of the patch and has not got any reply yet. Here is the v1. FYI.
> > https://lore.kernel.org/lkml/1586257192-58369-1-git-send-email-zhe.he@windriver.com/
> 
> I see, thanks. Hope this gets reviewed soon! :-)
> 
> > > On a side note, by looking at the code, I noticed that (apart from
> > > samples) all callers don't actually check eventfd_signal() return value
> > > and I'm wondering why is that the case and if is it safe to do so.
> > 
> > Checking the return value right after sending the signal can tell us if the
> > event counter has just overflowed, that is, exceeding ULLONG_MAX. I guess the
> > authors of the callers listed in the commit log just don't worry about that,
> > since they add only one to a dedicated eventfd.
> 
> OK. I was mostly wondering if returning early in case the WARN_ON_ONCE
> fires would cause a missing wakeup for the eventfd_ctx wait queue.

Gentle ping about this issue (mainly addressing relevant maintainers and
potential reviewers). It's easily reproducible with PREEMPT_RT.

Thanks,

Juri

