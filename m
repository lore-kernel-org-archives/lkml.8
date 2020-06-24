Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403CB20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W/ox/Zoj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dK2l0s41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbgFXRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:08:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41319 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404209AbgFXRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593018494; x=1624554494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZdoE6HWHyiZS5pwDcu5Bc17Yeu68tY/gmcwI90LrXqc=;
  b=W/ox/Zojy75j7mkeq+hpI/lWSPsxK7NG9fQM3MAotxoHkP6Za2lhZ/Q2
   mhyFiYeqxrxxAfdEcVQBbeDlCqYIUmA8LBToj19PY0krTZcYrbP1KVmxi
   XXtXkIqs/PtxoeGySixwB7WmWeDxnQNPhh9ARidNaa4lWymraWPcxWdRU
   3KNZ7j1i0T8KUIArH3Cs9Y6sTsSLO8TEmSpvGJD1d0rFIMRVE6tua5bkL
   MFm0g9mfBweG1F+e7/xp1X0gKPl2VZKHque2HSWf5pBhk1qNsLYgySAAV
   wDOxO64maazpAgwhzLsOJ8KNlCOOPDhlaL5i4xuHXA1gfc6H1QcRp7ILZ
   w==;
IronPort-SDR: Oak6ppXbc/Do1BcjmbaM4QK62RB2d7OPfb//1eyyECHXeHoQC5s3zNN/vmlTY2NOLlS1jif4lW
 fnrwmdOaCrfOZ4rZ+7h/WRxPF5qEICQZ9/wyo4XsIOBcK2lMdh+6nM4CS8jGJ/R2TDL4ABpmIJ
 JcrabA4ri9Qa3Ws8g9e5PMc2pJ0hGW+SEqsJvWv/uHui39R0XVODOZn3ks4eEnCKcS8bhQ1GkZ
 cnSJCRAw4Qg0TEXL8gqZWc5eigh80zLMMN3B8gxgrgDyNBlMA/Cdj+umzBV2eYa7TfffuIwiSD
 4GE=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; 
   d="scan'208";a="250032999"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 01:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxreHGdIoR6Uyv5h7BrULZz9hsGktQ8loID7qxNBWl2vwlK7T8S+IjayFujmHXR6XH4dw3xl/SCkESQ1ALklp/MuFQZ0EA74JO3NNXWWpBKwZYbhDnv6agMCZs/2Uxn9+a3C1nHX6FsaRhLXlDjSWRfCnvcVj1j9wmChAoHOrnL+YFRUOMLd/EdwwOimuDlG2y+wGvf0VpcWiiNIWSOqAmMNJ2dW2XYzz2kItOJph0cYgOsdqPQ2kX7BxfXvIfI+GU8RSNm3XKdDfM722RnaOHL11g35w0yS2KXsNmS4nobRr/PqPotpqJNKVeO6Lm6IuKH5naPAVCi10U9SBb0YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac6lA1l6PPjvTZ5uUAjRXbh32bqh22we/OQArxrb7oo=;
 b=T7aedc0CwQPz2539jHHI1ch5ViyH0jMXDIDsC21mTBgiRNOCWP4Oo0N2zsmzPimOm+6qlIH9e4oqIZmZIFWAfobay6ry/+dyHHndQBFF3YEtARvo7PNz+buu/trf+RAOnjHoqA8ihe54rqf2JvGwtYo5oYiiXi4EJJxUtEuyQGwc019H68cC9b5e4pIMH3fMBi3CZEU+OUximHN/gnH7LMhrnq94IzuefXOBHGG/epKQmaa0ha2AFm79yvCjrhwA//rQnhZEq7mxrG0/0/qUKLTm7VT6pi38eX4gTIrZ16Uu88ZxVmbMkoFk6lMnzVgBcuZG6gFLnWneuw3+G/b5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac6lA1l6PPjvTZ5uUAjRXbh32bqh22we/OQArxrb7oo=;
 b=dK2l0s418eb1wXGzZ1UZ+UnzwpQp81IS0PICm4VuEBuIai4gJlX+jvhyHsXRa+VUuUIV++frIiMUC0KtJ7HbLniigSvJ+CUVHVKgDrYHKH/2yegQo12RHlJ+vOnZk6ljEAgTpw1PP0EDNZ8z6MPjR6J9Vh8wPMTvlcYIavq0/GQ=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB3976.namprd04.prod.outlook.com (2603:10b6:a02:b0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 17:08:13 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 17:08:12 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Topic: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Index: AQHWRatsK9pqpN/HlEmT0NtnEgioaqjoAiyAgAADqACAAAE8gIAAAa2A
Date:   Wed, 24 Jun 2020 17:08:12 +0000
Message-ID: <20200624170811.GA396203@localhost.localdomain>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
 <20200624165746.GA394355@localhost.localdomain>
 <20200624170211.GA25230@lst.de>
In-Reply-To: <20200624170211.GA25230@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4d48fc2-081f-4b4e-87d8-08d818612da4
x-ms-traffictypediagnostic: BYAPR04MB3976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3976A974C8AB2A801EB62B0FF2950@BYAPR04MB3976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV/vTjMx0J06/LRMlkXCQCAD3jtY3ufsUjD8AfsPykMejXwv+x7iEk+j9p9fy8WEDbhM6+9nBTanCXgJrg3AWv5jIiuSN40s+1UF2karz/YjYDGL2lS3SqIERa+saqMJRExf8/ffbaiZzJhNrh4cOaDSzkfRhRtrLdVx6+5uvo8wSEbTaVLjaRc/mH4AP6pP7KnqetvJ72c7Lh9ZB729XsmUHmF74BLLRqsd6/u7KqBY2NtTVRB9JvlahXW0Vwe5pKN6ugDvse0gPGxWPgjW98t1JtImNGF+ZqA6txX/GjGoGJOVAFSN5SDa46DzSZSGu1JtvF2BPyVp0vv+qpALkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(316002)(26005)(4326008)(54906003)(1076003)(186003)(6486002)(2906002)(478600001)(66946007)(66556008)(76116006)(91956017)(64756008)(66476007)(9686003)(66446008)(6506007)(6916009)(6512007)(71200400001)(86362001)(33656002)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M1/fkUo3TCjronDEg9z4dWqpRb7lgIMsszBHeSgR3+/94XtBoZAESO7sdJiK2Zo6HL2S1yd9YoNHSJyFQEck4w2qssoVscfkOnX2Ef4x73WuYv/g9FJIaMg7vlaerXENCug6SvLU0u1y+tlmftSPUXDsTovU6S0/uBOGXWhwTf8jHclvrbOXz/FH3Ehkj0JdJdne2NJri4NII+JCzhuh6XLirVcX9GdtZb6soOAiSBSZS8hgcvujXQPs3Rr9githAQIGICm5dmm4ID79RT6Rw1vPiqdsZnoxbLMVbQGBMY3idpsHxFjFgGCB7ubIPhxRzr+Ww3EnpEiAFMTXBKpVceGlIIen/sMoJbnHENpOAaCY6mQYncH2lff/kE60cGIwPTKSuOuYKHPcYFCaUbpKwadCNdhl8edsIBng7O0dvV3MGw9pcv6q3ijIBuWQI+0ff+b3vE9bHuKG9Sr4PAUsbUd0HCh12MndE1GrYu8A8aXQfMXawDsB1TOrR91/uK7L
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2A3B0F50ADC18448F8995778D7268AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d48fc2-081f-4b4e-87d8-08d818612da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 17:08:12.7897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vExUhjQGYgqJcisu60sEuBgkmjNzGnSnH+P2IpClEs9Qbwy7WNbD4Y9QemQfprnCZ5e4Coqplg1cgVWSszLB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:02:11PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 04:57:48PM +0000, Niklas Cassel wrote:
> > On Wed, Jun 24, 2020 at 06:44:41PM +0200, Christoph Hellwig wrote:
> > > This looks good to me, but I'd rather wait a few releases to
> > > avoid too mush backporting pain.
> >=20
> > Chaitanya made me realize that about half of the nvme functions
> > are using "struct nvme_command c" on the stack, and then memsets
> > it, and half of the nvme functions are using an initializer.
> >=20
> > IMHO, using an initializer is more clear.
> >=20
> > memset has to be used if the function needs to reset an
> > existing struct, but in none of the functions that I've seen,
> > are we given an existing nvme_command that we need to reset.
> > All the functions that I've seen declares a new nvme_command
> > on the stack (so an initializer makes more sense).
> >=20
> > What do you think about me unifying this later on?
>=20
> I like the initializers a lot.  But as I said I'd rather wait a
> bit for now.

Just to be clear:
Even with these patches, about half of the nvme functions are using
memset rather than initializers.

But sure, I'll wait a couple of releases, and then rebase this,
and additionally convert the "struct nvme_command c" memset users
to use initializers.


Kind regards,
Niklas=
