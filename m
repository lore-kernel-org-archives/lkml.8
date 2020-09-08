Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6585421D1B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8CWiqHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgIHAiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 20:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgIHAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 20:38:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04316C061573;
        Mon,  7 Sep 2020 17:38:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z25so15277738iol.10;
        Mon, 07 Sep 2020 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDR6IsWSX2xd81R8pk5pE8RqAtPXHJYLYB8HvcgF40Q=;
        b=F8CWiqHclIEdY8g1HNYHVl1wXcuDgUrP5VqGkVOqMlgxVsnhY/g3zHfKmnNqKfx5rr
         lXjBlca+wJp2qFC+oRwEyKderhMcdUV0i/HGtdc+kmTwSgcLTkHx1gZV650Qtwgr8DSN
         cfbpMV23yjcPd2htmPPRJE+sb8EX9u2sUA0i0hkP47BGaSgO+bEOZhwsIV53SLn+pjEc
         4auekbs2AZ/26MipcOlJbnv0c4YNagTq8IBYIigGIHdxugF7rPGLDzNt/NRCnmEBxZqX
         hHbmHjn91tAT2P+0g2zQy+6XpNSZP+H0QwsX3ytZmPsllFgKw2pVcNFXHbJCDD9pkPK1
         yIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDR6IsWSX2xd81R8pk5pE8RqAtPXHJYLYB8HvcgF40Q=;
        b=Lt+NO1V+JlwZQYQamgmLMABfurJsKQfB3NTiqWWKCJF0DEFcbRfschTFRDXGE9M0sd
         V0d6HZsx1zE76F6nSiQIheu79Qe7+6B7BHSiFDFWqAQk8nm9nMjZ8VWiJ7rb6sxbd4QC
         mlxl5ULJE4IijlkAaBwibfLcrfK+3fkVdMkP1Fkepowhfg+wTRRRLj9z0mrKbZ8u5f6C
         nku/BUSpVD0OyyVTpqcNwq48SjEEAmkBTgTJ4BueQ57Qw4cxLwkJ89kr98125/iQNkrp
         gV56Icb3OCdj9BDeO8cF4KwV83VH+z9UB/CTZ5xbbF1YRI+32CAwJRlsXm25Nb89mLeH
         GJsw==
X-Gm-Message-State: AOAM5324XdEJkLKh7zDQwNa9JBA/D4UYdA0tXG+PK0zUEUWAGOhgbklg
        SQeVe2Kn9hzykt1y2wukeXkv5CQBpyXq6tp1w9P/u+U8Z38=
X-Google-Smtp-Source: ABdhPJyKNOiTqAZYzxBv2arYN0x03aWPF1RbNx7tn+o1OGJW+GJAeuV1DOsC/QQ8ZOF2/hEVe7ATtCVswkAox0zLEAo=
X-Received: by 2002:a5d:8604:: with SMTP id f4mr254925iol.196.1599525489023;
 Mon, 07 Sep 2020 17:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <1598348388-2518-1-git-send-email-yangtiezhu@loongson.cn> <s5hsgcb59gw.wl-tiwai@suse.de>
In-Reply-To: <s5hsgcb59gw.wl-tiwai@suse.de>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 8 Sep 2020 08:37:56 +0800
Message-ID: <CAAhV-H5V5adhY2OjJLxW7x3zDaHGgBxxy45hjf22+qMSEBQuww@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "ALSA: hda: Add support for Loongson 7A1000 controller"
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

This patch should be backported to 5.4.

Huacai

On Tue, Aug 25, 2020 at 6:03 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 25 Aug 2020 11:39:48 +0200,
> Tiezhu Yang wrote:
> >
> > This reverts commit 61eee4a7fc40 ("ALSA: hda: Add support for Loongson
> > 7A1000 controller") to fix the following error on the Loongson LS7A
> > platform:
> >
> > rcu: INFO: rcu_preempt self-detected stall on CPU
> > <SNIP>
> > NMI backtrace for cpu 0
> > CPU: 0 PID: 68 Comm: kworker/0:2 Not tainted 5.8.0+ #3
> > Hardware name:  , BIOS
> > Workqueue: events azx_probe_work [snd_hda_intel]
> > <SNIP>
> > Call Trace:
> > [<ffffffff80211a64>] show_stack+0x9c/0x130
> > [<ffffffff8065a740>] dump_stack+0xb0/0xf0
> > [<ffffffff80665774>] nmi_cpu_backtrace+0x134/0x140
> > [<ffffffff80665910>] nmi_trigger_cpumask_backtrace+0x190/0x200
> > [<ffffffff802b1abc>] rcu_dump_cpu_stacks+0x12c/0x190
> > [<ffffffff802b08cc>] rcu_sched_clock_irq+0xa2c/0xfc8
> > [<ffffffff802b91d4>] update_process_times+0x2c/0xb8
> > [<ffffffff802cad80>] tick_sched_timer+0x40/0xb8
> > [<ffffffff802ba5f0>] __hrtimer_run_queues+0x118/0x1d0
> > [<ffffffff802bab74>] hrtimer_interrupt+0x12c/0x2d8
> > [<ffffffff8021547c>] c0_compare_interrupt+0x74/0xa0
> > [<ffffffff80296bd0>] __handle_irq_event_percpu+0xa8/0x198
> > [<ffffffff80296cf0>] handle_irq_event_percpu+0x30/0x90
> > [<ffffffff8029d958>] handle_percpu_irq+0x88/0xb8
> > [<ffffffff80296124>] generic_handle_irq+0x44/0x60
> > [<ffffffff80b3cfd0>] do_IRQ+0x18/0x28
> > [<ffffffff8067ace4>] plat_irq_dispatch+0x64/0x100
> > [<ffffffff80209a20>] handle_int+0x140/0x14c
> > [<ffffffff802402e8>] irq_exit+0xf8/0x100
> >
> > Because AZX_DRIVER_GENERIC can not work well for Loongson LS7A HDA
> > controller, it needs some workarounds which are not merged into the
> > upstream kernel at this time, so it should revert this patch now.
> >
> > Fixes: 61eee4a7fc40 ("ALSA: hda: Add support for Loongson 7A1000 controller")
> > Cc: <stable@vger.kernel.org> # 5.9-rc1+
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >
> > v2: update commit message
>
> Applied now.  Thanks.
>
>
> Takashi
