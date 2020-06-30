Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2F720759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OYkCJmI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgF3GhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:37:11 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:17574
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730002AbgF3GhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ueqb1EBnlRso4LRfF9kFo7w9lQ99UZv4HC/0v2inqUrG0xUsA563wISgtG2rf/i5B99wfu1Ro9qpgyK90UHLk5VUHsukxMeUe3LLp30Ozw3VmLPXV+r8b42MqeU2THxq56IiRRTcpJAVgkp9tM/M4j5ZCqgiPC67sJ5R+PllF6HJpwHmdqQ1NclTXeSJcOz3i3PPsx+3qvcG2vCplqmoMWCXZ7O8t/tC7LLms4iiI7KIqEoVYIG5bZu4PTRYMtNN8AqGxRd+auOy1LHD2HGHZ59Zm5y1ZrhhZv2WKWadzaujcdfbLPJKUy9HMrrdgdVRN9FjtydRzhqf3M0svSWG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXJcAnhMPgE6kmOfqMNeRkFK62ZhiLQ6oBkIhRQj4xo=;
 b=ZlIIH3Rs9IvShhbzA9Teer7ZKg4cAMOzMPkhJYsDcxNjT6O3cLz0fuFIliW0Ds32vYMeZN7ycK/boxC0w2IJOm11K1BMpZJ2N/6iyoIpLbG/s/GwkHfl2hAgWNi+AiS0RlXVTqGRSbjt5QDJco8PiGGX4edGIw9ET/jR7BADlylCUlk5VZY17gpv85Gt8LQ29bNNkJCmRYS1W/VHzHSp7F+TvBmJcCv+Nqu82cBFSBI6TSHzcnGKJwop96E07U91XHhNNrr+1rq/00kFOCJ3u2RxhmhsX0LuYv2Dtb+reWrDAp1Mpu/+LUcR7cvfNOYvSrBN2vnwyXi2iNRizIdkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXJcAnhMPgE6kmOfqMNeRkFK62ZhiLQ6oBkIhRQj4xo=;
 b=OYkCJmI2J3eaJjonuLS5q/tPY1sPGy8VzizWshMQeXbkxG4a7rBuQBJIGPqfy+mzsRCQ5LQqLB/dZ2zNcue2Hv75qr3PDrnxNL6qSmf5MzOvlWB/3Q1DyJ1zUYwtbp9vjNAZ3vMLqZmzUXpchLRM1kXhL5gVT4NPdIUPGa6vww4=
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 06:37:05 +0000
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::c11b:3254:dd7b:66d]) by DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::c11b:3254:dd7b:66d%7]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 06:37:05 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone
 support
Thread-Topic: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone
 support
Thread-Index: AQHWTo44S8AorskBBEKeL2bS3reQjqjwnPGAgAAC6hCAAAP3AIAAAtig
Date:   Tue, 30 Jun 2020 06:37:05 +0000
Message-ID: <DBBPR04MB60907EC06EAABC949DD42E3EF36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
References: <20200630032014.22956-1-andy.tang@nxp.com>
 <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
 <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com>
