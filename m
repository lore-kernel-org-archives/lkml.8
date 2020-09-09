Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B39C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C152166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuxVtlS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgIIQqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgIIQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:12:39 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101BC0617BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:43:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t18so1734725ilp.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wzRfPI8VPUjN9UUY3Djh37yv6ix7hIv2rZzunO2y6YU=;
        b=VuxVtlS7tRUJRgKbX6B92xD/alpWvZmwy0QcPUOJka6AklyudrnjCYnvg2MN7/kTiy
         Eju4t6MsQBRWUiI4HgKmZeQpgaai/AJ5utoqDQFRdzKfQpGVZaPd7ZP1KgM3eTFDoC/P
         RDFMHhmwOfjadPsROfab/T/wWDz2dV0gc2a7j9otYGEP+2oF7FuTpObi+EdOXb7ygJ5z
         /7NxrBiBFUArJ5Gahh9Cu/AyAV7VP8GekjGc7ggBO3prmthyyQmW+3DWjzzPsj192uXS
         Z37vsixhJz15sQGX+G08UZXWaUY05HdUGarpsm3V9oD0b6aPnpdcbv9eelRcR5c4FSQs
         EG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzRfPI8VPUjN9UUY3Djh37yv6ix7hIv2rZzunO2y6YU=;
        b=a8xaXKNWuXBHPzzx92bGBeCy34TsECSP8oOcOgD+cRjDetOtkM47qg8e/MXR5ewboC
         0FtEN88yxvPhfGAtZuleSTlZXzqGPn09+gXOGoR2dBncqOK7COk9ptqpZxi0QPK1c57I
         DKf/+xcdvbXHd4ucHQ006WkTAA2xF+WYDOzF4XPwC+lElVX46bBYvk5LiV1MUmpcUkJp
         rEKLX0zLR44aHcadlNkaapQ4OIhIls3WlPXPapMgbgpJ7Pliz2RuR2X+82JxIdlbaH04
         8D1FtzmJ4s/GwT2cSbZx5SeI8lfHn+hjUtkYBibee8F2oo8enpOXMTdDgUnld3Cy7PyV
         8fvQ==
X-Gm-Message-State: AOAM532lNBXt9WthPj2sB0cy3RXolwzRWNLqfpSH6n/nZdy2HUFSrUT+
        OxaRgWqczc3wgY6Tjj0UGSO/w1/wus4+Lw==
X-Google-Smtp-Source: ABdhPJwIGrbK4KyNTds5smWJJ4zAFhQ5IOHVVyhL0gObMVN3sTRsWG+b+dllHjOw03HyY0O4b+99fw==
X-Received: by 2002:a92:512:: with SMTP id q18mr3637460ile.196.1599659025914;
        Wed, 09 Sep 2020 06:43:45 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e28sm1437589ill.79.2020.09.09.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 06:43:45 -0700 (PDT)
Subject: Re: [PATCH net-next 1/5] net: ipa: use atomic exchange for suspend
 reference
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200909002127.21089-1-elder@linaro.org>
 <20200909002127.21089-2-elder@linaro.org>
 <20200908.202731.923992684489468023.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <bd61d3fb-44b7-9bc3-ccad-1101c5c34ebc@linaro.org>
Date:   Wed, 9 Sep 2020 08:43:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908.202731.923992684489468023.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 10:27 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Tue,  8 Sep 2020 19:21:23 -0500
> 
>> We take a single IPA clock reference to keep the clock running
>> until we get a system suspend operation.  When a system suspend
>> request arrives, we drop that reference, and if that's the last
>> reference (likely) we'll proceed with suspending endpoints and
>> disabling the IPA core clock and interconnects.
>>
>> In most places we simply set the reference count to 0 or 1
>> atomically.  Instead--primarily to catch coding errors--use an
>> atomic exchange to update the reference count value, and report
>> an error in the event the previous value was unexpected.
>>
>> In a few cases it's not hard to see that the error message should
>> never be reported.  Report them anyway, but add some excitement
>> to the message by ending it with an exclamation point.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> Please use refcount_t if you're wanting to validate things like
> this.

There is exactly one reference here; the "reference" is
essentially a Boolean flag.  So the value is always either
0 or 1.

I can use refcount_dec_if_one() for the 1->0 transition,
but I'm not sure how I can do the 0->1 transition with
refcount_t.  I admit I might be missing something.

Would you like me to add refcount_inc_if_zero()?

Otherwise would you prefer a different naming convention
to use for this Boolean "reference count"?

Thanks.

					-Alex

> 
> Thank you.
> 

