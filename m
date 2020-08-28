Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50366C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249E920757
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nsF0IyYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgH1PVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:21:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:2231 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgH1PVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:21:31 -0400
IronPort-SDR: UixWlrfHHxv4Bsxc6vR583cEbSId8v+BuzALT96qefDkn/3ISZqMKHIgd3BQS4r6/xWiP3vg1Q
 m8MEFhjULdvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174732904"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="174732904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:21:30 -0700
IronPort-SDR: olOZc4EmGkLy7nRwzWH2pRGdETUx6PhD0O5IFJEyYuyZqb2gHW2UpYyxUh4SJk95N6waoTjA9H
 wctcYFQOq0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="296151842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2020 08:21:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 08:21:28 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Aug 2020 08:21:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Aug 2020 08:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBsLWhFuIXn+iWkXeVULR924uik8Jvvp61+UZQvcRJIiWbiTWTdHuV2XoHxvKmzdffTmnWiho2sEcavZ/iJKWscORiJw5npVhBG7dJB0mhtdo9VJ/RSxNNysPv1GONijRvQhFXWomW+aylMjAIceC4ubxJO5JOVL1aEahmuBHwFY3MLa8JeIjTLRM8yzK6z1FeJLaGHeSEvnpc7csQIM4jefRuidGHQOnHXyptsDru7ENCIuy0RX8GfUNqLjzfR5OuAflQ1G85jGv2tEs0e7c2nX0Idx5KWjSTIpbP8NSUiT8YLfuy6tTAH8VY50pJgSCt+k5cw2Xi0aB7ix+FFQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P7byHzAk7kAwQZSXOrBR2lYDNVdRJOPKWr/x2REYkM=;
 b=fBz6V7os7wtYJDik1MPuFMvapz/40GlN3cVZqZ/jxx2tXXfC6I7jePNDSmDxBgv6sb3Fs5mT8d5y+57KduKi7OzG5I+0pItoW824A5KIzXoVgLILxqI9swKvH9ztUCQse+HUVcDrTjKP+VJizkno36RHQLUwYa1LHDXeZ2cW19Cxoqm6iWiRew7/OVdl1udwoPUI5DFlyHMUeexC3Dx+dgBYHj7RnQbEp9My3HHArOgv73m6wuhT2eRk1nnBJ42WnLP5HrqhgcwP3hv1xTkcJGQkXe35uVcvuqRWkHbCTAm5nGJfnFrhV6kzglKZ45zyIXSTbwQZvINoGdmLMxzOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P7byHzAk7kAwQZSXOrBR2lYDNVdRJOPKWr/x2REYkM=;
 b=nsF0IyYpwjMO0HDgpLZmbBxAFh2IL7UsN8mjoo6RuwRTarat8RG81a9ZMNf/xXHXIk7w+LVCj5wMCp4Q6dXuKoHV63zZScqQheAT4toZm8CatoBjzdqcottuvncTGQ7wfceBFJQuM0WjtYkVYz/QbHm6V1PCg/n7lDQooN5nPGc=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 15:21:27 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55%7]) with mapi id 15.20.3283.028; Fri, 28 Aug 2020
 15:21:27 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Thread-Index: AQHWeD6ZmieVJ7ILtEmVT73DLNf2fqlNLX2AgAAXoACAAA9hgIAAH0uAgAA5QXA=
Date:   Fri, 28 Aug 2020 15:21:27 +0000
Message-ID: <DM6PR11MB3963833C6BEDA666C3C442F5F6520@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
 <20200828100335.GB1229122@kroah.com>
 <20200828115535.GD174928@kuha.fi.intel.com>
In-Reply-To: <20200828115535.GD174928@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a32b844b-de26-4372-b56e-08d84b66085e
x-ms-traffictypediagnostic: DM6PR11MB4754:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4754920D0F9E78E79C862691F6520@DM6PR11MB4754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVHgBWa5Bzl1M5vzsyaMX2JhJft8N2hGFd6w879qFmCf6L3KqYN3vtO38/RbvDchVGFmVhXAILfmJkJ3MVJZZH+szzKSb1p/oJQk2zOkTMKB+0aCV1u0je6rwfVAJxmCh5YsIX6Zv7uOGNN2yBCDtJqQjnlk2pEx5ocB0pyOoFxXywtzLBPD2gfyuGQZUy/Ai8kAAZpMk6cRGFr61EyVPSrystmALO0yzzEPa7VSBduW2b7jORjrehZ25dg5XHBxuPXagvXC0PDq24Tvz+lv4xfGVDET5/zpvS0bmpcHNesxtHRyUQpM5BlvvCuFrPTf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(7696005)(4744005)(5660300002)(52536014)(7416002)(6506007)(54906003)(110136005)(26005)(186003)(316002)(8676002)(66476007)(33656002)(9686003)(64756008)(66446008)(4326008)(66946007)(66556008)(55016002)(478600001)(76116006)(86362001)(8936002)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aDOj1CrH3JXTvb11+rRYwp5yjWtWqy9tRduLcjc+BC0dmll+b4y0E7gfmx9ncOEtQzEMtI/ImVecK+7q7BQemekB2lW3LHLOP2fHplX5stQqYDi8NIJ1Hjop82BjGOYXqIPt4rb4qA6eh9+XnqafMqaO7xKklQpfpEmrFK/z583UwqfO4wo/CzsUS9DiS0gW2eHLe/Q6z6BlUX5Nw+hhTGvGJXhgZmvBKprAbmPo6ETFf6ab0GkTmJ6cx2480utcuFRrSiyq6JXqRZrWqS2CnioCFoPb9CjAV+oW/LYGz2m501yu0s9COfc97p7wjX+fOYIL2Wz2h+f7h8t3AEL3OSeIDt96OBoWUnaqTkLLdiTqFzx0I3D7IiKGZbdde7fMVTVjHqGQRypv3TxNKWbl+3/sDVacXz0ODg4cdPN5peRpiLGH1ZzKoInadIw7nor+55jx4eorob3tyxVKho1PNmgLuCg6Vg5tQ14qCsSoEcrIN5fNyzhAxM6C5YHh+FUbw4LWXtgZ+8e5cK9LCIZIhGNzRjg7HbpSWajEbJ+cH+1CPF6spafKj1nHoWnFXWa8X5ER3I42lYfXTGDNRH3bZMF2xxM8dMmPApFce0MnfNKpKiQkS8V6mNrWTxof5s+J2RcUjHrywfLLFT2C7hlPug==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32b844b-de26-4372-b56e-08d84b66085e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 15:21:27.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTwuRCD7znFgvbRhAhTiHqYqeLe04iVifqIQtsX69J/Nq7z3/guzpxV7/uTZLLtzNbI6uHaHwq/ub6lGWuSTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
> (IOM) driver
>=20
> On Fri, Aug 28, 2020 at 12:03:35PM +0200, Greg Kroah-Hartman wrote:
> > Handle the situation today, if, in the future, someone else
> > needs/wants this, _then_ work on splitting it out into separate
> > pieces.  Don't create additional complexity today, for no benefit
> > today.  It's already caused numerous review comments/complaints the way
> this is designed...
>=20
> OK. We'll handle this in the mux driver for now.
>=20

Ack. Will work with Heikki on this.

>=20
> thanks,
>=20
> --
> heikki
