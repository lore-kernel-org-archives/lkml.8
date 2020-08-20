Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AB720758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMnnSDvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgHTFIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgHTFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:08:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:08:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so466761pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wl+znekrpMZrhKgF03OEXg1dwyzi76Esp+ribqdDlGI=;
        b=hMnnSDvu0c3nlgbn6bO0Ai9bdqHLyURvdDarPxav6NYqulkykK7Ji7H4AIMy6wxGQ+
         0HOumv9F4HsnLJZ9PRzXDkawxZgcJtyod6Ut6vSktmKbsB+4ZvFr7MB3ejwSXIs3gSMy
         2Iri5tCLqYVpky2RTREaMTIvRU51Z9HoaZ8l5nJfSkLtVLDygxT2l1vhq5Jl+BtM0u+u
         6SGBD/hlIFbPzepHk6YwLnW4en1ikPDDzUvZzE4itaCdt2avtmj69NP+1Mq5LzpLSV7h
         gmhq8Kz+WHIRRX0l5e/jXGB5WGezJ4RgOVn1bo5bx9G7BDNSckHiKmjnPHMTkP911Xlt
         6KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl+znekrpMZrhKgF03OEXg1dwyzi76Esp+ribqdDlGI=;
        b=uKgEB/sfUXBS/iGtoihjxzvQchSLxLhaI8T+AYIJKNHSgkCnLj6QnyWgiqeHQKeSeG
         0YfBDJH9kMYcL36pCbvDr0AzHGM3GuyBSGRjmrp43hUqswgUflfOHW4OxcWMPWnNPcig
         Qe0ASHIrly5AyW5hZTWKEqKQwQ56CJQAxJf0kQcDt9wiJBBn261C6diXrjzD0QYwK0bY
         40RuUL/oEGj0TOuxYGuVKDoMFV4Vfzfo5krqKxT0KQOPyYrgOruSeES0ilhSIXzdt17C
         Zc3QwcIw7sYSoBIznAPhHoCbX5i44T2CMr73QCzjKRByNyo01QxSEjvHqjUic18Buh3a
         4xIg==
X-Gm-Message-State: AOAM533+O+uq01J4QfcHxz8LvmhwZ8Fn073XYj0HMZuKb2Zr6HFE4Dgk
        OYwuHWCjpLOm+PSHrM9LLFedPIlXg0vp0fwjsziT7YR05WyGIQ==
X-Google-Smtp-Source: ABdhPJyb/CUZZAjXRGXkCMrx3gc4Hq9Q1vCQjk897voR1EdUHjCbmr0J5pdB+Op0uCen5iCbowfdrR5sJ18YlrVhOaY=
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr1333959plt.21.1597900109539;
 Wed, 19 Aug 2020 22:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200819070530.GJ18179@shao2-debian>
In-Reply-To: <20200819070530.GJ18179@shao2-debian>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Aug 2020 22:07:53 -0700
Message-ID: <CAGETcx9mctL_51Cgq9rWQuQhPpRixfqCt8fp4jyH0MP-Eg4p=w@mail.gmail.com>
Subject: Re: [driver core] e2ae9bcc4a: unixbench.score -2.2% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:06 AM kernel test robot
<rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -2.2% regression of unixbench.score due to commit:
>
>
> commit: e2ae9bcc4aaacda04edb75c4eea93384719efaa5 ("driver core: Add support for linking devices during device addition")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
>
> in testcase: unixbench
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> with following parameters:
>
>         runtime: 300s
>         nr_task: 1
>         test: syscall
>         cpufreq_governor: performance
>         ucode: 0x5002f01
>
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
>
> In addition to that, the commit also has significant impact on the following tests:
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/1/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2sp8/syscall/unixbench/0x5002f01
>
> commit:
>   372a67c0c5 ("driver core: Add fwnode_to_dev() to look up device from fwnode")
>   e2ae9bcc4a ("driver core: Add support for linking devices during device addition")

I'm ignoring this report for the following reasons:
1. These commits are almost a year old.
2. Code added by these commits have been changed quite a bit since
them to make them faster.
3. And most importantly, this code is effectively a NOP in a system
without devicetree firmware. I'm fairly certain this x86 Xeon system
isn't running off a DT firmware :)

-Saravana
