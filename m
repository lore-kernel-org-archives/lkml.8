Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7EEC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D51206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2yXsaWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCLMGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:06:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726669AbgCLMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584014771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSNpSvUKNp6/83m+odfBvo9SeOnVj+MqMyFuwojaVPk=;
        b=O2yXsaWwRD8HiRU0vj4NgFDQYwcuUARYsgHFUHnoYw02CrSfwaITk0e7TDDtm7IyNOIr0i
        FCw9thqyPlAAAArNiX3xzTmPPoK9Wf8bAos3QBsmm8P+pFIuhsI2yclNFgU85/1/Ni2v8x
        MGvcImHtllhKLV/r+fG0fArgKq9aPFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-xsa8WEcqPLSY8UBARSi1HA-1; Thu, 12 Mar 2020 08:06:06 -0400
X-MC-Unique: xsa8WEcqPLSY8UBARSi1HA-1
Received: by mail-wr1-f71.google.com with SMTP id j17so2514178wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 05:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSNpSvUKNp6/83m+odfBvo9SeOnVj+MqMyFuwojaVPk=;
        b=eo0QL1udmZwMVnL/Eke0Or/e6uZdzsJfx3xVHHr8KStMt6cnfb6WC9bEF6+nzS6I14
         KByqGeEbw3EFHTSjfrswGXutlOw/Cxw25Pcid6AvZulCm/Iz5ZKXGSqN+g+TMq4gcwqA
         o4cjkvdELtOZc3WBj36yobKhXWl9e9r/Qbkg7v0hf+exc/CGguE1twgNQ259fJ8A3Gsh
         eQYMA+jxYOpoeQXkf1LNAFOtJy+WxeIbFbyEECQhpH6AsANlHGwn8uYpdGVkUdK3FEpo
         /edKbQt2udhbTjt32+BtmicaTcT97VN/ztZUoj5TBIa9O6dwb0L7Xge5cPc3GHBAQH7s
         fxug==
X-Gm-Message-State: ANhLgQ2X29A5alqo2L10Fo+3qZx0dHlaROpul4AkZUbqhAhm4KxV2wc8
        UFfVah/unq+2/n197z/0Oh6aSE8NzAgMDWG5qVwOgOqoSmeO+SXv5AptXcXYKtdQSmRGExHbdWz
        YxJA38Yj4Hcq9fHNsqJqrmTiT
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr4516860wmt.60.1584014764913;
        Thu, 12 Mar 2020 05:06:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+HRWOgRlV2pNiPqlueoA4u8RAn38ejkM1ffrZr8wxJmwV3UnkER85ZZH0WJCOEzq7uqjitA==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr4516835wmt.60.1584014764673;
        Thu, 12 Mar 2020 05:06:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w4sm23445550wrl.12.2020.03.12.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 05:06:03 -0700 (PDT)
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
 <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
 <87fteek27x.fsf@nanos.tec.linutronix.de>
 <218eb262-011f-0739-8e74-9ca3ef793bb8@redhat.com>
 <87a74mk0gm.fsf@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9a7ebae2-fa65-4a85-5951-120f3543e5fb@redhat.com>
Date:   Thu, 12 Mar 2020 13:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a74mk0gm.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/11/20 11:09 PM, Thomas Gleixner wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>> On 3/11/20 10:31 PM, Thomas Gleixner wrote:
>>> Hans de Goede <hdegoede@redhat.com> writes:
>>>>> I just need to stare at the legacy PIC and the virt stuff.
>>>>>
>>>>>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>>>>>> somewhat a big change for that but it does solve some real issues...
>>>>>
>>>>> Yes. Let me stare at the couple of weird irqchips which might get
>>>>> surprised. I'll teach them not to do that :)
>>>>
>>>> I know that you are very busy, still I'm wondering is there any progress
>>>> on this ?
>>>
>>> Bah. That fell through the cracks, but actually I looked at this due to
>>> the PCI-E AER wreckage. So yes, this is fine, but we want:
>>>
>>>    https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
>>>    https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de
>>>
>>> if we want to backport this to stable.
>>
>> So far I have seen a few, but not a lot of devices which need this, so
>> I'm not 100% sure what to do here.
>>
>> Do you consider this change safe / suitable for stable if those 2 patches
>> are backported and applied first?
> 
> I think so. The two patches are on my list for backports anyway, but I
> wanted to give them some time to simmer.

OK, I'll submit this patch for stable then once your backports have landed.

Regards,

Hans

