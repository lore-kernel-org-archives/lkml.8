Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D526C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5A246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mf/OXxpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1Rdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:33:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:43948 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1Rdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:33:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 09:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="232591295"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2020 09:33:32 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Feb 2020 09:33:31 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Feb 2020 09:33:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 28 Feb 2020 09:33:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8K7kYXI9dZ19LBA729XSsNBXWu3XJlh7J98MUeTKwh+XWEaeYykWw7zjAquGYhROwy2QfEiYRLRqTGzpEhr3+7XPrDngYcFJMo3DsO20eHiYiudh3hNkN++/K0f9QEOKkWILLaDXLKnnyKVYMnEG0PCItxF/jDmPvK5Czza7MZKsGpg50mqxhIvOBWlA7mjzpkDKnsPpnmW8pwLRpQyVCgPFqgA+tEuOy571EaHB3vbrXetNZOH+tHhF++KCZejUS7N4UGL2xRNc2bhbn8U59TewAZ+uMPblumZQG5i+LaKVZrzvVSlwDI7EHNAKGoPu8v/7XW2Z4m7VajvaZhjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPb/rXtiRc5Rb/22/aEQqHYXsOoSoZhd0SLi46/48Lk=;
 b=A1iB8WmYLX7mWfQgUzZ/RhBM1KkUhWUjqjIIWa6+7yk0+CQgQtr1CZlk1Fgs4WiGo49o0wQH6BsRpFgSa2ZaAG3a08/YpbgPOEfcd1fPFatUieqW9NVMWax4vFf63Q3vHs0/Sc75F1+XfRZGj4zyGFsUvFAGDF1ZH8uLECMw+bBvhzRVR8DDPXmS6Q+1B0/h0C359DcdpfQqV08sAEnwZKIQXIqa4XpWL7dCbf7USl2CU51kKHpqWf3Kin8yo6rdtmC/Ly+/L0txxzkDdSkOzfc4KU9SVhmkYwK90ITM6BKy0sMwq0tfsTc68jR+6nYvwMO1IVbP5dKykekx/uO8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPb/rXtiRc5Rb/22/aEQqHYXsOoSoZhd0SLi46/48Lk=;
 b=mf/OXxpLE9rLCXUkrER2TLzUVFTmvthwCrvzz4Ake/FdxRLqdzw6tlfcpWmoW8TDODbEV3ZfxhCTrjfFtdzqsLQceEFGAv34neD0Pqpcn0V2NmCfjr0IdzjbOOB3vn7gO7DXhb+Af6vKCn+PWrnyaQP/kR7rWO6PEN74Em/NuYk=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Fri, 28 Feb
 2020 17:33:30 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 17:33:30 +0000
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
Subject: RE: [PATCH v2 2/4] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Thread-Topic: [PATCH v2 2/4] platform/x86: intel_pmc_core: fix: Make
 pmc_core_lpm_display() generic for platforms that support sub-states
Thread-Index: AQHV7cZef4xAbXROw0yHxOBXY5NMlKgwYe8AgAB6LbA=
Date:   Fri, 28 Feb 2020 17:33:30 +0000
Message-ID: <BYAPR11MB362462D69BEA6CC2EEA42A64F2E80@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1582845395.git.gayatri.kammela@intel.com>
 <49e90f024d89746d5955331e023231149210917c.1582845395.git.gayatri.kammela@intel.com>
 <20200228100628.GJ1224808@smile.fi.intel.com>
In-Reply-To: <20200228100628.GJ1224808@smile.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 04898bc9-86a2-4cf3-0e18-08d7bc7453dd
x-ms-traffictypediagnostic: BYAPR11MB3125:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3125977A8AE2D673A1690590F2E80@BYAPR11MB3125.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(2906002)(52536014)(5660300002)(76116006)(53546011)(7696005)(9686003)(55016002)(6506007)(478600001)(4326008)(54906003)(66946007)(66446008)(64756008)(316002)(66476007)(66556008)(6916009)(26005)(186003)(33656002)(81156014)(81166006)(71200400001)(86362001)(8936002)(8676002)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3125;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oSshOubt99XyHxDxs4pAEX4pig4GcEELsae1flkt7isLBHcmfUlXSEVFcbP+3wCfbL4J5GIWUgZW6GBfe1gcQ9wyj0Mi5UNbNTh5rrUO9dOPMcb421zeLt6fhcdfXXVr72WlHHkYHCJ6pl7hUOZuQ0ibbo+5SEkpnJFRSNCrfBsp5tYH1f9hPwQDvfySs+O43fml3McgL9MNXBPGsfOgQTJvEKTSGSOtWAUqUj8jlkbGtGfG1IyGbtJPibEkcTVxwxchwSXxv//f8lVuLcMwJ+BT1wBbEvJqUC2Fnpso/ROlODqwW4GUsUyTElAgWYLNUfTIrJd8Nj2lQO8OWfiSKvE4Yudgd0QGzNWTJJCb8haOLYiTWSSRwmF/jkpdho6MDyY20s+qINTlzapcVFg2fMkwgfHqV6eWnZ9UrohgYzkEXhlOFvO+V7M9khrzMgVaKD0VkjtEAJr+kmSq4HQs3meU7DQ0AlNO6IIOAmKuQnI=
x-ms-exchange-antispam-messagedata: y52XoV9/BfQKl5bA2PfILLJ5jsAnsxiPUX18ppJF0OhJbKLJIZAMmdgRf70KAOHMytlAX3JWCPO+3k+e3DwL/W4ELhIvDgwgPRMiXshlEoQB/1SX0RoPg12ImISu9JqAtfDL4g63x9YFIMEBafFulg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04898bc9-86a2-4cf3-0e18-08d7bc7453dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 17:33:30.4039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwK3SHjSlWhB7NFXFgRfjzO9+CZxGtMvy772AiFxBVZbxYxWuy8F3RDgy/QsrDcnpi19+njiOBT2XSK6G/psy3wXFRA+vIj/Mz6wzvSMR3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3125
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, February 28, 2020 2:06 AM
> To: Kammela, Gayatri <gayatri.kammela@intel.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> Somayaji, Vishwanath <vishwanath.somayaji@intel.com>;
> dvhart@infradead.org; Westerberg, Mika <mika.westerberg@intel.com>;
> peterz@infradead.org; Prestopine, Charles D
> <charles.d.prestopine@intel.com>; Chen Zhou <chenzhou10@huawei.com>;
> Box, David E <david.e.box@intel.com>
> Subject: Re: [PATCH v2 2/4] platform/x86: intel_pmc_core: fix: Make
> pmc_core_lpm_display() generic for platforms that support sub-states
>=20
> On Thu, Feb 27, 2020 at 03:29:14PM -0800, Gayatri Kammela wrote:
> > Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
> > tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
> > number of status/live status registers which is hardcoded and cannot
> > be re-used for future platforms that support sub-states. To maintain
> > readability, make pmc_core_lpm_display() generic, so that it can
> > re-used for future platforms.
>=20
> This patch need more work, see below.
> That said, I would prefer to see it last in the series for next version.


Sure, I will put this patch last in the series in v3.

>=20
> ...
>=20
> > +	lpm_regs =3D kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
>=20
> No error check?
> Besides that it is obvious memory leak.

Sorry my bad, I will put the check and free the memory. I will update this =
in v3

>=20
> > +	for (index =3D 0; maps[index]; index++) {
> >  		lpm_regs[index] =3D pmc_core_reg_read(pmcdev, offset);
> >  		offset +=3D 4;
> >  	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

