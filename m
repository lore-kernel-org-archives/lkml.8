Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE20B20FC3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598963141;
	bh=w1eqcuExBwNC/dwFeUGjiY+pkVmT0T28v6Rbi4XthJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=KRRc4odHwfcXVaMOnY6ZchjoCx3CAr+xfPdCylrXU6cbjpkJ5rBhz+MWGvJa+Ch5O
	 Er4YyOFKaDr76TBgDCbk3O5CaEx2o6wQQFTjonUlFx8ixDwm33AMBZaCTBX+AOhySY
	 JwAAq1xDZdCwxfTNuhHN0kQuU9r3f5NRk6K4YL/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgIAMZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgIAMQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:16:34 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A53A206EB;
        Tue,  1 Sep 2020 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598962519;
        bh=w1eqcuExBwNC/dwFeUGjiY+pkVmT0T28v6Rbi4XthJ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tbLlda0K5g5tuBPuhM2C+d3cU+xjdFgqP6DvILxucbbT6avDl32SZtaXQDDvexkCk
         E2wb/nyz3H2yZ1Htid3oP7zVDaidIh8DJPPxKZ24VOm+r+28N7Yc8aZKTeBTuLex73
         UhwfU4lPFeOVs+L3PwSPYkOFDbzgRdQ3bqpH9fe0=
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
In-Reply-To: <BYAPR02MB5896669D47783D06F779608BC1520@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
 <87y2m0ioql.fsf@kernel.org>
 <BYAPR02MB5896669D47783D06F779608BC1520@BYAPR02MB5896.namprd02.prod.outlook.com>
Date:   Tue, 01 Sep 2020 15:15:11 +0300
Message-ID: <877dtd7kxc.fsf@kernel.org>
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

(remember to break your lines at 80-columns)

Manish Narani <MNARANI@xilinx.com> writes:

<snip>

>> > +		goto err;
>> > +	}
>> > +
>> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->apbrst);
>> > +	if (ret < 0) {
>> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
>> > +			__func__, __LINE__);
>>=20
>> 		dev_err(dev, "Failed to assert APB reset\n");
>>=20
>> > +		goto err;
>> > +	}
>> > +
>> > +	ret =3D phy_init(priv_data->usb3_phy);
>>=20
>> dwc3 core should be handling this already
>
> The USB controller used in Xilinx ZynqMP platform uses xilinx GT phy
> which has 4 GT lanes and can used by 4 peripherals at a time.

At the same time or are they mutually exclusive?

> This USB controller uses 1 GT phy lane among the 4 GT lanes. To
> configure the GT lane for USB controller, the below sequence is
> expected.
>
> 1. Assert the USB controller resets.
> 2. Configure the Xilinx GT phy lane for USB controller (phy_init).
> 3. De-assert the USB controller resets and configure PIPE.
> 4. Wait for PLL of the GT lane used by USB to be locked
>    (phy_power_on).

it seems like you need to extend the PHY framework and teach it about
lane configuration.

> The dwc3 core by default does the phy_init() and phy_power_on() but
> the default sequence doesn't work with Xilinx platforms. Because of
> this reason, we have introduced this new driver to support the new
> sequence.

Instead of teaching the relevant framework about your new requirements
;-)

>> > +	if (ret < 0) {
>> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
>> > +			__func__, __LINE__);
>> > +		goto err;
>> > +	}
>> > +
>> > +	/* Set PIPE power present signal */
>> > +	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
>> > +
>> > +	/* Clear PIPE CLK signal */
>> > +	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
>>=20
>> shouldn't this be hidden under clk_enable()?
>
> Though its naming suggests something related to clock framework, it is
> a register in the Xilinx USB controller space which configures the
> PIPE clock coming from Serdes.

PIPE clock is a clock. It just so happens that the source is the PHY
itself.

>> > +static int dwc3_xlnx_resume(struct device *dev)
>> > +{
>> > +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
>> > +
>> > +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
>> > +}
>>=20
>> you have the same implementation for both types of suspend/resume. Maybe
>> extract dwc3_xlnx_{suspend,resume}_common() and just call it from both
>> callbacks?
>
> Going forward we have a plan to add Hibernation handling calls in
> dwc3_xlnx_suspend/resume functions.

at that moment and only at that moment, should you be worried about
splitting them.

> For that reason, these APIs are kept separate. If you insist, I can
> make them common for now and separate them later when I add
> hibernation code.

It would be a little better, no?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9OO08RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbnZhAAogpmjBBuZIXS7unOPfqYJzaDn/sbVhxl
5XjfTD972ymt0FUMyegO3k7iSdh24mUA1F4O3HBDai5FnOloo3SY1f1BXAImeSGW
qg8xSr9hDWg9cUX5znkpch5W3KCLwHU9IASBPqAsW4AWGstIt5cXkiREYA4G0jf+
I64Bnwxhd8gQ85OjYTSu8c2+Sj/HYrvuLLZyO4rBBjRNQNTLodMVIQ8mgDERGMW3
/s76/RGTedS+/k2XWDN6fKyu8p2ojWM++J9k2K9r74dzUK0DLMrhlxXU81OCWPY/
dBZYJIUMk1WbB5w0lzZRXIbOkNP44ryF5R7ReEJvRc/4RtxapJD0Vkk/jrVAW1fQ
IBzgSoigsEW5TQoRtH68CqeA/QVen0DH4SAFjWolnsJ2OBEiqlg1I+vgs7lHVc8G
EBk9qfpJ1JDIiveH8tcoLuSjbWJjKhBObEdxEaQuDlxpU3LdlTAPLWghtQtTYV2U
N2rVej79rSz6j6TnQ3f6pJVLlXV5GmeOcir1iR/0EDkGjM/0zSuzi489vvJWHP8z
ejL19F4+kxwxiacvLsyRhcaaLzSRatGqdcoBzwaav5Eu26YfUlt/QNCQdGbJVaLH
gwNWLbeBeBlv0PGbnHB/YBfGoOgaREb1vDfIOe4h7QWqF9Yfo3TDXmpHr1TWQqsM
7R7Rhz2c1QU=
=dH1X
-----END PGP SIGNATURE-----
--=-=-=--
