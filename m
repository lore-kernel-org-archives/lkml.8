Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7844C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E372076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEV5b9K/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGRFrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgGRFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:47:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6BAC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 22:47:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so6393582pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BoFpG5s+lsVErPe9zFgNuHyTdzcSF0LluD6wUQfwAEc=;
        b=jEV5b9K/r+84ZnSQt6ooI2nHa+vIpeYfhfbl4rjE+cPr0Ss/h0whvOyY2Hg/kUvPaU
         NxYjreJfNYOwVoOveaOnJARH+8EhKhLvJM5TWRXbDdtMkIHC6eKfuWbroCayIeDpuJhq
         aIsOJTUcx3PZzlZ+gzs7hvw/J0vVWhy91jwRkeqVoGJKNxpTzxFSh7py5XHJm5fSvNeG
         P3H9Cx92AJ8sUWBbnN42S2LBcPCNcGEJlJgnZP4DLt3xLbdxYqwJi7FDx6u1GsndBzzm
         P316q57yJEcuR/TNAZDGkdVPA1lhEpfa1tSl0mqrlrx6uZOMwonEYjdH92htXtHLbaNG
         zw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BoFpG5s+lsVErPe9zFgNuHyTdzcSF0LluD6wUQfwAEc=;
        b=rvhWr3royFC4lVEOp2IOkFZ3ZEwVaaRzKVut8FHI7ejcV5yVMuZNwW3mI9HqJT9+YP
         QbdTqMqytGJikgaM7KTrYC6WI6Qll7PhRHhpcimZ9SgobNs/eaKONxFPwu3PAUCWUai6
         o1OKJxjBA4OB3tS73xt95c0blr7KnpBZvXONfJROqnmcuV0Mz4BoO4gnH+RI5YjCTYz1
         rYTRJAA/B17zx3w56TPb9ZJ6pngub7LeDjOU21kTRmGedlLWxjTZj977L7XQp8TMU2Nb
         DDHon0OUN+xxQFPS3H4mcAYgQRoC1L71cvgl2TRQltiy16XNx5VABaDkvXShkAvdGNXv
         EQNQ==
X-Gm-Message-State: AOAM531W8bfjCXEDsYd4QxjrOGT5wltcnYP+4V+SCbz6kk+tpLJR9cDp
        dZf5t70BalPombGj74tnBBw=
X-Google-Smtp-Source: ABdhPJxIRK5+APxbnfus68JL3EtKTxRjLNpjsT2/yyydRIJN0V4RaUC/wol3cHjXjxX9kRraqXYa0A==
X-Received: by 2002:a05:6a00:1514:: with SMTP id q20mr11059218pfu.243.1595051263644;
        Fri, 17 Jul 2020 22:47:43 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x9sm6775167pfq.11.2020.07.17.22.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:47:42 -0700 (PDT)
Date:   Sat, 18 Jul 2020 13:47:32 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200718054732.wv2q5taib7o4tf2u@mail.google.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-4-changbin.du@gmail.com>
 <20200716153630.GD374956@kernel.org>
 <20200717132650.i32oovllal22b35i@mail.google.com>
 <20200717130124.54e85349@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717130124.54e85349@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:01:24PM -0400, Steven Rostedt wrote:
