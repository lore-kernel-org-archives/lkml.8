Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E411C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE6224656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="WOvbtHVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBZLC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:02:26 -0500
Received: from hermes.aosc.io ([199.195.250.187]:56983 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBZLCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:02:25 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BCD4F4AF6B;
        Wed, 26 Feb 2020 11:02:19 +0000 (UTC)
Date:   Wed, 26 Feb 2020 19:02:09 +0800
In-Reply-To: <f4109d23-4591-1c52-2822-0a2ba358fe1f@suse.de>
References: <20200221165127.813325-1-icenowy@aosc.io> <20200221171328.GC6928@lst.de> <1E7BDB0F-639B-42BB-A4B4-A4C8CF94EBE0@aosc.io> <f4109d23-4591-1c52-2822-0a2ba358fe1f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: analogix-anx6345: fix set of link bandwidth
To:     Thomas Zimmermann <tzimmermann@suse.de>, Torsten Duwe <duwe@lst.de>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <07EED5EC-28C6-473D-B672-509F5C770479@aosc.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1582714944;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=pIFoYi183Typp2lmcp92AMk/OHIxESeRN6Iv4o1xpWU=;
        b=WOvbtHVjWIE9boKR2Mpt+dszNQp2Fuku0lplBgL1Ao10VSD4nV4IeDoEjrwMDcWUp5lpTx
        94uvk8zIvE3ZO6sqMtXHkhh+QDloNsAlQMO7xJAJQdVikEVdXGjfXHz+Mk3bdxnE2bl4gz
        j0eWRG/CA7cHbfUSNMcZbnBVNeg1t+Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B42=E6=9C=8826=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886=
:58:43, Thomas Zimmermann <tzimmermann@suse=2Ede> =E5=86=99=E5=88=B0:
>Hi Iceynow,
>
>Torsten asked me to merge your patch via drm-misc-next=2E I'd add the
>additional cc and fixes tags that Torsten listed=2E Are you OK with that?

I think this fixes a driver (and a board) available in 5=2E6=2E

Maybe it should enter fixes?

>
>Best regards
>Thomas
>
>Am 22=2E02=2E20 um 03:43 schrieb Icenowy Zheng:
>>=20
>>=20
>> =E4=BA=8E 2020=E5=B9=B42=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=881:13:28, Torsten Duwe <duwe@lst=2Ede> =E5=86=99=E5=88=B0:
>>> On Sat, Feb 22, 2020 at 12:51:27AM +0800, Icenowy Zheng wrote:
>>>> Current code tries to store the link rate (in bps, which is a big
>>>> number) in a u8, which surely overflow=2E Then it's converted back to
>>>> bandwidth code (which is thus 0) and written to the chip=2E
>>>>
>>>> The code sometimes works because the chip will automatically
>fallback
>>> to
>>>> the lowest possible DP link rate (1=2E62Gbps) when get the invalid
>>> value=2E
>>>> However, on the eDP panel of Olimex TERES-I, which wants 2=2E7Gbps
>>> link,
>>>> it failed=2E
>>>>
>>>> As we had already read the link bandwidth as bandwidth code in
>>> earlier
>>>> code (to check whether it is supported), use it when setting
>>> bandwidth,
>>>> instead of converting it to link rate and then converting back=2E
>>>>
>>>> Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for
>v5=2E5")
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>>>> ---
>>>>  drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>>> b/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>>>> index 56f55c53abfd=2E=2E2dfa2fd2a23b 100644
>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345=2Ec
>>>> @@ -210,8 +210,7 @@ static int anx6345_dp_link_training(struct
>>> anx6345 *anx6345)
>>>>  	if (err)
>>>>  		return err;
>>>> =20
>>>> -	dpcd[0] =3D drm_dp_max_link_rate(anx6345->dpcd);
>>>> -	dpcd[0] =3D drm_dp_link_rate_to_bw_code(dpcd[0]);
>>>> +	dpcd[0] =3D dp_bw;
>>>
>>> Why do you make this assignment and not use dp_bw directly in the
>call?
>>=20
>> Because the dpcd array is then written as a continous array
>> back to DPCD=2E
>>=20
>>>
>>>>  	err =3D regmap_write(anx6345->map[I2C_IDX_DPTX],
>>>>  			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
>>>                                                       ^^^^^^
>>>>  	if (err)
>>>> --=20
>>>> 2=2E24=2E1
>>>
>>> BTW, my version is only a bit more verbose:
>>>
>>> https://patchwork=2Efreedesktop=2Eorg/patch/354344/
>>>
>>> 	Torsten
>>=20

--=20
=E4=BD=BF=E7=94=A8 K-9 Mail =E5=8F=91=E9=80=81=E8=87=AA=E6=88=91=E7=9A=84A=
ndroid=E8=AE=BE=E5=A4=87=E3=80=82
