Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05771C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE70217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qXjTaDPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAUVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:25:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40190 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:25:20 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so3519072ilo.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FHCvw3BPgEGuM+0lfBGPIFX9bQ88tvGWWuXcX9fLsHY=;
        b=qXjTaDPwyPUafBpzuhsi1ITIYQBhCPvnUaCq5unGMHCEZID3D2E7vNgrj6YiQvb/Dl
         vW9/+EL1jdb/jKYwudEW7PEOy42rH/0t0IodwwMAFEi6g61Z+4pkFeAgoXgMG8744qJx
         Bcnmf9Nw/RgVRm44x07L8eeTfw9WBSjXU8fU2Dxq+J1G4yrto2eDUAFSPCRVLoKr26/V
         l+ioFMzci7six7lSmV3a9jjjqfg4nBXF6IY8k8yzr/POU+0w/K2xAHpaE5MEnFUse493
         zCAdGwD6tByHfhs5dJN4hytggJKVC22sHrK5U/BwKxLCQ5FLDDSjqXhqA+3kChv/v2sh
         /O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHCvw3BPgEGuM+0lfBGPIFX9bQ88tvGWWuXcX9fLsHY=;
        b=mIqrFXMWnbe5Lf8jJsGlNYg5QaeKQLkYGOVnd9L48okjOoH1724RfZxIAqCa2F7Oeg
         QY8L8PJWm9qjESe7MgFkcw/NjGL5nAy/T5mGGXA0wuFbt/LY9iV1M0xshE58PEYSHTFA
         brTatLfIDwxQcAseP3l6DJqDilE+O3YuL6eSI0X5u1t0j97iGECpE7icv3lqd+Ve04AA
         Me8ccGH5k5hvSYAGXOWZM4mhLbckmjC4jBMJS+Y1JqN+I30dYoIQX7/uVH9wP0pS5m2m
         gDtfBcpCB0HgYuMepSMQfpyqVurE157nDPeo6yKDDHzMl/4ppbvDNMbpJ8mC3ZCDR8n3
         SMcA==
X-Gm-Message-State: APjAAAWOIA3psWxT4HkQgHsebcPHZ1bwYfnYVnNNMv76I1Di8PEaELtr
        LKJyU3Hf5mL7VMjz7Ksi/MIbIgEfqxQ=
X-Google-Smtp-Source: APXvYqxPLzlyge3FdUW1OJLyyZvj9cGo8aGoZ7RSW91nft7bFum48eXlAWOVjm4i1elqSsWJy65tCg==
X-Received: by 2002:a92:9e97:: with SMTP id s23mr5712813ilk.139.1579641919076;
        Tue, 21 Jan 2020 13:25:19 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l8sm9854822ioc.42.2020.01.21.13.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 13:25:18 -0800 (PST)
Subject: Re: [PATCH] nbd: add a flush_workqueue in nbd_start_device
To:     Josef Bacik <josef@toxicpanda.com>, Sun Ke <sunke32@huawei.com>,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200121124813.13332-1-sunke32@huawei.com>
 <82a3eb7e-883c-a091-feec-27f3937491ab@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83d21549-66a0-0e76-89e5-1303c5b19102@kernel.dk>
Date:   Tue, 21 Jan 2020 14:25:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <82a3eb7e-883c-a091-feec-27f3937491ab@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 7:00 AM, Josef Bacik wrote:
> On 1/21/20 7:48 AM, Sun Ke wrote:
>> When kzalloc fail, may cause trying to destroy the
>> workqueue from inside the workqueue.
>>
>> If num_connections is m (2 < m), and NO.1 ~ NO.n
>> (1 < n < m) kzalloc are successful. The NO.(n + 1)
>> failed. Then, nbd_start_device will return ENOMEM
>> to nbd_start_device_ioctl, and nbd_start_device_ioctl
>> will return immediately without running flush_workqueue.
>> However, we still have n recv threads. If nbd_release
>> run first, recv threads may have to drop the last
>> config_refs and try to destroy the workqueue from
>> inside the workqueue.
>>
>> To fix it, add a flush_workqueue in nbd_start_device.
>>
>> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   drivers/block/nbd.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b4607dd96185..dd1f8c2c6169 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1264,7 +1264,12 @@ static int nbd_start_device(struct nbd_device *nbd)
>>   
>>   		args = kzalloc(sizeof(*args), GFP_KERNEL);
>>   		if (!args) {
>> -			sock_shutdown(nbd);
>> +			if (i == 0)
>> +				sock_shutdown(nbd);
>> +			else {
>> +				sock_shutdown(nbd);
>> +				flush_workqueue(nbd->recv_workq);
>> +			}
> 
> Just for readability sake why don't we just flush_workqueue()
> unconditionally, and add a comment so we know why in the future.

Or maybe just make it:

	sock_shutdown(nbd);
	if (i)
		flush_workqueue(nbd->recv_workq);

which does the same thing, but is still readable. The current code with
the shutdown duplication is just a bit odd. Needs a comment either way.

-- 
Jens Axboe

