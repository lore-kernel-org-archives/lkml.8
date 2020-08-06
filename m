Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C75C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1850F2224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="aAmqYKeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHFSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgHFSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:46:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E658C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:46:07 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l17so50664466iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYvWLaCIquE0z2TVZ8Gq0tBoEFtzOAo2WsxwkK7WCII=;
        b=aAmqYKehmnbzoRwazwSBtxHArTwGzKkWN/ZiwpySOQVmEvZbnbVx6BB8m9v9kqC1Ch
         jFVu9sg4zff+V+a03Q15veLJ2HJmhczGOdS/0wHzIuUkM/xz1UGZFMQZ9GUtVqlySSe3
         n7bKIHhX+zxun1wss/APe4V9h9rdNdgovGQxreiiQbaseB9Kc7BYF9K7WTl6kvzNeIfg
         Axys3axW98Jr4Ul27/+hNCv4zKBHGDBmgBOC9njmUekotbLE9VErf60mnuicXpNiawZS
         mcJ2SCFVTY0uXqx96ZN1ip6by68wrh3Gr+GHjIX2ncBXRZHu8vawZCz0+2SJdrISLyIZ
         PMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYvWLaCIquE0z2TVZ8Gq0tBoEFtzOAo2WsxwkK7WCII=;
        b=nE42wiN73LOFUC2/F2B2uhbvDasD3QY2lD59ADxKN7Qfo5Y8qnugg9VSotP6EQC8Py
         sNIrTX7Wfa992HtDTGP0ct09tQt/GxTCO7EKBta69S3Kp37kcvFsqOL9YNcnuwgtH5rW
         lIGlLyCCDVmZ+AvcdLZ/mVM857O9BGjFhpTTgGGR/gxhCya1/iUdd9tZbi4INM4SOSYs
         fFTLCZIZaOmKYu1er4Ibo951U3TqV64+s8P5WU5z5OvHR9HCSvgB2TevpCZHP/62njPa
         7mBfa83NNpNhrlXMAu90Fiqgk6FfBzO1Z4v6LBfiOBDjf+wVb2L0AgR1r9CMxag1PfwV
         ILWQ==
X-Gm-Message-State: AOAM532L4YvNOZHvnC5p1DpFuXrL2fxYTGuab1XPgARO557bhJthomk5
        pDyeysJoLu+YuagNcUm9/cSVgr7YqEOPY4NbTnV4pMaG
X-Google-Smtp-Source: ABdhPJx/v8jBNAUuZuPpDp7pCGEJMGcrRe+TpzDJJbTw03w5kRmU+GQUH3c90QjfU093wqk/Ct5+prtElFSO34ZFWGM=
X-Received: by 2002:a02:cf26:: with SMTP id s6mr395526jar.44.1596739566680;
 Thu, 06 Aug 2020 11:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200806125710.3e9bd355@oasis.local.home>
In-Reply-To: <20200806125710.3e9bd355@oasis.local.home>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 6 Aug 2020 14:45:30 -0400
Message-ID: <CAMavQKJrg9qBUxV9Z8U1DWS+R5Uy2x6S7JgUV6r8oG16WHiXMQ@mail.gmail.com>
Subject: Re: tracing: Add trace_array_init_printk() to initialize instance
 trace_printk() buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 12:57 PM Steven Rostedt <rostedt@goodmis.org> wrote:
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

With the addition of exporting the symbol (which you pointed out on
IRC), this LGTM. Thanks again for being so accommodating!

Reviewed-by: Sean Paul <sean@poorly.run>


> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 06c0feae5ff9..48b608d9c5b1 100644
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
> @@ -3355,6 +3378,26 @@ int trace_array_printk(struct trace_array *tr,
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
> +
>  __printf(3, 4)
>  int trace_array_printk_buf(struct trace_buffer *buffer,
>                            unsigned long ip, const char *fmt, ...)
> --
> 2.25.4
>
