Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C999C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BA7206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knTkrsNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgGXOzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:55:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5266FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:55:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m15so4678259lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5J3Jiv01h2UCk0swTIEa7q9RnFkNMuL7hSAhjDrhLxI=;
        b=knTkrsNOeDMl4VdgpjUdj+J0ExIDPk5D/KaxeS9mQKdYOFm2EQUQ7srlRjoH//frpt
         UKkTNpBTODtiupFxUoHxEBu7aebq9AAOiT1M/5Ya1qaIvpkZea0PJ2tE/TFTHyv/tyj9
         d9z9KEjJ1Jante9yLuX3/KTPtiZBiEi8xQm3qJTj+h5zL/nEZaUAjbG4VwmWosCfRjPT
         DZIpU60mQM1RPf9aqyhTwzetFn5RDTfmpJx58YFrAzOmyKn/ZjEx79XvovBeWd46hTDE
         FtekfhOVZJhlCi9CS9y5qEoysAGSo20+QpCht8WdGfeuANZmkjvL8KQdWL857hhAM2gr
         Zt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5J3Jiv01h2UCk0swTIEa7q9RnFkNMuL7hSAhjDrhLxI=;
        b=IBFnBfNrMOdcrXOjUNgE3UdMmm0oI9qe9QcoKIaIIdzClJEo+OyYGm5qfze3GWW26A
         pR5WbAdehL16WQJ1SU1KDMjU4AAlCOPhW7LEpFEN8txxiylHKTiqGh/VqhdA5rLkmoE6
         IzHhN2rLAycAWw6/uiDgLADOkZPbHuGRTruyRhInIV6AXb5Ota/CwUZ6ff/wGp3moJLc
         YUfx+LotYw2S0sHU8IGKftH6qI/fQj5ZTyuvJJXXqilYQhDfxDO4I9Cyls/Uwgh9VaFg
         RXskWWbH3idGF4S63kGlzVgUbNU48HSVN5dGo8oC/dbMyaW3FIsaA8Jroozv8b+5K4vz
         k2gQ==
X-Gm-Message-State: AOAM531BQhVSeJfK53fH0MLbbNCp2yODkPO144beJmR/MC9xICnVCeM5
        X6jXKEb+ryMPPLwLcdKuBAA=
X-Google-Smtp-Source: ABdhPJxcM9dysLyJwMEjOG7o+gZD4cIfn5kxgwIzbVV0OkHJY30tBWbRpRgxGcYR8ZlqjE7DT23kbA==
X-Received: by 2002:a19:8095:: with SMTP id b143mr5264285lfd.175.1595602503697;
        Fri, 24 Jul 2020 07:55:03 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i10sm294925ljg.80.2020.07.24.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:55:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 24 Jul 2020 16:55:00 +0200
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200724145500.GA31254@pc636>
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:31:23AM -0400, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When get the pending softirqs, it need to process all the pending
> softirqs in the while loop. If the processing time of each pending
> softirq is need more than 2 msec in this loop, or one of the softirq
> will running a long time, according to the original code logic, it
> will process all the pending softirqs without wakeuping ksoftirqd,
> which will cause a relatively large scheduling delay on the
> corresponding CPU, which we do not wish to see. The patch will check
> the total time to process pending softirq, if the time exceeds 2 ms
> we need to wakeup the ksofirqd to aviod large sched delay.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/softirq.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c4201b7f..d572ce4 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -25,6 +25,7 @@
>  #include <linux/smpboot.h>
>  #include <linux/tick.h>
>  #include <linux/irq.h>
> +#include <linux/sched/clock.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
> @@ -200,17 +201,15 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  /*
>   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
>   * but break the loop if need_resched() is set or after 2 ms.
> - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
> - * certain cases, such as stop_machine(), jiffies may cease to
> - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> - * well to make sure we eventually return from this method.
> + * In the loop, if the processing time of the softirq has exceeded 2
> + * milliseconds, we also need to break the loop to wakeup the ksofirqd.
>   *
>   * These limits have been established via experimentation.
>   * The two things to balance is latency against fairness -
>   * we want to handle softirqs as soon as possible, but they
>   * should not be able to lock up the box.
>   */
> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
> +#define MAX_SOFTIRQ_TIME_NS 2000000
>  #define MAX_SOFTIRQ_RESTART 10
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -248,7 +247,7 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
>  
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> +	u64 end = sched_clock() + MAX_SOFTIRQ_TIME_NS;
>  	unsigned long old_flags = current->flags;
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
> @@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		}
>  		h++;
>  		pending >>= softirq_bit;
> +
> +		/*
> +		 * the softirq's action has been running for too much time
> +		 * so it may need to wakeup the ksoftirqd
> +		 */
> +		if (need_resched() && sched_clock() > end) {
> +			/*
> +			 * Ensure that the remaining pending bits are
> +			 * handled.
> +			 */
> +			or_softirq_pending(pending << (vec_nr + 1));
> +			break;
> +		}
>  	}
>  
>  	if (__this_cpu_read(ksoftirqd) == current)
> @@ -307,8 +319,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  
>  	pending = local_softirq_pending();
>  	if (pending) {
> -		if (time_before(jiffies, end) && !need_resched() &&
> -		    --max_restart)
> +		if (!need_resched() && --max_restart &&
> +		    sched_clock() <= end)
>  			goto restart;
>  
>  		wakeup_softirqd();
> 
To me it looks OKr.

Thank you for fixing the "2 msec resolution case".

--
Vlad Rezki
