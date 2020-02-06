Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12654C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E4221741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFYHzyK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgBFObv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:31:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36108 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgBFObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:31:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so6351370ljg.3;
        Thu, 06 Feb 2020 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LYnTX+vuEch8amcqPtgj6i6sblayjdqUwjD1WqwgRUg=;
        b=rFYHzyK4k2vQwvpbA9XpYXNVtyOqH1iRZ9VK74Eks3rEQiCjU9VB/E4tSXleaK/7DS
         yCtEtGuaZDiimEeXKokqEWuXypgbIypXpSEayNNIttVD4bEhOXwQPBPpwpHuLTmArg/G
         t60NRj2zbSZXPEZaVMe2059b6Puih6HAUYQdl2ZYJQvXv83b2ZpiSa95NUc7okZdX9yR
         2jv6HUimzPCKRw0aIbgXPBQnX2mIjfz8MUbLiwBCiEIG7D+VopxpeA4Fj/0vxBkNpc1J
         +a6VPej9BPWH5T+D9H9InZWWrGRrIpKEX9CZg3hz4sZ73e6C7MZCbK4oIdw8R3XEdokl
         Q1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LYnTX+vuEch8amcqPtgj6i6sblayjdqUwjD1WqwgRUg=;
        b=uPvLS5zNwEwVmvGfRtrKwHBpuvDV+tT0wqHW9w/FklBZrxM79O9PisWAGJO4EiNDRW
         xFym7WTxgDy+l/eaugolgennPRe4PAfPOl0aXXq20ngi8I11MYzdZ1ECqhN1ePX+rRDR
         IxVjpKwbnm4oV2/Lmd04IBJDcePrppTYbwzhsjjGDL0g3ztwC1C8DGR741kuOyB3zgy/
         jCdlkCNV9GfCZGKlVk77XeBPpz4aJDzpOt8LzrI5novqJq7SjSsYy/92xu80jgCVsclh
         aVqsWssgb+mbzdHAAy9udfvF7Y54ohOxoJEwE5UVdM7xVFv+9Nc534HKOzO/rx8nzhTc
         VoBg==
X-Gm-Message-State: APjAAAXj6xK5ohaqm1MZA381mwp7VoRj0Kb5I3dAfY8Lum7CQRMMOcoe
        ye/GrTwiIeMlGAip/j6lRFMwoJZv
X-Google-Smtp-Source: APXvYqzz3bUkGQYdT/6NL9IVjZN0HEdheiLNotzYPRH3i5D6HvT3nlNIzGkGg7ELvFFqFa2NoDfPaA==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr2240218ljg.198.1580999508762;
        Thu, 06 Feb 2020 06:31:48 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s15sm1477022ljs.58.2020.02.06.06.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:31:48 -0800 (PST)
Subject: Re: [PATCH v7 14/19] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-15-digetx@gmail.com>
 <ca0f71ef-ba16-73bc-d904-1f5351c69931@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3133d4e3-7623-9342-f26c-5de8b4e6b8c6@gmail.com>
Date:   Thu, 6 Feb 2020 17:31:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <ca0f71ef-ba16-73bc-d904-1f5351c69931@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2020 16:50, Jon Hunter пишет:
> 
> On 02/02/2020 22:28, Dmitry Osipenko wrote:
>> It's a bit impractical to enable hardware's clock at the time of DMA
>> channel's allocation because most of DMA client drivers allocate DMA
>> channel at the time of the driver's probing, and thus, DMA clock is kept
>> always-enabled in practice, defeating the whole purpose of runtime PM.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++-----------
>>  1 file changed, 24 insertions(+), 11 deletions(-)
> What about something like ......
> @@ -581,6 +582,7 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>  	if (!hsgreq->configured) {
>  		tegra_dma_stop(tdc);
> +		pm_runtime_put(tdc->tdma->dev);
>  		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
>  		tegra_dma_abort_all(tdc);
>  		return false;

Yes, that it's what you suggested to do in the reply to v6.

Alright, I'll drop v7 patch #13 and add the put to this patch #14.
