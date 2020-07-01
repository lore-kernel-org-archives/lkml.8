Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11B020720
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593630638;
	bh=ZeKOSr4swHNon8JlKOoWpk9fwv+EvdDQKTzNNDj68m8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1l8zpcjrMYb0gSU3rJYcDk4ETTZSWkRoH5iPSaD66tSvRBQtfQiQxTlxuf3BbPgdM
	 asl51N4BXc+bqzHszgtBsF4q40X4n5Yo5WBMsowTLQaxKi0bVgunb+XS4Lgp1uAWya
	 9e3vRLXTJJZRIRdzbSaFJTFYkw8WEJ96KGd5ODBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGATKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGATKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:36 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A223CC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:10:36 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 127so1541386ooc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQpzdbIjf113I5LT5xAH3Pi/R/4lrflrWxNFquDKW28=;
        b=FdoyLiw1YEaBJRmbvHwoiLGnoqBFL3sVYQzGpdYTkcc04w7rUWrpiD2CRsjH6qrCqD
         N0OmiCsWjkFTIO1gSatiKqwyKJkvNM7S2l0mAtNk9bA3iQf2fkMCQ3Wu0ZNyFKL8896X
         eVTqaFq/UaoMB5yU04svOiDK4sbp5tLO2/Lkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQpzdbIjf113I5LT5xAH3Pi/R/4lrflrWxNFquDKW28=;
        b=qhW1Xd1DCm4ungaLe8IlZOOs7sYYYA5FBXbMPiIb4E3fbqKomakrAEnn4+Hrk07a9r
         eHeGKYN1/MCVvUkTDSnXL4lkSRWqk+FO9iMjWUKHuIu1gJQnoQmSioisjL420g8fFGH6
         f1gy+top5GhMREpLw9jwwa7rNgM/sTz4Bqd9dUsBJzOah+zyoamg8hDd3cZWtEC0FjME
         Cr8Y9mV4r8YoRY284G3IYhgW0sz4iXjP2FsbMwuCG1mv1tVFd53d0ZEd+hmpWeej0JCU
         EQHylUcZgtABjrk1QhWupFZVW3m7s1rLR2hHnzoSe4iomPz5isBcrtk+1qqeVW369qXl
         M9xQ==
X-Gm-Message-State: AOAM533EB2HuZtmi7Z50OO8t9VMEQqLWfpFthdn5dIVQjc/UvpyiWBar
        iFI/Ry9MOU88/eW8kBpXPQmAfw==
X-Google-Smtp-Source: ABdhPJzx9z5yTTETBz/pqFVx0iHUBPxUsqSF0+zDs9TcGwYfRAte2MthXkwd/jt9wLGnktCfYhVTFA==
X-Received: by 2002:a05:6820:50a:: with SMTP id m10mr24591794ooj.54.1593630635940;
        Wed, 01 Jul 2020 12:10:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a204sm1627823oii.34.2020.07.01.12.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:10:35 -0700 (PDT)
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with
 space
To:     David Gow <davidgow@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
 <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da025a82-17ee-e8bb-61dd-e655f0087d8f@linuxfoundation.org>
Date:   Wed, 1 Jul 2020 13:10:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSnqyqg8xPT2wM=taN2=pPTAm_ySD-WscHuBW175QipuEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 1:15 AM, David Gow wrote:
> On Mon, Jun 8, 2020 at 5:57 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
>>
>> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
>> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
>> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
>> parsing which did not like the spaces in the string.
>>
>> Fix this by updating the regex to allow strings containing spaces.
>>
>> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> Tested-by: David Gow <davidgow@google.com>
> 
> I've been using this patch quite a bit, and haven't hit any problems.
> 
> +Shuah: Any chance we get this into the kunit branch sooner rather
> than later? The KUnit tooling is quite broken without it.
> 


Applied to linux-kselftest kunit

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=kunit

thanks,
-- Shuah
