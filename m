Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7DC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1701E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZSd0Tfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgDUNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:18:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgDUNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587475098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7gI8fb6o6LKlf8vISbpJtZJf7jBBUPaOiqBddbrn1E=;
        b=FZSd0Tfwup2GpS49a2qMUt9WRIQB+Ter7YwrwFMFhyka0Cj+K3XlbGxWZi3RaMLQpmUaRR
        lCv3CqXF/i6VK0/geW8MvxHprfm+RZQo3gloJn/BTwYoe+0ea5QKmgzd5HMVS31wTMmkp/
        dutgrvLanAB3785Zb6aVDC3mdOhbbUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-pjQK5lBZNTCmTKQv_1SJSQ-1; Tue, 21 Apr 2020 09:18:16 -0400
X-MC-Unique: pjQK5lBZNTCmTKQv_1SJSQ-1
Received: by mail-wr1-f71.google.com with SMTP id j16so7451948wrw.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7gI8fb6o6LKlf8vISbpJtZJf7jBBUPaOiqBddbrn1E=;
        b=q04oXpA3nBZBzv9gyXliZvNgg2kHdg8Zl9aHBYv5OOkq+/3dGO+DSls1mLsiPD/huH
         nV4I/rishsU00fffa7FS1STh/hKfxo2GA1IwThAVg0IJ2Bk5aa9fEw+TnNMXknCnGCya
         k8RtXonfmYOGTJt4DsQ0BnQy100k7mAf9EpWUKw1tLPHaz+S+8HGZRBex5QLQLKWN22n
         fiL2DmxmuOmrbflvmaou76l/EE9282UzNHEWQZz++4GDqx7pdbdQ66yNgIGPRH+D/efY
         aJyMRb9YhrWJ2kW9OGqFeoR60tNLpjX1+nLo0xdK450M2pi70cnS8ZJQSWXe0EZWSEKy
         oKSg==
X-Gm-Message-State: AGi0PuYam1dj+GxlaZPwfGFiDGdNU8bLPRFPeZshaTeM/79BN/mn6km6
        fLCG4EfGZS1x01fjj/fgxWyNLxD4Tx6tXcnQX011nPXB8gkqavyUWtqwKRtV/hmt3bpDDRFkLD4
        6chmIFsLZabquW7H5v6/HJiJ/
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr5179326wmy.13.1587475095509;
        Tue, 21 Apr 2020 06:18:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOo/12F9ol8UfBE3egEGUQetFBzPEkWc2rpUqQFmDVtIeQhiFoZGNO+C0Ad/Gn0F+CkJNmwQ==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr5179300wmy.13.1587475095124;
        Tue, 21 Apr 2020 06:18:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s30sm3800805wrb.67.2020.04.21.06.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 06:18:14 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: intel_int0002_vgpio: Only bind to the
 INT0002 dev when using s2idle
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        "5 . 3+" <stable@vger.kernel.org>
References: <20200414131953.131533-1-hdegoede@redhat.com>
 <4380034.KJPSqyn9gG@kreacher>
 <a9c4b315-2784-fe59-1236-3e3bf391fd4c@redhat.com>
 <15138701.54mejVaKjr@kreacher>
 <6e85613c-e129-831a-bbe8-9f0c4f9fadad@redhat.com>
