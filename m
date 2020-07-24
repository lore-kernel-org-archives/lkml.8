Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2605206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Denu9/Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:00:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:35661 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgGXVAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:00:43 -0400
IronPort-SDR: Vx2vK1CxwuQVpspXaO42nVtUa0ukj/KN/qh/5WJPrnyGulO+GE1GO1B7YRzomulhrrJpEVXKzd
 1jQL+Jn/zvzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138292027"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138292027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 14:00:23 -0700
IronPort-SDR: pbLf7hxeNV+PKCGzkxmcygZu9IRN8UI8TXUQmRZYpVjx055wlBFKutLr7o25IMJEnAl2p1QuZg
 oAyp+zrflfVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="319419541"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2020 14:00:23 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 14:00:22 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 14:00:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Jul 2020 14:00:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOkj7bLhtCwwTndDhO7O7AbOUL3iGxWLeFZ+6XfpjjMMOLU/DcAOmsoC/B3FufzvVisnMaoElTe34iiRFfxhEmpLpjX/HCdYyQpIU0Ll/R6hZECJhW77DPy7k+YKYMknF8NbHLRJoDC0UCA/vskQbpWjb82C64G0NHCXl8UsmQXgNmO8ExL0YTys56RVBRhN813/sncBJBLRsnDKg1YxKtVKpcfAUWQRp6b1Vm0rAm+M9nKD38GqXTffY43UdcYrN4EpixLL7eAlO57D8aqTROamxOH34bA9Cjocl8d58X7H1Wncpwfcqa2mPlZqPjxfhM2NL7s7KSlw0i0D8IbfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK4RdOTvyC0sSJz6qEA3ah6DYRjXuKTwQo66+Z+PahM=;
 b=LIa3TVUmpd/f+erh2/q2amoolzXF2DhsG1hpKREfciQ2yeYG8y4Yxl5WJ7dzC1yq4i3goT7+kuFsx9PmnudXjtymfbGEBE3DofAHMfp8Qgg9BHGdf8yfLXsjzEFYDZOmvaz0xNa9UESLyQr67KMW9VomXUZauCi8vefF5xv/3Pl/skrwDlnObCIuH4klCnPfJXiuWn275gRX+SSn/pn0Z+9be58HL1Y5xMgWMi/aFC9hA/BfpTi9bkqhOWV7p3RiHaRPuNMz+ypjIYT7w0cwqNEzwdTj81uG2RPeIkE9EFPe2zDcoeEp5ijcx6+MeXXHbuZ4NCso2cfPDuG3/KyOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK4RdOTvyC0sSJz6qEA3ah6DYRjXuKTwQo66+Z+PahM=;
 b=Denu9/EvMgz5+Re3jHpa9q8iMABEZX8geCsAmngb9mOgBfsU0jXFUDTuK5OnyjTQArjU5OuvxNipC01uizumF0mDWU5s301k4cihSumyNY8y9sexoECCuFqGf9UJ2aDKCDOw/k4H7mnZKkNxQ5etYR6cwPvxRuHnMeBCKSDN8Ws=
