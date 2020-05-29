Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B812206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2PLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:10:59 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDBC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:10:59 -0700 (PDT)
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04TFAwMr030856
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:10:58 -0400
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04TFArar024307
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:10:58 -0400
Received: by mail-qv1-f70.google.com with SMTP id l17so2563936qvv.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=D/1dZPUW5V+4QMH72iao93KJ6H84MZRpWQ8sS7tddTE=;
        b=KCQCLrmplhhA8bK8vsr0vcODpN2opbn3OS9InIjJs+/NT9Biy6LkHST/9H2qRmrm5L
         oiaXldyaANzJQoxYyYU53u1t6GW622nksXm7zj1Ad9+J5fWIDvoJWtyyapKyj9jOsVhS
         baBUATAyVOEWZcNgdjnJDzmXEyZfZQzDQz0j7CIOduJ0FA+1MSI3ZH4l1XAqRxzrOX+V
         9DQhD56cA+qN1m0OE1/BamY0FIVNQW/dG+SKMPxiBzITZ7oZYtsEk2WAe1SrTXDt15zN
         CIcC17tKwMmQjhjgZHURiznqk//FMlYlPrXo+zrkGwrpFNLRBP17MGl7h7ypkD3of93q
         ot9Q==
X-Gm-Message-State: AOAM5309bLwW2+IY42l+tXOXF0USYkZg1dUyJdYf4ZXiTGPkdxvd8qu5
        TwwS80gywudFyG90lUjs5M2+l1vjrMzoZ2b8H3gBorV216DfyCTCc5ZBPKlUYR2ydgtBUIMqEr/
        vZprwfb3BRFAE9f+19JK+KOFizY5ifn67gQI=
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr7731827qvb.216.1590765047884;
        Fri, 29 May 2020 08:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKzwZold1/HF+z5P6dRY/Hd3fUyv9/lUIa4HDr+Zru4bgcDlpbt078Uy6SdgW3gnLhDVLA0w==
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr7731788qvb.216.1590765047490;
        Fri, 29 May 2020 08:10:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id e1sm8019951qto.51.2020.05.29.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:10:45 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
In-Reply-To: <20200526161908.129371594@infradead.org>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590765044_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 11:10:44 -0400
Message-ID: <579691.1590765044@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590765044_16657P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 May 2020 18:11:04 +0200, Peter Zijlstra said:
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.

>  kernel/smp.c          |   47 ++++++++++++++++++++++++++++++++++++++++-------

> --- a/kernel/smp.c
> +++ b/kernel/smp.c

> @@ -659,6 +685,13 @@ void __init smp_init(void)
>  	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
>  		     offsetof(struct __call_single_data, flags));
>
> +	/*
> +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> +	 * for task_struct to be on the @call_single_queue.
> +	 */
> +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> +
>  	idle_threads_init();
>  	cpuhp_threads_init();

This blows up on a 32-bit ARM allmodconfig:

  CC      kernel/smp.o
kernel/smp.c:319:6: warning: no previous prototype for 'flush_smp_call_function_from_idle' [-Wmissing-prototypes]
 void flush_smp_call_function_from_idle(void)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/arm/include/asm/atomic.h:11,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/llist.h:51,
                 from ./include/linux/irq_work.h:5,
                 from kernel/smp.c:10:
kernel/smp.c: In function 'smp_init':
./include/linux/compiler.h:392:38: error: call to '__compiletime_assert_152' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) != offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist)
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
kernel/smp.c:689:2: note: in expansion of macro 'BUILD_BUG_ON'
  BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
  ^~~~~~~~~~~~

--==_Exmh_1590765044_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXtEl9AdmEQWDXROgAQJk7g/9GzJmVBQbhYDA0N9BADiK5ZA49RVxRNYN
yrcYB7uZ0BLjFkCJ/viYZqys7yG+VyTOAPH2DYJaizlx9wGvCj0eEmuJ3H8aBizo
ZthJvyh/qaqGbJ4svQg+MOj61l858htgubtLm+0XfQ4mYVwOITwmoCKMjTJ9wcqo
Y86Y9cEyxg87XcO7TS3i3CdxDCSERrh68wIcwjbR7Hie+QTsydxao40zw6kClH/9
c2v+cu/lDSxZdgg+V6OxtUrVX2KjYmGazc3Cbtg8ZgTaPdYnevfyHMmWsZCR7jfo
NAO4zUKBLFUxnzHil/hQKbNSYXQVdGXDSl6XiQ940lV8WJI8ESowdjSqDj9oVWd6
0WX+VyKo+Y1SqY1NDvE2qKUWLj1WQ8E7FFjRv82/KIltWhYxvzTns9xX9eGwn94F
mvHzq69j0tdLoyxshP67/3mJEmrwew86YIKDpvxHpT8yk3PXE/4ekkuPIf7YD7Ic
O3uCRS/217nv1Zqv6wTPVyHj1ojCeJ3KsNVa3x3PpRG8gLaXj66Al5U7IN+vzIuL
woSIK3Zb/JetA9MEMviim9+ld0dLgeC4i1NyStlZyk13R5tT8GlGSV7csIgJnXcC
08hs3kxVlij7FqOdR3LJgN1Md/brTzD4UMtWnHR7mQG5FUxuQqXFGxRcT74CT0Ns
nXjdNFZ3Al0=
=hd1G
-----END PGP SIGNATURE-----

--==_Exmh_1590765044_16657P--
