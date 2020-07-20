Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C56C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41A722482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ogq2OCWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGTTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:02:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:18833 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:02:13 -0400
IronPort-SDR: Pg8cNMBg7YL1NxpdOMRjhqQS6Q4pss68FBPaUeE58a6HS7JifNypGtfcm4UwT3H3hl2k6Hxy0H
 eTSnu6C4o/Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="130070267"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="130070267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 12:02:09 -0700
IronPort-SDR: FeV1Ux5i1iem2vnc64dDKx6Ziqs6/sZsAG1bw7r3/Zla48JOlEHvYoTxkUi6ekPk9jnWywChIw
 91yOKYw6dVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="319635930"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2020 12:02:08 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 12:02:08 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 12:02:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 12:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX+zg5LXnMkbpDmsH+FYvWwNOJimtDWaKD62VgFMV6oCRk5CfdtOwnOawDRqxcqo3BWEE7jt2ind7L04QhuokBEcDfIZNFu+NI4es3BDWucWM6npZsW9siruDkd3vm6mMQ8234lsue61yt/ZJlT8xK1JPWUUXKZXiblcljpoG6qVVUtqm6MzW5ma6heWZCkbmVA6QMRFRTp0h4EfaXUuJQ1liubguNq6KqWjWSNrdGHMnTOybSYuTWTdsp8H5/E2kfUWKLPxwQou07av0QaYkS/sDQSACxrt94xkl1qxm91jnblLlIldxf/Hgqk31wxMP1HVPoIBabLhDmn/5qUzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNNeitHgF4Q+O6lw/m2XHIS74/fTSDLvqieOR8lpFY8=;
 b=moyQv7tzvwd1MGx3GPClLYFQqIa75BQXNgH8bdDHq1F3DKrrhPfd2zaDLig5O2CIZrcdW7GBmhIe+SmJeA38LLUk0iR6YVhLNCwdF5+crvVBcBXxE4L/daIEh6KgaeaLWtDyaAHUHZu0v2KwcYOVj6koYJYPflVG+IZjti9soIf4gsKQ7GJ+lv9+/kLA4AovGyezI6P4FmHyMR2UmGWZXiDD0LgOu6mdYdaOnlG6Agf6NX7Ua3mmFRzWLl3zq9cLyKB3g68SrIud6WyhC8WmCZBSkp5u4wxUz6aYrK2dVRYLKMRli2brFe5O6hXcHYxp0l+rExz4U8xTqqDR2A5Vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNNeitHgF4Q+O6lw/m2XHIS74/fTSDLvqieOR8lpFY8=;
 b=ogq2OCWGGKMvo6IJCG2sn4dAs4s9NLNE8mhPyvBNq6aCBpvD1kdFhI/vXt4eWnlvuvY2aAitdjPV6nZCNp3a/u/ORlffukwExEvMYLXtCU9cK+UzVTyZhwu6FbPgOfUtpgFdWu4JwwbUnhYaVCN2cPk+f9PxrLxXnZ4thSKJCGM=
