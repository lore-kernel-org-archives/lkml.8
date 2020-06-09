Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA36C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505DA20760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAX1Ehqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgFIQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:59:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731276AbgFIQ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591721957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Nv/aSNOsUOuGhVJiOZj/3/GKlddqU08H1NN9MmEgDY=;
        b=jAX1Ehqww+m4Uw2yimEV0D3zi5RwS3VmQ9bBXDNnjhMt0Iyj/Ln+b5UAMjALma/7Kxysip
        CvKMkws4kQssgL3ERnl2v+wKKuHspU4VfQTwEMFNWQ7anpr++rAS4JF5W0TVhdJ9NmpTdv
        UT8M9U/QyMf7xyUaFxnXoJ0nt0Jinmk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-ifQm_XksOlaaMPX5_dvSDg-1; Tue, 09 Jun 2020 12:59:16 -0400
X-MC-Unique: ifQm_XksOlaaMPX5_dvSDg-1
Received: by mail-ed1-f72.google.com with SMTP id k17so8453735edo.20
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Nv/aSNOsUOuGhVJiOZj/3/GKlddqU08H1NN9MmEgDY=;
        b=WUiA/AXrQBBKkEbIsv1EHvOP71MC7JT2r5zhuG7JI+IqRkt1aLgysJu43VoWlliFyb
         gAL6kCJB/wJDqPdmdGIWv9SXGYkvC7Em1G95lt5LO6YseWGez5e7nN6deXNpeUlB8+HK
         gt7SGeJ35OIE9UjXOIETLOyN82kNIXVHmEkxIK+xzEfU34UJrozRFnqkjGrbB2McT4ej
         NS2huEDnslCuTkq0FXPlpTzJNp7n2sTUrvtENyDo2yAX+TtElILfqhOKuRr8LJ/pO15V
         FoFCg2PYcZvnvLzC4AZ9Q3EtCQ0N2z7qRtZlT4qveN0PwY+ZmxY6EXzwZPU8vRLM4HVA
         ZqbA==
X-Gm-Message-State: AOAM533YiTvYF9i6d4nvR5P3x6L1DLc+UHl90LVWfu5dVFY1EwEQC+Jk
        GyBk/pxH5V4wUfjmGKqlSU/Tpy0mGv5/g+Wsi+NgRUyjUw4VPzTr2bandyfkScW3CfnInf8vkk5
        83+oU0TrEKMM54rzlFfUfuJjw
X-Received: by 2002:a50:cccc:: with SMTP id b12mr27211511edj.68.1591721954915;
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuipLwjeopUoSVP0QNjhwtG56JmmHgFoTHfpbJSaHF3XASHeXXW/68XiqF4HC5kgK4xY5cKw==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr27211492edj.68.1591721954676;
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id s2sm13412514ejm.50.2020.06.09.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:59:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Mario.Limonciello@dell.com, y.linux@paritcher.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, mjg59@srcf.ucam.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <20200609154938.udo7mn7ka7z7pr6c@pali>
 <20200609164533.qtup47io2aoc5hgl@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <136a06e3-0f00-d252-ebdd-a76c8a575db8@redhat.com>
Date:   Tue, 9 Jun 2020 18:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609164533.qtup47io2aoc5hgl@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 6/9/20 6:45 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jun 09, 2020 at 05:49:38PM +0200, Pali Rohár wrote:
>> On Monday 08 June 2020 20:36:58 Mario.Limonciello@dell.com wrote:
>>> Can you please comment here how you would like to see events like this should come
>>> through to userspace?
>>>
>>> * Wrong power adapter (you have X and should have Y)
>>> * You have plugged a dock into the wrong port
>>> * Fn-lock mode
>>
>> In my opinion, Fn-lock mode is related to input subsystem and should be
>> probably reported via input device. For a user, fn-lock is similar like
>> caps-lock, scroll-lock or num-lock. Also fn-lock is provided by other
>> laptops and therefore I would expect that kernel provide fn-lock state
>> for all laptops (thinkpad / latitude / ...) via same interface. And not
>> via dell-specific interface or general-vendor-message interface.
>>
>> Wrong power adapter sounds like something related to power subsystem.
>> Adding Sebastian to the loop, maybe he can provide some useful ideas
>> about it.
> 
> I'm missing a bit of context. I suppose this is about connecting a
> non-genuine power adapter rejected by the embedded controller?
> Support for that should be hooked into 'drivers/acpi/ac.c' (note:
> so far there is no standard power-supply class property for this).
> Also printing a warning to dmesg seems sensible.

This is not so much about non-genuine as about the adapter having
the wrong wattage. E.g. plugging a 65W adapter in a laptop which
has a 45W CPU + a 35W discrete GPU will not allow the laptop to
really charge while it is in use.

One issue I see with doing this in the power_supply class is that
the charger is represented by the standard ACPI AC adapter stuff,
which does not have this info. This sort of extra info comes from
WMI. Now we could have the WMI driver register a second power_supply
device, but that means having 2 power_supply devices representing
the 1 AC adapter which does not feel right.

I was myself actually thinking more along the lines of adding a
new mechanism to the kernel where the kernel can send messages
to userspace (either with some special tag inside dmesg, or through
a new mechanism) indication that the message should be shown
as a notification (dialog/bubble/whatever) inside the UI.

This could be useful for this adapter case, but e.g. also for
pluging a thunderbolt device into a non thunderbolt capable
Type-C port, a superspeed USB device into a USB-2 only USB
port and probably other cases.

Rather then inventing separate userspace APIs for all these
cases having a general notification mechanism might be
quite useful for this (as long as the kernel does not
over use it).

Regards,

Hans

