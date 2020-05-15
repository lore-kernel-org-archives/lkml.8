Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDB8207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL1cZ4Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEOPBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgEOPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:01:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2CC061A0C;
        Fri, 15 May 2020 08:01:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so1064582pfd.4;
        Fri, 15 May 2020 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2M5tR/HXRVMHSv9+8jqo0K2JDlbfL1ldOQg3nx+e71Q=;
        b=IL1cZ4TylfUYpbf6FhwxxxXhlaOaaqYdpSPrLkvDDg+FIkyOWN+F7y94QtrBjbPWFc
         Zv3A9ox5S/PlhOENSj72fGWFEzW+aVL/BoTmCLnJdltfv6OYy5gu6G7ZPPijOCDwe/+P
         NiWwn6BYw3zv+T9+ARp6vNz8EK7fULvvwS16BZ8P2StoRGkB8gpx+RRhb5L2wC70cO5G
         lB1GAo9NMZdcqJ7BiOQLNeOQK4SlEFMGozmP99BLbJcBWbcYnMibd7qmciMhBChEcd5O
         WbmAQsc6Lu13FFhuwbHN4AkELthRIq3OmaFJT8TyDdOrz7Igz3bLSHOAu/wdHynU3UoO
         4CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2M5tR/HXRVMHSv9+8jqo0K2JDlbfL1ldOQg3nx+e71Q=;
        b=VJInwOhnNoSt42J2dTei+9IB9iAbVuBDC9Lf9ftOD0QDfyl0+Fhww6N62zODrAaX9N
         2XSB+sLTScvBbgKFPJ1Vv/2wWJOdprNyFjMZqE/+lzeMnFB+uqPtUtkJ1ypMJUkvhmIi
         R2V6lLv1ab/f/z7tTcPH/kFfYB0Xh1+/6ooMTAO1aRTUAjrqjF8GSb7/i6Ml6VB1ohAz
         9/XWzEk6rCtMhhFq1ChzsRrd8Jez2HdVqPGcTlNQyvbPVKa5KQ8NP3w6rLpBZKGsSNg7
         8Rt8jkMZKSwAQIISdfm18XjKGbDKHoI/fLRRl5ZTag0X2taAuuu3dEmO5u16YNLSwKa5
         rKiw==
X-Gm-Message-State: AOAM532i/zCNO79ZmjgRVeWel3BONg7X5wV5qUSy883ZYCH6V7I7iWjn
        /q1BDof/YyhJLycIKMUuVy8=
X-Google-Smtp-Source: ABdhPJwpKxsfDK1jgJ4Px/AFu3QMhIkgxrDqiMts5MLXcyGp4/P1ATPXHwvV2c77914YnZ0v0pPqwA==
X-Received: by 2002:a62:6545:: with SMTP id z66mr4098470pfb.87.1589554907217;
        Fri, 15 May 2020 08:01:47 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q21sm1916519pgl.7.2020.05.15.08.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:01:46 -0700 (PDT)
Subject: Re: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's
 README into top-level one
To:     paulmck@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
References: <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
 <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
 <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200514171656.GR2869@paulmck-ThinkPad-P72>
 <0ded5099-fe59-914a-d0dd-999cc334ff0a@gmail.com>
 <20200514224558.GZ2869@paulmck-ThinkPad-P72>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ed5b16b9-b522-8f9b-847b-e18d6387017e@gmail.com>
Date:   Sat, 16 May 2020 00:01:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514224558.GZ2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 15:45:58 -0700, Paul E. McKenney wrote:
> On Fri, May 15, 2020 at 07:03:33AM +0900, Akira Yokosawa wrote:
>> On Thu, 14 May 2020 10:16:56 -0700, Paul E. McKenney wrote:
>>> On Thu, May 14, 2020 at 08:46:18AM +0800, Boqun Feng wrote:
>>>> On Wed, May 13, 2020 at 06:39:03AM +0900, Akira Yokosawa wrote:
>>>>> From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
>>>>> From: Akira Yokosawa <akiyks@gmail.com>
>>>>> Date: Sun, 10 May 2020 15:12:57 +0900
>>>>> Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one
>>>>>
>>>>> Where Documentation/litmus-tests/README lists RCU litmus tests,
>>>>> Documentation/litmus-tests/atomic/README lists atomic litmus tests.
>>>>> For symmetry, merge the latter into former, with some context
>>>>> adjustment in the introduction.
>>>>>
>>>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>>>>> Acked-by: Andrea Parri <parri.andrea@gmail.com>
>>>>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>
>>>> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>>>>
>>>> Thanks!
>>>
>>> Applied, and thank you all!
>>>
>>> I rebased, cancelling the revert with the original, resulting in an
>>> updated lkmm branch on -rcu.  There was one minor conflict, so could
>>> one of you please check to make sure that I resolved things appropriately?
>>
>> One thing I noticed.
>>
>> Commit b2998782ded4 ("Documentation/litmus-tests: Clarify about the RCU
>> pre-initialization test")'s change log says:
>>
>>     Since this test returned to tools/memory-model/, make sure that it is
>>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     at least referenced from Documentation/litmus-tests/'s README.
>>
>> Because of the rebase, this needs amendment as well as the title.
>>
>> Something like
>>
>>     Documentation/litumus-tests: Cite a relevant litmus test in tools/memory-model
>>
>>     For ease of finding the RCU related litmus test under
>>     tools/memory-model/, add an entry in README.
>>
>> ?
> 
> Good catch, and yes, I will update that on the next rebase.
> 
> Any other things in need of adjustment?

Aside from the missing Signed-off-by tags Stephen pointed out, I don't
see anything.

        Thanks, Akira

> 
> 							Thanx, Paul

