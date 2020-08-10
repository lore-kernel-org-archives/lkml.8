Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61091C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A5120716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi8pCtya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHJVXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgHJVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:23:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE22CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:23:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i19so5512102lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qsiDWS5n9hKEAhff174Y+UtbN9r2TblkIij4sUTlVic=;
        b=Fi8pCtyaD9nfxMoAWYSP6HWchCG1Y42I8zripyNB8WUBb+pRCoooqvYqrqN1sN4PKA
         0466JJ2OYdr0NLYGv69VtY1ljoP6Z1S9hC5RbT9y4MQ3EDAfO7lHrPGwAPL8VyqJSB7J
         wGiAJaytAsvDcKY/SdrGMRx39ExYMQ0K/DBGNi8xhlVvMMCGGG3vwAZmEUDw3mGFJOs7
         unUPUUUQqonzbxvJNybwgJp/aagLzwHY89xrO/7/VlbCyfIAq5gFdhGYInIVomx3P8Cr
         5K5pils3Hr1tMm0qMidXtSD2pxN2nmoAv69v2w1T9cjLMQDCubOSmJupslDA+UwhfnGG
         /DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsiDWS5n9hKEAhff174Y+UtbN9r2TblkIij4sUTlVic=;
        b=H2v2yt+aQSh+ARj0HUkVA6rdqbhf3mCzIpVFMb0jSlYShV8UlxktRJm7W6su5bZenx
         1J/APOgwykF36FSkj5WLHPDFgTRGMwtZFfpnt6mMh81t5KhakZcrq3BmmGo9m86c5v5X
         NjMCWzFKGqY16bIO5t00EdCFzYP48UYiHRjO1Ja07J1eVGtGW9HUVI8tioDg5/i6pvA2
         kG5p8wfOXDuhsCXeUPzv9R3/KSagEiJEGa0IIyVF5c656utGpzJPRe9OOxrZNgnG97q/
         jEAYf0F+0mvdysHtAs/Coco8szQ2iNrGJa3bsrBu8JWX6JuGhD2mZyNnkuFDaVn8KXgm
         /zwQ==
X-Gm-Message-State: AOAM531tWRTUePsEdbVUJU/0XhgXtkOTRohm+ecqMBwiHOMCc4SBN4xZ
        vA+MAyJi/Uqv+Ggo9+EvBdWvAtM7
X-Google-Smtp-Source: ABdhPJxGqfOAqshznPYprxBoMjqwSpmohAVnBsuQ6993TvBTWAP3Qa3yrVJoUASO9Jt5KA3koBhnGA==
X-Received: by 2002:a19:c1d7:: with SMTP id r206mr1519170lff.2.1597094618995;
        Mon, 10 Aug 2020 14:23:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id j1sm9694998ljb.35.2020.08.10.14.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 14:23:38 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
 <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
 <20200810201846.GA12091@qmqm.qmqm.pl>
 <d9c3f307-e124-ea5e-c036-71138f9232f4@gmail.com>
 <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
Message-ID: <dc702a33-43b1-c5af-e549-2d3acc71011b@gmail.com>
Date:   Tue, 11 Aug 2020 00:23:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81e490af-d1da-873a-51b4-130ca82fd1f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 23:56, Dmitry Osipenko пишет:
> 10.08.2020 23:21, Dmitry Osipenko пишет:
>> 10.08.2020 23:18, Michał Mirosław пишет:
>>> On Mon, Aug 10, 2020 at 11:15:28PM +0300, Dmitry Osipenko wrote:
>>>> 10.08.2020 23:09, Michał Mirosław пишет:
>>>>> At first I also thought so, but there's more. Below is a lockdep
>>>>> complaint with your patch applied. I did a similar patch and then two more
>>>>> (following) and that is still not enough (sysfs/debugfs do allocations,
>>>>> too).
>>>> Then it should be good to move the locking for init_coupling() like I
>>>> suggested and use GFP_NOWAIT for the two other cases. It all could be a
>>>> single small patch. Could you please check whether GFP_NOWAIT helps?
>>>
>>> This would be equivalent to my patches. Problem with sysfs and debugfs
>>> remains as they don't have the option of GFP_NOWAIT. This needs to be
>>> moved outside of the locks.
>>
>> Ah okay, you meant the debugfs core. I see now, thanks.
>>
> 
> This indeed needs a capital solution.
> 
> It's not obvious how to fix it.. we can probably remove taking the
> list_mutex from lock_dependent(), but this still won't help the case of
> memory reclaiming because reclaim may cause touching the already locked
> regulator. IIUC, the case of memory reclaiming under regulator lock was
> always dangerous and happened to work by chance before, correct?
> 

And like Mark mentioned before, this situation also potentially may
happen from other paths.
