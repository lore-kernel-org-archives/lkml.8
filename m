Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CAC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DA120731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruaS4A+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgELVt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:49:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EFDC061A0C;
        Tue, 12 May 2020 14:49:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so1088905pjb.0;
        Tue, 12 May 2020 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zZSy0O//Upsqif3OjQcNKePgwmS9VaOsCq3tFE1zh0=;
        b=ruaS4A+xPQddTg7hvxZNZHNnuTfxvC97+N4Ld2I5jHLfYld5JhcOU2AYNV/yNT6DF6
         bECYAFrplgXfoCxCC/9i6pEK+xssRN0g63+uZ02dZn6C7IN+/l6OQPMSNpLQAh7P1iQN
         4l82E8Z/vEb8iNBVrQrnSpCmMMNr5xC45CHssxiE4WBPFbkEELULnPjl8OrkvUGXcjs4
         d+q0h28Q8Ui0JC1Pgz6gaWRmc6d7+TlwpYeO58u5hcij8LS21a2ivLa/J01eKr5LJqjT
         bZ69pKi5vpvAWtX1BGFoUoA6y+U+OV3mDdbLbTxb8xySXYl9ByPujqfBHbRGcmwAtn6m
         glvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zZSy0O//Upsqif3OjQcNKePgwmS9VaOsCq3tFE1zh0=;
        b=oAXlPNjAIrDUY3cKljttrNkqhXn7mmjZt96JQp9M9VNoFGk5BkyHuNFTqGARCx+riA
         ggVKSS9cQNozUOyuMTJQa81+ikQIFPslBSoec5AKF31uwNNwIthHP5KNdweB8kFd4e8a
         MgVqt9alZqK2CCT/7S6Z8HPAsTQ+XyG1FU/Y5DWVOswfQHZWbazY+NdMswMPbEpGY3i4
         rWU3lsczQ98NT63LClDG3U3ZNXl9fnX8H/oKHED0YCp31u7ZGhYOhY1NgJeLERL88zoL
         KP3NNbhb7NcaHNnM92R94MVhqPbn9Znyybq+ohCf2Fw2s850rOZZrHzn8gSEhwZ+Gp+i
         R5NA==
X-Gm-Message-State: AGi0PuZ4Yn1+m2S/1fRJoQaylesyNSo5p4rT6/waYKHeM0vRuwAcUxie
        OTcbMMa5CuEMSP20lZZ0GJ3pH3yg
X-Google-Smtp-Source: APiQypK1NxPUKU02NSvgu1EEmhvi3YoIGlD4qAFOVwep6DI1QfKWwNOjNdiyy7XNUF+ND+uC32uUXg==
X-Received: by 2002:a17:90a:748:: with SMTP id s8mr29699299pje.221.1589320197246;
        Tue, 12 May 2020 14:49:57 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f70sm12804644pfa.17.2020.05.12.14.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:49:56 -0700 (PDT)
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <20200512214342.GA89170@google.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <d1809f12-77a3-65e4-7af2-bdd87c48ada7@gmail.com>
Date:   Wed, 13 May 2020 06:49:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512214342.GA89170@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 17:43:42 -0400, Joel Fernandes wrote:
> On Tue, May 12, 2020 at 09:30:22AM -0700, Paul E. McKenney wrote:
>> On Tue, May 12, 2020 at 11:41:01AM -0400, Joel Fernandes wrote:
>>> On Tue, May 12, 2020 at 11:07 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>>>>
>>>> From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> Date: Mon, 11 May 2020 22:06:46 -0400
>>>> Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
>>>>
>>>> Since this test returned to tools/memory-model/, make sure that it is
>>>> at least referenced from Documentation/litmus-tests/'s README.
>>>>
>>>> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
>>>> [Alan: grammar nit]
>>>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>>>> ---
>>>> I said in the earlier message:
>>>>
>>>>> The explanation under tools/memory-model/litmus-tests/README also need the same
>>>>> rewording.
>>>>
>>>> , but obviously I was confused. It is good as is.
>>>>
>>>> This is on top of my earlier patch series.
>>>>
>>>> Joel, Alan, does this work with you?
>>>
>>> Yes, thanks a lot for doing it. Paul are you Ok with it too?
>>
>> Looks good to me!
>>
>> Could one of you please send a patch series and instructions, which I
>> -think- will be of the form:
>>
>> o	Revert a5cca3485d92 ("Documentation: LKMM: Move
>> 	MP+onceassign+derefonce to new litmus-tests/rcu/")
>>
>> o	Apply a series of patches.
> 
> Rebased Akira's 3 and my 1 on top of your /dev branch with the ordering done as above:

Oh, I missed the reordering part in my PATCH RESEND series.

Paul, it's up to you which you pull/apply.

        Thanks, Akira

> 
> Could you pull?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch for-paul-dev)
> 
> Thanks!
> 
>  - Joel
> 
