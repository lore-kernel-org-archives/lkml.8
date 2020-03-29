Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16426C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47A020757
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 03:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WUN0wBLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgC2D3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:29:15 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:47011
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgC2D3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 23:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKMY6n/1hnJn9BQ23/PjERyFXJ7qL3xmrAonA5aK/Z786kFbo7TLVMyQQN0KFAk3KE6xxwtW4uATkHdeNqL75nlGjaML3Z13K6lBUzFE95YTxYbLiaS9QBBPbjMG+g6RyXbowW0ma8IRNEiHmJr1HwGIaiR9kPdXKVXbX9CY4xGekDSUVXuOrFoQ/U1YT+fTu/WvoCRKIUL7jb4ILmznMTd2E3c7goblL50EFvWNwjgVajDfF6b9UEh/N5yKnJTBOT3C8UZKTfH4FZUBgO/CR03VOxzOfT2zgNyxGq2JwzZt5yrcTjiYQ5DKZDV+/RUelCDDcU5tAZYkZIQDyHZ81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2fWXS6xmfJn15rnRTyiaMAue6UClySmO72gaQsHptQ=;
 b=Gj/G0EEh4/5Tp8DZVA16K+GVPkNy0DJ8PNljZPhIF/DYhegd4zEg8T15AIsgqdl0p5mLnKGQVV42vxItQuICT6Ug6n+kkdSnNwAmGxPGtz1PAgkniiVwRdFW1wWOye/sSSF8iNjOgXbBMogwcYlOEXq1/zr6H7qo0Xu4hCJdSp7Qt0TEhC+ekuxl5Og9s8J0bmxVVAvNgWE1uC677oeQnCl49a2F09Gf+dV2/0a8Q+P4pi32+fOxtPwxyILDD4eeZPs4so935piXcH1kTGOo+ywnkWQBLkCNqPudfTsksl2TA8OBNG31XlU2VKaCFFWYFSqrdXdCjhOt0a8dZFpm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2fWXS6xmfJn15rnRTyiaMAue6UClySmO72gaQsHptQ=;
 b=WUN0wBLwIm/1dqW7kU/70tY6jPxe06ekshMIihnvWcsg9nUAwVIeBP9vKhfwBoWmtSEaPgfWk0Sdqh1P5FgrR2YQV/gMkflljsXUmtgAahkqkTROL3HMUvrOfmeG/dODQO3BZGNQQAYMmY9D77eCK6Q8eAH7ow9Cl+HqDVkfsnE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Sun, 29 Mar 2020 03:29:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2856.019; Sun, 29 Mar 2020
 03:29:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: i.MX8MN Errors on 5.6-RC7
Thread-Topic: i.MX8MN Errors on 5.6-RC7
Thread-Index: AQHWBKuViOa/vuBTwkqHT9gRBvnGdKhd5InggAANSwCAAPjnwA==
Date:   Sun, 29 Mar 2020 03:29:08 +0000
Message-ID: <DB3PR0402MB3916B68A1B0F37EA34825F69F5CA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
 <DB3PR0402MB39160D3F0D03B968B7CBE25AF5CD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAHCN7xJ2m3LRB3oGBb5QKbacYyTBQK1CdzGcTh3w=hj18H=4Pw@mail.gmail.com>
