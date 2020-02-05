Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E4C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546C320674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lhyawHAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEQQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:16:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33538 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:16:58 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so2357323iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7fnEMkwzTHdpkgtBHgX/yCKrRgu+mReSL+3/dsveHJo=;
        b=lhyawHArSLhT69zDHi2XFHPwC9wcSw9kWWwugQ3p8LmspyLVMoMRRuYLbv9s656P/L
         3sn3D/OIBjIJTJ8eUHAVMSbbCN3RrLYij6FKndLytnGo+8x9mueIu8ItdJwCPMxX5kiF
         mTB6+avniaTA8DZ2Dfop5O5mqcwK6i2ql0xQEM1hDYP3fa/vog4C26jCCJeRZXYHEt3j
         5KKs+7CL1HoehVveZydAG9M2meCTW4b59EFAWecdiDKTMJ5bUS37uNRFwRQTtBL8UI85
         mQmgSGVMj0ElCN7mRvWoDgcCeqpyt5SwUTXlPcYE+HKjXtbvOrXBhddZDXmD/tDqe7DX
         9yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fnEMkwzTHdpkgtBHgX/yCKrRgu+mReSL+3/dsveHJo=;
        b=auIJ8u9gzujzh4ZfGUzYB4vDUtJdF/OHkSZPmzYS9FUC9uzcA9KFK/tZJKunhu5Wy5
         zgLptRCbrystkGu3Pqj/E1EIsnrRdNMveWPSCrrFvEAewYFA6ic8BXVdcrc/Dhw2hPHc
         1D0DBZKJg54IJAFTz5ViW6xahKQmop+64mGYpFuT//3TkVLun4RcfpP4y6hSRJncYjKe
         xL96Wf3ijZ92t8hDDoDcjdlO2G47ym/KZe62BjV43BFWxYtuUCK+3Qlhj+p4dUpvpL2D
         inF5YSH5ErWPmIgwSVvWE7IgtahRa7ZrDJEPo7wBOFCZOgeC9p8aPdAJnCO4/8wlW4X3
         +ZEQ==
X-Gm-Message-State: APjAAAUDUkHvQZaEZnzZZlvIOzVe1El9rcUdQPM0ebLo+G24GppOkaxi
        TVS6wadMAVZNxkXA9fH2tfDoZAQ3Zc4=
X-Google-Smtp-Source: APXvYqzofQCivi2jVk+hqEashG6QpP3HN4Ab/KwyhdAD683DdRhE/Kvs4+m7o2ItZCqDx5kXR7r2Ow==
X-Received: by 2002:a92:8808:: with SMTP id h8mr24352201ild.253.1580919416694;
        Wed, 05 Feb 2020 08:16:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h4sm3173ioq.40.2020.02.05.08.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 08:16:56 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix mm use with IORING_OP_{READ,WRITE}
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <951bb84c8337aaac7654261a21b03506b2b8a001.1580914723.git.asml.silence@gmail.com>
 <df11c48e-f456-3b64-88d1-6012b1ac2bc8@kernel.dk>
 <d9a15d32-a20b-a20f-9ea4-3ac355c15bb2@gmail.com>
 <c6cc1e97-f306-e3f0-3f7b-9463fdbbc5a5@kernel.dk>
Message-ID: <d55fd4dc-e7f1-0f06-76bb-0e29c1db4995@kernel.dk>
Date:   Wed, 5 Feb 2020 09:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c6cc1e97-f306-e3f0-3f7b-9463fdbbc5a5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 9:05 AM, Jens Axboe wrote:
> On 2/5/20 9:02 AM, Pavel Begunkov wrote:
>> On 05/02/2020 18:54, Jens Axboe wrote:
>>> On 2/5/20 8:46 AM, Pavel Begunkov wrote:
>>>> IORING_OP_{READ,WRITE} need mm to access user buffers, hence
>>>> req->has_user check should go for them as well. Move the corresponding
>>>> imports past the check.
>>>
>>> I'd need to double check, but I think the has_user check should just go.
>>> The import checks for access anyway, so we'll -EFAULT there if we
>>> somehow messed up and didn't acquire the right mm.
>>>
>> It'd be even better. I have plans to remove it, but I was thinking from a
>> different angle.
> 
> Let me just confirm it in practice, but it should be fine. Then we can just
> kill it.

OK now I remember - in terms of mm it's fine, we'll do the right thing.
But the iov_iter_init() has this gem:

	/* It will get better.  Eventually... */
	if (uaccess_kernel()) {
		i->type = ITER_KVEC | direction;
		i->kvec = (struct kvec *)iov;
	} else {
		i->type = ITER_IOVEC | direction;
		i->iov = iov;
	}

which means that if we haven't set USER_DS, then iov_iter_init() will
magically set the type to ITER_KVEC which then crashes when the iterator
tries to copy.

Which is pretty lame. How about a patch that just checks for
uaccess_kernel() and -EFAULTs if true for the non-fixed variants where
we don't init the iter ourselves? Then we can still kill req->has_user
and not have to fill it in.


-- 
Jens Axboe

