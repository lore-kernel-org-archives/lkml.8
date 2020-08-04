Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711432075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NtPMZgXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHDIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgHDIut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:50:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:50:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p14so1921175wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ZcJP9tlcrLa5x4h1C/bOIZ/fSEfOKvm1WToVJD+VSA=;
        b=NtPMZgXbZfVJMTejbKLRZ0vN5MYf8LOukWY7RxFBgD3scEGI8tBTHAoaCsvP3DE/Sm
         IOYDy1hDRU7C0uUxjEzRcpoW/IxF1ja+ZOVFKHvpqYmumHNUKQ1z178sRRzGrJtWK0Bc
         TRL2Tpj7Q05COmQmWZa/HUM8LsrklhPkbFqlN3gssbLAWtIFhxtnf9vVL2J82cJ0G+CY
         BAN7r7+YTfjdcEcvwRMwmXFHWl0gy6AKFJzSIYSvpTF/4HXYVuRE8tTYCsTu4WdWfLvK
         V+nHiL3PBvEPf5ffMtkuUdywaW8AK2fvzVopVjIefNesj/xeIqRxSX6K0SpHVydv9Zs3
         Jisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ZcJP9tlcrLa5x4h1C/bOIZ/fSEfOKvm1WToVJD+VSA=;
        b=MmTTkDDI6e3zgG7oUfpLLFQtQiyFiDSLjzTb0Z42LIwwnogqaFN7HAxTdNjtKpfRbP
         6ehJIyxk18DOucLpAwQJZeOK+AtnEMnPAKhORI5BJtyoRKMJsWmWLtB5QyDRpDnvuQiy
         rThfSxuD0UCFGUytuI0/YBbYNBgo45uVjXBPfIPe4H3fkK7fcD0Sum3VRX6sdMJHQ1i8
         IbHV62ooaSxmDb0TMyO4bT3PGfBq3Ytt8Yg32S8EgO9hagSlXfi361QUiF+E+xlnziLU
         xjC24/Ke7XmPcVugnTJdE1OGbI8gJZiOX0XyuOxdEUKUQ0p540sHwO1Tph/W4EotX5yn
         oqFg==
X-Gm-Message-State: AOAM533UHpOTWtjOOD8MFJjuYijevTVrtGHOThuIWo3w+flHFZfF9pUS
        62LauYPQj02CUpzihvD/e5I=
X-Google-Smtp-Source: ABdhPJxYzSIsXp1kd7dXZ7jJ2jad04Z07RAKMcXJlFXwD9kayX+qxpgT7Pr4jN683ayBDXZzSvJxZw==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr2937757wmg.72.1596531047104;
        Tue, 04 Aug 2020 01:50:47 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id g7sm29636251wrv.82.2020.08.04.01.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 01:50:46 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
Date:   Tue, 4 Aug 2020 09:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2020 09:08, 吳昊澄 Ricky wrote:
>> -----Original Message-----
>> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
>> Sent: Tuesday, August 04, 2020 3:49 PM
>> To: 吳昊澄 Ricky
>> Cc: Chris Clayton; LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd
>> Bergmann
>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>> Intel NUC boxes
>>
>> On Tue, Aug 04, 2020 at 02:44:41AM +0000, 吳昊澄 Ricky wrote:
>>> Hi Chris,
>>>
>>> rtsx_pci_write_register(pcr, FPDTL, OC_POWER_DOWN, OC_POWER_DOWN);
>>> This register operation saved power under 1mA, so if do not care the 1mA
>> power we can have a patch to remove it, make compatible with NUC6
>>> We tested others our card reader that remove it, we did not see any side effect
>>>
>>> Hi Greg k-h,
>>>
>>> Do you have any comments?
>>
>> comments on what?  I don't know what you are responding to here, sorry.
>>
> Can we have a patch to kernel for NUC6? It may cause more power(1mA) but it will have more compatibility
> 

Ricky,

I don't understand why you want to completely remove the code that sets up the 1mA power saving. That code was there
even before your patch (bede03a579b3b4a036003c4862cc1baa4ddc351f), so I assume it benefits some of the Realtek card
readers. Before your patch however, rtsx_pci_init_ocp() was not called for the rts5229 reader, but the patch introduced
an unconditional call to that function into rtsx_pci_init_hw(), which is run for the rts5229. That is what now disables
the card reader.

Now, I don't know whether other cards are affected, although I don't recall seeing any reported as I searched the kernel
and ubuntu bugzillas for any analysis of the problem. I know this is not what the patch I sent does, but having thought
about it more, seems to me that the simplest fix is to skip the new call to rtsx_pci_init_ocp() if the reader is an rts5229.

If you agree, I can prepare a patch and send it to you. Whatever the solution is, it will also be needed in the stable
kernels later than 5.0.

Chris
>> greg k-h
>>
>> ------Please consider the environment before printing this e-mail.
