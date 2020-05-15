Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E34C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29044206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GQvZqy8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEOJEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:04:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:38987 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgEOJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:04:20 -0400
IronPort-SDR: GXoHkHOVhPWiUHz3IUbel4dJ2kTEj3bq5EdzMEuK1RQq1x6cI63a/zZ6wwmhLISax093/dFL5Z
 7B6NP8nIBViA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 02:04:19 -0700
IronPort-SDR: hw+VkVLSLvdZQgGESOPoKUGJv75CpxPGvD5VuOslWubbJtBLW3O3cJmCFs9M6cVQBCa+f8jguu
 iuc43tkVKGWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="298988274"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2020 02:04:19 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 15 May 2020 02:04:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 15 May 2020 02:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzAF20dz7UO6f5/DNuiFtccYrGSw/aQTTReMq7Xh24L96ZcmygXCLYiH1DJfDzSlB0z5McMkscCNlsDAPIJ90ErAZIouhMfziP+w1Zozc0rrndtUon3PjW5Krrs1fLYKNeqZzqP0PL/+RUo0opax4pFIXfLT/vSJrf7HdFhLzsCpX7kGgfTtWxi34msdGfOSAuzupLi2JwTOXMgIRE3zFzKnPjdTKGk59nC80DWrwOgk9ONcDnVE6BpXCHhBFYdOLPDkybCX9YrwzFt24NglvcYF7xAw8gr4P71gHf+62hJgn+a5B3cugcShz8AwmsNsE17TZXvn1QDqMhO4w0m+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpuJvxfv+NSIo94nyxT1yubNZXdBU1F3cVYdBKZUBcI=;
 b=FOcttRjemKkf6PdrUYG4VRbjF0Kxm+PYjXCcDaCahtJb875k5j6cnVX58c/0DI5VW61JSe/5TfxcOZMmVgnCl3/8YoWi6myWTzmvfXl77oqi246hdoZWqt1ZokcqNfvT7UXJgcx1X1ov1Y2t2maYsuOj033ahLk5SiLunzfRsfHC8xNuS6RFgnsjQgsaGZIOCI6HGCTbv+9uq4mAh64FgwlskWx2oA6XCzu1OeBFAFtrWlifGIhlm79RfFOTn/qVkv9NWzRYx5XBMkmATM3qgkGlFLVOAURSbS9Gg+RBgRYPRSDfcN4UUWtSxsGz+4b/5l93OnbLJxA5386RVO4vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpuJvxfv+NSIo94nyxT1yubNZXdBU1F3cVYdBKZUBcI=;
 b=GQvZqy8SdKMbDzV+mWzGxoF70VL/2gmxwXjCOcHtgFV5ItXyJnONxFK4bwNYMj0r84I8zjnzbJlW1IP+TVmUSc32EQQX58YwR0qt9ei1pCqfAtM9BDISy3VilfKJ53jwmMoL40uoX7o/zuaLWdJOI4Wq7hZAZdyftX4fZv8TWq0=
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 (2603:10b6:405:5b::22) by BN6PR1101MB2147.namprd11.prod.outlook.com
 (2603:10b6:405:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Fri, 15 May
 2020 09:04:16 +0000
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::5419:a938:2a3:ee27]) by BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::5419:a938:2a3:ee27%5]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 09:04:16 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulhsia <paulhsia@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Thread-Topic: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Thread-Index: AQHWKm+bGJ7M/VYc4UytQzlLp6XFraiouVwAgAAfc8A=
Date:   Fri, 15 May 2020 09:04:15 +0000
Message-ID: <BN6PR1101MB21327687327440F1DB7CB75F97BD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
 <20200515070446.GA1226131@kroah.com>
In-Reply-To: <20200515070446.GA1226131@kroah.com>
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
x-originating-ip: [1.164.110.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f696e1-0b2b-410d-6009-08d7f8aef1dd
x-ms-traffictypediagnostic: BN6PR1101MB2147:
x-microsoft-antispam-prvs: <BN6PR1101MB21470077622AA0E883BC6AB797BD0@BN6PR1101MB2147.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXjkSIwLrf/voKi/IJ3r+yLd8Fn1aZ+i9adETni5KeiI9D0xCRIAf6l64ASbFeTLgOP9VhdnM2CGaT6bEfJjXNoEIeZz8er1Q5oSPQWcz+ubCBj1BWXqOHhoq6TljFxA9WlSmY9eAG9RcFsUQyMQ5BEQ7/hJPxwn+j9Q7tBV++Qt0qjv/K0LugmEZUwt+zBlTQv+eYW1IkU5LrRjsPXwMfBxWpFdYLm3RHMUgMh26kXACK45e+CkV6oSfjzCu2FVLnGgVO2RR526qFK9H3u3PTbwV4mHzcSEwiPTjOM46wUGGjIAw7qNOdGsm12wa0fn31ITRgXSyh8yOVIybBFLVjbZEXwZ62zfszjzApaQNK8dkQY9ugMlvOFofs3WcCtijLK1BVIyAPs7Pr3zb3pzaX2p5o1lOhRWw8L34b9WjXny52RsH96KSN8x3E1utGT1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(55016002)(8936002)(2906002)(5660300002)(66446008)(9686003)(64756008)(33656002)(66556008)(26005)(7696005)(6506007)(8676002)(186003)(6916009)(4326008)(54906003)(7416002)(52536014)(86362001)(478600001)(66946007)(76116006)(316002)(71200400001)(4744005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bg8FhlfOu2UPD/y9ho7y6eewyP40nU60o1z7uYVdSwZbHMCEJGoKRPV4tdE5Vyo4yaJ1vxyXIP/JapXS356LH7PZrca52BNHwCbBID+QJyoQqmLw84NhVPZ59eRqQpn4WOReI7NYiaOP/SO1olC3rimgqgifgU7RY99hioIGa9T1XlXULZMjWCYivA+jZyMEoVazunPZa3aS4cqlTi9tvqS1fjLEaXEngUR3d53XjQYLsUY/L1vXyjYxyFg5KdGxQdKSHtnF3Ru2x/pgIv7kx6LdPne9HCkTgoPrdNYm1hekqBIxe1MZOzOe0rY+nfbOTHrKGw9cMd6OFI7UdBqOkKs5MfJ29iBHfxWHj+c1zqdntM9u1+v6DIimfmpDRwxCfsxwYFvV0B2akTkvIDOkGJV1PQnw1X+/P6Skk3pPcNDryzz33TPSihmjyQTifIW/vusa+fvqNeazK+7I9w2SE5chxeYKIhPd39XUUs/ccDk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f696e1-0b2b-410d-6009-08d7f8aef1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 09:04:16.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kU9Fk+jMguDL7aR0SRVu5UJVuK1HLGRZdLhZtwgTfjCQhZ2w8fW1uda1feyxQUTSzZ4Ei7FanMyvrCDcn/Z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2147
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Is this a bugfix needed for older kernels as well?  When did this issue s=
how
> up?
>=20
> thanks,
>=20
> greg k-h

It happens when DMA stop moving data from host to DSP/DAI for a long time
(> half of buffer time). I know host driver should do something about it. B=
ut if
not, the HWSYNC will keep increasing the hw_base and hw_ptr and confuses
user space program.

Regards,
Brent
