Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB07C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3655021734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tojCVxPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAUIHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:07:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:5838 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUIHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:07:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 00:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,345,1574150400"; 
   d="scan'208";a="250177203"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jan 2020 00:06:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jan 2020 00:06:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Jan 2020 00:06:24 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 00:06:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jan 2020 00:06:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZvNjjlkq+KeC5APVx9japSCmA+bhAUmMf2t3UaSKDc0R3gZgHm/ySgGGAAkmewnpdtihPE9AdKda2xyj0aXJPv9lKcvaMzZ7hDWIrOuKIHsMpOX4TtQ1GBLnEqkSw+ottqHaPAQ5crruQlrYsbfCHTvLUsygqB1gplKb3QaWw9EibLaukhvwD+Ro+Q7Z+STFFrXy7Z9Q5Y750qQYN+N0fQq5qsgvAcrtwiMWOZbRZg1M+nRHLNoHVEt1+g1HAjQw170draZZKqqytblrwiMim1IMLSGWd6iDFcpJA91P8J9iEQZSw0cJFVbs56ilMa+8ZNzaZj/Q/Al9vLkyFyVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPA67Ba1N/zlyuiXylXnmsZzxUH+TDd+kCyIebf0VLg=;
 b=JDI1eLCMBRbVm2C4VG96y5/sGZnfittgzE+qrCs26uZtqE0sr2RM4/ZlSJS5JYAJHTgJmT6PpRAk4xrPU1GXxHekM+JHtp3X7t3UoKONPNNYM1arrrCh7mE/VhTuCau8JKLM399VqAtzn4rniQm6LRtF4+U+KaXVKP3C7hiAO6spSv94f5jpLNjts9bOrV+MvpwDjAoD8469guIIITvGpj+m3Enl9PKZZhjjEBz91A0GjIqL9XgiFEto4NN+b/phNU286ZSVq0CUaKRDwAdO7me2amXiwNvltmHXOqoIydS1Q+sr36sEbbxGN531Mz7UIezAxhEUXolg70dJLqjUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPA67Ba1N/zlyuiXylXnmsZzxUH+TDd+kCyIebf0VLg=;
 b=tojCVxPsDhZkGIGFVEd6IrL08oOSH/rIUKrucPZjx8aKK7Bb9Yhln7y5PxgdPvzLaQLR4V1EA0BfKJYMycPtiR5AyIKtfImZNpEEWAf+wx7FssADeMR94qwbLCsAMM6JCFH5N/4A9cjeb+sjHJY1R57ekua6Fl5U114tafsfXg0=
Received: from BL0PR11MB2898.namprd11.prod.outlook.com (20.177.146.211) by
 BL0PR11MB3409.namprd11.prod.outlook.com (20.177.206.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 08:06:23 +0000
Received: from BL0PR11MB2898.namprd11.prod.outlook.com
 ([fe80::806e:e80a:edd9:ec51]) by BL0PR11MB2898.namprd11.prod.outlook.com
 ([fe80::806e:e80a:edd9:ec51%7]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 08:06:23 +0000
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     "Loh, Tien Hock" <tien.hock.loh@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Topic: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Thread-Index: AQHVwleyiG3Rz6znwEyi6iEOYBxM06fiIPYAgBK8nOA=
Date:   Tue, 21 Jan 2020 08:06:23 +0000
Message-ID: <BL0PR11MB289899043DC031AE4DB21AA8F20D0@BL0PR11MB2898.namprd11.prod.outlook.com>
References: <20200103170155.100743-1-joyce.ooi@intel.com>
 <SN6PR11MB2750CD8233FF8F14B006B343BD390@SN6PR11MB2750.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB2750CD8233FF8F14B006B343BD390@SN6PR11MB2750.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joyce.ooi@intel.com; 
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9692525e-204d-42a6-d9c0-08d79e48ce84
x-ms-traffictypediagnostic: BL0PR11MB3409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3409715912B3E067A44BDB28F20D0@BL0PR11MB3409.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(66946007)(86362001)(54906003)(76116006)(55016002)(8936002)(186003)(71200400001)(66556008)(66476007)(8676002)(9686003)(81156014)(64756008)(66446008)(81166006)(110136005)(4326008)(107886003)(33656002)(53546011)(6506007)(7696005)(26005)(2906002)(5660300002)(52536014)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3409;H:BL0PR11MB2898.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNwzZenMWLPFv3IfWnD238X0kQivjpRiC6VlWsfChssaAkUPbyCiUtFflPFg1OGIYhVvkZLIB4IQ8eTsBTSlmkqIBHogmHhnc9znixqVndXgjnlCVVDKZnyWKyqeZMn9pKr+aERGD4UJngs0GXBlpjXvf0t7sEoZepsr1h0xot13/EnXz91cJI/gX1Xcu5OyjJBtxYW4sTSRxQmVCiPPU924aD8EuuKQazkVKBFwC6wz+FrZYTR7IQyXQsMWrM2oqYtwh/HKjcbtpye25AoANOz8VaRRckFaZv7NE5E2xALTNp6pRn8FdweLW0Vwi9Pate1ikE0gsYm8WVhCyBKx7dEO3ho4RAKzje+TpfGZ7VHaHYod7sTSe1urAsWeHXs20nb2O8t50t1al8pNpt0vlVihkZ/cRBLSZfBdfy/qvli1upKkAJe6HN8Vv9/8gEKv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9692525e-204d-42a6-d9c0-08d79e48ce84
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 08:06:23.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N72aKU8uqFtgwPtNMbegn/Aj1MyjFnj92NCuJyYx85McBankVT6EIs05lm4R+1lHRq1B1KQxzwkeSHffa3HQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3409
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Can you please add my name to the maintainer list if there is no concern? T=
hanks.

Regards,
Joyce Ooi

-----Original Message-----
From: Loh, Tien Hock <tien.hock.loh@intel.com>=20
Sent: Thursday, January 9, 2020 5:55 PM
To: Ooi, Joyce <joyce.ooi@intel.com>; Mauro Carvalho Chehab <mchehab+samsun=
g@kernel.org>; David S . Miller <davem@davemloft.net>; Rob Herring <robh@ke=
rnel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Camero=
n <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org; See, Chin Liang <chin.liang.see@intel.com=
>; Tan, Ley Foon <ley.foon.tan@intel.com>; Ooi
Subject: RE: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO maint=
ainer

> -----Original Message-----
> From: Ooi, Joyce <joyce.ooi@intel.com>
> Sent: Saturday, January 4, 2020 1:02 AM
> To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>; David S .
> Miller <davem@davemloft.net>; Rob Herring <robh@kernel.org>; Greg=20
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron=20
> <Jonathan.Cameron@huawei.com>
> Cc: linux-kernel@vger.kernel.org; Ooi, Joyce <joyce.ooi@intel.com>;=20
> Loh, Tien Hock <tien.hock.loh@intel.com>; See, Chin Liang=20
> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>;=20
> Ooi
> Subject: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO=20
> maintainer
>=20
> This patch is to replace Tien Hock Loh as Altera PIO maintainer as he=20
> has moved to a different role.

Thanks Joyce!

Acked-by: Tien Hock Loh<tien.hock.loh@intel.com>

>=20
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  MAINTAINERS |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS index a049abc..3401c4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -726,7 +726,7 @@ S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c
>=20
>  ALTERA PIO DRIVER
> -M:	Tien Hock Loh <thloh@altera.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-altera.c
> --
> 1.7.1

