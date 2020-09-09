Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C562C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E921D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYOrQc3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgIIJyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:54:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE63C061573;
        Wed,  9 Sep 2020 02:54:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so2221398wrp.8;
        Wed, 09 Sep 2020 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YhVcwcb6Wgk1PCPZ8YCcZaGe5dXRg4SVb0CRjkFkgA=;
        b=nYOrQc3JozoKIR8lxuzT8bln2t+PdtuqzCCkyIdk/xjOMRc22tyJ1oUMUFGmeRPRix
         bCcR8TZBiiS4I0vJL4e3Bb1sDzBVEqafFMcW07KmUO2q8lwF3mJIqioT9pUzeURPWRkA
         bUAwKSbPfWtvAgG2jjldOHWh4Xrbbqxc3PTeZInVIBc2s8saMlxnsRGAm9Ir9V2PqSFO
         LXqZEBAs+6Fe0l48PKFQJcPlDn2pw+/hpa4xkC+jMGY6f4e6otRRS4RWA7mVULKmBuZT
         NefxPlUrmQOpwEGpS/qAq1ER4n614vXZRgS6K8oZV8O/b+aSyDk0ptRNp5ft76/4yF1I
         iMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YhVcwcb6Wgk1PCPZ8YCcZaGe5dXRg4SVb0CRjkFkgA=;
        b=ecvxNa5620JP8M3yfNZVUHfiGjn3QtIlEP6DOlrbmLb2kd8uTBgzdK4AWfM1dN6SDq
         Cg3N+mskg1uZWin0ZeedrtC1EBsKGMyYrTwq+Iespus/35Z5teCsHcstlhbRi+4jL8EL
         ZE1xqmioDIHhC1Xfp18f6CaK0UAVkCCeJ73dNTNFV5yoJrrX78N5tLrJs+FsGBZddyyR
         PCEi9C/s84EyuMO2CXh1M+L7vsn4nf8kksQR47btAXs4zd6WLOlFj+xS5Bj8mMOWj3sp
         UCtoJBRtGUjAb15s8YUEy+wxgN4VHPOIqNdnXvaeKT8G2Uzh6jVNEJP+2RagGMFJcTLY
         mWow==
X-Gm-Message-State: AOAM532mmJASm25NRo29DcwMoOJmnuj3lNVOws+RXntmrk1MApddDocq
        i/87/34a/ZjIjJDVXmseFVI=
X-Google-Smtp-Source: ABdhPJxv4K21NSQFaosgqbX77J5T+sjyZ/mqOq2NHXzwzUy5eaLztRepGwchvzhm/AWWCaZCdLX0Jg==
X-Received: by 2002:a5d:6343:: with SMTP id b3mr3178210wrw.179.1599645281761;
        Wed, 09 Sep 2020 02:54:41 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id u66sm3116098wmg.44.2020.09.09.02.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:54:41 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173-elm: fix supported values for
 regulator-allowed-modes of da9211
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     kernel@collabora.com, dafna3@gmail.com
References: <20200903142819.24487-1-dafna.hirschfeld@collabora.com>
 <5d504bea-0934-91a9-c052-e463ad6c6d95@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6b281668-3316-6b81-47b2-d17cc6348449@gmail.com>
Date:   Wed, 9 Sep 2020 11:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5d504bea-0934-91a9-c052-e463ad6c6d95@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2020 10:02, Enric Balletbo i Serra wrote:
> Hi Dafna,
> 
> Thank you to work on this.
> 
> On 3/9/20 16:28, Dafna Hirschfeld wrote:
>> According to the datasheet the allowed modes for the da9211
>> regulator are sync and auto mode. This should be changed in the
>> devicetree. This also fix an error message
>> 'BUCKA: invalid regulator-allowed-modes element 0'
>> since value 0 is invalid.
>>
>> Fixes: 689b937beddeb ("arm64: dts: mediatek: add mt8173 elm and hana board")
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> Double checked the regulator supported modes and I can confirm that this patch
> gets rid of the error message, so:
> 
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 

Applied to v5.9-next/dts64

Thanks!

>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>> index 1fe5dac24ba1..1a51879d5c6f 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>> @@ -5,6 +5,7 @@
>>   
>>   #include <dt-bindings/input/input.h>
>>   #include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/regulator/dlg,da9211-regulator.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include "mt8173.dtsi"
>>   
>> @@ -293,7 +294,8 @@
>>   				regulator-max-microamp  = <4400000>;
>>   				regulator-ramp-delay = <10000>;
>>   				regulator-always-on;
>> -				regulator-allowed-modes = <0 1>;
>> +				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
>> +							   DA9211_BUCK_MODE_AUTO>;
>>   			};
>>   
>>   			da9211_vgpu_reg: BUCKB {
>>
