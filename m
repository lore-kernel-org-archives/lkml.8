Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E962207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 00:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTgvXMwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgEVAKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 20:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgEVAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 20:10:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 17:10:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e11so3366463pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxJBUDh7pIk7wevtghR6V6BanARnmm04Ny6FWkU1Tdk=;
        b=nTgvXMwV0MVMm4Yul1nXwML0h6r6yP1iDZvpkJ8CUFgS/Liv8JT8huhcVjfpGKWAF4
         Uh7mTIilvObSbBeNNI9tYYhHV34FSJiHxZ3E5YvZL7/Oyd5vpI/AO5IX34ewdXy9FvzQ
         BaxSr+O0jY+4XC3T2qFNgJ7cVjt3d9Ztw55O/WPThh1myymkSeqzC6dQa/7QxPw0swfd
         Y7jd0n2zQbsf+vyyguwQgZ4AsLH6b5KuMM4Zn0zSMyV3viOco70Wd7DJ5vbpU/icvTM6
         4RGOUBbPvjgV44d3WqdFck5oRgpXnGJ4074EVoEu30G6R3haw7vg7JV3LL6PmIdg4hZb
         r2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxJBUDh7pIk7wevtghR6V6BanARnmm04Ny6FWkU1Tdk=;
        b=AdsdBjo5UqqcCVyihlL/NdTWl98pNGumS8hvXQBIa6l5eMZBc7+n6y07FYcWuMVD9g
         D/GXKE4UI197NYEfJTRepEajNpFdMz40CbnmF/ntjzgMRrRFiuUad+bRhlE1L3kRhe0+
         iquYMCOhpA89SpVvJHlx5aBB6pBH0RbNaxplwAIUFHrHZK60uXcf4BOJ5SoZucRrhsj+
         cV/g60DUMcNd6O0jsy9qlZd9Bc3U/xJu1hVnCoytcMDOE3MyTqykgaNK7LO3gSyXk575
         p/t/LNVtUtCw1pR5VmYKNxRbggwWo6XrhGRttpmjWhshsl8QKKlNqMRud/1x6XkTkes/
         8ITA==
X-Gm-Message-State: AOAM532XD1bcLVHGaeZh04OkLSJtCq0ittXFqKEKlO0ivMSOcWsQTbOz
        mfsRM5NY/W6sD1vGP07vluE=
X-Google-Smtp-Source: ABdhPJzoe65AGyLc6b1ml4flukCZZLYowWbn6SZ26RtXpasGQn9PJbjoNL+fwiBEWarKMavKqq326A==
X-Received: by 2002:a05:6a00:14d5:: with SMTP id w21mr1192249pfu.53.1590106223610;
        Thu, 21 May 2020 17:10:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id m12sm5267634pjs.41.2020.05.21.17.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 17:10:22 -0700 (PDT)
Date:   Thu, 21 May 2020 17:10:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH] vt: keyboard: avoid integer overflow in k_ascii
Message-ID: <20200522001020.GA89269@dtor-ws>
References: <20200521013400.GA2240@pizza01>
 <20200521063602.GZ89269@dtor-ws>
 <20200521233138.GA5469@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521233138.GA5469@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:31:39PM +0000, Kyungtae Kim wrote:
