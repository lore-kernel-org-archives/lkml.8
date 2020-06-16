Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF18C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9+FP4eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFPIlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFPIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:41:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63684C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:41:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n9so8085103plk.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kgm5AdGH8Er3kV8b0s+J7J3wvYFsTsl4yBOXROjlIDk=;
        b=F9+FP4eCuCR7tDgyHv/SvEADpP09h/Y5yb90fK6BSAVNprtQbTk55rrvUlSzaoTzvm
         0n9fB6bxVk38g+gE3gqV0RcYNwc7pGUzeByQ6ox7QQc0FHtJ8sDowSUEcxyQhGpqVLd7
         KC8G1MbE4aIlLw/+MBAPnvjTouS+Cy82vkqnFEQ8gaaW4RgeKJngE7WnlJR1WW1mvc1E
         wr5KJH0FSUFy7IsBiq49DzPKsj9+MRQmTOEhKZFaPw4eZEuoy0GyhTmDh70TDa+hgg2V
         fyuqpGb8VHutAv3+hj6kDdpMEDzz3dxwW0bIkDYJhvPc4JVSANKb9dhBcfZBpnHK5jki
         KEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kgm5AdGH8Er3kV8b0s+J7J3wvYFsTsl4yBOXROjlIDk=;
        b=oRTRxIpwAd3wokHZEkaOfZH5xE7fNPK+LxeJ6j6/Axc7xS7PsJJhYNt7SbwLltWiy7
         Lm8OFqGwKJBV7YkdCw7rEVy8EKeQoWtpaOPk2hqxtCaUUKEw77TxWJ4HlofhplY9YYkM
         opYDKAMacAPxv/FdRoz8pBXGT1gdA59hqkY/uBV/W+EU67DFvKHO4yH+vFD9LCJWH7gn
         tdCoyc3G4Q1/npZEOVD4U89CVr6vQ+8ZsCnWh4MHveX5QSjvv32NWjNv91jeao3GOFxz
         dPb8cXZwqdGR8tPIVV1KZ6vdZDT1LG/0ACDiWDiwT3nywMyfpmYYg5E8AHwa/KbPaWmt
         iS6g==
X-Gm-Message-State: AOAM530PqlLcI8GLG4AJbBdTj0oUBBEcPMcvl59nRBnTMLKm3qFEcKaT
        eiRcGgztUW5MHHLHD/Fexj8ktGFc
X-Google-Smtp-Source: ABdhPJys2GrrBCtT69W3GzI1oXOF8zGqN5zSq6N0s90/8Sl8Gt7UN1eLpLnKI8UUdrHINREIaRluPg==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr1193736pld.245.1592296870855;
        Tue, 16 Jun 2020 01:41:10 -0700 (PDT)
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp. [210.141.244.193])
        by smtp.gmail.com with ESMTPSA id a29sm15862292pfg.201.2020.06.16.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:41:09 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:41:06 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probe: fix memleak in fetch_op_data operations
Message-Id: <20200616174106.8b61410d50ce20e010ad6f4e@gmail.com>
In-Reply-To: <20200615143034.GA1734@cosmos>
References: <20200615143034.GA1734@cosmos>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 20:00:38 +0530
Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> wrote:

> kmemleak report:
>     [<57dcc2ca>] __kmalloc_track_caller+0x139/0x2b0
>     [<f1c45d0f>] kstrndup+0x37/0x80
>     [<f9761eb0>] parse_probe_arg.isra.7+0x3cc/0x630
>     [<055bf2ba>] traceprobe_parse_probe_arg+0x2f5/0x810
>     [<655a7766>] trace_kprobe_create+0x2ca/0x950
>     [<4fc6a02a>] create_or_delete_trace_kprobe+0xf/0x30
>     [<6d1c8a52>] trace_run_command+0x67/0x80
>     [<be812cc0>] trace_parse_run_command+0xa7/0x140
>     [<aecfe401>] probes_write+0x10/0x20
>     [<2027641c>] __vfs_write+0x30/0x1e0
>     [<6a4aeee1>] vfs_write+0x96/0x1b0
>     [<3517fb7d>] ksys_write+0x53/0xc0
>     [<dad91db7>] __ia32_sys_write+0x15/0x20
>     [<da347f64>] do_syscall_32_irqs_on+0x3d/0x260
>     [<fd0b7e7d>] do_fast_syscall_32+0x39/0xb0
>     [<ea5ae810>] entry_SYSENTER_32+0xaf/0x102
> 
> Post parse_probe_arg(), the FETCH_OP_DATA operation type is overwritten
> to FETCH_OP_ST_STRING, as a result memory is never freed since
> traceprobe_free_probe_arg() iterates only over SYMBOL and DATA op types
> 
> Setup fetch string operation correctly after fetch_op_data operation.
> 

Oops, Good catch! (I've commented it but not coded...)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

And,

Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
Cc: stable@vger.kernel.org

Thank you!

> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index b8a928e..d2867cc 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -639,8 +639,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  			ret = -EINVAL;
>  			goto fail;
>  		}
> -		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM) ||
> -		     parg->count) {
> +		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
> +		     code->op == FETCH_OP_DATA) || parg->count) {
>  			/*
>  			 * IMM, DATA and COMM is pointing actual address, those
>  			 * must be kept, and if parg->count != 0, this is an
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu
