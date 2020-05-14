Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65BA206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589451749;
	bh=vn9+hIkPzrxXP0cywMdfPNthAJJoU2dMAniEk9LTg0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=O6cTg5oevQ/iKDyFL5mpYXEF5tILVIHetq4QmPHJw8KYZTCnkmsztRf0KZ02Z/fe0
	 vXDYQee/R8leezxdJoXH1CX3B4v8Iv5tzdslXuD1WlGNHYMM8en8tHTuvSjC2hBljA
	 pWc7zmnXxTIwzRjLwcPS+XRldPyZgGv7VLFoniJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:22:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF488C061A0C;
        Thu, 14 May 2020 03:21:59 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so2145099lff.9;
        Thu, 14 May 2020 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BCPye0pUcJCrk1mGrs7j2KRmFPfxGUAT389d2jmnUgA=;
        b=YHESanEIwOFx7yqx5nXb7MOmP1hbxGBQl8oiuq/VNYK1KZX1rXsZpHig2eMC5eb2Fx
         9dKmYw5CM1cjQCVC2AiUG5qPL5Ua1ZWRM9yePwUNevdq2fKcBkYoaH0PDq1FQSR4hNwX
         ZxRrmYeoZ3bbndjHKMX2HEFQX9K3O704YYKZC6dv+2siHCY0ulkVVh5/SmdUXQfBPsVS
         DCaTQ7kaLOqDIeL16WawA/z1xFV+CwLUhX3OoT5akSwzDgP1NIv8/vrTLenIbb3VohEf
         tinYb5hl5eeSEiLAJ7yRY5XB1SGSA3E5th8YBUL+q/sO6L2DchdEtwmkNSjRHd96wuPO
         XZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=BCPye0pUcJCrk1mGrs7j2KRmFPfxGUAT389d2jmnUgA=;
        b=OZCOp+Kmn2KqjXCrSe5UPoeyZXS8wn/TTWLj+wgU/GEj0GLI82oL4UPzTB/qpdkn5W
         t7tjJx9n6LpZnx/ikXznYV43H4HUDEB949gmWh/fHyMJ8kh6Zm7FQb0knAbW+PjlcJ+g
         aqNf8incK9zUzl75uie3ClfWR5CpyRyk42jp3jrma+Ao7TsqtmTYlyoZ1xGk9ASzl1I+
         XotYDegh4osq/c1/H9KO82oatMWKP2rUBVtKi1YZncY78XQfZc9/Bawl1aUu2AVwqszz
         WHNotJu6qFwQtsO6GenSkUxbdPJg07SajHBclcFCKdbvTTTX9SfAraUruT4JWTjd5upi
         Dt6Q==
X-Gm-Message-State: AOAM530avmkD31bL9EWG0CLedwM5o1ItbSUeaIyi0Y1OT1Ee/JozsZKb
        3kmEv/P+vTaYaFiv0dQi6K/F4S1OFoa6nw==
X-Google-Smtp-Source: ABdhPJwSFr86hBYlDBf0+PbPXxKc+kC7s2B9GDldm15Xqs3P7Se2TIbnDsS5P/MfAEp4LzIbExD5QA==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr2886505lfb.208.1589451717935;
        Thu, 14 May 2020 03:21:57 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id h11sm1554137lfp.22.2020.05.14.03.21.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 03:21:56 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     robh+dt@kernel.org, vigneshr@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: dwc3: keystone: Turn on USB3 PHY before controller
In-Reply-To: <baaaf89c-4baf-4218-e22e-53cd1a64ec02@ti.com>
References: <20200513130709.10239-1-rogerq@ti.com> <20200513130709.10239-4-rogerq@ti.com> <1589420265.5899.0.camel@mhfsdcap03> <baaaf89c-4baf-4218-e22e-53cd1a64ec02@ti.com>
Date:   Thu, 14 May 2020 13:21:52 +0300
Message-ID: <87tv0i4y0v.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Quadros <rogerq@ti.com> writes:

> On 14/05/2020 04:37, Chunfeng Yun wrote:
>> On Wed, 2020-05-13 at 16:07 +0300, Roger Quadros wrote:
>>> The Local Power Sleep Controller (LPSC) dependency on AM65
>>> requires SERDES0 to be powered on before USB.
>>>
>>> We need to power up SERDES0 power domain and hold it on
>>> throughout the reset, init, power on sequence.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>   drivers/usb/dwc3/dwc3-keystone.c | 47 +++++++++++++++++++++++++++++++-
>>>   1 file changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-k=
eystone.c
>>> index 1e14a6f4884b..46d46f3507fc 100644
>>> --- a/drivers/usb/dwc3/dwc3-keystone.c
>>> +++ b/drivers/usb/dwc3/dwc3-keystone.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/io.h>
>>>   #include <linux/of_platform.h>
>>> +#include <linux/phy/phy.h>
>>>   #include <linux/pm_runtime.h>
>>>=20=20=20
>>>   /* USBSS register offsets */
>>> @@ -34,6 +35,7 @@
>>>   struct dwc3_keystone {
>>>   	struct device			*dev;
>>>   	void __iomem			*usbss;
>>> +	struct phy			*usb3_phy;
>>>   };
>>>=20=20=20
>>>   static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
>>> @@ -95,8 +97,44 @@ static int kdwc3_probe(struct platform_device *pdev)
>>>   	if (IS_ERR(kdwc->usbss))
>>>   		return PTR_ERR(kdwc->usbss);
>>>=20=20=20
>>> -	pm_runtime_enable(kdwc->dev);
>>> +	/* PSC dependency on AM65 needs SERDES0 to be powered before USB0 */
>>> +	kdwc->usb3_phy =3D devm_phy_get(dev, "usb3-phy");
>> Use devm_phy_optional_get() instead?
>
> Indeed, it seems better suited.

patches 1 and 2 are in testing/next

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69G8AACgkQzL64meEa
mQa11Q/+LJkpCuNcO49WcpIjbeMQZDjgBgMtNIDOq7wYX2aIP/ZFb3GhrdLLwe/H
3ZpoOTl5/KcJuF5BjMBt/7t+VdwP0Naw2Z8542e/OKzr/xVANOXmWN9ERujcVZy+
l50KeoG3eycU5UAoyJN2lAAQV05TNotjTrSl15eClSUbo+FPUYbAyqdu3SZyNrGh
O8mswueuV3BqznAbMh5dje+Rixdqr0gPYLj2RHnZYSHtWfNFyy5CT2fVikA45RZj
5dL43DHtbR+Z4MyivdvFtHClS4EvySngRTGhLvtYORLWfP7M8LiBIa1WZ4S0d6iV
A7lTlwlw3bE4/5uiGYqtM+SS5gDPu3wlyMhofhqKJlJAvV+DvTkaNLb7DI7lmDqU
CXK8dGcLBtv8D7XyXBHY1FdZ86sXvz4NYrNcoJlldakk+CY7iLrV0c2SYG65Dm0x
vLBCy2nWFq+tQ0tUYTU8rMGURDkASreb95XvyTh4+Ow6xY3/9MWFoAR16MSBx5r9
Lz6xXWWVKrQeNTPl6INJuuN9XBXVOwYRNfYhrpbAnB3/bR7WADCY+UNmUGK1RmRK
AU5zkyqPaamXy5+B6z6gL7KdOx0h5FEMm0J4advv32EFlBRTEi3KQm/lHGsxEnBt
r7DSou4RpmjBMnx/bDRVPY5l5g31mjEbYRX4wR+EuXbO3jgHv6s=
=QLsY
-----END PGP SIGNATURE-----
--=-=-=--
