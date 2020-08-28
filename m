Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96D2208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cVar68i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgH1PVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:21:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:8233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgH1PVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:21:38 -0400
IronPort-SDR: zbeJLlo4MyeFQ23eRZYuN5HtuYzrcxbTX8rqoB2Y+tfIz3F+SW650RYCWvFp4SKfh5RAKuvBni
 oNqL8yl0MYQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="155942164"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="155942164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:21:36 -0700
IronPort-SDR: 5AzL6bCfU8sqBhH9dnNGMXsnXJwa19INQzEFBtECdoF9s/PVGcNFwYXHmmwgNiQPgANLWAz5ps
 RnbbbhMmxDYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="337521262"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2020 08:21:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 08:20:24 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Aug 2020 08:20:23 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Aug 2020 08:20:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 28 Aug 2020 08:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIGycc1s9eltW5avtupi8JCyskrlueS8GrbdfJ4NRU3KyOHjR03aiTEX1MTWgvZgsf9M5STAMMqHl7ZsC075tgtyfxkWOuvAIy3fbXal/Gx3wYDiO9t8G7nf4Nwr8HUyvP6cgw4RoaYJ09pvfPGBzCRR+tUYlWCDbvhp23i5QWY9aY7UiaZ0FX+oPj5PzxjHOEpa2n6sZmVfnNXT3kY13nKq7idBeiwHZBGa+T7Ta3r1DAOcdzArO/NYjBRXbM6c77JVuOXUStVLVHz2IuWGIbDcrywFYdsICcW4soilS1hF9JD4bwqZ5sJVGA4XQK2RLd5kEzyWS2hGPJizCSQfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMrVeCfoGeTCSazUkkK/czO5DCp0IBrJ0ouSG+3ZqtM=;
 b=YYSnik5hrOPXsZiPyxjjx65LzyOKd0KxHs6A/Vg66x9zxW+lbz2Qzadth3TaMpz1L7Al0qjS37Mtm6T53Pq4xkumSN9M5zOUR2wcHWIjZiteEtOAdQSr25PrOMo3KouS63amaHngKqZ0e2jls8LMMk/vERYB8lL98wiMyWG0fTKyej+bEr+cB+6SzPBaoyJFCSK2P0m5RLAraumiWyqPIMHP0e66WjQb/tCfIKV9q6igIEdZqnqB9soEmjPfA8oLMmiPERfMr4s+WwloyVTT+1IRF0BbVNhF7DI/AfEZoPFa4kn0F0x1Pt7iLSOtNZFBdEPaOmOX9QhgNg/rC6bIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMrVeCfoGeTCSazUkkK/czO5DCp0IBrJ0ouSG+3ZqtM=;
 b=cVar68i53T+yMC0U/XcWUtbpghayTPzSYvUZWVxGVK17GlFA5bT74reVLcZQAlhd1t5SZ2Wp3zJFIpNoS+Yx79Ynmx6gwHStGkLWwt6+htI4CZl125l8DmmxxMIugSp2jMg0enkBen4s7IEnhvFxUaJK0R6jWcBL5/N3vmj96tc=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 15:20:22 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55%7]) with mapi id 15.20.3283.028; Fri, 28 Aug 2020
 15:20:22 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?iso-8859-2?Q?Bla=BE_Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Thread-Index: AQHWeD6ZmieVJ7ILtEmVT73DLNf2fqlNLX2AgAAXoACAAGapYA==