In-Reply-To: <CAHCN7xJ2m3LRB3oGBb5QKbacYyTBQK1CdzGcTh3w=hj18H=4Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd6fd0b6-b18c-4949-d487-08d7d3915772
x-ms-traffictypediagnostic: DB3PR0402MB3738:|DB3PR0402MB3738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37386B0B09AEC63B31499064F5CA0@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(44832011)(2906002)(6506007)(8676002)(33656002)(478600001)(6916009)(86362001)(26005)(71200400001)(45080400002)(81156014)(8936002)(4326008)(81166006)(186003)(316002)(52536014)(66476007)(54906003)(5660300002)(55016002)(53546011)(66446008)(7416002)(76116006)(7696005)(9686003)(66946007)(66556008)(64756008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWxxio5k4WhXaupmA6v8b+L8s77+X8v6+1gme4EuP9qZj6fa/7Cdmj/EKWWoQ0GdhbrrpcsciO6h+mQ0SmXoxEZPSo0OX9bkELZyYUIVyr3oT5tRfZ3fTpOhKRxVDNlzxvTsRR4kYrnSQTioHI/FgRI7eThUnDgh6unewZ9prkTP3MDp7KufIcwNPkGo/ULwY4EtdKruCEk0bRCvYl9Qlv1Cmbrf4L42Ahn7liifxp/kDCaE4HCuDq2XC8eJztvHYgbUMCqG79fX0ybmNLl/hT3FFGaTm2VEEXLJCmam6MzJTM1m81/7XYmq7hAGc2Im4rXt6uHxfW2jMapBgpiB/WgYNSZYbdglEaAq0zzABpRfMzByNFSWZ5uwRIFNay2+t3s6ICiRqCkOb+D4sLXdjKb/cITGCNmxpktrezrMZqCGsojikEUhkbflIs691mVs
x-ms-exchange-antispam-messagedata: Cb/010jyyuBqQpuiDwYVw3facj74TV17mYwOft25DBdxT2InzrbGaKRMfa+R29wFcQ7wmmzcX/u+4Bpe9VtM+eSeJWp89sDR4/Mr/AwODD9IFc1a0rMvG0hd2A/mGRCLhn3FXfa4s2yCbeTEV+CzFQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6fd0b6-b18c-4949-d487-08d7d3915772
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 03:29:08.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spIRxHkfZLjYh8UJQ06fN8REKp4Gh33AajoI/3uUJpD7NgCscRv/0LoEE5jSu7mVD4aUlwSq9vZlgy5s1Kchcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IGkuTVg4TU4gRXJyb3JzIG9uIDUuNi1SQzcNCj4gDQo+IE9uIFNh
dCwgTWFyIDI4LCAyMDIwIGF0IDc6MDcgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGksIEFkYW0NCj4gPg0KPiA+ID4gU3ViamVjdDogaS5N
WDhNTiBFcnJvcnMgb24gNS42LVJDNw0KPiA+ID4NCj4gPiA+IEkgYW0gZ2V0dGluZyBhIGZldyBl
cnJvcnMgb24gdGhlIGkuTVg4TU46DQo+ID4gPg0KPiA+ID4gWyAgICAwLjAwMDM2OF0gRmFpbGVk
IHRvIGdldCBjbG9jayBmb3IgL3RpbWVyQDMwNmEwMDAwDQo+ID4gPiBbICAgIDAuMDAwMzgwXSBG
YWlsZWQgdG8gaW5pdGlhbGl6ZSAnL3RpbWVyQDMwNmEwMDAwJzogLTIyDQo+ID4gPiBbICAgIDcu
MjAzNDQ3XSBjYWFtIDMwOTAwMDAwLmNhYW06IEZhaWxlZCB0byBnZXQgY2xrICdpcGcnOiAtMg0K
PiA+ID4gWyAgICA3LjMzNDc0MV0gY2FhbSAzMDkwMDAwMC5jYWFtOiBGYWlsZWQgdG8gcmVxdWVz
dCBhbGwgbmVjZXNzYXJ5IGNsb2Nrcw0KPiA+ID4gWyAgICA3LjQzODY1MV0gY2FhbTogcHJvYmUg
b2YgMzA5MDAwMDAuY2FhbSBmYWlsZWQgd2l0aCBlcnJvciAtMg0KPiA+ID4gWyAgICA3Ljg1NDE5
M10gaW14LWNwdWZyZXEtZHQ6IHByb2JlIG9mIGlteC1jcHVmcmVxLWR0IGZhaWxlZCB3aXRoIGVy
cm9yIC0yDQo+ID4gPg0KPiA+ID4gSSB3YXMgY3VyaW91cyB0byBrbm93IGlmIGFueW9uZSBlbHNl
IGlzIHNlZWluZyBzaW1pbGFyIGVycm9ycy4gIEkNCj4gPiA+IGFscmVhZHkgc3VibWl0dGVkIGEg
cHJvcG9zZWQgZml4IGZvciBhIERNQSB0aW1lb3V0IChub3Qgc2hvd24gaGVyZSkNCj4gPiA+IHdo
aWNoIG1hdGNoZWQgd29yayBhbHJlYWR5IGRvbmUgb24gaS5NWDhNUSBhbmQgaS5NWDhNTS4NCj4g
PiA+DQo+ID4gPiBJIGFtIG5vdCBzZWVpbmcgaHVnZSBkaWZmZXJlbmNlcyBiZXR3ZWVuIDhNTSBh
bmQgOE1OIGluIHRoZSBub2Rlcw0KPiA+ID4gd2hpY2ggYWRkcmVzcyB0aGUgdGltZXIsIGNhYW0g
b3IgaW14LWNwdWZyZXEtZHQuDQo+ID4gPg0KPiA+ID4gSWYgYW55b25lIGhhcyBhbnkgc3VnZ2Vz
dGlvbnMsIEknZCBsb3ZlIHRvIHRyeSB0aGVtLg0KPiA+DQo+IA0KPiBGYWJpbywNCj4gDQo+IEkg
dHJpZWQgeW91ciBBVEYgc3VnZ2VzdGlvbiwgYW5kIGl0IGZpeGVkIHNvbWUgaXNzdWVzIGFuZCBp
bnRyb2R1Y2VkIG90aGVyczoNCj4gDQo+IFsgICAgMC43Njc2NzldIC0tLS0tLS0tLS0tLVsgY3V0
IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICAgIDAuNzY3Njg3XSBjb2hlcmVudCBwb29sIG5vdCBp
bml0aWFsaXNlZCENCj4gWyAgICAwLjc2NzcxNF0gV0FSTklORzogQ1BVOiAzIFBJRDogMSBhdCBr
ZXJuZWwvZG1hL3JlbWFwLmM6MTkwDQo+IGRtYV9hbGxvY19mcm9tX3Bvb2wrMHg5NC8weGEwDQo+
IFsgICAgMC43Njc3MThdIE1vZHVsZXMgbGlua2VkIGluOg0KPiBbICAgIDAuNzY3NzI4XSBDUFU6
IDMgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZA0KPiA1LjYuMC1yYzctMDA0NzEt
Zzk3YzMzZjFhZGE1Yy1kaXJ0eSAjNQ0KPiBbICAgIDAuNzY3NzMyXSBIYXJkd2FyZSBuYW1lOiBC
ZWFjb24gRW1iZWRkZWRXb3JrcyBpLk1YOE0gTmFubw0KPiBEZXZlbG9wbWVudCBLaXQgKERUKQ0K
PiBbICAgIDAuNzY3NzM4XSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPKQ0K
PiBbICAgIDAuNzY3NzQ0XSBwYyA6IGRtYV9hbGxvY19mcm9tX3Bvb2wrMHg5NC8weGEwDQo+IFsg
ICAgMC43Njc3NDldIGxyIDogZG1hX2FsbG9jX2Zyb21fcG9vbCsweDk0LzB4YTANCj4gWyAgICAw
Ljc2Nzc1M10gc3AgOiBmZmZmODAwMDEwMDNiYTEwDQo+IFsgICAgMC43Njc3NTZdIHgyOTogZmZm
ZjgwMDAxMDAzYmExMCB4Mjg6IGZmZmYwMDAwN2M4NjgwODANCj4gWyAgICAwLjc2Nzc2Ml0geDI3
OiAwMDAwMDAwZmZmZmZmZmUwIHgyNjogZmZmZjAwMDA3ZmJkZDA4MA0KPiBbICAgIDAuNzY3NzY4
XSB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0OiBmZmZmODAwMDEwMTYxYjNjDQo+IFsgICAgMC43
Njc3NzRdIHgyMzogMDAwMDAwMDAwMDAwMTAwMCB4MjI6IGZmZmYwMDAwN2M4NmJkMzgNCj4gWyAg
ICAwLjc2Nzc4MF0geDIxOiBmZmZmODAwMDExMmJhMDAwIHgyMDogZmZmZjAwMDA3ZjZlZDQxMA0K
PiBbICAgIDAuNzY3Nzg1XSB4MTk6IDAwMDAwMDAwMDAwMDAwMDAgeDE4OiAwMDAwMDAwMDAwMDAw
MDEwDQo+IFsgICAgMC43Njc3OTFdIHgxNzogMDAwMDAwMDAwMDAwNDVlMCB4MTY6IDAwMDAwMDAw
MDAwMDQ1ZDANCj4gWyAgICAwLjc2Nzc5Nl0geDE1OiBmZmZmMDAwMDdmNDcwNDcwIHgxNDogZmZm
ZmZmZmZmZmZmZmZmZg0KPiBbICAgIDAuNzY3ODAyXSB4MTM6IGZmZmY4MDAwOTAwM2I3NzcgeDEy
OiBmZmZmODAwMDEwMDNiNzdmDQo+IFsgICAgMC43Njc4MDddIHgxMTogZmZmZjgwMDAxMThlMTAw
MCB4MTA6IGZmZmY4MDAwMTFhYmM2NTgNCj4gWyAgICAwLjc2NzgxM10geDkgOiAwMDAwMDAwMDAw
MDAwMDAwIHg4IDogNjU3MzY5NmM2MTY5NzQ2OQ0KPiBbICAgIDAuNzY3ODE4XSB4NyA6IDZlNjky
MDc0NmY2ZTIwNmMgeDYgOiAwMDAwMDAwMDAwMDAwMGE5DQo+IFsgICAgMC43Njc4MjRdIHg1IDog
MDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAwLjc2NzgyOV0g
eDMgOiAwMDAwMDAwMGZmZmZmZmZmIHgyIDogZmZmZjgwMDAxMThlMWI4MA0KPiBbICAgIDAuNzY3
ODM1XSB4MSA6IDNhNDQzNzEyNGM1YTZiMDAgeDAgOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAg
MC43Njc4NDBdIENhbGwgdHJhY2U6DQo+IFsgICAgMC43Njc4NDddICBkbWFfYWxsb2NfZnJvbV9w
b29sKzB4OTQvMHhhMA0KPiBbICAgIDAuNzY3ODUzXSAgZG1hX2RpcmVjdF9hbGxvY19wYWdlcysw
eDFhNC8weDFlMA0KPiBbICAgIDAuNzY3ODU4XSAgZG1hX2RpcmVjdF9hbGxvYysweGMvMHgyMA0K
PiBbICAgIDAuNzY3ODYzXSAgZG1hX2FsbG9jX2F0dHJzKzB4N2MvMHhmMA0KPiBbICAgIDAuNzY3
ODcwXSAgc2RtYV9wcm9iZSsweDNkNC8weDdmMA0KPiBbICAgIDAuNzY3ODc3XSAgcGxhdGZvcm1f
ZHJ2X3Byb2JlKzB4NTAvMHhhMA0KPiBbICAgIDAuNzY3ODg1XSAgcmVhbGx5X3Byb2JlKzB4ZDQv
MHgzMjANCj4gWyAgICAwLjc2Nzg5MV0gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg1NC8weGYwDQo+
IFsgICAgMC43Njc4OTddICBkZXZpY2VfZHJpdmVyX2F0dGFjaCsweDZjLzB4ODANCj4gWyAgICAw
Ljc2NzkwM10gIF9fZHJpdmVyX2F0dGFjaCsweDU0LzB4ZDANCj4gWyAgICAwLjc2NzkwOF0gIGJ1
c19mb3JfZWFjaF9kZXYrMHg2Yy8weGMwDQo+IFsgICAgMC43Njc5MTRdICBkcml2ZXJfYXR0YWNo
KzB4MjAvMHgzMA0KPiBbICAgIDAuNzY3OTE5XSAgYnVzX2FkZF9kcml2ZXIrMHgxNDAvMHgxZjAN
Cj4gWyAgICAwLjc2NzkyNV0gIGRyaXZlcl9yZWdpc3RlcisweDYwLzB4MTEwDQo+IFsgICAgMC43
Njc5MzBdICBfX3BsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcisweDQ0LzB4NTANCj4gWyAgICAwLjc2
NzkzOF0gIHNkbWFfZHJpdmVyX2luaXQrMHgxOC8weDIwDQo+IFsgICAgMC43Njc5NDRdICBkb19v
bmVfaW5pdGNhbGwrMHg1MC8weDE5MA0KPiBbICAgIDAuNzY3OTUwXSAga2VybmVsX2luaXRfZnJl
ZWFibGUrMHgxY2MvMHgyM2MNCj4gWyAgICAwLjc2Nzk1OF0gIGtlcm5lbF9pbml0KzB4MTAvMHgx
MDANCj4gWyAgICAwLjc2Nzk2M10gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4DQo+IFsgICAgMC43
Njc5NzJdIC0tLVsgZW5kIHRyYWNlIDc5NmI4ZDk0OWQ5NmY1ZjYgXS0tLQ0KPiANCj4gDQo+IEFu
c29uLA0KPiANCj4gPiBXaGljaCBib2FyZCBkaWQgeW91IHRyeT8gSSBqdXN0IHJ1biBpdCBvbiBp
Lk1YOE1OLUVWSyBib2FyZCwgbm8gc3VjaA0KPiBmYWlsdXJlOg0KPiBJIGhhdmUgYSBib2FyZCBm
cm9tIEJlYWNvbiBFbWJlZGRlZFdvcmtzIGJhc2VkIG9uIHRoZSBpLk1YOE1OIHdoaWNoDQo+IGlz
IG5lYXJseSBpZGVudGljYWwgdG8gdGhlIGkuTVg4TU0gd2hpY2ggZG9lc24ndCBleGhpYml0IGFu
eSBvZiB0aGVzZSBlcnJvcnMuDQo+IA0KPiBJIHRyaWVkIEZhYmlvJ3Mgc3VnZ2VzdGlvbiBvZiBz
d2l0Y2hpbmcgdGhlIHZlcnNpb24gb2YgQVRGIHdoaWNoIGRpZCBmaXggdGhlDQo+IEJsdWV0b290
aCBjb21tdW5pY2F0aW9uIGVycm9ycyBJIHdhcyBnZXR0aW5nLCBidXQgSSBkaWRuJ3Qgc2hvdyB0
aGVtIGJlZm9yZS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIEkgZG9uJ3QgaGF2ZSB0aGUgaS5NWDhN
Ti1FVksgcmlnaHQgbm93LCBJJ20gd29ya2luZyBvbg0KPiB0cnlpbmcgdG8gZ2V0IG9uZS4NCj4g
DQo+IENhbiBJIGFzayB3aGljaCB2ZXJzaW9uIG9mIFUtQm9vdCBhbmQgQVRGIHlvdSdyZSB1c2lu
Zz8gIEkgYW0gd29uZGVyaW5nIGlmIEkNCj4gbmVlZCB0byB1cGRhdGUgc29tZXRoaW5nIGVsc2Uu
DQoNCkkgYW0gdXNpbmcgb3VyIGxhdGVzdCB1LWJvb3QgYW5kIEFURiBpbiBOWFAgaW50ZXJuYWwg
dHJlZSwgbWF5YmUgeW91IGNhbiBnZXQgdGhlDQpsYXRlc3QgcmVsZWFzZSB0byBoYXZlIGEgdHJ5
Lg0KDQpBbnNvbg0K
