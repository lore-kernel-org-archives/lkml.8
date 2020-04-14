Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B731BC38A29
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968CA20578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GITeOYGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbgDNI1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:27:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436781AbgDNI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586852798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b37d0Kofi4/XRxv8UfpXOdTiWurzTmejZQ30rVyez0k=;
        b=GITeOYGXVWfEV2rb6jI+04vdqL04akUPwXjlfwcmESqBE1WplUTIjMt6mOCWyvBzGgCrct
        uL99TxZNO8jooIJXRvEexJCx+ePQ6kEQtIBaKbnYxI/+2Xn6oyNaaN/LlFsx5XuErnk1Y0
        YuUD4Ycjeu8QdKXLAexOKPhTTkZhE3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Lbn6NtKjPSK6tEeoc02sAA-1; Tue, 14 Apr 2020 04:26:36 -0400
X-MC-Unique: Lbn6NtKjPSK6tEeoc02sAA-1
Received: by mail-wm1-f69.google.com with SMTP id f17so3477913wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b37d0Kofi4/XRxv8UfpXOdTiWurzTmejZQ30rVyez0k=;
        b=oTr4XT/meHcL0vCaCzMqce6pAEN4XZPIcJjvMTfmFNoPXkzwys6Fgc8JLYAQRsGLB/
         5L28COvsGxHAvFdur9qPz5ovNx+cR3tcoVblWnE27dm7TU4qVQvw9vaDg2I4v4SzL/BO
         rc2ksmhiOVErbPQEss4PmAmtE7EVB2r+errNB0U+yHXIGZe/3AYCXSLaulpu2xJw3VGx
         t4LMj6hi5Dyy1Olrp/FAdA6ppKZHNB/tSBjJY0dgDhLaxQSe0+tGaVvvgy7gQNBqSH9p
         lL3ptwNRGnVTl42FGNvFcbZxmzKud0N/TBVO9wSpYrH6XlQa8KoHxCgap7UvpCPwe8PL
         B77A==
X-Gm-Message-State: AGi0Pubberdf9/hxu0HpDSVki22nyCucQnZ8K0/XothTYEb6O4Vg0cz2
        yQioLc+Gb4QTc1LSiui0uVb6nNA2JME/e07Sk7pnD2ll37k9zX9vysjJ0uIhsaMEPTdjCZfb8ML
        Z0f5T4Tf5Un2IQ2q7wUJQb1VZ
X-Received: by 2002:a7b:c401:: with SMTP id k1mr21977055wmi.152.1586852795048;
        Tue, 14 Apr 2020 01:26:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLloBOUIuHphP4FqubsTTF9OSa00IedmMyDWrhWDWdhrct7ws2/aUFRcsoLOb+NPUJGjePVw==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr21976977wmi.152.1586852793854;
        Tue, 14 Apr 2020 01:26:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y7sm18913048wmb.43.2020.04.14.01.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 01:26:33 -0700 (PDT)
Subject: Re: [PATCH] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200412170412.324200-1-jarkko.sakkinen@linux.intel.com>
 <b909aaee-3fff-4dca-40f4-4c5348474426@redhat.com>
 <20200413180732.GA11147@linux.intel.com>
 <7df7f8bd-c65e-1435-7e82-b9f4ecd729de@redhat.com>
 <20200414071349.GA8403@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6684575-ce91-fe72-6035-11834a05cd54@redhat.com>
Date:   Tue, 14 Apr 2020 10:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414071349.GA8403@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/14/20 9:13 AM, Jarkko Sakkinen wrote:
> On Mon, Apr 13, 2020 at 08:11:15PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/13/20 8:07 PM, Jarkko Sakkinen wrote:
>>> On Mon, Apr 13, 2020 at 12:04:25PM +0200, Hans de Goede wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 4/12/20 7:04 PM, Jarkko Sakkinen wrote:
>>>>> Call devm_free_irq() if we have to revert to polling in order not to
>>>>> unnecessarily reserve the IRQ for the life-cycle of the driver.
>>>>>
>>>>> Cc: stable@vger.kernel.org # 4.5.x
>>>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>>>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>> ---
>>>>>     drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>>>>> index 27c6ca031e23..ae6868e7b696 100644
>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>>> @@ -1062,9 +1062,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>>>>     		if (irq) {
>>>>>     			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>>>>>     						 irq);
>>>>> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>>>>> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>>>>>     				dev_err(&chip->dev, FW_BUG
>>>>>     					"TPM interrupt not working, polling instead\n");
>>>>> +				devm_free_irq(chip->dev.parent, priv->irq,
>>>>> +					      chip);
>>>>> +			}
>>>>
>>>> My initial plan was actually to do something similar, but if the probe code
>>>> is actually ever fixed to work as intended again then this will lead to a
>>>> double free as then the IRQ-test path of tpm_tis_send() will have called
>>>> disable_interrupts() which already calls devm_free_irq().
>>>>
>>>> You could check for chip->irq != 0 here to avoid that.

Erm in case you haven't figured it out yet this should be priv->irq != 0, sorry.

>>>>
>>>> But it all is rather messy, which is why I went with the "#if 0" approach
>>>> in my patch.
>>>
>>> I think it is right way to fix it. It is a bug independent of the issue
>>> we are experiencing.
>>>
>>> However, what you are suggesting should be done in addition. Do you have
>>> a patch in place or do you want me to refine mine?
>>
>> I do not have a patch ready for this, if you can refine yours that would
>> be great.
> 
> Thanks! Just wanted to confirm.

And thank you for working on a (temporary?) fix for this.

Regards,

Hans

