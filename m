Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EE6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF12206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W2XTIwq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgEKR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgEKR1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:27:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E970C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:27:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c64so10577405qkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UM9gsd3fd5O0uAUURv9BaNBZctm2fMnWWALVccCUp6Q=;
        b=W2XTIwq2caGPCLLV0Zo5+c8mMkd5a3SsEOnaiRYzJMpg+A09bryN+mBFPccDafmnmv
         Wi543zpmvLiEqVK5e02i/z33A4xKZkUAT4Jf7dnprQLsKxhUDk3dfLIFu7GszAqrM3/1
         u13PUHmJ+py/n+LryR2Y7QHDLljJPaQ/3ZDCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UM9gsd3fd5O0uAUURv9BaNBZctm2fMnWWALVccCUp6Q=;
        b=UB1IKz2hUd7gpZoKwCAetAFs8SgCjzJeX+8XJiRZ7cTofeX8U9s7nT/ph30U6K8xRG
         dhXSi7CLhrUg+Cl1N/lFnD6yKlCgF4y4wpIzQ++6BdscGA/IKn1Smhm4dsauxsyrPqiY
         fBy8q0NqQa3vgljkrZU1NXmk4Yef68H3KoXtA22g/LQAifoIwnX9RomTQRz7WoVPYWC0
         8kP7CWjKh6PT/2gkzgFGpzZNPTGef0Yh+hH98WhiJWcyqKrvIoyNgB3gMqAt5GEKbbIp
         kGVCstOsJykCBFjnU/HNq6jZDyT/9+/zsTD0dmTX9kKhPqWtbGiNTHbiKm4cZgY8sgtZ
         vBKQ==
X-Gm-Message-State: AGi0Puar2Bzao4tVjlFtQJvpOswJqm2fjrHZJLHHW41ORhmzJrK8EM64
        UHimQs2gvkxWCrFsFj9an2JC+w==
X-Google-Smtp-Source: APiQypIPXPVdkPUHdNTnQUFS0SEXrsu9+htHEUzgCBx0qoXV9LQyp5QCzfr6JKwuRJOWpb7KU7oDow==
X-Received: by 2002:a05:620a:1594:: with SMTP id d20mr16559637qkk.217.1589218074479;
        Mon, 11 May 2020 10:27:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d196sm8760154qkg.16.2020.05.11.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 10:27:53 -0700 (PDT)
Date:   Mon, 11 May 2020 13:27:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH] tracing: Wait for preempt irq delay thread to execute
Message-ID: <20200511172753.GA173916@google.com>
References: <20200510114210.15d9e4af@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510114210.15d9e4af@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 11:42:10AM -0400, Steven Rostedt wrote:
> \From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> A bug report was posted that running the preempt irq delay module on a slow
> machine, and removing it quickly could lead to the thread created by the
> modlue to execute after the module is removed, and this could cause the
> kernel to crash. The fix for this was to call kthread_stop() after creating
> the thread to make sure it finishes before allowing the module to be
> removed.
> 
> Now this caused the opposite problem on fast machines. What now happens is
> the kthread_stop() can cause the kthread never to execute and the test never
> to run. To fix this, add a completion and wait for the kthread to execute,
> then wait for it to end.
> 
> This issue caused the ftracetest selftests to fail on the preemptirq tests.
> 
> Cc: stable@vger.kernel.org
> Fixes: d16a8c31077e ("tracing: Wait for preempt irq delay thread to finish")

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/preemptirq_delay_test.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index c4c86de63cf9..312d1a0ca3b6 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -16,6 +16,7 @@
>  #include <linux/printk.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
> +#include <linux/completion.h>
>  
>  static ulong delay = 100;
>  static char test_mode[12] = "irq";
> @@ -28,6 +29,8 @@ MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
>  MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
>  MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
>  
> +static struct completion done;
> +
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))
>  
>  static void busy_wait(ulong time)
> @@ -114,6 +117,8 @@ static int preemptirq_delay_run(void *data)
>  	for (i = 0; i < s; i++)
>  		(testfuncs[i])(i);
>  
> +	complete(&done);
> +
>  	set_current_state(TASK_INTERRUPTIBLE);
>  	while (!kthread_should_stop()) {
>  		schedule();
> @@ -128,15 +133,18 @@ static int preemptirq_delay_run(void *data)
>  static int preemptirq_run_test(void)
>  {
>  	struct task_struct *task;
> -
>  	char task_name[50];
>  
> +	init_completion(&done);
> +
>  	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
>  	task =  kthread_run(preemptirq_delay_run, NULL, task_name);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> -	if (task)
> +	if (task) {
> +		wait_for_completion(&done);
>  		kthread_stop(task);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
