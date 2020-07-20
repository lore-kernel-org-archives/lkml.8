Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6DBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDEC20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WGiBVFDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgGTQjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbgGTPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:49:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C69C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:49:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so13693163ili.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D/CA+/3/bTndVqHDVfOkxSHtDGUPSGt5x3VVKQfqZbg=;
        b=WGiBVFDxkDK9ZFg0IrwsBU9TGmD+ri9d6HGdShiF1Ll+N1iHXGFQmIfLUSjif3Cmp+
         AVeUuZqUIux5ykvvGzRtLUa1DylQFhVVOKR7da7PHAgVzIKkJcHa7BONkoYjb/tCizfw
         1j4ywtzIffpQMa6dfjP3vGDCMKE5fn+PykRLQgbP431T/6VxhaOEmuCQyGkis6crNs5T
         HmAg41n3TmKIBU5R3qZ0YW8M+/EMEkE+3TpK2YDfQrsc5H8hJC9ES3ygxd+39EonR6Cx
         BDO3PHM1BrFlmkKI/BU0weuKzZ9PE3fTQTc4HoMAoDdTfYmVdfAxVSUf4Jd14SZHpD+K
         LVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/CA+/3/bTndVqHDVfOkxSHtDGUPSGt5x3VVKQfqZbg=;
        b=JUdYs82RPV9wDXuq8mV6bljW1Hh3RBPyKCK1wWeX9acSmo77+4sCgi41Vdechx300z
         QVIbLIgTkzVvUg7wjq9nKK5GVlxVWet9to/AbedAS+UtGRo4V1Wt4CXrUU1I6mGUtvtI
         WMSRry0IKMNQr5PAddKG2Af0ZpQtDzzKTu2hNwjOV2g+BjWWr00QVofpgMT9dTi6Y+Df
         OkDyEw6IWiOKCssNMdeAo2lbvMUCpYhSVNKRDVhuEhDWYsu4MIqjSne+aPxHDMs5zAyJ
         3+P4hRXiaBXlS3lRl1BfUutpB25YCaTEZkUo82wHkrH0IyvxsEkkgQMwfE8lRwqiTVtw
         3eoQ==
X-Gm-Message-State: AOAM53200WaVo1NdLavzSEYzauWohz57LgtSS8Z0rqUmmu4rRdtl5VBf
        9HyfsIK6A2UoGSGMStgGBvsmfyt2imhX5A==
X-Google-Smtp-Source: ABdhPJxoefCUr9kZLZrdpjB1/kG/khSkCyqABdVEAysM2MGxbfvjcaNVbWEaW6P3bgONfYG5iyq/kw==
X-Received: by 2002:a05:6e02:605:: with SMTP id t5mr23516270ils.116.1595260144075;
        Mon, 20 Jul 2020 08:49:04 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z78sm9474809ilk.72.2020.07.20.08.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 08:49:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] task_put batching
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1595021626.git.asml.silence@gmail.com>
 <cf209c59-547e-0a69-244d-7c1fec00a978@kernel.dk>
 <b01e7f2d-d9a6-5593-3afb-5008d96695c6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2aa8de0-a2d0-3381-3415-4b523c2b66a5@kernel.dk>
Date:   Mon, 20 Jul 2020 09:49:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b01e7f2d-d9a6-5593-3afb-5008d96695c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 9:22 AM, Pavel Begunkov wrote:
> On 18/07/2020 17:37, Jens Axboe wrote:
>> On 7/18/20 2:32 AM, Pavel Begunkov wrote:
>>> For my a bit exaggerated test case perf continues to show high CPU
>>> cosumption by io_dismantle(), and so calling it io_iopoll_complete().
>>> Even though the patch doesn't yield throughput increase for my setup,
>>> probably because the effect is hidden behind polling, but it definitely
>>> improves relative percentage. And the difference should only grow with
>>> increasing number of CPUs. Another reason to have this is that atomics
>>> may affect other parallel tasks (e.g. which doesn't use io_uring)
>>>
>>> before:
>>> io_iopoll_complete: 5.29%
>>> io_dismantle_req:   2.16%
>>>
>>> after:
>>> io_iopoll_complete: 3.39%
>>> io_dismantle_req:   0.465%
>>
>> Still not seeing a win here, but it's clean and it _should_ work. For
>> some reason I end up getting the offset in task ref put growing the
>> fput_many(). Which doesn't (on the surface) make a lot of sense, but
>> may just mean that we have some weird side effects.
> 
> It grows because the patch is garbage, the second condition is always false.
> See the diff. Could you please drop both patches?

Hah, indeed. With this on top, it looks like it should in terms of
performance and profiles.

I can just fold this into the existing one, if you'd like.

-- 
Jens Axboe

