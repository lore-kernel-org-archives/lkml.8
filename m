Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801C8204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593757847;
	bh=KHF2MMlAnVZH5QuuVgQtIY1BusorsR3zB8AWdQf+TSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kGWYi7cfpKdDkeAXNoNYZZcsqh0opxA0nFotG6tBrNtzmFHUwsZH7hqxudTNaYqTh
	 N3shdoSSz0DzDchdTtYOSV/4SP8JMFRFstkx1ZMrrFJirG3BNYJtbVcQpXHkJ01z6H
	 tGc1WprH6Sm5gDsa4utJOMXMvpbkMz64ae9bEYnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGCGaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:30:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:30:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id f139so32603107wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjZBJs8X0nguidZg5CpdB0HmryO+5Vc7KMWihjNjkqQ=;
        b=Q55dyzjg0W4iZiIJvX9xwa2G0RQq3ggQfZ0dVEfc8A5pQg9Dv1r7A/1WPFM8EoRG1u
         KYqyZxJuXiba2dArl2sdmYGOTVUblYl+IdARl9AGuZ81UB3gkIqlFIBg42AQWjVRB6xd
         NkxFeOUGTOP5mL0+2hcsM/ARWwF8AkH2xxP4Li2NhThdLJogqieRIL91GuwCoJFzIULx
         1mHEit3tu1WHcqCNIZ18n8vWTu0TC53c6VRIhJEfk+nKhz/H+k4nq+s8G2l2R+ybNAzm
         B8SZszZTeHUUZCBMo8BPEqbiukoY99n8/08wbO5x78FJUHr0nmlSldnTy4vj+dQFax+/
         +78w==
X-Gm-Message-State: AOAM530Txc20phqfwW/lR8KCLL+aa5jSpyZHlSCbXo+A8BT9Wb/SkMDe
        +DTugQDHkAFCPek/QMWVvOCdCpi+RD3nGa3c1PM=
X-Google-Smtp-Source: ABdhPJzJZznGHNaVY6+zpi2TVhlBSB0KmWvoLVJF2nf8zzzae0tezM0Uz5dksrJktgyLQYR8fT5tsFWetM00zErXGaA=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr34156620wmm.168.1593757843977;
 Thu, 02 Jul 2020 23:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-10-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-10-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 15:30:32 +0900
Message-ID: <CAM9d7ch7gPmen8TJ9PbiK-QnQ_ojGVGqbR3bGYT4AMNW3Odp+A@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] perf ftrace: add support for tracing option 'func_stack_trace'
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds support to display call trace for function tracer. To do this,
> just specify a '--func-call-graph' option.

What if it's used with -G option?  Also it might be used only with
the -T option..  How about showing a warning if it's missing.. ?

Thanks
Namhyung

>
> $ sudo perf ftrace -T vfs_read --func-call-graph
>  iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
>  iio-sensor-prox-855   [003]   6168.369677: <stack trace>
>  => vfs_read
>  => ksys_read
>  => __x64_sys_read
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe
>  ...
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
