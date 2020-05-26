Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7321C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CA02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IiYzYMWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbgEZS66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390428AbgEZS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:58:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:58:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v4so17097157qte.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjoliUfvbku6NAedJER/qXlY6SBZSp5CpYZIHr5HINA=;
        b=IiYzYMWUvmNd5hzuMmXXytnwc4UwCEuW3hPpITIAioJ270FpHW9eQDA25d+VUTRUyV
         /dFTBpU0IBDTV+SzfofT+BLcaaKMYszPa8Mg/NudsKGPn5ur5DvaSFZEXKGmRzHP0Kk2
         efn+BdwZDIxJ3U5aain49eCJefS1/q0Yy8QHN95I2lbHFFnWyL6a7FRVprrM01hWOuLa
         GjsZhH0Wn0JM5D2nYaDO1PWSskADk7tahX2wHWnrf9oKKXlg0huwSFMRBAwk0iOev9w4
         8vcv0yMrI/PjIUg9k7/c3KPaKxVritmc3iMdrSOD7O2K5tFIu2Ey8Zax6q7cD4hS0pJf
         NRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjoliUfvbku6NAedJER/qXlY6SBZSp5CpYZIHr5HINA=;
        b=txG9R1B6C/HeaUpoc7f+rPH6ZNkTLllYrzuz653/9WQzdBrJ2bZt/APry9k45J5yjX
         YstVNIDXFqHPcJ1GAER3nLWrLDnrynsInkhFfi0Q4DdIZJ3ExHRNkISTIY+UUlmXh2+U
         hJSMCaOfynbJ833M86jPA8crCE6p88oV0JYwmhOvH4u1D1UPtfWI5HAS8E3tjKI4Qkvx
         kiDM0qCWIEnkfzlqYSSm5jyKUwFWUBAUCujJaXmUr8FjRhz9gcEMsLicgU5yHXtKXFQS
         iYpVmSn3FnDAkxKY01iW6a8k+KUPMIJX+lifoCjMD9TsE36ibfZNWPajN9gIRxex8zf7
         C+Hw==
X-Gm-Message-State: AOAM5332QcCCXp4jfIHuQT+XsVUpT3kNfBH1g3AadlPeiZwjzp5RJV2e
        8VGxdTpTIu6OsgYzcFYnRFjI6Q==
X-Google-Smtp-Source: ABdhPJxJX2uoD88ndJDHTyRWsJwus80AMdWEX5WKid7HU24VXzVLq9dM17nRp54quc8a5QEH3WUzSQ==
X-Received: by 2002:ac8:1601:: with SMTP id p1mr228565qtj.311.1590519533596;
        Tue, 26 May 2020 11:58:53 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r7sm509210qtc.25.2020.05.26.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:58:52 -0700 (PDT)
Date:   Tue, 26 May 2020 14:58:50 -0400
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526185850.GE991@lca.pw>
References: <20200526174349.8312-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526174349.8312-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:43:49PM -0400, Waiman Long wrote:
> It was found by Qian Cai that lockdep splat sometimes appears with the
> "BUG: MAX_LOCKDEP_ENTRIES too low" message on linux-next. On a 32-vcpu VM
> guest with a v5.7-rc7 based kernel, I looked at how many of the various
> table entries were being used after bootup and after a parallel kernel
> build (make -j32). The tables below show the usage statistics.

I think this approach could help the situatin on this AMD server.
However, I don't understand why this particular system starts to exceed
the MAX_LOCKDEP_ENTRIES. All other Intel, powerpc, amd64 and s390
running the same workload have only < 20k at the end, but on this AMD
server,

