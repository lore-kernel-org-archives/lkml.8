Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB96DC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C937520747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlrptjpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgELLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:50:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F3C061A0C;
        Tue, 12 May 2020 04:50:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u5so3434365pgn.5;
        Tue, 12 May 2020 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RP7CCnXHNiRCfxD2kc6X+bKl9+1uJPemqeYA2xdtdEM=;
        b=qlrptjpYFGUnFosmbt4X6bjOqr8j3qwdi5pvab62DJFe+J1t+whMNOf4b8+9b8go49
         +3KFA20IbfWKUdgNqhJXCwWKMaRD88v07tmMmP4bbYcEPkOYM8xnfHcSHZC3dijkUjOz
         uU5Egmq+nj7lcFd9xSvjP9nLAkg5TU/am4dxyOQWWDODiNJl99q34tAQy6kWChnzoTO/
         L0aMNBBacFlCMKd+3SLE/MB9RRqFM0WQyWQ5SBJ1hiRHOo+gLQeoGJIcbtjZxHb4A5uT
         9gsytY07c3CTR5TLyIEDtz2qxIkT+ONz2J5fm+VbKOURKhTFr0z+ujcxWTZxOjjNiPb5
         thmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RP7CCnXHNiRCfxD2kc6X+bKl9+1uJPemqeYA2xdtdEM=;
        b=KB86xGGyTt6m8cRadZeFJT6TcrA1S8kndUWzOxu9dt2mNAgrzHMRM/FUDkdfYwajyS
         UguG7DjQKad8DSsvQV0MCS/a2rL/CdDy9WCXlen7Ut+jpPZkag7JcG5ccI9MyZJPjyiC
         ypVHAF1VtXpThHU0N7ecWdtetuUaTzWUi1Op0Sq5jUUwN1Ua3aaLyf3fYSIAFvnntxXO
         qqOWUJntO/I4m7llAdzbP8ZOagcU5CaW+UU/VvBW2SKo5tLQJLqaJVdARyU9WzGirZcb
         DLPaOXZrhFIuFbty9KDbu+LjWOGOW4MUki+AX8VdhFcjHn/117A7h/fcIiJrHxpCQnWE
         CbPg==
X-Gm-Message-State: AOAM531MRRmvuo2qP7fGlKSUoQGLyB9jaObPQpEPckmljV8CENbYuO4J
        WYAOiroWgN+Lrx8lmLuODE8=
X-Google-Smtp-Source: ABdhPJzQwS5oYy3waWX7FZdaEKOilqriIDEW9GlWK/d7LM953tzCjZ3FZfPuwwk5/lhEuoQroYxZiw==
X-Received: by 2002:a63:f015:: with SMTP id k21mr7400113pgh.248.1589284251171;
        Tue, 12 May 2020 04:50:51 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d35sm10304657pgd.29.2020.05.12.04.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 04:50:50 -0700 (PDT)
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        vpillai@digitalocean.com, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <20200511173348.GX2869@paulmck-ThinkPad-P72>
 <20200512021309.GA197229@google.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <bff04d71-1666-a5a8-54bf-d0c9f8737b47@gmail.com>
