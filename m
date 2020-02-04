Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55517C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C31A21D7E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLxCMCB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgBDKEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:04:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52522 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgBDKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:04:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so2529232wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9i8R9bI1KU8imWN9Jn2mGLP1QeS6cJKLjdfeB3bx5O8=;
        b=tLxCMCB4IVaQLxQqCSiVlultb4wa84G+dnzF6oyQMftTgT0DxEeFbCQiWEVAJgver2
         KLpGGYLpjfzXqv5j9kZXSLbGmzFiO+wUM2Nu6TiEyM5Wt3bu4J+Xj5bJqzNk4q6HkLVa
         1Nlinf+Rx4ryqdI4j2UWR+LOlMcn5kdDdmslYIrYV6UfMhuBYya1plRq/QYkC7tepnYS
         Xcb7BGPDD7FzZQngqk4yzaiL9q7DP8OLJPgztPBbNvavllWm06PoTT/rUtuyPnROd9Zs
         HFuhZ2xa/Lm+q8GEuiG2f0VyviYmjTfT/Oos0C51BVhkm5Ez0ZyQgqVwwYkVAfkWt80e
         scsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9i8R9bI1KU8imWN9Jn2mGLP1QeS6cJKLjdfeB3bx5O8=;
        b=oQLPtwS/7v3JxKjv6uuWbFkwBEBy2oOcVpXyrTfeU3dCLUNgvXZ3Ru2MpZ/wWfpe+9
         M6wLpUn5B9Y3WdeHatVgr8oHyeLfDNEL8XxdH8oLv418arZmpE8tIjWwGz8ESpSkxA51
         sMn7qt9yGKoki7joLSu5wnO81HVCamS3ulBkAAzOdFUKbzSdyJGI7Ng9ZNN9U0T4M9Tv
         bsvJeVId8uwC/Ps0Bj8MOjNp7LBe5urDOUdkgnVu/lk7GW8NMumzb9xIrDdGCXSet4i3
         osVYrcOrDw5EQcY+vZqOG7chr+S5gMU8braFfFSSiDhpnXM7O6w6QsM0QjRll/YwOe97
         Yssw==
X-Gm-Message-State: APjAAAX8ooN+UHl0DVkvaeljnkq4mb5CgLVdhAaaoxi2B1uHdPTBDUs9
        /9bKIeZpjzFoF2uKkQ7gIZIKMQ==
X-Google-Smtp-Source: APXvYqxx+5W18S0xB5ATNIg1V8iOT2hjAUdASDl14nMAGmbITjnzvlj+8JRyDy6zJOIdO0vGV7a+Lw==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr4885617wmh.22.1580810682684;
        Tue, 04 Feb 2020 02:04:42 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r15sm3023217wmh.21.2020.02.04.02.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 02:04:41 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the mfd tree
To:     Lee Jones <lee.jones@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200204140300.7537283c@canb.auug.org.au>
 <20200204075304.GE15069@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0a4c9e64-34e1-d2cd-fb5c-8b11021265f1@linaro.org>
Date:   Tue, 4 Feb 2020 10:04:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204075304.GE15069@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2020 07:53, Lee Jones wrote:
> On Tue, 04 Feb 2020, Stephen Rothwell wrote:
> 
>> Hi all,
>>
>> After merging the mfd tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>
>> ld: sound/soc/codecs/wcd934x.o:(.toc+0x0): undefined reference to `of_clk_src_simple_get'
>> ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
>> wcd934x.c:(.text.wcd934x_codec_probe+0x3d4): undefined reference to `.__clk_get_name'
>> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438): undefined reference to `.clk_hw_register'
>> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474): undefined reference to `.of_clk_add_provider'
> 
> What's the cause of this?  I thought PowerPC made use of the CCF?

Looks like the allyesconfig is not selecting COMMON_CLK for some reason,
and  SND_SOC_WCD934X is missing "depends on COMMON_CLK" in Kconfig

I will send a fix for that!


--srini

> 
>> Caused by commit
>>
>>    6ac7e4d7ad70 ("mfd: wcd934x: Add support to wcd9340/wcd9341 codec")
> 
> Looks to me like the Codec is broken, rather than the MFD driver.
> 
>> Unfortunately that commit is now in Linus' tree (and was never in
>> linux-next).
>>
>> I marked CONFIG_MFD_STMFX as BROKEN for now.
> 
> Surely that should be SND_SOC_WCD934X?
> 
> Srini,
> 
>    What do you plan to do about this?
> 
