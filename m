Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F444C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236AF2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ueoQGnQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgHNWq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:46:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C540C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:46:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so4825063plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hfkleEwSe7pLkB1i+3oiskPIgfmW6z+glQ5do1GkngU=;
        b=ueoQGnQgW5aNBF+q57GgcNTXjdyuwW3K88ga2JaQhzV7mJG76V/u7U1gG63QK7QKSY
         V+SB8kr0uA9VzGzKQ3mPanX+ObE513VSRBxefsfMR3hsIf20tUPoKWF6SGvVkO7CoRbf
         rvhYjx3CdRJS2K24smJ1WJRY/6RTXoRcauaf4af9pqbxeGUEPjFaojrI6c1i5cHvxIBJ
         PHRPhPvJ+IOeua5/oMKIDNehV/d7cHXIMqnXXMvYnBvG5T2fFyi2ao7MVWMhNnyHVyNQ
         9XfQPDzaxCBJlLhoO51zSDDDVcYqapC9p4iw3QTd8mrh+JBv/grkt/x5zP+UU4e4cmao
         47NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hfkleEwSe7pLkB1i+3oiskPIgfmW6z+glQ5do1GkngU=;
        b=a84DV4xsmDyTQIfuV2r/1VSen1gAF5cS9KwWVskUqeEUvrqgQCthWdWXAtakBpwwQd
         2hQCw/8HdhKUQTWvmfdEB8pjBEECXN1xcv6B1/gytHaeSnS01EqJpRfnx4aCsF/Mggew
         87q5VOMH6VYxz0pNlYQntTmwdwgtSghFzRMtnYS2Mhp1w73+LFKcVlrGuNmB/7xvi6YA
         Wj9JUc0t17ZdgScy3Raymif3mGrK0OIn4p+1RT1kz6Tzkq8COwPcPrNJYFdYCWKhuHTq
         dPPV+V9Yvk8RYO05DThhthwyM/BGRt3P1KurPpOkujbigsf6GQpWVqv9t2T++mzX2Ej9
         QFLA==
X-Gm-Message-State: AOAM532jLzYdXIYEEczVU1Dl9tl2rJwJS9bKeVHwuNkFkNKNj0nGemr2
        qIQDeholZdk+1h5kiSWV4Z9bcg==
X-Google-Smtp-Source: ABdhPJzlKNlwtLtRjj0H1x1Ji+tUu5s6Vu5SfHlWfbVy6P4m/qfnwqHH0hb6pWdbUe8J+eN645d+Vw==
X-Received: by 2002:a17:902:d346:: with SMTP id l6mr3263838plk.77.1597445216938;
        Fri, 14 Aug 2020 15:46:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g4sm9643218pjh.32.2020.08.14.15.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:46:56 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:46:56 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Aug 2020 15:46:54 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Setup exception vector for nommu platform
In-Reply-To: <CAAhSdy1hLAVEHohtuZ6XYxOjWgUmZPXah=tJFrb6tWoRyEiRgA@mail.gmail.com>
CC:     qiuwenbo@phytium.com.cn, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, atishp@atishpatra.org,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, greentime.hu@sifive.com,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-4a2f780e-e0c2-41d9-9ce9-c27a090236c3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 01:49:44 PDT (-0700), anup@brainfault.org wrote:
> On Thu, Aug 13, 2020 at 9:10 AM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>>
>> Exception vector is missing on nommu platform and that is an issue.
>> This patch is tested in Sipeed Maix Bit Dev Board.
>>
>> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
>> Suggested-by: Anup Patel <anup@brainfault.org>
>> Suggested-by: Atish Patra <atishp@atishpatra.org>
>> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
>> ---
>>  arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index d0c5c316e9bb..0a4e81b8dc79 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -77,16 +77,10 @@ relocate:
>>         csrw CSR_SATP, a0
>>  .align 2
>>  1:
>> -       /* Set trap vector to exception handler */
>> -       la a0, handle_exception
>> +       /* Set trap vector to spin forever to help debug */
>> +       la a0, .Lsecondary_park
>>         csrw CSR_TVEC, a0
>>
>> -       /*
>> -        * Set sup0 scratch register to 0, indicating to exception vector that
>> -        * we are presently executing in kernel.
>> -        */
>> -       csrw CSR_SCRATCH, zero
>> -
>>         /* Reload the global pointer */
>>  .option push
>>  .option norelax
>> @@ -144,9 +138,23 @@ secondary_start_common:
>>         la a0, swapper_pg_dir
>>         call relocate
>>  #endif
>> +       call setup_trap_vector
>>         tail smp_callin
>>  #endif /* CONFIG_SMP */
>>
>> +.align 2
>> +setup_trap_vector:
>> +       /* Set trap vector to exception handler */
>> +       la a0, handle_exception
>> +       csrw CSR_TVEC, a0
>> +
>> +       /*
>> +        * Set sup0 scratch register to 0, indicating to exception vector that
>> +        * we are presently executing in kernel.
>> +        */
>> +       csrw CSR_SCRATCH, zero
>> +       ret
>> +
>>  .Lsecondary_park:
>>         /* We lack SMP support or have too many harts, so park this hart */
>>         wfi
>> @@ -240,6 +248,7 @@ clear_bss_done:
>>         call relocate
>>  #endif /* CONFIG_MMU */
>>
>> +       call setup_trap_vector
>>         /* Restore C environment */
>>         la tp, init_task
>>         sw zero, TASK_TI_CPU(tp)
>> --
>> 2.28.0
>>
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup

Thanks, this is on fixes.
