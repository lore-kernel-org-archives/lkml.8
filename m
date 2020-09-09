Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A92C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51635206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599668548;
	bh=Z9KQb/DW9eAJ2hetddzeHFiqf4mZA/F9VG0fffdh6mA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=aNxgB3YLxinFhtGfh2C9R+6nP0jn0ErwlqqipIMxUKq3TrLhzkU/jY9JpUz3oE/Jk
	 3lHK74YORaHLCNfcsXjlBqYV6FcwmkcalKuCXkZ8DUnERoomGRp0ecIxfN9LEN/r2H
	 LbMDd4OZWUQJEe2xNuXFBSDiH2q9+juxPJIcN5SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgIIQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgIIQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:20:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BEC061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:19:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y6so2920472oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkoSSq8WPACZ/QHWA4I24uXK2makUJpC8Vvbzb8/Mzw=;
        b=OyTvZbHbIWZ+X76naLRjHS4Y4vdrWG3SfSw4OVldHx1EhCcoo0ebTkKE3013opJoGX
         WslRB3cGvqmZHxVUjKMPuWk0gZEQP1aYyX2e3gcn/yUg1NbxWAlWqOkZD1ZD2Ag48mj4
         eik+jw4qlvzuGFUmfhf0h5BwndBKYQA0exeXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkoSSq8WPACZ/QHWA4I24uXK2makUJpC8Vvbzb8/Mzw=;
        b=hzMSHz1491xH80GAeVxELJ6fyejJedwiM5ymDczlBpQQ5FGKv5ByzLDJLLS6ePH113
         H4dd+XDCq7DfWhIEH3tjk8FDVdVcOMsWMRV29Y32YvqU0W70dNZBK+nkEIPd+h7/OSoj
         v+yOH6IQIb8wTL6D6lpNjwSi+HKs/+73O/VCpl1jNjWX78TODTfGfYs9azuMvKHNf+21
         /4ppSQxUr/+dEVPziiwYxcQKCoyn4ovuA4mtUOEjQ6oa2ckzB9yneD0WIKTCIoZuNB/R
         XAMo2dqBuHfqTJAj8FUDLWgUHGLFFXmYP7IiDhKGuFZhuornFMNXIYtkkzkyJk35Uzj2
         tsBA==
X-Gm-Message-State: AOAM533C9BS3TBpa8gh7YHK0s3wCagipA3EH8vLcJTKGPENPNsHPbbXO
        vIe6q5itB1NRlF/uEgyNRtZUUA==
X-Google-Smtp-Source: ABdhPJyZcH5O+jGex+tDr0HJWglht4OaZpAYStGLnupFZcr4YYnKmIAJn3dkGv4SPWtpB29RyKdweQ==
X-Received: by 2002:aca:d885:: with SMTP id p127mr1165992oig.1.1599668376019;
        Wed, 09 Sep 2020 09:19:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j18sm434490otr.12.2020.09.09.09.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 09:19:35 -0700 (PDT)
Subject: Re: [PATCH] kernel: events: Use scnprintf() in show_pmu_*() instead
 of snprintf()
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200901234930.359126-1-skhan@linuxfoundation.org>
 <87o8mfxxc4.fsf@ashishki-desk.ger.corp.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d0c52cb6-5eb2-8ea0-a1b4-c97f447835f6@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 10:19:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8mfxxc4.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 12:45 AM, Alexander Shishkin wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> Since snprintf() returns would-be-output size instead of the actual
>> output size, replace it with scnprintf(), so the nr_addr_filters_show(),
>> type_show(), and perf_event_mux_interval_ms_show() routines return the
>> actual size.
> 
> Well, firstly they should just be sprintf()s, and secondly, I wouldn't
> worry about it, because [0].

scnprintf() or sprinf() could be used.

> 
> [0] https://marc.info/?l=linux-kernel&m=159874491103969&w=2

Awesome. Thanks for the pointer. I wasn't aware of this work and
it takes care of the problem kernel wide. A better way to solve
the problem.

thanks,
-- Shuah
