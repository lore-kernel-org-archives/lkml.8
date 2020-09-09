Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E697C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383F1206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBm0xnkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIIP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgIIPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:54:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:54:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3505341wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KwC1soUieCawn1nIPhLKGt7LneIuKVZR9+LdYfWklM=;
        b=dBm0xnkWVpqH6ODHdpQSx2DeKIzeJGA1w2yMKbh6GF2LVvFhlbhCauzIhhZoE4gS6C
         k3zZzuc8OBQmChF5c+sW7rMUhvhrpN27gchgLAyBcGOAYwaWNFNodXwzp4KAqt1lhUsd
         aLQAAsRFsHBl3+aV3AXJ9kHn4vO+sLvfSb8dQ2uOy+mNcQBJew/zMNuUDHTGQgyHQ9r7
         o9AJ6mAeTXsZnY9FbnmJwCvMveoPVTo6rYXyoRrYzpfCMkzMXwyco/Hy3BeKoYJEb4Ht
         2tpRFhOHqWTBpsEnBjFv6lscEdC+u3J+tdM1YPh0aaBiROWo2+txbt6KRphkMIid0aHx
         Kf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KwC1soUieCawn1nIPhLKGt7LneIuKVZR9+LdYfWklM=;
        b=Ou4T2b0qqZAYbudA/BS+NbgmVq9tS4HJeEsaHgcxZzstdZfmGgU0zEUmZ5BAoRtzS4
         2bA558cSk/R2E/lJvef0RsGwMPvKlSKO91RXlVF8OlXogxQ0w4OwjXNv+5N35sOke8Jg
         PlgYO4F11KCQe8Ll8MiEmfonlq2aaUYcssdJfMfIB6vqiNSPyQrv6xW1aXFKqBIO9q2q
         etoXuU8ZtTMCKuU18SP4jAqBmi/Ejbhz2HUU9f+sHEMXuX9+qy+38PfbDEkutMxos4qV
         qTM1qRmyXj0+V2ghvZfSFBWsJa3PHWVirXZC+laLnQ+twL2u9pdjA6xFbre52Q7jNFAF
         Cnwg==
X-Gm-Message-State: AOAM5328DmY732oEk0PWrB6wLTSdQxhGXtoTPcTGX9KB4MtlOz4ply8K
        Yal0/ifaza59gPhMW1dZh4jIs1hOenb9+Q==
X-Google-Smtp-Source: ABdhPJzq+ecLQ0dlN96maN6DMHvtC/xXYGjZzpuEZOeizDN86+41jWyowwzDlPXLmxO3f9962+5L0A==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr4577740wrv.343.1599666864443;
        Wed, 09 Sep 2020 08:54:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id v9sm4822740wru.37.2020.09.09.08.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 08:54:23 -0700 (PDT)
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
Date:   Wed, 9 Sep 2020 16:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2020 15:39, Pierre-Louis Bossart wrote:
> 
>>>> Currently slave devices are only added either from device tree or acpi
>>>> entries. However lets say, there is wrong or no entry of a slave device
>>>> in DT that is enumerated, then there is no way for user to know all
>>>> the enumerated devices on the bus.
>>>
>>> Sorry Srinivas, I don't understand your point.
>>>
>>> The sysfs entries will include all devices that are described in 
>>> platform firmware (be it DT or ACPI).
>>
>> yes that is true, but it will not include all the enumerated devices 
>> on the bus!
>>
>> In my case on a new board I was trying to figure out what devices are 
>> on the bus even before even adding any device tree entries!
> 
> We've seen this before but dynamic debug provides all the information 
> you need. see e.g. the logs from 
> https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/
> 
> jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0: Slave 
> attached, programming device number
> jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW 
> Slave Addr: 10025d070000 <<< HERE

Yes, I have noticed this too! This will be printed for every call to 
sdw_extract_slave_id()!

...
> 
> Now I get your point but
> a) you already have a dynamic debug trace to list all devices
> b) adding 'undeclared' devices would make things quite murky and is only 
> half of the solution. We already struggle because we already have 
> 'ghost' devices in sysfs that are not physically present, and no way to 
> differentiate between the two. If we did add those entries, then we'd 
> need two new sysfs attributes such as
> 'declared' and 'enumerated'.

I totally agree with you on dealing with the undeclared devices, which 
is unnecessary mess!
May be we could make the enumerated devices discovery bit more verbose!

--srini
