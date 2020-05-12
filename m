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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31008C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C828206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLmCx0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgELOj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgELOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:39:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E8C061A0C;
        Tue, 12 May 2020 07:39:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so5476586plr.0;
        Tue, 12 May 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/ffNZH2j8wRUIyx9mV+rSX8Z5whOOVlhkgSxFYbJXI=;
        b=TKLmCx0Z3nSct1EOvFmsKQeoDh1jNhdmWpIph9rYq+t1ulWmHFqigYOIS8eYuQ+Ydo
         koI5YeaTePI5jiL3R4Q68kwWZN95KmTq9NPzZAvvGDmsfsm4Goy/EgblS9vZGYjTe+WW
         O04n0Oh+7Bi+isekZwHrf74PdFlqtL39q3L+M+HGY2IbBzMCSBUMlvglzBXYgp7OuHq0
         qM9zaSCwHJBBTE/yF/yjFDAISM26wvaXpxnDS3WK90kV0gKDdDQmHFZscc4F8Ew7U4xy
         ZGSo5YHdQPr9aK5jGykK54dqoE6qGk1Rw4Opl3lnkX5u0IyEm2tyNPXQDD85C2wlBwGI
         SwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/ffNZH2j8wRUIyx9mV+rSX8Z5whOOVlhkgSxFYbJXI=;
        b=jKTVs/NqihfdjaDiPd+7cWR2x2ZJ+0PlKvx8JcDAjW0shpQc7TYakUij6DwvNzpgLv
         xFHx1dCTqWBO0zaJDVEmAxC4qK2IaaCpYp3JavDtZMlLXUgsZajeDsAAo220nEn/7PTS
         WV1hmnJT3hP8qBsoHnPsMrVZfBpywIDn3becTNGe2gLxZVnJWde9t/Qq0OW2ZYwKcUHo
         i4Ce5XyYDk4gxLKugKOCHS2v8cZB6z8uuDEEHilN8yHZm2E+X3HwLshh0ZFpXqKRFFvb
         tzlD9M9rfMODKXBmo2D3rywNmY6S9u48QVHB/W3u3de6OGQMq8zaSE36ygJ2eRP9TutB
         NbjA==
X-Gm-Message-State: AGi0Pua282HaO7RGr24VKECDf/shNCarFLvVERR0+R9Hhc9bWFWMLGAt
        jDpW84NdMJF/+4UmLHf/5rI=
X-Google-Smtp-Source: APiQypKxegfwSSaRnWsTzw6sOpVrUsSqsFX0oyju3ae91ekOvIu13KHd5uYSHZj6P1e9d5GyHTZaiQ==
X-Received: by 2002:a17:902:261:: with SMTP id 88mr19849899plc.308.1589294364981;
        Tue, 12 May 2020 07:39:24 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m63sm12573686pfb.101.2020.05.12.07.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 07:39:24 -0700 (PDT)
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
To:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
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
 <bff04d71-1666-a5a8-54bf-d0c9f8737b47@gmail.com>
 <20200512121936.GA228684@google.com>
 <20200512141944.GC2869@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <2ad1db9a-cd47-51a0-4bbf-5e6b64b73cbd@gmail.com>
Date:   Tue, 12 May 2020 23:39:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512141944.GC2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 07:19:44 -0700, Paul E. McKenney wrote:
> On Tue, May 12, 2020 at 08:19:36AM -0400, Joel Fernandes wrote:
>> On Tue, May 12, 2020 at 08:50:45PM +0900, Akira Yokosawa wrote:
>> [...]
>>>> I think on top of this patch, I'd like to add a reference to the to the
>>>> litmus test in tools/memory-model/ from Documentation/rcu/.
>>>
>>> Sounds reasonable to me. But for most people, it never changes its location.
>>> Please find inline comments below.
>>>
>>>>
>>>> Just to mention my rationale for Documentation/litmus-tests/rcu/, I was
>>>> basically looking for a central place for RCU related litmus tests in the
>>>> kernel sources and the idea of this new directory came up.
>>>>
>>>> For Akira's series,
>>>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>
>>> Thank you!
>>>
>>>>
>>>> And could we add the following patch on top of Akira's series so we still
>>>> maintain a reference to the moved RCU test?> 
>>>> ---8<-----------------------
>>>>
>>>> From 52fdb57551cc769d8bd690f4f2b22de36ddece99 Mon Sep 17 00:00:00 2001
>>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>>> Date: Mon, 11 May 2020 22:06:46 -0400
>>>> Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
>>>>  test
>>>>
>>>> Since this test was moved to tools/memory-model/, make sure that it is
>>>> at least referenced from Documentation/litmus-tests/'s README.
>>>>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> ---
>>>>  Documentation/litmus-tests/README | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
>>>> index ac0b270b456c1..53f09e74734a4 100644
>>>> --- a/Documentation/litmus-tests/README
>>>> +++ b/Documentation/litmus-tests/README
>>>> @@ -11,7 +11,6 @@ tools/memory-model/README.
>>>>  
>>>>  atomic (/atomic derectory)
>>>>  --------------------------
>>>> -
>>>>  Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>>>>      Test that an atomic RMW followed by a smp_mb__after_atomic() is
>>>>      stronger than a normal acquire: both the read and write parts of
>>>> @@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>>>>  
>>>>  RCU (/rcu directory)
>>>>  --------------------
>>>> -
>>>
>>> I loosely followed the convention of ReST documents in putting these empty
>>> lines.  But I don't mind if they are removed.
>>>
>>>>  RCU+sync+read.litmus
>>>>  RCU+sync+free.litmus
>>>>      Both the above litmus tests demonstrate the RCU grace period guarantee
>>>>      that an RCU read-side critical section can never span a grace period.
>>>> +
>>>> +MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)
>>>
>>> As I said above, for those who don't follow developments in the lkmm branch, 
>>> MP+onceassign+derefonce.litmus stays in tools/memory-model/litmus-tests/.
>>> So,
>>>
>>> +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
>>>
>>> looks better to me.
>>
>> Yes it stays under tools/.. but is referenced here. Sounds like you agree and
>> the only change from my follow-up patch that you want is to change "moved to"
>> to "under".
>>
>> If so, Paul do you mind applying my patch and fixing this up? Or do you want
>> to apply Akira's 3-patch series first and then have me send you another one
>> on top?
> 
> Let's get something that you, Akira, and Alan are good with, then I will
> apply that, either on top of or in place of the current commits (just
> tell me which).

OK.
I'm submitting a patch [4/3] with Alan's suggested-by and Joel's and my
co-developed-by tags.
The explanation under tools/memory-model/litmus-tests/README also need the same
rewording.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
