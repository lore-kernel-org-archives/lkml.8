Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012B82071A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593291763;
	bh=H+pgtT+I71fQO5a4jfcpOXtEkC/00odQA/9k0m0LfmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YDm0rgyXTEAE2YMlGwR7kyqeN70d6M51pZE7W25ofy97LQZrvHLIO8btoSIKxXTP5
	 bgx8vQzGKsEERiZ48OeAvbDFBXxQ7TKDNsKeuKnWQr1GnNMHuH3uHEzlDvQKauaTSh
	 171rFAz69166jMfe7iFj4mdTl1Q9x6aYCvdoiS9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgF0VC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 17:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgF0VC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 17:02:29 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28CEB2071A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593291748;
        bh=H+pgtT+I71fQO5a4jfcpOXtEkC/00odQA/9k0m0LfmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ur11i1uhWkLbgrpYGF71gd/AzwzEzjOHrRvEW08lLzAQqG5GSbUHM+/NiqS5iaCLV
         NxP+rOsCUaACN//vEpFqsZyZJUYEj4VqQEqZIZfiLQ74CJ5xMXNxxj9A5uvFXSmE5f
         wM4NfOeWMaXk8v/pFkdTN8wPOBxshFGTVgR4+WUw=
Received: by mail-wr1-f54.google.com with SMTP id a6so12746310wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 14:02:28 -0700 (PDT)
X-Gm-Message-State: AOAM531Y6yjK2zN+DBWi0hGeNKUAD2AFXdaszzsLlTib4QYMmR/j3dvl
        q2ydmOzBXSGLwytvSgxCiUNjlUgJFIbAkXdKvZ9i3g==
X-Google-Smtp-Source: ABdhPJwVZnNkWrkbRHs7+5vC+vKpuQXLcLkyMuq7Pln0xwhieZ+4FEC1PXTcommSeVVtEIf/qFHfhpqrIN+G/FakiL4=
X-Received: by 2002:adf:f707:: with SMTP id r7mr9904511wrp.70.1593291746791;
 Sat, 27 Jun 2020 14:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210506.GA27189@paulmck-ThinkPad-P72>
In-Reply-To: <20200626210506.GA27189@paulmck-ThinkPad-P72>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 27 Jun 2020 14:02:15 -0700
X-Gmail-Original-Message-ID: <CALCETrXN5Mm7yvDPsD7Ok=QAVoLH_fnEOgtdU2QCP+-q9u_ALA@mail.gmail.com>
Message-ID: <CALCETrXN5Mm7yvDPsD7Ok=QAVoLH_fnEOgtdU2QCP+-q9u_ALA@mail.gmail.com>
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
> (where "HH" is the hexadecimal softirq vector number) when one or more
> non-RCU softirq handlers are still enablded when checking to stop the
> scheduler-tick interrupt.  This message is not as enlightening as one
> might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
> local softirq work is pending, handler #HH.

Thank you!  It would be even better if it would explain *why* the
problem happened, but I suppose this code doesn't actually know.

--Andy

>
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> ---
>
>  tick-sched.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index f0199a4..349a25a 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>
>                 if (ratelimit < 10 &&
>                     (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> -                       pr_warn("NOHZ: local_softirq_pending %02x\n",
> +                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x\n",
>                                 (unsigned int) local_softirq_pending());
>                         ratelimit++;
>                 }
