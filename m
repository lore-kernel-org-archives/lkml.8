Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79747C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B63522482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug//8cVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGTOhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:37:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80353C061794;
        Mon, 20 Jul 2020 07:37:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so10364245pge.12;
        Mon, 20 Jul 2020 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thlrZiYvr8JeXWtXdyVQnMu4VcwRsFpjbSBErMNQJwA=;
        b=Ug//8cVZ9P5Xz3ZIa8wJmYkOMUvnaW1oJ5VjMTjtP2uho/FZQE/YuQGLjV6T5K3Kio
         +7VF272h3mHfhdeyt6oD1lu33vQr6lZb03vMMAmRlM8YxbbIaPckBESbh78yoWq0QPy9
         paW3hSYk2Sr61UFcplAukIibuemS594AGd7q+9PbcxQ0be7ZibZXdqNseuSKA+vensuY
         ODc9RDcEIySDR5QMT5PCfu4IxmSlrzZKe3aAmDGXvsaT2xp10nLgMmxlT4vvq9e+0yBH
         sSlrxWvRw4WpzIrGQORzP19IcS3wW7vi76d9RzTY1DSxws5zMLLzW65X5kU6PY7q5zAb
         IS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=thlrZiYvr8JeXWtXdyVQnMu4VcwRsFpjbSBErMNQJwA=;
        b=Fa2J0Zgdifj2PazE1RxwKqfDTymH+eA4dsln3xi/gijZouhPPMgfKxcifgv3wiKDrb
         tn8xexRuoupbAp2doW/PkBqVB4UUgAKvGVvjzhoIbrowhvcJoKEmBy5CbEvWFFSGR/VH
         A6HhVyQvcuFHFPC+jPZvIiJGElRXYUCJz/U8/71RpQ5HaM++P1Ph9WlMtvTpQUXtP7VC
         TfDZ4GekKaffZsHB9+SS9+EdbwZq+LcAKH1nELiqOgrqMAqthqopPQD+MDQrBDACu0HS
         TlH0LHk5/HKIn4Ej/I6KYr+4AH6V/+7amurrXb2yI/ClaZ5vrHr4pg+YBPlN+E8JIXVj
         k43w==
X-Gm-Message-State: AOAM5323d9tvPx4i/1PdXqFLHe+PYavhT7A9E7zoScj8OcdKasDMB3yx
        bTZtpxfgDu+Oorw7PVrbUg4=
X-Google-Smtp-Source: ABdhPJzY3OKnTx1t7xVftdPyAQPfW5TNftWQDvMpVORxFPvuG2USLQ3nr9Hsb7dZ2KYT+A6qD1w2yA==
X-Received: by 2002:aa7:8391:: with SMTP id u17mr21121180pfm.156.1595255822025;
        Mon, 20 Jul 2020 07:37:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3sm12552730pju.54.2020.07.20.07.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 07:37:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] fsi: occ: Add support for P10
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>, Rob Herring <robh+dt@kernel.org>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
 <20200501150833.5251-3-eajames@linux.ibm.com>
 <20200719221302.GA78557@roeck-us.net>
 <CACPK8XdzUcb922brKkD8iDPvr4CGdDZXhUPM=mtuHSMc2j0sog@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <df7cee27-ef84-d846-7b7b-1d5fdd4a5f25@roeck-us.net>
Date:   Mon, 20 Jul 2020 07:36:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XdzUcb922brKkD8iDPvr4CGdDZXhUPM=mtuHSMc2j0sog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 9:47 PM, Joel Stanley wrote:
> On Sun, 19 Jul 2020 at 22:13, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, May 01, 2020 at 10:08:32AM -0500, Eddie James wrote:
>>> The P10 OCC has a different SRAM address for the command and response
>>> buffers. In addition, the SBE commands to access the SRAM have changed
>>> format. Add versioning to the driver to handle these differences.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>
>> I don't recall seeing a maintainer Ack for this patch, nor any response
>> at all. I'd be happy to apply the patch through hwmon, but I would need
>> an Ack from a maintainer.
> 
> That would be great. I had one question before it goes in, but once
> Eddie has sorted that out it can go through your tree.
> 
>>
>> Thanks,
>> Guenter
>>
>>> ---
>>>  drivers/fsi/fsi-occ.c | 126 ++++++++++++++++++++++++++++++------------
>>>  1 file changed, 92 insertions(+), 34 deletions(-)
> 
>>> @@ -508,6 +557,7 @@ static int occ_probe(struct platform_device *pdev)
>>>       struct occ *occ;
>>>       struct platform_device *hwmon_dev;
>>>       struct device *dev = &pdev->dev;
>>> +     const void *md =  of_device_get_match_data(dev);
>>>       struct platform_device_info hwmon_dev_info = {
>>>               .parent = dev,
>>>               .name = "occ-hwmon",
>>> @@ -517,6 +567,7 @@ static int occ_probe(struct platform_device *pdev)
>>>       if (!occ)
>>>               return -ENOMEM;
>>>
>>> +     occ->version = (enum versions)md;
> 
> The 0day bot warns about this when bulding for 64 bit architectures.
> 
> How about you drop the match data and instead match on the compatible
> string to know which version to expect?
> 

That seems to be less desirable and defeat the purpose of of_device_get_match_data().
I have seen better solutions. Some options:

	version = (uintptr_t)of_device_get_match_data(dev);
	version = (unsigned long)of_device_get_match_data(dev);
	version = (enum versions)(uintptr_t)of_device_get_match_data(dev);

You don't otherwise use the "md" variable, so you might as well drop it.

Guenter

>>>       occ->dev = dev;
>>>       occ->sbefifo = dev->parent;
>>>       mutex_init(&occ->occ_lock);
>>> @@ -575,7 +626,14 @@ static int occ_remove(struct platform_device *pdev)
>>>  }
>>>
>>>  static const struct of_device_id occ_match[] = {
>>> -     { .compatible = "ibm,p9-occ" },
>>> +     {
>>> +             .compatible = "ibm,p9-occ",
>>> +             .data = (void *)occ_p9
>>> +     },
>>> +     {
>>> +             .compatible = "ibm,p10-occ",
>>> +             .data = (void *)occ_p10
>>> +     },
>>>       { },
>>>  };
>>>

