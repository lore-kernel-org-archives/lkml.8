Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA7EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87486207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZYkIz2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgESCB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:01:29 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:21477
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgESCB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:01:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE0BcQFelQy6mMJTzdV1XF1TrmTbOb0Oi1XinuwaEgasrQQskxYAVHl0Thb2RSjgYZ+1rfc4wx5KFhpDQg8FIxJcD3bonpHLz45XdDVzrGKr6tLIrapzCZup8H7XazazpT2Ci/T1xlh8IluYCUhhHKQoT1RFQ7VBp2bxdmjhurv0aH+RUuXp2kJhyCn1JQpSpFqpI1k0g+R15qqpTXIpDcd+Oz0oOPcKLtWh2JR4Pg8kfJG623FrAKwSiSpyLa7Pezz/uTcc6jQHIkR9FoGMyVYNv+gWFmc5EH87ZiS8qPzXJHTMZf/8uzeV9oN4IYpYRJfd9+DI87QBQxU/MG/3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdV8M/+9nJ/DKyTSl51mD5TjbrmlmYR5xJ6D3RV8Y8Q=;
 b=KoZoddfXH1HjtESDmtl78VHjxdEx0GG/l9B/YbocY/Br30yKcb4ICms7zWiuXRYpxfaO9s59e4U2bMGShBR1KFMwXBwp7lafVkVE31cotYwDqWQHBx0jdkQRQHokjZxwZwcXE496rlIuEsL8sgpjgCNIQkzaB2FZq/0y6nCQNit/yzO72M+oTqGI1w3+3V7ewiFbNCVJvsDRVcCvL69zNvOyeaQN9+uqihhrcIEktG4RaEYbraIRd6SeySUZjGVKud8mT0uz3zZAi6MAK6wj9x7QZx6K6wJrnbVovyTpBz193+RmnkGEpHPWPMA29RfUCaqWB5Zbmv6n80t3Lc7xng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdV8M/+9nJ/DKyTSl51mD5TjbrmlmYR5xJ6D3RV8Y8Q=;
 b=FZYkIz2obkLaHx+7L4SCMWqTZRm3BzGL1rJRiSCLWniUeLL96YejG5kD2qAhrXb0j2UCM18BgeD8DY6bsaDsPrFJy2EFSMqLsz+aSp/xp4TR4O89NexyrCDy9+yp7dVbEuAMxLDD875zk6R8I4aXYFHCvwqwdhnoACTrSo0u3pk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4822.eurprd04.prod.outlook.com (2603:10a6:20b:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:01:24 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:01:24 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to
 json-schema
Thread-Topic: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to
 json-schema
Thread-Index: AQHWLSVUC1m6aDt3DEWO3yA5A/5NBKiup4HQ
Date:   Tue, 19 May 2020 02:01:24 +0000
Message-ID: <AM6PR04MB4966B101D3E0A0820FAD4CDC80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e7eeda6-bf0d-4eae-43d5-08d7fb9888b5
x-ms-traffictypediagnostic: AM6PR04MB4822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4822F6E9775E7587D51146BF80B90@AM6PR04MB4822.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjUQWykxSxxD4BO63L4bsiH992A3L0t47NXbtnBc/NHPECRRl/5vXL+BYQBLFh6y5zy78w8Gyu8h76+/JlSRPGEYMbnkidjvQk707IQRJMr6MJwuPPvtBL3ldCAmf0PzsdBIxJNaCpyPkFHJtMZsLgFRPXiDo6x1ov9L7SPDsag5MbbV9b8YLABvHKXKycjpE2maRAJ3I9LKT2AnIJ+7Fatlcwa4iCjkfY6wOhBEvfUtNxYv59lRVXbq/FNDmYKjKhISxsDKZBo4cy/Opg6G6voLGn+oKpqSyCgnz6sz7Tfztf2bWjE1r3/dLhrpqVxVf4j0f+qbCqoEeOsFQzAEl2FTrKTjh9QbgoICqWTw6XpHCMHVyslmk6nQUoZFj/ZIdE4DPF1HZKxwfZC2m+HS+VPu9Qxrcl4kj/toyKtJkt8O/hoKCZxC0dwgH9JDPir+W0OgAzoAgae632Tbtpd4J1FbYpRLP6eJd1HZAdn9FsI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(186003)(26005)(44832011)(8936002)(2906002)(33656002)(6506007)(7416002)(110136005)(7696005)(71200400001)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(4326008)(86362001)(5660300002)(76116006)(52536014)(55016002)(9686003)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2Bvjewa6TUqibkfpwpZEIzZLYDEO/A4kixukXmCGbVTj3hULkwXia5EdrT02R09codQo5tbwD2PV6Bs/DvZkk6qkNZJAHZcjHKXQbN1S9K9TdLmNtSvmewRwznjgjEeq2hlak8SkZDxgI7eMktdFnn+iAbCl8ZRvD5X/XzqUzCJxEMIDwGY7bMZjdIeKa2OLaspqDVWs9UmkXSoQknRb+LVgb8oBTBwjpm3O7+yEklgbNOo6gebncosL8zq6kfmtilqud3IXrsR1UKacNGXdbBSSyVahEP5uZ+lxcUh7cXPrskUcT9JhLA1Ff7bn/PjomZenCtWRL+pZ5iDnR9JR94i4jbz9y6raqM7zrGYl7+wZEaGGmk5OOLigEMu8tVazSgBThet0ziHf3jSOCddAng7Yqmd2gtGZLTcC73uU3rQp8Hf9grWqQ8Y7o2qfqjkZyz3XRZLdPHd5+MLNOdLogJt7vUFM1Q7+E4ap5E5pxdtF+I+BU7BK5vVxtGORvkhf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7eeda6-bf0d-4eae-43d5-08d7fb9888b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:01:24.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8S96C7WHvDEMNp4Ofhkf1CWkAco82ksxPPLgJ04PYIL5GVtpUxcp2QK9E8/Jrbc8jVLUVjBakTFpOEQaIfCOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMTA6NTMgUE0NCj4gDQo+IENvbnZlcnQgdGhlIGkuTVg3RCBjbG9jayBi
aW5kaW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENo
YW5nZXMgc2luY2UgVjE6DQo+IAktIFVwZGF0ZSBtYWludGFpbmVyJ3MgZS1tYWlsIGFkZHJlc3Mu
DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14N2QtY2xvY2sudHh0
ICAgICAgfCAxMyAtLS0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14N2Qt
Y2xvY2sueWFtbCAgICAgfCA2NA0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUg
MTAwNjQ0DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3ZC1j
bG9jay50eHQNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svaW14N2QtY2xvY2sueWFtbA0KPiANCj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3ZC1jbG9jay50eHQNCj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14N2QtY2xvY2sudHh0
DQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCA5ZDMwMjZkLi4wMDAwMDAwDQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3ZC1jbG9j
ay50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwxMyArMCwwIEBADQo+IC0qIENsb2NrIGJp
bmRpbmdzIGZvciBGcmVlc2NhbGUgaS5NWDcgRHVhbA0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiAtLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgImZzbCxpbXg3ZC1jY20iDQo+IC0tIHJl
ZzogQWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQNCj4gLS0gI2Nsb2NrLWNl
bGxzOiBTaG91bGQgYmUgPDE+DQo+IC0tIGNsb2NrczogbGlzdCBvZiBjbG9jayBzcGVjaWZpZXJz
LCBtdXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggcmVxdWlyZWQNCj4gLSAgZW50cnkgaW4g
Y2xvY2stbmFtZXMNCj4gLS0gY2xvY2stbmFtZXM6IHNob3VsZCBpbmNsdWRlIGVudHJpZXMgImNr
aWwiLCAib3NjIg0KPiAtDQo+IC1UaGUgY2xvY2sgY29uc3VtZXIgc2hvdWxkIHNwZWNpZnkgdGhl
IGRlc2lyZWQgY2xvY2sgYnkgaGF2aW5nIHRoZSBjbG9jayAtSUQgaW4NCj4gaXRzICJjbG9ja3Mi
IHBoYW5kbGUgY2VsbC4gIFNlZSBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDdkLWNsb2Nr
LmgNCj4gLWZvciB0aGUgZnVsbCBsaXN0IG9mIGkuTVg3IER1YWwgY2xvY2sgSURzLg0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDdkLWNs
b2NrLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14
N2QtY2xvY2sueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi44
Y2QwNTczDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Nsb2NrL2lteDdkLWNsb2NrLnlhbWwNCj4gQEAgLTAsMCArMSw2NCBAQA0KPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2Up
ICVZQU1MIDEuMg0KPiArLS0tDQo+ICsNCj4gK3RpdGxlOiBDbG9jayBiaW5kaW5ncyBmb3IgRnJl
ZXNjYWxlIGkuTVg3IER1YWwNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gRnJhbmsgTGkg
PEZyYW5rLkxpQG54cC5jb20+DQo+ICsgIC0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+ICsgIFRoZSBjbG9jayBjb25zdW1lciBzaG91
bGQgc3BlY2lmeSB0aGUgZGVzaXJlZCBjbG9jayBieSBoYXZpbmcgdGhlDQo+ICtjbG9jaw0KPiAr
ICBJRCBpbiBpdHMgImNsb2NrcyIgcGhhbmRsZSBjZWxsLiBTZWUNCj4gK2luY2x1ZGUvZHQtYmlu
ZGluZ3MvY2xvY2svaW14N2QtY2xvY2suaA0KPiArICBmb3IgdGhlIGZ1bGwgbGlzdCBvZiBpLk1Y
NyBEdWFsIGNsb2NrIElEcy4NCj4gKw0KPiArcHJvcGVydGllczoNCj4gKyAgY29tcGF0aWJsZToN
Cj4gKyAgICBjb25zdDogZnNsLGlteDdkLWNjbQ0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJ
dGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdHM6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBDQ00gaW50ZXJydXB0IHJlcXVlc3QgMQ0KPiArICAgICAgLSBkZXNjcmlw
dGlvbjogQ0NNIGludGVycnVwdCByZXF1ZXN0IDINCg0KRG8gd2UgaGF2ZSBhIG1vcmUgc3BlY2lm
aWMgZGVzY3JpcHRpb24gZnJvbSBSTT8NCk90aGVyd2lzZSwgSSdtIGZpbmUgd2l0aCB0aGlzIHBh
dGNoLg0KDQo+ICsgICAgbWF4SXRlbXM6IDINCj4gKw0KPiArICAnI2Nsb2NrLWNlbGxzJzoNCj4g
KyAgICBjb25zdDogMQ0KPiArDQo+ICsgIGNsb2NrczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAg
IC0gZGVzY3JpcHRpb246IDMyayBvc2MNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IDI0bSBvc2MN
Cj4gKw0KPiArICBjbG9jay1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6
IGNraWwNCj4gKyAgICAgIC0gY29uc3Q6IG9zYw0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBj
b21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIGNsb2Nrcw0K
PiArICAtIGNsb2NrLW5hbWVzDQo+ICsgIC0gJyNjbG9jay1jZWxscycNCj4gKw0KPiArZXhhbXBs
ZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsNCj4gKyAgICBjbG9jay1jb250cm9sbGVyQDMwMzgwMDAw
IHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14N2QtY2NtIjsNCj4gKyAgICAgICAg
cmVnID0gPDB4MzAzODAwMDAgMHgxMDAwMD47DQo+ICsgICAgICAgIGludGVycnVwdHMgPSA8R0lD
X1NQSSA4NSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIDxH
SUNfU1BJIDg2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArICAgICAgICAjY2xvY2stY2VsbHMg
PSA8MT47DQo+ICsgICAgICAgIGNsb2NrcyA9IDwmY2tpbD4sIDwmb3NjPjsNCj4gKyAgICAgICAg
Y2xvY2stbmFtZXMgPSAiY2tpbCIsICJvc2MiOw0KPiArICAgIH07DQo+IC0tDQo+IDIuNy40DQoN
Cg==
