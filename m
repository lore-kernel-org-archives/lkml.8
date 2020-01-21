Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94A724125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579620737;
	bh=XH2P7QzLSGLLTUA6GkGmA2dArtRNJfmjRQRRA7h56y8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=crk7W4P+R1BcV0qw2z7DHJMPiXf4lsGEHsn5Obr/LsTg12E5OihR+kQ2pV+OR3AQm
	 a59xYRSJeAdCNoPkdHJWM9WX5U1vDHTBStjL7yci3P0ZdQKnLWrgJVcjXI8QSXu/cC
	 5SH6fE36YaqUpZBW5dR9AdFKZmnKKlsHexJjs8Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAUPcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:32:16 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40530 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:32:16 -0500
Received: by mail-il1-f195.google.com with SMTP id c4so2674347ilo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QuY0WDhZX4kxz2cZdcfoWX6pS1PqJixvjT3hklrb4bg=;
        b=L+6DmM/kq/25mWwwyfuJL5puz+XC8sQxXxmq4SEsjcjIrwPeY2MlaTK+KdFs0tUjpx
         e9TsO6QoiGoo8N8SYntD/DxXCbi1YZvH7iN2RdjPK7Wc4cGsN53XBYakvS9cUL9SAqI/
         RwQuKwy2Lk20eL6NfyGHqSaKkBLw3YLyu6U7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuY0WDhZX4kxz2cZdcfoWX6pS1PqJixvjT3hklrb4bg=;
        b=n9PtVdgy8wLj/wT0eRkwgD1RkxjUVzcCewQkQ5hCc6HHVqF1zfGmanuZHkgSLxT2t2
         VzHfwMBpzqS8q93MlZplOsbJdHJ0R5gSxW9Fy16Y+DJixGUMToPcevg3limMe11kjbcK
         kuNLc/1Qqblsn8jhlzaG+hju+ek22VrRriZk619paUJglb384fTxjGm6KZa3tJhj/pPH
         wt8YEEvDPqV0KFIVKmnOrM4+HGFJN54elqhnxyD5kEkPOfnkfs9YaJCzhNFrhZlSKIcv
         so1g4Xpuycjztm3cq1eZqqls6Xjm+36JMxfmO36q/LV1D8nwJf5iZAEyZzIeQCq/50eO
         ORAQ==
X-Gm-Message-State: APjAAAXRyhGoB7u/hDMhSKM+vwpBD5yBBaD03NDH5pwcFDdKxFue9ge7
        5VhI6OFQz5ebRMtp5RgzLBTFfQ==
X-Google-Smtp-Source: APXvYqz1a7VeH+whoGCCHkXj0ItYcUpJAraf63WTQVy3Nt9rZk1Rr6eVt72xptU5ReCjjNvMp5HCSA==
X-Received: by 2002:a05:6e02:c83:: with SMTP id b3mr4035768ile.29.1579620735950;
        Tue, 21 Jan 2020 07:32:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r14sm13344854ilg.59.2020.01.21.07.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:32:15 -0800 (PST)
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
 <20200117100829.GE15760@8bytes.org>
 <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
Date:   Tue, 21 Jan 2020 08:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/20 7:10 PM, Suravee Suthikulpanit wrote:
> On 1/17/2020 5:08 PM, Joerg Roedel wrote:
>> Adding Suravee, who wrote the IOMMU Perf Counter code.
>>
>> On Tue, Jan 14, 2020 at 08:12:20AM -0700, Shuah Khan wrote:
>>> init_iommu_perf_ctr() clobbers the register when it checks write access
>>> to IOMMU perf counters and fails to restore when they are writable.
>>>
>>> Add save and restore to fix it.
>>>
>>> Signed-off-by: Shuah Khan<skhan@linuxfoundation.org>
>>> ---
>>>   drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
>>>   1 file changed, 16 insertions(+), 6 deletions(-)
>> Suravee, can you please review this patch?
>>
> 
> This looks ok. Does this fix certain issues? Or is this just for sanity.

I didn't notice any problems. Counters aren't writable on my system.
However, it certainly looks like a bog since registers aren't restored
like in other places in this file where such checks are done on other
registers.

I see 2 banks and 4 counters on my system. Is it sufficient to check
the first bank and first counter? In other words, if the first one
isn't writable, are all counters non-writable?

Should we read the config first and then, try to see if any of the
counters are writable? I have a patch that does that, I can send it
out for review.

> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Thanks for the review.

thanks,
-- Shuah
