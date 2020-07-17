Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C0C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB20206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="VOXMigaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGQGE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:04:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:31252 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:04:55 -0400
IronPort-SDR: wFFz0evBO6yM67AzOL4ePBuvB+ZcEbWpZENOPqltrhInv4g78ZxCYx4iFOyKa8laqjnB1oKrdt
 b40S48TBfVIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137659780"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="137659780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:04:55 -0700
IronPort-SDR: reqtBt/W6KCf0h6XssoCO9cwvQ/D+wsyefQU6jnK4/xq66pMM2i9UT0MVem8nbR7+tfmDGEc6R
 taFacEfdu7gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="326754417"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 23:04:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jul 2020 23:04:54 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jul 2020 23:04:54 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 23:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxNpFxC67AiHA1jG8KT8dXeha1gv+HP6963ajl5qwnRmCcPj50K1Mm5P42Yw4/yH+2/SsT/usZ6uj8jypciOjdLM36lcNLYmBMGx+wQpy7L2nkRswEZz7lTdkaq1BoxiTYbNSMxYlu2sSsGlv4SZKv3mos97+8TcIZGZAVFUit4DVEaMNrrrj45oKppliccnaO3seYqjBn4hgUorzMhS2crHltx/nPDxjXe3vuNAZ1qb+O/MH69EEtUHI7ogzu+pWK93dox01XxPM9Wr2k0L5ld/nzd9LBExr5fsRZuLmR6qdQAnsez62yEnK4QvLn52KwXXbybbrpDncw2mRB2oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMHNzplyluR7erOe/Xo3k+sKFXmiKAxAUOWBWyGePYA=;
 b=oLFlT1G/+fJYnh+dR8TncCCfWHpfNakjGmCWm3tVBphfb263kEdLQJa+npz29zLiAnfBXNFbGun82PEvDOuBvufF5+NbN/3scClPOpZycvsdFGmekjD9fYGyCYihEZgn/GQL8f3KVYaUrMhErIbsCA+5AdIc7J5GtAu8n6yvOJp+Nn2tn1pVBeXzKRk7HhIouAfbfIe+aoZmkHEsFeBeh4OxgnonfF4Z+NpKUQZQA/avlAD63l3I4SiH0ix19q/b414rMQqdKJo4zXW8kgIllD3ixjdyAfXMmTbwr38fAZl2aG3rBFse+pHGKEryGS4itx6R7New2ZS4Y1hOBU/+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMHNzplyluR7erOe/Xo3k+sKFXmiKAxAUOWBWyGePYA=;
 b=VOXMigaCOq8VudFK6akHCgdKoOun5wsJB+yUVSaARpIzn7KziBi45QOqmeSpIBHdY+tNDCBKlnT3m/EJeMZtCsD2W/xe1VeNMayVHKZ/bm1lVwMJcftcsBwyy+PcW0sOfeULZB21tggrOuRWPb30foBBNoIEUS/gmQBtCsP7TjQ=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3962.namprd11.prod.outlook.com (2603:10b6:5:192::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 06:04:51 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::714f:fa64:4fd8:c9df%6]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 06:04:51 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
 before connect
Thread-Topic: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
 before connect
Thread-Index: AQHWWz+GMlKLLCj8UEiQgrY2PIsTTakLSa1A
Date:   Fri, 17 Jul 2020 06:04:51 +0000
Message-ID: <DM6PR11MB39632A8236161E4A27FAB1BBF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-3-rajmohan.mani@intel.com>
 <20200716070508.GB962748@kroah.com>
