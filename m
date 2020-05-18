Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C0E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sg9Vw2UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERDkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 23:40:10 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:6111
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgERDkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 23:40:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYat6euhHKvhj0EMHAZXO4ChZ+PP9o3MYaANJSev1Xr3YOQLoAjZh0N3CxD4yoB5pzNsuonDgGpWHrnyXXmpNqlYYaAv0/NDoMDwwXCP7ZFVpxU953tdqCj/gqhgzEUeaH1eBMM5eeO8zB1nXYZOq7/GIWlwuCRLKHqGQFJ08q3fzwaJVl4+recgX0odms7+/Q6r8gUBKmQo8jYxl9KevJjt7I0fxTE+uL21J81rod0kwykV35Eu1VoB/T1W49G2pKGzb47+PCeXyOrCoNWn6H0/Jgr8+UIxhiZdAwZ0DuA6pfIIE3zrwTxqnOwnfnElpGCtPuGLNobAiafoSnE2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk1ry5zby0UwOpfdEmaZiqzG0Dze+afJvgkUU7IX748=;
 b=JHyLFeXW/wGDX0PeMvpKFWU/xPF2tnDBcfey4R2aHXdGDIYdJDECyWYdm8WZMvo3f07v1P8XWbDh2VqnbSqBpH3NyVBkU/QmcsgZLgR1eKU6DlZ8Mqa6vzxdDa+5/ow9L1JUJP9uJ2Qh/wGZ7kBI/Z6C6sqpZ+6hDyQFcB2tERg3sovQ+Sn60OYpIyHUlPYaIouxBqlbQ/6DgXdM9nLXkJmnMrn17kF4gqCn8nj94+wf+wOT4QXOwIz9RQsVjKz8fSaI6f4oIE68KeNqe7CGoR2RbWFylShiEPRdkX/fEigcLBsz5vC3vjVn6wzAypvAqrwycr+DPKWsnvAm40nIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk1ry5zby0UwOpfdEmaZiqzG0Dze+afJvgkUU7IX748=;
 b=sg9Vw2UPhy6X/StxSjHHddQOfaw4s6B0zGzoEWEHtyvaAUFZQa7MHmJPUaYe862mwt+/9O5TmbF3BJ7xDwlCG1zn8ym04Em0YsXwj1u8WqiPpd441XaVFsD2Qlc+L6BVyDIFDWB6H1xZ9eAEDfo7GGmeqUDgx++3a+vklB+N6rA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6295.eurprd04.prod.outlook.com (2603:10a6:20b:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 03:40:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 03:40:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Index: AQHWLLrj2zkAZPZ1ZEqhceYmXEBXFqitMkdA
Date:   Mon, 18 May 2020 03:40:04 +0000
Message-ID: <AM6PR04MB4966C2A615086069F9C05B7780B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589767841-4213-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589767841-4213-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59e6db78-7216-4df4-c522-08d7fadd2767
x-ms-traffictypediagnostic: AM6PR04MB6295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB62959B03B839AD5E6B29490480B80@AM6PR04MB6295.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgvR1SHyx9a81V4q5rkcVZ1HFXtmqIKvlclm8mAlVW1/zf/pyvbokdihUS3/YAQKsJnfj/avdZFYS0CpMutuqnV2GaJI+m0muqxbo3sDlMfyr/MMPBNWe/n85tmbYO5RpOk9GzrrRcWHqH1aoK1oKtThfdfN9oTj0ReC7PcoUiem4BalGq4DJLvWMoRecvHcIdXAht3YWsbQSnnbc/P6gyx4M6P0ysplDr0sdq6mYBy4n70BqJ57NUL+4idIfJoYs+uRWZHCgcRzNMqxGrLyY36RysQauvqBV7OyfoKit5163DZg7XIvnESlILOd1LSy/yYrxat/LOGUX5j6FWDt/7sLItINEumCOalF6BjtZw+HcPENViwaprEAcHM4DEvSBuNztJmmVkqlGilY5QwOYwfVbR0884hlH2jRVfkCGe2ATgrn+3WEIx1fuq8d5EGx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(71200400001)(86362001)(2906002)(76116006)(4326008)(52536014)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(26005)(110136005)(6506007)(186003)(44832011)(55016002)(7696005)(9686003)(5660300002)(478600001)(33656002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: arLTCrX9K+CCkXTBWOeSQ8cnmFe3/DSFpQkqxAN/Iqq8whQZ/iMt6n2tPFqhEqh4qGVYS/Yb7ta/oDQUdzKlzB2a6POI8hsOOAMMSN6ZtNtOCRLPSUXE+uhdpl3hoXx4ydptn3EX5+fMxgNC0ce3+zxIxPEpXbAYZdv3MMW2oonN9cUytPf6p8mlemzZCVduOzfuzkADKGsWTZxZsYfuOjBI0xyC4rQFeK0zOwOVb00d6lTiN/TzZeLycl2Fsij0gKGYcGkgPi6/J3V4tJE12MSpoIxerp0mNsZ6rZQdza+tuUb+1oxEVe482t8u/xlymfPAlJf1yCNh95Onqo5gfq8W5oSvxwfLsWxas/ycp8CPx+dk3IeHaRvHHJqPLzjSJPH6cTowpbTCosyYHhs/ty83GOI3GQKdiPccXlvFBLjZYqLp9Tp9UflGWScue4ICNUhfS/GgZD/ApiQyTaN26RLpalyQILFC0tmX+fO0fYc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6db78-7216-4df4-c522-08d7fadd2767
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 03:40:04.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnTZ4dPt54j3iZBLa/nIphWmcALIxD/66RcTaY70DkSY1Am81gp5li8uj1UAxN87OW0FFVqU0gNSufclogKEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ICsNCj4gK3RpdGxlOiBGcmVlc2NhbGUgSVJRU1RFRVIgSW50ZXJydXB0IG11bHRpcGxl
eGVyDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiAr
ICAgIGNvbnN0OiBmc2wsaW14LWlycXN0ZWVyDQoNCllvdSBjaGFuZ2VkIGJpbmRpbmcgaGVyZSB3
aXRob3V0IGNvbW1lbnRzPw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gKw0KPiArICByZWc6DQo+
ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiArICAgIGRlc2NyaXB0
aW9uOiB8DQo+ICsgICAgICBzaG91bGQgY29udGFpbiB0aGUgdXAgdG8gOCBwYXJlbnQgaW50ZXJy
dXB0IGxpbmVzIHVzZWQgdG8gbXVsdGlwbGV4DQo+ICsgICAgICB0aGUgaW5wdXQgaW50ZXJydXB0
cy4gVGhleSBzaG91bGQgYmUgc3BlY2lmaWVkIHNlcXVlbnRpYWxseSBmcm9tDQo+ICsgICAgICBv
dXRwdXQgMCB0byA3Lg0KPiArICAgIGl0ZW1zOg0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogaXJx
c3RlZXIgY2hhbm5lbCAwDQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBpcnFzdGVlciBjaGFubmVs
IDENCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IGlycXN0ZWVyIGNoYW5uZWwgMg0KPiArICAgICAg
LSBkZXNjcmlwdGlvbjogaXJxc3RlZXIgY2hhbm5lbCAzDQo+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBpcnFzdGVlciBjaGFubmVsIDQNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IGlycXN0ZWVyIGNo
YW5uZWwgNQ0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogaXJxc3RlZXIgY2hhbm5lbCA2DQo+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBpcnFzdGVlciBjaGFubmVsIDcNCj4gKyAgICBtaW5JdGVtczog
MQ0KPiArICAgIG1heEl0ZW1zOiA4DQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1z
OiAxDQo+ICsNCj4gKyAgY2xvY2stbmFtZXM6DQo+ICsgICAgY29uc3Q6IGlwZw0KPiArDQo+ICsg
IGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQo+ICsNCj4gKyAgIiNpbnRlcnJ1cHQtY2VsbHMi
Og0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4gKyAgZnNsLGNoYW5uZWw6DQo+ICsgICAgJHJlZjog
Jy9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMicNCj4gKyAgICBkZXNjcmlw
dGlvbjogfA0KPiArICAgICAgdTMyIHZhbHVlIHJlcHJlc2VudGluZyB0aGUgb3V0cHV0IGNoYW5u
ZWwgdGhhdCBhbGwgaW5wdXQgSVJRcyBzaG91bGQgYmUNCj4gKyAgICAgIHN0ZWVyZWQgaW50by4N
Cj4gKw0KPiArICBmc2wsbnVtLWlycXM6DQo+ICsgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3VpbnQzMicNCj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiArICAgICAg
dTMyIHZhbHVlIHJlcHJlc2VudGluZyB0aGUgbnVtYmVyIG9mIGlucHV0IGludGVycnVwdHMgb2Yg
dGhpcyBjaGFubmVsLA0KPiArICAgICAgc2hvdWxkIGJlIG11bHRpcGxlIG9mIDMyIGlucHV0IGlu
dGVycnVwdHMgYW5kIHVwIHRvIDUxMiBpbnRlcnJ1cHRzLg0KPiArDQo+ICtyZXF1aXJlZDoNCj4g
KyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIGNs
b2Nrcw0KPiArICAtIGNsb2NrLW5hbWVzDQo+ICsgIC0gaW50ZXJydXB0LWNvbnRyb2xsZXINCj4g
KyAgLSAiI2ludGVycnVwdC1jZWxscyINCj4gKyAgLSBmc2wsY2hhbm5lbA0KPiArICAtIGZzbCxu
dW0taXJxcw0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhh
bXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9pbXg4
bXEtY2xvY2suaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvYXJtLWdpYy5oPg0KPiArDQo+ICsgICAgaW50ZXJydXB0LWNvbnRyb2xsZXJAMzJlMmQw
MDAgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXgtaXJxc3RlZXIiOw0KPiArICAg
ICAgICByZWcgPSA8MHgzMmUyZDAwMCAweDEwMDA+Ow0KPiArICAgICAgICBpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgMTggSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsgICAgICAgIGNsb2NrcyA9IDwm
Y2xrIElNWDhNUV9DTEtfRElTUF9BUEJfUk9PVD47DQo+ICsgICAgICAgIGNsb2NrLW5hbWVzID0g
ImlwZyI7DQo+ICsgICAgICAgIGZzbCxjaGFubmVsID0gPDA+Ow0KPiArICAgICAgICBmc2wsbnVt
LWlycXMgPSA8NjQ+Ow0KPiArICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gKyAgICAg
ICAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjcuNA0KDQo=
