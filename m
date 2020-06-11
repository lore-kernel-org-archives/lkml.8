Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24816C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17AE2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IXDaj0j/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFKGBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFKGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:01:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD31C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 23:01:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so4754036wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dnnaL0zcrHZ7GbUpIGBQzwwFoY13H1/kHvqB5tRy/2c=;
        b=IXDaj0j/nEv/iHebCBAYReXkO8R8Mo+9KtoWgzKFbAZMDAeEy2JyAMhuSUBXfzeh1X
         /rBonBcefudsu/QFeI5hEepJkUuz579K3GNR/Tg9BAhkfXY+fQOIu/VtVRZ9K4LsXGC5
         yXPGm9VgA6DO4PAPuWVpR7qe/I/bqLvHWAf4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dnnaL0zcrHZ7GbUpIGBQzwwFoY13H1/kHvqB5tRy/2c=;
        b=Lcg2Mxep9AuQUWb1vbQFT+l6kVbbZonla3gzNmQ0k6PiJr31OPQLyMN/SzbGuHG69G
         xcrvLRidjChhB8iAquxUVnOGNUIYuTgWP/SDpKYWxdhwnUAx2uP2Vv5md7NkLLzXSofp
         GUMq6jQVOWmj0hqMIv4TKWlobKbZGmZo/qH05rKvWRlbbV9pK4M7iKiFztnRMLy2gzAG
         tUeANG/GGv/DxA4IDtSZ49Jx50UBrS6yLUmLixPNGbI7ZuK+roVTDMCp6K5IfezPt2Iz
         C4nDWS4AxrQn18f/uqFl5StZFE7GaCKzUZlH6kgwEM73Bnw+ptL1P0H81tgcbNzTT+vy
         C7gA==
X-Gm-Message-State: AOAM532EISDja8TtktMrIuxF/1219E5fj1iTLNPCu62AcNQMuy1OpGjh
        nm50lTHWfhWi6uqh3VNQea1ZFZLqhTH7gNzt4mzC6tZrJwzIfrpptvV/3OtXuEpTqCDIFjygpWt
        YM0J4xgkzT9pJtmgj43xmjeG5PvMVdwNixtU0XdmYv8Us2bcT9ENrqaAbU628dHZZBcyzj7p2Oc
        haJmqR6giDa9U=
X-Google-Smtp-Source: ABdhPJwjuCoANT0rp8x0SpyLHDkLH9FBeECjwny6MqSXW7hIPnxV+uo+LogXApi9lsDdS3BYOvQxlw==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr7806571wrh.308.1591855280832;
        Wed, 10 Jun 2020 23:01:20 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d11sm3211326wrm.64.2020.06.10.23.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 23:01:20 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: ignore CamelCase for inttypes.h format
 specifiers
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20200610203307.9344-1-scott.branden@broadcom.com>
 <1b2d9ead79a5a035a287b7ecba8655b2c633d5cd.camel@perches.com>
 <a3d5f2c5-40fb-c97d-8365-423213926e89@broadcom.com>
 <6e2e2095f1b6839ec78d41233fa8d908d1bd2bbe.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f524dfb7-ba0b-1a12-9325-457f5e9d7136@broadcom.com>
Date:   Wed, 10 Jun 2020 23:01:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6e2e2095f1b6839ec78d41233fa8d908d1bd2bbe.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

A few questions about changes below.

On 2020-06-10 3:22 p.m., Joe Perches wrote:
> On Wed, 2020-06-10 at 14:48 -0700, Scott Branden wrote:
>> On 2020-06-10 2:09 p.m., Joe Perches wrote:
>>> On Wed, 2020-06-10 at 13:33 -0700, Scott Branden wrote:
>>>> Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
>>>> (ex. PRIx32 for uint32_t).
>>> Personally, I don't like those.
>> Checkpatch is run against a lot of code outside of the linux kernel but
>> following linux coding style.
> I know.  I don't have any strong feeling about this either.
>
> But _this_ checkpatch is specifically for the linux-kernel.
>
> I just don't want to encourage a bunch of uses of these
> somewhat useless defines internal to linux-kernel sources.
>
>> There is nothing personal about this, they are the format specifiers in
>> inttypes.h for fixed width types .
> True.  It's impersonal to me too.
>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>>>> @@ -5157,6 +5157,8 @@ sub process {
>>>>    			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
>>>>    #Ignore Page<foo> variants
>>>>    			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
>>>> +#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
>>>> +			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&
> There are missing format specifiers.
> If this is done, the test should be against a variable
>
> Something like:
>
> our $inttype_format = qr{(?x:
> 		(?:PRI|SCN)
> 		[diouxX]
> 		(?:FAST|LEAST)?
> 		(?:8|16|32|64|MAX|PTR)
> };
I can try adding the "X" and FAST|LEAST.
But I am not familiar enough with perl or the checkpatch script to 
understand
what you mean by test should be against a variable vs what I have done.
> btw: what about 24, 48, 96, 128 and 256?
I can't find those values described for inttypes.h format specifiers.
Where are you looking at those values from?
>
>>>>    #Ignore SI style variants like nS, mV and dB
>>>>    #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>>>>    			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

