Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B58206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTOMPRDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGCIMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:12:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725891AbgGCIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593763937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aL1ix2yKSa96qtp2+jnkXvtwe2HET4gQ2cg4dTxzFd8=;
        b=OTOMPRDJeG4RHuVIZ61CQNXhArP5wj+SqQJaOhYQWvm8bgM9rcrfNtk+3AfRHFhbnlr/bY
        nQ4Q7X3ceBz6cidlP9YbT/i/m2CxwvF4RZG2boOgcPxR5lrN6wq9SYwOWZ1kVR8Ij+Llwf
        YEHAY8jIdtYZ4bnBk4Nev4DrOHjuRYc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-AaxTv_GvPnuXibdgmTo4EQ-1; Fri, 03 Jul 2020 04:12:13 -0400
X-MC-Unique: AaxTv_GvPnuXibdgmTo4EQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so29075222wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aL1ix2yKSa96qtp2+jnkXvtwe2HET4gQ2cg4dTxzFd8=;
        b=ZbqRwMi5tSq0i4APMYTtRzL9RWKeEWPKWQMbnH5wbfBye2ARpIcufHf8Y3VpIMhsSc
         /fRUM1L2wdmuDMWLw5i35sLaYhr+MJJU6ruIud8qbe0XaNxCDVR8vbJYTbfAw2US6bO/
         vrdiYLV0KzgVY/BidXlO0Da4Utiam9ScpfDoMljS1bY9/7hGY/mRaXyiDXnJds4BTYzR
         0QSYB5NezN58u0Q2ndqiFtUx1X3TkiBndcKmISSA02z/PidKj42hSWZmt0jYmycp82AK
         Na9PtXCf1Ca+Ud+edANY+FGNjGJYNCBqlF78+t65qZIEvVCBWFI2RppySWPrSbvFtFrU
         HZ2g==
X-Gm-Message-State: AOAM530fPduCh20NLJhw9uqI2xO47C1N9BkU9LfJYjrXUHXZG5n0jh4Z
        S1C5+MhWtq/LgoaDmV+EPjH1/irDAH1hpo7BcZ9u5ffIdbhuafDhy8l7q5quUZm5q+Ua/7JpFzl
        MfGKx94cGlItRF5LQiBC5wnjg
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr36721014wmk.170.1593763932662;
        Fri, 03 Jul 2020 01:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJVYGoEOd49GzQeCEYy4tVXg5FJD/xHq5tF4vz9PCFVsuygmM68EUfqOhMRS1DSdtX7W+9zQ==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr36720996wmk.170.1593763932436;
        Fri, 03 Jul 2020 01:12:12 -0700 (PDT)
Received: from localhost.localdomain ([151.29.191.109])
        by smtp.gmail.com with ESMTPSA id v11sm49685250wmb.3.2020.07.03.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:12:11 -0700 (PDT)
Date:   Fri, 3 Jul 2020 10:12:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     zhe.he@windriver.com
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200703081209.GN9670@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410114720.24838-1-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/04/20 19:47, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
> 
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
> 
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
> 
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
> 
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---

Not sure if this approch can fly, but I also encountered the same
warning (which further caused hangs during VM install) and this change
addresses that.

I'd be interested in understanding what is the status of this problem/fix.

On a side note, by looking at the code, I noticed that (apart from
samples) all callers don't actually check eventfd_signal() return value
and I'm wondering why is that the case and if is it safe to do so.

Thanks,

Juri

