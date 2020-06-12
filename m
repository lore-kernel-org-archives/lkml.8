Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E285FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B637220792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVkI+V3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:32:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C53C03E96F;
        Fri, 12 Jun 2020 04:32:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so3996723pgo.9;
        Fri, 12 Jun 2020 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lgE32Ou0V39R4GTxZ5rk8NdY6XmTkz6GrQZdcG8x7g=;
        b=RVkI+V3mvBlLHDAS1i/drw5fhqljNH8F4sM0b2t2jGK1cU9LFc7kvWBEzT21tbyedp
         WaTeoUzDHrOQjHMgr+oVmRDbhFXoyTfluHAR0spRY2kRJhoo+M9H2pqO+gnMe2FG5rOl
         OLGHgg9LeXUx7ibdQirfQBbRSQo05Vmp9ki0ewZRTnrCk2OYU3ce7tWFBEQqEdOM7QW0
         zRrWq6xUxMNNj/DEYaJKYaHdjniT/wYqgRjaErO+htz028ne2XN0gSbdaj068JoS4AOE
         1lcwUEmcd+SPMTAfdiqZkxeVPFapsbE8bw6poQ9dFYXG/tHDhCNRyuG6vz4nW1wgAfoP
         10aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0lgE32Ou0V39R4GTxZ5rk8NdY6XmTkz6GrQZdcG8x7g=;
        b=QECEckMEcxw5+xEa2M6jzHYKZ37dFqiIwUcskTDB2TkA4Wwsd/NY7rqyOo31cOikiJ
         bVlZzvFZ9zD17dDmu+nBm1YBPoG7HilqYT5Bw73C0EVOyaVB8KhTc7+Uhcp6d0sl3Q1F
         yVmA7C7M1Hq2kGKciewHN1H149TwyWwABGnXgHVi3HOxIR4lSPYdqCRaCKcv5XLfJgD5
         vS6utF7mEBdbOZ55AdaOwKgnjw7LYJ7JyeDWBzvH21/PgMwBVEFNq+4m+MGsxTGWTb4t
         +WqQmcLSPrZSqPAk8VbwhDiJqEHHrHs86uvW6fX4dqDTRgZOZnToChXZpTnGbG0WJNWV
         LaAA==
X-Gm-Message-State: AOAM532eYeRH0zmAoHwy9WTUg1mBpeKGXSVJ58CpMSzQwBH6UAuUk8z/
        KMNfLLaB4YsnLQUq7fY/h+4=
X-Google-Smtp-Source: ABdhPJyml9rJjczDyYfvCjWWUSwV/e5wIDm9KSchWpwfBoH9jucVWeZxnt0opoOeSzMWKgI4VKlwKw==
X-Received: by 2002:a63:f413:: with SMTP id g19mr9499214pgi.200.1591961533176;
        Fri, 12 Jun 2020 04:32:13 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x11sm6208541pfq.169.2020.06.12.04.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:32:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 12 Jun 2020 20:32:09 +0900
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [v2 PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200612113209.GA1204@jagdpanzerIV.localdomain>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200612043634.GA30181@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612043634.GA30181@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/12 14:36), Herbert Xu wrote:
> As it stands if you include printk.h by itself it will fail to
> compile because it requires definitions from ratelimit.h.  However,
> simply including ratelimit.h from printk.h does not work due to
> inclusion loops involving sched.h and kernel.h.
> 
> This patch solves this by moving bits from ratelimit.h into a new
> header file which can then be included by printk.h without any
> worries about header loops.
> 
> The build bot then revealed some intriguing failures arising out
> of this patch.  On s390 there is an inclusion loop with asm/bug.h
> and linux/kernel.h that triggers a compile failure, because kernel.h
> will cause asm-generic/bug.h to be included before s390's own
> asm/bug.h has finished processing.  This has been fixed by not
> including kernel.h in arch/s390/include/asm/bug.h.
> 
> A related failure was seen on powerpc where asm/bug.h leads to
> the inclusion of linux/kernel.h via asm-generic/bug.h which then
> prematurely tries to use the very macros defined in asm/bug.h.
> The particular inclusion path which led to this involves lockdep.h.
> I have fixed this moving the type definitions lockdep.h into the
> new lockdep_types.h.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
