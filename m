Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F9CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC60E2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594309009;
	bh=ueL6sQO9ro3ww5u2ZGZQH4gfy/GTjuo0cXBScpidbA0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=itK4zanWYEcHGdDKeLJZNO/wV5WP0JuMxxt+8yFKqnDgDRfbBsBB1vdabs0AXXX6m
	 V1h0GAB/r2Gn/RKLbbP5LRMyvfjRVxmYYaHxrmXrcVIZvt+w1fv89NevjYlzdibQv5
	 18plNrwjV3bYFE3/P+GtPvl0HvwEe2sdmgZUSOeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGIPgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgGIPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:36:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6330DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:36:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t198so2208696oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVjAMTDUKFALK0qpTqn84ZrDkdKOkYoKEkZi0Af6a4g=;
        b=clTbhabYBx3gc82LSf9yDfTlYyYtoC6tVmbvqY9wjcSKN/Vg2T+OSVQMO9TaEgtJgo
         LckxP8J/RxjcVLx08XjHurp5Ryxx9jC7r2vVOQckau6TZYrCdYPJ8laaTDPUuqBhqr5S
         L8sr+x/whquSBt6V9c8Gwa44yfrlDNoCcf32U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVjAMTDUKFALK0qpTqn84ZrDkdKOkYoKEkZi0Af6a4g=;
        b=mI41CQ5IYQIeEVWPmhHgSNeYnp3j0nJ7pBjDA8cn9zLZoot8Mbiw3NYeB/6WJcK7Hb
         Zi2rLudxjJZtwb5h6Go+N0E7nyru5bIiYUE9E9x+JerPV0KUnYYG8PEorqhS6pxhG27x
         vRQdCdAMFlS31UbT7t8NvHg6u7uL76cFkU1YfHFm5Y/PgU1n9d/hUDf8APy/YLTX/OjY
         TF5h1HOw1Q/FAIf+3Tu6UOAYG3G+/W/nIMHrp8W1LopqlxCxYIhQ21aX4dWIAjYca5+P
         nOTO/o1snpGnDbBRr7u31OTDPcY44RsPEWWLvMdWW+/8u8eEldGHwgc+0ZeKpWl6YPE6
         QKmA==
X-Gm-Message-State: AOAM531j35lQFIjEhrott87xVle6eGUcPe7fVEmNJEvasblkrTZnkPiN
        sj8MFmMoO0d2GRyjCjqziriATA==
X-Google-Smtp-Source: ABdhPJz+ltVpAZ8QFMjs5UJ/cBz4tssapZ8j9FfPZ66zH14x9Gv0y0kopZuy/2J2c+EXe6QMXkMBjQ==
X-Received: by 2002:aca:cd50:: with SMTP id d77mr532501oig.29.1594309006834;
        Thu, 09 Jul 2020 08:36:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l23sm643270oot.41.2020.07.09.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:36:46 -0700 (PDT)
Subject: Re: [selftests] 7cb32086e5:
 kernel-selftests.x86.check_initial_reg_state_32.fail
To:     kernel test robot <rong.a.chen@intel.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200709064946.GQ3874@shao2-debian>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9cfe8123-9cd7-a6ec-f73b-3252d695a387@linuxfoundation.org>
Date:   Thu, 9 Jul 2020 09:36:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709064946.GQ3874@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 12:49 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 7cb32086e59b514a832a3e11f5370d37e7cfe022 ("selftests: simplify run_tests")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 

Thanks for the report. I will drop this patch for now from next.

Yauheni,

This patch broke x86 32-bit test run
make run_tests -C x86

Please resubmit the patch with the fix.

thanks,
-- Shuah
