Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883162072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GCq64MMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgCBS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:57:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:43987 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCBS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:57:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 10:57:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="440244133"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2020 10:57:06 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 10:57:06 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 10:57:06 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Mar 2020 10:57:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWqkVYdDIx9ZA1NDvuWxoQpBmmYQ8l63Xk4khSpGzg9NeCW4oMgQL1G8ht3YQvs4DArJwt9gyCheQ9F2OOJ/4/NZcyb/m9JIyAM/vh/VElko59gvnahpQK5LjV2qLfTo5i8S/kcypFXcNyzMkmT9hVKH0KFpJRMDPv30UFS21UxH3bDA6yE5Orm9ntJwErahEJ3qA350mkrQ2R9g5q8yfYS2J2VsArffH6rRGod0V/qtJcTsYV8rTGUZ/bzLye9m7JfVMfCrk4lTch34UsMY10l1u6uX1Fr0AhbCZT25jI7e1Szd90C0FKSLW8gD7ZFUxvPDFt6RzNu4d/sU4riSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3BjgkJHe50Eq1MYs/efgofjj8TOfUCwX21D+0AdNdg=;
 b=Lz5RJniSacyNOC+eS94wIPvzbeHyoQgisTTajeeKYATt4NOMzzGGEqF7ejJeolf/+nXTYI9xWCQrCLrhz/Dg1Z7Figb/3F/jHvHaWbkCGSQCDRSHTGEHcjENze0Smk6iA4+LU1pxVLYkAUcchFgfrk5pR38KweX/xgnO5RC41M6oAfQRSZTbBAFahcendBOx4n7SzRTQ2yCXX+UsTjZKZxe1e8q1si4bAFgDBsGYdL+T3ko64Sl61dz9dbr/X9KxPIHXJhQtif2bQCiqArTmeBaJrDjNxV5brt3n5mbDf4zKJ9FFtqI0TX879IIOGrHeS06TZqbkoq1DmjK+Aw366Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3BjgkJHe50Eq1MYs/efgofjj8TOfUCwX21D+0AdNdg=;
 b=GCq64MMllzia+mFYWpoza8RUKmR2ym8o6pqkkD9N/dinPeYDP76Wn/x+WP0QnMDNAiMYb/kq6bHnVqHRpOovasWUH6qDFzNqDNxsQ6R5l5muYqhlp8xpubh1NASg4XF/rti5qGVVqz70loBezai786Dz1goi2E18asMDg5uZhkA=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 18:57:04 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:57:04 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: RE: [PATCH v3 5/5] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Thread-Topic: [PATCH v3 5/5] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Thread-Index: AQHV8AreDwfVi/2B8EmknTpWh83O+Kg1Qx+AgABd1wA=
Date:   Mon, 2 Mar 2020 18:57:04 +0000
Message-ID: <BYAPR11MB3624E93E7E8D8FF291051508F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <5e28f488a6cc8b7c1e08b536868844b586a1eaf1.1583093898.git.gayatri.kammela@intel.com>
 <20200302125343.GU1224808@smile.fi.intel.com>
