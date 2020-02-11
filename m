Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3486C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E90206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="gI4dTZqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgBKPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:24:10 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:49437
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbgBKPYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPGYO82rqAUU6U3IqFAgm45gFlr1ziNZi7cQCNWtr2T4BefXP3hwUlZUY+yAFj+U5zbiZDTlCJuYApW55Y6hkANcg40J06tnEUYeNL9TuC/lZhXQgbfJ0bytEEbfIYkzfKru/57XBRnXmGXbax3ytcJsI++9SDokv1QHlywuYs87vpxmXZ6uR65TvTqWb7bK5/u72nuTP+ASbfC/BYygDCJ2V3Gsn5RgM57qUKbkEbzjYr9Y8pFWkSU9vsbfFsWOyhFfmdeYoRTxe5EURPlfwu/guwFWBoxkbCbP4XPa4qshtzDC2jWGlFxWXRte8hY/EspWiyzikgCX5vQDKC/wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeRLb2oDN1BWRMg4R1pfUJypJvbuP3YoymTukxPbE=;
 b=hssMj6MdfOex/LaTy2Jn9dM4gsy3jknPM8E5vFPjeTHDe2a1UCtyQxaqZkZ2ZBaky8vX+UxSo5ql6Ab/XHLA3jldRwt3/RI682/V/zfRAGHhOmOdZ2VqqGrEY2nFaHzYlErhYHzubhylzICerUtyPfLJCpIaYI2Nzcw6WKkNGN5JshQMUAyG1uI3PDwX+2bgVqhsnUqvekzhe6TtabpxgPS0LNSyEux7rVAIUQNPYM8AVoPQCNGzWpy9Md/bpFdrYiORlfoHrZaQiJP/Vn67i5ZUfN12vpAv1rglsg2D+9TtrXFhVrHwtN6SHVtjx9k/ScM9kBFnblw/fTgjhr7Q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeRLb2oDN1BWRMg4R1pfUJypJvbuP3YoymTukxPbE=;
 b=gI4dTZqfnXrd6RmB+RNkTTQNvqSeH3TtN0dTNwXPH0+aN5k4Huyp3SPmkJLExVl4UIGzLg5CnnYY+3Gb0bGLTlPVRn1k7zV1ehQ7vj0I9ElfoNpwGwnkhiTad3eQxGzCzASM+L+kNUo1wuPhhBf3erEsLt8PGbylJ97cPw8Mso8=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3566.namprd11.prod.outlook.com (20.178.251.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:24:07 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:24:07 +0000
From:   =?iso-8859-1?Q?J=E9r=F4me_Pouiller?= <Jerome.Pouiller@silabs.com>
To:     "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] staging: wfx: remove set but not used variable
 'tx_priv'
Thread-Topic: [PATCH -next] staging: wfx: remove set but not used variable
 'tx_priv'
Thread-Index: AQHV4OR7Gte2wj4gBkWnG+bg+D3foqgWHCEAgAAArYA=
Date:   Tue, 11 Feb 2020 15:24:07 +0000
Message-ID: <2132688.TkN2MAnNKH@pc-42>
References: <20200211140334.55248-1-yuehaibing@huawei.com>
 <7641155.kNzuLtrjOU@pc-42>
In-Reply-To: <7641155.kNzuLtrjOU@pc-42>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87dfc05-9a14-4d69-278f-08d7af066fe1
x-ms-traffictypediagnostic: MN2PR11MB3566:
x-microsoft-antispam-prvs: <MN2PR11MB356613E40199A6EA035CD54193180@MN2PR11MB3566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(366004)(136003)(39850400004)(396003)(189003)(199004)(4744005)(6916009)(2906002)(8936002)(186003)(6506007)(81166006)(81156014)(8676002)(6486002)(26005)(6512007)(9686003)(64756008)(66446008)(478600001)(66946007)(66556008)(91956017)(76116006)(316002)(4326008)(54906003)(66476007)(33716001)(71200400001)(86362001)(5660300002)(66574012)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3566;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUwLVQzkAaOUG3CtmaJBM8tNbDW0/12Y+IZXW+7ZqnLqn2tv9uU+oObhHnWV5i/I1aV/d5dlaECDdpGvBJYbRQ53HD/O7+Duy/p8B9fW8Miklp6uH6olS/UiHSkjWtdP/l9CCdKx95tTlGs4vVD1W1TMN+xQnFvNIedahXoj8KrLYUYlSUp1KFt5L06T85iL3cw/MxkItNbnfeg+77Re/smpSPYzl3i6a0rggkhBGK7PcktEtBm7JXHifR/HfZc5+G99XGCgG2IEbePwLJx7g2DHM3FcY+F3X8iw/dWKW8393I+qo+cBKyqW5ev96mElMSTKcb0X4l3DloJQhY7bbrTm93YL4i8i8+ti+5zOgANgfSw4jYqXFdWibhv07clM5uKBjLLjjGFXGDnffrPl41a9g8xNLPVzLnG9Uq4ZjZodg2RkDymuF3RMWTl1RcqRpiNOhp698DY1zmUiz6BUaPHOlOWazhUCE9/MSUSi97U6GoqbOploQUFykhVXqp2F
x-ms-exchange-antispam-messagedata: cHBDCYRolVJCxW5QLNjhzqVhx2df7yu3Vke6nS7CZnxfk44Rfm9KmTb4e8GataaRBN2qFCqQlM+d7Ez85hm14IwrBkG4YkZ9JI/zPaU0WPpMHtVLhUsNN8p705cySQeLnKhjFzlJYdNBDYUzEXil2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <206C9A7903982D4FAFB2B82EDE81D96C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87dfc05-9a14-4d69-278f-08d7af066fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 15:24:07.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUC80HawgLnDTAxyuI1mm4WVkgyRPqq55qi/31lfSQXLV4eNz2wDljv5e7E4frbmIYPdXcR+N0hOTTnpI9K7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 February 2020 16:21:41 CET J=E9r=F4me Pouiller wrote:
> On Tuesday 11 February 2020 15:03:34 CET YueHaibing wrote:
> > drivers/staging/wfx/queue.c: In function wfx_tx_queues_get:
> > drivers/staging/wfx/queue.c:484:28: warning: variable tx_priv set but n=
ot used [-Wunused-but-set-variable]
> >
> > commit 2e57865e79cf ("staging: wfx: pspoll_mask make no sense")
> > left behind this unused variable.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Maybe it could make sens to add a Fixes tag with the commit id that
introduce the warning?


--=20
J=E9r=F4me Pouiller

