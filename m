Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6063D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f+J4vZsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgFITVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:21:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32932 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFITVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:21:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059JKX1d088349;
        Tue, 9 Jun 2020 14:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591730433;
        bh=ZPzxZJaQ2aInc4QHSdxUXpf6Q0oMRP3/URsi//CF6L8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f+J4vZscyfmvcnEPlE8ig6eRWF1Mcldf0lezx2j9IV/V5OBx3Ljdp9TGELuebGnHz
         dCAWGlw5iYb3/Ra5aHxyNdTzGkvhcgzq0KfB2sPYWD1NCuKxy2wuXY/pNVKQLmF0Rk
         Vz7SQKuam4lgPahMqc0JKaErMDosf5dxuZDlBNgw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 059JKXDc063661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jun 2020 14:20:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 14:20:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 14:20:33 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059JKU5W083640;
        Tue, 9 Jun 2020 14:20:31 -0500
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com> <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
Date:   Tue, 9 Jun 2020 14:20:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609184734.GS4583@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/9/20 1:47 PM, Mark Brown wrote:
> On Tue, Jun 09, 2020 at 01:06:50PM -0500, Dan Murphy wrote:
>
>> I could make a default as you suggested to include i2c address and bus in
>> the name.  But the TAS2563 does not need the firmware to operate and the
>> 2562 does not have a DSP.
> That's fine, the driver can just use the compatible string to check this
> and not offer any of the DSP related stuff (it should do this regardless
> of the method used here).  I'm guessing the regmap configs should also
> be different.

The driver does check the compatible to determine if DSP loading is 
available for the device.

The driver also checks to see if the firmware file is declared in the DT.

So it has to pass 2 checks to even load and parse the firmware to 
present the controls for the programs and configs.


>> What if there was an ALSA control instead that passed in the firmware name
>> from the user space instead of using the DT?
>> Then the control can load and parse the firmware and wait for the user to
>> select the program.
>> This would solve a user from having ot update the DT to use a firmware.
> That's really not very idiomatic for how Linux does stuff and seems to
> pretty much guarantee issues with hotplugging controls and ordering -
> you'd need special userspace to start up even if it was just a really
> simple DSP config doing only speaker correction or something.  I'm not
> sure what the advantage would be - what problem is this solving over
> static names?

IMO having a static name is the problem. It is an inflexible design.  
Besides the firmware-name property seems to be used in other drivers to 
declare firmwares for the boards.

But if no one is complaining or submitting patches within the codecs to 
be more flexible with firmware then I can just hard code the name like 
other drivers do.

Dan