In-Reply-To: <20200302125343.GU1224808@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [134.134.136.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e4f8e29-abca-48c1-c954-08d7bedb7fa3
x-ms-traffictypediagnostic: BYAPR11MB2806:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2806D55270D67452FD2690BFF2E70@BYAPR11MB2806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(66946007)(66476007)(52536014)(6916009)(4326008)(66556008)(64756008)(66446008)(2906002)(86362001)(9686003)(55016002)(478600001)(71200400001)(33656002)(76116006)(8676002)(53546011)(7696005)(54906003)(6506007)(8936002)(5660300002)(81166006)(81156014)(186003)(316002)(26005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2806;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cFYWrTH0TCeWoBbO30bn/roS4kEzy6hPuatvzNKoGAm7y5H4IQ6TiykHwgwNsOl0qooWmBdwVNH3leSazG7fqgH0mIgyPBKnzeJAtBepdeKHx8y0YhMUULk1D73DI6gxz2lIjUGwic0onQKfLuqYlveGFHooBySNyu4gdtk3lkVn00D3JDIM4o117NJPdoLJWDhHzKSeI+1OAZNmheERD8LqW3Tx56EWYtNcfCiPlVAmgBxHrZbTnsh5QPmuHLqO38J3cZdHgeS0vdkjjCOhFBpM65gWnRV/FqNZ1EGRGTmeYrCaz7YTEpxLrcunLiXpTHyiTxdf6toIrrT52sQkko9Kg/R5CbyfvF/ddwfUR6C3hVHcS3WifIutEFBQ+DjWldP9WmyHYs3SYn7V9J7zmrw8Mp/eLnQJpbsW1DGi7LzVZKXKUe10wpqha+F9Ns5rE2z4GUFT5epHD3qbL1hgpVDKMLG4YDO+9URL4uLkpo=
x-ms-exchange-antispam-messagedata: 4eNfcDGSWpQAMLZCYkUyNS9i+LHjYEwJPZGYllStvTRgpsQI8NyJQFHHBTH3rxKi/9OSw+XKT1lWmkxO4jukPC16huhIBT0sezftZDsp2/+VV8NSaHoyMj38XkMyoLAiwjq1SOGTDJWSD7RMJn0RSg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4f8e29-abca-48c1-c954-08d7bedb7fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:57:04.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOW+cIgpgw739CDhQUAi8UYbSGjXWP2vO1cJ5dBU6VYLjNYN/szOAnNZKNjJJgMtZtZszQUz8GiCbM+ByuP6vtnRBjbIPo4nPcou7qfCaoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, March 2, 2020 4:54 AM
> To: Kammela, Gayatri <gayatri.kammela@intel.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> peterz@infradead.org; Prestopine, Charles D
> <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> Box, David E <david.e.box@intel.com>
> Subject: Re: [PATCH v3 5/5] platform/x86: intel_pmc_core: fix: Make
> pmc_core_lpm_display() generic for platforms that support sub-states
>=20
> On Sun, Mar 01, 2020 at 12:44:26PM -0800, Gayatri Kammela wrote:
> > Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
> > tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
> > number of status/live status registers which is hardcoded and cannot
> > be re-used for future platforms that support sub-states. To maintain
> > readability, make pmc_core_lpm_display() generic, so that it can
> > re-used for future platforms.
>=20
> My comments below.

Thanks Andy! for the comments.

>=20
> ...
>=20
> > +static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
> > +{
> > +	int idx, arr_size =3D 0;
>=20
> And why do you need arr_size variable at all?

I could just return idx value at the end of the for loop. I will remove the=
 arr_size variable.

>=20
> > +
> > +	for (idx =3D 0; maps[idx]; idx++)
> > +		arr_size++;
> > +
> > +	return arr_size;
> > +}
>=20
> ...
>=20
> > -	int index, idx, len =3D 32, bit_mask;
> > +	int index, idx, bit_mask, len =3D 32;
>=20
> What's the point of shuffling this?

Just wanted to have all uninitialized variables declared before initialized=
 ones. I will just leave this out in v4.

>=20
> > +	int arr_size =3D pmc_core_lpm_get_arr_size(maps);
>=20
> This would be better in a split manner, i.e.
>=20
> 	int arr_size;
>=20
> 	...
>=20
> 	arr_size =3D ...;

Sure, I will make this change in v4

>=20
> ...
>=20
> > +	lpm_regs =3D kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
> > +	if(!lpm_regs)
>=20
> > +		goto err;
>=20
> There is no point to have the label. Simple return will work.

Thought adding a label will help not to have multiple kfree() in the same f=
unction (one here at the check and one at the end of the for loop) I will a=
dd a return.

>=20
> > -	for (index =3D 0; tgl_lpm_maps[index]; index++) {
> > +	for (index =3D 0; maps[index]; index++) {
>=20
> Why not to reuse arr_size here?

Good point! I missed it. I will use the arr_size here to iterate.

>=20
> >  		lpm_regs[index] =3D pmc_core_reg_read(pmcdev, offset);
> >  		offset +=3D 4;
> >  	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

