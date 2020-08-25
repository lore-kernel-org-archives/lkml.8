Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F521C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5013720738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="REWL4rEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgHYBDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:03:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:14476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYBDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:03:32 -0400
IronPort-SDR: JG9/8bjb6MfaaH1mZOJLVGdzLNfx3VnRsyOvTJE+AKPDBFpiRsPvXU+4CaA6JShLvZo86XzXOi
 sdytBshf89Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136078111"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136078111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 18:03:30 -0700
IronPort-SDR: Qq3XE6ocTlm6w6Obz/wGP8C1RedPi3rtpyzieI9Q4rMRbg0I5meuyDbMzgyBEpAab+X+1aScAf
 2Mzg02/7D8Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="328687123"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com) ([10.22.229.85])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2020 18:03:28 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 18:03:28 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 18:03:28 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Aug 2020 18:03:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Aug 2020 18:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnJTWjpY0P5SqDYtlLsZTOSPIkicx7zzcSWH5221mCJ0PtgnU27pHM6uMbJcVeqCY+WcC2PYQmzW914Nm4u//WlAF2fe3fg05MUQ6JDbdaIriGPNYZlVKcV12zw0FgrP04AlRYRpTiw9PZ4X1jXONwRiMPxsQcN/o9mhumBPea8E+/O3w0JHYGQ6IUrAemK3K79/ws17k+7yut7fnrPcL3JQuOQNY0xvL5vgK8ZrvAjbtyDfCxymwOptVyjMQXJuRHiNj41LA3XWVhZn0FFVlQ08kIgt4wyMQpcdbUMSPcp48Ap1T5hxOXP35P+UCg9Th1eX4w/sjyH5Qg2yJbfSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8iPiY9I2nB4gNgJD1HBQuGDuhppPhIZ4Zo49YfBVls=;
 b=AoyXFxmhqluUHWPQ4vCK4GDyErMvbddCbQuWZoeXkWOax/4qFr6v4Q6qdf1x9BgqnF0pcMwF3HAoI+wxRM/hIAJe/jEvwjlXrVCzRlnA4kmtitASpX1YE64vRLun4GEcVqtQ4885tmksaHI5mbItnfjHNY59bkFCUXVtonw5+qyP6Qsn3v7BmoC7Bwi57Q4Z48oEN90BNiXJMVnnjsBVGp62qYQKB/LhJ1MR73kOitp78fa9he+kuSHd1CRDgdiYqktZmm7OAeXIgjhn+AFJtOLWShNEbb72+nvwFLAqxxrsJcSyfrbXWFkxKRvN8Q8p50/li1KFIVG+zMZxhmf6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8iPiY9I2nB4gNgJD1HBQuGDuhppPhIZ4Zo49YfBVls=;
 b=REWL4rEnA5quazmUbGgbJ3LjLVnqtGDzeGMyk/bTEz7G51poUjQTJdY2gk7Fu2ji2QLZi6Uvq6Ai6QLUzjbLfTvxjb/WC0r+ZPkCeXzBMOFMhxMRa6UhVcrP04hl+S7gDKVBoVacU6nQXmSnvxBRdQKDofpdIWO000tzlBA0fDY=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB3849.namprd11.prod.outlook.com (2603:10b6:5:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 01:03:25 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::5ca6:6956:d7f6:2c55%7]) with mapi id 15.20.3283.028; Tue, 25 Aug 2020
 01:03:25 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Thread-Topic: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Thread-Index: AQHWeD6ZmieVJ7ILtEmVT73DLNf2fqlD5IiAgAPw3+CAAAsvAIAAJTKg
Date:   Tue, 25 Aug 2020 01:03:25 +0000
Message-ID: <DM6PR11MB3963032D3549E865BE1F4CADF6570@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200822095631.GB2553024@google.com>
 <DM6PR11MB3963121C820F570F845BBAEEF6560@DM6PR11MB3963.namprd11.prod.outlook.com>
 <20200824224726.GA48297@google.com>
