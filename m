Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B25BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED29220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iIbatgUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbgFXMHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:07:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37458 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbgFXMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:07:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OC73Xq063657;
        Wed, 24 Jun 2020 07:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593000423;
        bh=urADYeKqD191XbG4nfUX5KHD6LogFmSovqRvKmsIO18=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iIbatgUS7IW5fQZvMehX7SX46NCWkYwOWiljDTn4DchTpDRXRMMpBPH1Thtiucws/
         gRCbHrruSyMvXNSrpxuMbGRcu8xQ78W6FmIhCk2mDsxg/XpJ3w+f/nZo0IQ8SeknY8
         oDoGHtL0pVjv13YnHiUjdM8H/+CerqsI75siF1xM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OC72LE055309
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 07:07:02 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 07:07:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 07:07:02 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OC6xjD039705;
        Wed, 24 Jun 2020 07:07:00 -0500
Subject: Re: DMA Engine: Transfer From Userspace
To:     Vinod Koul <vkoul@kernel.org>, Thomas Ruf <freelancer@rufusul.de>
CC:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
 <1835214773.354594.1592843644540@mailbusiness.ionos.de>
 <2077253476.601371.1592991035969@mailbusiness.ionos.de>
 <20200624093800.GV2324254@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <3a4b1b55-7bce-2c48-b897-51e23e850127@ti.com>
Date:   Wed, 24 Jun 2020 15:07:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624093800.GV2324254@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/2020 12.38, Vinod Koul wrote:
> On 24-06-20, 11:30, Thomas Ruf wrote:
>=20
>> To make it short - i have two questions:
>> - what are the chances to revive DMA_SG?
>=20
> 100%, if we have a in-kernel user

Most DMAs can not handle differently provisioned sg_list for src and dst.=

Even if they could handle non symmetric SG setup it requires entirely
different setup (two independent channels sending the data to each
other, one reads, the other writes?).

>> - what are the chances to get my driver for memcpy like transfers from=

>> user space using DMA_SG upstream? ("dma-sg-proxy")
>=20
> pretty bleak IMHO.

fwiw, I also get requests time-to-time to DMA memcpy support from user
space from companies trying to move from bare-metal code to Linux.

What could be plausible is a generic dmabuf-to-dmabuf copy driver (V4L2
can provide dma-buf, DRM can also).
If there is a DMA memcpy channel available, use that, otherwise use some
method to do the copy, user space should not care how it is done.

Where things are going to get a bit more trickier is when the copy needs
to be triggered by other DMA channel (completion of a frame reception
triggering an interleaved sub-frame extraction copy).
You don't want to extract from a buffer which can be modified while the
other channel is writing to it.

In Linux the DMA is used for kernel and user space can only use it
implicitly via standard subsystems.
Misused DMA can be very dangerous and giving full access to program a
transfer can open a can of worms.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

