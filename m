Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0947C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618FD20789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ofbWW0yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgCSR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:58:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:45646 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgCSR6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:58:07 -0400
IronPort-SDR: 9dKycu86rpmA8PBUaCdtojPcLI7VJiIpbXgSb1CUzVhLQur+upXobL8ex/q1fZU92fnq14nUG/
 r4gzdc1Z38mQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 10:58:03 -0700
IronPort-SDR: 2qQI2aTQucxEoaonlPuvDDBzpJ47WVZpiFWeNiRPEIk8M+JRrSd3V89puKFFEnvZPQpSpKyPE6
 CzoSXE5oamqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="248615362"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2020 10:58:02 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 10:57:37 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 10:57:35 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Mar 2020 10:57:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Mar 2020 10:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjhJyNeBbmW0ylR0rvFSPBLRhM0k6C7NCLBr3boPpTqPiZAceyIwYLUaJiOCwAXGfad9i8ruuRb2h3B32CB0dW2izyumUmDRPT3UWcZCMrkiCkvsUV+vLMLxdrf4mNoAuW5p/j+/FdtnR7etqODLs/q6rYhhJqWQCZdpEpGQ892rhxPSttlEUdhsUtrpu4jNbADRbqOLjEviVzxgnipu6vCAyqCBvfqhylmdGGMHj1E0r3qeTptVIHMclIASXSek5XQo6Yg3nAbc6kK048lMDc4/S2T5be4xYJJ1cRULD3k8ZsiSrRalAjcLleUGGfe+j9EMqXaAc0eLE6Dgi7wgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKSHk8QCexmhXRIx6HG0A35rF9Ndlq5YdEiX1++pmkQ=;
 b=Sa65+rQfwI72jaRPbkbC1R9vs+iHBysEyD6ddATN9CyNd6RX+dtGckcnUJZr/+Zk6r2davzJLCuNwB//OTw3DMK7SbVcQRTCWUuaGzgVVYsXJtWCwItCxk4lodDTQSPEplkuqWziTVWeoUWnZRuTw8kJygst1IGFIFtX0+uQGL7PohiOOfJRLuILowX93Rg3g8+d+WoDAAedPEnc7xV1SzuqEBVgC4vqbaGkpDcpA6FZRuRjHWs2XHkNGsIpXGtPQhXEdeX2yVwr0YlibR+wKa4T9saP13nDd1hL1TQywaKu1I9i0oQWFaPbIQPst4GNr69Cqa3rXMPdeTu7fSsdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKSHk8QCexmhXRIx6HG0A35rF9Ndlq5YdEiX1++pmkQ=;
 b=ofbWW0yvB5VV9IGaxQmJyMK+oCtQLgP+zzW6SxrChAb9yTSkRI4P7zgsyzOHo1JsOnxRyUP5AUspBWxbf7eRsmnumJlitvYWnaNgBmugNAPfQ0RXA9WbOwBXaJYvk1J1tpBLqoQBB5RjL8zckp8Etd82bzVemZFwOUNTuu23lqc=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB3784.namprd11.prod.outlook.com (2603:10b6:a03:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Thu, 19 Mar
 2020 17:57:06 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 17:57:06 +0000
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
Thread-Index: AQHV8ArQghD0dS6yzkaNkpM4RGGi9qg1Q1OAgABJMxCAGsE28A==
Date:   Thu, 19 Mar 2020 17:57:06 +0000
Message-ID: <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com>
 <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 76f63729-99e6-4638-a781-08d7cc2ef056
x-ms-traffictypediagnostic: BYAPR11MB3784:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3784E5BCAA56F56FD76A9B38F2F40@BYAPR11MB3784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(8936002)(498600001)(71200400001)(33656002)(52536014)(9686003)(966005)(5660300002)(186003)(26005)(66476007)(81156014)(64756008)(66946007)(7696005)(86362001)(66556008)(76116006)(81166006)(66446008)(8676002)(54906003)(53546011)(55016002)(4326008)(6506007)(2906002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3784;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtNvkwiZ1asMGXauqwkgE6C+fwATrEDCmA0Q+/r5k8j8AmwNEkuYBkp8n3n5OIvvnx7+NIzM9sKCA/p8o78cc6OPO5IG5mREwXVsJ00IVgJeGGC7KQpNfwvKghyxOw883VZi1ZiCTzIoh+ycVukuqW/BZFeII9cKBq4VG8XMNV+XEwuJEF6ZxxXKiGx6iTVc3Bo6uH5K+AJVVZiBwyl8kuXh96hZz7Q6UpvsSS02Cb9NCLpMy67ZQojNYxCJSLuOfL157U8HTHrkluT1UAHWWlKQTvSQ6Og2i2sHtM0AWD0aLH6UvPNmsJiMR16tF2/c4yKRB/jjMt5qIpZQyMRcBPiL8rzcH8haLgI8isJKO0mEcuZ0agv0Q4wPgCDPeBIfgrD+tL9CZbvOxGYNSe3xhhRDvA8dZhqRoZp0GC/ijXKFgdLto+rzZLsY6cEDH+7sL2kE6ItnY0DQXahpOGiml2gYYcOFFqDzGoxNuiAZqRs+IJWaCdEpg2MimvijtLYH1zabPUZRvIUUR0XbXQNcow==
x-ms-exchange-antispam-messagedata: yLvAS/onFMQx07HOTy8snsK5oPfjRHxIfqM7FtR2aP42NAFNFCnpTgE/3HfmiBNCjxH9tTVoW8DO3NOqyGQu4zLSC9Yl20Zqg0Bp/HWZ8kVjF5byK5n8cyD4YTOEBnmckA4p562mZLtfaPO81mI6xw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f63729-99e6-4638-a781-08d7cc2ef056
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 17:57:06.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpwcFrqpOGl8HZhWlxVt+NhJPtEDEZchweH/cQVlVf4G+nr0zDPin0ciZJsqmNOWpNA5nZVHHc2Q13JLNU3O3bQ/Z8duvBeS/lJD8H/j6cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3784
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kammela, Gayatri
> Sent: Monday, March 2, 2020 10:29 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> peterz@infradead.org; Prestopine, Charles D
> <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> Box, David E <david.e.box@intel.com>
> Subject: RE: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes o=
r
> code
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, March 2, 2020 4:54 AM
> > To: Kammela, Gayatri <gayatri.kammela@intel.com>
> > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> > dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> > peterz@infradead.org; Prestopine, Charles D
> > <charles.d.prestopine@intel.com>; Chen Zhou
> <chenzhou10@huawei.com>;
> > Box, David E <david.e.box@intel.com>
> > Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug
> > fixes or code
> >
> > On Sun, Mar 01, 2020 at 12:44:21PM -0800, Gayatri Kammela wrote:
> > > Hi,
> > >
> > > This patch series consists of bug fixes and code optimization for
> > > the series https://patchwork.kernel.org/patch/11365325/
> > >
> >
> > I had applied first four, the fifth requires additional work.
> > When send a new version, do it only for last one.
>=20
> Thanks Andy! I will send the 5th patch alone in new version.
>=20

Hi Andy! I see first 3 patches are merged in for-next branch on 2/28 but no=
t 4th patch. Can you please check? http://git.infradead.org/linux-platform-=
drivers-x86.git/shortlog/refs/heads/for-next

> >
> > > Patch 1: Relocate both pmc_core_slps0_display() and
> > > pmc_core_lpm_display() Patch 2: Remove the duplicate if() condition
> > > to create debugfs entry Patch 3: Add back slp_s0_offset attribute
> > > back to tgl_reg_map Patch 4: Make pmc_core_substate_res_show()
> > > generic Patch
> > > 5: Make pmc_core_lpm_display() generic
> > >
> > > Changes since v1:
> > > 1) Changed the order of the patches i.e., patch 2 in v1 is made first=
 in
> > >    the order for v2.
> > > 2) Fixed the warnings reported by kbuild test robot.
> > >
> > > Changes since v2:
> > > 1) Add "Make pmc_core_substate_res_show() generic" patch to v3.
> > > 2) Fixed the memory leak issue in pmc_core_lpm_display().
> > > 3) Moved patch 2 in v2 to the last in the series in v3.
> > >
> > > Gayatri Kammela (5):
> > >   platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display(=
)
> > >     and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
> > >   platform/x86: intel_pmc_core: fix: Remove the duplicate if() to cre=
ate
> > >     debugfs entry for substate_live_status_registers
> > >   platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back=
 to
> > >     tgl_reg_map
> > >   platform/x86: intel_pmc_core: Make pmc_core_substate_res_show()
> > >     generic
> > >   platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display()
> generic
> > >     for platforms that support sub-states
> > >
> > >  drivers/platform/x86/intel_pmc_core.c | 148 +++++++++++++++---------=
--
> > >  drivers/platform/x86/intel_pmc_core.h |   3 +-
> > >  2 files changed, 85 insertions(+), 66 deletions(-)
> > >
> > > base-commit: 7adb1e8aeeb5d4d88012568b2049599c1a247cf2
> > >
> > > Cc: Chen Zhou <chenzhou10@huawei.com>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: David Box <david.e.box@intel.com>
> > > --
> > > 2.17.1
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >

