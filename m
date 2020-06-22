Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F0C251C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGB/qPNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgFVHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:07:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726850AbgFVHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592809664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3157A3Oov0ALss4RHvOZqUEF+QQXhCevgdBSsdEPpE=;
        b=JGB/qPNsrvA/FIQhiYr74GbWCGV5bSPiqnkDqnje/0P95E3lVF9i0qeAOKK/GnpAfMDpTi
        yPCZ+obA4MDYtuYrXGleZxy7rqCCtUXtZZWDJsVYNh1/5FCgdlSUKobKNHCASNeDJ4l00M
        7iQ5on0pkf5UzaQzLYmRJLhTcDwg2Bc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-j8eqSvhSOCOXrnWfWfLR6Q-1; Mon, 22 Jun 2020 03:07:40 -0400
X-MC-Unique: j8eqSvhSOCOXrnWfWfLR6Q-1
Received: by mail-wm1-f69.google.com with SMTP id u15so6453830wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T3157A3Oov0ALss4RHvOZqUEF+QQXhCevgdBSsdEPpE=;
        b=B2skuwkIFacA60vphIPipVZ8wt+7nJtGTekBPMkaqnn+gRrZ46PPZLg7n0wc8juUjQ
         ijCu5c29Jo/iiV45AC5HGTmq7gi5w/94eMjGFUt1YxJZYWC1WO117XjtZ7WxoTfzsZp5
         cs7TRCWWAe5l/Ju1wUY9avNRy3pHq8xBmZ/sJxzDzDemRpidS/FZ6pIicM9prXwoMujs
         T/bDZXO7PMfOoSOOU4Oq2pSr+K8eRc1Ie72bLpV6TkVEkDr/TaHIc9K5b23sPYu66utM
         bhXmnhjmv6DxKRUqsstFf2LYmTlmmBy6zEFUeMl8JaGrUCJ8g2WTu8uuiQ9qaqIQ6ut/
         9mmw==
X-Gm-Message-State: AOAM531XnixQpg7WmDufiBuzbvMqgUkPbfWHtfUBThxicgcbfZTUW/1L
        oKsi/GSHdISCsHxTIFkPlWFOIYOCmkllh/NkvGyeAx8gP8P8HGA2LrAx9R+6XX0oGr0qtrH6C2c
        Cxyl8+TCnn3tSbCryNOAWNNf6
X-Received: by 2002:adf:afdb:: with SMTP id y27mr16953983wrd.267.1592809658603;
        Mon, 22 Jun 2020 00:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzO1254U/7rdCDBDbKkv8litm7qLIHJGh9jOiwClbTVucvZPA1wuWp+hjNR2TfLDpPwxqkWA==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr16953952wrd.267.1592809658333;
        Mon, 22 Jun 2020 00:07:38 -0700 (PDT)
Received: from localhost.localdomain ([151.29.187.107])
        by smtp.gmail.com with ESMTPSA id 63sm17963959wra.86.2020.06.22.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:07:37 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:07:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com,
        syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] sched/deadline: Initialize dl_boosted
Message-ID: <20200622070735.GA5763@localhost.localdomain>
References: <20200617072919.818409-1-juri.lelli@redhat.com>
 <20200617204939.2k7scf422tx2xvhe@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617204939.2k7scf422tx2xvhe@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/06/20 22:49, Daniel Wagner wrote:
> Hi Juri,
> 
> On Wed, Jun 17, 2020 at 09:29:19AM +0200, Juri Lelli wrote:
> > This happens because dl_boosted flag is currently not initialized by
> > __dl_clear_params() (unlike the other flags) and setup_new_dl_entity()
> > finds complains about it.
> > 
> > Initialize dl_boosted to 0.
> > 
> > Reported-by: syzbot+5ac8bac25f95e8b221e7@syzkaller.appspotmail.com
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Tested-by: Daniel Wagner <dwagner@suse.de>
> 
> Well, as it turns I can't trigger a warning on mainline but pretty simple on
> RT (5.6.14-rt7-rt):
> 
>  invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
>  CPU: 1 PID: 317 Comm: 0d19f76ecda7c30 Not tainted 5.6.14-rt7-rt #2
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>  RIP: 0010:enqueue_task_dl+0x71/0x3b0
>  Code: 74 28 41 83 fc 20 75 22 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 8d a8 b8 02 00 00 f6 c2 02 75 0c 8b 45 74 85 c0 78 2
>  RSP: 0018:ffffc90000673ba8 EFLAGS: 00010002
>  
>  RAX: ffff88807e87a700 RBX: 00000000ffffffff RCX: 0000000000000078
>  RDX: 0000000000000002 RSI: 0000000000000078 RDI: ffff88807c52bb80
>  RBP: ffff88800feda700 R08: ffff88807e87a700 R09: ffffffff81e43ea0
>  R10: 0000000000000000 R11: 000000000000006d R12: 000000000000002e
>  R13: 0000000000000078 R14: ffff88807c52bb80 R15: ffff88800feda9b8
>  FS:  000000000175c880(0000) GS:ffff88807c500000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fff9cbfa000 CR3: 000000007c4b2000 CR4: 00000000000006e0
>  Call Trace:
>   ? dequeue_task_fair+0x67/0x2b0
>   rt_mutex_setprio+0x39f/0x510
>   ? __switch_to_asm+0x34/0x70
>   task_blocks_on_rt_mutex+0x2a4/0x390
>   ? __switch_to_asm+0x40/0x70
>   ? __switch_to_asm+0x34/0x70
>   rt_spin_lock_slowlock_locked+0xb2/0x2c0
>   ? _raw_spin_unlock_irq+0x1d/0x50
>   ? finish_task_switch+0xa0/0x2e0
>   rt_spin_lock_slowlock+0x51/0x80
>   __local_bh_disable_ip+0x7f/0xa0
>   hrtimer_cancel_wait_running+0x31/0x70
>   hrtimer_cancel+0x1f/0x30
>   futex_wait+0x1e9/0x240
>   ? __hrtimer_init+0xe0/0xe0
>   do_futex+0x10a/0x1d0
>   __x64_sys_futex+0x134/0x162
>   do_syscall_64+0x69/0x110
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x445b89
>  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
>  RSP: 002b:00007fff9cbe2498 EFLAGS: 00000206
>   ORIG_RAX: 00000000000000ca
>  RAX: ffffffffffffffda RBX: 00000000004004e8 RCX: 0000000000445b89
>  RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000004ca3ec
>  RBP: 00007fff9cbe24e0 R08: 0000000000003fdc R09: 000000000000002d
>  R10: 00007fff9cbe24b0 R11: 0000000000000206 R12: 0000000000408bb0
>  R13: 0000000000000000 R14: 00000000004c8018 R15: 00000000004004e8
>  Modules linked in:
> 
> This looks similar to the one reported here:
> 
>   [PATCH 0/2] Fix SCHED_DEADLINE nested priority inheritance
>   https://lore.kernel.org/lkml/20191112075056.19971-1-juri.lelli@redhat.com/

I will have a look, thanks.

Best,

Juri

