Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1117620708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594272942;
	bh=HnMPp4djMszVkfw4r5dGwJ5cLHl1tQrLKeBR4bWUeV4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=TIE+cZbpM0/qmrO6c+AIe018JlIJ3BCzE5EyPEYx3WZ0KC7NS1e6hormsQr5KyAAo
	 2iUsS8Spk4gGplK2p0dR243sOlvj3XxDRxGoCul+nFfLHXdwHcPEWCxo8xPmKnkEjb
	 Y5r/klF3+tuXCRk2lI7WdtPQzwWb//V0Cs/gT7wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGIFfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:35:40 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:38468 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGIFfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:35:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id w16so938023ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 22:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/YkVRh01cwCdEzkOpoy/DTTQYnq+R76yuGpXCDqef4=;
        b=WVKjXKFXcnH7RXPN/I0zplDdRu59a/VIguAa3P8ZOXT6CPNG/ewlIW8tNejiTqGx1p
         C5bVC/bcbNr21c1uBMdqJy2YncBHZIa9pH75BAmdawbDEKBy0fTw5TF8gshJUHvRlF4w
         mXL2LOyeFOIGJphOev44xTs6YqmnQfbbpi7cQs62rLDIo3F3hHalm8nF+iYlHGcGhBXT
         F7itQ6zWF+JNKWL+WDvypdrF4QT3AcgnjA3a7OqroEGqXQkd6vPVt9dRU5aa44+sVMrP
         mNiy1U8EPNTbVLmx+YPN122Ah6q9+/Ag7GWinSgraMS8cagj51HszeF3uqgBjZpUc8uM
         M6sQ==
X-Gm-Message-State: AOAM5318dNS+oJL+8UWXYyxQ2Hd+vAzY5qQoj5Oz2GS0nHpIH/xDddqC
        cD7HCjYb91VYMajZrutxVWjKepI1
X-Google-Smtp-Source: ABdhPJzelNhKnlXU7ubXmtvObjEJ5uzY6drzw2lK4lwiTFlIRsXILmGgO6tpfOp4to6oLok3FcVoOg==
X-Received: by 2002:a17:907:2654:: with SMTP id ar20mr51976160ejc.62.1594272937511;
        Wed, 08 Jul 2020 22:35:37 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id u18sm1174665edx.34.2020.07.08.22.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 22:35:36 -0700 (PDT)
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>, peter.ujfalusi@ti.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
 <b9e8f171-6961-b483-c698-18a89e58f361@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <852318ec-9e18-3dee-a91d-1cf4dddb8906@kernel.org>
Date:   Thu, 9 Jul 2020 07:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b9e8f171-6961-b483-c698-18a89e58f361@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 07. 20, 17:42, Dave Jiang wrote:
> On 7/6/2020 11:05 PM, Jiri Slaby wrote:
>> On 26. 06. 20, 20:09, Dave Jiang wrote:
>>> Check dma device list and channel list for empty before iterate as the
>>> iteration function assume the list to be not empty. With devices and
>>> channels now being hot pluggable this is a condition that needs to be
>>> checked. Otherwise it can cause the iterator to spin forever.
>>
>> Could you be a little bit more specific how this can spin forever? I.e.
>> can you attach a stacktrace of such a behaviour?
> 
> I can't seem to find the original splat that lead me to the conclusion
> of it's spinning forever. As I recall, the issue seems to produce
> different splats and not always consistent in being reproduced. Here's a
> partial splat that was tracked by the internal bug database. Since with
> the dma device and channel list being are hot added and removed, the
> device and channel lists can be empty. The list_entry() and friends
> expect the list to not be empty (according to header comment), I added
> the check to ensure that isn't the case before using them in dmaengine.

Yes, the comment states that as it is true: you receive a
wild/non-checkable pointer if you do list_entry on an empty list. BUT
have you actually read what I wrote:

>> As in the empty case, "&pos->member" is "head" (look into
>> list_for_each_entry) and the for loop should loop exactly zero times.

HERE ^^^^

> With the fix, we can no longer produce any of the splats. So maybe the
> above was a bad description of the issue.

No, not only the description, worse, the patch proper looks wrong.

> [ 4216.048375]  ? dma_channel_rebalance+0x7b/0x250
> [ 4216.056360]  dma_async_device_register+0x349/0x3a0
> [ 4216.064604]  idxd_register_dma_device+0x90/0xc0 [idxd]
> [ 4216.073175]  idxd_config_bus_probe.cold+0x7d/0x1fc [idxd]

So, the good part in the patch is the fixed locking in
dma_async_device_register. Otherwise it adds nonsense checks. So you
fixed the issue only by a chance, by a side effect as Peter pointed out.
Leaving aside that you broke dma_request_chan -- that could happen to
anybody.

Vinod, please drop/revert this patch. Then start over only with
dma_async_device_register fixed locking.

thanks,
-- 
js
