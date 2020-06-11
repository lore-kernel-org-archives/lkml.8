Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544D32078C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ndtqhdQh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0INJPNLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFKXdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:33:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44096 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFKXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591918412; x=1623454412;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ELfqY4hnmjr+SvS+tYQT8h+HpDv9abZiR5P/5Pv/M+E=;
  b=ndtqhdQhT3/AjPv+y1KM52lUiR27JF6dbHMUeuNCY2Wd82NS+E3kNUfx
   kSQAVAISnxooXnqzy0obFTF/I/4+OfYfeejCX5BLL5iUwjTsbQA9UA2pu
   3yuAklQ55FyAkOKnWY3R2ynWvP7fkaOkXUM+KXrMfbKvJS4/a2SFZ9U8F
   fpyVHqS3Ifxl9NBfw5dzUvvosX5LsO76oGZpBHZ6dUeGtESWEd/oL7m2d
   +UYl0UrsS7BsRpdhdGoYVevm+IDZxp9xSu5sY4B9mMIOHW50lA32I7D2d
   kNwgJcjTOAE/SKW90uFb57rACb//UQ2QY1wsGvGaKeHaDAe9Fh3nVb4hN
   Q==;
IronPort-SDR: W44qlwtVCeXiYIQF2jnrAqhUCUbUvirenKMIZ0fo5WCquJwAbn2AGePXznajYO/AOl86BXVgQx
 pcMEnehQvrBS2yqk/MoyD4fH4i6v+6dlBx2x4LbGW3UgnCZ34mIEbegk9X9UavAWCt8eRmyNoA
 89o8Ltn/br7Yla7Vv92ODPO6doCFf73exsBqRxmFuwRgXrxo1RENWunZUluK4xnPKrVtb1iF4X
 hZU19TD5OGtMpJpLA07ynATWbrqEZB6QF9LL6htAnlRtvoShZxgKKiP5gL82ONPCj4/jrB4QSj
 09s=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="242703797"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:33:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTQZtGznsGLQOFaGYeiQ6zFiloyHqRET0cj2NzRPCTx2YmORMIej0kbn9hshr6nHghbuikdtP59cbwnqY0YNRlrihnSyph5pXS7WMB/dit1RZJvkUtGMpC9ysXMn9fXz35ulXYLCrEkZkLFV6SZMfqH/FclWAvZdWXp4oz/RS087+OzxOKi0c5ZPA+SWdHGiDLCH3DWBJs0c3W3n6xYX+yTf6J4XzFXBYKNQ0UDWVrYxXv8Xu8z+yaxGT7/3LPGwfNk6lnkzNmchvoR66B4qbWW20bKjaTR/Xi2i/Ul4hcIWIEW17Ior8i28yxxIvvSGW0Tfz+s9rz4T9SQk5k02Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfqY4hnmjr+SvS+tYQT8h+HpDv9abZiR5P/5Pv/M+E=;
 b=RLsS1FhiMbvhWBg/WFW7ycw/8XSiISLN03QlVDSKdEFVPI2mGZoczXKJvgM4atV//NgBPN7zTP/lrjWoAXEJ9yJ1IG+wPg39/63BfjKw6zkny8hMu95uSNIFRtekKQ8Lypa5a91bqIJAvXEF4Ve0xA5vCpVcDpu4sXU1j5BA/eRtwLmOeCzlqi0d7nr69y1PTP4W8LLq5bMTxEL0FiyY9Y6dlh/FNoFbCz5UrY5+aZLMuagJWVKnXcaxYqGKh4GNGzJ+0tCtv0pEl0BekBCTmlTe4+Xu28z+RVJuCCCAHp3q+PG5A1RBcmWXjlt1B0iqwXdVRhgFas5T/4wBTD8peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfqY4hnmjr+SvS+tYQT8h+HpDv9abZiR5P/5Pv/M+E=;
 b=0INJPNLyOj9rEGjhCOo3knPupdNK/c+AUlnV/TzJqMvMcvZW8duf8LBRZIaDiUYvUxUzXZAqLHxKFN+h/3McsRLuMHZQIigRQQBAsXC2POOwKBUo0VTPpnYBH0qcZsYDGxhtV71pR3syCUPeYG72HzeNSan8V4aOobWFca9MGyo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3957.namprd04.prod.outlook.com (2603:10b6:a02:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 11 Jun
 2020 23:32:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:32:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Topic: [PATCH v13 8/9] nvmet-passthru: Add enable/disable helpers
Thread-Index: AQHWKhRr7Wm2MqUdeUmSLdzKIjdSIQ==
Date:   Thu, 11 Jun 2020 23:32:57 +0000
Message-ID: <BYAPR04MB4965803E04A21743E4D6665E86800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-9-logang@deltatee.com>
 <BYAPR04MB4965E830CF6FDEE90FBC950B86800@BYAPR04MB4965.namprd04.prod.outlook.com>
 <36ea5fb0-ff95-fa27-0659-84c91f6b0587@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfff66d7-2550-4c73-ab1e-08d80e5fc59e
x-ms-traffictypediagnostic: BYAPR04MB3957:
x-microsoft-antispam-prvs: <BYAPR04MB3957003764A5DCC07D7A417386800@BYAPR04MB3957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W56EWOGKG7PaBp/Lel/gBYpc0KssBPmUUfy1eFrjZZ+95+j1xS1YnYdAfLpOaIJAB8ZMI5wH+gLbFoZN7CFYmzuA3v0MTIz05lBfB0cqSlCu79Ge9uezCf4geZfzFI9j/A+VDABCHbrGro69c34qgZjufEdUvXGI8ZwAQXjyt6eJpq58RggkNvigyCJQqagb7HvaiHkHRaOtmJVOc+9fjEpM/ZuRlD/8i/6plS+Z94LW4gBUcCa7qlDyUIxCTEWzvk0cA5BeEJDfLKJddfPaX3Ko+Xqsi+NJPRqWjOjlumSsb/hchqnR5m5nVJa7+7G/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(76116006)(8936002)(64756008)(66446008)(66556008)(66476007)(66946007)(6506007)(52536014)(5660300002)(53546011)(9686003)(26005)(55016002)(7696005)(8676002)(71200400001)(2906002)(186003)(4744005)(316002)(54906003)(33656002)(478600001)(110136005)(83380400001)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XHpT8rS65GKGOzZ3+hX3FisF4lunfWszCmh8a5RO7e5k7MkIrdvHru0KEYPpNehbwOVsxwxDCIH1TtVsFqO6O6eryOe0LzOsI1dvQX9wdggDS5iog323IYYDZna5RQiiMuCwuIgLa/ga8niE1vrNjwh6yoJqe8k365DRM4qXfC4/4uifLp3ZGBn1z1dCarVGNpw2dJkpK3uZHu9CtEiETS8EV5ksIDQ1aesCQJc16QvhMUy3RM5URllhKjJQ/k21iak7ZF9OLlzb4K1CBFvxAphZfD12gIEvRZ+65se5OOG/XThuF4Ls7zApjia5ltbtsxRjlOyeuWSgukwQ2EI65RIKJezwlc45CFZ7KPxbv0VCIZV1gHgKFACUnv4dERe/2wOCchYZDq0MSbnDc8Q/yv07oFRfCLr8IgrENQ0hIEtGUPqn7bOHDJgdqqnfguIEWfNhwRNHl3o6FjSsYz2K2XFMfcHf56rmUe26+YvihYY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff66d7-2550-4c73-ab1e-08d80e5fc59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:32:57.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCQBS/i2xJXtJZfgQn1O1Qdt/hhjeP2I40L5/nx89+xa6WOocz/vAb+F0IBl9dKIPSeGCsjuHND+1MZo0gTgqSh99KQt9Jv+VPQQP2FT2N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/20 4:15 PM, Logan Gunthorpe wrote:=0A=
> Honestly, I think that is too brief. The error message is only 74 chars=
=0A=
> and there's a long standing exception for long lines in the kernel for=0A=
> printks. Even Linus has recently suggested that keeping to the 80 char=0A=
> limit is not recommended when it harms readability (though I don't=0A=
> generally agree with this 100%)[1].=0A=
=0A=
I'm aware of that and main cause is it creates unnecessary breaking =0A=
which can lead to bugs, hard to read code and ugly wrapped code. I think=0A=
this case is different with printing message which is straight forward =0A=
to read and not going to introduce any bugs in actual logic.=0A=
=0A=
Based on your earlier reply about splitting printk I'll let Christoph=0A=
and Sagi decide on what to do about this and whether to enforce strict=0A=
80 lines or not for NVMe subsystem for printing messages and for future=0A=
code.=0A=