Received: from DM6PR11MB2572.namprd11.prod.outlook.com (2603:10b6:5:c8::31) by
 DM6PR11MB2572.namprd11.prod.outlook.com (2603:10b6:5:c8::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Fri, 24 Jul 2020 21:00:20 +0000
Received: from DM6PR11MB2572.namprd11.prod.outlook.com
 ([fe80::706f:31b:4c35:149d]) by DM6PR11MB2572.namprd11.prod.outlook.com
 ([fe80::706f:31b:4c35:149d%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 21:00:20 +0000
From:   "Eads, Gage" <gage.eads@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: RE: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Topic: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
Thread-Index: AQHWWGU9Tth4ik4BzU63g7CSJsQmkakKx86wgAIl3ACAA+YfQIAAEK6AgAZgyWA=
Date:   Fri, 24 Jul 2020 21:00:20 +0000
Message-ID: <DM6PR11MB2572EB1152A0B1453531D72BF6770@DM6PR11MB2572.namprd11.prod.outlook.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-2-gage.eads@intel.com>
 <20200712155810.GC186665@kroah.com>
 <SN6PR11MB2574E9B6F6957D765BC18F29F67C0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200718064656.GB245355@kroah.com>
 <SN6PR11MB25746161DC8D54AD5BD30F96F67B0@SN6PR11MB2574.namprd11.prod.outlook.com>
 <20200720191903.GD1529125@kroah.com>
In-Reply-To: <20200720191903.GD1529125@kroah.com>
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
x-ms-office365-filtering-correlation-id: e45a0edc-a225-4a2d-9fb0-08d830149360
x-ms-traffictypediagnostic: DM6PR11MB2572:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB25723106F2A9F687C40F1521F6770@DM6PR11MB2572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pe1yEtSQNOGfgVXrNg7gGxTKn+t5cr9ZwhY3uFRcQDnhJcad4sNOR+J9QFFL/Cmfi1UbUmztSJIbuZumUi2yUy6qlykbzyELpkdB9inS8ERKM5KB1lVZxxJlHfDM3KloOvNVEYO+Nh4BM/wD/UGpHxyor9AcQBXWBMhpLfOE6v1RpUEq3XFLw29pf6e68lVMVl/lTg7HyQep3E3AzSo1ABncuTa0TRcNl8JOPpQ1K+1T0NaX3He7PNuCS1YP/CkRIBlQ5a03Yvjr8Od1JTgd7+xT51KAWcP0ITlHyvpOzWnKqSrO3hIaJo+BVN12KCqEEw1TLHx9Gde2UZkAI6EEVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2906002)(52536014)(186003)(8676002)(4326008)(54906003)(33656002)(26005)(53546011)(6506007)(478600001)(55016002)(107886003)(7696005)(71200400001)(86362001)(64756008)(66446008)(5660300002)(66476007)(66556008)(76116006)(66946007)(83380400001)(6916009)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rgmPKIrcdluRSXBIo+PKxNOyAMo9ejEZchkwOVyELF2d+qNjrtc9NcaJvs5k84vrgHVN6zf+f0Oi9k4qBh/ckxT4r2oqRdWaPqeuVN4KVRDB2iN1JrdY8d3V1WjFKIvjjKi349xDdKuWV095cniM+F0TMLlHZIShk4GgxaEYuAuOJGEHVLsWdBYJE+N/ZCvrwtwLOOJPtYGP/7SFB2Pbw0+CbfvnY/DxSvJXolXnDAwxRGucYa0LtO9zR7E4xWYzG3WCYAISJKX/xkoWHuDmoFTCq8z6AD8PpQ3drW81zFfLmKxhsNEmq+KQPibiRw42NtVDN+zcZpkqOSCxaLYR2UyWASMlq3VV4IbU0UlFTJ/LG4sNjt/Q2umXbLm1ow+BVEUDPCCQJIGRh/6G3gjRczQjev2atSkjc30hR2XzfvZsmCBh5xQH7m4t4II8TBk3MRfxySy+TjUercWTUa1VVX4Mpm3DklrpeKFMWtYmQCE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45a0edc-a225-4a2d-9fb0-08d830149360
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 21:00:20.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQTKf0XQ9WYsAq+csAo7q7KPh0PIAB1yo2PsNUEH6QWDGIfoNKBAif5e7MPnOPDNIK/MaxNqei7UDzKW4WG7iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2572
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, July 20, 2020 2:19 PM
> To: Eads, Gage <gage.eads@intel.com>
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
>=20
> On Mon, Jul 20, 2020 at 07:02:05PM +0000, Eads, Gage wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Saturday, July 18, 2020 1:47 AM
> > > To: Eads, Gage <gage.eads@intel.com>
> > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > >
> > > On Fri, Jul 17, 2020 at 06:18:46PM +0000, Eads, Gage wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Sunday, July 12, 2020 10:58 AM
> > > > > To: Eads, Gage <gage.eads@intel.com>
> > > > > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > > > > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > > > > Subject: Re: [PATCH 01/20] dlb2: add skeleton for DLB 2.0 driver
> > > > >
> > > > > On Sun, Jul 12, 2020 at 08:43:12AM -0500, Gage Eads wrote:
> > > > > > +static int dlb2_probe(struct pci_dev *pdev,
> > > > > > +		      const struct pci_device_id *pdev_id) {
> > > > > > +	struct dlb2_dev *dlb2_dev;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	dev_dbg(&pdev->dev, "probe\n");
> > > > >
> > > > > ftrace is your friend.  Remove all of your debugging code now, yo=
u
> don't
> > > need
> > > > > it anymore, especially for stuff like this where you didn't even =
need it
> in
> > > the
> > > > > first place :(
> > > >
> > > > I'll remove this and other similar dev_dbg() calls. This was an ove=
rsight
> on
> > > my part.
> > > >
> > > > I have other instances that a kprobe can't easily replace, such as
> printing
> > > structure contents, that are useful for tracing the usage of the driv=
er. It
> looks
> > > like other misc drivers use dev_dbg() similarly -- do you consider th=
is an
> > > acceptable use of a debug print?
> > >
> > > Why can't a kernel tracepoint print a structure?
> >
> > I meant the command-line installed kprobes[1], but instrumenting the
> driver is
> > certainly an option. We don't require the much lower overhead of a
> tracepoint,
> > so I didn't choose it. This driver handles the (performance-insensitive=
)
> > device configuration, while the fast-path operations take place in user=
-
> space.
> >
> > Another reason is the "hardware access library" files use only non-GPL
> external
> > symbols, and some tracepoint functions are exported GPL. Though it's
> probably
> > feasible to lift that tracing code up into a (GPLv2-only) caller functi=
on.
>=20
> Stop going through crazy gyrations for something that your own legal
> team has told you not to do anymore in the first place.
>=20
> No "hardware access library" files please, that's not how Linux drivers
> are written.
>=20
> you all know better...
>=20
> > But if tracepoints are the preferred method and/or you think the driver
> would
> > benefit, I'll make the change.
>=20
> I don't think you need any of that stuff, now that the code works
> properly, right?

There are no known issues, correct. The logging (whether it's
dev_dbg/tracepoints/etc.) would be for user-space developers -- visibility =
into
the driver could help them debug issues in their own code.

It's hardly a critical feature; I'm happy to change or remove it if necessa=
ry.
But it could be helpful, isn't a maintenance burden or performance hindranc=
e,
and (AFAICT) shouldn't pose any security risks.

Thanks,
Gage

>=20
> greg k-h
