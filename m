Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D50C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39162176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K4wkCBoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgBYNR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:17:58 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52052 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgBYNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:17:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PDHOol042048;
        Tue, 25 Feb 2020 07:17:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582636645;
        bh=lZ62AKaTB/Atbtpwa67sBTXqFH1ZmiihyqLCvh1A9fA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K4wkCBoy+olSygfm7BA8MQdkjr6f+AsXt7grThlRsMjHH8kKwfOeVLzzs5k1SCige
         Mb5HwZ+bskuIAzm3KFEUoQVL4eJxYc0xqIv49gKT5wn70q8E9y0aJPe9wZQDZRcdTL
         DnKH1LoUJAMAJuOJEfq3ragVeOzEFsnq4vCO4wC8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01PDHOoS121640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 07:17:24 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 07:17:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 07:17:24 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PDHMpk082587;
        Tue, 25 Feb 2020 07:17:22 -0600
Subject: Re: take the bus_dma_limit into account on arm
To:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
References: <20200218184103.35932-1-hch@lst.de>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6e0988f4-7958-29d9-6249-24ee51edee3a@ti.com>
Date:   Tue, 25 Feb 2020 15:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218184103.35932-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 18/02/2020 20:41, Christoph Hellwig wrote:
> Hi Russell,
> 
> this series fixes the arm dma coherent allocator to take the bus dma
> mask into account, similar to what other architectures do.  Without
> this devices that support 64-bit mask, but are limited by the
> interconnect won't work properly.
> 

Can we please have this series marked for -stable? Thanks.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