Message-ID: <9683ad9e-5969-5f22-74cb-fed232437b35@redhat.com>
Date:   Tue, 21 Apr 2020 15:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6e85613c-e129-831a-bbe8-9f0c4f9fadad@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/16/20 11:00 AM, Hans de Goede wrote:
> Hi,
> 
> On 4/15/20 11:34 PM, Rafael J. Wysocki wrote:
>> On Wednesday, April 15, 2020 11:48:20 AM CEST Hans de Goede wrote:
>>> Hi,
>>>
>>> On 4/15/20 11:45 AM, Rafael J. Wysocki wrote:
>>>> On Tuesday, April 14, 2020 3:19:53 PM CEST Hans de Goede wrote:
>>>>> Commit 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement
>>>>> irq_set_wake on Bay Trail") stopped passing irq_set_wake requests on to
>>>>> the parents IRQ because this was breaking suspend (causing immediate
>>>>> wakeups) on an Asus E202SA.
>>>>>
>>>>> This workaround for this issue is mostly fine, on most Cherry Trail
>>>>> devices where we need the INT0002 device for wakeups by e.g. USB kbds,
>>>>> the parent IRQ is shared with the ACPI SCI and that is marked as wakeup
>>>>> anyways.
>>>>>
>>>>> But not on all devices, specifically on a Medion Akoya E1239T there is
>>>>> no SCI at all, and because the irq_set_wake request is not passed on to
>>>>> the parent IRQ, wake up by the builtin USB kbd does not work here.
>>>>>
>>>>> So the workaround for the Asus E202SA immediate wake problem is causing
>>>>> problems elsewhere; and in hindsight it is not the correct fix,
>>>>> the Asus E202SA uses Airmont CPU cores, but this does not mean it is a
>>>>> Cherry Trail based device, Brasswell uses Airmont CPU cores too and this
>>>>> actually is a Braswell device.
>>>>>
>>>>> Most (all?) Braswell devices use classic S3 mode suspend rather then
>>>>> s2idle suspend and in this case directly dealing with PME events as
>>>>> the INT0002 driver does likely is not the best idea, so that this is
>>>>> causing issues is not surprising.
>>>>>
>>>>> Replace the workaround of not passing irq_set_wake requests on to the
>>>>> parents IRQ, by not binding to the INT0002 device when s2idle is not used.
>>>>> This fixes USB kbd wakeups not working on some Cherry Trail devices,
>>>>> while still avoiding mucking with the wakeup flags on the Asus E202SA
>>>>> (and other Brasswell devices).
>>>>>
>>>>> Cc: Maxim Mikityanskiy <maxtram95@gmail.com>
>>>>> Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
>>>>> Fixes: 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement irq_set_wake on Bay Trail")
>>>>> Tested-by: Maxim Mikityanskiy <maxtram95@gmail.com>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Rebase on top of 5.7-rc1
>>>>> ---
>>>>>    drivers/platform/x86/intel_int0002_vgpio.c | 18 +++++-------------
>>>>>    1 file changed, 5 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
>>>>> index 289c6655d425..30806046b664 100644
>>>>> --- a/drivers/platform/x86/intel_int0002_vgpio.c
>>>>> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
>>>>> @@ -143,21 +143,9 @@ static struct irq_chip int0002_byt_irqchip = {
>>>>>        .irq_set_wake        = int0002_irq_set_wake,
>>>>>    };
>>>>> -static struct irq_chip int0002_cht_irqchip = {
>>>>> -    .name            = DRV_NAME,
>>>>> -    .irq_ack        = int0002_irq_ack,
>>>>> -    .irq_mask        = int0002_irq_mask,
>>>>> -    .irq_unmask        = int0002_irq_unmask,
>>>>> -    /*
>>>>> -     * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
>>>>> -     * and we don't want to mess with the ACPI SCI irq settings.
>>>>> -     */
>>>>> -    .flags            = IRQCHIP_SKIP_SET_WAKE,
>>>>> -};
>>>>> -
>>>>>    static const struct x86_cpu_id int0002_cpu_ids[] = {
>>>>>        X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,    &int0002_byt_irqchip),
>>>>> -    X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,    &int0002_cht_irqchip),
>>>>> +    X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,    &int0002_byt_irqchip),
>>>>>        {}
>>>>>    };
>>>>> @@ -181,6 +169,10 @@ static int int0002_probe(struct platform_device *pdev)
>>>>>        if (!cpu_id)
>>>>>            return -ENODEV;
>>>>> +    /* We only need to directly deal with PMEs when using s2idle */
>>>>> +    if (!pm_suspend_default_s2idle())
>>>>> +        return -ENODEV;
>>>>> +
>>>>
>>>> What if the system supports s2idle which is not the default suspend option
>>>> and then it is selected by user space (overriding the default)?
>>>
>>> This driver only binds (the cpuid check still visible above) on Bay Trail
>>> and Cherry Trail/Brasswell systems. AFAIK those never support both modes,
>>> the laptop variants of these SoCs always use S3 and the tablet versions
>>> always use s2idle.
>>
>> But this means that at least the laptop variants can use s2idle if users choose
>> that option.
> 
> I was under the impression that the laptop variants only supported S3,
> butyou are right they support both.
> 
> Still I believe that the intent of this patch is right as is. The
> laptop variants are much more like standard X86 devices then the
> tablet devices.
> 
> E.g. they use standard HDA for audio instead of ASoC, the always use
> the ACPI ac and battery drivers instead of needing native PMIC drivers,
> etc.  Basically the tablet variants are a lot more like SoCs from other
> (ARM) vendors, so they need some special handling.  I consider the
> (undocumented, lifted from android-x86) INT0002 / special manual poking
> of PMC GPE registers to also be part of the tablet variant special
> sauce.
> 
> My intent of the pm_suspend_default_s2idle() check really is to
> check for the tablet variant. As Maxim's regression on the laptop
> (aka normal x86 machine) variant has shown doing the manual
> poking there seems to be a bad idea.
> 
> So I guess I need to rewrite this patch to better match my original
> intent. Does anyone have any ideas how to check it we are dealing
> with the tablet variant ?  One option would be to see if s2idle
> is supported, while S3 is not supported. Rafael any idea how to
> neatly check for those conditions ?   Anyone else an idea to
> more directly check if we are running on a tablet version ?
> 
>> Switching over from S3 to s2idle and back needs to be supported.
> 
> Ack, but even for the laptop variant s2idle path I believe that
> letting the INT0002 driver bind and poke PMC GPE registers
> directly is a bad idea.

Ping? I'll happily rework this patch to replace the s2idle check
with an are we running on a tablet version of the SoC check,
but I could use some input on how exactly to detect that we
are running on a tablet version of the SoC.

Regards,

Hans

