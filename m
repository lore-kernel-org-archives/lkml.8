Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA307C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A309720829
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 00:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgF2kEGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHAAq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 20:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgHAAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 20:46:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F185C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 17:46:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s23so24381179qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpyhrCH4eKTJSelS4BtxCH/z19fxo1jSDpO/4tVrznQ=;
        b=TgF2kEGa6o9qpnnYlPeNuDYCLWN5/02F+nADdR3bQKNzQMXPLx5mDDJJT8TGy6GMwf
         nKKoIlZHKJ8loYbuU5NWqz5VbwrhDmrMjmjCGeKdfL/8WfkmbB3mmxjLPltBTP1CwK5O
         wePqmE78S4jrp8BOrpPyCZkz4Z6PK6nE7hhB63kE8pxrncittx0jG4S6cc2sg9v+TQ9Z
         76K0+vdDR8v95Lww3aSVM4ri/eatSHuXAt179tCdZKLQthMQS/ZsDSPS42txv42nh9bX
         dCssrgtbMHio+2lB2iQD31oWjAnxvV7RHMuSuiym3IkvOPR9L2AiWDuNoFJnBGMRWWIT
         t0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpyhrCH4eKTJSelS4BtxCH/z19fxo1jSDpO/4tVrznQ=;
        b=qtJip8DTuE//u2U0le8uQz+tk4rNPTcxSj289iTtlPr0Lxm+DLfjzZ8wHMkl6IA3to
         uzBEJpNtTYbBlxIHeqpGwebsKS32FbjydsAj2emBfABLvMjWNAgsngk0mTUdoPaZTZ1p
         rEcbtvZlNGonY9AaS8Y8IGsM82kGRDq0cDzxcWbLKz1LcFenoliEDcA6KZKyKvaESEVh
         LyOPpl2Co47stgRW4GlJvg1NRY8inGFpKnTNW8ZnXZeqgT8u3XdYYauq5VjP05Q08IT7
         hmqmprU+i2MwoKU9gvTXkosdTs42RGmYQTfx3I5USEPClDRNqqhLFKEWaBlDcesurebA
         OdCA==
X-Gm-Message-State: AOAM532aPevW1MjR2qfW0S/dGIlAfCy8Gky3feSCxdbexLOqBSWvY7sN
        3qXQsB/kpNPgbjBieRL3T1Y=
X-Google-Smtp-Source: ABdhPJyysKQG9Da79zYsgd5MtHNZx3EGVO28pOqu8huF+5G0OFwNRUakppW8Pa+l+EH1gVrMkPo6Qg==
X-Received: by 2002:ac8:774f:: with SMTP id g15mr6387982qtu.145.1596242785832;
        Fri, 31 Jul 2020 17:46:25 -0700 (PDT)
Received: from ?IPv6:2601:284:8202:10b0:c147:b41e:be5e:8b7a? ([2601:284:8202:10b0:c147:b41e:be5e:8b7a])
        by smtp.googlemail.com with ESMTPSA id j61sm10860360qtd.52.2020.07.31.17.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 17:46:25 -0700 (PDT)
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
To:     peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
 <20200731074726.GA1485940@krava>
 <20200731153612.GC1299820@tassilo.jf.intel.com>
 <20200731180539.GA2674@hirez.programming.kicks-ass.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <27a4663d-bc71-5f52-5871-23d4061fe575@gmail.com>
Date:   Fri, 31 Jul 2020 18:46:21 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731180539.GA2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/20 12:05 PM, peterz@infradead.org wrote:
> On Fri, Jul 31, 2020 at 08:36:12AM -0700, Andi Kleen wrote:
>>> yep, we have a customer that needs to compare data from multiple servers
>>
>> It's also needed to correlate over different guests on the same machine.
>> This is an important use case.
> 
> Both these cases you want to sync up CLOCK_MONOTONIC, using walltime is
> just utterly misguided.

Every userspace component logs in walltime. You can say that is
misguided, but that is the way it is. The missing piece is the ability
to correlate kernel events to userspace logs.

> 
> What happens if the servers have (per accident or otherwise) different
> DST settings, or someone does a clock_setttime() for giggles.

Yes, someone *could* change the time. Someone *could* start ntpd or
other time server in the middle of a session. While technically such
things can happen, that is not real life in most environments (e.g.,
Data center servers). ntpd (or other) is started at boot, and it is just
the little misc adjustments that happen over time.

We could add tracepoints and detect the changes and invalidate the
reference time. We could add tracepoints to track the adjustments and
update the reference time. In my experience over 9+ years using this
tool (out of tree patches) that has never been the problem.

> 
> All you really want is a clock that runs at the same rate but is not
> subject to random jumps and user foibles.
> 

All I want is to compare user logs to a kernel event via timestamps.
