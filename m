Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEFCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F8C206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElcSoZ2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIRyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:54:25 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37279 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:54:25 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so5957064qvz.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T68rPewmf4BnEjG4gbV45voMaldyLN/fs5q/Sve6O4Q=;
        b=ElcSoZ2hSryP0NOI23Sav6u//9KLZnBNbbDNdDAFlJUKPjBMd6LSrzm4JBSbhIibDI
         RugUq4rXBOiK5q74PQvz+Rr5OBy3zs/+JzARqs7Hxn8W1QMYF7VjvQoI/ZJqaUM0JcUq
         WASmRHLJAdqjqnD2GXR75v+X6Mht85cQRNyDg461zHBvDF+JcapAGerWNerh520g94YR
         uTnzlDFskAlG65RcrdwVHdsAn8X7MCVfXj9eTEy7+beAwuKsisiUkwfLelk2F0TwXsch
         9a/6xlSgI+dFKGtYt8AKNBc5ZtiuMbXCty24Uv3HmKrEHao6MUa+bmhPFyOT49OveEWg
         71mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T68rPewmf4BnEjG4gbV45voMaldyLN/fs5q/Sve6O4Q=;
        b=il9txihcUg3KLCPCSWYTFSOLjnEEo5N8M5CBI5m7hRxx3RsfyZheNVTMOc9pv1iTwp
         IOF0axPoWDu1hWfEqXChiBrCKSEaphSSs73UefkPsAvcxqm6Npf6JbU2aKfCRzByTljQ
         OCrAyFQuOtMLTIF063gYliqKocuXiK2pP/aaOt2J1Zl7kIShhmdvkKynIdF+DwtaFRXT
         miDTd5tKKlU8dlnw2Q7moffMXTKQt8Y0Cyx94pJ2W5eeUcBGdOo43liHpcsOW07qn1fh
         hf9f/igyr/XXOvy3hv7yxavgfB+IV4P/9cgDj0lbIm0iEOtcgxA8BiXhCWj/P5M6MK4Z
         t+rQ==
X-Gm-Message-State: AGi0Pub6oxnPY0cgUR1avjXoAAeYJZ6+4M7/Ql7WpdoxNs0eSz4GGr9X
        GI1s2D0LYTCxQ8jVz2NXmdJfZljJ2UKbZeNatrh0Sg==
X-Google-Smtp-Source: APiQypL4GIZ16krMeIYz180+JcjeFeUo3/PF+/HzEK8g/KUfeZ/nh0KVBZ8b2keh/jk0MTTeoDu8oOMCvuE3H7r1Gcw=
X-Received: by 2002:ad4:4c85:: with SMTP id bs5mr1274772qvb.213.1586454864517;
 Thu, 09 Apr 2020 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200401114215.36640-1-cj.chengjian@huawei.com>
In-Reply-To: <20200401114215.36640-1-cj.chengjian@huawei.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 9 Apr 2020 13:54:13 -0400
Message-ID: <CAJWu+ooyRsFFA13=rqMBCFgf_JeHsOr16-ayuECaQ5Xz48mrqQ@mail.gmail.com>
Subject: Re: [PATCH] sched/arm64: store cpu topology before notify_cpu_starting
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        aaron.lwe@gmail.com, aubrey.intel@gmail.com,
        aubrey.li@linux.intel.com,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        LKML <linux-kernel@vger.kernel.org>, mgorman@techsingularity.net,
        Ingo Molnar <mingo@kernel.org>, naravamudan@digitalocean.com,
        pauld@redhat.com, pawan.kumar.gupta@linux.intel.com,
        pbonzini@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        tim.c.chen@linux.intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        xiexiuqi@huawei.com, huawei.libin@huawei.com, w.f@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 7:27 AM Cheng Jian <cj.chengjian@huawei.com> wrote:
>
> when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
> SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
> the thread_sibling is ready for use.
>
>         notify_cpu_starting()
>             -> sched_cpu_starting()     # use thread_sibling
>
>         store_cpu_topology(cpu)
>             -> update_siblings_masks    # set thread_sibling
>
> Fix this by doing notify_cpu_starting later, just like x86 do.
>
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>

Just a high-level question, why does core-scheduling matter on ARM64?
Is it for HPC workloads?

Thanks,

 - Joel


> ---
>  arch/arm64/kernel/smp.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 5407bf5d98ac..a427c14e82af 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -236,13 +236,18 @@ asmlinkage notrace void secondary_start_kernel(void)
>         cpuinfo_store_cpu();
>
>         /*
> -        * Enable GIC and timers.
> +        * Store cpu topology before notify_cpu_starting,
> +        * CPUHP_AP_SCHED_STARTING requires SMT topology
> +        * been initialized for SCHED_CORE.
>          */
> -       notify_cpu_starting(cpu);
> -
>         store_cpu_topology(cpu);
>         numa_add_cpu(cpu);
>
> +       /*
> +        * Enable GIC and timers.
> +        */
> +       notify_cpu_starting(cpu);
> +
>         /*
>          * OK, now it's safe to let the boot CPU continue.  Wait for
>          * the CPU migration code to notice that the CPU is online
> --
> 2.17.1
>
