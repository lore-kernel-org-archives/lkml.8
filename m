Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D5C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67055206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzumF5ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgCKVtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:49:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729223AbgCKVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5i8d0/y4R6sMxndZYF3wHrGqGjDf4b+kE4cAWVwa8PA=;
        b=fzumF5evIu6CbGtVvBXdnjF2OtjYeWkCWg2x84bfT09CDlcE9OB0V8SoSIWCzGGZktWn8S
        I0vkeehuzEtiDkQw7WsbkpNtH/yU6xYa580RfiX4A44NbMAUz2yui5JkQZovUb/r20LYlR
        AHUD/0N7MmMScY1I5sodHe9wCZ0dP2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-HGbxLO8ZNougPtx8aZLWfg-1; Wed, 11 Mar 2020 17:49:16 -0400
X-MC-Unique: HGbxLO8ZNougPtx8aZLWfg-1
Received: by mail-wm1-f72.google.com with SMTP id r19so1400739wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5i8d0/y4R6sMxndZYF3wHrGqGjDf4b+kE4cAWVwa8PA=;
        b=BJEuARZqbNDp8T65eZPL3Zxbg8rurziE7FUys2cLOJRbRNHOs3RLFlqV49IEQubpHx
         fVeUyF2ta9xkTp6btT2LV5DiZ/zhaJc61+OHbiv8RnRTCqn+evZ15PdSCED3KVLv4GvW
         x581hzpkZqvJ7RYdqjvssX8s26Z5R8LSg6e8/OD/PmFgO2f9IFAM3EER2HO4FoCPl5kA
         GpYAhpU0PQWP+lnPd9Wi/D61KvZvpSAHEvoCZaooJ+n4jght9Fg82UIcEbXifYW771W/
         8caTZULnJwrxFzVaCsEyg4cN9JCMye4wbjVU5VhyQ98qrb+TsW1v6OSOIe0vkBPvQ3nC
         dENw==
X-Gm-Message-State: ANhLgQ1AXxPqmjrDoVrXg2rXHmkQvcsusb867oJ43R2nxJnuvw03e22C
        4EYHyRT9zRenJdPA67wHayrKoSyHBTNUoQXj6PK3gQ1E91fWHvrL/znPrNAxDq0faDO3GSDFtAq
        jB3pasYD4VOiKLCejhS6Hu/me
X-Received: by 2002:a7b:c202:: with SMTP id x2mr717096wmi.71.1583963354852;
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJh7ov//Fnzju2Fjoa56M5YkAUFuQ4/RNkG53NtiQYrS/m7+q0+QRUOVFSof+x/grazcfT+Q==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr717075wmi.71.1583963354591;
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id r23sm16627136wrr.93.2020.03.11.14.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <218eb262-011f-0739-8e74-9ca3ef793bb8@redhat.com>
Date:   Wed, 11 Mar 2020 22:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87fteek27x.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/11/20 10:31 PM, Thomas Gleixner wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>>> I just need to stare at the legacy PIC and the virt stuff.
>>>
>>>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>>>> somewhat a big change for that but it does solve some real issues...
>>>
>>> Yes. Let me stare at the couple of weird irqchips which might get
>>> surprised. I'll teach them not to do that :)
>>
>> I know that you are very busy, still I'm wondering is there any progress
>> on this ?
> 
> Bah. That fell through the cracks, but actually I looked at this due to
> the PCI-E AER wreckage. So yes, this is fine, but we want:
> 
>   https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
>   https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de
> 
> if we want to backport this to stable.

So far I have seen a few, but not a lot of devices which need this, so
I'm not 100% sure what to do here.

Do you consider this change safe / suitable for stable if those 2 patches
are backported and applied first?

Regards,

Hans

