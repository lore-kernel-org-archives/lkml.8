Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C883320768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbgFWLP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:15:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732245AbgFWLP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:15:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F9CAAEE6;
        Tue, 23 Jun 2020 11:15:24 +0000 (UTC)
Subject: Re: [PATCH v2 18/29] nvmem: Add Realtek DHC eFuse driver
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?B?U3RhbmxleSBDaGFuZyBb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-19-afaerber@suse.de>
 <4c137c33-bd46-2da0-01d0-5f52747be48a@linaro.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <e723322f-fecf-01a4-a4c0-825f074c6722@suse.de>
Date:   Tue, 23 Jun 2020 13:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4c137c33-bd46-2da0-01d0-5f52747be48a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

Am 23.06.20 um 11:32 schrieb Srinivas Kandagatla:
> On 23/06/2020 03:50, Andreas Färber wrote:
>> Implement enough of a read-only nvmem driver to easily read efuse cells.
>>
>> Cc: Cheng-Yu Lee <cylee12@realtek.com>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
> 
> This patch itself looks okay to me, I will apply this once DT patches 
> are Reviewed/applied by DT maintainers!

Thanks - let's give the Realtek engineers some time to review, too:

* Driver naming - new [rtk-]dhc (Stanley) vs. in-tree rtd1195 elsewhere.

* My other driver was previously reading u32-sized registers directly, 
whereas here I switched to byte-sized reads based on other in-tree nvmem 
drivers. Downstream driver seems inconsistent wrt .word_size:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/nvmem/rtk-efuse.c#L191

* RTD1619 (RTD1319, too?) may need special handling and therefore its 
own DT compatible: There's a magic OTP_CTRL register write downstream 
that I am lacking documentation w/ names&explanations and use case for.
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/drivers/nvmem/rtk-efuse.c#L216
That might obviously affect the binding, too, requiring oneOf - could be 
changed in a later step though.

I would take the .dts patches through my linux-realtek.git once the 
binding is approved.

* The downstream DTs have nvmem-cells and nvmem-cell-names properties in 
the efuse node directly, which I regarded as unnecessary from reading 
the consumer binding, placing those properties into the consuming node.

* Downstream DTs have more eFuse fields declared than the one I use in 
this series [1]; they are also inconsistent in prefixing them efuse_ vs. 
otp_; in the RTD1295 datasheet the block is called eFuse, so I used 
efuse_ for consistency. I have enforced the dashes convention for nodes,
as I didn't see the node name get used anywhere.

[1] https://patchwork.kernel.org/patch/11619643/

One more comment inline...

>>   v2: New
>>   MAINTAINERS                   |  1 +
>>   drivers/nvmem/Kconfig         |  9 ++++
>>   drivers/nvmem/Makefile        |  2 +
>>   drivers/nvmem/rtk-dhc-efuse.c | 86 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 98 insertions(+)
>>   create mode 100644 drivers/nvmem/rtk-dhc-efuse.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1d0d6ab20451..02117fbf0e57 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2312,6 +2312,7 @@ F:    
>> Documentation/devicetree/bindings/soc/realtek/
>>   F:    arch/arm/boot/dts/rtd*
>>   F:    arch/arm/mach-realtek/
>>   F:    arch/arm64/boot/dts/realtek/
>> +F:    drivers/nvmem/rtk-dhc-efuse.c
>>   F:    drivers/soc/realtek/
>>   ARM/RENESAS ARM64 ARCHITECTURE
[snip]

This line addition will conflict with the next line, added earlier in 
this patchset. Same for the binding patch. Do you need a v3 reordering 
them? This driver seems easier to target for 5.9 than the rest of the 
series.

If you do not intend to take the dt-bindings patch (17/29) through your 
tree, I can queue it once ack'ed by Rob and you.

Thanks for the quick review,

Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
