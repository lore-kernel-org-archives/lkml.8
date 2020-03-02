Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3124677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="L/cWQC2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCBS3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:29:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:59966 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbgCBS3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:29:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 10:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="233457280"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2020 10:29:31 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 10:29:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 2 Mar 2020 10:29:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efPBPJUAzRXvhOezBpsMTooMficFLx3RVZ2i2tpPiliXU8kgMupvdfSq5moGAt8UWB/81rbbd55RGJgi+8jrrCzNf0kmyNJtRqwfl5tSrVyirg8fh6fkA0fCOZFh7ZYjCEVK4E7v54+OhFG2OzxCCsHOy3UbJLSg6rUhf0Zvwe5zhUN7KM52FTR8yjw9C/saMAwr6r1BAhWcoa/XfrRnMBC+RnkVF7Mtc4z8nT1XTqGz3GzTcoxPlcw94n1ft2bp+4/pUKFGt29coTmKeCojizd9tlfzWGDYoOVrl9d31E0H6YnJ8wUqY4SqNYqwc1d9NkCHO+cqroHExU8eabAKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTmJk80nQOgoQmg6DzNFYFG2vI8GlIV9e2IeyAlpGV4=;
 b=C0+g+fvAadojTu0Ro6Ei8Cc4wRqq0GetjWJGq0P21mmwYB/sD1f7MCtIxsf4xeU8H8n69Sfh1886HzsAHbKPYQmpv2mN3ksu+YvXF+ewPIIlHwsWs7EGdy9qbyCNmQ17J8bF1UJi4NcUgyuJad+gVlO1NsnTI3/5gx+6gtsNIZrUDsmpdT22rIAlP54KPXp7cQtaXKoRX2wvnyl+l5W/2DF2eZq4Id5iTPIQyOjobowZRh6iR0g437t6muijEsjGHysr/6ss1MmEVD9nwd+bVza227jNv8GjG3fX1TWCXQvfgX0CdsB4+MM/fuQE6Hb9vslX5Bp0e9nWLJsXgFVmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTmJk80nQOgoQmg6DzNFYFG2vI8GlIV9e2IeyAlpGV4=;
 b=L/cWQC2CzBG+XDk5ZUZ4zZqmWwQl8aOaCPfgNcoNeB3mXd2LzaFqmz5uxFM5+jcZknTuOzV8RwoASREw3uu9URi0u2aM21YxbaQY+pwJof6kl9I1Dlk2DHz7zOaBpU2SUM5blKFrIBrMbcNMhqOTrOlvD08WGNe3IW7fSAMVNNo=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 18:29:29 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 18:29:29 +0000
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
Thread-Index: AQHV8ArQghD0dS6yzkaNkpM4RGGi9qg1Q1OAgABJMxA=
Date:   Mon, 2 Mar 2020 18:29:29 +0000
Message-ID: <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com>
In-Reply-To: <20200302125427.GV1224808@smile.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 816dbcca-8049-4920-eeb5-08d7bed7a531
x-ms-traffictypediagnostic: BYAPR11MB3096:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3096893FF1088B8E55FD5577F2E70@BYAPR11MB3096.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(136003)(346002)(396003)(189003)(199004)(9686003)(2906002)(55016002)(6916009)(54906003)(26005)(6506007)(81156014)(81166006)(7696005)(33656002)(8936002)(53546011)(52536014)(186003)(5660300002)(71200400001)(4326008)(966005)(66946007)(66476007)(66556008)(64756008)(478600001)(316002)(66446008)(86362001)(76116006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3096;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOTMLu4wFqk2TOh0Ik2DkhyhO4Zm8cuinLzGMa7XtI5RI0jEYn8G8jRkYwwdA8irLuXXthaDcyXGaBOhK/goqXcTcVsmLTLG76TwdInM9JysX7+gBMp3ThS624PY4HyrM6kgvipTYa5tSs15I9HzoMbHlLnZ/DZN5UhmLLaWS7lIb/lshjgRjvj7+O+sAasdFWH5qA9ii+E1VXq8ZRbqdMZB16SsS1Ex5/o2w2n+ZtTeq9EjZzUSwMUEHue0B7qhW/Otoox1RtlZwDS4xT2CuuQ5MWzzyxam2dAA1Dk4yemThPxo6X12Epnm+rQ37K13lAHd+rScDtXOdN9jZ4eq9xT1ZtJeARv8lxPtWJs8WA+HVLhPeRZ/BdIk8LofKswzQ6+TzhLSlZZJvOOLCR47nKiuS8XNw8mrz37DCVFI7qbHmsVVUg3YKZk/b6jI26fTiMvegwXmzi3fAwLnul43jl+3XGsv5txHdThSp+W8BsONUtn2Ha5hO6barFPhFdBOPZUUhxw3TN3+rxlRSPNVPg==
x-ms-exchange-antispam-messagedata: Ga2aHfWfLShRx5+TBQB+eIC71qocFVmGBK/DoUJNe3n4lxqOyF6tRgykkd7FMHETazVxuMnBtUD/dKvpHe/jP/w0YpfRN9jQVWzy4Ye3CpTlFCjsEGtTuK1E0upX8D0HWIEW+0zyfJJbhihpT2yvgQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 816dbcca-8049-4920-eeb5-08d7bed7a531
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 18:29:29.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeIVNwgoVhZipn3L525KEjwcmZtMjWp+3XMreujVqGD5NJZN7EaqXqx4t9mCBXkKk5KoIl44v27GnnyGczU1aK67OgOIhugX/wA9Zq0X4SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3096
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
> Subject: Re: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes o=
r
> code
>=20
> On Sun, Mar 01, 2020 at 12:44:21PM -0800, Gayatri Kammela wrote:
> > Hi,
> >
> > This patch series consists of bug fixes and code optimization for the
> > series https://patchwork.kernel.org/patch/11365325/
> >
>=20
> I had applied first four, the fifth requires additional work.
> When send a new version, do it only for last one.

Thanks Andy! I will send the 5th patch alone in new version.

>=20
> > Patch 1: Relocate both pmc_core_slps0_display() and
> > pmc_core_lpm_display() Patch 2: Remove the duplicate if() condition to
> > create debugfs entry Patch 3: Add back slp_s0_offset attribute back to
> > tgl_reg_map Patch 4: Make pmc_core_substate_res_show() generic Patch
> > 5: Make pmc_core_lpm_display() generic
> >
> > Changes since v1:
> > 1) Changed the order of the patches i.e., patch 2 in v1 is made first i=
n
> >    the order for v2.
> > 2) Fixed the warnings reported by kbuild test robot.
> >
> > Changes since v2:
> > 1) Add "Make pmc_core_substate_res_show() generic" patch to v3.
> > 2) Fixed the memory leak issue in pmc_core_lpm_display().
> > 3) Moved patch 2 in v2 to the last in the series in v3.
> >
> > Gayatri Kammela (5):
> >   platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display()
> >     and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
> >   platform/x86: intel_pmc_core: fix: Remove the duplicate if() to creat=
e
> >     debugfs entry for substate_live_status_registers
> >   platform/x86: intel_pmc_core: fix: Add slp_s0_offset attribute back t=
o
> >     tgl_reg_map
> >   platform/x86: intel_pmc_core: Make pmc_core_substate_res_show()
> >     generic
> >   platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generi=
c
> >     for platforms that support sub-states
> >
> >  drivers/platform/x86/intel_pmc_core.c | 148 +++++++++++++++-----------
> >  drivers/platform/x86/intel_pmc_core.h |   3 +-
> >  2 files changed, 85 insertions(+), 66 deletions(-)
> >
> > base-commit: 7adb1e8aeeb5d4d88012568b2049599c1a247cf2
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

