Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE5D206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NGT7+V58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbgFXJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:14:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgFXJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:14:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05O9E4no119939;
        Wed, 24 Jun 2020 04:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592990045;
        bh=+U9mzYjHXvzQcKQ8zAR2Rl0V4zJPMHqdfZnHwYl51KE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NGT7+V58MqwR78RadLUNojxEoPh5W+sm16OU/EMx8sWnj8LbRXkAfZs9Eln6tzgAt
         IYFyiE0imKDk4SH6pv41DbSdY0l123owgB99SGQjRVF0eLjh76B/6+YcPfDMklIgHP
         /Xp6RtDvnGeWHBbO+WqsAzMgQK24Fyhm4jX1io20=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05O9E4vd127560;
        Wed, 24 Jun 2020 04:14:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 04:14:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 04:14:04 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05O9E25P006129;
        Wed, 24 Jun 2020 04:14:03 -0500
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
To:     Vinod Koul <vkoul@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <22b95e2d-dbe0-6d17-3085-2f363cd4d889@ti.com>
Date:   Wed, 24 Jun 2020 12:14:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624055535.GX2324254@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/2020 8.55, Vinod Koul wrote:
> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
>> Make use of the struct_size() helper instead of an open-coded version
>> in order to avoid any potential type mistakes.
>>
>> This code was detected with the help of Coccinelle and, audited and
>> fixed manually.
>>
>> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/dma/ti/k3-udma.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 0d5fb154b8e2..411c54b86ba8 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, str=
uct scatterlist *sgl,
>>  	u32 ring_id;
>>  	unsigned int i;
>> =20
>> -	d =3D kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT)=
;
>> +	d =3D kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
>=20
> struct_size() is a * b + c but here we need, a + b * c.. the trailing
> struct is N times here..

Yes, that's correct.

>=20
>=20
>>  	if (!d)
>>  		return NULL;
>> =20
>> @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, d=
ma_addr_t buf_addr,
>>  	if (period_len >=3D SZ_4M)
>>  		return NULL;
>> =20
>> -	d =3D kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAI=
T);
>> +	d =3D kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
>>  	if (!d)
>>  		return NULL;
>> =20
>> --=20
>> 2.27.0
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

