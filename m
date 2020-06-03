Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4401C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B144C2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YgjDG2DO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCCHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgFCCHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:07:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E98C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 19:07:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so681344pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=05oZ75W4PAkbEc2W7bJ8bzylCGe8tKmwbPUEdrxK2MI=;
        b=YgjDG2DOa5fJsziE47TJOIqO8/01xtN5rj6XQhEyI58geqkjsw62uCrQ7ZmmhL1jkL
         +kdgjXt7D4Aq84xaZGh0L81EUocGLPlyFYiHF2fvO1P9QWVrCSVyYbDEz9iL9hZEe4Ui
         7YZAAfcJIdO1plU1NAB8hK7wr7/4flAHjNYD8hU0lNN7/8+Zkt4blJX442q/S/nA/vZh
         ugEK+rcs2zZVVsFqei43wS/VJn57yAxbDa+HeKXRww6Cp4IUKjMn6uAQPi2N6jZB0j3A
         bduC0KNOtfAW6NAb8ORPkEUhbnT2iM3J6BRWL+y5fs4WuBDMiQzfut9IcvNApvAQ/5b+
         ACDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05oZ75W4PAkbEc2W7bJ8bzylCGe8tKmwbPUEdrxK2MI=;
        b=BTnF6RKtuwD07O1Q/MEwSZoBlx9gTOFB71XWY8NX4NIqpFbzC9y87dPzKWwmmsNx4X
         JuyMiQm3YkTSPeDZRtjs0gkXV1zspxKp1rZthxs4AiLH/W87iynjinpEpaKPkn6kSIFl
         I4YFTcOcoZJur948DROwES+DhKZ2jmGHRKCVftFFOTeW0pifEaJ7UkN69qm5CVGW2yuD
         xUQkDVk/91QQztyAc1IGEsI5RTyqeVzpb1Y/swQMayZm2gokXtjLMtSJ4GQJgMTtTjLj
         LoociHjWiyxFGNcYkZdsZfst9nnqJxbmNqR9dLuW6rwtCgXFShdaqIT4IKf1fUCBGhiY
         VWuQ==
X-Gm-Message-State: AOAM5332DfhQ9G+i1D1eyiEnMoHTdD1HJShC/erFO0GIWMw012fXtj+q
        FrfugKhESHuOhoE+CFXTaEd1NjbXXJwGKA==
X-Google-Smtp-Source: ABdhPJw+m9Bk6S9FVc4FjMyeOU0mdWCwQ/Z6Zb3KXA32gR56BP6UBcW9Kd3MbvhePimU1xOaEgMogA==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr2559305pjv.33.1591150036093;
        Tue, 02 Jun 2020 19:07:16 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k7sm216841pga.87.2020.06.02.19.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 19:07:14 -0700 (PDT)
Subject: Re: [GIT PULL] io_uring updates for 5.8-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <dacd50ff-f674-956b-18cd-9d30e2221b09@kernel.dk>
 <CAHk-=wjuAN_vgUN_TiPtzSpz2NX9XQq7-nJ1u=gHG=EKdRdrkA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <237d782f-8163-dbc2-4505-ed5f88ce4362@kernel.dk>
Date:   Tue, 2 Jun 2020 20:07:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjuAN_vgUN_TiPtzSpz2NX9XQq7-nJ1u=gHG=EKdRdrkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 5:03 PM, Linus Torvalds wrote:
> On Mon, Jun 1, 2020 at 10:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>   git://git.kernel.dk/linux-block.git for-5.8/io_uring-2020-06-01
> 
> I'm not sure why pr-tracker-bot didn't like your io_uring pull request.
> 
> It replied to your two other pull requests, but not to this one. I'm
> not seeing any hugely fundamental differences between this and the two
> others..

Pretty sure that happened last time too, but I don't know why. For
the incremental ones after the merge window, it seemed to work fine...

-- 
Jens Axboe

