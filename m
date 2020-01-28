Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA0C24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xBh/qDSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgA1IUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:20:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40426 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1IUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:20:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00S8KNjt028638;
        Tue, 28 Jan 2020 02:20:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580199623;
        bh=8puorSS2DhVQd8TswvusYCRWiQHEdCmIblxq5NzEfKY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xBh/qDShAxxjP942ORw04g8URKhIt3mOedUwGR10rZangDQIWSIxfKgKHsUeiTtNL
         s2wC1w79g1NmvLGND9S0f+qydHhXamX6gRMx+E88rXwn1BdWZ9eMKk55ft7xNuPUi2
         xJJe6jsgZHPAxy3Ag3cxjrVWW9w+e4D4bz8Mbo0A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00S8KN84033053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 02:20:23 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 02:20:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 02:20:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00S8KKnV104334;
        Tue, 28 Jan 2020 02:20:21 -0600
Subject: Re: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
To:     Olof Johansson <olof@lixom.net>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>
References: <20200124092359.12429-1-peter.ujfalusi@ti.com>
 <20200124200811.ytgs66cg5qpugi5c@localhost>
 <12f40648-fec6-9179-1f62-0a648996ed20@ti.com>
 <CAOesGMiFw2V6fdbGCOfgsVq+WK-4ijdzivDdX3hbS2E=bO4zkg@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a81fa6b0-811c-82af-4cf6-e2f4ac3c0ded@ti.com>
Date:   Tue, 28 Jan 2020 10:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMiFw2V6fdbGCOfgsVq+WK-4ijdzivDdX3hbS2E=bO4zkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 27/01/2020 17.30, Olof Johansson wrote:
>>> I also see that this is statically enabling this driver -- we try to keep as
>>> many drivers as possible as modules to avoid the static kernel from growing too
>>> large. Would that be a suitable approach here, or is the driver needed to reach
>>> rootfs for further module loading?
>>
>> We would need built in DMA for nfs rootfs, SD/MMC has it's own buit-in
>> ADMA. We do not have network drivers upstream as they depend on the DMA.
> 
> Ok, so that can either be turned into a ramdisk argument, or into a
> "we really want to enable non-ramdisk rootfs boots on this hardware
> because it's a common use case".

SD/MMC does not need slave DMA, it is self containing with it's own
built-in DMA.
I'm not sure if it is enabled in defconfig. It is not enabled at all in
defconfig atm.

Normally I would use nfs rootfs, but we don't have network drivers
upstream for K3 platform.

I think having the UDMA stack as module should be fine when I have the
dependencies in to be able to build them as modules.

> I find it useful to challenge most of the =y drivers to make people
> think about it, and at some point we'll enough overhead of cruft in
> the static superset kernel that defconfig today is used for such that
> we need to prune more =y -> =m,

Sure, I fully agree on this, we should have non boot needed drivers as
modules.

> but this particular driver is probably
> OK (it's also not large).

Well, it depends how you look at it ;)

UDMA stack is not enabled in defconfig (w/o this patch):
$ size vmlinux
text      data     bss     dec       hex      filename
17853717  9221872  469288  27544877  1a44d2d  vmlinux

UDMA stack is enabled in defconfig (w this patch):
$ size vmlinux
text      data     bss     dec       hex      filename
17890970  9237544  469288  27597802  1a51bea  vmlinux

It would be nice for other driver to enable the DMA if it is acceptable
to have it built in for start and when I can build it as module we can
switch it to module?

>> Imho module would be fine for the DMA stack, but neither ringacc or the
>> UDMA driver can be built as module atm until the following patches got
>> merged:
>> https://lore.kernel.org/lkml/20200122104723.16955-1-peter.ujfalusi@ti.com/
>> https://lore.kernel.org/lkml/20200122104031.15733-1-peter.ujfalusi@ti.com/
>>
>> I have the patches to add back module support, but waiting on these
>> currently.
> 
> -Olof
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
