Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF32520738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1QJCkhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405561AbgFXRgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:36:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59922 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbgFXRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:36:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHa4PC059738;
        Wed, 24 Jun 2020 12:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593020164;
        bh=b7I1LZjktpXQtE/2SIxPlGxZJRi/hvLLHrKcEtNIZXM=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=S1QJCkhF8V2NBByGKWtk/vz55e0z8N2FwVrqdXywrH2vywZFUrpZmygqW7vY+d6VS
         epUUkxSSnuWq2cwb/FgbEXggJWNYIj8qrsgQ2/QiwZSAd5FqGcMcAkNnKpiYKGxLD/
         Qz8TWD/dVnP6AXrMZWTYpTFZCv+Fvzl3/uadznk4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHa4ap044210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 12:36:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:36:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:36:03 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHa3tG127913;
        Wed, 24 Jun 2020 12:36:03 -0500
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
From:   Dan Murphy <dmurphy@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com> <20200624162917.GK5472@sirena.org.uk>
 <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
Message-ID: <370c71e3-731b-3549-adb0-597abb217cfc@ti.com>
Date:   Wed, 24 Jun 2020 12:36:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/24/20 11:58 AM, Dan Murphy wrote:
> Mark
>
> On 6/24/20 11:29 AM, Mark Brown wrote:
>> On Wed, Jun 24, 2020 at 11:14:55AM -0500, Dan Murphy wrote:
>>> Fix the issue found that there is an extra space before a comma in the
>>> volume control.
>>>
>>> Fixes: bf726b1c86f2c ("ASoC: tas2562: Add support for digital volume 
>>> control")
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>   arch/arm/boot/compressed/fdt.h             |   66 +
>>>   arch/arm/boot/compressed/libfdt.h          | 2072 
>>> ++++++++++++++++++++
>>>   arch/arm/boot/compressed/libfdt_internal.h |  173 ++
>>>   sound/soc/codecs/tas2562.c                 |    2 +-
>> I'm guessing those libfdt changes weren't supposed to be here?
>
> No they were not those must have been added when I verified the build.
>
Can this patchset get a review as well so I can fix before I post v6?

Not sure what the current work load is for review or merge.

Dan


> Dan
>