> On Fri, 17 Jul 2020 21:26:50 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > On Thu, Jul 16, 2020 at 12:36:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Sat, Jul 11, 2020 at 08:40:21PM +0800, Changbin Du escreveu:  
> > > > This allows us to trace single thread instead of the whole process.
> > > > 
> > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > > ---
> > > >  tools/perf/Documentation/perf-ftrace.txt | 4 ++++
> > > >  tools/perf/builtin-ftrace.c              | 2 ++
> > > >  2 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > > > index d79560dea19f..e204bf6d50d8 100644
> > > > --- a/tools/perf/Documentation/perf-ftrace.txt
> > > > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > > > @@ -38,6 +38,10 @@ OPTIONS
> > > >  --pid=::
> > > >  	Trace on existing process id (comma separated list).
> > > >  
> > > > +-t::
> > > > +--tid=::
> > > > +	Trace on existing thread id (comma separated list).
> > > > +  
> > > 
> > > 
> > > Humm, I just  tried:
> > > 
> > > [root@five ~]# yes > /dev/null &
> > > [1] 18265
> > > [root@five ~]# perf ftrace --tid 18265
> > > ^C[root@five ~]#
> > > 
> > > After waiting for a while, nothing, what am I doing wrong?
> > >  
> > I got it wrong. Currently ftrace only can filter by pid. If the pid is not
> > the main thread it won't work.
> 
> Wait what?
> 
> The "pid" for ftrace is really a "task id" which is a thread id.
>
My bad. I traced a sleeping thread yesterday so no event generated.

Now it works:
$ pstree -p 2378
qemu-system-x86(2378)─┬─{qemu-system-x86}(2379)
                      ├─{qemu-system-x86}(2382)
                      ├─{qemu-system-x86}(2385)
                      ├─{qemu-system-x86}(2387)
                      ├─{qemu-system-x86}(2388)
                      ├─{qemu-system-x86}(2389)
                      ├─{qemu-system-x86}(2390)
                      ├─{qemu-system-x86}(2391)
                      ├─{qemu-system-x86}(2392)
$ sudo ./perf ftrace --tid 2388
[sudo] password for changbin:
# tracer: function
#
# entries-in-buffer/entries-written: 0/0   #P:8
#
#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
#              | |         |       |         |
          <idle>-0     [001]   6561.553989: switch_mm_irqs_off <-__schedule
          <idle>-0     [001]   6561.553996: load_new_mm_cr3 <-switch_mm_irqs_off
 qemu-system-x86-2388  [001]   6561.553997: finish_task_switch <-__schedule
 qemu-system-x86-2388  [001]   6561.553998: smp_irq_work_interrupt <-irq_work_interrupt
 qemu-system-x86-2388  [001]   6561.553999: irq_enter <-smp_irq_work_interrupt
 qemu-system-x86-2388  [001]   6561.553999: rcu_irq_enter <-irq_enter
 qemu-system-x86-2388  [001]   6561.554000: __wake_up <-rb_wake_up_waiters
 qemu-system-x86-2388  [001]   6561.554000: __wake_up_common_lock <-__wake_up
 qemu-system-x86-2388  [001]   6561.554000: _raw_spin_lock_irqsave <-__wake_up_common_lock
 qemu-system-x86-2388  [001]   6561.554000: __wake_up_common <-__wake_up_common_lock
 ...
> [root@bxtest ~]# yes > /dev/null &
> [1] 6799
> [root@bxtest ~]# trace-cmd record -e all -P 6799
> Hit Ctrl^C to stop recording
> ^CCPU 0: 3573031 events lost
> CPU0 data recorded at offset=0x838000
>     627675136 bytes in size
> CPU1 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU2 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU3 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU4 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU5 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU6 data recorded at offset=0x25ed1000
>     0 bytes in size
> CPU7 data recorded at offset=0x25ed1000
>     0 bytes in size
> [root@bxtest ~]# trace-cmd report | head 
> CPU 1 is empty
> CPU 2 is empty
> CPU 3 is empty
> CPU 4 is empty
> CPU 5 is empty
> CPU 6 is empty
> CPU 7 is empty
> cpus=8
>              yes-6799  [000] 67825.580902: sys_exit:             NR 1 = 8192
>              yes-6799  [000] 67825.580903: sys_exit_write:       0x2000
> 
> 
> What's different about tid vs pid?
> 
> -- Steve
> 
> 
> 
> > 
> > So this patch makes no sense. will drop this.
> > 

-- 
Cheers,
Changbin Du
