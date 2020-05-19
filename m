Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34189C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AB92075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dXHkny3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgESCzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:55:08 -0400
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:55166
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbgESCzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOfP6QPyJQMwOqUqVhkt7J7JHcZCG/FakX4p/wuocbQGWRe7WYOvMIhribLYfKJbzfO7Asbz5BWsXAErLSFuWkTI002y6rMzP82xE/9iaqMKZI0qucmIw660morla2lw1aFCmvBSczh1fIikxaKHtTR2CsmUJP4nSbri095l52saGAHIuFCM9iQydp6yIGmvMfATb5+wmo1Jqa7zgfuJTDzTrbJKd3QMLJb5CwymmfPBRl929WF8ccGxIup1ExgWRa1ponQQVAEiu0KXMT/WqJJhiyaL+vt1nnmkwFDs6RhafgGFs0Hfm3xsItoA/DmjblXpyNmO1cSxuecAULe20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i33KtpjnNfq1RbGjHVQQma49QPXY9IBR5GCgfAsZ3Ms=;
 b=UeIOsPGRGp3UEYCbgxkxWE0wRSdgr9kbWVRCCzkFZnYHHyiu2DOfzDZG0QWYgqApIiU5fvTfC1gmnIX+hGOUUxpJTqxeTE9DNj2yoW4WS04L1o0igowHANtM3NtT0x0aFAi1xXJgOkME1+ioMSV3QpwAZEFMySW3neDL013ecc+jizimORo57cL8c8aFqqL0uq6fvNTu8LZO+DKgKFZtvdgX/g9Apeg6ugZAnQKpTPOQf9J0wAatienG86WsWANQepaNUNMLCzJAOEinSkLyaCHMyUQ/+4nvSPkbaef91kp0QTyYTl0Hz1oTqFAtHF1y1+8iuxC+7t2GaH4Pv/zNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i33KtpjnNfq1RbGjHVQQma49QPXY9IBR5GCgfAsZ3Ms=;
 b=dXHkny3lhJxlx97VMlfITzfkoBcnQqZdPqsGh/7R04cei/SiAyS3Lzug33PV5qIsU+UIynmUzpC+zs2mA8URvSNgftRrnvr0wIHRMy2PCn4Oz0uno55EbccoqZfmPmJ3Braf2/PDyRIes4Qy0IPggzTKgGyKw3vtqGfYPD+4wyk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4150.eurprd04.prod.outlook.com (2603:10a6:209:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:55:02 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:55:01 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Topic: [PATCH V2] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Index: AQHWLPzyLOeUPwdr6kC7CajWkJ7yjqiutw7Q
Date:   Tue, 19 May 2020 02:55:01 +0000
Message-ID: <AM6PR04MB4966CEA2116B3BF13CADE70880B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589796212-9993-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589796212-9993-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc4d6417-e03a-490a-6b15-08d7fba00693
x-ms-traffictypediagnostic: AM6PR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41506EFB42A2B59419D3852680B90@AM6PR04MB4150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUeps2QJKD/bbe108i4Ms7uC8zWGdCP+fbxxiFmvQNBOg+RZ0HuBGiQM0YYdiJB7TVIWy9x3X/Eh7WuFCPB76IKFRjIGwF8imV5B82nWt63hL1lbkh01S15WXYloh9Z7Xc80OR1FQdp4/rGMuD7YhPnWyxyelsSSRQaJOyhkEMCWbZyBW662rX/8nEtWSzLh3YbS7X3A0f4TBoj7N90KE6WhXEgiwuKb6PPbaQssAlr4Ea9G8hIoX+JX0wSvn7STYaFiBYV/2sw+qIibB8nAV6yOn+yH9JNah+IGqhxhIDhkqM95tI7uqJGWHoqYRLyrw7tVaomxtl3QZYJp21gGWoQE2nE7qaxFIVbu6wyezmuHUwhRIJs274wGDhpWhooptl7rzSQWYDH7VkH35JqndgY6qchrS55K9W7nNIKuSVH7DCEqpAEmAF28Z5bi5wb1W34MBc5Xek0NmXg7WnEro6ijZrMauqSoIetibbq9lvw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(316002)(66446008)(110136005)(52536014)(86362001)(9686003)(6506007)(4326008)(8676002)(64756008)(478600001)(71200400001)(186003)(5660300002)(26005)(76116006)(66556008)(66476007)(66946007)(2906002)(44832011)(55016002)(8936002)(7696005)(33656002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: t2DxwYewJWPwa8pRhXqJzPu3/wQexIOyM6HwkFwGVQs0QhyapwVj3adE9A51egEMwAycBWa5CglRK/Yv72mess8U+yZkVo3twWIzhvqxJWnvlh7q37IYBHjL6JWg/pt4HFsImqF1d+BIskVyMBLk4zFHK1r6rYvrY2+DNKgex6Tbzhiq+jKd2PbpUWJ7HPwUbCkm1q29hEKJniZgP6+UBRFzX86lRMBxPWMLboS44Ih8mnemv2E6utefjGb7lihAAIwv2x5VZ0PfgtgbVLozjGpycNBgPPe8XmBY7NeRa4utbI1opglrhF3Op8zK2YIJg4fT8K1bRaDP0FmQM1f9EU2jPbqpR8Y6uo/EAbrwRS9Vo9NkaM/3QXhypM8ODQLHbTG+QuLAuDG3VfXrMhk0AKO62gchWIQox5b8cjNcw7sIsbyCENt95JqbEdeLEp3oAIkXG9SV1f0HoL4xJuSLguEpQ4xQZvBgkGGwm+A2dHBJZ/TiecAsollcrZcweTeM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d6417-e03a-490a-6b15-08d7fba00693
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:55:01.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LioajL3hkRwfBj3tNYCWIOQX7Th9AhYQiYaqXpavxcYevH8pxuRE1rOesdlTWRryZSfDz5XE1Eo6AcwLN7lXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgNjowNCBQTQ0KPiANCj4gQ29udmVydCB0aGUgaS5NWCByZXNldCBiaW5k
aW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5n
ZXMgc2luY2UgVjE6DQo+IAktIGFkZCB0aGUgY29tcGF0aWJsZSBzdHJpbmdzIHBlciBTb0M7DQo+
IAktIHVzZSAicmVzZXQtY29udHJvbGxlciIgYXMgbm9kZSBuYW1lIGluc3RlYWQgb2Ygc3JjOw0K
PiAJLSBhZGQgaW50ZXJydXB0IGl0ZW1zIGRlc2NyaXB0aW9uLg0KPiAtLS0NCj4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dCAgICAgIHwgNDkgLS0tLS0tLS0t
LS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnlhbWwgICAg
IHwgOTgNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5OCBp
bnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkgIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMudHh0DQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jl
c2V0L2ZzbCxpbXgtc3JjLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMudHh0DQo+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4dA0KPiBkZWxldGVkIGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggNmVkNzllNi4uMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMudHh0DQo+ICsrKyAv
ZGV2L251bGwNCj4gQEAgLTEsNDkgKzAsMCBAQA0KPiAtRnJlZXNjYWxlIGkuTVggU3lzdGVtIFJl
c2V0IENvbnRyb2xsZXINCj4gLT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQo+IC0NCj4gLVBsZWFzZSBhbHNvIHJlZmVyIHRvIHJlc2V0LnR4dCBpbiB0aGlzIGRpcmVjdG9y
eSBmb3IgY29tbW9uIHJlc2V0IC1jb250cm9sbGVyDQo+IGJpbmRpbmcgdXNhZ2UuDQo+IC0NCj4g
LVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBiZSAiZnNsLDxj
aGlwPi1zcmMiDQo+IC0tIHJlZzogc2hvdWxkIGJlIHJlZ2lzdGVyIGJhc2UgYW5kIGxlbmd0aCBh
cyBkb2N1bWVudGVkIGluIHRoZQ0KPiAtICBkYXRhc2hlZXQNCj4gLS0gaW50ZXJydXB0czogU2hv
dWxkIGNvbnRhaW4gU1JDIGludGVycnVwdCBhbmQgQ1BVIFdET0cgaW50ZXJydXB0LA0KPiAtICBp
biB0aGlzIG9yZGVyLg0KPiAtLSAjcmVzZXQtY2VsbHM6IDEsIHNlZSBiZWxvdw0KPiAtDQo+IC1l
eGFtcGxlOg0KPiAtDQo+IC1zcmM6IHNyY0AyMGQ4MDAwIHsNCj4gLSAgICAgICAgY29tcGF0aWJs
ZSA9ICJmc2wsaW14NnEtc3JjIjsNCj4gLSAgICAgICAgcmVnID0gPDB4MDIwZDgwMDAgMHg0MDAw
PjsNCj4gLSAgICAgICAgaW50ZXJydXB0cyA9IDwwIDkxIDB4MDQgMCA5NiAweDA0PjsNCj4gLSAg
ICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiAtfTsNCj4gLQ0KPiAtU3BlY2lmeWluZyByZXNl
dCBsaW5lcyBjb25uZWN0ZWQgdG8gSVAgbW9kdWxlcw0KPiAtPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtDQo+IC1UaGUgc3lzdGVtIHJlc2V0IGNvbnRy
b2xsZXIgY2FuIGJlIHVzZWQgdG8gcmVzZXQgdGhlIEdQVSwgVlBVLCAtSVBVLCBhbmQNCj4gT3Bl
blZHIElQIG1vZHVsZXMgb24gaS5NWDUgYW5kIGkuTVg2IElDcy4gVGhvc2UgZGV2aWNlIC1ub2Rl
cyBzaG91bGQNCj4gc3BlY2lmeSB0aGUgcmVzZXQgbGluZSBvbiB0aGUgU1JDIGluIHRoZWlyIHJl
c2V0cyAtcHJvcGVydHksIGNvbnRhaW5pbmcgYSBwaGFuZGxlDQo+IHRvIHRoZSBTUkMgZGV2aWNl
IG5vZGUgYW5kIGEgLVJFU0VUX0lOREVYIHNwZWNpZnlpbmcgd2hpY2ggbW9kdWxlIHRvIHJlc2V0
LA0KPiBhcyBkZXNjcmliZWQgaW4gLXJlc2V0LnR4dA0KPiAtDQo+IC1leGFtcGxlOg0KPiAtDQo+
IC0gICAgICAgIGlwdTE6IGlwdUAyNDAwMDAwIHsNCj4gLSAgICAgICAgICAgICAgICByZXNldHMg
PSA8JnNyYyAyPjsNCj4gLSAgICAgICAgfTsNCj4gLSAgICAgICAgaXB1MjogaXB1QDI4MDAwMDAg
ew0KPiAtICAgICAgICAgICAgICAgIHJlc2V0cyA9IDwmc3JjIDQ+Ow0KPiAtICAgICAgICB9Ow0K
PiAtDQo+IC1UaGUgZm9sbG93aW5nIFJFU0VUX0lOREVYIHZhbHVlcyBhcmUgdmFsaWQgZm9yIGku
TVg1Og0KPiAtR1BVX1JFU0VUICAgICAwDQo+IC1WUFVfUkVTRVQgICAgIDENCj4gLUlQVTFfUkVT
RVQgICAgMg0KPiAtT1BFTl9WR19SRVNFVCAzDQo+IC1UaGUgZm9sbG93aW5nIGFkZGl0aW9uYWwg
UkVTRVRfSU5ERVggdmFsdWUgaXMgdmFsaWQgZm9yIGkuTVg2Og0KPiAtSVBVMl9SRVNFVCAgICA0
DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
ZnNsLGlteC1zcmMueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
ZXNldC9mc2wsaW14LXNyYy55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAuLjdjZDYwOTUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMueWFtbA0KPiBAQCAtMCwwICsxLDk4
IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0y
LUNsYXVzZSkgJVlBTUwgMS4yDQo+ICstLS0NCg0KWy4uLl0NCg0KPiArdGl0bGU6IEZyZWVzY2Fs
ZSBpLk1YIFN5c3RlbSBSZXNldCBDb250cm9sbGVyDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiAr
ICAtIFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+ICsNCj4gK2Rlc2Ny
aXB0aW9uOiB8DQo+ICsgIFRoZSBzeXN0ZW0gcmVzZXQgY29udHJvbGxlciBjYW4gYmUgdXNlZCB0
byByZXNldCB0aGUgR1BVLCBWUFUsDQo+ICsgIElQVSwgYW5kIE9wZW5WRyBJUCBtb2R1bGVzIG9u
IGkuTVg1IGFuZCBpLk1YNiBJQ3MuIFRob3NlIGRldmljZQ0KPiArICBub2RlcyBzaG91bGQgc3Bl
Y2lmeSB0aGUgcmVzZXQgbGluZSBvbiB0aGUgU1JDIGluIHRoZWlyIHJlc2V0cw0KPiArICBwcm9w
ZXJ0eSwgY29udGFpbmluZyBhIHBoYW5kbGUgdG8gdGhlIFNSQyBkZXZpY2Ugbm9kZSBhbmQgYQ0K
PiArICBSRVNFVF9JTkRFWCBzcGVjaWZ5aW5nIHdoaWNoIG1vZHVsZSB0byByZXNldCwgYXMgZGVz
Y3JpYmVkIGluDQo+ICsgIHJlc2V0LnR4dA0KPiArDQo+ICsgIFRoZSBmb2xsb3dpbmcgUkVTRVRf
SU5ERVggdmFsdWVzIGFyZSB2YWxpZCBmb3IgaS5NWDU6DQo+ICsgICAgR1BVX1JFU0VUICAgICAw
DQo+ICsgICAgVlBVX1JFU0VUICAgICAxDQo+ICsgICAgSVBVMV9SRVNFVCAgICAyDQo+ICsgICAg
T1BFTl9WR19SRVNFVCAzDQo+ICsgIFRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBSRVNFVF9JTkRF
WCB2YWx1ZSBpcyB2YWxpZCBmb3IgaS5NWDY6DQo+ICsgICAgSVBVMl9SRVNFVCAgICA0DQo+ICsN
Cj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgb25lT2Y6DQo+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBvbiBpLk1YNTEgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxlIG11c3Qg
YmUgc3BlY2lmaWVkDQoNClVubmVjZXNzYXJ5IGRlc2NyaXB0aW9uDQoNCk90aGVyd2lzZToNCg0K
UmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiAi
ZnNsLGlteDUxLXNyYyINCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDUwIHRo
ZSBmb2xsb3dpbmcgY29tcGF0aWJsZXMgbXVzdCBiZSBzcGVjaWZpZWQNCj4gKyAgICAgICAgaXRl
bXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogImZzbCxpbXg1MC1zcmMiDQo+ICsgICAgICAgICAg
LSBjb25zdDogImZzbCxpbXg1MS1zcmMiDQo+ICsNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IG9u
IGkuTVg1MyB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGVzIG11c3QgYmUgc3BlY2lmaWVkDQo+ICsg
ICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14NTMtc3JjIg0KPiAr
ICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14NTEtc3JjIg0KPiArDQo+ICsgICAgICAtIGRlc2Ny
aXB0aW9uOiBvbiBpLk1YNlEgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxlcyBtdXN0IGJlIHNwZWNp
ZmllZA0KPiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDZx
LXNyYyINCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDUxLXNyYyINCj4gKw0KPiArICAg
ICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDZTWCB0aGUgZm9sbG93aW5nIGNvbXBhdGlibGVzIG11
c3QgYmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6
ICJmc2wsaW14NnN4LXNyYyINCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDUxLXNyYyIN
Cj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDZTTCB0aGUgZm9sbG93aW5nIGNv
bXBhdGlibGVzIG11c3QgYmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAg
ICAgIC0gY29uc3Q6ICJmc2wsaW14NnNsLXNyYyINCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNs
LGlteDUxLXNyYyINCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogb24gaS5NWDZVTCB0aGUg
Zm9sbG93aW5nIGNvbXBhdGlibGVzIG11c3QgYmUgc3BlY2lmaWVkDQo+ICsgICAgICAgIGl0ZW1z
Og0KPiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14NnVsLXNyYyINCj4gKyAgICAgICAgICAt
IGNvbnN0OiAiZnNsLGlteDUxLXNyYyINCj4gKw0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogb24g
aS5NWDZTTEwgdGhlIGZvbGxvd2luZyBjb21wYXRpYmxlcyBtdXN0IGJlIHNwZWNpZmllZA0KPiAr
ICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiAiZnNsLGlteDZzbGwtc3JjIg0K
PiArICAgICAgICAgIC0gY29uc3Q6ICJmc2wsaW14NTEtc3JjIg0KPiArDQo+ICsgIHJlZzoNCj4g
KyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgaXRlbXM6DQo+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBTUkMgaW50ZXJydXB0DQo+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBDUFUgV0RPRyBpbnRlcnJ1cHRzIG91dCBvZiBTUkMNCj4gKyAgICBtaW5JdGVtczogMQ0K
PiArICAgIG1heEl0ZW1zOiAyDQo+ICsNCj4gKyAgJyNyZXNldC1jZWxscyc6DQo+ICsgICAgY29u
c3Q6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0K
PiArICAtIGludGVycnVwdHMNCj4gKyAgLSAnI3Jlc2V0LWNlbGxzJw0KPiArDQo+ICthZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAg
IHJlc2V0LWNvbnRyb2xsZXJANzNmZDAwMDAgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gImZz
bCxpbXg1MS1zcmMiOw0KPiArICAgICAgICByZWcgPSA8MHg3M2ZkMDAwMCAweDQwMDA+Ow0KPiAr
ICAgICAgICBpbnRlcnJ1cHRzID0gPDc1PjsNCj4gKyAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+
Ow0KPiArICAgIH07DQo+IC0tDQo+IDIuNy40DQoNCg==
