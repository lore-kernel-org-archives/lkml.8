Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC45C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6584920736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/R6iyP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgDWR3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgDWR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:29:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422BC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:29:54 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e26so7496260otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTw3HJ5LMrayra2bc8zUPQ4gdkufH4Sy4zUG6VbstMI=;
        b=i/R6iyP6IXUBDRYqGP5hjs1Wz9DAo2+1mqcnXZM22f3YAJHk6QyLzJMYbDG7HoEMCJ
         5kgOvuIRpCqEHPJgj3QdbfG94If55hel5odUb87g29CzUumOnVy/ujFxdH4khw2r21wP
         1oJBwjV4LQbU8YxM7/zY+hnQhGgcdZVMdPQ7F3HAqtus9Xc3Q6wGht2irsdU1CVEyXzR
         eVgeAbIwPZPxuj8YAVNbWCSJQ3EYGvH8jo/ieX6alQGmrNIY9OjoFgiq/Oru9izq+kn6
         BMsZgmqz2AswQgYULqsqD+CNf+wYzctiLa48m2OMs+7CkVhnKQozPoEmKBk9sTavLTzO
         t7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTw3HJ5LMrayra2bc8zUPQ4gdkufH4Sy4zUG6VbstMI=;
        b=G7TQsmJDOlEQR6EkZ4sJagJYGAlQyp4Q6lcqZFXYya68yZMNlQ5XBs4MEo/gdvEXPl
         DjRqE1rNHVeUaXkAUWu6hzezbmuzJ01kswAOK9pvUqCfg8AL3qdUidBL+awgvpH8mesi
         x5fJ9vT93EA2FS2RB1EenzJbB/3PjKYV0gtblhewwuDx9KKxc6a03AH46SbFgbS2Lyo8
         McpVaxi16nWu+J+BGnaGDLTtnYEGsx16tfgctRDtQr08dYl3khHs4g8w3pLMV53/Yfef
         mCPG/SOcjdEfN3LRGJTZjXetLhJlTAEWaC8YVPYVsoADghFiElzVDE7QZn8xaiXPj+eX
         DSyA==
X-Gm-Message-State: AGi0PuYP4n021AQ3c9jFzIDA3mMvyXFDvhC23OReAOyz6rg/DhoQ4vIi
        nb03sjzSX2dfucGoMZyZW3qeFJgLN7f3uR31OPz6FQ==
X-Google-Smtp-Source: APiQypIzPt6Wc7kwOoNGiJ6wK9DZLHp2FNQ2KZh+pZK2yJ50apzIeRpoYiuTgs1pFAQeDOCjW2OJnPIhRRz1JzHhudE=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr4128856otb.352.1587662994124;
 Thu, 23 Apr 2020 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
 <jhj8simxgqo.mognet@arm.com>
In-Reply-To: <jhj8simxgqo.mognet@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 10:29:42 -0700
Message-ID: <CALAqxLXGQa-sPjNQV-uXzJLOVMyJtHqdfk0J48dhs+WVbWu+Sw@mail.gmail.com>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:19 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 23/04/20 17:40, John Stultz wrote:
> > Hey Folks,
> >
> > Recently, I've seen some occasional hangs earlyish in boot on my
> > HiKey960 board with 5.7-rc1/rc2. The kernel isn't totally wedged as I
> > will see some kernel messages (firmware loading failures, etc) much
> > later if I leave it.  But oddly sysrq doesn't respond.
> >
> > Figuring it must be some sort of deadlock, I added LOCKDEP and a bunch
> > of other debug options and started booting in a loop. So far I've not
> > been able to trigger the original problem, but I do see the following
> > every boot:
> >
>
> Interestingly I can't seem to reproduce that one with the latest master
> (5.7.0-rc2-00115-g8c2e9790f196). Is that with some of the extra h960
> patches?

There are additional patches for hikey960, but nothing from the
tracelog (which looked pretty generic).
But I'll pull everything out to confirm and re-check against
linus/master in case there's a recent fix.

> I do get this however:
>
> [    3.626638] INFO: trying to register non-static key.
> [    3.626639] the code is fine but needs lockdep annotation.
> [    3.626640] turning off the locking correctness validator.
> [    3.626644] CPU: 7 PID: 51 Comm: kworker/7:1 Not tainted 5.7.0-rc2-00115-g8c2e9790f196 #116
> [    3.626646] Hardware name: HiKey960 (DT)
> [    3.626656] Workqueue: events deferred_probe_work_func
> [    3.632476] sd 0:0:0:0: [sda] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
> [    3.640220] Call trace:
> [    3.640225]  dump_backtrace+0x0/0x1b8
> [    3.640227]  show_stack+0x20/0x30
> [    3.640230]  dump_stack+0xec/0x158
> [    3.640234]  register_lock_class+0x598/0x5c0
> [    3.640235]  __lock_acquire+0x80/0x16c0
> [    3.640236]  lock_acquire+0xf4/0x4a0
> [    3.640241]  _raw_spin_lock_irqsave+0x70/0xa8
> [    3.640245]  uart_add_one_port+0x388/0x4b8
> [    3.640248]  pl011_register_port+0x70/0xf0
> [    3.640250]  pl011_probe+0x184/0x1b8
> [    3.640254]  amba_probe+0xdc/0x180
> [    3.640256]  really_probe+0xe0/0x338
> [    3.640257]  driver_probe_device+0x60/0xf8
> [    3.640259]  __device_attach_driver+0x8c/0xd0
> [    3.640260]  bus_for_each_drv+0x84/0xd8
> [    3.640261]  __device_attach+0xe4/0x140
> [    3.640263]  device_initial_probe+0x1c/0x28
> [    3.640265]  bus_probe_device+0xa4/0xb0
> [    3.640266]  deferred_probe_work_func+0x7c/0xb8
> [    3.640269]  process_one_work+0x2c0/0x768
> [    3.640271]  worker_thread+0x4c/0x498
> [    3.640272]  kthread+0x14c/0x158
> [    3.640275]  ret_from_fork+0x10/0x1c

Oof. Way to twist the knife :) I'm probably to blame for that
deferred_probe_work_func issue. I'll take a look at it.

thanks
-john
