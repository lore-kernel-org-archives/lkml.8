Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0282C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA480206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NZ5nqg3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGQSTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:19:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:37369 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:19:18 -0400
IronPort-SDR: oJV2YkGD1KHsBuO1A+DhGGHsTPbC8it4sEo5Cc9T5y8BSogaFgqmaxWmpaoZX+2j0qbBwZD69G
 MGz2wLqtVq2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="214360548"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="214360548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:19:17 -0700
IronPort-SDR: AOvmw2vU3av7wq5RacRtZIHFDXWPHjQoMJO72dgw5NBrMRm/753JOVeVdk1ElbllFYcjOkbvjL
 kJQzXbu5S9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="361421036"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2020 11:19:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jul 2020 11:19:16 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jul 2020 11:19:16 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 Jul 2020 11:19:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jul 2020 11:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrv2vYkXKPcKPLyaU53LDDEEc3j1U55GbTZY+DiHlovkG3/87Oh1rDFHmzQJQ/4DNiby8GjQEixrZOreuxRr4WMkz75e4TySDXjk5QJDVcdMGJm2c7R/t5rTfra46+o/Vn42m1aFABlEdJurwOO6d0BWiOJMXmSpvsSSAUrbG7Mh6VyHPacD7pxqhOm38LLqrsHAkfCgMDvxFyJgx5lqv8KqBuuP74QyMy7Q0K1w+MGExx/Im5OHHhPzIwmzwg/R6ntwyWLHiZ7iPAcNlp4IEbEq8XsPB3gABKIKMQ+HfykI9N0Kn9FpG4ptPBNhAA/HFil7o+AjTBCTCoTcyZ1MzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40IaP4AD7B1ASEWx+VluzhVyU5K0s+vcBC3jUhrxIWI=;
 b=gLoaRcgNOmzQASyPLJXf8LtvjzdY1gpUVe3tC/WOJppdIoLQeTpow8/zOS6CAjzyly1I2L0YrawjsrzWuhOli5hSJcWbTtivk8XyFwSpLsGDvCuCsJ6Ibaw/A0jla4R7QqKksoK2Cwe8SGiceONeXck/ZCjvuL7r5HX2wj/W8gkkR7sjGcmQsEY6xHOi+p4xHkWQqQHJyt3LELzAaPQh0QbnaruS67+HcTIP8UyAJQj6PN9gPD5koSV/gHVe3BHimzSwp7ZeYgPx6OzriCjm22smsb+IVUE7aCubcARQ3bAC6l+GZWYMyaCqgPFwce5UphPnqEUF0HHGI0TohvbujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40IaP4AD7B1ASEWx+VluzhVyU5K0s+vcBC3jUhrxIWI=;
 b=NZ5nqg3RLpwaRMG0Y9vD3URvqw9NOekb7ZyXRMGS34vu9dYTuAIb76kTHOBrFE546qwhwbfje/42zF5NJUQM1hyw59OCtr7JQqzGFiUbalhxo8mFhePPexmCnpJFmTji+c8GFgyB7kEAG5DFHlftrUdFaoHpsbagMKMKWONMJ/w=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 18:19:14 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 18:19:14 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Topic: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Index: AQHWWGUNTth4ik4BzU63g7CSJsQmkakKy9cw
Date:   Fri, 17 Jul 2020 18:19:14 +0000
Message-ID: <SN6PR11MB25742456A7DA3C99F88FA77FF67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155631.GB186665@kroah.com>
In-Reply-To: <20200712155631.GB186665@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b28e44d6-534d-4f90-e20e-08d82a7de937
x-ms-traffictypediagnostic: SA0PR11MB4751:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB47513BD55C97FF7AAFF15856F67C0@SA0PR11MB4751.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DB5FBVqlPRAGqhRka8Cq4HyBAEqQGsmsQ43enOXGMAwOFdkDT4sO3MZJv48FG+d0ozXL4lCDGlocMKL2zrNem3FcwtSomRnt2I7XKfZ8NuKAcpqtRW9ADpw1eJ6mlw9BwRGR1DJFW7VTHwKJTvowXuh8vsNF1h9ihNgTr78tbeun4j6ru4VTYD44tc5zjCxbkMKqDAjoERr9sGZWWedsil2o8x1F7BOr2baWrmbZsQvbqintMU1sUNyB5/Y55Ip7V5hnWzGwcgVi7SonbVXtv5QXJHfLLZ3KwbnybE+ybsfD9CycrYzaU2i9j7+jcBl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(26005)(33656002)(9686003)(55016002)(7696005)(6506007)(8676002)(478600001)(53546011)(71200400001)(64756008)(66446008)(76116006)(66476007)(8936002)(186003)(86362001)(66556008)(66946007)(107886003)(6916009)(52536014)(2906002)(83380400001)(316002)(4326008)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IeygK9UT93atQkLVZFnKs7GVXnb57sFZikyffnf+C+G5EFQguzPCNgYzRCTd5ddKyRNey8HIidFGHlxvk+xVEVCysS50BAc+L/9ioUTM8nthka5c5dyjvZpg/a4mAMgl7/EhGF1Xh07kTLRhZ9JaIfvuhc83OvFD2pUeQujzNphMYYg7TamA8V4wzBZnuiSXsjeigRNOZPYzhKbkLmSZyUSp8qhXJNXW4FQSA1L0aZXjuej8Q42mMnkEDoNmREb+NbHN1DUlK/cKrvXVYMVT2dzvep2eaHa3nmeL0q0bOg9pqQS24YHagz9DrPBGpG1quh7WGCkgtwslQ6YkUHmhQUOlUG3tnpLaUdguIPZex2DdFcqHqGhXIrmX1GFygv2/WQgrKl1FEVeVDKVuwixrfpQYZvHM4D40Qc2y4pbCAMCDuoEk0QWbxxDclbUwvabK+bs7hCWhY2sGIgdlKHfxY0Xk4X01ID3qOQsUp2WlGL0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28e44d6-534d-4f90-e20e-08d82a7de937
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 18:19:14.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQ0yfdDroo8BNSfg3XqXN4wimTFq5dbb1pOxDaxRswCRMKAz3PVpX02kRl8hSf85s0Agxbshy/ArtSlg7/Dl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, July 12, 2020 10:57 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
>=20
> On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > +config INTEL_DLB2
> > +       tristate "Intel(R) Dynamic Load Balancer 2.0 Driver"
> > +       depends on 64BIT && PCI && X86
>=20
> Why just that platform?  What about CONFIG_TEST for everything else?

