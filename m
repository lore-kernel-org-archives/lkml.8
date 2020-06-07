Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4631C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2292065C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="IJ5qErtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFGIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 04:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgFGIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 04:20:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329CC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 01:20:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so14062546wrm.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d6y0/beVX2prGG9BaE8oNlZtYuIjUlHNGhxvleEO0bg=;
        b=IJ5qErtG21ULmz69a5xEiMSHuCWvqzTbWhUhp1hh4fbxsqJP6xZ2Prgzz+wFtA0ZhO
         5llr2H/GttTs9TLm6c8dlzvbbjDs2LKrFy6lno4XdfRvUDY3xj7SoMeeEcvXf8dg5+Vr
         Wl44IfE9RxaitCau+KqAiKKI96hf7MRwA6DPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6y0/beVX2prGG9BaE8oNlZtYuIjUlHNGhxvleEO0bg=;
        b=nJEYk+C0X+W4XoabdqRTkb59yO9sjcqvZtwP/XHyntHg6tWrAagwwDK1O00GY67mGY
         OZ3uYZJvY5jQY6hKcJkhQKXP38RQihQUcFPCXYel7DhCRYrD+w7ZWR95+ynu2z5UTm3d
         jeB+RvN8O4TZpwEFbJOS5rZjAtmvd9s8w/8vjQG0M3KVieaPyyb5Upx3p0BqCBAYxcNq
         BfIVC80FrhWD/0kqcITg45I4Qll2kfGKT0ud7oyY57dsgp1JsU0tlXZXdeEdPI8rV5/H
         rR0cHd5KqdFP5579MgSqsMjhxnlhHtaUbmJpNj/DZw802a0a9/mmuAVxfJuflg4WOVIE
         UbWg==
X-Gm-Message-State: AOAM531kldZ6OJ8PhHGRWqOmH7h1OVOqD/kSP0Uv9wxI9hfRbeuoTWUe
        B5zq9z5dXPxJwlkopsCXw97w6oLx8+w=
X-Google-Smtp-Source: ABdhPJyrLG5zH3hR7xWaSH2JPAz+F2TCGNki4XEF8+f2WSz6+lF2sVGbgdCLcSVEy4IPAlpSagcgVQ==
X-Received: by 2002:a5d:6289:: with SMTP id k9mr18715571wru.358.1591518035028;
        Sun, 07 Jun 2020 01:20:35 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id g3sm21445618wrb.46.2020.06.07.01.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 01:20:34 -0700 (PDT)
Subject: Re: [PATCH] ipv4: nexthop: Fix deadcode issue by performing a proper
 NULL check
To:     David Miller <davem@davemloft.net>
Cc:     patrickeigensatz@gmail.com, dsahern@kernel.org,
        scan-admin@coverity.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
 <20200601.110654.1178868171436999333.davem@davemloft.net>
 <4e6ba1a8-be3b-fd22-e0b8-485d33bb51eb@cumulusnetworks.com>
 <20200602.140108.2199333313862275860.davem@davemloft.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <438a628d-e742-0bc6-a67b-41a2d0a62bab@cumulusnetworks.com>
Date:   Sun, 7 Jun 2020 11:20:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200602.140108.2199333313862275860.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2020 00:01, David Miller wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Tue, 2 Jun 2020 10:23:09 +0300
> 
>> On 01/06/2020 21:06, David Miller wrote:
>>> From: patrickeigensatz@gmail.com
>>> Date: Mon,  1 Jun 2020 13:12:01 +0200
>>>
>>>> From: Patrick Eigensatz <patrickeigensatz@gmail.com>
>>>>
>>>> After allocating the spare nexthop group it should be tested for kzalloc()
>>>> returning NULL, instead the already used nexthop group (which cannot be
>>>> NULL at this point) had been tested so far.
>>>>
>>>> Additionally, if kzalloc() fails, return ERR_PTR(-ENOMEM) instead of NULL.
>>>>
>>>> Coverity-id: 1463885
>>>> Reported-by: Coverity <scan-admin@coverity.com>
>>>> Signed-off-by: Patrick Eigensatz <patrickeigensatz@gmail.com>
>>>
>>> Applied, thank you.
>>>
>>
>> Hi Dave,
>> I see this patch in -net-next but it should've been in -net as I wrote in my
>> review[1]. This patch should go along with the recent nexthop set that fixes
>> a few bugs, since it could result in a null ptr deref if the spare group cannot
>> be allocated.
>> How would you like to proceed? Should it be submitted for -net as well?
> 
> When I'm leading up to the merge window I just toss everything into net-next
> and still queue things to -stable as needed.
> 

Got it, in that case could you please queue the patch for -stable?

I checked https://patchwork.ozlabs.org/bundle/davem/stable/?state=* and
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
but didn't find it.

Thanks,
 Nik


