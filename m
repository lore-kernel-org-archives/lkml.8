Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C961C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2566D214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XFfxS9KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDQW7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDQW7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:59:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:59:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so4854292wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9+eK9oKTOT3i8zAun0pqdW6UL+0nXAjeXn0xSjWy3ek=;
        b=XFfxS9KM5RUpYEecDU9LDOTUnYwrQ87bsghotn9o5G37xaObnMtd8FAwhQDPL53IAM
         UdZR8vn7/AtBs/8VwzLToZRY7JA4FRDBCaGXC10UhrvN26Luq6/JzgwcWQrPcA6x5jcd
         3l/ZCADGoGHBAU7VnVJkKn0q3li6SfPlC5H1+4CI+57yfqchhhCT/wBS/Kh1ZoFWSDOq
         W5HT3Q1M0eYUsQdbrrsRBReDHa+b4Y7g1reMHhQP9iaI6+naf/zOhmwNdFKkfkpXDuEr
         2WDaufDeHlN/+xRGdmp4nLIz2kGiaMc/NXIYDDXcvuedv/EQHV+eTS8pR1LxRKT/dRru
         o3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+eK9oKTOT3i8zAun0pqdW6UL+0nXAjeXn0xSjWy3ek=;
        b=tDQsB86oZw0C8rmoFzKOKbYXtcfUpxPKeewQienqGc75nXFPXmUaAEVXgWOnvwKwh4
         FY/d+XyOydAhZMwUes7GYq2Foc6fSHaZB+Ba01CRfYweOh3Y0vCn6xtpO5nSWY7ify2C
         2FuV1KogmnQ1UgzXdXtJLeGJvHmOR7PEgbY4/21vkDjklhbHrFeBPSZUCJIZmWBNGs5R
         PqMBWFyK2Zrjr1LwPmE81BYNGNqhiKrPv+s1eKVOEwRfuxZsRLcMRzNkELDJ1m0HZ/R7
         FKoWsbXRXxO/uR2Cdbzg1oECgDz20uRC+HKnIBR8l+PnMLf59okil0D7jeucSuSO0fPb
         LjfQ==
X-Gm-Message-State: AGi0PuYT+gtyCXYjlEmf5YkJwLSFd6Vbobvp6Jofvv79k6He950bfFPv
        jh/wy1Z+SkZpA/aJsOlc9tf6CA==
X-Google-Smtp-Source: APiQypLqlt3uovyL1IBjjjc8qBljmPanbafSQqKnsPq+OIxxCLbZ6Nc44ailz0qCbC7ZjccZO5rHEw==
X-Received: by 2002:a5d:4452:: with SMTP id x18mr5960505wrr.231.1587164343004;
        Fri, 17 Apr 2020 15:59:03 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id p7sm34069559wrf.31.2020.04.17.15.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 15:59:02 -0700 (PDT)
Subject: Re: [PATCHv2 01/50] kallsyms/printk: Add loglvl to print_ip_sym()
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20200316143916.195608-1-dima@arista.com>
 <20200316143916.195608-2-dima@arista.com>
 <97ea305c0d336f3c36a804b37e6bbb4b1bbf24fd.camel@perches.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <7d17eaf8-a3a8-eaba-ff80-e857135571e1@arista.com>
Date:   Fri, 17 Apr 2020 23:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <97ea305c0d336f3c36a804b37e6bbb4b1bbf24fd.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 3/16/20 3:29 PM, Joe Perches wrote:
> On Mon, 2020-03-16 at 14:38 +0000, Dmitry Safonov wrote:
>> print_ip_sym() needs to have a log level parameter to comply with other
>> parts being printed. Otherwise, half of the expected backtrace would be
>> printed and other may be missing with some logging level.
> 
> There are 15 instances of print_ip_sym.
> 
> Perhaps it'd be better to get rid of print_ip_sym
> altogether by expanding it in-place instead.

I tried this and format-string + two casts to (void *) take some space
and the resulting printk() doesn't fit 80 cols.
I guess, it's minor and it can be done on the top of v3..

> 
>>  arch/microblaze/kernel/unwind.c | 2 +-
>>  arch/mips/kernel/traps.c        | 4 ++--
>>  arch/nds32/kernel/traps.c       | 4 ++--
>>  arch/riscv/kernel/stacktrace.c  | 2 +-
>>  include/linux/kallsyms.h        | 4 ++--
>>  kernel/locking/lockdep.c        | 4 ++--
>>  kernel/sched/core.c             | 6 ++----
>>  kernel/trace/ftrace.c           | 8 ++++----
>>  tools/include/linux/kallsyms.h  | 2 +-
> 
> 

Thanks,
          Dmitry

