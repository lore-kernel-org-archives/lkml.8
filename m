Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81FEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A455320771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6BqCzfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgGGPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgGGPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:19:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72ABC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:19:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so4840510pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=er6hsFquLTNA8VKEn24uMWaKfe7q89cZ0TTNSo/x5mA=;
        b=l6BqCzfkcZOUtekgBlMOFzEoQdcPcAs3uILNTs2Rc6zKFxOoXGcFngHlzIUen+l2w4
         edX+VgvnoybDAbGyjcunBSFrklD07tDq6aGeqP36T1S52x9ayjBAvcRyx1a7/R638gd0
         ORLlomrwFY14zy1yc/CdmTaAfT/e6qYBgxkh6k+LBJXzmmW2cJ0p3UoNPj92WsaEECrb
         io+RbC0J9ko7yYmpjSmgkJ2BVCQZQFX2fzn5GwfzsZ2sBrl4Mjjvs7QJHaY2m9OKZuEJ
         XZmBuGe90ONz69yyNEZMsSp5BTPtaXPo+hgi9b4QFn+2sDc20U3KcBoPpTXWeiombnq7
         Lkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=er6hsFquLTNA8VKEn24uMWaKfe7q89cZ0TTNSo/x5mA=;
        b=pF0+x7oy7sCwvGZs3hC/Y+PKB3IyezAn+c+dCP9B0mkK1+MZSnTXdZF0UWt3n146/+
         Yo49oVxHyh3APQqJBXbF7vl/hKALMqp5ewu2UyPQzC4CeooWaeaXALcpAMtPVLEmmRrK
         b69cjNVV+cZmQgTqgOmYWHUyKDzbcy4W6PAZjpwJ+dXQ+4ey/sNu25FPB9xhO7iWBXKP
         JQc1882NFnhLnSH8UmfX2uvNhVGRs8mxpj32D/VeJAeAYlAqPgIjR44cHPVJruNJRGqB
         9BjL50mkqGVI0Gc7YSI4zeWaYXzkH1zoKBe6I/9Jzb4Gz/asPx+gYMmnjGRirabbUe5J
         bIhw==
X-Gm-Message-State: AOAM531c1ccRN3SZfCDwwSChQzWwg9R0z292ptTcRIJcP+EIWIwCK9dr
        zHLu+rZY2ajrxVYKBpWm5qE=
X-Google-Smtp-Source: ABdhPJyo++a00C0KC/2zJLhYAA5YUxExURUW/Hz4ihgCnIQ0sgWSzcjPi7pGghI+EUrRuc6m1A3O6A==
X-Received: by 2002:a17:90a:222d:: with SMTP id c42mr5140691pje.126.1594135184400;
        Tue, 07 Jul 2020 08:19:44 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q24sm1295225pgg.3.2020.07.07.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:19:43 -0700 (PDT)
Date:   Tue, 7 Jul 2020 23:19:31 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/15] perf ftrace: add support for tracing option
 'func_stack_trace'
Message-ID: <20200707151931.ehgnhgl67cd73fjd@mail.google.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
 <20200627133654.64863-10-changbin.du@gmail.com>
 <CAM9d7ch7gPmen8TJ9PbiK-QnQ_ojGVGqbR3bGYT4AMNW3Odp+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch7gPmen8TJ9PbiK-QnQ_ojGVGqbR3bGYT4AMNW3Odp+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:30:32PM +0900, Namhyung Kim wrote:
> On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > This adds support to display call trace for function tracer. To do this,
> > just specify a '--func-call-graph' option.
> 
> What if it's used with -G option?  Also it might be used only with
> the -T option..  How about showing a warning if it's missing.. ?
>
All '--func-xxx' options are function tracer only. The warning message is a
good idea.

> Thanks
> Namhyung
> 
> >
> > $ sudo perf ftrace -T vfs_read --func-call-graph
> >  iio-sensor-prox-855   [003]   6168.369657: vfs_read <-ksys_read
> >  iio-sensor-prox-855   [003]   6168.369677: <stack trace>
> >  => vfs_read
> >  => ksys_read
> >  => __x64_sys_read
> >  => do_syscall_64
> >  => entry_SYSCALL_64_after_hwframe
> >  ...
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>

-- 
Cheers,
Changbin Du