> On Wed, May 20, 2020 at 11:36:02PM -0700, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On Thu, May 21, 2020 at 01:34:08AM +0000, Kyungtae Kim wrote:
> > > FuzzUSB (a variant of syzkaller) found an integer overflow 
> > > while processing keycode value.
> > > 
> > > Reference: https://lkml.org/lkml/2020/3/22/482
> > > 
> > > This bug occurs because of no validity check when operating keycode values.
> > > By executing k_ascii() multiple times, npadch can have a large value 
> > > close to the max of int type e.g., 1111111111. 
> > > In the following, its muliplication causes an integer overflow.
> > > 
> > > This fix prevents the overflow by checking npadch using check_mul_overflow() 
> > > ahead of its operation.
> > > 
> > > 
> > > UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c:888:19
> > > signed integer overflow:
> > > 10 * 1111111111 cannot be represented in type 'int'
> > > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.11 #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> > > Call Trace:
> > >  <IRQ>
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0xce/0x128 lib/dump_stack.c:118
> > >  ubsan_epilogue+0xe/0x30 lib/ubsan.c:154
> > >  handle_overflow+0xdc/0xf0 lib/ubsan.c:184
> > >  __ubsan_handle_mul_overflow+0x2a/0x40 lib/ubsan.c:205
> > >  k_ascii+0xbf/0xd0 drivers/tty/vt/keyboard.c:888
> > >  kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
> > >  kbd_event+0x888/0x3be0 drivers/tty/vt/keyboard.c:1495
> > >  input_to_handler+0x3a9/0x4b0 drivers/input/input.c:118
> > >  input_pass_values.part.8+0x25e/0x690 drivers/input/input.c:145
> > >  input_pass_values drivers/input/input.c:193 [inline]
> > >  input_repeat_key+0x1f8/0x2c0 drivers/input/input.c:194
> > >  call_timer_fn+0x20e/0x770 kernel/time/timer.c:1404
> > >  expire_timers kernel/time/timer.c:1449 [inline]
> > >  __run_timers kernel/time/timer.c:1773 [inline]
> > >  run_timer_softirq+0x63f/0x13c0 kernel/time/timer.c:1786
> > >  __do_softirq+0x262/0xb46 kernel/softirq.c:292
> > >  invoke_softirq kernel/softirq.c:373 [inline]
> > >  irq_exit+0x161/0x1b0 kernel/softirq.c:413
> > >  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> > >  smp_apic_timer_interrupt+0x137/0x500 arch/x86/kernel/apic/apic.c:1146
> > >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> > >  </IRQ>
> > > RIP: 0010:default_idle+0x2d/0x2e0 arch/x86/kernel/process.c:696
> > > Code: e5 41 57 41 56 65 44 8b 35 30 9d 5d 7a 41 55 41 54 53 0f 1f 44 00 00 e8 11 42 a4 fb e9 07 00 00 00 0f 00 2d d5 29 5e 00 fb f4 <65> 44 8b 35 0b 9d 5d 7a 0f 1f 44 00 00 5b 41 5c 41 5d 41 5e 41 5f
> > > RSP: 0018:ffffffff87007ce8 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff13
> > > RAX: 0000000000000007 RBX: ffffffff87032900 RCX: 0000000000000000
> > > RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff87033154
> > > RBP: ffffffff87007d10 R08: fffffbfff0e06521 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > R13: ffffffff88c99c00 R14: 0000000000000000 R15: 0000000000000000
> > >  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:686
> > >  default_idle_call+0x50/0x70 kernel/sched/idle.c:94
> > >  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
> > >  do_idle+0x332/0x530 kernel/sched/idle.c:269
> > >  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:361
> > >  rest_init+0x240/0x3d0 init/main.c:660
> > >  arch_call_rest_init+0xe/0x1b
> > >  start_kernel+0x7f6/0x81e init/main.c:997
> > >  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:490
> > >  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:471
> > >  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
> > > 
> > > 
> > > Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
> > > Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>
> > > 
> > > ---
> > >  drivers/tty/vt/keyboard.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> > > index 15d33fa0c925..f7e1bb21bd9c 100644
> > > --- a/drivers/tty/vt/keyboard.c
> > > +++ b/drivers/tty/vt/keyboard.c
> > > @@ -869,6 +869,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
> > >  static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
> > >  {
> > >  	int base;
> > > +	int bytes;
> > >  
> > >  	if (up_flag)
> > >  		return;
> > > @@ -884,6 +885,8 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
> > >  
> > >  	if (npadch == -1)
> > >  		npadch = value;
> > > +	else if (check_mul_overflow(npadch, base, &bytes) || check_add_overflow(bytes, value, &bytes))
> > > +		return;
> > 
> > Why do we discard the result of calculation and repeat it again below?
> > Can we say
> > 
> > 	else if (check_mul_overflow(npadch, base, &new_npadch) ||
> > 			check_add_overflow(new_npadch, value, &new_npadch))

Sorry, this should have been

	!check...() && !check_(...)

> > 		npadch = new_npadch;
> > 
> > Thanks.
> > 
> > -- 
> > Dmitry
> 
> Yes. This looks better. 
> 
> Thanks,
> Kyungtae Kim

Thanks.

-- 
Dmitry
