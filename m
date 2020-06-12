Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C0920801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GAP2vffs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:19:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44302 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:19:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CGJ3NZ008385;
        Fri, 12 Jun 2020 11:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591978743;
        bh=qdnsUxScp0+e7+Rcpeem3AhfcgDvP3Hz7jFw8jx1lT8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GAP2vffsMCWro9ZC609aRrgEkttKyDM6Il74FmQw2z8xIPhzCPGSy0CYsW/NGLE60
         Ju9BVR4rLSpgInOvL8Gw//psG6ukTo+mIAcM6R7FFDwrp+mChFs6Y2/NoUVsPR2wmV
         RLk2DMSfdaNRzzN4/O3QMueOLcyNW6bv/q9s/6us=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CGJ3Tb127945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:19:03 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 11:19:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 11:19:03 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CGJ2Rb045616;
        Fri, 12 Jun 2020 11:19:02 -0500
Subject: Re: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200612160603.2456-1-dmurphy@ti.com>
 <20200612160603.2456-2-dmurphy@ti.com> <20200612160922.GL5396@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0e482167-71c2-a128-b8b4-a054557d30e9@ti.com>
Date:   Fri, 12 Jun 2020 11:18:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612160922.GL5396@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/12/20 11:09 AM, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 11:06:03AM -0500, Dan Murphy wrote:
>
>> -	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
>> +	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
>>   						      GPIOD_OUT_HIGH);
> This also changes the name from shut-down to shutdown which will be
> incompatible (IIRC we do try -gpio as well as -gpios).
Yes the non-standardish name was highlighted by Rob[1].

Also I checked the GPIO library and it looks at both -gpio and gpios as 
property suffixes.

Since this is a single GPIO the singular should be used in this case

[1] https://lore.kernel.org/patchwork/patch/1251670/

Dan