This device will only appear on an x86 platform. CONFIG_COMPILE_TEST won't =
work, since the driver uses the x86-only function iosubmit_cmds512().

>=20
> > +       help
> > +         This driver supports the Intel(R) Dynamic Load Balancer 2.0 (=
DLB 2.0)
> > +         device.
>=20
> Are you sure you need the (R) in Kconfig texts everywhere?

The second is probably overkill. Just the first one is required.

>=20
> And a bit more info here would be nice, as no one knows if they have this=
 or
> not, right?

Intel hasn't yet announced more information that I can include here. For no=
w, "lspci -d 8086:2710" will tell the user if this device is present.

>=20
> > --- /dev/null
> > +++ b/drivers/misc/dlb2/dlb2_hw_types.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>=20
> Why dual licensed?  I thought that Intel told me they were not going to d=
o
> that anymore for any kernel code going forward as it was just such a pain=
 and
> never actually helped anything.  Has that changed?
>=20

The driver is mostly GPLv2-only, but a subset constitutes a "hardware acces=
s library" that is almost completely OS-independent. "almost" because it ha=
s calls to non-GPL symbols like kmalloc() and kfree(). This dual-licensed p=
ortion can be ported to other environments that need the more permissive BS=
D license.

For the broader policy question, Intel's open source team will get back to =
you on this.

>=20
> > + * Copyright(c) 2016-2020 Intel Corporation */
> > +
> > +#ifndef __DLB2_HW_TYPES_H
> > +#define __DLB2_HW_TYPES_H
> > +
> > +#define DLB2_MAX_NUM_VDEVS 16
> > +#define DLB2_MAX_NUM_DOMAINS 32
> > +#define DLB2_MAX_NUM_LDB_QUEUES 32 /* LDB =3D=3D load-balanced */
> #define
> > +DLB2_MAX_NUM_DIR_QUEUES 64 /* DIR =3D=3D directed */ #define
> > +DLB2_MAX_NUM_LDB_PORTS 64 #define DLB2_MAX_NUM_DIR_PORTS
> > +DLB2_MAX_NUM_DIR_QUEUES #define DLB2_MAX_NUM_LDB_CREDITS
> 8192 #define
> > +DLB2_MAX_NUM_DIR_CREDITS 2048 #define
> DLB2_MAX_NUM_HIST_LIST_ENTRIES
> > +2048 #define DLB2_MAX_NUM_AQED_ENTRIES 2048 #define
> > +DLB2_MAX_NUM_QIDS_PER_LDB_CQ 8 #define
> > +DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS 2 #define
> > +DLB2_MAX_NUM_SEQUENCE_NUMBER_MODES 5 #define
> DLB2_QID_PRIORITIES 8
> > +#define DLB2_NUM_ARB_WEIGHTS 8 #define DLB2_MAX_WEIGHT 255
> #define
> > +DLB2_NUM_COS_DOMAINS 4 #define DLB2_MAX_CQ_COMP_CHECK_LOOPS
> 409600
> > +#define DLB2_MAX_QID_EMPTY_CHECK_LOOPS (32 * 64 * 1024 * (800 / 30))
> > +#define DLB2_HZ 800000000
>=20
> No tabs?  How easy is that to read?  :(

I'll improve this (and a few other instances in later patches) in V2.

Thanks,
Gage

>=20
> greg k-h
