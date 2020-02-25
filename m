Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9946C35DF3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4524686
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xojYbUmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBYE6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:58:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57974 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgBYE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:58:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P4wWcV052767;
        Mon, 24 Feb 2020 22:58:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582606712;
        bh=RnFLvEnRIw1nTDH2LeYZgGHl3LuyiCpGMi6GWE7hDBw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xojYbUmqNkNElX2StIiyAmNE2D+AUJTUPVLwZMfAm+h9ouP3UdKOTYQZIy0LedK1B
         KIaNQ7mh8ZhjQI6x3AZnNSccxewiiV+7IrnZlBWWubTvnxPhVK/Bg/5TDlF1ZwrImo
         MyaCOaxBicJTi0iJS95qUeVlMrDkWWOpntIWcGZA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P4wWJR055279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 22:58:32 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 22:58:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 22:58:32 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P4wUSr007407;
        Mon, 24 Feb 2020 22:58:31 -0600
Subject: Re: [PATCH] phy: tegra: xusb: Don't warn on probe defer
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200224143641.5851-1-jonathanh@nvidia.com>
 <20200224151218.GA2570205@ulmo>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7292f4cc-ec5c-4840-3627-72883a0353c7@ti.com>
Date:   Tue, 25 Feb 2020 10:32:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200224151218.GA2570205@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 24/02/20 8:42 pm, Thierry Reding wrote:
> On Mon, Feb 24, 2020 at 02:36:41PM +0000, Jon Hunter wrote:
>> Deferred probe is an expected return value for tegra_fuse_readl().
>> Given that the driver deals with it properly, there's no need to
>> output a warning that may potentially confuse users.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/phy/tegra/xusb-tegra186.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Kishon,
> 
> I already have a couple of PHY subsystem patches from JC and Nagarjuna
> in a branch in the Tegra tree that I need to resolve a dependency. Do
> you mind if I pick this up into that branch as well and send it to you
> as a pull request later on? Say around v5.6-rc6?

You can take this via Tegra tree itself.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

-Kishon

> 
> Alternatively you could provide an Acked-by and then I can take them all
> through ARM SoC.
> 
> Thierry
> 
>> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
>> index 84c27394c181..12d0f3e30dbc 100644
>> --- a/drivers/phy/tegra/xusb-tegra186.c
>> +++ b/drivers/phy/tegra/xusb-tegra186.c
>> @@ -802,7 +802,9 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_xusb_padctl *padctl)
>>  
>>  	err = tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
>>  	if (err) {
>> -		dev_err(dev, "failed to read calibration fuse: %d\n", err);
>> +		if (err != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to read calibration fuse: %d\n",
>> +				err);
>>  		return err;
>>  	}
>>  
>> -- 
>> 2.17.1
>>
