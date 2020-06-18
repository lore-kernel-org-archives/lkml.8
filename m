Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1581021D81
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="fajwe68D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgFRG57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgFRG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:57:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24677C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:57:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so4833175wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjj1nJScgeETVB1sGHCvwVl4garCuwqOg+nannMyhR0=;
        b=fajwe68DPCqqm1PlI2LvucOr4yFPHF9ov4K/5S8xakCxmEQuVpW+maNukQiC8xz+V2
         unIfnlpTNlLqUGe+F/vaaciKLp6Q5V1h9e5vX5UqSt0clfLBN3vL+/nMtsdDAoDBh+xv
         m+/RTTP2nbptgnTsciN+p3NYyffT4qORr78gHzQPFH1cA2VMuAalzzZt2KkdBSuirMnj
         nBt6V+VU19Pv9kF6RlG76T8eMQM2uk8WvrWwtgevtDZb09oYp982X04k7+J/8+ZD0L5O
         PGX5ThO7dJy1C94hyfkDRBLAFA4cxKEIGwpvi0aFv61ElCFU9pGsuP8VXwyJznblsyd8
         xu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjj1nJScgeETVB1sGHCvwVl4garCuwqOg+nannMyhR0=;
        b=PiWFpowcvE7bHMweCUxAW/n7WeHpFobdY2e5XiTy677kPjj/XpTyIGEia2dKU47eEG
         3rM5w115fcZnOX+O+5LeccZL5wiIy5H3ig3bsdfmSY2zfghDZyHGdzA88MIIqAeqGtwu
         +MmcZRxqlKNmjMu+zaDaOslfC2DWP01c8lUz9mD17eJKF3y6hx8PmkMRpYQMqaSNmhwi
         fg4jf4wXFeGkoGc9mbtM0npXchdiPQGR7vKCwrEJOM+NPl5nPxYXB6IIKUu9Ph90Mf+3
         bjQr3ViQBZg7ICKMwo7yHnrw3UnsWP1jWFSp5s2Ap4MmJS0OMPa2EF1LPaSidsgCR7ht
         07eg==
X-Gm-Message-State: AOAM531/SkcGFEvCgulIPP3LiK6IKoWlfDyF0jtN7df+iT/cs3hzXKjS
        pUqhYHmLl8Wnndp9rsrc4Foljg==
X-Google-Smtp-Source: ABdhPJw79suYDvUm3Xs8K1QYbjnNDzDmpAY+39aoPvuYtWhJr72UeIpXQMKeJVlzZl77onkFfrcfug==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr3148610wru.117.1592463473721;
        Wed, 17 Jun 2020 23:57:53 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:98f8:245a:88c9:f6f4? ([2a01:e0a:3cb:7bb0:98f8:245a:88c9:f6f4])
        by smtp.gmail.com with ESMTPSA id o10sm2268375wrj.37.2020.06.17.23.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 23:57:52 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
 <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <6b67cd00-a302-55a1-1e56-d1f1e7a06cef@forissier.org>
Date:   Thu, 18 Jun 2020 08:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/20 6:59 AM, Sumit Garg wrote:
> Hi Jerome,
> 
> On Wed, 17 Jun 2020 at 20:46, Jerome Forissier <jerome@forissier.org> wrote:
>>
>>
>>
>> On 6/17/20 3:58 PM, Sumit Garg wrote:
>>> Hi Maxim,
>>>
>>> On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>>>
>>>> With the evolving use-cases for TEE bus, now it's required to support
>>>> multi-stage enumeration process. But using a simple index doesn't
>>>> suffice this requirement and instead leads to duplicate sysfs entries.
>>>> So instead switch to use more informative device UUID for sysfs entry
>>>> like:
>>>> /sys/bus/tee/devices/optee-ta-<uuid>
>>>>
>>>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>>>>  MAINTAINERS                                       | 1 +
>>>>  drivers/tee/optee/device.c                        | 9 ++++++---
>>>>  3 files changed, 15 insertions(+), 3 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
>>>> new file mode 100644
>>>> index 000000000000..0ae04ae5374a
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
>>>> @@ -0,0 +1,8 @@
>>>> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
>>>> +Date:           May 2020
>>>> +KernelVersion   5.7
>>>> +Contact:        tee-dev@lists.linaro.org
>>>> +Description:
>>>> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
>>>> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
>>>> +               are free to create needed API under optee-ta-<uuid> directory.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index ecc0749810b0..6717afef2de3 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>>>>  M:     Jens Wiklander <jens.wiklander@linaro.org>
>>>>  L:     tee-dev@lists.linaro.org
>>>>  S:     Maintained
>>>> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
>>>>  F:     drivers/tee/optee/
>>>>
>>>>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>>>> index e3a148521ec1..23d264c8146e 100644
>>>> --- a/drivers/tee/optee/device.c
>>>> +++ b/drivers/tee/optee/device.c
>>>> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>>>> +static int optee_register_device(const uuid_t *device_uuid)
>>>>  {
>>>>         struct tee_client_device *optee_device = NULL;
>>>>         int rc;
>>>> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>>>>                 return -ENOMEM;
>>>>
>>>>         optee_device->dev.bus = &tee_bus_type;
>>>> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
>>>> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
>>>
>>> You should be using format specifier as: "%pUb" instead of "%pUl" as
>>> UUID representation for TAs is in big endian format. See below:
>>
>> Where does device_uuid come from? If it comes directly from OP-TEE, then
>> it should be a pointer to the following struct:
>>
>> typedef struct
>> {
>>         uint32_t timeLow;
>>         uint16_t timeMid;
>>         uint16_t timeHiAndVersion;
>>         uint8_t clockSeqAndNode[8];
>> } TEE_UUID;
>>
>> (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
>>
>> - The spec does not mandate any particular endianness and simply warns
>> about possible issues if secure and non-secure worlds differ in endianness.
>> - OP-TEE uses %pUl assuming that host order is little endian (that is
>> true for the Arm platforms that run OP-TEE currently). By the same logic
>> %pUl should be fine in the kernel.
>> - On the other hand, the UUID in a Trusted App header is always encoded
>> big endian by the Python script that signs and optionally encrypts the
>> TA. This should not have any visible impact on UUIDs exchanged between
>> the secure and non-secure world though.
>>
>> So I am wondering why you had to use %pUb. There must be some
>> inconsistency somewhere :-/
> 
> Yes there is. Linux stores UUID in big endian format (16 byte octets)
> and OP-TEE stores UUID in little endian format (in form of struct you
> referenced above).
> 
> And format conversion APIs [1] in OP-TEE OS are used while passing
> UUID among Linux and OP-TEE.
> 
> So we need to use %pUb in case of Linux and %pUl in case of OP-TEE.
> 
> [1] https://github.com/OP-TEE/optee_os/blob/master/core/tee/uuid.c


Got it now. The TA enumeration function in OP-TEE performs  the
conversion here:
https://github.com/OP-TEE/optee_os/blob/3.9.0/core/pta/device.c#L34

Thanks for clarifying.

-- 
Jerome
