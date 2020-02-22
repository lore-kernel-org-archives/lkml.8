Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93EFC35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 02:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7103A206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 02:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="iBuZGyAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBVCnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 21:43:11 -0500
Received: from hermes.aosc.io ([199.195.250.187]:36629 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBVCnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 21:43:11 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DE74848A85;
        Sat, 22 Feb 2020 02:43:07 +0000 (UTC)
Date:   Sat, 22 Feb 2020 10:43:02 +0800
In-Reply-To: <20200221171328.GC6928@lst.de>
References: <20200221165127.813325-1-icenowy@aosc.io> <20200221171328.GC6928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: analogix-anx6345: fix set of link bandwidth
To:     Torsten Duwe <duwe@lst.de>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <1E7BDB0F-639B-42BB-A4B4-A4C8CF94EBE0@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1582339390;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=HdzgxMt6spoiHKpSzevHwlrwkDQO+555z64Q+HRu8y8=;
        b=iBuZGyAA0D0whU3sCLhDXXiLyba9sqcc4GM3/SEbgRPvBCAzBSwOwFuOdjRUYotm6k9CAh
        KBxhTXsm/SKXf4+xZP00qKmnXmiOoDmtW8Ui2hLE9BKBR3Wvx1l0M6NvybawdkxtH9XpqX
        njZ0SNgbpZfZrWMJDhaAGIDFLL8Ea4E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B42=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=881=
:13:28, Torsten Duwe <duwe@lst=2Ede> =E5=86=99=E5=88=B0:
>On Sat, Feb 22, 2020 at 12:51:27AM +0800, Icenowy Zheng wrote:
>> Current code tries to store the link rate (in bps, which is a big
>> number) in a u8, which surely overflow=2E Then it's converted back to
>> bandwidth code (which is thus 0) and written to the chip=2E
>>=20
>> The code sometimes works because the chip will automatically fallback
>to
>> the lowest possible DP link rate (1=2E62Gbps) when get the invalid
>value=2E
>> However, on the eDP panel of Olimex TERES-I, which wants 2=2E7Gbps
>link,
>> it failed=2E
>>=20
>> As we had already read the link bandwidth as bandwidth code in
>earlier
>> code (to check whether it is supported), use it when setting
>bandwidth,
>> instead of converting it to link rate and then converting back=2E
>>=20
>> Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5=2E5")
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>>  drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>b/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>> index 56f55c53abfd=2E=2E2dfa2fd2a23b 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>> @@ -210,8 +210,7 @@ static int anx6345_dp_link_training(struct
>anx6345 *anx6345)
>>  	if (err)
>>  		return err;
>> =20
>> -	dpcd[0] =3D drm_dp_max_link_rate(anx6345->dpcd);
>> -	dpcd[0] =3D drm_dp_link_rate_to_bw_code(dpcd[0]);
>> +	dpcd[0] =3D dp_bw;
>
>Why do you make this assignment and not use dp_bw directly in the call?

Because the dpcd array is then written as a continous array
back to DPCD=2E

>
>>  	err =3D regmap_write(anx6345->map[I2C_IDX_DPTX],
>>  			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
>                                                       ^^^^^^
>>  	if (err)
>> --=20
>> 2=2E24=2E1
>
>BTW, my version is only a bit more verbose:
>
>https://patchwork=2Efreedesktop=2Eorg/patch/354344/
>
>	Torsten

--=20
=E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84A=
ndroid=E8=AE=BE=E5=A4=87=E3=80=82
