Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD9C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2DF20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mEtnmnXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD0Inn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:43:43 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:15840
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbgD0Ini (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:43:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WimqhGdjSO3lLkvhE2nk6LZgRVdel8qXQF6Kc5funzQgmSI7MexVoAPA62ATya4dV2rLqjBZACrOp3U0Am2s+5op1CrIEsyLg+7DlXpRgxY3oK4W56S2J97ypP7srRe5hPv1GUpj7L0Lt/QwU85RUdRak5dL1OJd7EgxtT1dWyA9SpFUeSQncOHdpXmree5CRe8sTABvhB9BF0RRaaqLKroxhiLJrGY/wYZilPVA0jxff9sdb0NxBy86+2jcpsNN5HwDFPolMuhnuBHItcnKfRCLEjQGQlrBjL0xqtfns7vn5Jx6vnUsa4r6btb4wcbf2GNiL8otamWPLVVFw4a6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyN0pFqVc/UgEdHtIgLBMIDwsw6pgcJpTULwrTdSXNY=;
 b=E9sI7nN2NMRnBNP23EHHCw8LNUnmKx5GbGrm8SDwiIzdGXfTvWVKDi1oao9Drg9PCHtEMbdrNyuhp1RJltSh1O1kW9IdFWz8xnCZcA8E/iu+6BN93z6MKU68kauUG8+ETMzKe32pCkFF1PkmIHHg/D5aY50Yr0DmJ2SHq3/Sf43NK6W9zkP1DrlqeH99DIXZPnd29zFQ3TeAWLeBtnnXyvJvLcCmGYRee3EyBtqN2VbR1/iFGhAZgG+uWGkcSuNoU+wt91EMp93EmQG9MfCqViQ3Ap2ZVNIiQHv4UJJlYkyjZB99FUmnqnamb8agfjJvlRTyEDmqMQ4G/kFsC6mP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyN0pFqVc/UgEdHtIgLBMIDwsw6pgcJpTULwrTdSXNY=;
 b=mEtnmnXt9w8HUcf2z1ZP60xWeNu11AsvsqkzWDt/LeVcdagcQgl5mrKb65Y8Et9X1t6QMgWPAQVg+yqGvJ2+yidYgjrHIGYyJfq6WfTe42qQ9+in91uP5DXTrR/fAXre0ZeAMTVQfSePJDszhosmjJnn3RZNLbElUS7/6at2dRM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:43:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:43:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Topic: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Index: AQHWGTz1S3ryZr4eI06QzGNLele1k6iGhU2AgAACxjCAADVJgIAAt/hggAAQDACABSdo4A==
Date:   Mon, 27 Apr 2020 08:43:31 +0000
Message-ID: <DB6PR0402MB27609BE35A7D7C93789DA4DF88AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276068E21E36BFCCA91728D088D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB49665A599A06623160EB592980D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49665A599A06623160EB592980D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7060ce00-0fa8-4d58-2e80-08d7ea8710d1
x-ms-traffictypediagnostic: DB6PR0402MB2935:|DB6PR0402MB2935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2935B5F439239880B41B263E88AF0@DB6PR0402MB2935.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(5660300002)(478600001)(110136005)(26005)(966005)(7696005)(186003)(55016002)(86362001)(53546011)(6506007)(54906003)(33656002)(316002)(2906002)(8676002)(4326008)(76116006)(81156014)(44832011)(52536014)(8936002)(66556008)(66946007)(9686003)(64756008)(66446008)(66476007)(71200400001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVIxZchFaqHuxb5zY8ixIwwhdCSdaPR2aJEVYt8GPN0DuTJXVFssBNTiScJFURioGSANYN1nZuN8Z4N94O1r0m23RrhZmOC3KoMbPUQNOix5/m6nPTX+oaLL8zCkvNHYydL+DfGhobVOGNeYe0ZmPaPK/grhLRXtGd/Z83NjcqUMsS8lEsuGo0HNIo4GnZvVGTDejCondrS74Vwtpl80v2XIur5EwR2n6sd/4hxvkRnWM9+0Aun6UAa+2oW8LLqMZNJUk1q6UhIkyp7w7cCf6JfgTmNSB7ugNcdSHOAbC8AB/PR16Tanm9UviGaF9vGwWn1yYm96lnYuRlruZV/3a42JDLhvctd2mZIvRoOa7P7scIGPA3R8ja7Ejz6bfxg4UKWY4Dwc2NpRyBjdIExOiAA4Z2doXIA35mrZyndpTrUGO9jL6mvRNrq/si1QuRXo/Fu3XCkJecH4y8X2ZqPCF1oFx2nsnp5uFhAi/ZkIGjMrHU7Y7PBojW3Djsb+toNGPeJz2OTgLuBQt1EyMNIPZA==
x-ms-exchange-antispam-messagedata: Emno0vYRMHnKD9UdAY7wCR9YStTN56GrEzBCotoOVK1gmnBSxnp1nP+GWKgLVy1gU/4cRQN+LwZF9J6U1iGOMK6hbwZxXOVg8bfpTyvvBBdZvCaV89GFjmUF70P4w4joXzMJSuG0Swbw1vIvGbelZT5aHLfh27kEtCF7hcIuelgu+3t94hE23igAlvS93OGszpSlG16IOgYL1am/d5MuATRfyGh2KNmsFEkUhmRgs9Z8Jj10lTC6o1eZOka7esYhVet1qyvrtz2FuAHz1LMXeIMNY7+3YO+E/JpP9nrBE8yBDxbU8ZeukdBrC6z2ekd1Xhf3lsDuCkO7i+BKTBN3xZTHZS7sQRnr56vW8dUm0isUEPZ8UAQJocvR3pKnjLwkVJB6H/N6LRvbWMyhBKScjhMvfMTALbF5ROdQsGZU3/7GOIRH8jJNpAb7hd92Qu/VnlTpRTyWnV8hSTCKD6s7y52cTb2C1ChenTZ1zjG2KuEP0ji2LMoqBc+7uL2g4Y6yVsL/PHCHFQzrjiE1FOvq4/vib7z/GtEqaHzbCdX2qBBX6WL26CzPCX21Vn3Zx5kn34bV99P/R0eM+bwxUeS4MwXHUbHVidXxMRNMMutXrC5ACwow0DaZqvkN3Sw8CSNNDwMV1Vx3lVzEYyovrBT5hre60JAA1lnNZiDlDMDxwsmWlyV/G9JKYx0i4J3nHKtCIHck4EVPAE7lewN0i6s9fJW9ZWcJXuPgw3OJhe2ewBkU8MXlRLb0JqrE+GqR8ctPu3uBtd4FMk4pFoZTJAkwT6fRPJku7V9fsPhcOdgZcDw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7060ce00-0fa8-4d58-2e80-08d7ea8710d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 08:43:31.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hGuQlUdXrr0atztqJWcBUNx48z7Z8Send+VidqU/tdcOA5lLOZFJqpkOW3ppgVjRrJs71RvyfLRBwkPt3yGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGlteDogaW50cm9kdWNlIGlteF9jbGtfaHdfY3Jp
dGljYWwNCj4gDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU2Vu
dDogRnJpZGF5LCBBcHJpbCAyNCwgMjAyMCA5OjA4IEFNDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJF
OiBbUEFUQ0hdIGNsazogaW14OiBpbnRyb2R1Y2UgaW14X2Nsa19od19jcml0aWNhbA0KPiA+ID4N
Cj4gPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCA2OjU0IFBNDQo+ID4gPiA+DQo+ID4gPiA+ID4gU3Vi
amVjdDogUkU6IFtQQVRDSF0gY2xrOiBpbXg6IGludHJvZHVjZSBpbXhfY2xrX2h3X2NyaXRpY2Fs
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
Pg0KPiA+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDI6NTIgUE0NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUbyBpLk1YOE0gU29DLCB0aGVyZSBpcyBhbiBjYXNlIGlz
IHdoZW4gcnVubmluZyBkdWFsIE9TZXMgd2l0aA0KPiA+ID4gPiA+ID4gaHlwZXJ2aXNvciwgdGhl
IGNsayBvZiB0aGUgaGFyZHdhcmUgdGhhdCBwYXNzdGhyb3VnaCB0byB0aGUNCj4gPiA+ID4gPiA+
IDJuZCBPUyBuZWVkcyB0byBiZSBzZXR1cCBieSAxc3QgTGludXggT1MuDQo+ID4gPiA+ID4gPiBT
byBkZXRlY3QgY2xvY2stY3JpdGljYWwgZnJvbSBjY20gbm9kZSBhbmQgZW5hYmxlIHRoZSBjbG9j
a3MNCj4gPiA+ID4gPiA+IHRvIGxldCB0aGUgMm5kIE9TIGNvdWxkIHVzZSB0aGUgaGFyZHdhcmUg
d2l0aG91dCB0b3VjaCBDQ00NCj4gbW9kdWxlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay5jIHwgMTkgKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiA+ID4gZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+ID4gPiB8ICAx
DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2lteC9jbGsuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0KPiA+ID4gPiA+ID4gaW5kZXgNCj4g
PiA+ID4gPiA+IDg3YWI4ZGIzZDI4Mi4uZWM3ZDQyMjU0MGMxIDEwMDY0NA0KPiA+ID4gPiA+ID4g
LS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLmMNCj4gPiA+ID4gPiA+IEBAIC0xNzcsMyArMTc3LDIyIEBAIHN0YXRpYyBpbnQg
X19pbml0IGlteF9jbGtfZGlzYWJsZV91YXJ0KHZvaWQpDQo+ID4gPiA+ID4gPiAgCXJldHVybiAw
Ow0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICBsYXRlX2luaXRjYWxsX3N5bmMoaW14X2Ns
a19kaXNhYmxlX3VhcnQpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK2ludCBpbXhfY2xr
X2h3X2NyaXRpY2FsKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHN0cnVjdCBjbGtfaHcNCj4gPiA+
ID4gPiA+ICsqIGNvbnN0DQo+ID4gPiA+ID4gPiAraHdzW10pIHsNCj4gPiA+ID4gPiA+ICsJc3Ry
dWN0IHByb3BlcnR5ICpwcm9wOw0KPiA+ID4gPiA+ID4gKwljb25zdCBfX2JlMzIgKmN1cjsNCj4g
PiA+ID4gPiA+ICsJdTMyIGlkeDsNCj4gPiA+ID4gPiA+ICsJaW50IHJldDsNCj4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ICsJaWYgKCFucCB8fCAhaHdzKQ0KPiA+ID4gPiA+ID4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCW9mX3Byb3BlcnR5X2Zvcl9l
YWNoX3UzMihucCwgImNsb2NrLWNyaXRpY2FsIiwgcHJvcCwgY3VyLA0KPiA+ID4gPiA+ID4gK2lk
eCkgew0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXMgdGhlcmUgYSBiaW5kaW5nIGZvciBpdCBhbHJl
YWR5Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIGNsb2NrLWNyaXRpY2FsIGlzIGEgY29tbW9u
IGJpbmRpbmdzPyBTZWUgb2ZfY2xrX2RldGVjdF9jcml0aWNhbC4NCj4gPiA+ID4gUGxlYXNlIHJl
dmlldyB3aGV0aGVyIHRoaXMgYXBwcm9hY2ggaXMgYWNjZXB0YWJsZSwgaWYgZG8gbmVlZA0KPiA+
ID4gPiBiaW5kaW5ncywgSSBjb3VsZCBhZGQgdGhhdCBpbiB2Mi4NCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBJJ20gb2sgaWYgaXQncyBhIGNvbW1vbiBiaW5kaW5nIGFscmVhZHkgc3VwcG9ydGVkIGJ5
IGN1cnJlbnQgY2xrDQo+IGZyYW1ld29yay4NCj4gPiA+IEJ1dCBpdCBzZWVtcyB0byBiZSBtb3Jl
IGxpa2UgYSBjb21tb24gY2xrIGZlYXR1cmUgcmF0aGVyIHRoYW4NCj4gPiA+IHBsYXRmb3JtIGZl
YXR1cmUuDQo+ID4NCj4gPiBIZXJlIGlzIHRvIHVzZSBpdCBmb3IgZHVhbCBMaW51eCBjYXNlIHJ1
bm5pbmcgb24gaS5NWCBwbGFmb3Jtcy4NCj4gPiBJdCBpcyB0byByZXBsYWNlIHRoZSBpbml0LW9u
LWFycmF5IHByb3BlcnR5IGluIGRvd25zdHJlYW0ga2VybmVsLg0KPiA+DQo+ID4gVGhlIHJlY29t
bWVuZGVkIGNyaXRpY2FsIGNsb2NrIGlzIHVzaW5nIENMS19JU19DUklUSUNBTCBmbGFnIGluIGNs
aw0KPiA+IGRyaXZlciwgbm90IHVzZSBjbG9jay1jcml0aWNhbCBwcm9wZXJ0eS4NCj4gPg0KPiAN
Cj4gQ2xvY2stY3JpdGljYWwgcHJvcGVydHkgc2VlbXMgRFQgdXNhZ2Ugb2YgQ0xLX0lTX0NSSVRJ
Q0FMIGZsYWcgYW5kIHB1cmUNCj4gcGxhdGZvcm0gaW5kZXBlbmRlbnQuDQo+IFNvIEkgd29uZGVy
IGlmIHRoaXMgZmVhdHVyZSBjb3VsZCBiZSBhZGRlZCBpbnRvIG9mX2Nsa19hZGRfaHdfcHJvdmlk
ZXIuDQoNCkFmdGVyIGNoZWNrLCBvZl9jbGtfYWRkX2h3X3Byb3ZpZGVyIHRha2VzIG5vZGUgcG9p
bnRlciBhbmQgYSBmdW5jdGlvbiBwb2ludGVyDQphcyBwYXJhbWV0ZXIsIGhvd2V2ZXIgY2xvY2st
Y3JpdGljYWwgbmVlZHMgY2xrIGluZGV4IGFuZCB0aGUgY2xrX2h3IGFycmF5DQpwb2ludGVyLiBJ
dCBuZWVkcyBtb3JlIGNoYW5nZXMgdG8gY29tbW9uIGNvZGUgdGhhdCBJIHdvdWxkIG5vdCBsaWtl
DQp0byBkby4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gPiBCdXQgaGVyZSwgd2UgY291bGQg
bm90IHVzZSBDTEtfSVNfQ1JJVElDQUwsIGJlY2F1c2Ugd2hlbiBzdXBwb3J0IGR1YWwNCj4gPiBP
U2VzLCBpdCBpcyBub3QgZmxleGlibGUsIGFuZCBpdCB3aWxsIGFmZmVjdCBub24gaHlwZXJ2aXNv
ciBjYXNlLg0KPiA+DQo+IA0KPiBBIGJpdCBjb25mdWluZyBiZWNhdXNlIHlvdSBzYWlkIHRoZSBj
cml0aWNhbC1jbG9jayBwcm9wZXJ0eSB3aWxsIG9ubHkgYmUgdXNlZCBieQ0KPiBIeXBlcnZpc29y
IGR0cywgdGhlbiBob3cgdG8gYWZmZWN0IG5vbiBoeXBlcnZpc29yIGNhc2VzPw0KPiANCj4gPiA+
IEFsc28gYSBiaXQgc3RyYW5nZSB0aGF0IHdoeSBJIGRpZCBub3QgZmluZCB0aGUgYmluZGluZyBk
b2MgaW4gbGF0ZXN0IGtlcm5lbC4NCj4gPiA+IE1heWJlIFN0ZXBoZW4gY291bGQgY29tbWVudCBt
b3JlLg0KPiA+DQo+ID4gSXQgaXMgdXNlZCBoZXJlLg0KPiA+IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y1LjctcmMyL3NvdXJjZS9kcml2ZXJzL2Nsay9jbGsuYyNMNDgNCj4gPiA5
MQ0KPiANCj4gWWVzLCBJIGFsc28gc2F3IGl0LCBidXQgZGlkbid0IGZpbmQgYmluZGluZyBkb2Mu
DQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBCVFcsIGlm
IHVzaW5nIHRoaXMgZm9yIGR1YWwgT1NlcyBjYXNlLCB3aWxsIHRob3NlIGNyaXRpY2FsIGNsb2Nr
cw0KPiA+ID4gYWZmZWN0IHRoZSBub3JtYWwgdXNlcnMgdGhhdCBub3QgYm9vdGluZyB0aGUgc2Vj
b25kIE9TPw0KPiA+DQo+ID4gTm8uIGR1YWwgb3MgdXNpbmcgeC1yb290LmR0cywgbm90IHguZHRz
LiBjcml0aWNhbC1jbG9jayB3aWxsIGJlIHB1c2ggaW4NCj4geC1yb290LmR0cy4NCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBQZW5nLg0KPiA+DQo+ID4gPg0KPiA+ID4gUmVnYXJkcw0KPiA+ID4gQWlz
aGVuZw0KPiA+ID4NCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBQZW5nLg0KPiA+ID4gPg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gUmVnYXJkcw0KPiA+ID4gPiA+IEFpc2hlbmcNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGh3c1tpZHhdLT5jbGspOw0K
PiA+ID4gPiA+ID4gKwkJaWYgKHJldCkNCj4gPiA+ID4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+
ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCXJldHVybiAwOw0KPiA+
ID4gPiA+ID4gK30NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LmggYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCj4gPiA+ID4gPiA+IGluZGV4IGQ0ZWExNjA5YmNi
Ny4uNzAxZDc0NDBmOThjIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14
L2Nsay5oDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCj4gPiA+ID4g
PiA+IEBAIC05LDYgKzksNyBAQCBleHRlcm4gc3BpbmxvY2tfdCBpbXhfY2NtX2xvY2s7DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gIHZvaWQgaW14X2NoZWNrX2Nsb2NrcyhzdHJ1Y3QgY2xrICpj
bGtzW10sIHVuc2lnbmVkIGludA0KPiA+ID4gPiA+ID4gY291bnQpOyB2b2lkIGlteF9jaGVja19j
bGtfaHdzKHN0cnVjdCBjbGtfaHcgKmNsa3NbXSwgdW5zaWduZWQNCj4gPiA+ID4gPiA+IGludCBj
b3VudCk7DQo+ID4gPiA+ID4gPiAraW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3RydWN0IGRldmlj
ZV9ub2RlICpucCwgc3RydWN0IGNsa19odw0KPiA+ID4gPiA+ID4gKyogY29uc3QgaHdzW10pOw0K
PiA+ID4gPiA+ID4gIHZvaWQgaW14X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKHN0cnVjdCBjbGsgKiog
Y29uc3QgY2xrc1tdKTsNCj4gPiA+ID4gPiA+IHZvaWQgaW14X21tZGNfbWFza19oYW5kc2hha2Uo
dm9pZCBfX2lvbWVtICpjY21fYmFzZSwNCj4gdW5zaWduZWQNCj4gPiA+ID4gPiA+IGludA0KPiA+
ID4gY2huKTsNCj4gPiA+ID4gPiA+IHZvaWQgaW14X3VucmVnaXN0ZXJfY2xvY2tzKHN0cnVjdCBj
bGsgKmNsa3NbXSwgdW5zaWduZWQgaW50DQo+ID4gPiA+ID4gPiBjb3VudCk7DQo+ID4gPiA+ID4g
PiAtLQ0KPiA+ID4gPiA+ID4gMi4xNi40DQoNCg==
