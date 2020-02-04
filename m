Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA5C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8942087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RfSI5TO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgBDXK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:10:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:42802 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgBDXK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:10:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="403958120"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2020 15:10:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Feb 2020 15:10:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Feb 2020 15:10:55 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Feb 2020 15:10:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 4 Feb 2020 15:10:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EseUbKb3CYmwLA45SQw6vtG2+nCJ2TGduxbttcogEAq4DVdbrn/KxlR/RD2pY8rAaptMCISfjqxM3DjtGj1gW45Yn3KHWH0T7FJJhFb0e1FVbQX68+fC4q0MCun3gkUmAPqvz2P20AdIcnQSml8OqzueSIlwzCPYwbwk1itDPrIZW230DO5pYrgLZ1q0//4NkNnIDWzTAxIAGvRdwKkZA+wSmgxC5RJ4eKXhIgnTFHYURPpRuVW98ULzrlXG+7HWF4Tk1FHGuU5+vH92a3g3jB+TAarheEv2ROSUKPc9HSgNvDmP78j+f1B1u0vLIymmrmcOpeAqZI3cIqhB/pAP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmlPAGpv4A9TZlfvZcaYr95z4F4IYheic30NaOXseJ8=;
 b=gEa+JDFc+JjFWMmzfPZ9CByZG8YkJnT4vTVHod/T3TIoa84GijHLHZhYJQT0vubuPbakY1H+vpiG++t+ZS4YQL33Sbz33XZLMQmvVtHrw9ybEq2130sSvHAhE4RbMeKKcHV6KrL1yzO9Cz7F0kWPZH7alAqOmOn/bcksx/Eh3OImjBrikAiis015/hcPEz3NCSjvvEYQd917j6pMdahqiz2gCBjjoaShyshMNN+/dcl3HpXMgLIqs2bNeQQD9fsO5eBknEFMrAj3GuQPDs6vKm1WN2QcYr68LBdEV1HSddURfNfbhyGCruHgDpu+ylwH4uZ09V2Z8KQ5pMeXjeF+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmlPAGpv4A9TZlfvZcaYr95z4F4IYheic30NaOXseJ8=;
 b=RfSI5TO1Et9GE9xzCyXQYLP1VwUxGGsatU4w9PK2O+9GQZe5VpRQOvHNGu1KabHEXKQZG27GtnSYtXCoUZLtXtNWgTXRyf0TdlSX/jjc7n1TNDB4C/ZuqxsUE8EOdSbsoYWzOzCl3Nee2CKdG1UCalODkACmKs/7VTeI+1ONzko=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (20.178.239.225) by
 BYAPR11MB3688.namprd11.prod.outlook.com (20.178.237.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 23:10:50 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d12e:da32:257e:7d51]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d12e:da32:257e:7d51%5]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 23:10:49 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: RE: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Topic: [PATCH v1 0/7] platform/x86: intel_pmc_core: Add debugfs entries
Thread-Index: AQHV0uehR65JqlDsd0qQ+gWeMY04Aqf+WQcAgAB1iqCAABOEAIALk8swgACCXgCAAMFZ8A==
Date:   Tue, 4 Feb 2020 23:10:49 +0000
Message-ID: <BYAPR11MB362427151E22D623A1B48E37F2030@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
 <CAHp75Vfb38BEh2OZkO2EoQgCyBxaLoiwh8S_qKiPQRX1g+ZA2Q@mail.gmail.com>
 <BL0PR11MB31071AD85775C09B8EC26608F20B0@BL0PR11MB3107.namprd11.prod.outlook.com>
 <CAHp75VeRAWsqxfjOxw97SBPRLvcyF=SGrN84hT=UUNC6yQ6-_A@mail.gmail.com>
 <BL0PR11MB3107F8D50FCADD168EAA9E7BF2030@BL0PR11MB3107.namprd11.prod.outlook.com>
 <20200204113414.GB10400@smile.fi.intel.com>
