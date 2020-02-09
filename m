Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4978BC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 06:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A3A2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 06:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="EKZtPM10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgBIGd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 01:33:57 -0500
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:30491
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbgBIGd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 01:33:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk51NzXpEVEEUf3GZdq3kmuCVnS3yCxdLecP5jMkHlc1/r5mcF4t9elW+hKJyFjCH7fyYFDCm+UoBWvLGVvGarM7DOqHFNStNzLoS0zh526suHozBgNgC13HvkcAzK3I7Z8yZDUWVuTXuSFz/iGEaiKbN6KdwYMWQZH6wyqvVKZ/lmS2+IgB9uN7F3vJcd3Ay94mx/Ufnc8Ds0D3BlRB1HJ7aNd921FZCgbqwPGZ3tdr2NzKo1Ube5txk+KRzx5kSlyahF9OhqRXforD+A8oLajxGrV8zzsL382SDi95P33IB9x6IPP8jPJ9+qw982VQErcrG4bEV4fbwhN6Bddwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfz4UUc7rys1R/uiZP4LiGYia6MEQ4MmK9sKGuph/CY=;
 b=h/NBxkTOEIPc91biuFDvLL/fEinYGF/PGJnqgbCDexBjdylSqFSOnuBI53uOMoQirlZM0ADFRJH2JVDR6Fffb2R8MXARY8owsRs17Ujr2B8FlIIgH50gqnra2nDi1ePJFa/lUcsHIwQStWV8ESL7+++zB09fzOiMyd90VVHZOh6MDt/B4nxbGTA1UkoWNjTtA0ujYu/n4rcKHWU7NIUv+yXH+scqu8Xw7tr3VVnpQv8xu6/HZ5FiDnUxzCZnx5xASralnUBHWw1POGyZkXzEZ9oKkfjs0sLab4YW5OQ7JZk7g9v6F09kce80X7/f1CBrVEeyGU8m9KBKxNBUw+B7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfz4UUc7rys1R/uiZP4LiGYia6MEQ4MmK9sKGuph/CY=;
 b=EKZtPM102sMVJuUIFETGaUV3soXoNp6NfW8Or2Nx1Rje0maz7pIUCRuqV0VPnD0TLnhxDidyaI6ByFyJdtwuS9OhocLiEL//fZzkFjj/ChdWsUELOnGro+pTQLBJttTEWv6B/x00yrq/BIeZIQJMGaQK3Mk/oEZZyzHOWuZuxqM=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB5009.eurprd02.prod.outlook.com (20.178.21.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Sun, 9 Feb 2020 06:33:52 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::8112:12dd:4130:9206%3]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 06:33:52 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/5] habanalabs: ratelimit error prints of IRQs
Thread-Topic: [PATCH 2/5] habanalabs: ratelimit error prints of IRQs
Thread-Index: AQHV3Y7bVRwxFyK6/kexXoA9FJ6Y3agSaRgA
Date:   Sun, 9 Feb 2020 06:33:52 +0000
Message-ID: <AM0PR02MB5523313ACC42C164B93D65F4B81E0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200207081520.5368-1-oded.gabbay@gmail.com>
 <20200207081520.5368-2-oded.gabbay@gmail.com>
In-Reply-To: <20200207081520.5368-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb55331b-712f-4e03-b318-08d7ad2a07b0
x-ms-traffictypediagnostic: AM0PR02MB5009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB50092C4FB88EFA291431A098B81E0@AM0PR02MB5009.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(346002)(396003)(376002)(189003)(199004)(478600001)(4326008)(53546011)(316002)(6506007)(2906002)(71200400001)(110136005)(52536014)(86362001)(66476007)(76116006)(6636002)(8676002)(7696005)(5660300002)(64756008)(66556008)(66446008)(8936002)(4744005)(66946007)(26005)(33656002)(81166006)(9686003)(186003)(81156014)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB5009;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nv77uByJmJFNgoyKhQr9lPr2kXLCP60LXfjX+VJtb/VUBgBMvfx64sRPL0MGtsTRHJ+QR8ATeYkQJMPyVoozbe4lOrgW5TjrpLaLY4e0Qm8BDp/DrWil34XSP3moGuwN9bTrY/IrY43KR3fsWtbUL1bUVetP9aIW8A9LLMYX/TtcSCukm85PbLlAPqSybpCH17clsMuX3Uez4dw061RHI1wmp5Pqh/88HFJSWW658S1yZflW7bJPxbLrgO7OBmbD1NE64LjQlQ0jFciHf0CGAMdEI95Y76mdcPfY8+1pFbfPI9XVD4uflBZyh9KUV7LuT/8RLCbaLO523yiN5XWeQIO5I2VVVvVL/UHG2aSkmoVIIvjqEa0R+xsZJqTsshf505ELGpyBj4xK/mmx3Vu19O3b1aQT24P/c4DItW/XBLTwMZDd6Tg7sNBizMDfF3ND
x-ms-exchange-antispam-messagedata: uCP4z76aSL9jYPWa/XuNyPluOmTlKskOvrStoIELMt2jQ0aThJ6EOya1u/a1eGuPV5nv65UpU/kE0gHpIH+QWDQZ98v3CsNI0FvW1tjQMtIZqA1OCketSBIUr7xMxyG5c/aePqgvBKf6Jdv5SkSAhQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: eb55331b-712f-4e03-b318-08d7ad2a07b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2020 06:33:52.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adYeWigFESebxk3Vh7K+ED33dCkCXbrLeRM6/n8ztyBF1XxYr6y7wwQp3lB2AZM6vLZuvUBG5TGrrZZ0VV8DAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBGZWIgNywgMjAyMCBhdCAxMDoxNSBBTSBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlA
Z21haWwuY29tPiB3cm90ZToNCj4gVGhlIGNvbXB1dGUgZW5naW5lcyBjYW4gcGVyZm9ybSBtaWxs
aW9ucyBvZiB0cmFuc2FjdGlvbnMgcGVyIHNlY29uZC4NCj4gSWYgdGhlcmUgaXMgYSBidWcgaW4g
dGhlIFMvVyBzdGFjaywgd2UgY291bGQgZ2V0IGEgbG90IG9mIGludGVycnVwdHMgYW5kDQo+IHNw
YW0gdGhlIGtlcm5lbCBsb2cuIFRoZXJlZm9yZSwgcmF0ZWxpbWl0IHRoZXNlIHByaW50cw0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpS
ZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=
