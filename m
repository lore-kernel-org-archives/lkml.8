Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F3C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD482206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jCyHDDxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgC0WSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:18:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34807 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgC0WSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:18:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id i6so12614538qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N7gy/G5yt4C6gRMEJcBMgk3+X7PiFDeDUNz7oegRXTc=;
        b=jCyHDDxnBfF/r4/912n+KwCBdRCnAbq0UBj3G8+HIjnKd+Ah5x2L8MCROJ0t5AuUPH
         uKyWVUP4P9eeMqpOMjdj3SNpUA/MFPTTunwWKdvArGIEWmn/VzLWo2z/kSo5iGXUlQ6W
         FOdWDHLQsBtkpt0t9NzbPsKeForxOVVJckPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7gy/G5yt4C6gRMEJcBMgk3+X7PiFDeDUNz7oegRXTc=;
        b=d/tdP3FNrAYmfqxBMMDyJiguGp9bJRLM+WfLTPpXOL9fQ7fOQ1xcjoHZnLMUrQFvue
         d81pGgry0NZQcik6RtyyChVNC5z5C4E44Q8sCsVF+uMtkVyIXDn5fnHUSPUJmdzszZPO
         7/F3/KEifpQyq6+MPMVWDWKeaJUfhW7ForDZo2ULRdwq1O43cL+ZhHsMXs+HNN+7QKoq
         sXPM4OFuFPKcT4eNfE4H2XgPw4cA3Z65nGKZj4ao+jCDybqYvlbHyBKez0/sp53eTKOu
         dcZWm329GpRsLkWr7Sm1JZ+Kw1y88tlQ5ZcvF3+Ts/mMJXKrRWv9PJhNrSEDmweIrZn7
         YGOA==
X-Gm-Message-State: ANhLgQ2OeK8VBenMBG2EyARNTVk6wUPesHxWFNrfrsV6hmNAg+zHyDAI
        Qt16FdfwzNjGJdCupeciU1R2gA==
X-Google-Smtp-Source: ADFU+vu0g7q3fxyouuFS26fuvwVSpjPJNDmOaZ5QUZLg7+PprW6EA4oP+A3S2YPT8MOEVRaSlw3/jw==
X-Received: by 2002:a37:992:: with SMTP id 140mr1664796qkj.36.1585347524268;
        Fri, 27 Mar 2020 15:18:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d201sm4559968qke.59.2020.03.27.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 15:18:43 -0700 (PDT)
Date:   Fri, 27 Mar 2020 18:18:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Message-ID: <20200327221843.GA226939@google.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326024022.7566-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs. And based on the previous discussion, I create a
> new directory Documentation/atomic-tests and put these litmus tests
> here.
> 
> This patchset starts the work by adding the litmus tests which are
> already used in atomic_t.txt, and also improve the atomic_t.txt to make
> it consistent with the litmus tests.
> 
> Previous version:
> v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/

For full series:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

One question I had was in the existing atomic_set() documentation, it talks
about atomic_add_unless() implementation based on locking could have issues.
It says the way to fix such cases is:

Quote:
    the typical solution is to then implement atomic_set{}() with
    atomic_xchg().

I didn't get how using atomic_xchg() fixes it. Is the assumption there that
atomic_xchg() would be implemented using locking to avoid atomic_set() having
issues? If so, we could clarify that in the document.

thanks,

 - Joel

> 
> Changes since v3:
> 
> *	Merge two patches on atomic-set litmus test into one as per
> 	Alan. (Alan, you have acked only one of the two patches, so I
> 	don't add you acked-by for the combined patch).
> 
> *	Move the atomic litmus tests into litmus-tests/atomic to align
> 	with Joel's recent patches on RCU litmus tests.
> 
> I think we still haven't reach to a conclusion for the difference of
> atomic_add_unless() in herdtools, and I'm currently reading the source
> code of herd to resovle this. This is just an updated version to resolve
> ealier comments and react on Joel's RCU litmus tests.
> 
> Regards,
> Boqun
> 
> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> 
> Boqun Feng (4):
>   tools/memory-model: Add an exception for limitations on _unless()
>     family
>   Documentation/litmus-tests: Introduce atomic directory
>   Documentation/litmus-tests/atomic: Add a test for atomic_set()
>   Documentation/litmus-tests/atomic: Add a test for
>     smp_mb__after_atomic()
> 
>  Documentation/atomic_t.txt                    | 24 +++++++-------
>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
>  Documentation/litmus-tests/atomic/README      | 16 ++++++++++
>  tools/memory-model/README                     | 10 ++++--
>  5 files changed, 91 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  create mode 100644 Documentation/litmus-tests/atomic/README
> 
> -- 
> 2.25.1
> 
