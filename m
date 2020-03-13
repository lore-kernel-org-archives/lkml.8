Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D391A206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlzSqSKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCMPTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:19:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgCMPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584112753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1BOU8Ryb4eDYX9q0GnCAE4TkNIw/xVsOPssVl8EMSI=;
        b=RlzSqSKtSsi8ePEk8A3y4JZpAw92BPF/ximbPLTqIEcS9IQ2yifHdIjAW0kFgca1s0Oyr3
        9ZxbZ2ItD9Gj/pnUJE6tvvro7NIbpd+V0V17gFdMr7aa/PYzpMy6T+dy3F2LwFVoKoGI4k
        0MH+nySTjRCWdfthQSGPg5hsRLuLANg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-pPVoNVW4PZGs8d3lwXVU1w-1; Fri, 13 Mar 2020 11:19:11 -0400
X-MC-Unique: pPVoNVW4PZGs8d3lwXVU1w-1
Received: by mail-qk1-f200.google.com with SMTP id c1so6207060qkg.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1BOU8Ryb4eDYX9q0GnCAE4TkNIw/xVsOPssVl8EMSI=;
        b=r8rOhHAKMEkQ5CNSmLY/GB49d1xHsUl9aegniNaR+m9BexgZYxLqAOZ0LLUB0YRwUG
         fOYtU/NO2xIVeymIfx6gRCBVhmg4XofkBuAY2NcHbqHUjz0mDk+wupfo/JVRe+VrSD6O
         GzNHOQvdtTq4h61Ze28PzI4SwcPBvDrQ4/VPge4A0hFC6SW06oXG4zsRz/52mB35t8rq
         R+TK0U09s5cHNOY3lXfREVWPcWWgTm9TknGGkUDXef9qw8/CYS5vcgYtvuU+avKi2TRW
         e+oT+rMpn52Z8geXhw2xObT7YoPz8sC6nbLRWYzOAac4zMeDTePfcuuuMDpeCKwtMfpO
         fQ5Q==
X-Gm-Message-State: ANhLgQ3paSFJCAJmPk6VFLlA7WLkSDyP3N4RPkFbwjavBItOKO/DkSq1
        l6ydNlbOUB5okVQljbZ5KRTAkiwOKGlBEKnOKG+SB/+xo3LNf6cVnDsLkPgobliXKbi3A627gam
        hSC7RAz/yPH44BZRbiwB2OAn1
X-Received: by 2002:a37:6411:: with SMTP id y17mr13891160qkb.437.1584112751202;
        Fri, 13 Mar 2020 08:19:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupAH6cqSYPKnWKz3hPKhftLx9/aFvP9znQhGbGdRV0AErbIBzYh1MW737PUnv4mpawLxfdPw==
X-Received: by 2002:a37:6411:: with SMTP id y17mr13891130qkb.437.1584112750917;
        Fri, 13 Mar 2020 08:19:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v19sm14308824qtb.67.2020.03.13.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:19:10 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:19:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
Message-ID: <20200313151908.GA95517@xz-x1>
References: <20200312205830.81796-1-peterx@redhat.com>
 <878sk4ib93.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878sk4ib93.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:24:08PM +0100, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > After we introduced the "managed_irq" sub-parameter for isolcpus, it's
> > possible to free a kernel managed irq vector now.
> >
> > It can be triggered easily by booting a VM with a few vcpus, with one
> > virtio-blk device and then mark some cores as HK_FLAG_MANAGED_IRQ (in
> > below case, there're 4 vcpus, with vcpu 3 isolated with managed_irq):
> >
> > [    2.889911] ------------[ cut here ]------------
> > [    2.889964] WARNING: CPU: 3 PID: 0 at arch/x86/kernel/apic/vector.c:853 free_moved_vector+0x126/0x160
> 
> <SNIP>
> 
> > [    2.890026] softirqs last disabled at (8757): [<ffffffffbb0ecccd>] irq_enter+0x4d/0x70
> > [    2.890027] ---[ end trace deb5d563d2acb13f ]---
> 
> What is this backtrace for? It's completly useless as it merily shows
> that the warning triggers. Also even if it'd be useful then it wants to
> be trimmed properly.

I thought it was a good habit to keep the facts of issues.  Backtrace
is one of them so I kept them.  It could, for example, help people who
spot the same issue in an old/downstream kernel so when they google or
grepping git-log they know the exact issue has been solved by some
commit, even without much knowledge on the internals (because they can
exactly compare the whole dmesg error).

> 
> > I believe the same thing will happen to bare metals.
> 
> Believe is not really relevant in engineering.
> 
> The problem has nothing to do with virt or bare metal. It's a genuine
> issue.
> 
> > When allocating the IRQ for the device, activate_managed() will try to
> > allocate a vector based on what we've calculated for kernel managed
> > IRQs (which does not take HK_FLAG_MANAGED_IRQ into account).  However
> > when we bind the IRQ to the IRQ handler, we'll do irq_startup() and
> > irq_do_set_affinity(), in which we will start to consider the whole
> > HK_FLAG_MANAGED_IRQ logic.  This means the chosen core can be
> > different from when we do the allocation.  When that happens, we'll
> > need to be able to properly free the old vector on the old core.
> 
> There's lots of 'we' in that text. We do nothing really. Please describe
> things in neutral and factual language.
> 
> Also there is another way to trigger this: Offline all non-isolated CPUs
> in the mask and then bring one online again.

Thanks for your suggestions on not using subjective words and so on.
I'll remember these.

However I think I still miss one thing in the puzzle (although it
turns out that we've agreed on removing the warning already, but just
in case I missed something important) - do you mean that offlining all
the non-isolated CPUs in the mask won't trigger this already?  Because
I also saw some similar comment somewhere else...

Here's my understanding - when offlining, we'll disable the CPU and
reach:

  - irq_migrate_all_off_this_cpu
    - migrate_one_irq
      - irq_do_set_affinity
        - calculate HK_FLAG_MANAGED_IRQ and so on...

Then we can still trigger this irq move event even before we bring
another housekeeping cpu online, right?  Or could you guide me on what
I have missed?

Thanks,

-- 
Peter Xu

