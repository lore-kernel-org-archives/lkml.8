Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E71C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8C120724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mcWLWRYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbgFXOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:04:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45450 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404002AbgFXOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:04:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624140440euoutp01d05b0de32b4383c9c772e08281dbd48d~bf90aQ4eJ1776817768euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:04:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624140440euoutp01d05b0de32b4383c9c772e08281dbd48d~bf90aQ4eJ1776817768euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593007480;
        bh=WOy+RPiPwwhfLMb9wxRBCXOF+SWWGckgH40ukXnrCLk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mcWLWRYyD2TeyViAHyPWiIzImtdfw8ak3kUuFoODbbYwFiUEG81Grb9RhbQK7nh14
         67igGFOcF/Or4xL6weuVPnMQ11QEatwPVKffygOSHfmc4twpcZfADrDoup7bbYo/5W
         LFpHnpEvj1Fhk7/KuQ4hfM6s5i9Znkf+5CYtxBZo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624140440eucas1p287a46bbbf09f2311e960b75c1221c3ec~bf9zzfBnm2594025940eucas1p2U;
        Wed, 24 Jun 2020 14:04:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.71.06456.87D53FE5; Wed, 24
        Jun 2020 15:04:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624140439eucas1p2e33d560a30478fe601c77f40027ab7cc~bf9zZvCMC3115431154eucas1p22;
        Wed, 24 Jun 2020 14:04:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200624140439eusmtrp2295989dd560a00e6a25ba314f7dc95fc~bf9zY4rU82266722667eusmtrp25;
        Wed, 24 Jun 2020 14:04:39 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-30-5ef35d7863c7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.8A.06314.77D53FE5; Wed, 24
        Jun 2020 15:04:39 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624140438eusmtip1ee4a15968210e4d6a0247671d3fa5816~bf9yiZbXg1513515135eusmtip11;
        Wed, 24 Jun 2020 14:04:38 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 1/5] driver core: add probe_err log helper
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d8dda106-44f1-157f-14c1-9a19216abb8f@samsung.com>
Date:   Wed, 24 Jun 2020 16:04:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624132344.GA5980@pendragon.ideasonboard.com>
Content-Transfer-Encoding: 7bit
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7Ow5nn9PyxSLphFRCamRwoLAMoRP4ox/+yERr2UnFa1ua
        +qO0tHSlzGrqllp4QZnJ8lZppDXviuJtZhddFyGUzPKC3Vw5j5L/nvd5n/d7ngc+mpB/FbvS
        kbEXeWWsIpqhpOTjjp/9e5NC5kO9v02I2SlNK2JrCoxiVvthkmJHFmcp9lqpkWLNS1ME2/3F
        TLJZuWUStvbTqJgdbiqkWJP2OWKr28YlrCknmC1a0BJHHLjh0UGCmx3LkHCN+nEJdy9TJ+Zq
        DVkU16UZEnEtRQ8lnOVmp4irK7vC5dQbEPci+w7JzdduP2F/SnroHB8dmcgrvXzPSCMKxtOp
        +OnNST3dGpSKnjmqkR0N2Ad6CpZEaiSl5bgSQWmrWiIMCwiKJ8yUMMwjMAybResnNXlZpLCo
        QKBtzxXbFnI8i2C5mFUjmnbCHGR/TrHRzjgKujJeETY9ga0E1KnNq3oK74HluteUDcuwL0y1
        960akNgdPmRUSWx4Mw6BW5ZpQtA4QrdukrRhO3wYSofHVvUEdoMnM4WEgJ1h7GM6spkBLqJh
        7uokIaT2hzzDDyRgJ5jurJcIeBv8bby/1uwKWCrTCeE4E0HDo8a144Pwrv8XZWtGrKQ2NnkJ
        tB9UDSys0oAdYGzGUcjgALcf5xMCLYPM63JBvQMsfQ1rD7pA+cAipUGMfkMz/YY2+g1t9P99
        HyDSgFz4BFVMOK/aF8tf8lQpYlQJseGeYXExtWjlF/ZaO+eeosWhsyaEacTYyx69/x4qFysS
        VckxJgQ0wTjLjvb1hspl5xTJKbwy7rQyIZpXmdBWmmRcZPtLpkLkOFxxkY/i+Xheub4V0Xau
        qYgJ9U0paNG1Ndpnll4OC37pwRjPts6UtGqtPtamfHFqhe5ulXvApvPtby3Mzuy24675z/wC
        nZvTOlridV3HBvXe2SMBl/yDtRpr4pagBvvuN3G/39pN4J7m0UmfCr+D1c0jgRdo5YGQ3Z27
        yr3TttRIjZEen6KC9H+eFwafdPO4wZCqCMU+D0KpUvwDPYC0N4EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd3y2M9xBvufalq8nHCY0WLjjPWs
        FlMfPmGzuPL1PZtF8+L1bBZXv79ktjj55iqLRefEJewWmx5fY7W4vGsOm8WhqXsZLdYeuctu
        cagv2mLul6nMDnwel69dZPZ4f6OV3WPnrLvsHrM7ZrJ6bFrVyeZxYsIlJo/9c9ewe9zvPs7k
        sXlJvUffllWMHgd6J7N4fN4kF8ATpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJcx424LW8Er0YpTJycwNjDuFuxi5OSQEDCR2Ditk6WLkYtDSGAp
        o8Tqd1eZIRLiErvnv4WyhSX+XOtigyh6yyjxdGMDUxcjB4ewgIdE7/MqkBoRgWyJgxcOMIHU
        MAs0sEj8XrCEEaJhKpNE08T1jCBVbAKaEn8332QDsXkF7CReHj3LBGKzCKhKPGxdzQ5iiwrE
        SnQv/sEOUSMocXLmExYQm1PAXmLx5Rtg9cwCZhLzNj9khrDlJba/nQNli0jceNTCOIFRaBaS
        9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwPjfduzn5h2MlzYGH2IU
        4GBU4uHd8OBjnBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0
        OR+YmvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAuOML75edG
        iy0scy+6RStM7jpxg333PafWSl9v0/ie19tdckrOOhV1eL6xWtdnK2/iyd8l1clrWar2YdaT
        rD3zVvYe/9386IyEIk/tkyX8ETIr51b/OtSqauTOlGEovrEjZ7t33z0fqQ1/l3kJvLrEWsXp
        uel223azsisN/yQ5zpSoy6zYL6TEUpyRaKjFXFScCAATKFy9FQMAAA==
