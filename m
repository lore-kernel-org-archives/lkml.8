Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B4A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAR/xXia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHLOGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgHLOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:06:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31533C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:06:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so2386984ejx.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d8f3pH5/ZCKSKStfszgIlZxnw3uyn/996p8sG8HyjxQ=;
        b=fAR/xXiaC+iP55fNn6oDuokITntCFEBi1xlzqIOiXdpufTT+WXrxe16rF8df2MiHZY
         er7UtqFH2MHRU7xYYD1IApTAK7fdlpfxic9pzjkwK5cY5cYUmVOs2zgzIvB8c+XvSiZR
         3L25GBDd93gJK37iUq3pqEhk5NLOUD9oT6bLhsIDtTdX/ne0Yg0xt9gS1NnFCxJxEQIB
         sskLpOZFE0XZFdBoFghrvl7obOn7ywiRYPOrKLFwLku3v746zDYlZPGdpOyW7kwQ8mQJ
         Wf8ihmeQWtY7mcxKWzJxDDH4F7cARHazoA3nwmdj5ULhEOfNu4ehVklCkuUeqEuOJ+vS
         FrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=d8f3pH5/ZCKSKStfszgIlZxnw3uyn/996p8sG8HyjxQ=;
        b=QhcNxbthTpdmDFQI5NhlO2dJYxZ/wvO3Zetmpo9pMmejDnHhiuGH9E4aBQqA8TA+vC
         rie70W92xZCAvAszst3yBHItEQ8zucvoNEEZDBpVZFvqwUJiHEG/FkaAqOpjsEDPc8Bc
         l+xZffSP4Q4Or5LFiMNGjmP8Ivsk2llMY8Fs4wbkS11BH42W6KMCogj9zP91Z7WHYZvg
         NHlcnv2G3MJbxBx2fCi4OYQn5GzX1NxXDPZJLF0TUmnPvd83TcKAY1B5T/BrZKjUoNvJ
         dW2E48D1IFvyDzhLhDEr8qno8TOurgbzny3fMWX6VEds5BytzOjF5pdsYo8HZPPF9BiW
         w0NQ==
X-Gm-Message-State: AOAM531RAyIHEImDJh1HuotESyhPj5wTSM5mGTk89qrLeEJzOXlOVQp0
        67VqKeZ7lDo9c7U/M7jrijs=
X-Google-Smtp-Source: ABdhPJznwOGp/qyo5pGS6jX40SdNtqxQhEKTMsJPS7+o051ebKYTfT0qr3V1BC6oqvTcaOqZcyqkbw==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr31966727ejc.430.1597241189936;
        Wed, 12 Aug 2020 07:06:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id gl20sm1674979ejb.86.2020.08.12.07.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 07:06:28 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: RFC: How to adjust the trace pid?
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>, Shashank.Sharma@amd.com,
        Alex Deucher <alexander.deucher@amd.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <1975d7d1-8f94-5852-6ccc-19fde4d4a919@gmail.com>
 <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dca018cb-8455-874f-7473-fbfbd1d4c7a9@gmail.com>
Date:   Wed, 12 Aug 2020 16:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uF7nTgJE38Krhnw9Ca4FtFpw4b=nFr8-tWqPxTkRrh=Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.08.20 um 15:49 schrieb Daniel Vetter:
> On Wed, Aug 12, 2020 at 3:42 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Ping? Daniel, Dave any opinion on this?
> Type patch, cc: tracing people, see what they say?

Adding Ingo and Steven then.

> tbh I have no idea,
> but they have been making unhappy noises about some of the tricks
> we've played in the past in i915 tracepoints. So not everything is
> cool in there.

Well that was the feedback I was looking for.

> Otherwise I guess just add another tracepoint parameter to dump the
> correct userspace mm.

Well the tracing subsystem looks like rather complicated macro magic, so 
I'm not touching that before speaking to he maintainer what approach we 
should take.

> 3rd option could be to dump the current mm (since I'm assuming those
> threads do kthread_use/unuse_mm to impersonate the right userspace
> process correctly) in the tracepoint infrastructure too?

Nope, we don't use kthread_use/unuse_mm since we don't touch the process 
which initiated the operation in any way.

This is just to improve debugging since it doesn't make much sense to 
trace the pid of the worker thread. And since we have the pid of the 
initiator around anyway using it should be trivial.

Question is rather how to do it correctly? I couldn't find much 
precedence for this.

Thanks,
Christian.

>
> Cheers, Daniel
>
>> Christian.
>>
>> Am 07.08.20 um 15:36 schrieb Christian König:
>>> Hi everybody,
>>>
>>> in amdgpu we got the following issue which I'm seeking advise how to cleanly handle it.
>>>
>>> We have a bunch of trace points which are related to the VM subsystem and executed in either a work item, kthread or foreign process context.
>>>
>>> Now tracing the pid of the context which we are executing in is not really that useful, so I'm wondering if we could just overwrite the pid recorded in the trace entry?
>>>
>>> The following patch does exactly that for the vm_grab_id() trace point, but I'm not 100% sure if that is legal or not.
>>>
>>> Any ideas? Comments?
>>>
>>> Thanks,
>>> Christian.
>>>
>>>
>

