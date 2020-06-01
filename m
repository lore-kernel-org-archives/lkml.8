Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24815C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D3F206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJBkjwja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFAJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFAJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:13:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D71C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:13:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l26so9961299wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDHwL27SjRSAn7P4iHG4Ki5sU7jd9jS6jL4SyV4oF3E=;
        b=zJBkjwja8Fm8zIIJ8IBmWgDe1V+NAhJHgo3lPoZWmY4ashtHyXRVt0ke2KgerN+BKB
         mcbIvnoV/C+IlpkcKMwnTbla9vWa+MTMQo8AbTndYAS1id/kKOlFtIswZE3GyH3xqLqe
         NKP4cFLNrEs0XTwge8f+oMHNyl6xJNxJ37AeDsG1ZhoRMdq9UVZzbu2rzPzZAoXCLNLw
         mvTilv3CbiEJgo5JguLjHDrVtI1qN5/QUee0Q8RXb+wXs7Ja6c6EX9Q1pAL7icuNs9P/
         eD/IDjZUzlf8PziZn/LEhdF9C8YYn0xoLToiFYusRqqif1uPUkJeWB4083UZXw6srafa
         kAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDHwL27SjRSAn7P4iHG4Ki5sU7jd9jS6jL4SyV4oF3E=;
        b=OzZFE12KXw7ZfY00Px3qdc1KnKwVbazrjkqC+AFJ2VBYvNAvrMANIS+ZzQzLsE9S+V
         bOKMheeAbYeAH9N5mBn/ado9Zp3N+zfEwQ48rxECXM7YUGg+/gIfLzuxYRwVwnANLw/4
         ZOJAU29bk0PzPV+J+a2xgl0x/tdbdTRjmLG/19UfZrJ3CJB9gIVBJ9qSRO/e8ztO//ex
         ZtljgGYYb7Dn+YZ0ePcxqhOR9qt7gZYVXnNS7gTohVXHRuNFIEJfkMv981QRBGiZf/J6
         BVglLnE0rbaE3syKeDDGVh7do9p32n9PoPMrFGYa66AcHL5uTg4nCa8D1E7DecSXop0R
         73hw==
X-Gm-Message-State: AOAM5324/9vPALrHgCyYiownCX6emRu8+VvlX+TUx3dV2zCl3KcNC2W3
        4Uc/BIYg5PgPmy8z/fuNbPvRm/xEPhA=
X-Google-Smtp-Source: ABdhPJzMiRlL4OQZE/Sy5jOOHAS/PO2AotW6Syts2R0Ia9kzs9upII1d9fLRC8E86GyxWKS9PaMHPQ==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr2813557wmb.69.1591002786511;
        Mon, 01 Jun 2020 02:13:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r2sm21587171wrg.68.2020.06.01.02.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 02:13:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
 <20200601090300.GA21928@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
Date:   Mon, 1 Jun 2020 10:13:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200601090300.GA21928@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2020 10:03, Vadym Kochan wrote:
>>> +
>>> +	nvmem = of_nvmem_device_get(np, NULL);
>>> +	if (IS_ERR(nvmem))
>>> +		return PTR_ERR(nvmem);
>>> +
>> TBH, this looks completely incorrect way to do this and misuse of nvmem
>> consumer interface.
>>
>> Ideally nvmem provider driver should populate "cells" in struct nvmem_config
>> after decoding them and then register nvmem provider.
>>
>> That should just work!
>>
>>
>> --srini
> But this is not nvmem provider but just describes the cells for any
> nvmem device, because ONIE uses special TLV structure on the nvmem
> device. So from the nvmem device point it is a consumer but provides the cells
> for the given device.

That still falls under nvmem providers responsibility to parse these 
cells before registering it.

BTW, where is the provider driver for this in kernel?


--srini

> 
