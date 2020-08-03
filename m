Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89829C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A83206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qcj5wBRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHCF1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgHCF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:27:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2067C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 22:27:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k20so14231887wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=69cyjrW66mX1zu+gVhNvv/8lhHh7361866nLFNhNGiI=;
        b=qcj5wBRRvKjFo6kVtZzpSdLkRSM+ierYoIfz7ZKWT+UWsytwpSW25SAlXu1Y8YDwZM
         JIF/EyeAc2vfXf4esNGTDRCsW0lhMZFEUeEmSZPCPfAoC7P9rsQjpVPEwSb8Mki0n8QB
         BRXU9dxzyvt/OMM+SpPod21DP2kFQv/YLL6UCPARe5yHrXdJ3DnFjEvWyLTC6Fr7LjdU
         ZQofX8GyQHPS6FHKX8maBMg+oJ7TzMIldpgWG4GyXYC8m+o4Gq34zXURZZQ7A7epHjfl
         ENrxTq395lDUn3jA0JJspqQrS+zWDXJBjfXGQBj+CYRzujPFJyUbIAlxIWqPEYy97RzX
         DBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69cyjrW66mX1zu+gVhNvv/8lhHh7361866nLFNhNGiI=;
        b=FDkcRn7PgSLtixZr5Vq3zJB0KoAwY4MnozYSNPbopJCRuO+YF4zkPX3Rntm3dH5XJD
         mvDQowfY+zeVRq4s82XWkaMHkSjiOEiuSwQ+A35tkRwpFgHKMA+2SLjVkK+2UthWodI4
         8NBBLMWadTIYJo+k0QGv1eWgxTAkQ/VFNo8y1vRzB3szEcpbxGhS2mWK1hCvJMJ7RHBg
         yM4040rfqvkSJi+dOR6Bcz0UK7yKxRbCcUghHSCkAQxlUXMDMRKZyYGkjYXp89nUqXdI
         H4VI+PoFl35jezZevTnA1KAvdw1QURNyYTuEJdsvb1OPAHrawgdyHX7ZikjRVB4HMHX/
         uwLA==
X-Gm-Message-State: AOAM531qGej6a/52cDzmVmB0FA/29ACvhDZzAN4heD9Ktiuh+/zCCqpz
        SrABbvzzEXfMlc6PSjhAxUc=
X-Google-Smtp-Source: ABdhPJzM6tZWf6BWLb2Asf2dXWIcOR53Z94QP6ekhDPyGdKdXRWQBjBY6Y3y4sJ2d5pPO3afg9qxkQ==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr3163640wmb.5.1596432451691;
        Sun, 02 Aug 2020 22:27:31 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id x204sm34200548wmg.2.2020.08.02.22.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:27:31 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <7c3f6a03f8cc4cb1ac69ec7322fba3d3@realtek.com>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <96b1fe92-4199-1c9a-523e-58bdd2d3a9db@googlemail.com>
Date:   Mon, 3 Aug 2020 06:27:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <7c3f6a03f8cc4cb1ac69ec7322fba3d3@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ricky

On 03/08/2020 04:01, 吳昊澄 Ricky wrote:
> Hi Chris，
> 
> We don’t think this is our bug...
> This register(FPDCTL) write to OC_POWER_DOWN is for our power saving feature, not to disable the reader
> In your case, we cannot reproduce this on our side that we mention before, we don’t have the platform(Intel NUC Tall Arches Canyon NUC6CAYH Celeron J345) to see this issue
> But we think this issue maybe only on this platform, our RTS5229 works well on the new kernel all platform that we have  
> 
> Ricky    

Perhaps I should have used the word regression rather than bug. I didn't buy the machine until earlier this year, but
other people who have reported this problem have indicated that until bede03a579b3 was applied (during the 5.1 merge
window), the driver supported the card reader on this on the Intel NUC boxes. I know that is true because I built and
tested a 5.0 kernel and the card reader worked fine. I've also built and tested an 5.1-rc1 kernel and the card reader no
longer works. Whether by design or by accident, the card reader worked and now it doesn't. That's a regression in my book!

Since you signed off the patch that caused the regression, I believe it is your bug.

Thanks.

Chris
> 
>> -----Original Message-----
>> From: Chris Clayton [mailto:chris2553@googlemail.com]
>> Sent: Monday, August 03, 2020 3:59 AM
>> To: LKML; 吳昊澄 Ricky; gregkh@linuxfoundation.org; rdunlap@infradead.org;
>> philquadra@gmail.com; Arnd Bergmann
>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>> Intel NUC boxes
>>
>> Sorry, I should have said that the patch is against 5.7.12. It applies to upstream,
>> but with offsets.
>>
>> On 02/08/2020 20:48, Chris Clayton wrote:
>>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card
>> reader on my Intel NUC6CAYH box.
>>>
>>> The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp()
>> was added to rtsx_pci_init_hw().
>>> At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in
>> rtsx_pci_init_ocp() the cardreader
>>> gets disabled.
>>>
>>> I've avoided this by making excution code that results in the reader being
>> disabled conditional on the device
>>> not being an RTS5229. Of course, other rtsxxx card readers may also be
>> disabled by this bug. I don't have the
>>> knowledge to address that, so I'll leave to the driver maintainers.
>>>
>>> The patch to avoid the bug is attached.
>>>
>>> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a
>> rts5260")
>>> Link: https://marc.info/?l=linux-kernel&m=159105912832257
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
>>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
>>>
>>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express card
>> reader on my Intel NUC6CAYH box.
>>>
>>> The bug is in drivers/misc/cardreader/rtsx_pcr.c. A call to rtsx_pci_init_ocp()
>> was added to rtsx_pci_init_hw().
>>> At the call point, pcr->ops->init_ocp is NULL and pcr->option.ocp_en is 0, so in
>> rtsx_pci_init_ocp() the cardreader
>>> gets disabled.
>>>
>>> I've avoided this by making excution code that results in the reader being
>> disabled conditional on the device
>>> not being an RTS5229. Of course, other rtsxxx card readers may also be
>> disabled by this bug. I don't have the
>>> knowledge to address that, so I'll leave to the driver maintainers.
>>>
>>> The patch to avoid the bug is attached.
>>>
>>> Chris
>>>
>>
>> ------Please consider the environment before printing this e-mail.
