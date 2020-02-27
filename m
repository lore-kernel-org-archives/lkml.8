Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F60C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DCD24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="k6I+FpxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgB0PxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:53:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:10250 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgB0PxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:53:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 07:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="230812823"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2020 07:53:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 07:53:09 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Feb 2020 07:53:09 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 07:53:09 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 27 Feb 2020 07:53:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK7FnAFM+6mUxeiTSBsXuRP/jFynbz4Sif4GAaqlTvDKZnFzX2KQ/fqo9UP35pXs8biayfUsTDxivA1Eq8ln69FtumO1HN9fAzXHobfDJ9a+M4GqEIxnCe/BatymoqoZUpVPPUj+4R7lr69Bm58p+kOtSslQK3BPd+bje5q5W3VgeYG6VKEPsk4AiNFPma0RNeqrT+BG1mub1eAeUDNw0YuIRF9i0PX74VRQkbwhti2QJ7uyKOTkYXmZqzw9CkMmVtCveUJds6VhZ38WVU5gIBtwdLqVs4IVh17xpU+sN+7PP4KS7lWK1yT+Tnx6hQ+NnccNg3mcAgqanpE574Okew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo5KM/pFQLqrObYxeJLp3dgM2GpyznAEib5TGZAW4nw=;
 b=Lk9lXWUvhIJcjik3BsGUIqUgv/ak7g+kEEjb4UKXHmb0nfXz6eZ+E0AYqSZouQb37CRC8NjCevvES7Fu3WEnPy5gz5AxNLehlklY4BNNEsyn/skvntIVVCYevuT3KRAB6SV2czP8EhuwGL/9PRq7dyZP+7Fh2Cs1rO/ivpdc6NMxTF0JT1bip+f9N0jMSpXP8QssDF/M8kSVLawP3VKhzu+7QGEODRniC1G76SqPLED1mF/qRqHS9zZSAdt24f4c/a+H6brPzAry2B7X5KswwNKGP7hUS/mPasyp8yDBJ8s47XPodgfkc/3AfVQzjL8RePjAFe2DWUD8BpEYun4njQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo5KM/pFQLqrObYxeJLp3dgM2GpyznAEib5TGZAW4nw=;
 b=k6I+FpxRn8teFtwO/3OrT02kzOwjgR5VOkWe0FLgekJPgWonc785+JTLi4EX/06pF6KbayUIH6l+SKJg6X+gDaiP0qnycBo7cy67E25Hogpgi7LQihWqBodDh81Qr/kfAdzfYOakEzIpdMpQX3OVBotj7tCpzTvR1QIDC6BY11k=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB2613.namprd11.prod.outlook.com (2603:10b6:a02:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Thu, 27 Feb
 2020 15:52:59 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 15:52:59 +0000
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
Subject: RE: [PATCH v1 0/4] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Topic: [PATCH v1 0/4] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Index: AQHV7RhQHomQqbAPK0KsSv1d/KuGBqguzj2AgABiWkA=
Date:   Thu, 27 Feb 2020 15:52:59 +0000
Message-ID: <BYAPR11MB362461968CAAC427A185AC5CF2EB0@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
 <20200227095643.GB1224808@smile.fi.intel.com>
In-Reply-To: <20200227095643.GB1224808@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [134.134.136.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f2db5dc-849a-4616-9fcb-08d7bb9d1ece
x-ms-traffictypediagnostic: BYAPR11MB2613:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26134787A3B6B2C802894E42F2EB0@BYAPR11MB2613.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(66446008)(66556008)(66476007)(26005)(81166006)(8676002)(64756008)(6916009)(5660300002)(316002)(76116006)(55016002)(81156014)(186003)(66946007)(7696005)(6506007)(478600001)(71200400001)(52536014)(4326008)(54906003)(9686003)(2906002)(53546011)(33656002)(8936002)(966005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2613;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7B8CgwHA4ZpSx40aT2yjjPza/yeQV+HHMGHqJYVqKal/Xx6EZi1c7uMgrZ5zOK3DJmO8wYNyV4RNjzDT2TJ4m4K736UcEaW31nVhRJn7C3rdRZa9it3n8zmSG6zDTsbdtSK77e+Xq4UGoFuhzJXn7IFGsveJ2mov+Lpx+Y1shpXpg7+hJRjtr3U9EVVFO7UK8yJMw0Tb/r+diq940quC53M0q9mRWrjPtFdPV5uin1a6pRzLtTUZWpX1wqSFDSMaZS4JP2eB7o/MoSzKXLbNFpEQcelq2G1PJx6udQbL2FIaRMgEc8UjVix3tjl25NISunAOcIVVvOr+9WKwmLXMZu1m7KFquBi8+ivwPFXzWbPp/0WFoN2427af50zgMYkIsU5XCogbiMHDQxfpOa9mTeF/KtNEmGBOtzTNrGvotYlXB9eW68D9cmWmEsW5+xOoc+UM/OnIS7Wu5zH+QB3yu9Ry2far42hp+swMbiAtx2R4aLkja8CLdmlPHJJDQ88iq0hxK4WVrwrVFWv+9rui/w==
x-ms-exchange-antispam-messagedata: t/HbVYhZ6i9qMOGlaGdzJeyPr1miWa79OLQMQ1lObju+Kn1tSzXeFVCE8XDYkDnJehiakrrhHCP6U6s3Hdk7qIf/jG9lK+RvZuZnpMxfwWdlDTY9N40UiLnmp74nU6li+yhl7exE4uLvQOPETaF/rg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2db5dc-849a-4616-9fcb-08d7bb9d1ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 15:52:59.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUtmQYATdfQVLAneSvlFnHLP398oEFjdEN69G3HaKMf43tovOx6nS6uEV9WFYOCZB4wUecyPAQqTi8vYhpPnME/OjKrsBgQEtFd7O6Hgd0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2613
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, February 27, 2020 1:57 AM
> To: Kammela, Gayatri <gayatri.kammela@intel.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> peterz@infradead.org; Prestopine, Charles D
> <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> Box, David E <david.e.box@intel.com>
> Subject: Re: [PATCH v1 0/4] platform/x86: intel_pmc_core: Add bug fixes o=
r
> code
>=20
> On Wed, Feb 26, 2020 at 06:43:26PM -0800, Gayatri Kammela wrote:
> > Hi,
> >
> > This patch series consists of bug fixes and code optimization for the
> > series https://patchwork.kernel.org/patch/11365325/
> >
> > Patch 1: Make pmc_core_lpm_display() generic Patch 2: Relocate both
> > pmc_core_slps0_display() and pmc_core_lpm_display() Patch 3: Remove
> > the duplicate if() condition to create debugfs entry Patch 4: Add back
> > slp_s0_offset attribute back to tgl_reg_map
>=20
> Let's do other way around, i.e. patch 2 as a first in the series, so I ma=
y fix the
> current (visible) issue.

Hi Andy,  sure I will change the order and send the version 2

>=20
> Then fix the kbuild bot complains and send the rest.

Sure, I will do that. Thanks!

>=20
> >
> > Gayatri Kammela (4):
> >   platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generi=
c
> >     for platforms that support sub-states
> >   platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
> >     and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
> >   platform/x86: intel_pmc_core: fix: Remove the duplicate if() to creat=
e
> >     debugfs entry for substate_live_status_registers
> >   platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back t=
o
> >     tgl_reg_map
> >
> >  drivers/platform/x86/intel_pmc_core.c | 131
> > +++++++++++++-------------
> >  1 file changed, 66 insertions(+), 65 deletions(-)
> >
> > Cc: Chen Zhou <chenzhou10@huawei.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: David Box <david.e.box@intel.com>
> > --
> > 2.17.1
> >
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

