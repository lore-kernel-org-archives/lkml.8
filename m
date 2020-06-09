Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC82FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA2220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f5XnrPJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbgFISIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:08:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbgFISIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:08:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 059I7reh053985;
        Tue, 9 Jun 2020 13:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591726073;
        bh=cm2RuIQ71UrmMw+X34myMwl7z6ENm3bU422kS2bPHGA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f5XnrPJs4w2Wo3RbXRbUSSWUchDqz65sZXYm8RgxcPxtSRoPugfzAsuRu1O3bXhb7
         naz1VTXM5GrtUAGtnVS6BcLUtTcSNlTQ2ItxFZwU0VG9rLz1yC262gDzxYArDGbNXn
         VZ1Y5gvtf/DrguwAwzXcBNO1YuSzLUkB7BAEQ1UY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 059I7rHB096669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Jun 2020 13:07:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Jun
 2020 13:07:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Jun 2020 13:07:52 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 059I7pnU088442;
        Tue, 9 Jun 2020 13:07:51 -0500
Subject: Re: [RFC PATCH 0/2] TAS2563 DSP Firmware Loader
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609175203.GP4583@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6d6aaed3-dac8-e1ec-436c-9b04273df2b3@ti.com>
Date:   Tue, 9 Jun 2020 13:07:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609175203.GP4583@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/9/20 12:52 PM, Mark Brown wrote:
> On Tue, Jun 09, 2020 at 12:28:39PM -0500, Dan Murphy wrote:
>
>> These programs and configurations are selectable via files under the I2C dev
>> node.  There may be a better way to select this through ALSA controls but I was
>> unable to find a good example of this.  This is why this is an RFC patchset.
> I think you can just use enums for most of this - what you want to do I
> think is parse the firmware, build templates for the controls and then
> add them with snd_soc_add_component_controls().  Userspace *should* cope
> with controls being hotplugged.

Yes this was my concern if userspace could cope with dynamic controls.

Dan