X-CMS-MailID: 20200624140439eucas1p2e33d560a30478fe601c77f40027ab7cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114135eucas1p26e2e4683d60cebdce7acd55177013992
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114135eucas1p26e2e4683d60cebdce7acd55177013992
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114135eucas1p26e2e4683d60cebdce7acd55177013992@eucas1p2.samsung.com>
        <20200624114127.3016-2-a.hajda@samsung.com>
        <20200624123140.GB1773782@kroah.com>
        <20200624132344.GA5980@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.06.2020 15:23, Laurent Pinchart wrote:
> On Wed, Jun 24, 2020 at 02:31:40PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jun 24, 2020 at 01:41:23PM +0200, Andrzej Hajda wrote:
>>> During probe every time driver gets resource it should usually check for error
>>> printk some message if it is not -EPROBE_DEFER and return the error. This
>>> pattern is simple but requires adding few lines after any resource acquisition
>>> code, as a result it is often omited or implemented only partially.
>>> probe_err helps to replace such code sequences with simple call, so code:
>>> 	if (err != -EPROBE_DEFER)
>>> 		dev_err(dev, ...);
>>> 	return err;
>>> becomes:
>>> 	return probe_err(dev, err, ...);
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> ---
>>>   drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>>>   include/linux/device.h |  3 +++
>>>   2 files changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index 67d39a90b45c..ee9da66bff1b 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -3953,6 +3953,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>>   
>>>   #endif
>>>   
>>> +/**
>>> + * probe_err - probe error check and log helper
>>> + * @dev: the pointer to the struct device
>>> + * @err: error value to test
>>> + * @fmt: printf-style format string
>>> + * @...: arguments as specified in the format string
>>> + *
>>> + * This helper implements common pattern present in probe functions for error
>>> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>>> + * It replaces code sequence:
>>> + * 	if (err != -EPROBE_DEFER)
>>> + * 		dev_err(dev, ...);
>>> + * 	return err;
>>> + * with
>>> + * 	return probe_err(dev, err, ...);
>>> + *
>>> + * Returns @err.
>>> + *
>>> + */
>>> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
>>> +{
>>> +	struct va_format vaf;
>>> +	va_list args;
>>> +
>>> +	if (err == -EPROBE_DEFER)
>>> +		return err;
>>> +
>>> +	va_start(args, fmt);
>>> +	vaf.fmt = fmt;
>>> +	vaf.va = &args;
>>> +
>>> +	dev_err(dev, "error %d: %pV", err, &vaf);
>>> +
>>> +	va_end(args);
>>> +
>>> +	return err;
>>> +}
>>> +EXPORT_SYMBOL_GPL(probe_err);
>> Please be specific in global symbols, how about "driver_probe_error()"?
> Or dev_err_probe() to match the existing dev_* functions ?


OK.


Regards

Andrzej


>
>> And merge the other patch into this one, as Raphael said, otherwise this
>> just looks odd to add something and then fix it up later.
