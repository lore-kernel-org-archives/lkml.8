Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E162C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5989205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ago46R+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbgENAV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732847AbgENAV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:21:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0A1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:28 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y13so928252vsk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBLBg/Pi2nLTYpT77RqGN75i0jKE/4YyC2iRVJu8R0U=;
        b=Ago46R+bOlJOlbr3ydxhX8fE13MVcv+tDV1HihlMB/XR/x+7cAnOdthEYc9oKzfg1q
         jr1tivPXu8P/UvKgCSv0AP6E6nKMIfRK3Ihr2/2wNCE1DK/w4n3DND0BROpYOs+ayD4X
         GSr8act4VPC/w9zO19A9XBVjS/13ospHw5fjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBLBg/Pi2nLTYpT77RqGN75i0jKE/4YyC2iRVJu8R0U=;
        b=arltoHc05L4V4iUEC0wzI0PvF/+8ntfl9xaay2jgYva18UwPVvZXaUAbge3kts9Jjc
         Ye3u4YBvkvBtSsXvpNg0fzp2Plp9j7sjqqAbA35UvQ0dJNeiBIBsVMORqUm5kP5YH9Tz
         b+9lybginmLtjTUm5vvJ7JfhLbf/nVfuafBa9ApB4JyLXd48fNCq5J+jjqzj7xJmQSYP
         booO16VgqVdwSrzhltJ5SbSxZw+H0OXyT/tIVHFCvQuFEa32gziN3YAF27xXmqNbC8yx
         MO8sGXvxR4UL4Q32LmWpNJlydYhohFDnb9/j6MZB9hNr9Xr5Hnemc+gzbe96L5Ijzsk/
         q9Ag==
X-Gm-Message-State: AOAM530YxVNcAIQ98BvUQpseaD02JVWcyLePLDqa96yHdCIe/VXOD2fI
        82+ADLZrcaj737GX2HsQwlbddhGIUzs=
X-Google-Smtp-Source: ABdhPJzdtlohToywcKzaXEZ9hqqZuZvEnjC6nDqtVNFlVJzXve1GvHu+1D58KQM7n3qBlOS3XaQo0Q==
X-Received: by 2002:a67:7f0a:: with SMTP id a10mr1491509vsd.147.1589415686574;
        Wed, 13 May 2020 17:21:26 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id b6sm306395vka.38.2020.05.13.17.21.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:21:25 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id f7so329794vkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:21:24 -0700 (PDT)
X-Received: by 2002:a1f:d0c5:: with SMTP id h188mr1639201vkg.0.1589415684421;
 Wed, 13 May 2020 17:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <20200509214159.19680-2-liwei391@huawei.com>
In-Reply-To: <20200509214159.19680-2-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 17:21:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+EGz5nRoPXa_V+85FDwHjnAK6-ubH0zv1gGROKNZhPg@mail.gmail.com>
Message-ID: <CAD=FV=U+EGz5nRoPXa_V+85FDwHjnAK6-ubH0zv1gGROKNZhPg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: kgdb: Fix single-step exception handling oops
To:     Wei Li <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>
> After entering kdb due to breakpoint, when we execute 'ss' or 'go' (will
> delay installing breakpoints, do single-step first), it won't work
> correctly, and it will enter kdb due to oops.
>
> It's because the reason gotten in kdb_stub() is not as expected, and it
> seems that the ex_vector for single-step should be 0, like what arch
> powerpc/sh/parisc has implemented.
>
> Before the patch:
> Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff8000101486cc (printk)
>     is enabled   addr at ffff8000101486cc, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fa878040, pid 266) on processor 3 due to Breakpoint @ 0xffff8000101486cc
> [3]kdb> ss
>
> Entering kdb (current=0xffff0000fa878040, pid 266) on processor 3 Oops: (null)
> due to oops @ 0xffff800010082ab8
> CPU: 3 PID: 266 Comm: sh Not tainted 5.7.0-rc4-13839-gf0e5ad491718 #6
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000085 (nzcv daIf -PAN -UAO)
> pc : el1_irq+0x78/0x180
> lr : __handle_sysrq+0x80/0x190
> sp : ffff800015003bf0
> x29: ffff800015003d20 x28: ffff0000fa878040
> x27: 0000000000000000 x26: ffff80001126b1f0
> x25: ffff800011b6a0d8 x24: 0000000000000000
> x23: 0000000080200005 x22: ffff8000101486cc
> x21: ffff800015003d30 x20: 0000ffffffffffff
> x19: ffff8000119f2000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 0000000000000000
> x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : ffff800015003e50
> x7 : 0000000000000002 x6 : 00000000380b9990
> x5 : ffff8000106e99e8 x4 : ffff0000fadd83c0
> x3 : 0000ffffffffffff x2 : ffff800011b6a0d8
> x1 : ffff800011b6a000 x0 : ffff80001130c9d8
> Call trace:
>  el1_irq+0x78/0x180
>  printk+0x0/0x84
>  write_sysrq_trigger+0xb0/0x118
>  proc_reg_write+0xb4/0xe0
>  __vfs_write+0x18/0x40
>  vfs_write+0xb0/0x1b8
>  ksys_write+0x64/0xf0
>  __arm64_sys_write+0x14/0x20
>  el0_svc_common.constprop.2+0xb0/0x168
>  do_el0_svc+0x20/0x98
>  el0_sync_handler+0xec/0x1a8
>  el0_sync+0x140/0x180
>
> [3]kdb>
>
> After the patch:
> Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff8000101486cc (printk)
>     is enabled   addr at ffff8000101486cc, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to Breakpoint @ 0xffff8000101486cc
> [0]kdb> g
>
> Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to Breakpoint @ 0xffff8000101486cc
> [0]kdb> ss
>
> Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to SS trap @ 0xffff800010082ab8
> [0]kdb>
>
> Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/kernel/kgdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As far as I can tell this looks right.  Specifically in kdb_stub() I
see that it needs "ks->ex_vector == 0" to get "reason" as
KDB_REASON_SSTEP.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


I did really basic testing of this series as a whole and things that
used to be broken for me around stepping / going past breakpoints are
now fixed.  I'll keep using it more, but it definitely feels like it
makes things happier.

Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