After system boot: ~13000 (which is similar to other arches.)
After LTP MM +2000
After LTP Syscalls: +5000
After reading all sysfs [1] (except debugfs): +10000
[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/read_all/read_all.c
# read_all -d /sys -q -r 10

I still don't understand why reading all sysfs files on this system
could increase that much, but here is the lockdep file after
running sysfs read to see if you could spot anything obviously,

https://cailca.github.io/files/lockdep.txt

lock-classes:                         2114 [max: 8192]
 direct dependencies:                 28568 [max: 32768]
 indirect dependencies:              126882
 all direct dependencies:            304192
 dependency chains:                   38269 [max: 65536]
 dependency chain hlocks used:       141480 [max: 327680]
 dependency chain hlocks lost:            0
 in-hardirq chains:                     166
 in-softirq chains:                     818
 in-process chains:                   37285
 stack-trace entries:                175558 [max: 524288]
 number of stack traces:               8355
 number of stack hash chains:          6545
 combined max dependencies:       804750782
 hardirq-safe locks:                     80
 hardirq-unsafe locks:                 1048
 softirq-safe locks:                    169
 softirq-unsafe locks:                  957
 irq-safe locks:                        183
 irq-unsafe locks:                     1048
 hardirq-read-safe locks:                 4
 hardirq-read-unsafe locks:             943
 softirq-read-safe locks:                12
 softirq-read-unsafe locks:             940
 irq-read-safe locks:                    12
 irq-read-unsafe locks:                 943
 uncategorized locks:                   255
 unused locks:                            0
 max locking depth:                      19
 max bfs queue depth:                  1136
 chain lookup misses:                 43195
 chain lookup hits:              3151662027
 cyclic checks:                       44009
 redundant checks:                        0
 redundant links:                         0
 find-mask forwards checks:            7726
 find-mask backwards checks:           8095
 hardirq on events:              3503795225
 hardirq off events:             3503795224
 redundant hardirq ons:              453772
 redundant hardirq offs:         1856554342
 softirq on events:                51104551
 softirq off events:               51104551
 redundant softirq ons:                   0
 redundant softirq offs:                  0
 debug_locks:                             1

 zapped classes:                       1101
 zapped lock chains:                   1117
 large chain blocks:                      1

> 
>   After bootup:
> 
>   Table               Used        Max      %age
>   -----               ----        ---      ----
>   lock_classes[]      1834       8192      22.4
>   list_entries[]     15646      32768      47.7
>   lock_chains[]      20873      65536      31.8
>   chain_hlocks[]     83199     327680      25.4
>   stack_trace[]     146177     524288      27.9
> 
>   After parallel kernel build:
> 
>   Table               Used        Max      %age
>   -----               ----        ---      ----
>   lock_classes[]      1864       8192      22.8
>   list_entries[]     17134      32768      52.3
>   lock_chains[]      25196      65536      38.4
>   chain_hlocks[]    106321     327680      32.4
>   stack_trace[]     158700     524288      30.3
> 
> Percentage-wise, it can be seen that the list_entries for direct
> dependencies are used much more than the other tables. So it is also
> the table that is mostly likely to run out of space when running a
> compex workload.
> 
> To reduce the likelihood of running out of table entries, we can increase
> MAX_LOCKDEP_ENTRIES by 50% from 16384/32768 to 24576/49152.  On a 64-bit
> architecture, that represents an increase in memory consumption of
> 917504 bytes. With that change, the percentage usage of list_entries[]
> will fall to 31.8% and 34.9% respectively to make them more in line
> with the other tables.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep_internals.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index baca699b94e9..6108d2fbe775 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -89,12 +89,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>   * table (if it's not there yet), and we check it for lock order
>   * conflicts and deadlocks.
>   */
> -#define MAX_LOCKDEP_ENTRIES	16384UL
> +#define MAX_LOCKDEP_ENTRIES	24576UL
>  #define MAX_LOCKDEP_CHAINS_BITS	15
>  #define MAX_STACK_TRACE_ENTRIES	262144UL
>  #define STACK_TRACE_HASH_SIZE	8192
>  #else
> -#define MAX_LOCKDEP_ENTRIES	32768UL
> +#define MAX_LOCKDEP_ENTRIES	49152UL
>  
>  #define MAX_LOCKDEP_CHAINS_BITS	16
>  
> -- 
> 2.18.1
> 
