Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FDC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941F224697
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 16:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W08zDKBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgB2QaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:30:09 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35688 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgB2QaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:30:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so784585pjq.0;
        Sat, 29 Feb 2020 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzYPFcgLq98qx0Z9hEcgZDgTUNyNkA7Y3So+hkWUqj4=;
        b=W08zDKBWopWkisfBh9+8MXXzG4TFeqI3ap6x+j7OqODYer7ZMmk1nDE/PZkA2CwFFI
         2o3yk7In+hUvKLjDEY6R17lnn6TOq2su4w2xHVefsoz5Kj5MtbZwFltSF539Zi/4gHMp
         KVIpR0n/Zvd1wv0J2ztnxDlMGdmal1VSd+laRh/XsLILEuHNdM/1Mer0qUzQpx9uzXXM
         f343ATlqOpAg7yzwddzGu8lw7WVIMWv0Q10VGFj23QjPugII8fUhlORkuUw10ok5mMSr
         0XDrfLxwUt2oDMoHipCX6sZIEOeXHk2DLgrjzsATVb1DyPUE7ieX52LSLHdfSO78hm16
         LGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MzYPFcgLq98qx0Z9hEcgZDgTUNyNkA7Y3So+hkWUqj4=;
        b=jMoVDPModinwSUoE3eJtB9BtW4a8QVNYbZmoI1uh+xseZQeZ0eq3FZ/Nc+kfoRhy3r
         M7bqeUZCj8wo2bGZpDEuEaty8AR/j5Ss7R7XXqR8LhxJwoTsLCtGWy996kAxxmdDltNq
         H5giWsMw+VzC96JAwvydgzNU+4nobsU4lO9XELPR/92pMwAhC2nrWQmb58CITOci9cwq
         vhXrcIUthdiK+Hu9NRRtrQeJ6d39s1NBwXBJT4PEvp3hS0m+6hQdDSy5nDzzD8T6ZF6p
         pKi/yF+1eBwX3vX2svlfzxRF5v2VNjQui2EFcVSWMuF3Sn40EVzwgNlAwfq/Y50v0I0b
         DOoQ==
X-Gm-Message-State: APjAAAU2J8GCQ1O+QdIgoZHEqwJhCh3ZDZsJ0yPbEpEMzmwcHR1JTOZb
        Dxp+t2tgJMyLFj9Aa5/IgvXJLJbq
X-Google-Smtp-Source: APXvYqwH3/MvTsLJABz5hBjbxh/e6fy0ABMBgwcW3rBgOU4donrmGEli7Yr+5Uct4YenU6GT1ry+Uw==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr9813854pld.58.1582993807856;
        Sat, 29 Feb 2020 08:30:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm3512986pfg.12.2020.02.29.08.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 08:30:06 -0800 (PST)
Subject: Re: [PATCH] hwmon: (pmbus) Add support for 2nd Gen Renesas digital
 multiphase
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, adam.vaughn.xh@renesas.com,
        zaitsev@google.com
References: <20200228212349.GA1929@raspberrypi>
 <20200228225848.GA14676@roeck-us.net> <20200228235206.GA3468@raspberrypi>
 <1a456016-682a-2d53-767b-fe09784883ef@roeck-us.net>
 <20200229154839.GA8048@grant-ubuntu>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a174f532-0595-30b9-b9af-04e67bb9be20@roeck-us.net>
Date:   Sat, 29 Feb 2020 08:30:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200229154839.GA8048@grant-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/29/20 7:48 AM, Grant Peltier wrote:
> On Fri, Feb 28, 2020 at 05:55:44PM -0800, Guenter Roeck wrote:
>> On 2/28/20 3:52 PM, Grant Peltier wrote:
>>> Hi Guenter,
>>>
>>> Thank you for your expedient review. I will need to consult with my
>>> coworkers to determine a more appropriate driver name. In the meantime I
>>> will make the desired changes and I will also create a document for the
>>> driver, which I will submit as a linked but separate patch.
>>>
>>> With regard to the part numbers, this family of parts is currently in
>>> the process of being released and we have not yet published all of the
>>> corresponding datasheets. However, I have been assured that all of the
>>> parts listed are slated to have a datasheet published publicly in the near
>>> future.
>>>
>> That would be great.
>>
>> As for the driver name, I had a look into drivers/hwmon/pmbus/isl68137.c,
>> and I don't immediately see why the new chips would warrant a new driver.
>> The only differences seem to be that VMON is a new command, and of course
>> only the ISL68137 supports AVL. But then there is, for example, ISL68127,
>> which is again quite similar. The only other difference as far as I can
>> see is input voltage scaling, but that doesn't warrant a separate driver
>> (and, of course, I have no means to validate if input voltage scaling
>> is indeed different for all the new chips).
>>
>> Overall I would suggest to extend the isl68137 driver. I would also
>> suggest to not add separate tables for each of the rail configurations
>> but use the three-phase entry as starting point, copy it, and adjust its
>> values as needed.
>>
>> For the multi-phase chips, I question if reporting the input voltage
>> for each phase make sense. Is it really a different voltage ? For IIN
>> and PIN, the question is if the registers are indeed paged, since they
>> are not paged in the older chips.
>>
>> Guenter
> 
> The ISL68137 is part of the first generation of our digital multiphase
> parts which are all exclusively 2-rail (2-page) devices. There are a
> couple of reasons that we are opting for a new driver for the new
> generation of devices:
> 
> 1) Gen 2 has multiple rail configurations (1, 2, or 3) with different scaling
> parameters than Gen 1

That would only mean a single additional entry for the Gen1 devices.
This is not a valid argument for a separate driver, especially since
the difference in scaling only affects a single parameter as far as I
can see.

> 2) We are planning to support some of the non-generic PMBus functions of
> the Gen 2 devices using the debugfs interface.
> 
This is not a valid argument either. We have, for example, a single driver
for all Linear chips, even though they have quite some difference across
individual chips. The above can simply be solved by not instantiating
debugfs for Gen1 devices, and marking VMON as supported for Gen2 devices
only. If the Gen1 devices are all pretty much the same, you'd only need
a single additional table entry for those in the driver (if you insist
using a table).

For the debugfs functions, please keep in mind that those will have to be
documented in a way that lets people without access to datasheets
understand what they are for. We can't have cryptic debugfs functions
which, if misused, blow up the chip.

> I am currently working on point 2 and those features are not
> quite ready to be included in a patch set but we wanted to move forward
> with the hwmon functionality for now as that is useful on it's own.
> 
> Fair point on the global vs paged commands. I will modify the page
> functions so that global commands are only read from page 0.
> 

Also a fair point showing that not having the datasheet hurts. I see the same
problem with recent TI devices. In some cases I _know_ that a driver is buggy
or much less than perfect, because I have access to a datasheet through
my employer, but I can't talk about it because what I know is under NDA.
Then I end up spending a lot of time trying to find leaks that let me comment.
I am _not_ happy about this situation, not at all.

Please understand that I won't accept a driver adding support for a chip
if there is no public information available that the chip exists in the
first place. Imagine a situation where you are requesting to add support
for a chip, and that chip isn't mentioned anywhere, not even in a datasheet
I (hypothetically) may have access to through my employer. How would _you_
handle such a situation if you were in my place ?

You could of course send me all the datasheets under NDA to my work e-mail,
but that wouldn't really be much better since I still would not be able to
comment in public. On the other side, I'd have at least some confirmation
that those magic chips do indeed exist, so you might possibly want to
consider that.

Thanks,
Guenter
