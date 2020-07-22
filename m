Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3C207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gug+wemw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgGVQz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:55:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3BC0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:55:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so2601458wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/L5P6Wi4l5w5E61NWRVDyen6nCeOgGhib6kkyx3xg4=;
        b=Gug+wemwkv5z2RLWjjalbOFEuEkFtC0ykSLnBs/RB/j5fl8oDtHwbf+UvDFuur5oO2
         iOxEehek0b8oyIZ2hfEEuDtjBhX/77LZob3QNQQLJDNbWXwOq6ZB5E/tOFChQdPhYn/x
         md2N62uo++EmN2+MfnhZRE3dhfxo1FTGCuV6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/L5P6Wi4l5w5E61NWRVDyen6nCeOgGhib6kkyx3xg4=;
        b=A0fxsiJ3RVj7XsjD+EB1loHOWJjRzjGnTJYsnRsPkuIqmoCII//G90v8zxT7NhrjwP
         uYow7LTzfbGjQG6dAtCBEGvWU/eLCocILuE6QrXzcQsSXobK5psI7VY2IPIfeJO9y05R
         K+SkLhCgXrOnfqls7214PQx6nstvCMkQCnWjzCzN/CNGUmTyRCt+aQFwqMcyCAWvUbdh
         QEGQv8VhvYQj9bEQUolQQjUxHIx0C7xVAUvs1HdoEpbXDY83DN6xNVSmr9U3hDNhaznt
         lJNNv1bXOdsM5LNPD1IQypZyyOXZrdW1ikjqWuNq/c2jgui5n2fjIIqfMMfLQ1nVrDYY
         DqZQ==
X-Gm-Message-State: AOAM532bzwEmyKCOBl57LqI6LFa/ZpAsQlaC7m4yozmWnDRQ2r5tum7n
        Owixgrou98XXjeDrO1yCntJMig==
X-Google-Smtp-Source: ABdhPJwhuP7o3LsaaCn1Ff99xaHdCwRo78eNMDryKf/WrKKuGYq+hmYdzoXUSDl/VoQeJyZLAkOkSg==
X-Received: by 2002:adf:fd4e:: with SMTP id h14mr434451wrs.251.1595436923597;
        Wed, 22 Jul 2020 09:55:23 -0700 (PDT)
Received: from [10.136.8.242] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j8sm565902wrd.85.2020.07.22.09.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:55:22 -0700 (PDT)
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <1595115599-100054-1-git-send-email-dphadke@linux.microsoft.com>
 <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com>
 <20200722104128.GK1030@ninjato>
 <5048cf44-e2c2-ee31-a9fb-b823f16c2c7d@broadcom.com>
Message-ID: <0995d57c-890c-cdd3-7ddf-ece6bc454528@broadcom.com>
Date:   Wed, 22 Jul 2020 09:55:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5048cf44-e2c2-ee31-a9fb-b823f16c2c7d@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/2020 8:51 AM, Ray Jui wrote:
> 
> On 7/22/2020 3:41 AM, Wolfram Sang wrote:
>>
>>>> +	synchronize_irq(iproc_i2c->irq);
>>>
>>> If one takes a look at the I2C slave ISR routine, there are places where
>>> IRQ can be re-enabled in the ISR itself. What happens after we mask all
>>> slave interrupt and when 'synchronize_irq' is called, which I suppose is
>>> meant to wait for inflight interrupt to finish where there's a chance
>>> the interrupt can be re-enable again? How is one supposed to deal with that?
>>
>> I encountered the same problem with the i2c-rcar driver before I left
>> for my holidays.
>>
> 
> I think the following sequence needs to be implemented to make this
> safe, i.e., after 'synchronize_irq', no further slave interrupt will be
> fired.
> 
> In 'bcm_iproc_i2c_unreg_slave':
> 
> 1. Set an atomic variable 'unreg_slave' (I'm bad in names so please come
> up with a better name than this)
> 
> 2. Disable all slave interrupts

Actually, thinking about it more, 1. and 2. here need to be an atomic
operation so it needs to be wrapped by a spin lock/unlock (and it is
safe to do so here before calling synchronize_irq below).

Same applies to the two read-modify-write sequneces to enable some of
the slave interrupts in the 'bcm_iproc_i2c_slave_isr' routine.

> 
> 3. synchronize_irq
> 
> 4. Set slave to NULL
> 
> 5. Erase slave addresses
> 
> In the ISR routine, it should always check against 'unreg_slave' before
> enabling any slave interrupt. If 'unreg_slave' is set, no slave
> interrupt should be re-enabled from within the ISR.
> 
> I think the above sequence can ensure no further slave interrupt after
> 'synchronize_irq'. I suggested using an atomic variable instead of
> variable + spinlock due to the way how sync irq works, i.e., "If you use
> this function while holding a resource the IRQ handler may need you will
> deadlock.".
> 
> Thanks,
> 
> Ray
> 
>>>> +	iproc_i2c->slave = NULL;
>>>> +
>>>>  	/* Erase the slave address programmed */
>>>>  	tmp = iproc_i2c_rd_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET);
>>>>  	tmp &= ~BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
>>>>
