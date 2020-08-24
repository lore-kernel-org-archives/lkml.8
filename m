Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09591C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D798C20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/yIEyDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHXITA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:19:00 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:39137
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgHXIS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5W/GzqqXdZj7U1SbASS8dHkMQ5fuyogoABdb3gfpV28r2nqi9CBPEM4h3IkZZ/Me+rIQ/JeS8WejI7btXRRIHGpyHMlU08Tnwo1usafgjtMrMfFZvvKjBfu2Dgg4RvEHWzxonm8GqPxxXnQKJr+MSpJS1P6E89c2GNdOFEGcZLG7vlTM1A0RlHkXSIkk1tnYcenApkbGaHbsPNzUt94uq1T/nyVX9QJ/HNHaffoFDCQzoftPjti2DRpklXZHca3FxJpxnOkRA5wXPpwotP96YWVjtqdJmbIrA63eyl6kbRAFfsRPiswZUKWW0keYktGYwbeFiJquoL0ovaerUNQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXIUK1ih/zBDqYQMwrtbppGwMfLbLNaoL0zizaXisLI=;
 b=gPNqD4WEqHq+kk7+GWxgLr34DvcljFj6JFkAWITB7Gb8p1wBtGhnh7dE9Eo7sTKRTNDx5pnv9qUyfinFs185LJqe+X4gP4CX208jPV8YOeUSwsGl7GOqZv6Iv72C/RCabQgGr7BQ1u3GZouISw9UeRUmyi6TMRWfc8XghiDIA/Z3R6cQLMd2E2K4rvzz4IwF3O5+46AubK8DMlFduOGZgRmu4XGW1n/qT3xwRBZsMB1GbZpV/+OGFwMRBnsN5C6vxWHaRlSQ8nE2DuiEm0aHMn06NgyTn//HJsIsYHZpzURw8Qh935sO8UgxKwzoX6G/FdzEDdjNP7HLwff0CWE60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXIUK1ih/zBDqYQMwrtbppGwMfLbLNaoL0zizaXisLI=;
 b=F/yIEyDwgUudA0NBisV42zNlai/Qo6euK+V4iL25wlD0XVVIubfnQwea0YIx/rSGW3EsXFYDWp4Wz9dVjgQsL9pqdEVtL2765RRvom3Gj6s7X/LHMiD9um0eWdJ9SzvwQd0PP1BYFRMz9xLX/Oe4sB0JE7qsdhn+Z0hKwun8hMc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 08:18:56 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:18:56 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Dong Aisheng <dongas86@gmail.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: RE: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
Thread-Topic: Lockdep warning caused by "driver core: Fix sleeping in invalid
 context during device link deletion"
Thread-Index: AQHWd25DsUuuRELfrECPQIWK8Z77BqlC4s8AgAQMZuA=
Date:   Mon, 24 Aug 2020 08:18:56 +0000
Message-ID: <AM6PR04MB4966FBCF88E707CAC069663680560@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com>
 <CAGETcx8wAgMeh-ZanMD4xjdFniYpjYK-h=pfjf2EpKy-p321AQ@mail.gmail.com>