Date:   Tue, 12 May 2020 20:50:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512021309.GA197229@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 22:13:09 -0400, Joel Fernandes wrote:
> On Mon, May 11, 2020 at 10:33:48AM -0700, Paul E. McKenney wrote:
>> On Sun, May 10, 2020 at 04:21:02PM +0900, Akira Yokosawa wrote:
>>> On Sat, 9 May 2020 12:43:30 +0900, Akira Yokosawa wrote:
>>>> Hi Joel,
>>>>
>>>> Sorry for the late response but I've noticed some glitches.
>>>>  
>>>> On Sun, 22 Mar 2020 21:57:32 -0400, Joel Fernandes (Google) wrote:
>>>>> Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
>>>>> directory.
>>>>
>>>> MP+onceassign+derefonce.litmus is called out in
>>>> tools/memory-model/Documentation/recipes.txt as a representative example
>>>> of RCU related litmus test.
>>>>
>>>> So I think it should be kept under tools/memory-model/litmus-tests.
>>>>
>>>> Further RCU-related litmus tests can be added under Documentation/litmus-tests/.
>>>>
>>>> IIUC, this change is not picked up by tip tree yet. So we have time to respin
>>>> the series targeting v5.9.
>>>>
>>>>>
>>>>> More RCU-related litmus tests would be added here.
>>>>>
>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>
>>>>> ---
>>>>> Cc: vpillai@digitalocean.com
>>>>>
>>>>>  Documentation/litmus-tests/README                        | 9 +++++++++
>>>>
>>>> Please note that later patches to add atomic litmus tests under
>>>> Documentation/litmus-tests/ by Boqun put README as
>>>> Documentation/litums-tests/atomic/README.
>>>>
>>>> This patch's location of RCU's README as Documentation/litmus-tests/README
>>>> looks asymmetric to me.
>>>>
>>>> I'm OK with either merging atomic's README with the top-level one or
>>>> moving RCU's README to under Documentation/litmus-tests/rcu.
>>>>
>>>> Joel, Boqum, can you sort out the location of README?
>>>
>>> So something like this?
>>>
>>> Patch 1/3 is an independent typo fix in recipes.txt.
>>> Patch 2/3 reverts the MP+onceassign+derefonce relocation.
>>> Patch 3/3 merges atomic's README into the top-level one.
>>>
>>> This is relative to -rcu's lkmm branch.
>>>
>>> Thoughts?
>>
>> Looks plausible to me, and thank you for reviewing this.
>>
>> Joel, thoughts?
> 
> Sorry for the delays (OSPM conference in progress). I'm Ok with moving it
> back to tools/memory-model/.
> 
> I think on top of this patch, I'd like to add a reference to the to the
> litmus test in tools/memory-model/ from Documentation/rcu/.

Sounds reasonable to me. But for most people, it never changes its location.
Please find inline comments below.

> 
> Just to mention my rationale for Documentation/litmus-tests/rcu/, I was
> basically looking for a central place for RCU related litmus tests in the
> kernel sources and the idea of this new directory came up.
> 
> For Akira's series,
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you!

> 
> And could we add the following patch on top of Akira's series so we still
> maintain a reference to the moved RCU test?> 
> ---8<-----------------------
> 
> From 52fdb57551cc769d8bd690f4f2b22de36ddece99 Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Mon, 11 May 2020 22:06:46 -0400
> Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
>  test
> 
> Since this test was moved to tools/memory-model/, make sure that it is
> at least referenced from Documentation/litmus-tests/'s README.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/litmus-tests/README | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index ac0b270b456c1..53f09e74734a4 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -11,7 +11,6 @@ tools/memory-model/README.
>  
>  atomic (/atomic derectory)
>  --------------------------
> -
>  Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>      Test that an atomic RMW followed by a smp_mb__after_atomic() is
>      stronger than a normal acquire: both the read and write parts of
> @@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  
>  RCU (/rcu directory)
>  --------------------
> -

I loosely followed the convention of ReST documents in putting these empty
lines.  But I don't mind if they are removed.

>  RCU+sync+read.litmus
>  RCU+sync+free.litmus
>      Both the above litmus tests demonstrate the RCU grace period guarantee
>      that an RCU read-side critical section can never span a grace period.
> +
> +MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)

As I said above, for those who don't follow developments in the lkmm branch, 
MP+onceassign+derefonce.litmus stays in tools/memory-model/litmus-tests/.
So,

+MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)

looks better to me.

        Thanks, Akira

> +   Demonstrates that rcu_assign_pointer() and rcu_dereference() to
> +   ensure that an RCU reader will not see pre-initialization garbage.
> 