In-Reply-To: <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b74bd3e-c1cd-4c69-641c-08d81cc00154
x-ms-traffictypediagnostic: DB8PR04MB6652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB665232B58B0EFAC88D9C42B5F36F0@DB8PR04MB6652.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q40xftcWse8+L3mvSog8BKMcGQdBylzb0HqUGBZ4MbhhXRPJs6m6CNyEjSPryQ/mINQOX0PQ9ZpXkfq79Y1IQfUOaCsJ9qT4l+bmsk5uV3JKUN4PNaqQ39o7h1w7X9VLWHraY/mVsKnMWxlq3S3j2DpMxrvdvnWv5wGiOrZbHO0rKsVPiBYik3wl2r+wSj9yf3ofVwz73N+4ZJ19FQYA1gW4oqSPN4NcWfnxkpvwi7BnOw3hNuh9HZjv+vxZBMXGfZLlm68iTeT54uPHbotp8LzO7XbvCUpbUCZJtuGM4/m71Vr9eHyxw1fbFzH2pU/A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6090.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(71200400001)(4326008)(2906002)(9686003)(55016002)(52536014)(54906003)(86362001)(33656002)(316002)(8676002)(478600001)(83380400001)(76116006)(5660300002)(8936002)(186003)(53546011)(6506007)(7696005)(26005)(66476007)(66556008)(66446008)(66946007)(64756008)(44832011)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ytgu8nZXpXLv7lCubAQeVIxFLHW9Cil50uQDYW2fxTbrmWwoOS2Qn/4k9tdgJAPaTFy6VZvfdLiFSOIEPrlENrhHdWDdF9MqPq2KLdFfpVa9mNyl/Rb+8+14xrBPoDfhPrnnjSBN9CSfTxIgF/l0gi/DdUwnKek9IubIcqLsLLt6+Vpmj53pCVj66Gb5xGmrS+oVcz5lMDi8IcZMjI/zMUN3A8DfRMFdciE7i+mW9a0/cd5EoMIyRNY8zww4BKEl/kaOMh9qrgZZgOOQE3CKKUktq/HQGk3i8FZI2uJL62gVG3aaoLLwQ1wP6OW7bMPwo9GKf4QnFiWfqsz9Y3zJl+5LBUECQyLCJreDD3pHAvmPJ0jiyVXv+RwFY6TUpR1DhJdAzWorr20p1WSE8LTA5TtO2fnoyo8YyOyYPMwKyNwu1oixkunQKASAHfENFdYs6/tyeDa0fZHk3AnqWxx1Vb+zZmrzgKm+x1gBVMa8dRw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6090.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b74bd3e-c1cd-4c69-641c-08d81cc00154
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:37:05.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFCV283JoktaOOeu3+ECBbivYLENVVDzVy6Dub7ciHMGWc+amhzKsrZ3hASxIO3aJjgI2ItFOJAIaXaCA5OOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW1pdCBLdWNoZXJpYSA8
YW1pdC5rdWNoZXJpYUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIw5bm0NuaciDMw5pelIDEzOjM3
DQo+IFRvOiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBSb2INCj4g
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgbGFrbWwgPGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZz47DQo+IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVO
RUQgREVWSUNFIFRSRUUgQklORElOR1MNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsg
TEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtFWFRd
IFJlOiBbUEFUQ0ggMS8yXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgbW9yZSB0aGVybWFsDQo+
IHpvbmUgc3VwcG9ydA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUdWUsIEp1
biAzMCwgMjAyMCBhdCAxMDo1OCBBTSBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPiB3cm90
ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+DQo+ID4gPiBT
ZW50OiAyMDIw5bm0NuaciDMw5pelIDEzOjEyDQo+ID4gPiBUbzogQW5keSBUYW5nIDxhbmR5LnRh
bmdAbnhwLmNvbT4NCj4gPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+ID4gPiBSb2IgSGVycmluZyA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgbGFrbWwNCj4gPiA+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc+Ow0KPiA+ID4gb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJ
Q0UgVFJFRSBCSU5ESU5HUw0KPiA+ID4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTEtN
TCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggMS8yXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgbW9yZSB0aGVybWFsDQo+ID4g
PiB6b25lIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+
ID4gPiBPbiBUdWUsIEp1biAzMCwgMjAyMCBhdCA4OjU2IEFNIDxhbmR5LnRhbmdAbnhwLmNvbT4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IFl1YW50aWFuIFRhbmcgPGFuZHkudGFuZ0Bu
eHAuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBhcmUgMiB0aGVybWFsIHpvbmVzIGluIGxz
MTA4OGEgc29jLiBBZGQgdGhlIG90aGVyIHRoZXJtYWwNCj4gPiA+ID4gem9uZSBub2RlIHRvIGVu
YWJsZSBpdC4NCj4gPiA+ID4gQWxzbyB1cGRhdGUgdGhlIHZhbHVlcyBpbiBjYWxpYnJhdGlvbiB0
YWJsZSB0byBtYWtlIHRoZQ0KPiA+ID4gPiB0ZW1wZXJhdHVyZXMgbW9uaXRvcmVkIG1vcmUgcHJl
Y2lzZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVhbnRpYW4gVGFuZyA8YW5k
eS50YW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHMxMDg4YS5kdHNpIHwgMTAwDQo+ID4gPiA+ICsrKysrKysrKysrLS0t
LS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDM4IGRlbGV0
aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiA+ID4gaW5kZXggMzZhNzk5NTU0NjIw
Li5jY2JiYzIzZTZjODUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwODhhLmR0c2kNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+ID4gPiBAQCAtMTI5LDE5ICsxMjks
MTkgQEANCj4gPiA+ID4gICAgICAgICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHRoZXJt
YWwtem9uZXMgew0KPiA+ID4gPiAtICAgICAgICAgICAgICAgY3B1X3RoZXJtYWw6IGNwdS10aGVy
bWFsIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGNvcmUtY2x1c3RlciB7DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcG9sbGluZy1kZWxheSA9IDw1MDAwPjsNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbC1zZW5zb3JzID0gPCZ0bXUgMD47
DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRyaXBzIHsNCj4gPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfYWxlcnQ6IGNwdS1hbGVydCB7
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29yZV9jbHVzdGVyX2Fs
ZXJ0Og0KPiA+ID4gY29yZS1jbHVzdGVyLWFsZXJ0DQo+ID4gPiA+ICsgew0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGVtcGVyYXR1cmUgPQ0KPiA8ODUw
MDA+Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHlz
dGVyZXNpcyA9IDwyMDAwPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHR5cGUgPSAicGFzc2l2ZSI7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjcHVfY3JpdDogY3B1LWNyaXQgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvcmVfY2x1c3Rlcl9jcml0Og0KPiA+ID4gPiArIGNvcmUtY2x1c3Rlci1j
cml0IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRl
bXBlcmF0dXJlID0NCj4gPDk1MDAwPjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlID0gImNyaXRpY2FsIjsgQEANCj4gPiA+
IC0xNTAsNw0KPiA+ID4gPiArMTUwLDcgQEANCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgY29vbGluZy1tYXBzIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtYXAwIHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRyaXAgPSA8JmNwdV9hbGVydD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0cmlwID0NCj4gPiA+IDwmY29yZV9jbHVzdGVyX2FsZXJ0
PjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvb2xp
bmctZGV2aWNlID0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZjcHUwDQo+ID4gPiBUSEVSTUFMX05PX0xJTUlUIFRIRVJNQUxfTk9fTElN
SVQ+LA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8JmNwdTENCj4gPiA+ID4gVEhFUk1BTF9OT19MSU1JVCBUSEVSTUFMX05PX0xJTUlUPiwg
QEAgLTE2Myw2ICsxNjMsMjYgQEANCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB9Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgc29jIHsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcG9sbGluZy1kZWxheS1wYXNzaXZlID0g
PDEwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBwb2xsaW5nLWRlbGF5ID0g
PDUwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB0aGVybWFsLXNlbnNvcnMg
PSA8JnRtdSAxPjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB0
cmlwcyB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc29jLWFsZXJ0
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRlbXBl
cmF0dXJlID0NCj4gPDg1MDAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlID0gInBhc3NpdmUiOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzb2MtY3JpdCB7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJhdHVyZSA9DQo+IDw5NTAwMD47DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoeXN0ZXJlc2lz
ID0gPDIwMDA+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHlwZSA9ICJjcml0aWNhbCI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gWW91IHNob3VsZCBhbHNvIGFkZCBhIGNvb2xp
bmctbWFwcyBzZWN0aW9uIGZvciB0aGlzIHRoZXJtYWwgem9uZQ0KPiA+ID4gZ2l2ZW4gdGhhdCBp
dCBoYXMgYSBwYXNzaXZlIHRyaXAgdHlwZS4gT3RoZXJ3aXNlIHRoZXJlIGlzIG5vIHVzZSBmb3Ig
YQ0KPiBwYXNzaXZlIHRyaXAgdHlwZS4NCj4gPiBJdCBpcyBiZXR0ZXIgdG8gaGF2ZSBhIGNvb2xp
bmcgZGV2aWNlLiBCdXQgdGhlcmUgaXMgb25seSBvbmUgY29vbGluZw0KPiA+IGRldmljZSBvbiB0
aGlzIHBsYXRmb3JtIHdoaWNoIGlzIHVzZWQgYnkgY29yZS1jbHVzdGVyLiBTbyB0aGVyZSBpcyBu
byBleHRyYQ0KPiBjb29saW5nIGRldmljZSBmb3IgaXQuDQo+ID4gVGhpcyB6b25lIGNhbiB0YWtl
IGFjdGlvbiB3aGVuIGNyaXRpY2FsIHRlbXAgaXMgcmVhY2hlZC4gU28gaXQgaXMgc3RpbGwgdXNl
ZnVsLg0KPiA+IFdoYXQgZG8geW91IHN1Z2dlc3Q/DQo+IA0KPiBJZiB0aGUgYWN0aW9uIHRha2Vu
IGJ5IHRoZSBjb3JlLWNsdXN0ZXIgY29vbGluZy1tYXBzIGlzIHRoZSBvbmx5IG9uZSB0aGF0IGNh
bg0KPiBiZSB0YWtlbiwgSSBzdWdnZXN0IGdldHRpbmcgcmlkIG9mIHRoZSB0aGUgc29jLWFsZXJ0
IHBhc3NpdmUgdHJpcCBjb21wbGV0ZWx5LiBJdCBpcw0KPiBub3Qgb2YgYW55IHVzZS4NCj4gDQo+
IElmIHRoZXJlIGlzIGEgY2hhbmNlIHRoYXQgeW91ciBzb2MgdGhlcm1hbC16b25lIGNhbiBoZWF0
IHVwIGJlZm9yZSB5b3VyDQo+IGNwdS1jbHVzdGVyIHpvbmUgKHVubGlrZWx5KSwgeW91IGNvdWxk
IHVzZSB0aGUgc2FtZSBjb29saW5nIGRldmljZSAoY3B1MCwgY3B1MSkNCj4gZm9yIHNvYyB0aGVy
bWFsIHpvbmUgdG9vLg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpJIHdhcyB0b2xkIHRo
YXQgYSBjb29saW5nLW1hcHMgY2FuIG5vdCBiZSBhcHBsaWVkIHRvIG1vcmUgdGhhbiBvbmUgdGhl
cm1hbCB6b25lLg0KU28gdGhlIG9ubHkgb3B0aW9uIGlzIHRvIHJlbW92ZSB0aGUgYWxlcnQgdHJp
cC4NCg0KQlIsDQpBbmR5DQo=