In-Reply-To: <20200716070508.GB962748@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214d073f-cca6-48a4-a05d-08d82a1751d2
x-ms-traffictypediagnostic: DM6PR11MB3962:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39622A5AA3F536B5713079E3F67C0@DM6PR11MB3962.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrg3PliTp110rCbWevOZUIOZNr8olP2cT4c+6WZ7X3GMbBhroam80ODy9Z+ovloz5V+mkBVjbJFhm31fP5NAcmS8q0Kdu9vSublTrlLGP6LtWsh5QCaUWJPuLUS8cLHTscvmD2CbnCqUK5/+lFmBHW+G/jZjW/cAmbYKduwk9XdWwkkmDX9ECYwIqmr5YwpCxkgwi1IJHMXlnPwyu189NPtAC9966fJy8PXM+Tea1vGcS11Wf3/sXui/nG3zPP5atI+4xVvj5W4rJpd5UnoFyx5gbvNCOnq3uLBtR4Fkc9odlmian3RnOQp4xsqTN2eqopKe7QO1/adnBrZlGqbr2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(6916009)(316002)(86362001)(26005)(8936002)(4326008)(186003)(9686003)(7696005)(76116006)(5660300002)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(71200400001)(8676002)(6506007)(53546011)(83380400001)(478600001)(7416002)(2906002)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NPaoru+nGph+d7/h3vu+fPXwg3DSP4mJNV5gQJxcWHEMXzkm2Sjsyx9RDDWXFJzWNtbfY6TfgVFv5Q/5Jx4qL5m+5dgAwEDN/9lJ6bzCSctdfF7u2WOsluXI2cWQn934E8Kn4KVDMM98eSaaiyZGgx5fgGFXZyGpA4U1E5LYp5ComP/ui/Sv5uamGXWTYKo+ZVoo7bVfwOROoXsAWLIpGYLaJbA/ZeQzxzoaLiJw+6rWy+E+/Zf6riJWbD6pySyRP0ukYsn/tcp4WLpYYEFBQDjHnyJBNds/NqFr1LU7eQLvCGvsTs2S2Crf5ED75+KtAe9ZkitRlq+9wbWD/zOyMDPH2zr/STwD/MZKR/bTKz6rk4UtJDRw5bASgD6vuLTaAKFwEKMlI2IrQxQq7pPU85VzMv/fXwQpMKI8wagaluezPKQPNrdfj0taNPrtDVoMeTZeHbHCuoBgZ6E5FBuTM+YpvEHENjhyhb/fY+YvaMuiJOfNQA3VAaQimI1I8pcZ
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214d073f-cca6-48a4-a05d-08d82a1751d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 06:04:51.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxEjoXIO2rXfcPYj5vS9nkCTpXa1PyZvTIWzhX7Jdt2Qg0E3pd64ZIH6Ymcq4dcug2RXHZg45f9IItwEUs8tXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3962
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, July 16, 2020 12:05 AM
> To: Mani, Rajmohan <rajmohan.mani@intel.com>
> Cc: Darren Hart <dvhart@infradead.org>; Andy Shevchenko
> <andy@infradead.org>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Dmitry Torokhov
> <dmitry.torokhov@gmail.com>; Lee Jones <lee.jones@linaro.org>; Ayman
> Bagabas <ayman.bagabas@gmail.com>; Masahiro Yamada
> <masahiroy@kernel.org>; Joseph, Jithu <jithu.joseph@intel.com>; Bla=BE
> Hrastnik <blaz@mxxn.io>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; linux-kernel@vger.kernel.org;
> platform-driver-x86@vger.kernel.org; Heikki Krogerus
> <heikki.krogerus@linux.intel.com>; linux-usb@vger.kernel.org;
> pmalani@chromium.org; bleung@chromium.org
> Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status
> before connect
>=20
> On Wed, Jul 15, 2020 at 05:33:10PM -0700, Rajmohan Mani wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > The PMC microcontroller that we use for configuration, does not supply
> > any status information back. For port status we need to talk to
> > another controller on the board called IOM (I/O manager).
> >
> > By checking the port status before configuring the muxes, we can make
> > sure that we do not reconfigure the port after bootup when the system
> > firmware (for example BIOS) has already configured it.
> >
> > Using the status information also to check if DisplayPort HPD is still
> > asserted when the cable plug is disconnected, and clearing it if it
> > is.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> You can't just forward on patches from others without also adding your
> signed-off-by to them, right?
>=20

Sorry I missed this.

> Please fix up this series and try again.
>=20

Ack. Will fix this with v2.

> thanks,
>=20
> greg k-h
