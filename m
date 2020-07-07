Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D79D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NvJeHCRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGGDdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGGDdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:33:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0867C061755;
        Mon,  6 Jul 2020 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vl6KXRcrocPNDZrmREX3V5N1vmHQHID4t2FGejDxCgc=; b=NvJeHCRqtpSeaNJDRjVwBsJm5Q
        jySkdyljWzRDEmZVioCs/H6AEKMxaiOXD+fPzH713D2kdSGRL9GEwxQO4whMc8GQN4U9QcQpR8sgj
        sRYmBbP/NwhbqzDKcT/GNcz90QAzYYy7OvOk7Ix8Tk0Lz3joEj8jtbMV0Z5x+Vl94YyWyKhI+qcZA
        uL2quRo7w3XZ7uODPl93BGahhMyReZQvgGlKqWLsmaKM+KDS/o524yiXG4doBLxpb4gvc3KLKnHI6
        z/iUTk0R9xoA7jlC8WNWcn2c1OxP29Ul8pltJoU45wTae4JIX6AqXvSLb7xObhCchW8WBdvMhVbGI
        alL5m0zA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jseLt-0003lY-1z; Tue, 07 Jul 2020 03:33:02 +0000
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
 <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
 <dd03ec1e-e511-4c13-4e12-a9f8ec407326@infradead.org>
 <1594092631.20820.4.camel@mtkswgap22>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb2eaab3-1ecc-d2c8-fc40-5bbe51ee31c4@infradead.org>
Date:   Mon, 6 Jul 2020 20:32:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594092631.20820.4.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/20 8:30 PM, Neal Liu wrote:
> Hi Randy,
> 
> Thanks for your review.
> 
> On Mon, 2020-07-06 at 09:13 -0700, Randy Dunlap wrote:
>> On 7/6/20 2:28 AM, Neal Liu wrote:
>>> diff --git a/drivers/soc/mediatek/devapc/Kconfig b/drivers/soc/mediatek/devapc/Kconfig
>>> new file mode 100644
>>> index 0000000..b0f7d0e
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/devapc/Kconfig
>>> @@ -0,0 +1,17 @@
>>> +config MTK_DEVAPC
>>> +	tristate "Mediatek Device APC Support"
>>> +	help
>>> +	  Device APC is a HW IP controlling internal device security.
>>
>> preferably:               s/HW/hardware/
>>
>>> +	  MediaTek bus frabric provides TrustZone security support and data
>>
>> 	               fabric
>>
>>> +	  protection to prevent slaves from being accessed by unexpected
>>> +	  bus masters.
>>> +	  Device APC prevents malicious access to internal devices.
>>> +
>>> +config DEVAPC_MT6779
>>> +	tristate "Mediatek MT6779 Device APC driver"
>>> +	select MTK_DEVAPC
>>> +	help
>>> +	  Say yes here to enable support Mediatek MT6779 Device APC driver.
>>
>> 	                         support for Mediatek
>>
>>> +	  This driver mainly used to handle the violation with 1 DEVAPC AO/PDs.
>>
>> 	  This driver is mainly used                           ^^^^^^^^^^^^^^^^
>>
>> 	                      What is that meaningless string of chars? ^^^^^^^
> 
> I did not see any meaningless string of chars from my original patch.
> Is there something wrong?

To someone who is reading the Kconfig help text but is unfamiliar with this device,
I would say that        "1 DEVAPC AO/PDs"                    is not helpful at all.

> [1] https://lkml.org/lkml/2020/7/6/168
> 
>>
>>> +	  The violation information are logged for further analysis or
>>
>> 	                            is
>>
>>> +	  countermeasures.
>>
>> thanks.
> 


thanks.
-- 
~Randy

