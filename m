Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918CEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1C1206DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 14:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IugrzgrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgFFOTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:19:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D651C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 07:19:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so4870719plk.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sFPewfONU6fSUKPDZW/BB0Mur5NOnPk+a+/ksltSLUo=;
        b=IugrzgrZ6sYmmqGT9OK1GEs8uO7idsYeev7uywdH2eMbCrpD16Y7mWmwWtfWOUqkHU
         Nfl5ZgZTZSpwy0Fb3uI5TN4P7QWIdq8YaG5lC6SOqXL/I1vzF7cHILj4L5DIQIj/tZHM
         rFHdjRQAmxJaRe0+KVx4AKCqjBwPmwASr0Lx42ejlrp80eYDqN3UrHYAOA6Cei6Tu18u
         f/ksegDRPNWfKbd7UYLI1skVgFfhKtBnnewsd8898OTU/n72WhhoXZPmGXXTDqn54b3S
         7LU8BuGHo58OFjIHDrojefY7WfaEJCZrvUdQEysCR4chNSjUZJSrUwba7SAbwqXwrYvz
         u6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sFPewfONU6fSUKPDZW/BB0Mur5NOnPk+a+/ksltSLUo=;
        b=UFWxLzZm6tbjv2JXKjqO6kHeeHhDpAVNervFMR+Rbvc0R4IJag7Kf0AW2VX+ImSpoA
         tprfTrASgXQXpwsXbm0wmquz3NKfqroHWAJgqSMiR7eFPWgTX3stH9o0YeSxGuhkOPXK
         5+cesSycszxfgj6bUT7Oz28YZU7deRNI2Vei0HvYcLZnO/hoNWuNAImnD5P/eamxOfzC
         0RNih5tv/bIu5FoTmK4N+cBZo+rTibhItxAjkEOF6Bdc2XroJ0frIbY1CUYNQDL5wrNI
         z38q7ojoQ/t3g6dk/1QSwVSa+4SwQw06yl1ty9vMLOhjGCS/mYwZgJAlSpXZXVumBgB6
         FWiA==
X-Gm-Message-State: AOAM531sBNRdYHU2XGvp/sNwrAvpdRrTq2S86PfsuAvmgR2deRSdoVat
        BodZ9XuYOCyY8IRRv16WkpA=
X-Google-Smtp-Source: ABdhPJybc2yZbYCOIdhodj9uQrp4m0mAw2phZ+knnymHpPpNma3tFS2Uc0xzW2wtiMWo2yiSQPIemg==
X-Received: by 2002:a17:902:c402:: with SMTP id k2mr13822994plk.184.1591453173099;
        Sat, 06 Jun 2020 07:19:33 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id j13sm7475913pje.25.2020.06.06.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 07:19:32 -0700 (PDT)
Date:   Sat, 6 Jun 2020 22:19:23 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/19] perf ftrace: add support for trace option
 sleep-time
Message-ID: <20200606141923.6k4xcwvalhmrki7c@mail.google.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-7-changbin.du@gmail.com>
 <20200520210106.GT32678@kernel.org>
 <CAM9d7cjcaNGwYE+kWFfonDn7M4KgZBmFdG0bMaJ_pDmiwVVs_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjcaNGwYE+kWFfonDn7M4KgZBmFdG0bMaJ_pDmiwVVs_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 02:56:41PM +0900, Namhyung Kim wrote:
> On Thu, May 21, 2020 at 6:01 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sun, May 10, 2020 at 11:06:15PM +0800, Changbin Du escreveu:
> > > This adds an option '--nosleep-time' which allow us only to measure
> > > on-CPU time. This option is function_graph tracer only.
> >
> > This seems, for now, very specific to the function_graph tracer, so
> > perhaps we should have a:
> >
> >         --function_graph_opts nosleep-time,other,another,etc
> >
> > ?
> 
> Agreed.  Also I don't want to add an option in a negative form
> as it's confusing.  Actually, our option parser can recognize
> --no-xxx form automatically so adding a positive option (--xxx)
> can handle that too.
>
Agree. And for the name, maybe we can align to original trace options.

root@WRT-WX9:/sys/kernel/debug/tracing# cat trace_options
print-parent
nosym-offset
nosym-addr
noverbose
noraw
nohex
nobin
noblock
trace_printk
annotate
nouserstacktrace
nosym-userobj
noprintk-msg-only
context-info
nolatency-format
record-cmd
norecord-tgid
overwrite
nodisable_on_free
irq-info
markers
noevent-fork
function-trace
nofunction-fork
nodisplay-graph
nostacktrace
notest_nop_accept
notest_nop_refuse


> Thanks
> Namhyung

-- 
Cheers,
Changbin Du
