Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30650C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D292072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B5GQRG24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgDHTOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:14:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59364 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgDHTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:14:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 038JE0A6026197;
        Wed, 8 Apr 2020 14:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586373240;
        bh=Jan9WiQvt2G9+ylIarIQMuliXA1cCWyxA1RFqWRPzVY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B5GQRG24mhTkEdDH5w5DKJ6caXNu+qydPzTDAaJ9msmDCnX/cnjW9tDszzik4JtQH
         Bl8d0uz4DXD+4PuDOM4izIbQtMv2qz/E0kXnWCkd2ItLCQMnb1paNQaEkb1lncA3dx
         Ugu/CEWmfV7AigBK3/loMN3zpRaPbvWEgTuyHU2o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JE0bB110973;
        Wed, 8 Apr 2020 14:14:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Apr
 2020 14:14:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Apr 2020 14:14:00 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 038JDurk103291;
        Wed, 8 Apr 2020 14:13:57 -0500
Subject: Re: [PATCH] dma-debug: fix displaying of dma allocation type
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20200408184804.30522-1-grygorii.strashko@ti.com>
 <20200408184958.GA9945@lst.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <ccd0cca4-ca89-3ecd-90d5-66e5e4090f41@ti.com>
Date:   Wed, 8 Apr 2020 22:13:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200408184958.GA9945@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/04/2020 21:49, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 09:48:04PM +0300, Grygorii Strashko wrote:
>> The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
>> dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
>> type2name string table. This causes incorrect displaying of dma allocation
>> type. Fix it by removing "page" string from type2name string table.
>>
>> Before (dma_alloc_coherent()):
>> k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>> k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>>
>> After:
>> k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>> k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
>>
>> Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   kernel/dma/debug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>> index 2031ed1ad7fa..09b85ba0c137 100644
>> --- a/kernel/dma/debug.c
>> +++ b/kernel/dma/debug.c
>> @@ -137,7 +137,7 @@ static const char *const maperr2str[] = {
>>   	[MAP_ERR_CHECKED] = "dma map error checked",
>>   };
>>   
>> -static const char *type2name[5] = { "single", "page",
>> +static const char *type2name[5] = { "single",
>>   				    "scather-gather", "coherent",
>>   				    "resource" };
> 
> To make sure this doesn't happen anymore, can you switch to
> named initializers?
> 

Just to clarify.
Do you mean
[dma_debug_coherent] = "coherent",
?


-- 
Best regards,
grygorii
