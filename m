Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D746BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15B32080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VFBZaSOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFQBey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:34:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:52759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQBex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:34:53 -0400
IronPort-SDR: yJgWcJR9ZBNxFpYzizYj1wpXho34+jQyIIuCMp+voCbSiUdwYTz2GsMORQwNvwJECQLDPWFwVi
 M9LZocYKQ+8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:34:53 -0700
IronPort-SDR: qZT80fhhjld5H1CFihUxcNTKuFzHUZmfyeJlsQwfljD3yn6THCLCTW8QhM0fURpH7Be8NbOEId
 3TU7523keGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="291260708"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2020 18:34:52 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 18:34:52 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 18:34:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Jun 2020 18:34:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpXrx3oJZlCqUdkHXf9FFUrqCKJ+37+ouvkp2umF8xqjEJyg361zt5CRIU+hJ++kSZlwryOvg6HUmPMP/5pASo+1CR0mJjOLmmQXCwsjlOzmovPhMK3kVdELZCy4STsXIuctiyQe7IjAKDHX2in47YW+0I6wdTQt0ajVlOi7ulSpSAX7Wf7NvFvUnZC8Ox+BDpUAv703RviQ+BnzN1GRHxxNyB8vkfVA556ErNbET5Cy5tGb+KWRQ0BUIVok/A3dAGI2n9TkZRR251YPPRvJRP0cLHgtn3Hzzyi4gZiuK1udbBuISZMkX/d8HccV/q6O8YHvnhU7z+ML6KebPuaKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XxKq6EdYyQPjMNBZSvnjIgXh1ijk2VdbwrN1WVRKjg=;
 b=OOEWvPEkO+6hn9EyOIkvw2JFSmcNpXrv5S20Y7I5CIW43XtAtdc8lUgQbHFVIRnll66CSnlkVxCILwxIFMDs8i1gfhmMDP/w25WVcSlBqkqTqi+I5gQgVs9nxGV4n3RoNGAHaJ2w6dCHaNAiak/N24WTY9e/CpnZRHQWEwvbuIV7REq6agvtyySBKyLiJfnWzb6KJsbUOfyjQ9DT16+4JobsNhGvm9dZVz7HPT0coQxp7RFSbH6OyPVm3/+8lqhXxRh78SrulGsdNyvSQTsP+ozZCr+PbPRKmUL3pS+Nws1Rcdv9637divHzswzPbYQGL7+YPY9M7o3T0KIxQQpjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XxKq6EdYyQPjMNBZSvnjIgXh1ijk2VdbwrN1WVRKjg=;
 b=VFBZaSOM6T386F7ldok/ALxxyjDBjS7yi1TKR52S2QgfSWSEIKSE1YunhUtqElqGGYKDenUQj8iAE/dadORtFMhNxsjAZ/1kcGOzCNfaEgR1E0mSdRDMkiWSSUuMM2+m/44G2bVZffB+Dy8Y1e+TpS9nDv4wH7R2MyitPENLrm8=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 01:34:51 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 01:34:50 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: RE: [PATCH v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Topic: [PATCH v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Index: AQHWQ+wc04c1VDLsCUu4H/RWl0c5TajbcusAgACRWLA=
Date:   Wed, 17 Jun 2020 01:34:50 +0000
Message-ID: <DM6PR11MB3721BFF25B5377B28E56F69DDD9A0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200616143818.13579-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200616143818.13579-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200616164420.GZ2428291@smile.fi.intel.com>
In-Reply-To: <20200616164420.GZ2428291@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a86fdf67-1b60-4950-aa2a-08d8125ea0fa
x-ms-traffictypediagnostic: DM6PR11MB4691:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46912F7C91D380D2205B50C4DD9A0@DM6PR11MB4691.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlG5hxfifBHNK8ak6afKG0p9qh1QMUcApYrquGmdCtfHQcn5hP01XY45y6i//4kU+7E7I9ROzfsKc37Bl7SlVumwZNGkODathn6/b5eeufWS9gx0U7MVy4dwf2EfgiFwC0x05jr0uyIqH8gGeNCTz+4f08LwpbFtrxnb1JQa8AewVWZM8dGZQrZI9NlE3oz16yXt7APRntcno1zpjfRN0bzImBvs7ys2lcOXY6Ra8kknc+vz0OH+yBRbSmvGnA7o24IAyc/pFBpGBhFv0cJpG+O77fpbg35VAYF6VoQWWIhY2C65ln165nziDyHmrKRL5eswBucm7f6zXY5L9yiG3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(33656002)(64756008)(66476007)(54906003)(316002)(71200400001)(66556008)(8676002)(9686003)(76116006)(66446008)(83380400001)(8936002)(6506007)(53546011)(5660300002)(26005)(6862004)(6636002)(186003)(478600001)(66946007)(86362001)(107886003)(55016002)(4326008)(52536014)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +1gLhuKvcCly+Qvgihbad2PcGIaR8S3gDajiBZYitRQa6ICMo3gcUflZcpjyVJT1lyRxTNEc1ZudIP+tq2MDiK5syVMvSV8Qk6LToUSoXHSTG+e87EyWID5yPBlVYB8nhSO34gEAvPXpDujaFi6iMuZk3+yngZ4WWONyRnQqcj39S1Hyi+cnas/Rz13u8w+QCFeJooSp88v/rfYZSbezNYBu4ubKs3KIBm7abgIy2XoWRG36LIpELiH1H8JsDjxnaXhqahSoXebYiE2qKvMTf1c5w77hW+vWpAODEZP5QFd+hyBZ2kdrjuehzzWOnJCuPYpVb0DbtDCNveCtgPGELcAkD6Fkfas26Soqy24ctraud3rEQd5tovw0ox/6TrRGthTuStGR7KfDdfVBggqFwO1ibAAlfQNQOKur15Mxk84fUBri48nbsKmLAaQ+ABlOGGFaE3ajZebfHk6BmRNTY27HYCq+ue3DEdtJb9RBiUXp0dS6Gz0rQGVEpttEbxVO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a86fdf67-1b60-4950-aa2a-08d8125ea0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 01:34:50.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TqBohwMq9XZaGq/l/5rJiFG4l3KNlOIAiqSNOBYGRvN7rgdNLG4baVQG09iLtVBevVHZLL78SEvOeKax5SLzhTXZ82EWWFapvF5hhCUDQ+djjDZekGPzsx6Nv1aII4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Wednesday, June 17, 2020 12:44 AM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; Hunter, Adrian
> <adrian.hunter@intel.com>
> Subject: Re: [PATCH v5 2/2] phy: intel: Add Keem Bay eMMC PHY support
>=20
> On Tue, Jun 16, 2020 at 10:38:18PM +0800, Wan Ahmad Zainie wrote:
> > Add support for eMMC PHY on Intel Keem Bay SoC.
>=20
> ...
>=20
> > +	ret =3D regmap_read_poll_timeout(priv->syscfg, PHY_STAT,
> > +				       dllrdy, IS_DLLRDY(dllrdy),
> > +				       0, 50 * USEC_PER_MSEC);
> > +	if (ret) {
> > +		dev_err(&phy->dev, "dllrdy failed, ret=3D%d\n", ret);
>=20
> > +		return ret;
> > +	}
> > +
> > +	return ret;
>=20
> return ret;
>=20
> (Since it's only one minor issue, it's up to maintainers to decide if new
> version is needed)

This was addressed in v4, together with another 2 changes.
I was careless when modifying Kconfig in my older working branch.

I resend v5.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

