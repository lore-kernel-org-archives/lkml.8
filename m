Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E8E2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxjqH0YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgEUGgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:36:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E25C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:36:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so2881206pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RVXKvHjZU68eYG6LLYhPCJFA2xPyIwUft0Jtqmw8jus=;
        b=gxjqH0YCcgUykO24Ty9wEwHGNCYWKIzUcqci9jcvqxeLzBGZ+KgNQ4At2CDQcz5rec
         g9POMkJ8AXvs1kBGg4RlRUv5141rtaQq3Oh4HidabVK4VODGEzB/KPVNv98RKq8RXTK1
         aNLSw7/atQITjfYrCyZ9PWnvmcPsNhQegy+8BtQ8YW0Wj2cm6wehmAqWxetZe0XU95Hu
         y48M5d/OJM5A6ZmVIl9oK4fb+MtmKjRXLB5R/yMZVj6GcZnelw5+G4f1pMWxuz7Ggxj+
         qRhudkSrWqLtXJpT5L/t6+FBSur7nemDZrY8weKp5qdTmNEdIlAku81Hwz34tZsHOVKG
         1wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVXKvHjZU68eYG6LLYhPCJFA2xPyIwUft0Jtqmw8jus=;
        b=RyjKvmhhcpN3uZR/AkJpv2LKfY6JTt5iXLk8C3zheKnaWdDO1crJLkFifqgST313V9
         5v+Oeg55ye8xH7mm4Fnx7C9+dTe2oyRsUnlHyRmky/zCTxln3iZ6WwonHC5UY9vPuC/y
         bngPGD+l9/eRaKnLm4u5dmS6mbPfIc8k0SBEWOAFlCejOGzSnltCcU9DdD3rS+Ilvdzs
         ZJ1rAgUsN9A1pzOIabUQeHOW0KykRH28/BJjiIYeFJvrhrbBz8jwT450jmdLZZfY4qKY
         t7ZUwune815Q4Ca1xRhSzVscddaG6ngl1gJ7ynJWZMjGe9BTJbDxoix1GHMTtvyzk37U
         SQPg==
X-Gm-Message-State: AOAM532iPRIRXYdtOts7NsLyNwzs+YE7e/DUTGE9u2GX5Xk1CN/XZAqj
        o6kCSUVO8iIogHmAZT0lbkw=
X-Google-Smtp-Source: ABdhPJw+BMKQT18E3QhGaDAwHJBpHZZcn9hgaJu39ueB9W2pWnV78zLToBVrcOyYJ3CERPg9ChEWIA==
X-Received: by 2002:a63:3c11:: with SMTP id j17mr7712502pga.70.1590042965954;
        Wed, 20 May 2020 23:36:05 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id i17sm3692597pfq.197.2020.05.20.23.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:36:05 -0700 (PDT)
Date:   Wed, 20 May 2020 23:36:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: [PATCH] vt: keyboard: avoid integer overflow in k_ascii
Message-ID: <20200521063602.GZ89269@dtor-ws>
References: <20200521013400.GA2240@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521013400.GA2240@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 21, 2020 at 01:34:08AM +0000, Kyungtae Kim wrote:
> FuzzUSB (a variant of syzkaller) found an integer overflow 
> while processing keycode value.
> 
> Reference: https://lkml.org/lkml/2020/3/22/482
> 
> This bug occurs because of no validity check when operating keycode values.
> By executing k_ascii() multiple times, npadch can have a large value 
> close to the max of int type e.g., 1111111111. 
> In the following, its muliplication causes an integer overflow.
> 
> This fix prevents the overflow by checking npadch using check_mul_overflow() 
> ahead of its operation.
> 
> 
> UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c:888:19
> signed integer overflow:
> 10 * 1111111111 cannot be represented in type 'int'
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.11 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xce/0x128 lib/dump_stack.c:118
>  ubsan_epilogue+0xe/0x30 lib/ubsan.c:154
>  handle_overflow+0xdc/0xf0 lib/ubsan.c:184
>  __ubsan_handle_mul_overflow+0x2a/0x40 lib/ubsan.c:205
>  k_ascii+0xbf/0xd0 drivers/tty/vt/keyboard.c:888
>  kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
>  kbd_event+0x888/0x3be0 drivers/tty/vt/keyboard.c:1495
>  input_to_handler+0x3a9/0x4b0 drivers/input/input.c:118
>  input_pass_values.part.8+0x25e/0x690 drivers/input/input.c:145
>  input_pass_values drivers/input/input.c:193 [inline]
>  input_repeat_key+0x1f8/0x2c0 drivers/input/input.c:194
>  call_timer_fn+0x20e/0x770 kernel/time/timer.c:1404
>  expire_timers kernel/time/timer.c:1449 [inline]
>  __run_timers kernel/time/timer.c:1773 [inline]
>  run_timer_softirq+0x63f/0x13c0 kernel/time/timer.c:1786
>  __do_softirq+0x262/0xb46 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x161/0x1b0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
>  smp_apic_timer_interrupt+0x137/0x500 arch/x86/kernel/apic/apic.c:1146
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>  </IRQ>
> RIP: 0010:default_idle+0x2d/0x2e0 arch/x86/kernel/process.c:696
> Code: e5 41 57 41 56 65 44 8b 35 30 9d 5d 7a 41 55 41 54 53 0f 1f 44 00 00 e8 11 42 a4 fb e9 07 00 00 00 0f 00 2d d5 29 5e 00 fb f4 <65> 44 8b 35 0b 9d 5d 7a 0f 1f 44 00 00 5b 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffffffff87007ce8 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: ffffffff87032900 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff87033154
> RBP: ffffffff87007d10 R08: fffffbfff0e06521 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff88c99c00 R14: 0000000000000000 R15: 0000000000000000
>  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:686
>  default_idle_call+0x50/0x70 kernel/sched/idle.c:94
>  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>  do_idle+0x332/0x530 kernel/sched/idle.c:269
>  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:361
>  rest_init+0x240/0x3d0 init/main.c:660
>  arch_call_rest_init+0xe/0x1b
>  start_kernel+0x7f6/0x81e init/main.c:997
>  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:490
>  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:471
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
> 
> 
> Signed-off-by: Kyungtae Kim <kt0755@gmail.com>
> Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>
> 
> ---
>  drivers/tty/vt/keyboard.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 15d33fa0c925..f7e1bb21bd9c 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -869,6 +869,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
>  static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  {
>  	int base;
> +	int bytes;
>  
>  	if (up_flag)
>  		return;
> @@ -884,6 +885,8 @@ static void k_ascii(struct vc_data *vc, unsigned char value, char up_flag)
>  
>  	if (npadch == -1)
>  		npadch = value;
> +	else if (check_mul_overflow(npadch, base, &bytes) || check_add_overflow(bytes, value, &bytes))
> +		return;

Why do we discard the result of calculation and repeat it again below?
Can we say

	else if (check_mul_overflow(npadch, base, &new_npadch) ||
			check_add_overflow(new_npadch, value, &new_npadch))
		npadch = new_npadch;

Thanks.

-- 
Dmitry
