Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21293208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jJTXjPkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgE0BOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgE0BOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:14:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002E2C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 18:14:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so17901377qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NHzMNH28y/GXSoFOf1/NF/R2VMPDvKZxUdmkO5KBgxY=;
        b=jJTXjPkgJLHrf2hO4j4PKGAsQ+OKm/7kMeoo0TXPZvOfXHeldzfY1lXSh+NwiaxTOw
         ZKnc3V5UK9RskJaNiNhRroqXlInFVKOAbJ9njNeGK1woyD/fhwy2Lh2BzGuO3QqBKS49
         Y6UzSbGFQwu17utdr39lsGrhkGKF4xP4O6twY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NHzMNH28y/GXSoFOf1/NF/R2VMPDvKZxUdmkO5KBgxY=;
        b=EKGkWeoQocMDVit7lYsT7RE4yAedA2cN4SI8+cauD54VZidEkSPSaN4zic94ITTgxS
         ECm47azt2sLzW8MmldGTltQsTK6pDlwchVzVFRbNMXUdjQsgyUshi3a+RPixIQhL3OAc
         GJ06/y7IfDPzxpvQcDYIIcP4SzRuVdCO1Ko5J9tJVMZQnmMmYsxam0yDRAu4Bx6gxJGn
         sOVMxO56lZv2RmVft5UO/AjeUrhgPLXrswYBkbofBmSr4HqSXDo+5CMjDLa63btocSIG
         U+Qw+Eh3vq9fP3aHLe+iVvJ/VcxyOsRlKrUlhNZPFaqptthIzhNPfUGIoUUngxcrUkRU
         Cb7w==
X-Gm-Message-State: AOAM533ZZivBPs5OnOlhX6K6WnVKmGqXoVfJqgfJrE0yS+7pMdw3iTFz
        Bjy9SbWsj5ltcK2umVNmU5S7aw==
X-Google-Smtp-Source: ABdhPJzpw4hOd5QOy5LX+F5XNYCN3BpbdALQEeniFIPQEU07Dr5VpM/Wwp+pQNuQicgRtYfXDVz0Tw==
X-Received: by 2002:ac8:7b4c:: with SMTP id m12mr1627606qtu.97.1590542054136;
        Tue, 26 May 2020 18:14:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o144sm1075774qke.126.2020.05.26.18.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 18:14:13 -0700 (PDT)
Date:   Tue, 26 May 2020 21:14:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200527011413.GD149611@google.com>
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
 <20200526182744.GA3722128@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526182744.GA3722128@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:27:44PM +0200, Ingo Molnar wrote:
[...]
> ./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument
> of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’
> [-Wformat=] 5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */ |
> ^~~~~~
> ./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
>     9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
>       |                    ^~~~~~~~
> ./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
>   295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~~~~~
> kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |  ^~~~~~~~
> kernel/rcu/rcuperf.c:726:32: note: format string is defined here
>   726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
>       |                              ~~^
>       |                                |
>       |                                long unsigned int
>       |                              %u
> 
> 
> The reason for the warning is that both kfree_mult and sizeof() are 
> 'int' types on 32-bit kernels, while the format string expects a long.
> 
> Instead of casting the type to long or tweaking the format string, the 
> most straightforward solution is to upgrade kfree_mult to a long. 
> Since this depends on CONFIG_RCU_PERF_TEST

Thanks for fixing it.

> BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
> to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
> mistakenly believe that it's somehow related to perf, while it isn't. =B-)

Would it be better to call it 'RCUPERF_TEST' instead of the
'RCU_PERFORMANCE_TEST' you are proposing? I feel the word 'PERFORMANCE' is
too long.  Also, 'rcuperf test' instead of the 'rcu performance test' you are
proposing.  I am Ok with doing it however you and Paul want it though, let me
know.

Paul, should I send you a renaming patch for the new performance tests as
well (which I believe should be in the -dev branch).

thanks,

 - Joel


> 
> Thanks,
> 
> 	Ingo
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
>  kernel/rcu/rcuperf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 16dd1e6b7c09..221a0a3810e4 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -88,7 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> -torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> +torture_param(long, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
