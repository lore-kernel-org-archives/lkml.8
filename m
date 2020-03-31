Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00FC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A98206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="viJtbtjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgCaNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:09:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60992 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgCaNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1585660186; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnwtTc/EcdatrYJ8xwpC2XqSDdEDN2As8dDKoKSgRsY=;
        b=viJtbtjDgLg/oVj83f6PuXcpO19M2ildvSP0Bd4WrZNicQgd24xrsOLQouZkLa+AoD1aSW
        kT1G4jj3UXQ0vO+XMtD5HJLk7qGBT4mLhaP7QYufe4teGm/pxJTg9v5PHKclz+kZNqIbcd
        DSq8s2JHVAWDNEhScJaAfpMsFpH+z+4=
Date:   Tue, 31 Mar 2020 15:09:33 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        =?iso-8859-2?b?UGF3ZbM=?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <X7728Q.UX8A28S31JO92@crapouillou.net>
In-Reply-To: <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
References: <20200312153411.13535-1-paul@crapouillou.net>
        <20200312153411.13535-2-paul@crapouillou.net> <20200313090011.GB7416@pi3>
        <CGME20200318142549eucas1p1793027850923ebad20b4691cba676671@eucas1p1.samsung.com>
        <D6.31.03891.A6F227E5@epmailinsp8.samsung.com>
        <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>

Hi Marek,

Le mar. 31 mars 2020 =C3=A0 7:36, Marek Szyprowski=20
<m.szyprowski@samsung.com> a =C3=A9crit :
> Hi Paul,
>=20
> On 2020-03-18 15:25, Paul Cercueil wrote:
>>>>   +    };
>>>>   +
>>>>   +    tsp_reg: regulator-1 {
>>>>   +        compatible =3D "regulator-fixed";
>>>>   +        regulator-name =3D "TSP_FIXED_VOLTAGES";
>>>>   +        regulator-min-microvolt =3D <3300000>;
>>>>   +        regulator-max-microvolt =3D <3300000>;
>>>>   +        gpio =3D <&gpl0 3 GPIO_ACTIVE_HIGH>;
>>>>   +        startup-delay-us =3D <70000>;
>>>>   +        enable-active-high;
>>>>   +        regulator-boot-on;
>>>>   +        regulator-always-on;
>>>=20
>>>  always-on and boot-on should not be needed. You have a consumer=20
>>> for this
>>>  regulator.
>>=20
>>  About this: the touchscreen driver does not use a regulator, so I
>>  believe that's why these properties were here.
>>=20
>>  I sent patches upstream to address the issue:
>>  https://lkml.org/lkml/2020/3/15/94
>>=20
>>  I believe this means I cannot merge the i9100 devicetree until it is
>>  acked.
>=20
> One more information - similar change has been already posted, but it
> looks it got lost then: https://patchwork.kernel.org/patch/10550903/

I was aware of this patch, but didn't know it was sent upstream.

This other patch uses two regulators, vdd/avdd but doesn't give any=20
reason why.

Pawe=C5=82, is that really needed?

-Paul


> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>=20


