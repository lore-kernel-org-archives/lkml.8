Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A1C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BD420722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YzO/t206"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgELOEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:04:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51236 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:04:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CE4GWK104112;
        Tue, 12 May 2020 09:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589292256;
        bh=RYLxeYyV14EWrGllI+5nxV7VKhyVKweYLlCJbrn+/wQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YzO/t206C/tOJSoUonzoDfABTdJRCAuyp6RPO8/ZrH4cJqkrPnCYmOR2OoiN2CdHz
         7ZoqZv5HgEdxwuXZKU2YZ1shTUzta+AkkHxBOYF1SGD6XNseWRo3IpNw2nzF3t4i4o
         ThbQv7vxkhNfuBbr6FvyZyW3k1L3+NHi5qldIDLI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CE4GxK004618;
        Tue, 12 May 2020 09:04:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 09:04:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 09:04:16 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CE4E0i097923;
        Tue, 12 May 2020 09:04:14 -0500
Subject: Re: [PATCH v2] mfd: stm32-timers: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Lee Jones <lee.jones@linaro.org>
CC:     <fabrice.gasnier@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <vkoul@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200107105959.18920-1-peter.ujfalusi@ti.com>
 <20200416084651.GW2167633@dell>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <b50b4568-88d6-3475-f3c5-84331d66632e@ti.com>
Date:   Tue, 12 May 2020 17:04:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200416084651.GW2167633@dell>
Content-Type: multipart/mixed;
        boundary="------------CF3D3B72ECF4F393ED0CA57E"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------CF3D3B72ECF4F393ED0CA57E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 16/04/2020 11.46, Lee Jones wrote:
> On Tue, 07 Jan 2020, Peter Ujfalusi wrote:
>=20
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since v1:
>> - Fall back to PIO mode only in case of ENODEV and report all other er=
rors
>>
>> Regards,
>> Peter
>>
>>  drivers/mfd/stm32-timers.c | 32 +++++++++++++++++++++++---------
>>  1 file changed, 23 insertions(+), 9 deletions(-)
>=20
> Apologies for not spotting this patch sooner, it had slipped through
> the net.  If this happens again, please just submit a [RESEND].

No issues, I have also forgot about it ;)


