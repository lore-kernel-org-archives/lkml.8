Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE94208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eBfQSPTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgAPQA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:00:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40062 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:27 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so22330434iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9JA64lSSGZhM2+AlaRyGX22gJ8cKrvAPGqj8KNteWAA=;
        b=eBfQSPTl2scwswbOFhSakwoAF8PgLkNlYnC3C6QeLqCeox/H7wcY+SIlR+lNSUw42o
         WOIT5oBuVgYd+Y1OGGrbGJNKNmktZTmNXZ16cIQuyAPm4YWbbgoXZnpe06HrfjhZe4wh
         Jvjp4VXvd7d0e1EMKTINBcMvDAv1ptgp5VdEi5x2MQSm3xy5BAWpnG4nDc8SWGvlFXF0
         09mWFcUSVHjoTgkHypCGBi7RfnLUUYN7U9ZoE3UVeSBmMhUBAUqOMOwjHSseREsHpuz5
         yEpQvoDQq9aZOqAgUm/bE5JmNmhYThEmhhBzTgBD2xFEjKfYh2Rhaz0m+v9VGIkXZF7p
         qPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9JA64lSSGZhM2+AlaRyGX22gJ8cKrvAPGqj8KNteWAA=;
        b=KdQp+0q/3+IfSCpEbp+qT0pLFN9Yoik9KMIk92o4x4YVYtxEWDjUbJZ8V8WcAcihs8
         l1PTdue4XwGueJcy1MYz4sjbjmJS0MzvuBM4/N26LzRt3nJNmHCpCzLRvuSmjN7psa9w
         DfD7B3THBRWaC8sJWOa7/ovWHL0RELJQ5QcqqaauAn+dpVSfLq3I6zUnRv/FXvqO3kea
         q7M9pRzIvUp33sWHcXeATEPsrCtDUjxUXOr82a0c2vdvvBBPSWLoL0mbaFp+dTSBgjC7
         fOwHBF/mfRSN/0SQcaiyIhjv5pRnVo9JFgPdrFk95DTSDMPbLvAq0IePgsas461ZYR4n
         KRPA==
X-Gm-Message-State: APjAAAW8Frlp32ZD56JZeer36tR85MZEa9dXOVLzLVdO44/OjYw/zplK
        PnJYwtaNGsGCDMwGjvK51Wgh8A==
X-Google-Smtp-Source: APXvYqyeh93woLPz87vdCJmNQys9BCZFkfr63nCTiExdwxydYs0bn+NUXt5EfOG2vH3juJG/+gxrNQ==
X-Received: by 2002:a6b:740c:: with SMTP id s12mr28568449iog.108.1579190425642;
        Thu, 16 Jan 2020 08:00:25 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y14sm2002012ioa.12.2020.01.16.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:00:25 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
Date:   Thu, 16 Jan 2020 09:00:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116155557.mwjc7vu33xespiag@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 8:55 AM, Stefano Garzarella wrote:
> On Thu, Jan 16, 2020 at 08:29:07AM -0700, Jens Axboe wrote:
>> On 1/16/20 6:49 AM, Stefano Garzarella wrote:
>>> io_uring_poll() sets EPOLLOUT flag if there is space in the
>>> SQ ring, then we should wakeup threads waiting for EPOLLOUT
>>> events when we expose the new SQ head to the userspace.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>
>>> Do you think is better to change the name of 'cq_wait' and 'cq_fasync'?
>>
>> I honestly think it'd be better to have separate waits for in/out poll,
>> the below patch will introduce some unfortunate cacheline traffic
>> between the submitter and completer side.
> 
> Agree, make sense. I'll send a v2 with a new 'sq_wait'.
> 
> About fasync, do you think could be useful the POLL_OUT support?
> In this case, maybe is not simple to have two separate fasync_struct,
> do you have any advice?

The fasync should not matter, it's all in the checking of whether the sq
side has any sleepers. This is rarely going to be the case, so as long
as we can keep the check cheap, then I think we're fine.

Since the use case is mostly single submitter, unless you're doing
something funky or unusual, you're not going to be needing POLLOUT ever.
Hence I don't want to add any cost for it, I'd even advocate just doing
waitqueue_active() perhaps, if we can safely pull it off.

-- 
Jens Axboe

