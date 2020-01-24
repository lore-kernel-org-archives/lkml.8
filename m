Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99782072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yqe3fCW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbgAXSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:06:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390710AbgAXSF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:05:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00OI5kqa057284;
        Fri, 24 Jan 2020 12:05:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579889146;
        bh=OTh91vvqx5FkwJrVpzCRzAv6h7V2/gVJYW+HKZ6IZhk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Yqe3fCW4F0O3F0vumSdxgo2GnRdaUfq0AWbDcXGU+dqLjOP3xlCcCBhJ16Aca+MfL
         E/gWOMP7bcC4dGea61P/6/F39CAi8K9HbX6fOPyFH5TvUw0Se9JHvDYgeqOaV9e16M
         /I5Dwto69rOrxwTdIuOOXDUdv3BAdtg7tMD4dp9w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OI5kiS098350;
        Fri, 24 Jan 2020 12:05:46 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 24
 Jan 2020 12:05:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 24 Jan 2020 12:05:45 -0600
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00OI5gfU118628;
        Fri, 24 Jan 2020 12:05:43 -0600
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <C043QOCZ7SMB.2XXX2ESS1ZJ98@linux-9qgx>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e29e23fd-cb60-56b9-e53d-ecbafc12bf8c@ti.com>
Date:   Fri, 24 Jan 2020 20:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <C043QOCZ7SMB.2XXX2ESS1ZJ98@linux-9qgx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 1/24/20 4:47 PM, Nicolas Saenz Julienne wrote:
>> If you need MMC rootfs then the DMA needs to be built in or have initrd
>> with the modules.
>> The driver expects to have DMA channel and it is going to wait for it to
>> appear unless the request fails.
>>
>> Without moving the DMA as built in and removing the deferred probe
>> handling form the MMC driver, one can just remove the DMA support from
>> the mmc-bcm2835 as it is not used at all.
> 
> Oh sorry, I meant to ask if the 'Fixes:' tag was really needed.

Complements: or Needed-for: would be better, but with the Fixed tag this
patch would be picked in case the dma_request_chan() conversion patch
gets backported for stable.

> The
> patch itself is very much needed since not everyone uses initrds in the
> RPi world, and we want to keep being compatible as much as possible with
> older device-trees.

Sure. Just checked on my RPi with libreELEC that at least they have the
DMA built in, I assume other distros do the same.

It would be great if this patch would make it to linux-next as soon as
it is possible for sure.

>> I wonder why this is not signaled by automated boot testing, if any
>> exists for bcm2835>
> Actually now that you mention it, it's failing since today here:
> https://kernelci.org/boot/bcm2837-rpi-3-b/

Oh, so you can even have a bug report to back this patch ;)

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
