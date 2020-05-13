Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26E42053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oU+zYpSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbgEMR0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:26:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732731AbgEMR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:26:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DHPnEH109727;
        Wed, 13 May 2020 12:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589390749;
        bh=duOsfIS+tq7+J/oq9NmLkFabkw0gD0IE1GYQRhOX5qg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oU+zYpSz2npoUF8TOdFjvAo6oy3TDlzNxjM9OTYFYFveOmiCLMOlLpGap3JuPIkW2
         R87XXmuprnHmGwGDf4VYlncFRBLlcIUsKM9oX+ThnhFpkmGK+OlH2oC34bzBnHrCnR
         TJQ4vS/AiA2e4RwVCjmaSw9t804bdBoor0IFSQVc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DHPnSd123155
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 12:25:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 12:25:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 12:25:49 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DHPnc9115992;
        Wed, 13 May 2020 12:25:49 -0500
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add controls for PDM clk and edge
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200513144746.14337-1-dmurphy@ti.com>
 <20200513153243.GO4803@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d2e3741e-ba06-7578-b5f3-2af75e1e33c7@ti.com>
Date:   Wed, 13 May 2020 12:16:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513153243.GO4803@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 5/13/20 10:32 AM, Mark Brown wrote:
> On Wed, May 13, 2020 at 09:47:46AM -0500, Dan Murphy wrote:
>
>> +static const char * const pdmclk_text[] = {
>> +	"2.8224 MHz", "1.4112 MHz", "705.6 kHz", "5.6448 MHz"
>> +};
>> +
>> +static SOC_ENUM_SINGLE_DECL(pdmclk_select_enum, ADCX140_PDMCLK_CFG, 0,
>> +			    pdmclk_text);
>> +
>> +static const struct snd_kcontrol_new pdmclk_div_controls[] = {
>> +	SOC_DAPM_ENUM("PDM Clk Divider Select", pdmclk_select_enum),
>> +};
>> +
>> +static const char * const pdm_edge_text[] = {
>> +	"Negative", "Positive"
>> +};
> Are these (especially the clock and polarity) things that are going to
> vary at runtime?  I'd have expected these to come from the hardware
> rather than being something that could usefully change.
Some microphone support low power modes that use a slower clock.
Polarity will probably not change at run-time, but clock speed can 
change to move mics from low power/low-resolution to higher 
power/high-resolution mode.

So polarity can be made hardware specific but clocks should be configurable.

I can break these out into separate patches if you want.

Dan

