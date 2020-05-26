Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79896C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB762084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590517674;
	bh=rZAtahavtSaGWymq2e+TvSWD9uARc0aK6D7bAI8UBgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D3eJkjVfjxBT1h2MIC9pbq7GBfKOhNxTkk+yjTdE5A18bVMkwJozWNfQP2I691BU3
	 ZBjcxoNeJtJYpqs65Rh3KyEA7NxXC0+anbRtQlWn2jLdWUq8xNn69RAw/STrhoh4j5
	 UA0LXn3NjvNAFV0UeIS9NlGva8nsjA5QG2cBU99g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgEZS1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgEZS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:27:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52081C03E96D;
        Tue, 26 May 2020 11:27:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so523430wmb.4;
        Tue, 26 May 2020 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=//ycJC/8SpwdLfYq3Nycql5/Hbahas9UZRlYhXfm7+I=;
        b=FmMvMXFZ9hCNgIHrEYeddrdJW4YW6VbsqWyMQYttoQmKFWJ8SCeBhME+VooCIBsQr2
         +g9pyMvOVHsQEB9OiB3Api4N0qlnauYSJb/6r3U/DzuLO9ffz5dZ/thZaFo6hL+cOSCL
         IEnD8F5LPg/nzoFp7B/+N0gIXNCNRbg5+LRm6RyEtsCP4m96TlCpeQOHQSazY5bE3xfg
         sHRIhz9CWMpztqjaNnN9q8NvCzeAv5zT+HepIhPmHX8NNpq8/csOr3Ag57Vns2oY9OCC
         VuGk1Ukp/v3qFWyWqxSHug5xdqH/nn5DpZrOZGhl3GuK0ANQJ11jx40SVaQtGELvvtwc
         kxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=//ycJC/8SpwdLfYq3Nycql5/Hbahas9UZRlYhXfm7+I=;
        b=TjOi3MnfqeuEbsB7qSRNDr5HGiOGhTZ91+ScATCKn0+t9DhWtJc3RCvDbZ3mbKDHqS
         ZGmbTIpscsBehURHZ7uawuke+KS57ON5X2vlm7r6pjoAxoS24FdlpSTVakJufc1Dz+gx
         B5gLR+SqL/rw9VeuSgDqL/E8/I5ZPNg6nxa/I1ey1Z8hD1tl3uZz5sK4d3R126OzOv0i
         yWI/8DuSFKsgwp4GVmTj1k12YmwVBm2PBCSttz/wmSBJ3qqVuZZBlG3HsBgUAWdrLhGt
         cEcPDDGKTR+V/CRmYTOAVVe2mH/5JUPGbgCjuNqQrN7ZatXxJD7zE+NWYjWkdhkJLCu6
         Yz8Q==
X-Gm-Message-State: AOAM531Dpo3mzGRWVX4D1phG7ojjVlckDqOkcxL/povxei+odw93C1/k
        33SQQVTNsUV+dGuOtQBJquzH+VCV
X-Google-Smtp-Source: ABdhPJysQ9RQd+E56OjTReQIQ7hDeBXSTipHByGD5ZQ9wUJsdjPfti02+7IWEAHJZ/3/NZ+UtM/bsg==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr451742wmc.1.1590517666702;
        Tue, 26 May 2020 11:27:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o20sm594010wra.29.2020.05.26.11.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:27:46 -0700 (PDT)
Date:   Tue, 26 May 2020 20:27:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH] rcu/performance: Fix kfree_perf_init() build warning on
 32-bit kernels
Message-ID: <20200526182744.GA3722128@gmail.com>
References: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158923078019.390.12609597570329519463.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Joel Fernandes (Google) <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the core/rcu branch of tip:
> 
> Commit-ID:     f87dc808009ac86c790031627698ef1a34c31e25
> Gitweb:        https://git.kernel.org/tip/f87dc808009ac86c790031627698ef1a34c31e25
> Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
> AuthorDate:    Mon, 16 Mar 2020 12:32:26 -04:00
> Committer:     Paul E. McKenney <paulmck@kernel.org>
> CommitterDate: Mon, 27 Apr 2020 11:02:50 -07:00
> 
> rcuperf: Add ability to increase object allocation size
> 
> This allows us to increase memory pressure dynamically using a new
> rcuperf boot command line parameter called 'rcumult'.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/rcuperf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index a4a8d09..16dd1e6 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -88,6 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> +torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *perf_type = "rcu";
>  module_param(perf_type, charp, 0444);
> @@ -635,7 +636,7 @@ kfree_perf_thread(void *arg)
>  		}
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> +			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> @@ -722,6 +723,8 @@ kfree_perf_init(void)
>  		schedule_timeout_uninterruptible(1);
>  	}
>  
> +	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));

There's a new build warning on certain 32-bit kernel builds due to 
this commit:

In file included from ./include/linux/printk.h:7,
                 from ./include/linux/kernel.h:15,
                 from kernel/rcu/rcuperf.c:13:
kernel/rcu/rcuperf.c: In function ‘kfree_perf_init’:
./include/linux/kern_levels.h:5:18: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
    5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
      |                  ^~~~~~
./include/linux/kern_levels.h:9:20: note: in expansion of macro ‘KERN_SOH’
    9 | #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
      |                    ^~~~~~~~
./include/linux/printk.h:295:9: note: in expansion of macro ‘KERN_ALERT’
  295 |  printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~~~~~
kernel/rcu/rcuperf.c:726:2: note: in expansion of macro ‘pr_alert’
  726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
      |  ^~~~~~~~
kernel/rcu/rcuperf.c:726:32: note: format string is defined here
  726 |  pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
      |                              ~~^
      |                                |
      |                                long unsigned int
      |                              %u


The reason for the warning is that both kfree_mult and sizeof() are 
'int' types on 32-bit kernels, while the format string expects a long.

Instead of casting the type to long or tweaking the format string, the 
most straightforward solution is to upgrade kfree_mult to a long. 
Since this depends on CONFIG_RCU_PERF_TEST

BTW., could we please also rename this code from 'PERF_TEST'/'perf test'
to 'PERFORMANCE_TEST'/'performance test'? At first glance I always
mistakenly believe that it's somehow related to perf, while it isn't. =B-)

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 kernel/rcu/rcuperf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6b7c09..221a0a3810e4 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -88,7 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
-torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(long, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
