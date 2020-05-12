Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC6C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81FC20753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yarnVwmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgELKmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgELKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:42:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D3C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:42:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so7807776wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XBDNzFG8QSzsIRZuQSwPOSqw+NgxOqYHOpBQC+9ka4k=;
        b=yarnVwmJoraw95ZM6j1mC2m1g54rjNMVGuE9yv/yH4ttyQQBhCWb1YyGqbnIBaouGp
         pOmMpzMf5ISo7ZzsqAngi7SS4i+T8fhRIP0TMl9oRq+ZNHxI5Qt+YZ32uw2hgPEmr+7w
         vRcaOm23guFIPD1YQjezKSxkbqSrbiKq+StAACkg8ih5FrYdcnY2/QDBLOig9wDKD57m
         us55WNPBdiDTzu7E4g89lE6runsA+jzpKWvhLoeP6gFYYsN9UKaaQW1HXJsDJrOPzpI7
         6iU8R4dEfZnowCqDNdyTAVJ7UqIRMbHEFVYr5lDyQsmQth07+pHpf7nAedcQ5W0mSdCs
         AdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XBDNzFG8QSzsIRZuQSwPOSqw+NgxOqYHOpBQC+9ka4k=;
        b=Esx13mUV1O2YRLwiOfhlCvFjZ0L00i6x4UN4bvr9s7XO1MZyRA2yWw6ciuhh90FUFf
         UhoJuWZf1pOSXv0NcQvQgNkCTIdz8zwl1UNMNYeprBVwb1uHP5+fv3SDzxT4z35kaCDL
         aEWHqaVvTCUlLDN20J2qRYc20eKEBnJ0DCGjgUjE26CHOXhgavuVLb8tBUrGz4GpZ381
         n/IfLZvVmP/WEigJn8N32HOMQfbibXENOMyCd3h0KdgNZSzIFoh3MTdxPON/8DxsgWVT
         oyJ5+JRmhthJ2M0EL7x/pi9joF/tj4WU1O8T1AW6m8S+MfPAxhO81O7mQayqpRraljti
         15Ug==
X-Gm-Message-State: AGi0PubJQfUkppGMwrid4oTPzssQTv8UIFzsmqg/keCFTWlgiK8LdLDW
        XApuO1ix3ENKD48yZ8XXerMTmA==
X-Google-Smtp-Source: APiQypLJb2onAHmEXMCSiZDhoizRSpnoSt1QzYjPjrlbuuO/ZkyvhykW1XekrBNOffxYaWototjTLw==
X-Received: by 2002:a7b:c41a:: with SMTP id k26mr31029189wmi.85.1589280142295;
        Tue, 12 May 2020 03:42:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 81sm14320045wme.16.2020.05.12.03.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 03:42:21 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: fix potential fastrpc_invoke_ctx leak
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20200511162927.2843-1-srinivas.kandagatla@linaro.org>
 <20200512011810.GB57962@builder.lan>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da155fca-98b9-f65e-1683-314a132a8255@linaro.org>
Date:   Tue, 12 May 2020 11:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200512011810.GB57962@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2020 02:18, Bjorn Andersson wrote:
> On Mon 11 May 09:29 PDT 2020, Srinivas Kandagatla wrote:
> 
>> fastrpc_invoke_ctx can have refcount of 2 in error path where
>> rpmsg_send() fails to send invoke message. decrement the refcount
>> properly in the error path to fix this leak.
>>
>> This also fixes below static checker warning:
>>
>> drivers/misc/fastrpc.c:990 fastrpc_internal_invoke()
>> warn: 'ctx->refcount.refcount.ref.counter' not decremented on lines: 990.
>>
>> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context")
>> Reported-by: Dan Carpenter<dan.carpenter@oracle.com>
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/misc/fastrpc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 9065d3e71ff7..07065728e39f 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -949,8 +949,10 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>>   	dma_wmb();
>>   	/* Send invoke buffer to remote dsp */
>>   	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
>> -	if (err)
>> +	if (err) {
>> +		fastrpc_context_put(ctx);
> So we refcount ctx once for the invoke function and once between send
> and callback. And this fastrpc_context_put() would counter the fact that
> rpmsg_send() failed, so we will not get the "remote's" put().
> 
> I think that if you moved this call inside fastrpc_invoke_send() it's
> relationship to the failing rpmsg_send() would be obvious.

That works as well, and sounds much cleaner!


thanks,
srini

> 
> Regards,
