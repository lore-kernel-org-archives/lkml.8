Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9301C2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fXqsYbmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHFTXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgHFTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:23:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7CC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:23:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so38735093ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJMMEQyeYoFZamYcp1LYhzE0BTlamnydOpPxwDn2cGs=;
        b=fXqsYbmIT1mSvSoJNPQ1aMveBbEXe6FaWiTjjLD7vClMKtZNFOwBq9xP9rkqhpAXpj
         0S8XA5sqdQ6Rs5cl34L0Cg2n6SYnwdyX/fYTn3wTWXls8UgF6Zp2J2JOhZyLrK/ibRfS
         jnQBUp+XFpneM3+ugwPmog+A5+c7S4yT4RFXLUQiw/dC9eeunQS923G5TdDgSFLl8DKE
         RUGWgHm9/5PsfZdMZBKslvKmFmQs93CUxIg8eLRpdNCiTEAph2BLmzWojoU6h3jGziaP
         wT3zl9aOO5Y55YZ30yfHKUhJWRfQ7SfoYuZolUV4/7V06s7RPzwm29d3kwCkIbM8oIf8
         PoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJMMEQyeYoFZamYcp1LYhzE0BTlamnydOpPxwDn2cGs=;
        b=K0RughRxAx3i23+2d8PFWf4xBUlnVhze65ZzJLCbo3NtCjimuH8kT2s6aYdK4uY9GU
         /vcNDic41Z1PB0p5PCpKgUY2ZrWPW+SHG3WIeMP/Cxgqv9fOYzJRnjsH/jK3qJ+gq0Ma
         tmKrc57PWbYutEnxwfGZwZBBcFSj3pBuYlmnol9Irdfmoo4GBGzoiCXCVwNHYGoEZD7g
         8Df0/GXIEZZxZ3ed32cfYnGAzExwuPcVEbn0tpTFV79BAEh+1oFTpZAGxHGBLgYUw5Fm
         t53DD9umAZ8Bv+aFbG3IP2CFgWhcaXA9VHpW2K/O6rUow9zFyNS1FyD712J/TEqEXysd
         SjEg==
X-Gm-Message-State: AOAM530nmTlEpG7oilzRyIVcBKCveWifmI+YxiZaaosbvYZ/I9efAa8e
        7hsXQ0ZPn3WtKdmaexF51O1tCndLo+DRqqzuHkzRWOAp
X-Google-Smtp-Source: ABdhPJy4WmJcVXA1gBMJGOmohxprVyg5ve0gqpy0IlGbYGAqjJu2AIxPjnPrNwwYptTfyq2LZVkyeLZYYqzhFQ2MyIo=
X-Received: by 2002:a02:70c3:: with SMTP id f186mr537634jac.118.1596741778965;
 Thu, 06 Aug 2020 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200806144618.4384a0f9@oasis.local.home>
In-Reply-To: <20200806144618.4384a0f9@oasis.local.home>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 6 Aug 2020 15:22:23 -0400
Message-ID: <CAMavQK+j8Gxj5n8XnzjprM5b4gL0Kopd5Nu0MNnJPt5_5KifWA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Add trace_array_init_printk() to initialize
 instance trace_printk() buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 2:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> As trace_array_printk() used with not global instances will not add noise to
> the main buffer, they are OK to have in the kernel (unlike trace_printk()).
> This require the subsystem to create their own tracing instance, and the
> trace_array_printk() only writes into those instances.
>
> Add trace_array_init_printk() to initialize the trace_printk() buffers
> without printing out the WARNING message.
>
> Reported-by: Sean Paul <sean@poorly.run>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since v1:
>   Added EXPORT_SYMBOL_GPL() to trace_array_init_printk() as it is
>   required for another function that is exported.

Could we also add this to trace.h?

>
>  kernel/trace/trace.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 06c0feae5ff9..c5f822736261 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3129,6 +3129,9 @@ static int alloc_percpu_trace_buffer(void)
>  {
>         struct trace_buffer_struct *buffers;
>
> +       if (trace_percpu_buffer)
> +               return 0;
> +
>         buffers = alloc_percpu(struct trace_buffer_struct);
>         if (MEM_FAIL(!buffers, "Could not allocate percpu trace_printk buffer"))
>                 return -ENOMEM;
> @@ -3331,6 +3334,26 @@ int trace_array_vprintk(struct trace_array *tr,
>         return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
>  }
>
> +/**
> + * trace_array_printk - Print a message to a specific instance
> + * @tr: The instance trace_array descriptor
> + * @ip: The instruction pointer that this is called from.
> + * @fmt: The format to print (printf format)
> + *
> + * If a subsystem sets up its own instance, they have the right to
> + * printk strings into their tracing instance buffer using this
> + * function. Note, this function will not write into the top level
> + * buffer (use trace_printk() for that), as writing into the top level
> + * buffer should only have events that can be individually disabled.
> + * trace_printk() is only used for debugging a kernel, and should not
> + * be ever encorporated in normal use.
> + *
> + * trace_array_printk() can be used, as it will not add noise to the
> + * top level tracing buffer.
> + *
> + * Note, trace_array_init_printk() must be called on @tr before this
> + * can be used.
> + */
>  __printf(3, 0)
>  int trace_array_printk(struct trace_array *tr,
>                        unsigned long ip, const char *fmt, ...)
> @@ -3355,6 +3378,27 @@ int trace_array_printk(struct trace_array *tr,
>  }
>  EXPORT_SYMBOL_GPL(trace_array_printk);
>
> +/**
> + * trace_array_init_printk - Initialize buffers for trace_array_printk()
> + * @tr: The trace array to initialize the buffers for
> + *
> + * As trace_array_printk() only writes into instances, they are OK to
> + * have in the kernel (unlike trace_printk()). This needs to be called
> + * before trace_array_printk() can be used on a trace_array.
> + */
> +int trace_array_init_printk(struct trace_array *tr)
> +{
> +       if (!tr)
> +               return -ENOENT;
> +
> +       /* This is only allowed for created instances */
> +       if (tr == &global_trace)
> +               return -EINVAL;
> +
> +       return alloc_percpu_trace_buffer();
> +}
> +EXPORT_SYMBOL_GPL(trace_array_init_printk);
> +
>  __printf(3, 4)
>  int trace_array_printk_buf(struct trace_buffer *buffer,
>                            unsigned long ip, const char *fmt, ...)
> --
> 2.25.4
>
