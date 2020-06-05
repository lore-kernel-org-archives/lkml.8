Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B01DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D4E206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sQRRF+6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgFEUVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgFEUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:21:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FEC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:21:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ga6so3128594pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lsaNY1znMuhWXaMnc/rolmE1oxcFFUp17hGPr1rY97U=;
        b=sQRRF+6FJFYJrF+tlMtHHxvSYj85wVQllZj5/u0RK1uLZ2l9Eg34mVsYN5NXfe6wsw
         tc0XDG8jEIcIA0kcP0QL5agDaoTKwx+hIxp4mIsHfWLT/txu7EwaZ4anSq9oXUGzC4hC
         oCO0uP1Hxgwo3ic303jU02yWfqbiUS1iH8FgpMi+P3iJEZoyBE7rdNJl1wV/n7cGxipX
         hQh1JgOyOAnn/Z8pEf1/Cn37AOThgHiE8/XVkOKXpuswEwr992L88cHF0y8qgi+xtfuc
         AtOMibKECuD1j/RKQUcy/AfnwvlNJ5byB5NT6GMEdwFMItTaDO4V+7VNxNvNHQHLMtQP
         KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lsaNY1znMuhWXaMnc/rolmE1oxcFFUp17hGPr1rY97U=;
        b=Lpm48D18+/2IeYoB8Ud7QZRS4/ZzuzKvdWhv6Dv7ZgDjyfgvExDqZoSugBmZSgLo4T
         dBHggQaZIiGZT58lAfB1qlQ6aHBMYMog5ahU8zuNbhDJ/C1Of7lmy4RkwNAYZpa2otEJ
         LnhxwT6raVLkWHikyt5RhbOkcNPFnR4mrJ0XVfL/Tp1mn5gifYBkXKLUe7Dmuyi/UIjs
         9IqmGO5lvxxqbxnW0DmSgY5ScWpTTcIgUA/sxLUP1qEh2oA+3A3eOB27eau7evvpczBw
         8oavsoGg6Adhe5Muh+T0/LntDyG8FrhOg0+FlRvgzDhGbkX8SCXMRiboRoETMzd8yY0c
         waKg==
X-Gm-Message-State: AOAM532QNartjLAxat4ZthSeM4SDf1lzgE4ixYL+v1gpkX6si6gC6mTR
        ujp4xYVRVRQwRXxioLpeAeQhJ6d0X58XkQ==
X-Google-Smtp-Source: ABdhPJxUYCcV6eTrwlSeDC7QQ+JpnPnlJQKUBydTzbvgKQGAeXuZ+SEtrB0EwChX4HH45w4rFeTHQg==
X-Received: by 2002:a17:90b:1108:: with SMTP id gi8mr4824068pjb.144.1591388507489;
        Fri, 05 Jun 2020 13:21:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id nl8sm9810832pjb.13.2020.06.05.13.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:21:46 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
To:     Andres Freund <andres@anarazel.de>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200604005916.niy2mejjcsx4sv6t@alap3.anarazel.de>
 <e3072371-1d6b-8ae5-d946-d83e60427cb0@kernel.dk>
 <6eeff14f-befc-a5cc-08da-cb77f811fbdf@kernel.dk>
 <20200605202028.d57nklzpeolukni7@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34b47fac-c162-1a81-2829-965189fa5d3d@kernel.dk>
Date:   Fri, 5 Jun 2020 14:21:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605202028.d57nklzpeolukni7@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 2:20 PM, Andres Freund wrote:
> Hi,
> 
> On 2020-06-05 08:42:28 -0600, Jens Axboe wrote:
>> Can you try with async-buffered.7? I've rebased it on a new mechanism,
>> and doing something like what you describe above I haven't been able
>> to trigger anything bad. I'd try your test case specifically, so do let
>> know if it's something I can run.
> 
> I tried my test on async-buffered.7?, and I get hangs very quickly after
> starting. Unfortunately, I don't seem to get an OOPSs, not sure yet why.
> 
> Let me know if my test triggers for you.
> 
> I'll go and try to figure out why I don't see an oops...

I'll try the reproducer! Thanks for testing.

-- 
Jens Axboe

