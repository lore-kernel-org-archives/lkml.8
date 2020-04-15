Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95358206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0mSPiX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895822AbgDOJsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:48:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2895812AbgDOJs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586944105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ug9COLY/YhK3wDyJaFP4QjMwRSRIqTSu+CJpF4CbDvs=;
        b=W0mSPiX1HNkIxgOKDKczZcJy2D9DT9NCkLN/MiUqsMJ+nSnl7nXFbdfPEyUPkhzhrhYdvr
        RJ92i0sGhgYrdhVuMbA5U2bQkxDOdMGGvjUFzEq3JAP54BQAo/GBvizjJlpG9xXuH3biPQ
        ByY0Y44IhBQkaB7sQ4K/PlMU7GoRU3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-e6orq65aMvifBDWxV1LrQA-1; Wed, 15 Apr 2020 05:48:23 -0400
X-MC-Unique: e6orq65aMvifBDWxV1LrQA-1
Received: by mail-wm1-f69.google.com with SMTP id n127so4739811wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ug9COLY/YhK3wDyJaFP4QjMwRSRIqTSu+CJpF4CbDvs=;
        b=SHzWEJZsX2H/dGGJNQ7eXO8SSEJYFa/eB1b4lPYQQ3ptkgsWiKXieYxqFsErFnuxMb
         Lkd5Z8BDn9Xq34m8wTGIveJZ0BRuQtoYTiVLN2UVc13bSE3zO87Q9g9NqcDAVhdZsb3T
         MtEz036In3PYsI9DBnrxMwPaXo0SxPNwH7Gi//gAjv94quQGtuNzsbaVga5TB4FXl+zx
         PEfm7Ag1ODFrk6ikVGk5iL7mxX8VftBh4sUYheE7KYz0Mm/8A4dhgfbwNwwAXZOrbLd2
         BjMwLKkHCGYEkCyN9bAqZwFF6XtVsxT1QNFR9ZhWIH4F/2tRW+e1fp1OA6SVCQmj2Osf
         oDsQ==
X-Gm-Message-State: AGi0PubD5M8qjjlfGYx70XDkT5LhL8Y/ocV7zIhWBW88+Gjue+B1079v
        MvXuAFZNaktAcGvbh+ZAa5FlXxlnRRYrRBOLVO25sxgEcp0UMusTrTU69H61sNUc3Xvrq72Pev1
        6cwKV/93BXPHUYOpGbbLgeQ1Y
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr4291793wme.0.1586944102149;
        Wed, 15 Apr 2020 02:48:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypKUG80qfuOm5k54Q2sYK5dSgdmjv0kwB06qovoaM2PgbZClDJCAYTf/jozp54s3aKzh8FISyQ==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr4291777wme.0.1586944101909;
        Wed, 15 Apr 2020 02:48:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v21sm21528522wmj.8.2020.04.15.02.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 02:48:21 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: intel_int0002_vgpio: Only bind to the
 INT0002 dev when using s2idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        "5 . 3+" <stable@vger.kernel.org>
References: <20200414131953.131533-1-hdegoede@redhat.com>
 <4380034.KJPSqyn9gG@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a9c4b315-2784-fe59-1236-3e3bf391fd4c@redhat.com>
Date:   Wed, 15 Apr 2020 11:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4380034.KJPSqyn9gG@kreacher>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/15/20 11:45 AM, Rafael J. Wysocki wrote:
> On Tuesday, April 14, 2020 3:19:53 PM CEST Hans de Goede wrote:
>> Commit 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement
>> irq_set_wake on Bay Trail") stopped passing irq_set_wake requests on to
>> the parents IRQ because this was breaking suspend (causing immediate
>> wakeups) on an Asus E202SA.
>>
>> This workaround for this issue is mostly fine, on most Cherry Trail
>> devices where we need the INT0002 device for wakeups by e.g. USB kbds,
>> the parent IRQ is shared with the ACPI SCI and that is marked as wakeup
>> anyways.
>>
>> But not on all devices, specifically on a Medion Akoya E1239T there is
>> no SCI at all, and because the irq_set_wake request is not passed on to
>> the parent IRQ, wake up by the builtin USB kbd does not work here.
>>
>> So the workaround for the Asus E202SA immediate wake problem is causing
>> problems elsewhere; and in hindsight it is not the correct fix,
>> the Asus E202SA uses Airmont CPU cores, but this does not mean it is a
>> Cherry Trail based device, Brasswell uses Airmont CPU cores too and this
>> actually is a Braswell device.
>>
>> Most (all?) Braswell devices use classic S3 mode suspend rather then
>> s2idle suspend and in this case directly dealing with PME events as
>> the INT0002 driver does likely is not the best idea, so that this is
>> causing issues is not surprising.
>>
>> Replace the workaround of not passing irq_set_wake requests on to the
>> parents IRQ, by not binding to the INT0002 device when s2idle is not used.
>> This fixes USB kbd wakeups not working on some Cherry Trail devices,
>> while still avoiding mucking with the wakeup flags on the Asus E202SA
>> (and other Brasswell devices).
>>
>> Cc: Maxim Mikityanskiy <maxtram95@gmail.com>
>> Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
>> Fixes: 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement irq_set_wake on Bay Trail")
>> Tested-by: Maxim Mikityanskiy <maxtram95@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Rebase on top of 5.7-rc1
>> ---
>>   drivers/platform/x86/intel_int0002_vgpio.c | 18 +++++-------------
>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
>> index 289c6655d425..30806046b664 100644
>> --- a/drivers/platform/x86/intel_int0002_vgpio.c
>> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
>> @@ -143,21 +143,9 @@ static struct irq_chip int0002_byt_irqchip = {
>>   	.irq_set_wake		= int0002_irq_set_wake,
>>   };
>>   
>> -static struct irq_chip int0002_cht_irqchip = {
>> -	.name			= DRV_NAME,
>> -	.irq_ack		= int0002_irq_ack,
>> -	.irq_mask		= int0002_irq_mask,
>> -	.irq_unmask		= int0002_irq_unmask,
>> -	/*
>> -	 * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
>> -	 * and we don't want to mess with the ACPI SCI irq settings.
>> -	 */
>> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
>> -};
>> -
>>   static const struct x86_cpu_id int0002_cpu_ids[] = {
>>   	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&int0002_byt_irqchip),
>> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&int0002_cht_irqchip),
>> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&int0002_byt_irqchip),
>>   	{}
>>   };
>>   
>> @@ -181,6 +169,10 @@ static int int0002_probe(struct platform_device *pdev)
>>   	if (!cpu_id)
>>   		return -ENODEV;
>>   
>> +	/* We only need to directly deal with PMEs when using s2idle */
>> +	if (!pm_suspend_default_s2idle())
>> +		return -ENODEV;
>> +
> 
> What if the system supports s2idle which is not the default suspend option
> and then it is selected by user space (overriding the default)?

This driver only binds (the cpuid check still visible above) on Bay Trail
and Cherry Trail/Brasswell systems. AFAIK those never support both modes,
the laptop variants of these SoCs always use S3 and the tablet versions
always use s2idle.

Regards,

Hans

