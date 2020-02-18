Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F20C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F6E2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zRjwMWHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgBRH01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:26:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36854 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgBRH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:26:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01I7QDKD031977;
        Tue, 18 Feb 2020 01:26:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582010773;
        bh=dCDwEi1NILs2W8PNP2nGs/h1/l7croz6wFHCkYPYipo=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=zRjwMWHT0OaNYxBoxLtorHS6v3rINzz2qSq8IFLhsWivszYAue9eMTL4WCAvvLAy5
         OI4FV7DhAHUwB57KuXijH/8DBcow/HWW02SbnLMMEfawJewXMBIRZxRsAzOHaRMhPj
         OjhK8MPYk4zcDQueglu7V8rSMKGM3sq2Wdte2vGY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01I7QD0j065660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Feb 2020 01:26:13 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 01:26:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 01:26:12 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01I7Q8RI018709;
        Tue, 18 Feb 2020 01:26:09 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     Roger Quadros <rogerq@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        <stefan.wahren@i2se.com>, <afaerber@suse.de>, <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
 <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
 <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
 <20200217132133.GA27134@lst.de> <848c4cab-ad96-9c42-b15b-eaffee7f3f8f@ti.com>
Message-ID: <9ff32fa8-b6c4-04dc-b237-cac7c9a27d50@ti.com>
Date:   Tue, 18 Feb 2020 09:26:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <848c4cab-ad96-9c42-b15b-eaffee7f3f8f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

On 17/02/2020 16.54, Peter Ujfalusi wrote:
> Christoph,
> 
> On 17/02/2020 15.21, Christoph Hellwig wrote:
>> Roger,
>>
>> can you try the branch below and check if that helps?
>>
>>     git://git.infradead.org/users/hch/misc.git arm-dma-bus-limit
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-bus-limit
> 
> I'll test them on k2 tomorrow ;)

fwiw, k2g works fine with the three patch applied. MMC uses ADMA, EDMA
probes and audio works.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
