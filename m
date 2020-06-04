Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83808C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53814206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iZOjvqgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgFDIkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:40:00 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:49589
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgFDIkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:40:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMVB3VealovFNoz9EvZNJS7MpPtQdR3gV6LTDiVbp+xVo6Y+r6Kpb74WLe7ITvdXoLNPHg8vLOpnwOG28ROAqwwilPi7U/0113a9NrmSHNEcTmXCiI/rLkuoL3VxB9h1i2/joGWawJ/cPV4hOOLbx+wBoVh+GZZxw7gBx96srw3p3+TtEqhP6pGymkvVxHq6MF7I/nfc5XKISfVcVJpeewN+WmCWbaHeFJyubN/P1fjlO2NVyBYWj1ydyG94jyFxwAri9qYwysna6HCkAdFmb4qyb7i7XLaBIE1HWz/9ZeSKpGnXFRgehpCZniDwq08gOLPxU7Sz5bc1awtGowjlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpXTRvLSyOh5s+LfCmB9GwA8m5MY+qG1HarZXQvjPOA=;
 b=eMmesKj0s3YtLbfF2gfMvZ6mo0xSe1dWHo7sQuBeGpRWpiuOKOluYWAon0ffUSr+krwSoLrQDB4ei2Eayc0CdyJ2zTJQwEGXbzfG69oLslkGawQGpeVmprkn3u6vLYyfha/D32/OqmOO+obBpRK5yIYk+hA4w1Fmmciaywb34xgq303cCumI1NjIRAkQQE0lak08QssbnfvgohqHOSXeL3vVxb91OnChbOx/ED7QkmFBy1VA6Jzhz1CoQxFceLBskc44pFtsIvIzy1V8vDqGEeojxQvaQPnscRoSuwQmFhRV8yEs8ceHN2vLNb6v5yqvFEe2umocadLPi+2mTc8fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpXTRvLSyOh5s+LfCmB9GwA8m5MY+qG1HarZXQvjPOA=;
 b=iZOjvqgi+RIgjc0z3G1IvwlA7z8rSP5bPzynmF4nM2aX2x1e4FBD64tp2zF3oFQ95xor2+aqdgboNkth+wKIDkGKpvwV6JfBGWpY++48BjE4Pf2z/f0i2ve0tVFCveLKu3+V/V0HEVFdoPAAFcVM0tj42kNCJXnMd4fGdriYLlY=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5288.eurprd04.prod.outlook.com (2603:10a6:20b:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 08:39:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 08:39:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: clock: Convert imx7ulp clock to
 json-schema
Thread-Topic: [PATCH V2] dt-bindings: clock: Convert imx7ulp clock to
 json-schema
Thread-Index: AQHWOhGSp3Y4XiEnqUiyMH3+78AdsqjIIyxg
Date:   Thu, 4 Jun 2020 08:39:54 +0000
Message-ID: <AM6PR04MB49666E9E2443378C8040F11B80890@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6719837-66b0-4d2e-5f52-08d80862daca
x-ms-traffictypediagnostic: AM6PR04MB5288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5288BCD1EF47E3D99F0FD84C80890@AM6PR04MB5288.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vziNgU7MTqmaf+uEswebUqIMqqYywUGemMgSXB6EQxMme2QqF3/vlPHlptXs7ycW6GznqTp0HerSAVwLEp1urr1WvgMtmHl26YsdLWzi1ihQbOWa9JgaMRmAMrpeQWaXQfKGxe8Y6PrMb6ljxftGBQsOF8H4GcX33LFDzuMq/57s2A3x5p2hi4uY74Kzpj8H/SSh7a/Yv8HvjIW3qjKLChoQ4TBdE8UhXKwJqs/OsTZ7FUmhuwgfKMsgoh6gcZr8HuzTSMb3DDdQHwqM88fvnIP6GtDl92ZGPiK+s1cZvCAzz1VKZjUSoGVxuIrnvWEbml3erdR23a3bNgKtmOm1UqG+hBnpUKO1fCKgYQ4NhDE6zr8mP23/QWQ2YF+PBxRX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(478600001)(2906002)(33656002)(66946007)(5660300002)(4326008)(8936002)(7416002)(76116006)(64756008)(8676002)(4744005)(55016002)(66446008)(66476007)(66556008)(52536014)(9686003)(71200400001)(316002)(110136005)(44832011)(86362001)(83380400001)(7696005)(186003)(26005)(6506007)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bVaxukPXJWPxQTdOUHM0e1sbye/V4dpLBvD7YbMeNk4SxtDqgfbMvuIyhxw0wRcLTF5E60FoMEg/FfiU6GSz+mD3srC0PfRLNSnLMkCJLKgxmyFLfstgQQ8PRW48QOYjlp0iwu+79VV4LiikbtpHxYNek8V1CHy8dCBVtlw8Hn7OsNxJVBgnDAoEXGg9zQIBIbnlKiNzj2up0aEE4Qpm6GP8w7M84w/iZumP1nm5jYomHGAjeiFQrpFZQJiMGXC67CURaZPVQk7nfyRKjl09h3hbui7RvkppuaaXyatEVeI23KVW2ShVcfmY7hp1OfQmKlf5fbEt0xFLEq951bGv7YFs35SaSCES5K7WPCkx5bu7CWmETX2rtSqCOCaDdokWPs404TYgljOygjqs1Hg/iOP8wCxHVgxfZjGNvUY+2slKulgvyY3v9ZHfeTcNCsxuf+CLUhjtHXVc24EIhsv3pqzeFkVJt2J8gc3JsazBZ0dhcl4C+cQCRhF2HcDCE2qG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6719837-66b0-4d2e-5f52-08d80862daca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 08:39:54.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaUJav8p3rOk+2KR0Fj8p3SrSOJCjo1VcAnVQUk1HHZiPbnTCMFrmsaDaLz/bqcjm9/soV0+g13Rq2FV+zJOKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEp1bmUgNCwgMjAyMCA5OjMzIEFNDQo+IA0KPiBDb252ZXJ0IHRoZSBpLk1YN1VMUCBjbG9j
ayBiaW5kaW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEsDQo+IHRoZSBv
cmlnaW5hbCBiaW5kaW5nIGRvYyBpcyBhY3R1YWxseSBmb3IgdHdvIGNsb2NrIG1vZHVsZXMoU0NH
IGFuZCBQQ0MpLCBzbyBzcGxpdA0KPiBpdCB0byB0d28gYmluZGluZyBkb2NzLCBhbmQgdGhlIE1Q
TEwobWlwaSBQTEwpIGlzIE5PVCBzdXBwb3NlZCB0byBiZSBpbiBjbG9jaw0KPiBtb2R1bGUsIHNv
IHJlbW92ZSBpdCBmcm9tIGJpbmRpbmcgZG9jIGFzIHdlbGwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcg
QWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
