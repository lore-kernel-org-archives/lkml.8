Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929412075B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 06:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeyRTo8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgGFGqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:46:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727089AbgGFGqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594017966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARowG2upYL1FRBFOB0ffQO34fUJQ8qsd+4GQ3s8Aw0w=;
        b=KeyRTo8iqGq4ZtM5DlTvVP+kWJC2Otq/rbL39FrcvAGYuIRXJ0Freed24NjJtGijinMLFp
        CdZhWNT0mNafp9oOOC7AwmJvAPC+egTgyXHKJSLuslGXM+Ih/jn7MnLHCt0tA1QQRVdyMk
        BOcb1DRAmPHFwLhqmcG45dWjXGbLj4Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-qQLL-LhFOWSI1851Wzp1Jg-1; Mon, 06 Jul 2020 02:46:01 -0400
X-MC-Unique: qQLL-LhFOWSI1851Wzp1Jg-1
Received: by mail-wr1-f71.google.com with SMTP id o25so41141035wro.16
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 23:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARowG2upYL1FRBFOB0ffQO34fUJQ8qsd+4GQ3s8Aw0w=;
        b=aiTi5mxgQYYvjytWK/cNhMxznEw4sAxQ5EfC+uAfviv8OPUZZrHIwB4fqEalu26IvR
         M/APLkCd7C0Z3IId6HelP6LlcxjT9lzoMqttm0Lk5NyfzGNrWbkodbSFnMXA3ZQGItr6
         BQICGCgcXs5jt6/Bst+On8pWPYCMF4TEtVtUXT+54ddNwyZHBeCqWfoEI/7jAj9jhBDA
         GJmaC+ntIEaQm73ME8I3jcqX8oMCAA7tsSUznSXvwqcLBHIWjMyXFfPyBSGP8/B/vZrQ
         ZWFnAw8d+vijHP2Tghz9ygZgrCq77iCRUGEZvogERNECrqUGz2kr2xMjmOZueCI0hx6B
         MsMA==
X-Gm-Message-State: AOAM5335Vg+AOhsYXJ2q2a0DLXx82hgj9METwkgmHgFIB2LJ3YmHzHOk
        t1ACr6Qsy6k0+2YjQFAOdDhNlCtkPTSlZ9dpjH/yG8lsPMQdxs4AYj4S8iEUEEKOWSZD/7VpZ86
        l9I9dbQZRLeTRmrLO48kvN8vx
X-Received: by 2002:adf:c551:: with SMTP id s17mr45472946wrf.330.1594017960089;
        Sun, 05 Jul 2020 23:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXKRgv2Yi4GtFNaRL7lNBSGMigmOVf2YwXXf+1ouKxxO0A6r9m6n7Qd3x6f9RjD+e21Ty2cw==
X-Received: by 2002:adf:c551:: with SMTP id s17mr45472928wrf.330.1594017959736;
        Sun, 05 Jul 2020 23:45:59 -0700 (PDT)
Received: from localhost.localdomain ([151.29.90.54])
        by smtp.gmail.com with ESMTPSA id 92sm24328066wrr.96.2020.07.05.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 23:45:59 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:45:57 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200706064557.GA26135@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/20 19:11, He Zhe wrote:
> 
> 
> On 7/3/20 4:12 PM, Juri Lelli wrote:
> > Hi,
> >
> > On 10/04/20 19:47, zhe.he@windriver.com wrote:
> >> From: He Zhe <zhe.he@windriver.com>
> >>
> >> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> >> introduces a percpu counter that tracks the percpu recursion depth and
> >> warn if it greater than zero, to avoid potential deadlock and stack
> >> overflow.
> >>
> >> However sometimes different eventfds may be used in parallel. Specifically,
> >> when heavy network load goes through kvm and vhost, working as below, it
> >> would trigger the following call trace.
> >>
> >> -  100.00%
> >>    - 66.51%
> >>         ret_from_fork
> >>         kthread
> >>       - vhost_worker
> >>          - 33.47% handle_tx_kick
> >>               handle_tx
> >>               handle_tx_copy
> >>               vhost_tx_batch.isra.0
> >>               vhost_add_used_and_signal_n
> >>               eventfd_signal
> >>          - 33.05% handle_rx_net
> >>               handle_rx
> >>               vhost_add_used_and_signal_n
> >>               eventfd_signal
> >>    - 33.49%
> >>         ioctl
> >>         entry_SYSCALL_64_after_hwframe
> >>         do_syscall_64
> >>         __x64_sys_ioctl
> >>         ksys_ioctl
> >>         do_vfs_ioctl
> >>         kvm_vcpu_ioctl
> >>         kvm_arch_vcpu_ioctl_run
> >>         vmx_handle_exit
> >>         handle_ept_misconfig
> >>         kvm_io_bus_write
> >>         __kvm_io_bus_write
> >>         eventfd_signal
> >>
> >> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> >> ---- snip ----
> >> 001: Call Trace:
> >> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> >> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> >> 001:  handle_rx+0xb9/0x900 [vhost_net]
> >> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> >> 001:  vhost_worker+0xbe/0x120 [vhost]
> >> 001:  kthread+0x106/0x140
> >> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> >> 001:  ? kthread_park+0x90/0x90
> >> 001:  ret_from_fork+0x35/0x40
> >> 001: ---[ end trace 0000000000000003 ]---
> >>
> >> This patch enlarges the limit to 1 which is the maximum recursion depth we
> >> have found so far.
> >>
> >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> ---
> > Not sure if this approch can fly, but I also encountered the same
> > warning (which further caused hangs during VM install) and this change
> > addresses that.
> >
> > I'd be interested in understanding what is the status of this problem/fix.
> 
> This is actually v2 of the patch and has not got any reply yet. Here is the v1. FYI.
> https://lore.kernel.org/lkml/1586257192-58369-1-git-send-email-zhe.he@windriver.com/

I see, thanks. Hope this gets reviewed soon! :-)

> > On a side note, by looking at the code, I noticed that (apart from
> > samples) all callers don't actually check eventfd_signal() return value
> > and I'm wondering why is that the case and if is it safe to do so.
> 
> Checking the return value right after sending the signal can tell us if the
> event counter has just overflowed, that is, exceeding ULLONG_MAX. I guess the
> authors of the callers listed in the commit log just don't worry about that,
> since they add only one to a dedicated eventfd.

OK. I was mostly wondering if returning early in case the WARN_ON_ONCE
fires would cause a missing wakeup for the eventfd_ctx wait queue.

Best,

Juri

