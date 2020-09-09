Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEDC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B196B206F4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599647253;
	bh=MG0msxZvjCsJNDApogNfiZrhvSjNoctWQSyL9scydxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=q0IkfDnoG0jFzaAdMBfiDJuYwTEH9colWYefyLL3NH99prk6nysjsRSyR+PJ1vwof
	 i7TxzxSafLJH2mZfjXe+0Uwo0Y75YqGM2t4BSsaTEQA9ID78EoNFE+CTumJVc+yzgF
	 gEVvhbpidjIuseITRQ9zpMmoPlL/AR061IUKPnh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIIK1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgIIK0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:26:51 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9365D206F4;
        Wed,  9 Sep 2020 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599647209;
        bh=MG0msxZvjCsJNDApogNfiZrhvSjNoctWQSyL9scydxs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FedeXmt6fvwowKtOyhe/cRP0eUKyzmP9wPKyX4D8hmyQKsI71a7+ceemLYsWgstGb
         6AI1ZhtZEIyey4iaef9Elcefio4AU1rhrW6bOmUOxuA4pV9zlVKnZkv0PsjObP9Jfe
         pCfjE5Yim1FbmjqPyh80HSWywTyr/fhL2hqU2i8g=
From:   Felipe Balbi <balbi@kernel.org>
To:     Manish Narani <MNARANI@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
In-Reply-To: <BYAPR02MB58960AA4C87C76223C04D71BC1260@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
 <87y2m0ioql.fsf@kernel.org>
 <BYAPR02MB5896669D47783D06F779608BC1520@BYAPR02MB5896.namprd02.prod.outlook.com>
 <877dtd7kxc.fsf@kernel.org>
 <BYAPR02MB58960AA4C87C76223C04D71BC1260@BYAPR02MB5896.namprd02.prod.outlook.com>
Date:   Wed, 09 Sep 2020 13:26:42 +0300
Message-ID: <87blifkzz1.fsf@kernel.org>
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


Hi,

Manish Narani <MNARANI@xilinx.com> writes:
>> -----Original Message-----
>> From: Felipe Balbi <balbi@kernel.org>
>> Sent: Tuesday, September 1, 2020 5:45 PM
>>=20
>> >> > +		goto err;
>> >> > +	}
>> >> > +
>> >> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->apbrst);
>> >> > +	if (ret < 0) {
>> >> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
>> >> > +			__func__, __LINE__);
>> >>
>> >> 		dev_err(dev, "Failed to assert APB reset\n");
>> >>
>> >> > +		goto err;
>> >> > +	}
>> >> > +
>> >> > +	ret =3D phy_init(priv_data->usb3_phy);
>> >>
>> >> dwc3 core should be handling this already
>> >
>> > The USB controller used in Xilinx ZynqMP platform uses xilinx GT phy
>> > which has 4 GT lanes and can used by 4 peripherals at a time.
>>=20
>> At the same time or are they mutually exclusive?
>
> The lanes are mutually exclusive.

Thank you for confirming :-)

>  [...]
>> >> > +	if (ret < 0) {
>> >> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
>> >> > +			__func__, __LINE__);
>> >> > +		goto err;
>> >> > +	}
>> >> > +
>> >> > +	/* Set PIPE power present signal */
>> >> > +	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
>> >> > +
>> >> > +	/* Clear PIPE CLK signal */
>> >> > +	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
>> >>
>> >> shouldn't this be hidden under clk_enable()?
>> >
>> > Though its naming suggests something related to clock framework, it is
>> > a register in the Xilinx USB controller space which configures the
>> > PIPE clock coming from Serdes.
>>=20
>> PIPE clock is a clock. It just so happens that the source is the PHY
>> itself.
>
> This bit is used to choose between PIPE clock coming from SerDes
> and the Suspend Clock. When the controller is out of reset, this bit
> needs to be reset in order to make the USB controller work. This
> register is added in Xilinx USB controller register space. I will
> add more description about the same in v2.

Aha! That clarifies. It's just a clock selection from clocks that are
generated elsewhere :-) I guess a clk driver would be overkill, indeed.

Thanks for explaining. Could you add some of this information to commit
log, then?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9YreIRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZ/zw/7Btf7KF38ujarqULDRAGPcndKWFLsg+zM
mf6UkIlysLp3RK3ADxwyLi+9jwnezvSTQ7wHU1E3jF5aHsVpahXOtkkjS6ffYhyG
LyOGMJNJ1/h4i+QyNs5mkfOTNSP02W0mfd2VrzWse9A1IMqJeoo0xVjrqyZixZEd
6FaO1mfIXfFFQnfS5q5hZo9GYk6HNM929VKs09bX2uJ8qsJqcI+i5SAdxbo+Zp4T
2PxrQtcQEYxjL2R39AbAy6U627ZfEtuHrIOtTV5czMqzPAIfi/88WnXvriT7oOcM
GrvAz+ulf8uSMwNtVc3GUzkFgpppshjoB71WojNxlfbt/5UYLTLyFOfDfPf2i4gE
Q6EKRU3NPJcnt/2letLFfhSow6qnLuCFYCfl6z+8lgbLHoThfmNtUrx4jlVrPFMJ
Sz1bSR5NO82aNvbhOIXWGcyoaiZBpYPX0XVyW0wDEc+dnal4oUE12MxOVhzk6QVz
FqBdmDKXx+jjwwKkWoBONLsTvjScG5PXPMTOMGFffVSnrJ6f8bo1QGuwL8H72uqj
4z44XEbYjiWGFYroG3VsoVJvf/vGjsfud0ZJLesKF37BeaU1jJkbYQQQjLM9WzXY
IZ0Mg04mcVLl1vhCDK3KZH0B/8vMDiUgduLflBtuuxPqVU/wAr74jgLRJMDppBDH
vE++F+UPao4=
=+Qxk
-----END PGP SIGNATURE-----
--=-=-=--
