Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917C420720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MAx4TECl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgFWCOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:14:09 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:56525
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728447AbgFWCOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9qDEnbhyjpH+F0e32ArMcZ77+G9q/HV8lTbewL/T0GvVe42LBlRGMGrXucyTT5OUuUntwPJcwiwVwhxZXyopHJ54fqHQlVBnpa8DA8hdyDkp9+UGSjX81Od8L6XAjJash+EJHWPjbKIGlz5s6pkr0GGKRKoKZrSX7gOuIzejNZAcLKKc+TIqFs6iYxSGGy3EAhegoo21GeNOQa8XKTOKoxH1yPHYTWSptmOmJnWpL6x9lHRAdqbxv73BGkep23kg6rzgXTK8rDH1B956b7m23Qv1HdSC7HyrWfRRCwNXHaadhKgqGxdjsg965MVvkoMzTCseEUm0gfIqweiziyWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MthDkVbk8Gf+iGCvOIjRmfIYYwun4XSe/UzoL28IiZc=;
 b=NAZIJVFV2vGksRnSXTCWub/rq3G7cZ49vs+0wrPv24DizeUFX5ckjuK5VNDFulC6eOdP/ArOp0jZcGupJHJBF51ScyuMBqYoF9vjq4mEUdxQg25DUgQh+PrAMaJXqEltiG7cvVmPkIiaOnOSK0NOwu2UbfLwzLueGB6oqsvV9tVBgo0rPcQQN9Imz5pL4zOMb6yJKHsfwj5TpjnLPf+YsRVQuEHU6W1OKzBtc7svig+ekYHvJsGv5J3CEBpvha5qImb5F+qytkuYSR7KptpbhUZ3aYzVbq5R2IVzjCX812pimxMDra37xAgjXVFM1eKx7pJZ5bowduv6epXzjncC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MthDkVbk8Gf+iGCvOIjRmfIYYwun4XSe/UzoL28IiZc=;
 b=MAx4TEClhAxxXNn6pVOzELA8+vRYjm5sA8habw08RcQPIGLnLMpwOHsRNXY7RoIFHQymrXJpPhQC/dHt4c0InKL78aNeocLq9ePRdAxUFCi8temQML2mhMFa37X15ykqmkXQyA12+j62pijNfieXWenEozMMb7NUSabBQc4Ym3o=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5160.eurprd04.prod.outlook.com (2603:10a6:20b:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 02:14:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 02:14:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mailbox: imx: Mark PM functions as __maybe_unused
Thread-Topic: [PATCH] mailbox: imx: Mark PM functions as __maybe_unused
Thread-Index: AQHWSPpS1T1SvLDfukmd7DmxcvdGgKjlddWw
Date:   Tue, 23 Jun 2020 02:14:05 +0000
Message-ID: <AM6PR04MB4966C312C40364B5BCA18C8780940@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20200623010403.517691-1-natechancellor@gmail.com>
In-Reply-To: <20200623010403.517691-1-natechancellor@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44af87b9-ecc2-49b1-2cd5-08d8171b1afb
x-ms-traffictypediagnostic: AM6PR04MB5160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5160A1B914CB18E1BA2015B280940@AM6PR04MB5160.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:166;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1e37LQF+Q3QY6VNroVEBL0wwwW8m3LqqJeZZ6srwO8gXw4XJ7DXF1w21e8XNQcEjCtqcy+rf19b2eoL3sAkkhGNtKrKw1qozLve+QkjW9p8iA/3vNAlHQBSI1tPOkw9DA2GAnYpOmJ1Ktk16CLj76SuhzTYno1mCY+i9bB3kYRFtB/JYEpl5UXkqEJpo5xJHFxGempCE2SkXS0PIIvkUVY5IPBJCb5S3p0GhDr4m5XhQyQgshsHlVm/vVnGNfeA02DTX9uHGuDG7yJrLTPzPsw5/Ju0Rw144Wo0DAjqo4YWOJpQVeDr4UjVRd/ho/JmalKkM1OYwEbh/6lAmYjrvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(9686003)(55016002)(64756008)(66556008)(76116006)(66446008)(66946007)(66476007)(110136005)(6506007)(15650500001)(26005)(54906003)(478600001)(7696005)(86362001)(186003)(316002)(4326008)(8676002)(8936002)(44832011)(2906002)(52536014)(83380400001)(5660300002)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KEEr/xvY5ilK02uD/LSEZuzRLjddHsxdJJTONhsi0qbCAd5cXcTkV45B6wPaL202lVE0+CIqE8VFmp1M70l0ip//PCPkx41FGy0jhxr5Q+bemFuu935hOKSsFs1NinJm/QWTetOOslgivSRYDyudeHHxmUG6w8LuM1IR4UBSUw6JhHyF2GdnxIhNFGLyZHDFl3/EOktl/4ql1EL4F2NY2pGCLId9lruN1zUNAgvUEqBgdTD0kUnciG7uMq7fE3aP6rkUsilqYgYo+zAv9IBfJpWXCGHA2AB7gSbs4+AuoDaFalZOCuHvvsol6sEOABzL7FyyeVSXyUioOXXWpRW9lzmHG9BYiayogOJA4UmoP3h+rNFU8EQ9cLd5NQLCG0uYlN35PU4+7PHJoou85clsJ0+v7GDyrdEKP2LsEb5t/fq6p3eMrleo03S0I7Ew3JmjOE5Z9VRXrbs7prPNEtSVYeA6TFmfYHAjHPI1XCxB8wE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af87b9-ecc2-49b1-2cd5-08d8171b1afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 02:14:05.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/QFDmspeHkEHbAuAnj7Qt6MDxZe041d2K8ydM+EvMNakndl+6adtNRsxiOVvDs/BKvBR9FfqY9twdLZjiIi2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBKdW5lIDIzLCAyMDIwIDk6MDQgQU0NCj4gDQo+IFdoZW4gQ09ORklHX1BN
IGFuZCBDT05GSUdfUE1fU0xFRVAgYXJlIHVuc2V0LCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzDQo+
IG9jY3VyOg0KPiANCj4gZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmM6NjM4OjEyOiB3YXJu
aW5nOiAnaW14X211X3J1bnRpbWVfcmVzdW1lJw0KPiBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtZnVuY3Rpb25dDQo+ICAgNjM4IHwgc3RhdGljIGludCBpbXhfbXVfcnVudGltZV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQo+IGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jOjYyOToxMjogd2Fybmlu
ZzogJ2lteF9tdV9ydW50aW1lX3N1c3BlbmQnDQo+IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3Vu
dXNlZC1mdW5jdGlvbl0NCj4gICA2MjkgfCBzdGF0aWMgaW50IGlteF9tdV9ydW50aW1lX3N1c3Bl
bmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPiBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYzo2MTE6MTI6IHdhcm5p
bmc6ICdpbXhfbXVfcmVzdW1lX25vaXJxJw0KPiBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtZnVuY3Rpb25dDQo+ICAgNjExIHwgc3RhdGljIGludCBpbXhfbXVfcmVzdW1lX25vaXJxKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmM6NjAxOjEyOiB3YXJuaW5nOiAnaW14
X211X3N1c3BlbmRfbm9pcnEnDQo+IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5j
dGlvbl0NCj4gICA2MDEgfCBzdGF0aWMgaW50IGlteF9tdV9zdXNwZW5kX25vaXJxKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
IA0KPiBNYXJrIHRoZXNlIGZ1bmN0aW9ucyBhcyBfX21heWJlX3VudXNlZCwgd2hpY2ggaXMgdGhl
IHN0YW5kYXJkIHByb2NlZHVyZSBmb3INCj4gUE0gZnVuY3Rpb25zLg0KPiANCj4gRml4ZXM6IGJi
MmIyNjI0ZGJlMiAoIm1haWxib3g6IGlteDogQWRkIHJ1bnRpbWUgUE0gY2FsbGJhY2sgdG8gaGFu
ZGxlIE1VDQo+IGNsb2NrcyIpDQo+IFNpZ25lZC1vZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxu
YXRlY2hhbmNlbGxvckBnbWFpbC5jb20+DQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4NCg0K
UmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg==
