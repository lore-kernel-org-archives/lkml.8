Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACABC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F4120838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgC0Wvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgC0Wvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3019820787;
        Fri, 27 Mar 2020 22:51:40 +0000 (UTC)
Date:   Fri, 27 Mar 2020 18:51:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 10/10] trace: Replace printk and WARN_ON with WARN
Message-ID: <20200327185138.5e98e17b@gandalf.local.home>
In-Reply-To: <20200327212358.5752-11-jbi.octave@gmail.com>
References: <0/10>
        <20200327212358.5752-1-jbi.octave@gmail.com>
        <20200327212358.5752-11-jbi.octave@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 21:23:57 +0000
Jules Irenge <jbi.octave@gmail.com> wrote:

> Coccinelle suggests replacing printk and WARN_ON with WARN
> 
> SUGGESTION: printk + WARN_ON can be just WARN.
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/trace/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6b11e4e2150c..1fe31272ea73 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1799,9 +1799,7 @@ static int run_tracer_selftest(struct tracer *type)
>  	/* the test is responsible for resetting too */
>  	tr->current_trace = saved_tracer;
>  	if (ret) {
> -		printk(KERN_CONT "FAILED!\n");
> -		/* Add the warning after printing 'FAILED' */

NACK! Did you not read the above comment. The FAILED goes with another
print and should NOT be part of the WARN_ON.

-- Steve

> -		WARN_ON(1);
> +		WARN(1, "FAILED!\n");
>  		return -1;
>  	}
>  	/* Only reset on passing, to avoid touching corrupted buffers */

