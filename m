Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C12CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586032065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCsx/elz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgENWDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgENWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:03:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D0C061A0C;
        Thu, 14 May 2020 15:03:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so65304pjb.0;
        Thu, 14 May 2020 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmtQhKFdNrlpZsMj2XOzORk3musPwzUfAsf1Y+1YzwU=;
        b=aCsx/elz0xFYJrJT8FXPE/2q/TDolncdxRulXfnVfwv4g8Cyt/6oJVFavIDFtT+MUz
         8HJ1goV6cc/+YoUY30opQ1mWlsnhAVF9x2GgR+2GkgqVgJzx01Xoz+xrXlMbLtIGGO1w
         Tj6ZCnR+RxF11Zd3I3dEWqNYQe4Q42eatMvHZDtqrYhDrD9ZlPDXgXSXQfKiXmCUBtIe
         6xVQj8Le7LkRe6uJui4MN7XWQF/3nXvTYQRSqDZnyMACdel1rmAXagvMWXlU5+4CBRMr
         tnVId00YQ7xncXL8hFiGm4qasKJOm5I8CBhASY85Jfl3Fu8pjr8iG5Z/s/ZAKwM9+pHX
         OMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmtQhKFdNrlpZsMj2XOzORk3musPwzUfAsf1Y+1YzwU=;
        b=Zxl2StU+wmiKXO/zY2nOlHSNZetvoLBUfmYQIq9isJmPrTxclnZi/m+35oCvvK9PLI
         JK08fmXeJFLiACY7+5jtyFLT6FhuxBZwHuHXe268Ff2XwNJddzN81cTBeF3F+5jr8buC
         Es/g6pwFmlD0gCSGvI2ZbDdPyA+TVRhRrApKz7wDeVJ48L7+5o3PFQJer2cI5gNJ7TtX
         zHPndraVSji9QHA6iDMiGhg4Cc4u4Hquj9km29VvSlQ2xpEMrJ7WzbnQspsCGsax1Cw1
         UNUYv+zxuoye7COh7o+10jEznOCN1vgC19NTkQHANNKertzY2+0BPyef201i5Rwr++KC
         oVig==
X-Gm-Message-State: AOAM531Iufqe/TQDDyMV5z1C3OpXlXkL3lXR3Pw9cPLqi9syxKd/DL1O
        7sSmP8DLst275UA0kovmE0g=
X-Google-Smtp-Source: ABdhPJxTstBaCTGSAD8RrbquGtwIOedd1pFEJ3boxmLflSCP4LbenTz0MXDTVQUi8Ligd/rT9a3B4g==
X-Received: by 2002:a17:90a:a591:: with SMTP id b17mr120725pjq.90.1589493818899;
        Thu, 14 May 2020 15:03:38 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id nm6sm31968pjb.34.2020.05.14.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 15:03:38 -0700 (PDT)
Subject: Re: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's
 README into top-level one
To:     paulmck@kernel.org, Boqun Feng <boqun.feng@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
 <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
 <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200514171656.GR2869@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0ded5099-fe59-914a-d0dd-999cc334ff0a@gmail.com>
Date:   Fri, 15 May 2020 07:03:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514171656.GR2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 10:16:56 -0700, Paul E. McKenney wrote:
> On Thu, May 14, 2020 at 08:46:18AM +0800, Boqun Feng wrote:
>> On Wed, May 13, 2020 at 06:39:03AM +0900, Akira Yokosawa wrote:
>>> From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
>>> From: Akira Yokosawa <akiyks@gmail.com>
>>> Date: Sun, 10 May 2020 15:12:57 +0900
>>> Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one
>>>
>>> Where Documentation/litmus-tests/README lists RCU litmus tests,
>>> Documentation/litmus-tests/atomic/README lists atomic litmus tests.
>>> For symmetry, merge the latter into former, with some context
>>> adjustment in the introduction.
>>>
>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>>> Acked-by: Andrea Parri <parri.andrea@gmail.com>
>>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>>
>> Thanks!
> 
> Applied, and thank you all!
> 
> I rebased, cancelling the revert with the original, resulting in an
> updated lkmm branch on -rcu.  There was one minor conflict, so could
> one of you please check to make sure that I resolved things appropriately?

One thing I noticed.

Commit b2998782ded4 ("Documentation/litmus-tests: Clarify about the RCU
pre-initialization test")'s change log says:

    Since this test returned to tools/memory-model/, make sure that it is
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    at least referenced from Documentation/litmus-tests/'s README.

Because of the rebase, this needs amendment as well as the title.

Something like

    Documentation/litumus-tests: Cite a relevant litmus test in tools/memory-model

    For ease of finding the RCU related litmus test under
    tools/memory-model/, add an entry in README.

?

    Thanks, Akira

> 
> 							Thanx, Paul
> 
>> Regards,
>> Boqun
>>
>>> ---
>>>  Documentation/litmus-tests/README        | 19 +++++++++++++++++++
>>>  Documentation/litmus-tests/atomic/README | 16 ----------------
>>>  2 files changed, 19 insertions(+), 16 deletions(-)
>>>  delete mode 100644 Documentation/litmus-tests/atomic/README
>>>
>>> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
>>> index c4307ea9f996..ac0b270b456c 100644
>>> --- a/Documentation/litmus-tests/README
>>> +++ b/Documentation/litmus-tests/README
>>> @@ -2,6 +2,25 @@
>>>  LITMUS TESTS
>>>  ============
>>>  
>>> +Each subdirectory contains litmus tests that are typical to describe the
>>> +semantics of respective kernel APIs.
>>> +For more information about how to "run" a litmus test or how to generate
>>> +a kernel test module based on a litmus test, please see
>>> +tools/memory-model/README.
>>> +
>>> +
>>> +atomic (/atomic derectory)
>>> +--------------------------
>>> +
>>> +Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>>> +    Test that an atomic RMW followed by a smp_mb__after_atomic() is
>>> +    stronger than a normal acquire: both the read and write parts of
>>> +    the RMW are ordered before the subsequential memory accesses.
>>> +
>>> +Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>>> +    Test that atomic_set() cannot break the atomicity of atomic RMWs.
>>> +
>>> +
>>>  RCU (/rcu directory)
>>>  --------------------
>>>  
>>> diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
>>> deleted file mode 100644
>>> index 714cf93816ea..000000000000
>>> --- a/Documentation/litmus-tests/atomic/README
>>> +++ /dev/null
>>> @@ -1,16 +0,0 @@
>>> -This directory contains litmus tests that are typical to describe the semantics
>>> -of our atomic APIs. For more information about how to "run" a litmus test or
>>> -how to generate a kernel test module based on a litmus test, please see
>>> -tools/memory-model/README.
>>> -
>>> -============
>>> -LITMUS TESTS
>>> -============
>>> -
>>> -Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
>>> -	Test that an atomic RMW followed by a smp_mb__after_atomic() is
>>> -	stronger than a normal acquire: both the read and write parts of
>>> -	the RMW are ordered before the subsequential memory accesses.
>>> -
>>> -Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>>> -	Test that atomic_set() cannot break the atomicity of atomic RMWs.
>>> -- 
>>> 2.17.1
>>>
>>>
