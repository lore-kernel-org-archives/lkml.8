Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ABD20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 00:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUYO9lkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbgGaAYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbgGaAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 20:24:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:24:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so21182387iob.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 17:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHN+uLmX/K+mPuq0yzanWuXPqaWti8JxXwhQ/gYkGRk=;
        b=FUYO9lkPyHatjuEszFnSwiGD+PXO+vxOLyPE4yKhHZqNztOA82IJxgjjzOsRYaUQ8B
         lQM3KWBdDVwNcctLD3jqcQN2kMXkgZ8iF04zd75apQmHrUvkLdV7UavTfPV0HX/W2nPL
         +uf3qXlTFLJx29m9dtIyA0WvLgdUqoQT6iCvQp4P55G0uY1JpBzYn9X3/HMj4H7wDc6u
         FMTjW09sWrY2OQljOaS5+mFeIfputr77xApl47IrF0gZOY8o0GNB+lqhmofFQHq3snf4
         l6i0I/nq8HyzY5VCrAZx52HurPnL/2xG01gMYU+EyXd8csYo4Ks1i1XTVzFI9JS3okVu
         lSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHN+uLmX/K+mPuq0yzanWuXPqaWti8JxXwhQ/gYkGRk=;
        b=osmBdIPbgHyReFAZ+8PM2aZBI7w7ikK32+YKw2Jk3XpiUfK+8l4XWnxByOEhEmFz2a
         dR7FbiwDp1Nmd5DBowLiIyc8hy1VPBDgQ24a0RDgh363l9lWZs6e9xoBKL7gDwe1PIWP
         qFQU5HRwtKXbWiQEX80ANWxGKxDRKdwAvLuqdF2PjDQ1YmEwKvJMO2lmUaDlC1LcihSY
         hGZwp9AoLRKdl0+gqi6AqENlhf5RsWBWCLj1oVGCaqtdCliYiV4Zf9NNX61BiM2G6oJa
         MPiKlTYKiui6lH35haId1lpBhAlF27Qcudlden8av81/n750r1biNx3ogPB06ZHvFbY7
         ylTw==
X-Gm-Message-State: AOAM530GOE0PWvyQ9sVv+ttounR5KanUm63Qg1hH9HavWEY7DjxsOG4B
        eoNI8pl3dRxQdSRuXZbFAUQ1WBmQBRtADb10j2I4+kE2jyw=
X-Google-Smtp-Source: ABdhPJxyZ/h30LSwdVIrYA8bGG5bEGrUyMiWadHXnrVkH5NfDq6vQSvM2Mh1XSBK8wkqKC42pmDW+OSieoGbGGZZR8M=
X-Received: by 2002:a6b:8d03:: with SMTP id p3mr1153341iod.114.1596155051462;
 Thu, 30 Jul 2020 17:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com> <20200730095842.3e438960@oasis.local.home>
In-Reply-To: <20200730095842.3e438960@oasis.local.home>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 31 Jul 2020 08:24:00 +0800
Message-ID: <CAGWkznH=Vkow_x2=b=+MfHnAnoSK36CSZ63-a5F7ZQL=GNkn_Q@mail.gmail.com>
Subject: Re: [PATCH] trace : use kvmalloc instead of kmalloc
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 9:58 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 30 Jul 2020 19:04:12 +0800
> Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> > High order memory stuff within trace could introduce OOM, use kvmalloc instead.
> >
> > Please find the bellowing for the call stack we run across in an android system. The scenario happens when traced_probes is woken up to get a large quantity of trace even if free memory is even higher than watermark_low.
>
> Please limit your column width in the description of patches to 76
> characters.
>
> >
> > traced_probes invoked oom-killer: gfp_mask=0x140c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),  order=2, oom_score_adj=-1
> >
>
> What does this traced_probes thing do?
traced_probes is an android exe which reads ftrace and writes them to
files. I think kzalloc works fine for most of context but will cause
OOM in high ratio ftrace access in memory constraint system, like
mobilephone etc.
>
> > traced_probes cpuset=system-background mems_allowed=0
> > CPU: 3 PID: 588 Comm: traced_probes Tainted: G        W  O    4.14.181 #1
> > Hardware name: Generic DT based system
> > (unwind_backtrace) from [<c010d824>] (show_stack+0x20/0x24)
> > (show_stack) from [<c0b2e174>] (dump_stack+0xa8/0xec)
> > (dump_stack) from [<c027d584>] (dump_header+0x9c/0x220)
> > (dump_header) from [<c027cfe4>] (oom_kill_process+0xc0/0x5c4)
> > (oom_kill_process) from [<c027cb94>] (out_of_memory+0x220/0x310)
> > (out_of_memory) from [<c02816bc>] (__alloc_pages_nodemask+0xff8/0x13a4)
> > (__alloc_pages_nodemask) from [<c02a6a1c>] (kmalloc_order+0x30/0x48)
> > (kmalloc_order) from [<c02a6a64>] (kmalloc_order_trace+0x30/0x118)
> > (kmalloc_order_trace) from [<c0223d7c>] (tracing_buffers_open+0x50/0xfc)
> > (tracing_buffers_open) from [<c02e6f58>] (do_dentry_open+0x278/0x34c)
> > (do_dentry_open) from [<c02e70d0>] (vfs_open+0x50/0x70)
> > (vfs_open) from [<c02f7c24>] (path_openat+0x5fc/0x169c)
> > (path_openat) from [<c02f75c4>] (do_filp_open+0x94/0xf8)
> > (do_filp_open) from [<c02e7650>] (do_sys_open+0x168/0x26c)
> > (do_sys_open) from [<c02e77bc>] (SyS_openat+0x34/0x38)
> > (SyS_openat) from [<c0108bc0>] (ret_fast_syscall+0x0/0x28)
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > changes since v1: change kfree to kvfree
> > ---
> >  kernel/trace/trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index ca1ee65..8d70c79 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6891,7 +6891,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
> >       if (trace_array_get(tr) < 0)
> >               return -ENODEV;
> >
> > -     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +     info = kvmalloc(sizeof(*info), GFP_KERNEL);
>
> The above is a bug. It converts kzalloc() to kvmalloc() instead of
> kvzalloc().
fixed and resend with patch v2
>
> -- Steve
>
>
>
> >       if (!info) {
> >               trace_array_put(tr);
> >               return -ENOMEM;
> > @@ -7017,7 +7017,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
> >       if (info->spare)
> >               ring_buffer_free_read_page(iter->trace_buffer->buffer,
> >                                          info->spare_cpu, info->spare);
> > -     kfree(info);
> > +     kvfree(info);
> >
> >       mutex_unlock(&trace_types_lock);
> >
>
