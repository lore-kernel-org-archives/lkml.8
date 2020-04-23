Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666AC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD74620728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BGmH/FCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgDWQKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729391AbgDWQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:10:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D60C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:10:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so818972pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PXdH7gtulh3o2j8CqVfWunfbdEFNfgOMbxxUAKN27N0=;
        b=BGmH/FCuCaVSJq9IlwPrm6m9ZQjhGItMZhvk1Ff7plNumL+7RUcSSqcITz2BRTJlmz
         PDk1s8zw200TBnHFCMmaqrrUL0s+YWiGimGF5wAivxPzzipnPqSfiyAN3SpdorLN2BEk
         J4YgqZDgQId8LXnuZmRuDltYsR1Hxcu2QfjKTSziIQ503KMeOtVYMOCapPkyhpnJUNdv
         kPWQDlyJQssd86E2kUtp5QM6+FY2YIplaqPadylFfO6GO5pstFilHvHfgr3uo7B911HR
         lyA4UFKf5OC3q2jGt92jRqDQCz7AhBcfbEsTMbqQXmPPeyBWfvJ2+buMI94085LgzEtF
         QjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXdH7gtulh3o2j8CqVfWunfbdEFNfgOMbxxUAKN27N0=;
        b=qeQLAEa9BJW/ku9L8TlXEUv5ZvINSJ39h6dGCBLb1rsiIkLTd/E8YsSrL/Dyc7WId9
         b/BJdqvXHjP0/f7v8Sbljz6GPdKKFq0heLexF/E1Xes8a1D7mE3yDDPH8Y/snRV8bXF+
         WTT+BRPWfFloIBkJFNL0a9L7b/bk5XwUfwPRKdzS01eqgEuZV28T80JRDU3qj7eZq5uJ
         K62475shLentIhErnLiYNSahvlel8kIRl/JCZEVv/YMNJLqec26LG6q+E11HOawkgA0V
         nUEdTBPPlep7Qido6H6Cizh9ywQ9u0y7UdGiQ5ZwtjDCporgtDQdSf0IZFY3OclKqVIF
         NwNw==
X-Gm-Message-State: AGi0Pua9oSlbO2h2htV+T10Z3iO4nEPW4J4OC6vf/ws5+tpew5q2dCKJ
        pRW73OHnMEbpZwUnobkoV20qEQ==
X-Google-Smtp-Source: APiQypLgNut8lAUE+bMux20idbYi6ZaPb8Atd9R8ay1QqQsCZH7bqNRY4J4h2GfpXTfkr/3awCurmg==
X-Received: by 2002:a17:90b:3598:: with SMTP id mm24mr1568048pjb.132.1587658228929;
        Thu, 23 Apr 2020 09:10:28 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id a23sm2854945pfo.145.2020.04.23.09.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 09:10:28 -0700 (PDT)
Subject: Re: [PATCHv3 00/50] Add log level to show_stack()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200418201944.482088-1-dima@arista.com>
 <91d0f39c-2f79-20c0-7c68-f129dfea5e14@i-love.sakura.ne.jp>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <f2ea1d6f-f44e-fd44-ce45-293ca0006bbc@arista.com>
Date:   Thu, 23 Apr 2020 17:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91d0f39c-2f79-20c0-7c68-f129dfea5e14@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On 4/23/20 4:48 PM, Tetsuo Handa wrote:
> On 2020/04/19 5:18, Dmitry Safonov wrote:
>> Add log level argument to show_stack().
>> Done in three stages:
>> 1. Introducing show_stack_loglvl() for every architecture
>> 2. Migrating old users with an explicit log level
>> 3. Renaming show_stack_loglvl() into show_stack()
> 
> Thank you for proposing this patchset.
> 
> Every architecture gets show_stack_loglvl() means that it will become
> possible to implement dump_stack_loglvl(const char *loglvl), isn't it?

Yes, it should be quite trivial.

Currently I'm waiting if there will be any noise from linux-next, then I
plan to add dump_stack_loglvl(), also sched_show_task_lvl() and
show_trace().

> I'm about to start a proposal for making it possible to suppress printing majority of
> OOM-killer messages and memory allocation failure messages to consoles
> ( https://lkml.kernel.org/r/efc649fc-f838-97ea-44a2-882f068d033c@i-love.sakura.ne.jp ), for
> dump_stack() / show_mem() / dump_tasks() etc. can take long time (if printed to consoles) is
> an unhappy thing for OOM context and atomic context.

Sounds good - especially for slow consoles.
One can use sysrq to print OOM info.

Thanks,
          Dmitry