In-Reply-To: <20200824224726.GA48297@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1a3992-81df-497e-32bc-08d84892abd7
x-ms-traffictypediagnostic: DM6PR11MB3849:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3849D515F68364BF78AD89C0F6570@DM6PR11MB3849.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gBCDpfZlUOsEEd0ESqPxAJbThnw4S0xbmatwoJtJECflf+h17CEtGI2tvAqUWWRXxC1vN68LXJHpUDgNj1U9MX2WH1LMIP5b5ZMleItZT5rauOmD+dObPj83Zd6qOwSVZx8jjK2u52Bo+7r2hd8xr7fKGoYNcvxGYUkxLA8cUvAQFRGo8/mFMFrbSVLLN8cqlTZQ+6+G13ysr2pUDaW2YeVrdF9hPJ0EOsH6u0CIaZF0xGkSoZXC9r7NLuv9jeSdSjGAEDN3HUdNfV++pwe9r7wepA2nJ2Ufzygk6+u6RztHjd51ETrsjEiRQnZTAxWnP2uPj4K3NZBpyp9HrLQE0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(186003)(6506007)(4326008)(316002)(54906003)(9686003)(83380400001)(71200400001)(52536014)(86362001)(7696005)(33656002)(55016002)(2906002)(6916009)(478600001)(5660300002)(7416002)(66446008)(8676002)(66946007)(76116006)(66556008)(64756008)(8936002)(26005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CW+HB6NN4weLCrRRO/Cst9o3W0LyW0cKPfNeSUubM5ZmzgdFtFEwnfa0aiL6qblrzZiqE/TeM7XOI+186Vj5j5mdM2XGP9/ehXz9/XnBZIQITsXQDD73Z80X1ca4C9P+HynccEOa0H41+GLZzLtAxfwG5tES1J9//IKPOMakLTtQUXZcefy0bKfbviUTleYTTI/w8v3wIhecsiM1nHHdbd/aLt56ksCYhOXdlCW2lMyWKKrKWZlp7Bw4FkP4Rb+TMi2lI2bfvt+6qKw1LkjsyA2bdrQjbS2/TCRE/IPLZ+7k2Al25w8qW/O1tQKE07UU4DkMxVUlDbIwI5krz/JA7noSUPvg+7H86ZPbTAECpYsdbzyPoi1FksHzoXqHyRXSc8Z8gQXFelOIzuzL2eWbTLBtU2H3P5W/u+uPWR2KECU81RuR0hQZS/9XEglLPtclRlRf2RnAJ6+yjFvPlZ+LhMK5kUC7f9YAGMkJsAD9ZTaLXfNp7wEFhqp3NrFF4AJXSRhfijpIfkVxK0PkoieH9SAS3ofmXSnAu7slTflu7dKTWP5rM5IE8fTGOo0OtnSDukaF0Bu8e9o/tsdLYbdUvVDf6qELCfBNVvoBrlUQHL4a9DDxie1UrazU6PueibcWCwTGvveKfpr/DjFMW4208A==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1a3992-81df-497e-32bc-08d84892abd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 01:03:25.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2OLuBDHLTj4Nd9fwUvjkx8BfzUJMZoQzdpaB8Nt58f5qXUShgEOoQI590DnbfR4NlYMv3m/fxD8uwxHi8+qtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3849
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

...

> > > > +
> > > > +	reg =3D iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN *
> > > port;
> > > > +
> > > > +	*status =3D ioread32(reg);
> > >
> > > Perhaps just inline reg within the parentheses?
> >
> > Kept this way to increase readability. Let me know if you feel
> > strongly towards inline reg.
>=20
> I'd rather this be inlined, you save a couple lines from the variable dec=
laration,
> and IMO we're not gaining much in terms of readability by declaring this
> separately.
>=20

Ack
(at least to me, it was more readable)

...

> >
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(intel_iom_port_status);
> > > > +
> > > > +static int intel_iom_probe(struct platform_device *pdev) {
> > > > +	void __iomem *addr;
> > > > +
> > > > +	/* only one IOM device is supported */
> > >
> > > Minor nit: s/only/Only
> >
> > And then I may need to end the comment with a period.
> > Let me know if you feel strongly.
> Yes, let's capitalize and add the period. Let's try to use the right punc=
tuation
> where possible.
>=20

Ack
Will take care of this as part of v3.
