Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F16C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C532083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="g2AtxI5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgHaVmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:42:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:19221 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgHaVl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:41:59 -0400
IronPort-SDR: +la8orjmX8sPxeR7RZFxiEg0HF4CL9O8eRTGTp6QdAx9nY30EOr0U+0K5wNPFNbaMeJeIy82Te
 h9waH9ecgCpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="218618008"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="218618008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 14:41:58 -0700
IronPort-SDR: xsDu+HXwCjZgnhkOvSJFq4inHPwDxjwIeCuGEXYS4N4lrgI77SmYoGJVcI7i2Mf7kW0rMrOv59
 dYjoM0EemTmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="281762638"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2020 14:41:57 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 31 Aug 2020 14:40:53 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 31 Aug 2020 14:40:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 31 Aug 2020 14:40:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 31 Aug 2020 14:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVMXCUCFidXDJLKIM2SsTxM7ZStkz+Gs1o5UWAHmpClv5obBDej2lScfiFHg6ZLGNCtmcNr1lwycwq5Lk9xswH9MBUNjlP2I7Yq6yKyRbWVyPAkTi0UprZS0nhsvp0uQMAc9Zu3ZiQn0+sLW8rd2y3Z+NiyRedG3C9RL2ijO50WEM5NML7B4k+1XHLgztGjGTKSxdtVJSRPtlW9wjvlUgKW0ENG009i4cqgBWYlwlUdqYpBCG1h9NzvqdezOGWk8+01GUsO/hAtmsLS3x1XAl1L9fAYoyezX/voArTusY8PHvjMatSqAIViB8QLuyaRz5R/8OZR9wDWyM4N+gjwbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH5KPY1BCKm9UJOb7Nzs8sZl0NtMsKLW6kvU26Bay/0=;
 b=mKqk96P2zGnT2cp+srvYBiow4A2ww02FfY/MBFZDJlZKN9ucIU8SVNfeKkfDfPf6QZ1lK9ChAe4VxEhIADkPfSpmWB6S8TjvihfPD11nleZuO/hi+JosAcvI/9aJYlPxXuyfvzfUsYpFIDAhqUQIs5ckyg6Fm6NiT7wHdBXEzfobCIE6K7MMEyvJJhFue8FQCggj3+52P1wu9iskP5gpCxulb1huJhGc5imSVKF92RB3Ly7b5AXz+hr34mYyJXo8alJAq8oh2efjSDX4YtFH5CkIdlLT1XKbsajZcrXWKwTij5VWd5cnl/cj5ElN6ELuJUtDQlKTGjiJPmOvX7LcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH5KPY1BCKm9UJOb7Nzs8sZl0NtMsKLW6kvU26Bay/0=;
 b=g2AtxI5voZqXk3cFbpXY10+jBXSUED9TsqjG3OKKfm5huVKnOD+iVBfu0vdZHmKr3qxy8wjtWy/v9Vn/d30BIbZaJkcWzJLah/Xz2aciDP0lCI4tR/RJ43cRrCfdattUbgcst3YolKDBgPELD5+MKlPKblQpU0VKxxvolxDfWSY=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM5PR11MB1499.namprd11.prod.outlook.com (2603:10b6:4:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Mon, 31 Aug 2020 21:40:52 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55%7]) with mapi id 15.20.3283.028; Mon, 31 Aug 2020
 21:40:52 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Thread-Index: AQHWeD6ZmieVJ7ILtEmVT73DLNf2fqlNLX2AgAAXoACAAGapYIAA/qCAgAQfx0A=
Date:   Mon, 31 Aug 2020 21:40:52 +0000
Message-ID: <DM6PR11MB396318BBCF00D2327711AC0AF6510@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
 <DM6PR11MB3963228D43B50604AE4D0F3AF6520@DM6PR11MB3963.namprd11.prod.outlook.com>
 <20200829062719.GA80106@kroah.com>
