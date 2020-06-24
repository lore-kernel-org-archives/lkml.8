Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88769C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691852073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fchGKA38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405332AbgFXQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:59:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58962 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405261AbgFXQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:59:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OGwK22116650;
        Wed, 24 Jun 2020 11:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593017900;
        bh=1bCCG3caD2sEg6qKGWI/2Xon9AP/3Rs9Tep0MMhKNyI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fchGKA38CXQUP7iDyyGdGNLVtQi1y++syqLRo4u0NBdkO8Aq1PwcPfq/2hfFdSdBz
         ICbpWJGi7uNSCEXVt6XOhq+nxLuI9pE8WYZyhPCVFoE2ufsoIgaGGuLPj0wKdy8ng2
         Jt+4ukQeedooST/j+nZakDToc/gpsQOBWlZfBSms=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OGwKoL125387
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 11:58:20 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 11:58:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 11:58:20 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGwJ5b062239;
        Wed, 24 Jun 2020 11:58:19 -0500
Subject: Re: [PATCH v5 3/7] ASoC: tas2562: Fix format issue for extra space
 before a comma
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
References: <20200624161459.19248-1-dmurphy@ti.com>
 <20200624161459.19248-4-dmurphy@ti.com> <20200624162917.GK5472@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c4a26be8-88cc-1dfa-61e0-844b9c19eb52@ti.com>
Date:   Wed, 24 Jun 2020 11:58:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624162917.GK5472@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/24/20 11:29 AM, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 11:14:55AM -0500, Dan Murphy wrote:
>> Fix the issue found that there is an extra space before a comma in the
>> volume control.
>>
>> Fixes: bf726b1c86f2c ("ASoC: tas2562: Add support for digital volume control")
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   arch/arm/boot/compressed/fdt.h             |   66 +
>>   arch/arm/boot/compressed/libfdt.h          | 2072 ++++++++++++++++++++
>>   arch/arm/boot/compressed/libfdt_internal.h |  173 ++
>>   sound/soc/codecs/tas2562.c                 |    2 +-
> I'm guessing those libfdt changes weren't supposed to be here?

No they were not those must have been added when I verified the build.

Dan

