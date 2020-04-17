Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C4C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca3Nklzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgDQMTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:19:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57833 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbgDQMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587125992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAvAY7kidzmNvlsCwdf3voHC0ApsCK/J869Shf1r6TI=;
        b=ca3NklzbTg0LgFNfxe8HCfGyyVVaNfIYqJDQrPPP3n+Q/OIsMfuBEryC+BIu5U1ygLnqOi
        uNnXb4VmcJVggzeQpjo7RaNdfp8OF9P/BXjCVb8OtWmDwsQdmYAPmHE5W4xasM7mFhNP4F
        kPP7lHlubfdVV27XaVmD2f1g1pwzT1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-PQ7yjlxiMwCNIvSF8HSRGQ-1; Fri, 17 Apr 2020 08:19:50 -0400
X-MC-Unique: PQ7yjlxiMwCNIvSF8HSRGQ-1
Received: by mail-wr1-f70.google.com with SMTP id j16so871243wrw.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dAvAY7kidzmNvlsCwdf3voHC0ApsCK/J869Shf1r6TI=;
        b=uYd/+3fr9YHqcmYNt082zca6N1kVNJ3GT4tGv+oxXR+kaSa2ximxVRJXXI7TJd8vkP
         3C1MjYwcfKKtRg0rluY+gDbFH3zzY/+wwwJhLcW41hEbFx2fq+vm8etm4Xnq692H4xzL
         L7qEFwcBlzvRYKXQ8SlwYoDXSz4pFJZWiuRd7V7/qK5V6aPPm2trCAeiesu2y7qj+Uob
         +Yfinql89ZGxzziNqp4lQEW4je+fJLOLOWB2vdacKoZOaZdlqUuTiLgdX79o1hNLGXlz
         qkjSGFLEYVuysAxRTrGTMrUjcXLkAnlgYl+uLqECgP9xj2ak/P0VYarbKfv6L35H8KS/
         ci9Q==
X-Gm-Message-State: AGi0Pua5rBH9kivlziJfnSqMeEIe6hFKoWh9wnJtBv7C0k2YvFHlru38
        JkNj3y/IJyP67DVAGwdtCLwtVUk6G8UtYQm247M/4UwM7JNJUp2m/NtVRZ2vI3DgQToNpKSQlzb
        Up4PU+s2OAP7IRZvbMRFRNshn
X-Received: by 2002:adf:f091:: with SMTP id n17mr3614536wro.200.1587125988946;
        Fri, 17 Apr 2020 05:19:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypILmJEGttVpZsTMiKNpTiWWB+ukHgKkmui3YD85EvHFoljJkAHvozhKBbMdGxKfllOHT0icJw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr3614500wro.200.1587125988687;
        Fri, 17 Apr 2020 05:19:48 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id k14sm32506670wrp.53.2020.04.17.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 05:19:48 -0700 (PDT)
Date:   Fri, 17 Apr 2020 14:19:45 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200417121945.GM9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
 <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20 19:29, Dietmar Eggemann wrote:

[...]

> 
> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
> with the help of an extra per-cpu cpumask we could just

Hummm, I like the idea, but

> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
> 
> dl_bw_cpus(int i) {

This works if calls are always local to the rd we are interested into
(argument 'i' isn't used). Are we always doing that?

>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
> 
>     return cpumask_weight(cpus);
> }
> 
> and
> 
> dl_bw_capacity(int i) {
> 
>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
>     ...
>     cpumask_and(cpus, rd->span, cpu_active_mask);
>     if (cpumask_equal(cpus, rd->span))
>         return rd->sum_cpu_capacity;

What if capacities change between invocations (with the same span)?
Can that happen?

> 
>     for_each_cpu(i, cpus)
>         cap += capacity_orig_of(i);
> 
>     return cap;
> }
> 
> So only in cases in which rd->span and cpu_active_mask differ we would
> have to sum up again.

Thanks,

Juri

