Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0054C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A372074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tIEn8cOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgHXWUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:20:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:57907 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgHXWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:20:05 -0400
IronPort-SDR: Nsw/iCe5hUBUMf/mMGtvrrU2Rf7eaPl33gEgjgibRVVhzAoPP0e7KBbOzWkkxUeVV9KLlcYfFw
 wQc/B3zJ27ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="155254781"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="155254781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 15:19:32 -0700
IronPort-SDR: EUBWpFIiJdVVlmUKluSJ3mBfkJpuzfemwrkuGjsv0AeWF31BL7Bf1KOnN+my1H/2gN/c0kpN0S
 K26mf5WMgI8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="499632512"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2020 15:19:32 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 15:19:31 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 15:19:31 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.58) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 15:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHBwwx4pvl0ASIZAFJvztxkcUkZms5nuiCcqqg5lMebcaS/fQDtpz4oqDLdjcGeihbpRc5AxS+g6qiFfDh+ifACSR51QmKL6rAPMEqiOdRwE1LCKHxfb4SJBG6VKmRB3aT2kCuID04RlOdd/HrtZcEVlHMezAUmJ/BQBAiEUAPn6WtVXAs31Qz+uhWErjA0NFjJ4GcjZOZaZO2Q9qUxukzONkMHpVg/YfhaVDB2ba2MzliM21Cr2RxiX07f1Qszs3pxJXXMo5+z310ur2XyDmoGuhg74EhqAhGRtALzZk8B4pNvjh2fFwxVIV5KSaOQchG4h4l+f4T5fqiszZUqvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTmr39shLRz0HzBm3xclvWORYM6q24SNJ/eBNkzgAww=;
 b=k8ESJzTxkHR3pZe4CZDPw4wRm1ifvKE7vmN5DQpB8AdC4AbY+CPBnuNh3bLwvhlbix2ZdecFqKHtOzLGOhUpXwzCHaFN1Igy/0qYGRkaJeT3rQxYFNK0wonsVo2PP/PHtwhf+b+21W7JVIUmEIHHgai35Owj34p0ND3RGHVHCbh844J5GpDVf5Qakap57ylJZyP+4CNz6KAEgcDzqSMD5JK1MO87zqrnFnmeb/UuvmArta4Oiuz1LMcqtilXgXLhVzbjoJxhqOSZ6Wpc6k2GjUbXTL/2k+md9EWE6fCA8CAvDWUQn9aIB0FxqUunnPg0aP2PZI9kNPft7ckE+fLOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTmr39shLRz0HzBm3xclvWORYM6q24SNJ/eBNkzgAww=;
 b=tIEn8cOiY5zEU38JNnqCc/IzHJxwMjl/ECHK58J2pCawVusWwbO2zQRbnIEoXYc2bcrE82A2ffm/iW9tzHuPTzC4GMeMwUo7ZIEFPvcrzEtiTxAaBHAAWUVnkNoDWj/MWnGZrxyViS5jLTNhQOUyln20/ousoqRFP+TDP1YAoyU=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3610.namprd11.prod.outlook.com (2603:10b6:5:139::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 22:19:27 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55%7]) with mapi id 15.20.3283.028; Mon, 24 Aug 2020
 22:19:27 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?iso-8859-2?Q?Bla=BE_Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Thread-Index: AQHWeD6ZmieVJ7ILtEmVT73DLNf2fqlD5IiAgAPw3+A=
