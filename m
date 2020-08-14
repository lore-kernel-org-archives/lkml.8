Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC03120708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHNSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:00:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41072 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHNSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:00:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15so4883314pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 11:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b1l6WJIr43PpfFuXs56xVTu2jiFSLMBw3oL0hztXcos=;
        b=H+PwhcIH2zsWCbIVtFpbpDXB5jtr8Q66UiJJmFVLkijjXtu8hnuhfC0py5H5fWqqa5
         OTqELwTBCtUS0Jv5G2DJi5A/xxu9CfQ9MGZNN2Hqpe95PFm8/dbmpLgowsXfoaSOser6
         6Ye0knczMC/IFX849wwABFQpy633aSO3gS6e77atCgqw8EbM/i8j1ArtSbDeL4kfs3+R
         rEe2YCI2v8rDXg2EYCFCy0M5r4j8EvS3pssxZg8GR98Fk3DZrwTWjCusWeOebwzUhrbd
         dSUoDRe07BsSOSPLlbADqg+XujoSpU80U7YyqC8FDw8bysbxVKm2nb/bFya51jdSfWF+
         RuMw==
X-Gm-Message-State: AOAM532+6In/3+//xLzBg3qS5xrX48vqRtXSbKUb+3Tv3nhdN5mt5Jle
        Nx63RZYsebO4XR6JCrjU5lE=
X-Google-Smtp-Source: ABdhPJyF3ztckgCcdugn+Ud0cF+bfv1vKWCsXc7NhxQ8d6m3EUTgVQchX0lrfO+uwb2WyTIiWwHV5w==
X-Received: by 2002:a05:6a00:1509:: with SMTP id q9mr2652041pfu.24.1597428010590;
        Fri, 14 Aug 2020 11:00:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f? ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id x6sm10054474pfd.53.2020.08.14.11.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 11:00:09 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To:     Keith Busch <kbusch@kernel.org>, Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02d965f9-d465-6e6f-b113-5f6f7e327afb@grimberg.me>
Date:   Fri, 14 Aug 2020 11:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index ba725ae47305..c4f1ce0ee1e3 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>>                dev_warn_ratelimited(dev->ctrl.device,
>>>>                         "I/O %d QID %d timeout, disable controller\n",
>>>>                         req->tag, nvmeq->qid);
>>>> -             nvme_dev_disable(dev, true);
>>>>                nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>>>> +             nvme_dev_disable(dev, true);
>>>>                return BLK_EH_DONE;
>>>
>>> Shouldn't this flag have been set in nvme_cancel_request()?
>>
>> nvme_cancel_request() is not setting this flag to cancelled and this is causing
> 
> Right, I see that it doesn't, but I'm saying that it should. We used to
> do something like that, and I'm struggling to recall why we're not
> anymore.

I also don't recall why, but I know that we rely on the status
propagating back from submit_sync_cmd which won't happen because
it converts the status into -ENODEV.

> The driver is not reporting   non-response back for all
> cancelled requests, and that is probably not what we should be doing.

I'd think that we should modify our callers to handle nvme status
codes as well rather than rely on nvme_submit_sync_cmd to return a
negative codes under some conditions.
