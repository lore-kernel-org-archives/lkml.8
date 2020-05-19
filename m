Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF69204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgESIgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:36:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:36:23 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaxjV-000476-KX; Tue, 19 May 2020 10:36:17 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2386B1006A1; Tue, 19 May 2020 10:36:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xianting Tian <xianting_tian@126.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: Use set_current_state macro
In-Reply-To: <1589469647-33814-1-git-send-email-xianting_tian@126.com>
References: <1589469647-33814-1-git-send-email-xianting_tian@126.com>
Date:   Tue, 19 May 2020 10:36:11 +0200
Message-ID: <87imgsuxs4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xianting Tian <xianting_tian@126.com> writes:
> Use set_current_state macro instead of current->state = TASK_RUNNING
>
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 4820823..b9ecf87 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1882,7 +1882,7 @@ signed long __sched schedule_timeout(signed long timeout)
>  			printk(KERN_ERR "schedule_timeout: wrong timeout "
>  				"value %lx\n", timeout);
>  			dump_stack();
> -			current->state = TASK_RUNNING;
> +			set_current_state(TASK_RUNNING);

This is still wrong. Again:

   "That's not the same and adds a barrier which is not needed.

    Not a big problem in that particular error handling code path, but in
    general you really have to look whether your replacement is resulting in
    the same code.

    If not then you need to make an argument in the changelog why you are
    replacing existing code with something which is not fully equivalent.

    For this particular case, please check the implementation and read the
    documentation of set_current_state() in include/linux/sched.h."

Thanks,

        tglx
