Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1008C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C4920836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZKEW3toQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgEKVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725355AbgEKVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:13:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58214C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:13:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so5120919pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hUQMJys9GXX0OApmECyo7V+SJ+sKw8u+lJewTe9R5AU=;
        b=ZKEW3toQkxakBREaqJqBiIE7vNAgIgbSlR89IzT1kwQYXkICDfbpQO8esDKoLJJ8mw
         tXRfh6B0tTtaZZ2jyHU9NeDVmSBprIjhvLhu6De1dx2wFt05O6caAHsZEL3ESIu7ATWh
         MgLznWvYwtFwu0fds2ZHicQiRkzFYhu94qwLsb6C/SNHk0Z4vwCdBciOgh7HrDgZy3ra
         yMz10O5CaJfddKRo6jcz6WaZEJAzQaedyaYuvI9qTPUx0DLensSrIPmMpmLSdTbsLvFA
         6Fe4Rx8YFQbjCHp1vaxY4U8PWavZByIJJd7tdihMrLrG5ln2z3uWzvuGfyCvd415yPdn
         +AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUQMJys9GXX0OApmECyo7V+SJ+sKw8u+lJewTe9R5AU=;
        b=NmyEZTWSMcjDdKqIiUVwtgFY0Kf1SR0avVH30sQ/RLSolXG8OcZdI67bdvnj3TfyXB
         KRvKGupDyoHoCi8hZ8fhImx38EzqgQKUhbFd3G3R2NmyyqxbqwQxw+2/BQ8rxxqX/k7i
         qPt+6tciRhcBjqUfKv2BfAHLuWIMRrE73lGynInVdXfwq0lt7FtsYw0cn/jzfDB7pacq
         n+s7aTGHMMXqsu2/Ue6ib+2On9SDw8VKfzIi+Jdor4AVgUNXbG/7utNpy84QTZNQvo6f
         dNWVOHkwhl0KuV3jhkNMxyWU10k1WMPvdi2NcBaLUyE9vq16bQPNi/Pd9yWNQ8CZ/77y
         y2SQ==
X-Gm-Message-State: AOAM530NmeTPcMwqJXJ7VQfegkV/dVt+VAbopEeNJneyV8kBKK8BWrgI
        xBtujsrwsuheaFmu77Kde81y0A==
X-Google-Smtp-Source: ABdhPJz0vPahRYr9Z3u+DQ62wb8D6DV32O/3QHkApFFpe2HvnuBdo6EtGykV8XZSwWdslWFSKHTpzQ==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr4948063pgf.405.1589231585784;
        Mon, 11 May 2020 14:13:05 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s9sm10071376pfc.179.2020.05.11.14.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 14:13:04 -0700 (PDT)
Subject: Re: [PATCHv3 42/50] xtensa: Add loglvl to show_trace()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-43-dima@arista.com>
 <20200511194534.GA1018386@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <fa4a0d52-3186-27eb-69f7-3bd7ba7fa00a@arista.com>
Date:   Mon, 11 May 2020 22:12:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511194534.GA1018386@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 5/11/20 8:45 PM, Mike Rapoport wrote:
[..]
>> @@ -511,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>>  	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
>>  		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
>>  		       sp, len, false);
>> -	show_trace(task, sp);
>> +	show_trace(task, stack, KERN_INFO);
> 
> it should have been
> 
> 	show_trace(task, sp, KERN_INFO);

Thank you for noticing it!

> 
> Andrew, can you fold the following patch as a fixup please:
> 
> 
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index f9217b6b45c8..efc3a29cde80 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> @@ -515,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
>  	print_hex_dump(loglvl, " ", DUMP_PREFIX_NONE,
>  		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
>  		       sp, len, false);
> -	show_trace(task, stack, loglvl);
> +	show_trace(task, sp, loglvl);
>  }
>  
>  DEFINE_SPINLOCK(die_lock);
> 

Thanks,
          Dmitry
