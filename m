Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C0B2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="lhBBTM+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIJRJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:09:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:6716 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgIJQxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:53:09 -0400
IronPort-SDR: KOhw8S+7kFEnJhg+e08zHLLGmUJKY/uV5kZAv0hM38EpJm3ZlIw1l8g0azSZEYkSdExnwC3ac0
 0MGkkMj/dA9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="243403078"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="243403078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 09:52:50 -0700
IronPort-SDR: pAEPlXHx0J9Ojxd2huzRur81oXMV+9rzxu43DswPATT3urzvIZ3iemK3xawRX6VHfv6Yq8MBxG
 Lk6uo1p1/1cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="329402903"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 10 Sep 2020 09:52:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 09:52:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 10 Sep 2020 09:52:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 10 Sep 2020 09:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS/pOE4PLPtZDPR5diwSDCIBu7m6SyXrv5jj/dUsCt7yKDQziR1jdWtRdw+XxpxBorksK86t3C2xDINMC4Ofq85QuUpEKwgkWbJ8zacPpA7maiWqVaEFwp3hOsxD8MfXJtl+3DaIgAflFXv3JiDWOGlP7VIKQcyvL/AYyHpLG5d3qjLUc61LWzbqK8hDqs1yhnHW5pmxLanyu6sG+NXFxZGmA0xZ6aAXssFTSCz2xoX67CmwvJXH/vbmnA+9HS5VnLgVmQVMakiOfmlTQ6WcCu4yGExLQ096/1DiYmO8Go+VUlyj4GjIhb51Axug9HL7z9rLDcaHU5iuO5B5u4+kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+uLZ7H9Z4tkZ74Gq5+MhqjW51X44V5L/zzsJrDHlAk=;
 b=D7k6+SVzeCOq0/TrWM1s2U5rpab9s5FGXHzfG9Ds4g1erR903ufhXd3eBVNXyhqdghLbdlzD0GBGd20Es2gP43BY92P4X2H/+KlaZJsbqZevFHR0fuTpc6iFtiX03Gxiof5ASAOWAwcg1kF+sOV44SG39+FDVpp0A0rEXnCJm1A6IFwNe307aDZ56AjWVwIEdh0aHwB9DXNfxmAT23fhp/n0rPIqM8cDKlnmR2zytoyz5IQadIiuoo0oh2/WW+VUlHGT9oE+IsLxXzIYVetJPHceF/KUcVWj0OlS3cD8yytDP2c4YO0tYPL1j5Df9Xd4EJV7Ph1Y1n9aV1GhhPlpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+uLZ7H9Z4tkZ74Gq5+MhqjW51X44V5L/zzsJrDHlAk=;
 b=lhBBTM+Fy9iT3LHkVHbW4f6CDZuDEEUnRszG+4THn1igVsaJ01L0mcMQo59xYeNS/A7p/AHE7y+/IWfD5qKmWE1CqDpV8oasBfKRi2VuuhNbVVeHrtZgV6oIMakZ21B5yw8/Go0o2Id84j4Zdd7b7rrkjCpLOXvP2HD0dlOWpyc=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3104.namprd11.prod.outlook.com (2603:10b6:805:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 16:52:38 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::54:b143:c75e:41bd%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 16:52:38 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Thread-Topic: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Thread-Index: AQHWhRcMCBS5jrzbZkavfoY9EXJ14aliEEMQgAAFaACAAAClMA==
Date:   Thu, 10 Sep 2020 16:52:37 +0000
Message-ID: <SN6PR11MB257475DF5F45FED24F4D4968F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
 <20200907130150.GE2371705@kroah.com>
 <SN6PR11MB2574DA2AA215E9566BA4F410F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200910163208.GA1321670@kroah.com>
In-Reply-To: <20200910163208.GA1321670@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [68.203.30.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecb89772-f0a1-4b4b-aec4-08d855a9eca5
x-ms-traffictypediagnostic: SN6PR11MB3104:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31041E35BD530754B0FAF2B3F6270@SN6PR11MB3104.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIKTeZZE7RhRIPblnjU3W1a8ISb0cHAnmj8KsNaSXGHEquwvCJvbQA4qeMr2PW4zGLsQnXEe/xRlioX5s/jZ3LbYc2DzRCSIV9+v1dpZY5gR13mICy9aleadDJ3Z2jjkBdhjtzvDWxgvKi6wGjCtfJlG1sVQDmtoHvH+jJLyN/2kFN1fCJE3lVIcVgZXAiX/tEMoEMFCUeU+hfoo8Fo7r2nHjhgArWPhZPJKnYTJ8Vp+bF0NAsXUp20lYKptC/lNLZesGduC4giNgUBRuxp2SrZY1+wLA/DQ5lPwGgqiIhm2Qr6Guhp9ReOXYW55VzynIbGIq5kSLAvtYczrn8JimQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(107886003)(26005)(8676002)(478600001)(186003)(4326008)(2906002)(8936002)(52536014)(86362001)(53546011)(6506007)(71200400001)(83380400001)(54906003)(66946007)(6916009)(76116006)(55016002)(5660300002)(64756008)(66556008)(66476007)(66446008)(9686003)(7696005)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MtW4pbzUlYb5Aqg3oj0DEF5xnkMKlZThJdalpxY36cwwudfxL6+Qi1DKjHNbMUwbwu6qJwRCsGisndT6bJlZ4XFUaC5J/DrqTfbqV9p07BeprE4+Clfa88MHnpNwnj3EaiDowKCUrpk2hM9x1DJaUtEa/NFhxshtVj4IF1Kpbx+MuG1coPn8+zD88WYQsJ+/VlvljUlsYAiTL6/wxAElOi83lv2W2rG/zek+7nobZMsIYxgA8Td3kfJTTrHLQoArdq3OFKyyXiF9KWJxRfYNcha/n2btDZLwHkl9RL9SYEXExtCQJ2lZf4hzjLAdtDCyhBEhdC6Ehl+EDuoyMq7ZIJjw2DTRkgCM5mAPfB9IbyMpPdaX5PkEIqx2i3r7SZyAtdiw8WEATo8pb67ZZdQTf5QsYaTqy3+xYsV1HNILwSoqgOjsyVPQOPM3h2EhRVX6R4ocLrKD0WqkKlHbhj1z+k3jFL58FIb2B4Zc4tqRyUzZfR8hFrJQDCsDEry7BkEXIV5QXMoy2mVsgUXAY4bS4S4n5QEvUZe4fTw3ULd7glar/QDtKsd7TFq1nnHTe2X+03Rj2XV6i5kmTTkXAVyPp3gIT+SideRyTwpxoFtLuaQ5y5fpQYtAjDIzTsxeyo/TJnwEhtSeMPCry7TNaYT0Gg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb89772-f0a1-4b4b-aec4-08d855a9eca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 16:52:37.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Deqq4aNpmQA1S14Ct6hSby624oFKgM7eY3vA779b2OYKNczzu5QpNUMfqLDFSZ4sszxFgFSgqjhQudeIo5yKeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3104
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, September 10, 2020 11:32 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
>=20
> On Thu, Sep 10, 2020 at 04:24:31PM +0000, Eads, Gage wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Monday, September 7, 2020 8:02 AM
> > > To: Eads, Gage <gage.eads@intel.com>
> > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
> > >
> > > On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/dlb2/dlb2_main.c
> > > > @@ -0,0 +1,208 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Copyright(c) 2018-2020 Intel Corporation */
> > > > +
> > > > +#include <linux/aer.h>
> > > > +#include <linux/cdev.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/fs.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/pci.h>
> > > > +#include <linux/uaccess.h>
> > > > +
> > > > +#include "dlb2_main.h"
> > > > +
> > > > +static const char
> > > > +dlb2_driver_copyright[] =3D "Copyright(c) 2018-2020 Intel Corporat=
ion";
> > >
> > > Why have this in a string and then:
> > >
> > > > +MODULE_LICENSE("GPL v2");
> > > > +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
> > >
> > > Not use it?
> > >
> > > It's probably not needed at all, right?
> > >
> > > Don't you get a build warning about this when applying and building t=
his
> > > patch?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > dlb2_driver_copyright was used in a pr_info() in the v1 patchset that w=
as
> > removed at Arnd's recommendation, and I forgot to remove the string.
> Will fix.
> > The unused warning variable was likely missed in the deluge of warnings
> from
> > included kernel headers.
>=20
> You should not have any build warnings.  If you do, then something is
> really wrong, the kernel builds cleanly today.
>=20
> thanks,
>=20
> greg k-h

Sorry, I worded that ambiguously. The driver builds without any warnings wi=
th
my GCC (7.3.1) by default. The deluge from kernel headers only occurs after
adding EXTRA_CFLAGS=3D-W. There shouldn't be any dlb2 warnings with -W enab=
led,
but I'll double check.

Thanks,
Gage
