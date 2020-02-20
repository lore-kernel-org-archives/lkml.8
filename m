Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70022C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405D0206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AXhQLFrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBTSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:52:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49518 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgBTSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:52:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KIq3Th050543;
        Thu, 20 Feb 2020 12:52:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582224723;
        bh=CG0tyGJbtv0I8DXr8bqwQT8uM4lDoibn5681XyzQ1P4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AXhQLFrnGcIXakvPGLOqv/zrVizRfWyVaWHSwtTnw1vRRqMHfJj6v0EfAkRdCmcDb
         TDrSXT90v12e/lWcpn5FGC5oWUh9WTsI21mDLoulRs+7xZoo/toBK8+H+kN8E7BDJo
         vrrl3VFgJAEff67Knfr956Kpt8zpOSyWBKB3VuIU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01KIq2ij058863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Feb 2020 12:52:03 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 12:52:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 12:52:02 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KIq1DS102364;
        Thu, 20 Feb 2020 12:52:01 -0600
Subject: Re: [PATCH] ASoC: tas2562: Add support for digital volume control
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20200220172721.10547-1-dmurphy@ti.com>
 <20200220184507.GF3926@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <de0e8a5b-8c2a-ee04-856f-f0d678a3c66b@ti.com>
Date:   Thu, 20 Feb 2020 12:46:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220184507.GF3926@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 2/20/20 12:45 PM, Mark Brown wrote:
> On Thu, Feb 20, 2020 at 11:27:21AM -0600, Dan Murphy wrote:
>
>> +	/* Set the Digital volume to -110dB */
>> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4, 0x00);
>> +	if (ret)
>> +		return ret;
>> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3, 0x00);
>> +	if (ret)
>> +		return ret;
>> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG2, 0x0d);
>> +	if (ret)
>> +		return ret;
>> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1, 0x43);
>> +	if (ret)
>> +		return ret;
> Is there a reason not to use the chip default here?  Otherwise this
> looks good.

Chip default is set to 0dB full blast+ 0x40400000.  This sets the volume 
to -110dB.

I have the values backwards.  CFG4 should b 0x43 and CFG3 should be 0x0d 
and CFG1&2 should be 0.

I will resend v2 with this fixed.

Dan