In-Reply-To: <CAGETcx8wAgMeh-ZanMD4xjdFniYpjYK-h=pfjf2EpKy-p321AQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b2e2e88-4cf6-42d0-78d0-08d848065860
x-ms-traffictypediagnostic: AM7PR04MB7015:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB70158786A01C6AA4AB44C6CE80560@AM7PR04MB7015.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vg0hyWN4GQmV89s07HcvGVIvRHesI4Hhjqg6sTksYCrBPWMWDcEtKoDKBVL9HclNi+2iDYZpv6A2B5eO6n60fcZ1Rk11SPprJDsjGY4gYc6GC46pG/3mSg/mkBKR8e/0tzdIkvoZI4M/ltdX6X09EwBqttCd+k1IUOIYQKEXuzP6GW0OUDcJH9/ZPQz/smA5ZMdXCaNhcdu9DhTN668P+M+EskRI3W4hMhvnY8th/bgP+u2eadqb99IpZHQQQp9I96A919cEyYIXhGPvJXosQyLtB7oOOLNtoEz+BMPNncXJS7nGgjI6z7Nou17bKF4i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(8676002)(478600001)(83380400001)(4744005)(7416002)(110136005)(71200400001)(316002)(86362001)(54906003)(5660300002)(6506007)(52536014)(53546011)(8936002)(9686003)(55016002)(2906002)(186003)(66446008)(76116006)(66946007)(7696005)(66476007)(64756008)(66556008)(26005)(44832011)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4LjMVknSeyXJwBf39SXywkLH32jiWdHICaKmh/7Xmx2EdHSDl9k8s3ARItn46/s+ut2Q1LOUafaelH46FDfggLCHzVNr4wpwKSK5o04/bcEw8BM2ZCo3nW57zRGMAPEri2GtYpG300RaA0YwAqpT7ZXsMor6TC88gueAVyMmAf74SmFY77yqPZWgS9WBh75yNjubDarIaefd6N60hMFM3U6vR3ds00eCcF19DzWvkj3I/OWgmQFhOG0yTnU3+o+1R3gLiz5aCBTNfC3Jk2R8UlsrTdU1eiEc1onpZMJCpazNvmDM5lHLIkjkBN5q/z1cplxr3szKDim+Mz1OFmrQKLX1ZhUIke+5/ZZzKo8Hv0w+ULlZTx0ptMmLlF1H+vSyxvWjlavu+gCx9KhelUKQ0/v5YC40cspb/U74EVRgraCEHPemYGhb0gdzKQMWuXA7YNSO4N6FDfwtrScAP1kWA0BSVo3Slz6RJ7VVDj6KDfO/MeVBj+JhOdxhc+xiMnedcNFyz+1395upuFduNha5/HpZe5HWix3kUnFE9Bsr/c92+US53oNm1+PNeFrxYWj1G0c7UvPrqvjReAcLVhH1EHY9I1Yu1Je2N/fEHMvrnnFmtjjc0mlvqY/kvCkpFSkt3WSHPzqt4eOMoeoRjhX5AQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2e2e88-4cf6-42d0-78d0-08d848065860
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 08:18:56.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/BlhfK8OttClBK5cmdwfYScV+tI6yQ+c3AHMMrMFpIFfOp1MQFHARcTy0Ar4idns07EskFAchdfbFKdPBYf4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTYXJhdmFuYSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29tPg0KPiBTZW50OiBT
YXR1cmRheSwgQXVndXN0IDIyLCAyMDIwIDI6MjggQU0NCj4gDQo+IE9uIFRodSwgQXVnIDIwLCAy
MDIwIGF0IDg6NTAgUE0gRG9uZyBBaXNoZW5nIDxkb25nYXM4NkBnbWFpbC5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgQUxMLA0KPiA+DQo+ID4gV2UgbWV0IHRoZSBiZWxvdyBXQVJOSU5HIGR1
cmluZyBzeXN0ZW0gc3VzcGVuZCBvbiBhbiBpTVg2USBTREIgYm9hcmQNCj4gPiB3aXRoIHRoZSBs
YXRlc3QgbGludXMvbWFzdGVyIGJyYW5jaCAodjUuOS1yYzErKSBhbmQgbmV4dC0yMDIwMDgyMC4N
Cj4gPiB2NS44IGtlcm5lbCBpcyBvay4gU28gaSBkaWQgYmlzZWN0IGFuZCBmaW5hbGx5IGZvdW5k
IGl0J3MgY2F1c2VkIGJ5DQo+ID4gdGhlIHBhdGNoIGJlbG93Lg0KPiA+IFJldmVydGluZyBpdCBj
YW4gZ2V0IHJpZCBvZiB0aGUgd2FybmluZywgYnV0IEkgd29uZGVyIGlmIHRoZXJlIG1heSBiZQ0K
PiA+IG90aGVyIHBvdGVudGlhbCBpc3N1ZXMuDQo+ID4gQW55IGlkZWFzPw0KPiANCj4gVGhhbmtz
IGZvciB0aGUgcmVwb3J0LiBJJ2xsIGxvb2sgaW50byB0aGlzIG1vcmUgY2xvc2VseSBhZnRlciBM
aW51eCBQbHVtYmVycyAobmV4dA0KPiB3ZWVrKS4gV2UgY2FuJ3QganVzdCByZXZlcnQgdGhlIHBh
dGNoIHlvdSBwb2ludGVkIG91dCBiZWNhdXNlIGl0J3MgZml4aW5nIGFub3RoZXINCj4gbG9ja2lu
ZyBpc3N1ZS4NCj4gDQoNClRoYW5rcy4gUGxzIGhhdmUgbWUgQ0NlZCB3aGVuIHlvdSBzZW5kIG91
dCBwYXRjaGVzLg0KSSdkIGxvdmUgdG8gdGVzdCBpdC4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
