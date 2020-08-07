Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE175C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DD720748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="arPbKFhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHGQk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:40:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE98C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:40:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so2250403wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7MlPgb6G7MRWKetSxLBPIn4G5T6xBNw3EZ7AtQ9Ybwc=;
        b=arPbKFhxxyyboW1VBkC62G21qD3kowo3A8JmoTGQPfZ22/u6amzmKXjsRjlqgTwqiL
         uez3c5KPFX90oOIQK5z9X9s7bkUlWB0bTHO6MLOLeuMn1YRNQqN/h7rO8C4Q89zd+eIH
         6dWJ9kGtlZv7f7IUm+tw5eGtXP7vjE/WfgkrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MlPgb6G7MRWKetSxLBPIn4G5T6xBNw3EZ7AtQ9Ybwc=;
        b=SMxZ0wYPN7Un2Jpc37wba71/fLifPAHdBoRImmS11k5vjFNX+mzdJLXltfXGoPCcdt
         biCLhEWJikVrxzLpdrymXpEOc40b0mqwbKWh7Enmrhn9DqgeeL3P/ZasIKDOOOiej5Hl
         j0LPie4ztKhPe1Q7bqcyBW/6hX6H1iu7qv4DNkF5I/oDfBqsk4OgPDQYlM7Tl1nUW7yE
         +2Bga/oaj3lyMLt7LNDWodkmW9d4iQR/y+5dIN0bVhE+WC8NzRkqcPzdC6nxy/6igkEs
         vKtBobzomZAYq+mZUk86FNzXZKXK1ZE57ou2IebyTrBSW1vnt7EPkd4T5xFCWB6FOgpr
         Hndg==
X-Gm-Message-State: AOAM530jsFrhVLcQxq24LA6xyeSga5COjv+5GJ6W60lZu7PKBmJYL4RT
        cg8JDx2KLbeyAzHx5J0L4v8qog==
X-Google-Smtp-Source: ABdhPJxM/rARbNhKBESgK7EulY4/kSt9kA9NAL150pa7F2wfnfK4IBvCCdeGYpPL2rk8S+oVipwHgg==
X-Received: by 2002:adf:b602:: with SMTP id f2mr12258316wre.186.1596818426294;
        Fri, 07 Aug 2020 09:40:26 -0700 (PDT)
Received: from [10.230.0.249] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d21sm11018559wmd.41.2020.08.07.09.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 09:40:25 -0700 (PDT)
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
To:     Wolfram Sang <wsa@kernel.org>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <1595115599-100054-1-git-send-email-dphadke@linux.microsoft.com>
 <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com>
 <20200722104128.GK1030@ninjato>
 <5048cf44-e2c2-ee31-a9fb-b823f16c2c7d@broadcom.com>
 <20200725101815.GA1519@ninjato>
 <4cf12c92-889d-ffbf-f8de-c1e08cfb8ce9@broadcom.com>
 <20200727181346.GA1034@ninjato> <20200727202657.GA18997@ninjato>
 <f56b0f2c-f723-a4b6-8c03-4b397aaa375c@broadcom.com>
 <20200805091725.GI1229@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <574e1d63-cfe0-8e0b-1b45-f91ee9b3cb84@broadcom.com>
Date:   Fri, 7 Aug 2020 09:40:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805091725.GI1229@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rayagonda/Dhananjay,

On 8/5/2020 2:17 AM, Wolfram Sang wrote:
> On Mon, Jul 27, 2020 at 01:43:40PM -0700, Ray Jui wrote:
>>
>>
>> On 7/27/2020 1:26 PM, Wolfram Sang wrote:
>>> On Mon, Jul 27, 2020 at 08:13:46PM +0200, Wolfram Sang wrote:
>>>>
>>>>> Can you confirm that even if we have irq pending at the i2c IP core
>>>>> level, as long as we execute Step 2. below (to disable/mask all slave
>>>>> interrupts), after 'enable_irq' is called, we still will not receive any
>>>>> further i2c slave interrupt?
>>>>
>>>> This is HW dependant. From my tests with Renesas HW, this is not the
>>>> case. But the actual error case was impossible to trigger for me, so
>>>> far. I might try again later. But even in the worst case, I would only
>>>> get a "spurious interrupt" and not an NULL-ptr OOPS.
>>>
>>> Let me explain how I verified this:
>>>
>>> 0) add a debug print whenever the slave irq part is called
>>>
>>> 1) Put a 2 second delay after disable_irq() and before clearing
>>> interrupt enable register
>>>
>>> 2) unbind the slave driver in the background, triggering the 2s delay
>>>
>>> 3) during the delay, try to read from the to-be-unbound slave in the
>>>    foreground
>>>
>>> 4) ensure there is no prinout from the slave irq
>>>
>>> Worked fine for me with the Renesas R-Car I2C IP interface. As mentioned
>>> before, I couldn't trigger a bad case with my setup. So, I hope this new
>>> fix will work for Rayagonda's test case, too!
>>>
>>
>> Sure. I suggest Dhananjay gives the sequence you proposed here a try
>> (with delay added during the testing to widen the window to cover corner
>> cases). If it works, we can just go with your proposed sequence here.
> 
> Any progress yet?
> 

I don't know if Dhananjay is actively working on this or not.

Rayagonda, given that you have the I2C slave setup already, do you think
you can help to to test and above sequence from Wolfram (by using the
widened delay window as instructed)?

Thanks,

Ray
