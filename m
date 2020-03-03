Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B42C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069B92073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfKoNwe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgCCPP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:15:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46779 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCCPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:15:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id v6so3026326lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqL8FBmflC7jECmwEvPcutur31Kjbol45YD6A9jQX+I=;
        b=pfKoNwe5g3+8N//haG3GXX2c06OILFiwSCPIx9NruMRyN5JiKcInj+lrz3Fe+cy3kb
         tlMb8/stVX5o99/tAMbKRfsSvfrNd5EHrnZKR9nN6B6dpUpZAchyegQo2S8M8gTJnDyN
         cl+li3/pIQE6Trcjxo5Y1kU9u84rBUBgW9LDQDXIDVFj2FH7g4Js2jARMmIykW/7JNDr
         agsBRuuFMzagQwat2cR7QTrYowdi7eCJMYEbTdwlmsvFERa1LwZDnC+cdKiRVlvr3hyQ
         o2gXcunXDGxkXl3w18X5Ec4FcjEA6kfZmoaHNGAWYrR0HRHa5sz55cKQ0u4qgIkC9qR+
         a+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqL8FBmflC7jECmwEvPcutur31Kjbol45YD6A9jQX+I=;
        b=KEbTkO6uejWu/2IPNNj475tDt1xHrm9UF7o/CgNQmAXC8GyV0VWsYNoUb1HxISRXiq
         2BdSSmFOxcYHWI3IkJq8Aw/ZpJemWBi6cu8KfbzkDHxYLl3KYpHF/LLa4s8APA5i0oji
         GsqyiPvEfVNpjJWL6Vx0DapXUt/p+8j4wbTtjFncWil5aSiYHDUNMDIjGJxLxZznOXL0
         uj7hKWmq9vrAMHa9ucSkxQQme83YY+Rp1TYtX0FZhjlb90h9y7umP4vAauMj2H4rSROh
         mp3vDlqhJpQZPWa4/GL3b5X4JlpmjNbOJ/5O0bUUvkkGkSESmZ1LFAADbjFZwbR9Kt9C
         AbEw==
X-Gm-Message-State: ANhLgQ2v+vTnnWzbGy2H9qWoG2eBdJizUOAPwo6lwcWvK3m+3Wqt4VD7
        CaRb0ckJEV2lbRUMZaIcfZMvDsFP923MaGtEwm5O
X-Google-Smtp-Source: ADFU+vsqrjC79DTEosewF++BVV+/AkPXOG9j7CNVOkZJLqmADroaEljLgKfd1KoMmgENLvyMzwFCRRwoi/ZcCEbaj6Q=
X-Received: by 2002:a19:5210:: with SMTP id m16mr3102082lfb.118.1583248557365;
 Tue, 03 Mar 2020 07:15:57 -0800 (PST)
MIME-Version: 1.0
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
 <20200302235044.59163-1-zzyiwei@google.com> <20200303090703.32b2ad68@gandalf.local.home>
 <20200303141505.GA3405@kroah.com> <20200303093104.260b1946@gandalf.local.home>
In-Reply-To: <20200303093104.260b1946@gandalf.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Tue, 3 Mar 2020 07:15:46 -0800
Message-ID: <CAKT=dD=a2r8s_ksHmwdOvnpKG0JeRxCo+ERzYGPFTW6OR01Org@mail.gmail.com>
Subject: Re: [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
To:     Greg KH <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, elder@kernel.org, federico.vaga@cern.ch,
        tony.luck@intel.com, vilhelm.gray@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        bhelgaas@google.com, darekm@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 6:31 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 3 Mar 2020 15:15:05 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Tue, Mar 03, 2020 at 09:07:03AM -0500, Steven Rostedt wrote:
> > >
> > > Greg,
> > >
> > > You acked this patch before, did you want to ack it again, and I'll take it
> > > in my tree?
> >
> > Sure, but where did my ack go?  What changed from previous versions???
> >
> > Anyway, the patch seems sane enough to me:
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Your previous ack was was here:
>
>   https://lore.kernel.org/lkml/20200213004029.GA2500609@kroah.com/
>
> And the patch changed since then (although, only cosmetically), so your ack
> was removed. The diff between this patch and the patch you acked is this:
>
> -- Steve
>
> diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> index 3b632a2b5100..1897822a9150 100644
> --- a/include/trace/events/gpu_mem.h
> +++ b/include/trace/events/gpu_mem.h
> @@ -28,34 +28,27 @@
>   *
>   */
>  TRACE_EVENT(gpu_mem_total,
> -       TP_PROTO(
> -               uint32_t gpu_id,
> -               uint32_t pid,
> -               uint64_t size
> -       ),
> -       TP_ARGS(
> -               gpu_id,
> -               pid,
> -               size
> -       ),
> +
> +       TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +
> +       TP_ARGS(gpu_id, pid, size),
> +
>         TP_STRUCT__entry(
>                 __field(uint32_t, gpu_id)
>                 __field(uint32_t, pid)
>                 __field(uint64_t, size)
>         ),
> +
>         TP_fast_assign(
>                 __entry->gpu_id = gpu_id;
>                 __entry->pid = pid;
>                 __entry->size = size;
>         ),
> -       TP_printk(
> -               "gpu_id=%u "
> -               "pid=%u "
> -               "size=%llu",
> +
> +       TP_printk("gpu_id=%u pid=%u size=%llu",
>                 __entry->gpu_id,
>                 __entry->pid,
> -               __entry->size
> -       )
> +               __entry->size)
>  );
>
>  #endif /* _TRACE_GPU_MEM_H */

Hi Steve, since Greg has acknowledged again on the latest patch v4,
will you help merge from your tree?

Thanks for all the help!
Yiwei