Date:   Mon, 24 Aug 2020 22:19:27 +0000
Message-ID: <DM6PR11MB3963121C820F570F845BBAEEF6560@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200822095631.GB2553024@google.com>
In-Reply-To: <20200822095631.GB2553024@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7b589fe-08ab-4894-3a5d-08d8487bc395
x-ms-traffictypediagnostic: DM6PR11MB3610:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3610F16149729908F32B5943F6560@DM6PR11MB3610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EDKUzWijRH+mLLPRu1TvvUfcNfw9tgPA9jwFVoCvPWXgJei5BZEPN6hn7cauDN1xPkQIaJlD+6zQjv8RM1FrcZrnBk68HKi3vzduOL8ON5i322qOZ6azp39OxfQ4hqiiZ6af5JrkYTNfSr3zt8hLpgTtzvOayWG/oCy1snvZO5LHvKAThxxHGNIeEk1Mv6mp5hN8HuA+th7yUBuRk6GCGElMwUwOkNwE5hJObmotaEYoxcmctwyUvwbLo8af7G1famIifZs/3BvFJIXNHZ1+nMRJEsfmkVl7cR4mlT7RPfnKusHjWSMSpPrBcEKV+FtH+g3R6I2Dr65KCUicwYKIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(4326008)(5660300002)(8936002)(7416002)(6506007)(9686003)(66946007)(33656002)(76116006)(66446008)(66556008)(478600001)(186003)(64756008)(71200400001)(83380400001)(7696005)(316002)(26005)(86362001)(52536014)(8676002)(2906002)(54906003)(6916009)(55016002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2sjThVfbtbWsNb9282OowIR0jphLFTYhvxF4XdF4q0/O8BA/7T/7wS6h2ZYknp0ijJRx7xix/uuX9ynQiUJLAr1SiL9CHUamA1uHKNDHXOvZUCKqGmNUNqw7mKBurNGEd9iAvMCtA9c04R9pYBwTcrrWCEztS2MviX5z43vooWJsmPpZLEQ9+Z6dnrBeknM9sG6PqCGkNiGS08Yx6VM2YIb1SKC2y7lH688uMd6+Tz++BbM4vN7iIDzseAkb46qCQqeveA69xYzq26c4yVa7/p2vP3nl3PTJKrcutFHARU9kyCK7iBa5AYgZCQZYGD8+1h+QJIxEqwDkkVXL+sCHMH0ZbG2E11t2hDBYdUlvAOaUrHTyS/U/Moq6jojrb+3GC5ZO0JPSxxfmm/aR/HyGjZ3r3jmurzTbESZduio0ed9+0adcfs8v5+yvEUhtczUGZdWE5bnhZ3mirjRCQJuVUIXVbeyljMa2/HUcyoC4qrvxVUUu/kh5J8eNUsWnSCJqnxcfjB9Q+JsvxCTflRtgIrYpgbPb7RyAcZTjJbDSIV32Vo5oYwyFL73ovrcby+8uaBnA0vuk7asJ8rOIgF2F8axqCCLgrbSf4MSYGsZ3wshrmSZN9VqBam/FlbUwc2/RuDmYVbtoWivDpXk7UA31Sw==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b589fe-08ab-4894-3a5d-08d8487bc395
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 22:19:27.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CK7v6d/OunEr6kYEoeaaSe4M98uc53UPboFkO9/5lIgby+Xz4U3TMq83pGTCXqnUoiMVKaELE8TNFlq7RdhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3610
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thanks for the quick review.

> Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
> (IOM) driver
>=20
> Hi Rajmohan,
>=20
> On Fri, Aug 21, 2020 at 09:05:06PM -0700, Rajmohan Mani wrote:
> > Input Output Manager (IOM) is part of the Tiger Lake SoC that
> > configures the Type-C Sub System (TCSS). IOM is a micro controller
> > that handles Type-C topology, configuration and PM functions of
> > various Type-C devices connected on the platform.
> >
> > This driver helps read relevant information such as Type-C port status
> > (whether a device is connected to a Type-C port or not) and the
> > activity type on the Type-C ports (such as USB, Display Port,
> > Thunderbolt), for consumption by other drivers.
> >
> > Currently intel_iom_port_status() API is exported by this driver, that
> > has information about the Type-C port status and port activity type.
> >
> > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > ---
>=20
> Perhaps include a version log of changes since v1?

Yes. It's there in the cover letter (patch v2 0/3).

> > diff --git a/drivers/platform/x86/intel_iom.c
> > b/drivers/platform/x86/intel_iom.c
> > new file mode 100644
> > index 000000000000..cda7716410c6
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel_iom.c
> > +int intel_iom_port_status(u8 port, u32 *status) {
> > +	void __iomem *reg;
> > +
> > +	if (!iom || !iom->dev || !iom->regbar)
>=20
> Do we need to check for !iom->dev and !iom->regbar?

It's a good practice to have sanity checks on pointer members dereferenced.

So I can lose the check on iom->dev, but prefer to keep the check on regbar=
.
Let me know if you feel strongly about losing the check for regbar as well.

> Is there a valid situation
> where iom !=3D NULL but iom->dev and/or iom->regbar =3D=3D NULL?
> Sounds like it shouldn't, but I may be missing something.
>=20

I think I am being conservative here.

> > +		return -ENODEV;
> > +
> > +	if (!status || (port > IOM_MAX_PORTS - 1))
>=20
> I think parentheses around "port > IOM_MAX_PORT - 1" aren't required.

Ack

> > +		return -EINVAL;
> > +
> > +	reg =3D iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN *
> port;
> > +
> > +	*status =3D ioread32(reg);
>=20
> Perhaps just inline reg within the parentheses?

Kept this way to increase readability. Let me know if you feel strongly tow=
ards
inline reg.

> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_iom_port_status);
> > +
> > +static int intel_iom_probe(struct platform_device *pdev) {
> > +	void __iomem *addr;
> > +
> > +	/* only one IOM device is supported */
>=20
> Minor nit: s/only/Only

And then I may need to end the comment with a period.
Let me know if you feel strongly.

> > +	if (iom)
> > +		return -EBUSY;
> > +
> > +	iom =3D devm_kzalloc(&pdev->dev, sizeof(*iom), GFP_KERNEL);
> > +	if (!iom)
> > +		return -ENOMEM;
> > +
> > +	addr =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(addr))
> > +		return PTR_ERR(addr);
> > +
> > +	iom->regbar =3D addr;
> > +	iom->dev =3D &pdev->dev;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id intel_iom_acpi_ids[] =3D {
> > +	{ "INTC1072" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, intel_iom_acpi_ids);
> > +
> > +static struct platform_driver intel_iom_driver =3D {
> > +	.probe =3D intel_iom_probe,
>=20
> nit: I generally see ".probe" listed below ".driver".

Ack

> > +	.driver =3D {
> > +		.name =3D "intel_iom",
> > +		.acpi_match_table =3D intel_iom_acpi_ids,
> > +	},
> > +};
> > +
> > +module_platform_driver_probe(intel_iom_driver, intel_iom_probe);
> > +
> > +MODULE_AUTHOR("Rajmohan Mani <rajmohan.mani@intel.com>");
> > +MODULE_DESCRIPTION("Intel IOM driver"); MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/platform_data/x86/intel_iom.h
> > b/include/linux/platform_data/x86/intel_iom.h
> > new file mode 100644
> > index 000000000000..e4c9a305e7a9
> > --- /dev/null
> > +++ b/include/linux/platform_data/x86/intel_iom.h
> > @@ -0,0 +1,49 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _PLATFORM_DATA_X86_INTEL_IOM_H_ #define
> > +_PLATFORM_DATA_X86_INTEL_IOM_H_
> > +
> > +
> > +#define IOM_MAX_PORTS					4
> > +/* Register length in bytes */
> > +#define IOM_REG_LEN					4
>=20
> Do these two #define's need to be in the header, instead of directly in
> intel_iom.c ?
>=20

Ack. These 2 can be moved to .c file.

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +int intel_iom_port_status(u8 port, u32 *status);
> > +
> > +#else
> > +
> > +int intel_iom_port_status(struct intel_iom *iom, u8 port, u32
> > +*status)
>=20
> Should the function signature be the same as the #ifdef case?
>=20

Thanks for catching this. I missed it.
