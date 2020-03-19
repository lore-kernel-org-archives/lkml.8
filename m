Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B67C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7070E20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ZHAO1WHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCSSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:16:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:61405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCSSQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:16:02 -0400
IronPort-SDR: Q7ZGdnwz7dQCRMB4YP2WL2hl32L0WDGTW591PFO3ojwByCLil4c6NENsPv3MMJHU51B1kWhZ3j
 3VhMAixvHhtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 11:16:01 -0700
IronPort-SDR: POb4jxYMPpZ/ky3Ba1cNHnYhfHEbrCe/kyAecgLDawPd54ynSoncvO9QLx656d8czO21IUOnkU
 Wd0g2GgS20RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="280168220"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2020 11:15:57 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 11:15:56 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX153.amr.corp.intel.com (10.22.226.247) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 11:15:56 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Mar 2020 11:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQbKe8NAmwkpQpw8xRHs9i9FZ10ZA35frUEgfJkTbhToTHYYnymJPI3Ymn82RF3ooMp+uJjSuXGf7nabQWBAdWBgq9hzkOwYy/9kTRUiBYG9oheka3C3szThtoeCv38acVC6R2Tdi+phbarFySSQrSRFAy7xJZWbp7cfXDAqRodNgz9HCHaWD/emDqza0LhSZHOtELrCNlz93nuk6TazZJkx2YQXmkHGGtwBPoAhxK46dYz+TJFZW9bqmH7bXwdqBzEscszmjWP7LF5upA97AibqG2+0xZjEAK10GodpEjQAhyDLtd978/cJOL+Ajjjfc60PmfG5O1F819ASt6FJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUbicXQ6bBq2xrR0mByoIterPTVOjcZ3Vo92srMMtaY=;
 b=RQIcfqlLnD48p5Np586J1rCJmfk84WP+21caCD5tSthpcYmzNMp0EeTPOZQd7ATMnlJosJQragfg+z1PfjyjdSIxLQaYm0raiTC+62IIjBMBeE2YOeQnpc+YpPdNnubJgKDkaAnTVCxuWxkSzmoYwL/raDmxur6cFUQf56oZcaRiz9ih8C8ORZDblPoVZyY7UaFp5mQ3jOT1FKvVkZ5bsSBBRV7ab1EVCmJI7rlgV4ILCf/ZCW+LINXo9yTy1vPmAZDPw+dU0/IyipM90NSiSLvd+yYLIOdKM0EBYvTjMBOF5UXi620jLAC+ukxcWlRp3RflaE3nCtWo/spBZLiO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUbicXQ6bBq2xrR0mByoIterPTVOjcZ3Vo92srMMtaY=;
 b=ZHAO1WHHkzw/sGHyi9PXa9XJw87FV6F8Cj8PsWk3hw+p7zRBdRfSPDoaFL32sw65mqR1jbW9GSbzaTTg7upXGwTMF8mRdgyPbnYjJXkfHK5YAcOXwzO3YIAexyfHO3NL1FybZC1fSg4Vwtslxrw2pxr2eDLcCyDScGDbo7bq/jc=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB2838.namprd11.prod.outlook.com (2603:10b6:a02:cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Thu, 19 Mar
 2020 18:15:54 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 18:15:53 +0000
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
Subject: RE: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Topic: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Index: AQHV8ArQghD0dS6yzkaNkpM4RGGi9qg1Q1OAgABJMxCAGsE28IAABFsAgAACN3A=
Date:   Thu, 19 Mar 2020 18:15:53 +0000
Message-ID: <BYAPR11MB3624FFB1B25DD743F473AFFEF2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com>
 <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
 <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
 <20200319180618.GN1922688@smile.fi.intel.com>
In-Reply-To: <20200319180618.GN1922688@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 897c8e6d-1f0b-44bd-a653-08d7cc319019
x-ms-traffictypediagnostic: BYAPR11MB2838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB283837C2E92B21991E650498F2F40@BYAPR11MB2838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(33656002)(7696005)(478600001)(966005)(5660300002)(6916009)(52536014)(316002)(54906003)(55016002)(4326008)(86362001)(26005)(9686003)(8936002)(66556008)(6506007)(53546011)(186003)(66446008)(64756008)(66476007)(8676002)(81166006)(76116006)(2906002)(66946007)(81156014)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2838;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fRi0mhmX5kAygKhqvwMMGHqANRTkD0QKhzeNr27q23qYwb7rIBt5K4KcQn85EqJ8iseRa0QSdJ2G1+2qEDeDgT4Zd85fLOn+4wjJJYh7R/sMjF2BGDg1b5Z4ZQ5cR83IzLWDsVaR7ieENup+Jw6S8GAIUruTZPCXXHYZ88UtOeIVoSf37hRLN0TFsH8P9laQcRbABUvtlLy6PHMjYW8MPSXekuI1Mp8szeO/VkwMmdAyEpKf+ZSryDqsGk5AEPS30LKqZ2YFqE7AkjO+v9TZs8fmk24yRFjKDj+EexPyKlIAEJlbdudVrWlvY9cYJx5WAqegbDw6epFV2H1G4pHp08BjzG8n7WFT7MJtL4mvQOmL42AhTuQzvtb6tYIpSxkYZHW7W6akZo3+mZcnOlbHEHbN54V0Mmy9JIBpJ3bejtb2QLyvSwwl+1FlcvkkEZ1ajSwFoTHpZ9Z5OlmQOa3tgd/5VXX1eCdH7By2eZexa8nhGBiSQt3iEuQBgt66ZkfCf0FB3SpdUqudGk0PwIsIfg==
x-ms-exchange-antispam-messagedata: HZwJVN1rs3CQu71l7p3+ym6aG/EGWqjF/LCeudahWNmsKydQY5UT93c1rVOty11/AQKyWTE0009dVhdSVY5PjyOnhTd1s7+7nxoDkq++/WPuxxmYmukUtUbalBi6684u7B+GYuFrUcs8AGJWprQHMA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 897c8e6d-1f0b-44bd-a653-08d7cc319019
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 18:15:53.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPY0Qtk7DdcqYvRgytqLFwS5O25voDtxj+A+GGT2sZqPLKpwS+QexOW2dJA3cWGF9GkrHOYhC1NPF+KRNIgNiFGE7EDzHxcTbgz45bml414=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2838
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, March 19, 2020 11:06 AM
> To: Kammela, Gayatri <gayatri.kammela@intel.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> peterz@infradead.org; Prestopine, Charles D
> <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> Box, David E <david.e.box@intel.com>
> Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes o=
r
> code
>=20
> On Thu, Mar 19, 2020 at 05:57:06PM +0000, Kammela, Gayatri wrote:
> > > -----Original Message-----
> > > From: Kammela, Gayatri
> > > Sent: Monday, March 2, 2020 10:29 AM
> > > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: platform-driver-x86@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; Somayaji, Vishwanath
> > > <vishwanath.somayaji@intel.com>; dvhart@infradead.org; Westerberg,
> > > Mika <mika.westerberg@intel.com>; peterz@infradead.org; Prestopine,
> > > Charles D <charles.d.prestopine@intel.com>; Chen Zhou
> > > <chenzhou10@huawei.com>; Box, David E <david.e.box@intel.com>
> > > Subject: RE: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug
> > > fixes or code
> > >
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Monday, March 2, 2020 4:54 AM
> > > > To: Kammela, Gayatri <gayatri.kammela@intel.com>
> > > > Cc: platform-driver-x86@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Somayaji, Vishwanath
> > > > <vishwanath.somayaji@intel.com>; dvhart@infradead.org;
> Westerberg,
> > > > Mika <mika.westerberg@intel.com>; peterz@infradead.org;
> > > > Prestopine, Charles D <charles.d.prestopine@intel.com>; Chen Zhou
> > > <chenzhou10@huawei.com>;
> > > > Box, David E <david.e.box@intel.com>
> > > > Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug
> > > > fixes or code
> > > >
> > > > On Sun, Mar 01, 2020 at 12:44:21PM -0800, Gayatri Kammela wrote:
> > > > > Hi,
> > > > >
> > > > > This patch series consists of bug fixes and code optimization
> > > > > for the series https://patchwork.kernel.org/patch/11365325/
> > > > >
> > > >
> > > > I had applied first four, the fifth requires additional work.
> > > > When send a new version, do it only for last one.
> > >
> > > Thanks Andy! I will send the 5th patch alone in new version.
> > >
> >
> > Hi Andy! I see first 3 patches are merged in for-next branch on 2/28
> > but not 4th patch. Can you please check?
> > http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/
> > heads/for-next
>=20
>=20
> Is it in my review and testing queue?

I think it is archived and superseded https://patchwork.kernel.org/patch/11=
414379/

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