Date:   Fri, 28 Aug 2020 15:20:22 +0000
Message-ID: <DM6PR11MB3963228D43B50604AE4D0F3AF6520@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
In-Reply-To: <20200828090832.GB174928@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c5a30c3-7cf5-4903-075f-08d84b65e1cd
x-ms-traffictypediagnostic: DM6PR11MB4754:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB47547092C33802363E106E83F6520@DM6PR11MB4754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYoI7wZqTJCKQr2lg/U9ir7WMAhe+ByPjVieiYovycC/UheOlvRzLl9LGVO4BMhk63GF1uhho7tTw93V7Y/SX/GKRc8w4rf5DVgfS36/Uh+JrTe1OWZXFTVxNGT3TqWaQ/9crNKFYDnSA8+6DKQisgjLWtBKlw76DfuYgzYxAT9Rs84uvo6/oz9FCnqKC6fQB3VkjMpclE5aQSEd0xKM75GEC/cBR+4mG7Vpvp5VokCDfZr4Cf//jFgK1QvbCtTzTn1yoFXlde3uFEg6HYCU7XpfNl1CZ5kV96l9dX8TVx7IL1Zr2jcDLpwj7fSaFHF8ke66KZhkX2zMbLcoowLwow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(7696005)(83380400001)(5660300002)(52536014)(7416002)(6506007)(54906003)(110136005)(26005)(186003)(316002)(8676002)(66476007)(33656002)(9686003)(64756008)(66446008)(4326008)(66946007)(66556008)(55016002)(478600001)(76116006)(86362001)(8936002)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vC9tmnyQcPI06JJnbejlzsILwIii+dEicl9A/cnl0SQX2xn1DEklvatUnwlPQWKriMxGC2TDDccbZZk4fKjqv0wxwfZYlf+EfwtSbT/bHofy0HSEvz6qQM1joFgD6ENMgt/ix/gjgYjagzIU/mV1wi7HQKriUiLyLevVh3gshe0XWgWu0bqIsGysnA7NkFOYovu1xjQ1Gx50qh2j5iFMuflNIUkwxEhtAkptzV5K5A9qRh7NpR1fcGxu/CCs8RljpW1vxmChZZLjCT3B2p7jkm0+q4S0knNcRz4KEnM7gA4uK1ZMLI3pCIQvG3IphjMCbsQxVtG2IN6pmU8fGuTVJbbJ41hhfx8JU3+X7xhMwpPNtWwYW1qfrMDufqWgmYkeC5fDVN5plHAXKRKcHrgpNmm5PrtSgFj17Kih2wQAsEebbJzyl6WRoDR6n295+5ajKy7CZk49mthTFewjjhn73e34Ihggoua+FKTSnncmLl7XaC7dKOLCDWknVBHQE5RmAsTKkMNWWaTQZ46kiHjz3huLF5XSpA14YKMiZJDUuXJi0Sq3pXdTJ+OahyJ2UrkvXExFXV2/uW6F0y3tQfmsUdUYkC387mCqY+BbpUs6sTOIOR3apQIyIkqyurBpuR1klFLCOlL0qKxIVxfv4AnwOw==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5a30c3-7cf5-4903-075f-08d84b65e1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 15:20:22.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBWU2IK7Ep/zkL/dpdkxilABbN9RfNhTEY00KPbBrACsc76fktAN/P93Oalp0dwb13tv6XzN7otqsdn93gXZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
> (IOM) driver
>=20
> Hi Greg,
>=20
> On Fri, Aug 28, 2020 at 09:43:59AM +0200, Greg Kroah-Hartman wrote:
> > I still find this crazy that a whole separate driver is created just
> > to read a single 32bit value.
> >
> > Why not put this logic in the driver that wants to read that value?
> > That would be much simpler, smaller, and more obvious.
>=20
> That would mean that we start maintaining something like DMI quirk table =
in
> those drivers. Unfortunately the IOM device is not available on every pla=
tform.
> Also, even on platforms that do have it, there is no guarantee that the d=
evice is
> always going to be mapped to the same address.
>=20
> Nevertheless, I was originally hoping that we could hide the handling of =
IOM
> somehow in ACPI without the need for an actual device object, but it now
> turns out that the other features of the IOM chip have created interest. =
At
> least our i915 guys probable have some use for it (I don't know exactly w=
hat
> they are planning to use it for).
>=20
> So the fact that we may later need the device for something else, on top =
of the
> clumsiness and most importantly risks involved with using ACPI to take ca=
re of
> extra tasks (ASL tends to have bugs - bugs that may never ever get fixed)=
, I
> think the IOM device object, and the driver that binds to it, do have a v=
alid
> reason for existing.
>=20

Intel PMC USB mux device is part of the PCH, while IOM is part of the SoC.
This was another reason we had to have a separate ACPI device.

>=20
> thanks,
>=20
> --
> heikki