In-Reply-To: <20200204113414.GB10400@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ec15bc-546e-4d49-906f-08d7a9c77998
x-ms-traffictypediagnostic: BYAPR11MB3688:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3688FDD26A0A0FDA7C92A85CF2030@BYAPR11MB3688.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(189003)(66556008)(66946007)(54906003)(316002)(66476007)(52536014)(66446008)(2906002)(64756008)(6916009)(966005)(76116006)(71200400001)(6506007)(86362001)(186003)(26005)(8676002)(81156014)(8936002)(7696005)(55016002)(9686003)(81166006)(5660300002)(4326008)(107886003)(478600001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3688;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pC5oiIwaSJjbR4UWO5MFejbkQN7a7Fbt9SC4+WSqDIuQyMRyhHHeLY+5jbHTxtt6IkTHbNIJuOf3ZVA7xLrHN8eLWF/Qhfynb2iPCc1OY3Ny07eR3HYtpXKv3wg14leO1pATN/Q2RcYbvQ4zJtxeVUiX8uSUjPGYlEWsGSsaOczQW/jKndViIXt6c5Je08a9NWZ3/pw8Q7LVDjDCYSn+YDX25Sn+4Hj+Z9NX5VA2pgg6StFayN917G96wEGT5bQtchuwB9uX6QNpu68z8yuC1E/05UjR/LndHT5BXAXgLyLoP9CQcFWEglEl+e/19AM5PQxTefMoyXlrLTA5Np54c3P+dsi1UzHTyDsXjG0rZ5jOGq28W/kuY3jg9Dr294tn2RVpOnosWK5FGS3nttx/aU9/t9hPpPuZRk2qczyIvMTdxneqEpI4g3rRRGBBT/Fc9vOdLffNmSJkC+b+Gpy52uNbUwkOuzF+hmi3aaUwdiM0XTrPv8eEn/h0BfcXwOkvhBp3xc51DbCg5rcq5f8nlEH9CC3LQDNzkiobFVQiGyuMZsGVYEcCyc4b7mhluNO07sBfoxTZbiUUH614lZqApkTGSq3mMjduLXLLyGrj7XzNUOk24yW+5yAIN45Pj5pbO5CL4l1ex91y1ro9erxGlbs4HiunoC1jAgmKr4ksfoWpWIjEmkB+U+sTDK726plJQFQ5VOThi5JWzOKhXKQ8BUgVYgZ4f82nNreT0TiNjMg=
x-ms-exchange-antispam-messagedata: x97zJdguefypK9IfKaCwkktzP//NZb1N9PEaD8NA+WolWOUUP+Ohyzeh9qgQEirj6qfItqv6bARP14OkNCuCfIGOMWAf2u1YDcDMSfdWIXZ0jC0mgspJLgald4CG6qAE5D+7fUVB96Qo5Wk9NT/q7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ec15bc-546e-4d49-906f-08d7a9c77998
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 23:10:49.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDX3jwzKSUa7dAe5aljqot/yJx48lOF4SNajCp52S4nsaezG06wbH8uZ+f3z4QbamSuK3WlvxwvRXmVpYneES/AjRplp2QVmdfOCeMA5phU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3688
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > It doesn't apply to our for-next branch.
> > > > Sorry to hear that. I've rebased the series on mainline 5.5-rc7.
> > > > Should I
> > > rebase it on for-next branch?
> > >
> > > You should always base your branch on the for-next (whatever it's
> > > being
> > > called) of the subsystem your series against of.
> >
> > Hi Andy,
> >
> > The current series has a dependency on Tiger Lake and Elkhart Lake patc=
he
> which is merged in to mainline.
> >
> > (554f269f0f38 platform/x86: intel_pmc_core: Add Intel Elkhart Lake
> > support 49a437941c3f platform/x86: intel_pmc_core: Add Intel Tiger
> > Lake support
> > 6268c0b278b5 platform/x86: intel_pmc_core: Make debugfs entry for
> > pch_ip_power_gating_status conditional
> > e39854781830 platform/x86: intel_pmc_core: Create platform dependent
> > bitmap structs
> > b1cb33dae414 platform/x86: intel_pmc_core: Clean up: Remove comma
> > after the termination line)
> >
> > But they are not available in for-next branch. I am confused, how that =
could
> be the case. For me to base the current series on for-next branch, the
> dependency patch series should be available in for-next branch.
>=20
> I'm wondering how did you check it?
> The branch location is in this [1] tree.

Thank you for your patience Andy. I apologize for the mishap as I was check=
ing in the wrong tree. I have rebased the series on for-next branch on righ=
t tree this time and sent v2.

>=20
> [1]: http://git.infradead.org/linux-platform-drivers-x86.git
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

