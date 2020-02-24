Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FCAC38BE1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B72080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="K9J9F9PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBXS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:59:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39006 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBXS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:59:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id n30so6768462lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWIogKdup7RNMEQuGw4ZK8XOOx0NelgD6LsQ23lIpno=;
        b=K9J9F9PV+48ev9LK8v98rsnmW179zWtfmyhq0RgD2gPng7rPjM11KvxdB0vwPZrecW
         0ZJF5dYneiH+au5KOHmBFw8QF4N1Iw0/mEd0A4jiiAmFWHtE10cFS2ov5YWqcR8A1iQI
         mwaMkZjCY275H3YMSHT1FGGlzaQMZq2r8t+H+r02QFlVgLD0bAdWKCSdlnHeb6+hJa/H
         bYm9F7ScwA5B9K38urOwf0g27uW+omFOWqIExTILY1vP7BE3BjaBkQhCHcByfQO8ous3
         BaL+XAofK48p2a7X4Q5zgSzweH+XZ1Skoi3bGvhmgg6p6RhDeI74kPpMFgXTm4l0GzvA
         07jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DWIogKdup7RNMEQuGw4ZK8XOOx0NelgD6LsQ23lIpno=;
        b=I5ErbWnHxFEra2FODv0/GKGNHUzHmKr9drTbsr7HklFQu0yintU6qeqLxAj2Jyiteh
         MmcyLGLo5yzGqlvJdjlYx+QPHM9P3ygFdne9ILkKY328h6Z3cmngTaAQEAKqnrVP+gc/
         i/HXYflvERT19nBTdf4KPt22q4F1sMGNBNEsYCZy8f9YhrizAq2QiGQaDS+tj2d08aV3
         zwjRnm/O9JOmsm67vnEGZ7Ez934i7i4xKGPewL86J8uKPkNM9zNz4xjKoX0SolvMop0i
         cekI0PuLMujKrLpwb84d7aqDD70ghn5DhgNbZXxd1aWUhDflruAqOynlQXQ6vRIqbJAx
         k+HQ==
X-Gm-Message-State: APjAAAUwq5udyPiCpEzzzkzdtCaWmfXgwXOkXbVw4VJY1o1yL0cs91Jt
        yLjZ/IIp/EWazkDBNKdRt4BVHg==
X-Google-Smtp-Source: APXvYqy0tBQh6NrjPUVDkFA+Xh7MQuqHB2EeKfbvVtje8TT1bP0hItq13fx2MA+evvjyvRSeln3ZBw==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr27518111lfc.130.1582570747459;
        Mon, 24 Feb 2020 10:59:07 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4845:f7d3:88db:d8d1:c530:4d4])
        by smtp.gmail.com with ESMTPSA id a3sm2281419lfo.70.2020.02.24.10.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:59:06 -0800 (PST)
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
To:     "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ec545462-54ed-9e23-049e-1807d24ec084@cogentembedded.com>
Date:   Mon, 24 Feb 2020 21:59:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/24/2020 08:46 AM, Behme Dirk (CM/ESO2) wrote:

>>>> Add the memory driver for Renesas RPC-IF which registers either SPI or
>>>> HyperFLash device depending on the contents of the device tree subnode.
>>>> It also provides the absract "back end" device APIs that can be used by
>>>> the "front end" SPI/MTD drivers to talk to the real hardware.
>>>>
>>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>>
>>> FYI, please find below [1] the changes I did locally on this driver. It seems to read & write successfully on my custom M3 (R8A7796) device, now.
>>
>>     Not for me...
>>     BTW, your patch had whitespace ruined, I had to apply it by hand, you'd better
>> attach the patches, not paste. :-/
> 
> 
> Ok. There are other mailing lists complaining about attachments ;)

   All Linux MLs prefer patches inline. :-)
   But you seem to paste the patches to the mail edited in some MUA (which does ruin
whitespace). Don't do that, it's better to just attach.

> Even better, maybe we should put what we have so far publicly anywhere, e.g. github.

  Cogent has an accout there, I'll try asking the management if it could also be used...

>>> Best regards
>>>
>>> Dirk
>>>
>>> [1]
>>>
>>>  From d72b805cc461ab1e9747c973e9be84e7abb8f828 Mon Sep 17 00:00:00 2001
>>> From: Dirk Behme <dirk.behme@de.bosch.com>
>>> Date: Tue, 4 Feb 2020 08:39:31 +0100
>>> Subject: [PATCH] memory: renesas-rpc-if: Correct the STRTIM and some other
>>>   clean up
>>>
>>> This is required to make the driver work correctly in my M3 environment.
>>>
>>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>>> ---
>>>   drivers/memory/renesas-rpc-if.c | 42 ++++++++++++++++++++-------------
>>>   1 file changed, 25 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
>>> index 04be92b64bfa..f4356b066384 100644
>>> --- a/drivers/memory/renesas-rpc-if.c
>>> +++ b/drivers/memory/renesas-rpc-if.c
>> [...]
>>> @@ -513,19 +525,15 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
>>>       pm_runtime_get_sync(rpc->dev);
>>>
>>>       regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
>>> -    regmap_write(rpc->regmap, RPCIF_DRCR,
>>> -             RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
>>> -    regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
>>> -    regmap_write(rpc->regmap, RPCIF_DREAR,
>>> -             RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
>>> -    regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
>>> -    regmap_write(rpc->regmap, RPCIF_DRENR,
>>> -             rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
>>> -    regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
>>> -    regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
>>
>>     The driver somehow works only with this left in place (with 2 bytes eaten
>> as before), otherwise all the flash reads all 0xff (via dirmap).
> 
> 
> Do you boot from hyperflash?

   No, I have arewto say 'cpld write 30 1' in U-Boot before a boot a kernel.
Normally, the V3x Starter Kit boards are wired for the QSPI flash chips.

> The system I'm using for testing boots from hyperflash. So most probably all registers
> I don't touch in the driver are put into a reasonable state by the boot code, already.
> If you don't boot from hyperflash, that at least would explain our different behavior.

   Yes. Mind dumping the registers and sending to me?

> Best regards
> 
> Dirk

MBR, Sergei