>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
>> index efcd4b980c94..add603359124 100644
>> --- a/drivers/mfd/stm32-timers.c
>> +++ b/drivers/mfd/stm32-timers.c
>> @@ -167,10 +167,11 @@ static void stm32_timers_get_arr_size(struct stm=
32_timers *ddata)
>>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>>  }
>> =20
>> -static void stm32_timers_dma_probe(struct device *dev,
>> +static int stm32_timers_dma_probe(struct device *dev,
>>  				   struct stm32_timers *ddata)
>>  {
>>  	int i;
>> +	int ret =3D 0;
>>  	char name[4];
>> =20
>>  	init_completion(&ddata->dma.completion);
>> @@ -179,14 +180,23 @@ static void stm32_timers_dma_probe(struct device=
 *dev,
>>  	/* Optional DMA support: get valid DMA channel(s) or NULL */
>>  	for (i =3D STM32_TIMERS_DMA_CH1; i <=3D STM32_TIMERS_DMA_CH4; i++) {=

>>  		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
>> -		ddata->dma.chans[i] =3D dma_request_slave_channel(dev, name);
>> +		ddata->dma.chans[i] =3D dma_request_chan(dev, name);
>>  	}
>> -	ddata->dma.chans[STM32_TIMERS_DMA_UP] =3D
>> -		dma_request_slave_channel(dev, "up");
>> -	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =3D
>> -		dma_request_slave_channel(dev, "trig");
>> -	ddata->dma.chans[STM32_TIMERS_DMA_COM] =3D
>> -		dma_request_slave_channel(dev, "com");
>> +	ddata->dma.chans[STM32_TIMERS_DMA_UP] =3D dma_request_chan(dev, "up"=
);
>> +	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =3D dma_request_chan(dev, "t=
rig");
>> +	ddata->dma.chans[STM32_TIMERS_DMA_COM] =3D dma_request_chan(dev, "co=
m");
>> +
>> +	for (i =3D STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++) {
>> +		if (IS_ERR(ddata->dma.chans[i])) {
>> +			/* Save the first error code to return */
>> +			if (PTR_ERR(ddata->dma.chans[i]) !=3D -ENODEV && !ret)
>> +				ret =3D PTR_ERR(ddata->dma.chans[i]);
>> +
>> +			ddata->dma.chans[i] =3D NULL;
>> +		}
>> +	}
>=20
> In my mind, it doesn't make sense to keep requesting channels if an
> error has occurred.  Please remove all of the added complexity caused
> by the for() loop and simply check the return value after each call to
> dma_request_chan(), returning immediately on error.

Yes. I have intentionally done the patch this way to _not_ change the
behavior in any ways as it is not up to me to decide what is good or bad
for a driver I can not test.

>=20
>> +	return ret;
>>  }
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------CF3D3B72ECF4F393ED0CA57E
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFki4nsBCAD3BM+Ogt951JlaDloruEjoZk/Z+/37CjP0fY2mqLhBOzkpx95u
X1Fquf0KfVk+ZzCd25XGOZEtpZNlXfbxRr2iRWPS5RW2FeLYGvg2TTJCpSr+ugKu
OOec6KECCUotGbGhpYwBrbarJNEwDcAzPK7UJYa1rhWOmkpZJ1hXF1hUghB84q35
8DmN4sGLcsIbVdRFZ1tWFh4vGBFV9LsoDZIrnnANb6/XMX78s+tr3RG3GZBaFPl8
jO5IIv0UIGNUKaYlNVFYthjGCzOqtstHchWuK9eQkR7m1+Vc+ezh1qK0VJydIcjn
OtoMZZL7RAz13LB9vmcJjbQPnI7dJojz/M7zABEBAAG0JlBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+iQFOBBMBCAA4FiEE+dBcpRFvJjZw+uta
LCayis85LN4FAlki4nsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQLCay
is85LN4QjggAzxxxXqiWpA3vuj9yrlGLft3BeGKWqF8+RzdeRvshtNdpGeIFf+r5
AJVR71R1w89Qeb4DGXus7qsKiafdFGG7yxbuhw8a5wUm+ZncBXA+ETn3OyVtl8g8
r/ZcPX420jClBNTVuL0sSnyqDFDrt5f+uAFOIwsnHdpns174Zu9QhgYxdvdZ+jMh
Psb745O9EVeNvdfUIRdrVjb4IhJKNIzkb0Tulsz5xeCJReUYpxZU1jzEq3YZqIou
+fi+oS4wlJuSoxKKTmIXtSeEy/weStF1XHMo6vLYqzaK4FyIuclqeuYUYSVy2425
7TMXugaI+O85AEI6KW8MCcu1NucSfAWUabkBDQRZIuJ7AQgAypKq8iIugpHxWA2c
Ck6MQdPBT6cOEVK0tjeHaHAVOUPiw9Pq+ssMifdIkDdqXNZ3RLH/X2svYvd8c81C
egqshfB8nkJ5EKmQc9d7s0EwnYT8OwsoVb3c2WXnsdcKEyu2nHgyeJEUpPpMPyLc
+PWhoREifttab4sOPktepdnUbvrDK/gkjHmiG6+L2owSn637N+Apo3/eQuDajfEu
kybxK19ReRcp6dbqWSBGSeNB32c/zv1ka37bTMNVUY39Rl+/8lA/utLfrMeACHRO
FGO1BexMASKUdmlB0v9n4BaJFGrAJYAFJBNHLCDemqkU7gjaiimuHSjwuP0Wk7Ct
KQJfVQARAQABiQE2BBgBCAAgFiEE+dBcpRFvJjZw+utaLCayis85LN4FAlki4nsC
GwwACgkQLCayis85LN7kCwgAoy9r3ZQfJNOXO1q/YQfpEELHn0p8LpwliSDUS1xL
sswyxtZS8LlW8PjlTXuBLu38Vfr0vGav7oyV7TkhnKT3oBOLXanyZqwgyZSKNEGB
PB4v3Fo7YTzpfSofiwuz03uyfjTxiMGjonxSb+YxM7HBHfzjrOKKlg02fK+lWNZo
m5lXugeWD7U6JJguNdYfr+U4zYIblelUImcIE+wnR0oLzUEVDIWSpVrl/OqS3Rzo
mw8wBsHksTHrbgUnKL0SCzYc90BTeKbyjEBnVDr+dlfbxRxkB8h9RMPMdjodvXzS
Gfsa9V/k4XAsh7iX9EUVBbnmjA61ySxU/w98h96jMuteTg=3D=3D
=3DeQmw
-----END PGP PUBLIC KEY BLOCK-----

--------------CF3D3B72ECF4F393ED0CA57E--
