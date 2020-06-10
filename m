Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8102086A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MzxhwN3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFJXWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:22:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC57C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:22:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p18so2620112eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fjz1sdXtyDMJLQ8eG+rXU+1hDfMzBCz7MYoXS+AhliY=;
        b=MzxhwN3mhdi4Ni9OfVNBsbEm6HK2yBlp23IW2Y9WDRNpqceptE7f65cU+2CBC0/ikA
         OMcQWc0pyC7f9hMGhj/FPRCBjnH2YL4NeKYes5GOFmcZpJQ3lhkKoRZ1M2+wVsukJ6Z0
         ftk/IPh375idOHuyN0rWo6C9Y1v4hRXBlBKVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fjz1sdXtyDMJLQ8eG+rXU+1hDfMzBCz7MYoXS+AhliY=;
        b=krruBhsWUtUXUOr3JmuF+3XBp8FTaWYpLyUe111ka+hvSZvUYygXNCMWXF2HEXbVqk
         TrM8LF6zaSKPV9m8F50ik5klTpubdBeiaSLI4WagvpTOKuDtFFCjYDxOK1YC7fTbHqIk
         0YZh7OAtRHRsQBYDXAmZy1hKiQ/0srWME3rUKhM3GVgT1PC4bYQpUs3Jc822cxhNZtTf
         6diXsijI+FfcltwEXlCPTaz2RB3fn/NJ6sP+2efBYf+D7G9mpQJIO1MNvPTFJ1Ex5xiE
         ujgXcpzGS2m4AKzGvi1TWbcVa5a2pJWK8Q+WLDcrHTGYMnVMpKK8AXT0lL6rkBJsOx6R
         njcA==
X-Gm-Message-State: AOAM5320wWO72KMaH1leDFpAtZAqVLuJUJOhZeWi6PIOwZjTxSRWJqgt
        VP+IMo/VAARjpavmCY0o85gZyU3GgcKPgZgfesxUDU7Tk3ic3ZT/HOZ0uCyCAV01fqLDmcfHi4/
        fqn4FCPzZRpSpVT2F4IjIzMwEObhuY2fgAvUwd8kfUubClqZdgjsF1V9jqCuvjbti0oXg3K2UyZ
        izCrX4Np3ZLTA=
X-Google-Smtp-Source: ABdhPJzDuVIc1wl5RUPRUpLKn2bW90GmlUQNlXFLa108eytk6qIWoFeWp6MtY1P8KYZjD8DcPmBFCQ==
X-Received: by 2002:aa7:d698:: with SMTP id d24mr4626113edr.56.1591831366761;
        Wed, 10 Jun 2020 16:22:46 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id md8sm800308ejb.4.2020.06.10.16.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 16:22:45 -0700 (PDT)
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
Message-ID: <88a1d1be-cd31-bbaa-3d8d-d7706fcf5e4f@broadcom.com>
Date:   Wed, 10 Jun 2020 16:22:42 -0700
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
It is already used in various code in the linux-kernel tree for tools to 
work properly on different cpu architectures.
Use of inttypes.h does have its place.
So _this_ checkpatch shouldn't be complaining about them in the linux 
repo either?
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
>
> btw: what about 24, 48, 96, 128 and 256?
>
>>>>    #Ignore SI style variants like nS, mV and dB
>>>>    #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
>>>>    			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&