Received: from SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14)
 by SN6PR11MB3534.namprd11.prod.outlook.com (2603:10b6:805:d0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 19:02:06 +0000
Received: from SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4]) by SN6PR11MB2574.namprd11.prod.outlook.com
 ([fe80::b8e9:bae7:d1d8:64f4%2]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 19:02:06 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Topic: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Index: AQHWWGU9Tth4ik4BzU63g7CSJsQmkakKx86wgAIl3ACAA+YfQA==
Date:   Mon, 20 Jul 2020 19:02:05 +0000
Message-ID: <SN6PR11MB25746161DC8D54AD5BD30F96F67B0@SN6PR11MB2574.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155810.GC186665@kroah.com>
 <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200718064656.GB245355@kroah.com>
In-Reply-To: <20200718064656.GB245355@kroah.com>
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
x-ms-office365-filtering-correlation-id: fd26abda-deb0-4900-b2f7-08d82cdf6539
x-ms-traffictypediagnostic: SN6PR11MB3534:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB35344BBAEBD7F66D518D153BF67B0@SN6PR11MB3534.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 822L5gZhvCFWN0gLCAYwx5BCs1Ro2awpFTMAuo58UFCDarSXaMldyFwQrS61Iv15GogIXWFniAwe1rd/N/yGQwnRac0UjyMeGG0eS6B49h9/EeyMfCD5ykuuF8tVST8DwmA1Vak2EBS0pE8o4hxyzn1ak/VlntzwXfqPHq/wOD0av1YuS91vefC2IXMlE/ucnMEXrz6MwdlpK9dK5I8xE05bwTPxe1jZlCzdXlrkrkvzZfZl2+5YG5/RfQJKRiY+Cg1Td7UDGXgYRODSfYHm0cpjZ7yf/vi1f0bfm3exJeNe2fmjiWqi7WFq/yPoBJWhmeE6DMfIt8SB27+FHwLkximxxNv71zSnabK3J8w2lbb+oDvTKG5kfSxcPV6xFDcYZevEZoRQ22jxaVElxRg5XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(71200400001)(6916009)(316002)(53546011)(7696005)(6506007)(186003)(8936002)(52536014)(2906002)(86362001)(26005)(54906003)(107886003)(478600001)(8676002)(83380400001)(76116006)(66476007)(966005)(64756008)(66946007)(55016002)(66446008)(66556008)(5660300002)(9686003)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kiGn+Hi60aWkiVj4r9Jw+UVFp/4BJ97fxhuXe/tue7CpEVD62A+mByfqMEjmBd62fvgF1TATbdLvi5K8LD9GCPcPwRG9OfvK0+k2lNOAPlXeZUziNBYcZ7YbKAT1cj+Qbvpyzwd4YZIukVzGNrF4+vw4qBYHOuFyPBGNJQCe0LR7sPCDflXJSBb8qwTrCpVGOgQP0d1Wce1bjQNHQZfAzSPBMqbYQVwLAeCwhxHxYzuelAS4JLcbMHFA+KYYwsPTfnR+er+L+qr8jDD5dMqtRuqu/GKeiuJXj/2g5NKHrXtK0McIBuSoSTwf3QjL2WB+CREq6+18fVusRsEJoLeqnU5UsYpvxvWXnajGIejz/Tnj+uF1eQfj7PNgC0ERUXUPqVWywNRTGr05MCIGn2dLRrrCajWmHdA0gyFnMypLi0/8G/eAgpZJ2Zbmif1IKwrU8sv4Du7LPD6GUeyd3oUBtbwM3QereNM9O4vNIenAGC4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2574.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26abda-deb0-4900-b2f7-08d82cdf6539
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 19:02:05.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+aq4dneuRZ2C7BL18IY1ISxjEDfRWVeExUn146vDcnydJgc6nocNF0vTUyyKxfrDMHF+iUQUp4TkqSYOm2qfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3534
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, July 18, 2020 1:47 AM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
>=20
> On Fri, Jul 17, 2020 at 06:18:46PM +0000, Eads, Gage wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Sunday, July 12, 2020 10:58 AM
> > > To: Eads, Gage <gage.eads@intel.com>
> > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > >
> > > On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > > > +static int dlb2_probe(struct pci_dev *pdev,
> > > > +		      const struct pci_device_id *pdev_id) {
> > > > +	struct dlb2_dev *dlb2_dev;
> > > > +	int ret;
> > > > +
> > > > +	dev_dbg(&pdev->dev, "probe\n");
> > >
> > > ftrace is your friend.  Remove all of your debugging code now, you do=
n't
> need
> > > it anymore, especially for stuff like this where you didn't even need=
 it in
> the
> > > first place :(
> >
> > I'll remove this and other similar dev_dbg() calls. This was an oversig=
ht on
> my part.
> >
> > I have other instances that a kprobe can't easily replace, such as prin=
ting
> structure contents, that are useful for tracing the usage of the driver. =
It looks
> like other misc drivers use dev_dbg() similarly -- do you consider this a=
n
> acceptable use of a debug print?
>=20
> Why can't a kernel tracepoint print a structure?

I meant the command-line installed kprobes[1], but instrumenting the driver=
 is
certainly an option. We don't require the much lower overhead of a tracepoi=
nt,
so I didn't choose it. This driver handles the (performance-insensitive)
device configuration, while the fast-path operations take place in user-spa=
ce.

Another reason is the "hardware access library" files use only non-GPL exte=
rnal
symbols, and some tracepoint functions are exported GPL. Though it's probab=
ly
feasible to lift that tracing code up into a (GPLv2-only) caller function.

But if tracepoints are the preferred method and/or you think the driver wou=
ld
benefit, I'll make the change.

Thanks,
Gage

[1] https://www.kernel.org/doc/html/latest/trace/kprobetrace.html