In-Reply-To: <20200829062719.GA80106@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6079498f-1fc2-4249-c1b3-08d84df688a9
x-ms-traffictypediagnostic: DM5PR11MB1499:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1499DCC0FE9CFA7B335003E5F6510@DM5PR11MB1499.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/8l8d6DUkDzhZGU0qJu4CIEwnfq8+Ozv/FvoRzY7Opn07abd2hLDjtr68yiw0Euul8ADvkZdhhCubC9Ie0aQmVMcFkv0UHpYkz3DpUjQk1aj851Q2J7Hmp66Kkl7uA4v1jWRRBtvvChHtCQixvXJ24V+JJDu/PuRGM30y1GlwuHxuaCZz9yDeGczL5icRz8cSe72AFlqCP/rCm12YmhTHdkOcwdBO13kUPM80+sIqQzdts72WNIdwnm3fGUPdLWC/hGSWX00Wz0zzto5/rf8maBHkb49DRsl40ehwzBQZOQH98FKKc9jWLpdN7N6eeJr8Mge9NEWeTLw6RQ04DRwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(64756008)(66556008)(66446008)(71200400001)(54906003)(316002)(6506007)(86362001)(478600001)(52536014)(7416002)(83380400001)(5660300002)(6916009)(7696005)(66946007)(76116006)(2906002)(66476007)(8676002)(8936002)(26005)(4326008)(55016002)(9686003)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9rbeI+E9LK4M/xK/D+6OHXI/76A4Zx6dBzJrfzJwpQ1eXTipNCKS/K8OPTQrLYNW4wxj5YZvKa3FF8MUJHcFTSx+JjvWOgo3kqzMhv6UPWVLQhgGgT0r6eryAFpAjYEpqXPZDUun0JIDgYzYY9NSpsOmt2byg04X5SHe7SmxKgSIGygiBeCYOmfqXccWGEO+fXuPNkYWqHxezzZJ7ARW4FESq/NE5Z/G9ShjhtFLRDjLVGIZJCmqY+HKS8mkMMUg1o8DoZP9G/gEWkFssQsfVPmi1L5Dd38TSqMOR1qezRljo2ppi6bb2Rk/g63B/t4uSe/r8DUlh8I22R+ZJ6q1HfNWSxim/YyZbkOEUJHCl/gaCDk5tLP9syfczuiZtd6Je4q/glBgo96XWq18e3WohPcD3quP04rlUT8/OGq9S3F2WouL9uXr2kyBgF/wWYvoSr2udP8Sknpj/wgYTSZ/F6FA3VClTG9E8tLiZLbm5HFOx2tfoqGWLk+/UPZFu1ksl5eQq1uewuBmgHEmanTK0Adsc16mahUhZnbkDmjrVzrYV54wfnm2iT/zmgpvtNLJhHbM5clPgRzvo51PEwLmJNgqNzjfpTuM0KUn9UQQ0iTWmUchE4bz9Tbe/xg6OrZX/FwkEQ4Gj8cCzcLwkiwqWQ==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6079498f-1fc2-4249-c1b3-08d84df688a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 21:40:52.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5y0LTxOm8lg/JmkP5RshoMBG/gTjaXvVEkU/A7mjDu2W3SQSY9VK4PQHMQXYsFd1lOmWH0sw8zzOsVd0AVy9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1499
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
> (IOM) driver
>=20
> On Fri, Aug 28, 2020 at 03:20:22PM +0000, Mani, Rajmohan wrote:
> > Hi Greg,
> >
> > > Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output
> > > Manager
> > > (IOM) driver
> > >
> > > Hi Greg,
> > >
> > > On Fri, Aug 28, 2020 at 09:43:59AM +0200, Greg Kroah-Hartman wrote:
> > > > I still find this crazy that a whole separate driver is created
> > > > just to read a single 32bit value.
> > > >
> > > > Why not put this logic in the driver that wants to read that value?
> > > > That would be much simpler, smaller, and more obvious.
> > >
> > > That would mean that we start maintaining something like DMI quirk
> > > table in those drivers. Unfortunately the IOM device is not available=
 on
> every platform.
> > > Also, even on platforms that do have it, there is no guarantee that
> > > the device is always going to be mapped to the same address.
> > >
> > > Nevertheless, I was originally hoping that we could hide the
> > > handling of IOM somehow in ACPI without the need for an actual
> > > device object, but it now turns out that the other features of the
> > > IOM chip have created interest. At least our i915 guys probable have
> > > some use for it (I don't know exactly what they are planning to use i=
t for).
> > >
> > > So the fact that we may later need the device for something else, on
> > > top of the clumsiness and most importantly risks involved with using
> > > ACPI to take care of extra tasks (ASL tends to have bugs - bugs that
> > > may never ever get fixed), I think the IOM device object, and the
> > > driver that binds to it, do have a valid reason for existing.
> > >
> >
> > Intel PMC USB mux device is part of the PCH, while IOM is part of the S=
oC.
>=20
> I have no idea what a "PCH" is, what "IOM" is, and how any of this relate=
s to a
> "SoC" :)
>=20

I was just meaning to say IOM (Intel Output Manager) is a separate device, =
that
is not part of PCH (Platform Controller Hub) like PMC (Power Management Con=
troller).

For the sake of completeness

PCH - Platform Controller Hub (usually that handles I/Os in Intel core plat=
forms)
IOM - Input Output Manager (IOM) is part of the Tiger Lake SoC that handles=
 Type-C
topology, configuration and PM functions of various Type-C devices connecte=
d
on the platform

> Don't impose arbritrary hardware "splits" to kernel code when the kernel =
has
> no such "partitioning" please.
>=20

Ack.

> > This was another reason we had to have a separate ACPI device.
>=20
> That sounds like a firmware issue you can solve in UEFI.
>=20

Ack

> I think this is the most TLA-laden email I have ever written, and I used =
to work
> at IBM :)

I thought it was only Intel where TLAs are abundantly used.

Thanks for the reviews and the direction on this topic.

>=20
> greg k-h
