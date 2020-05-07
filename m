Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E60C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E532083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ompRb8wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgEGG6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:58:55 -0400
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:54497
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgEGG6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9RmfNmCenGPrJuorHNi1xbfOhjGY1tuIjfuSAssXP+h5Rf1aGNWhzY6sWwyfyJbBd6D30si0UpCmYOlF+7kYYAYwS30i6yJIST6W41m2wIGsQ1fNQNH2ZVRosD6i7gQI8u2mjZHBg37uA/zyoas0Fv7yoIPH1ULRaE8q+TAwWSF5dOgwZvoZjVxQOx/BnfnQtsRij6Tc1YQkT9BVzp/4ZDiOMK1yFPmLGboRS5Jfd5x8xMM8OXuo3Ldi8KotAnNOK7p5DvhbOXosfl0FhF5eXM+BcwZ00sHrCsIC49kVvx181fPhbFaaYX3nTtvAs8JBznMkCVz/lae8w1KOgrp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOTJnxptmKgp25ssdoFx+2ZYuU0NMc9CLVQL2QR7iTQ=;
 b=ZmKePmpkHxvyGwtMKnuRtip7W/WNfjeAUKJZLYyQi4Np5JvWbpX5kx+eLm+4w0LuSfUik2/ufX6nHzGe44YQyk0OLAYr2yg0o11liDFpy4NaLMcdjwEAy0kYUXBIFDPMUdsyFAERXo8GD1CwjbhxnaFwAEGbVB6JN9Go+BdKkQUkqNhztYw6cegQKEvWaZBp1cdFh63YMnkGQpoQDwGI5CCp7iWiZ8gp6nY04/BbjCfLtWHBt3iWuIPjTXdYoCdUsptH+arpqOuY7UJQIpjqrLWdX7KuPOjsJ9QArNGN7ed3VkLAYeBVu/0kYbj68eFIonUSaAEK34+mJtCSelIyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOTJnxptmKgp25ssdoFx+2ZYuU0NMc9CLVQL2QR7iTQ=;
 b=ompRb8wHjeIP0TdlD5mz1WwAGwd1TMjmj8vy1I6n4V8oOsmhWxr7vO1ahhWDbJcJYhq0vb64UGyUJxyrtIyr8cnAkJCbxkGh3bT4SCWCf/8caFwzTIIWU8hsGQgvlEESMmcjaY9GaejKmE5W8PhBrCr66Ah/g/8o2r2vmjE3gv4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4327.eurprd04.prod.outlook.com (2603:10a6:209:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 7 May
 2020 06:58:49 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 06:58:49 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Topic: [PATCH V3 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Index: AQHWJDWGQWPBaEf1OUCT0qUKYEEzPaicMHrQ
Date:   Thu, 7 May 2020 06:58:49 +0000
Message-ID: <AM6PR04MB4966473CEEFA2674576A342C80A50@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a923923-f8bc-41ea-1f06-08d7f2541811
x-ms-traffictypediagnostic: AM6PR04MB4327:|AM6PR04MB4327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4327D1CD322C1EEB522CA44B80A50@AM6PR04MB4327.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPi28oKhKlN3uemogMYy+PUu3oGoRJhgwgYh2Ayzf5zGaOedRcXFCywVG+WCg5Ll/52ucBa3xafgv/E1iWjgW2v0PViqXpqBL6LZIcrTci7iGa46rbqV86zFXCyqedGanUH8Toh2gbo5h4jVVNrIseNv5WHpIk31cuEpvJr+5MHF4WvJHTaovWBulKQlnb+iEV0nAUUEqL8LiVfwp7VCqEdLKLTEAMN5ZCp1XVh9Z9cGIBky89Wuf9tH/Pg19qeDBJG08jr/Xln9RpE/mPJH9xkVrFcXinHKyufhuEk0k9nATFQXJuv2kMSjLr2tPJNLsXUbkki9VV/AKE4KJ7S6WReXykHUHAxKPEb2PEFhi8hfoOqznLQAS8/LGJhUhLFW/xi3CGinmIaYIPVKH3rgjbLVthMxV9qbHSq+gL8wmq7Wc29PHjwpFFrIOkLKWguc5wunK5upGU5Rc+a5u3Yz6YcqFbPSjZnCnSi3u2JAGO4uN8uiMAPwI+6ti6PLoqlniAkdAputXZYCfmF8LINv8mgJsszvKRW+dT2VM0WNqIamW1zM1+IyX/m26g2Mh1JVRlCDIW9bL7YZ5BPgy4JDSu1QEIv540ZmBZse0Ltu9n0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(33430700001)(6506007)(7696005)(478600001)(966005)(316002)(110136005)(186003)(54906003)(5660300002)(33656002)(8676002)(83300400001)(83310400001)(83290400001)(8936002)(9686003)(83280400001)(83320400001)(2906002)(44832011)(55016002)(6636002)(76116006)(4326008)(33440700001)(26005)(64756008)(66476007)(71200400001)(66946007)(52536014)(86362001)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hvhRIjfWWoa+YRvZWmu25wU9OFZq3ayhiVfx5MDqkQ29GeR/13jlBUI41986buCmcpcW667grKMU6/D6CdzocPy0h0XDxtBt/yxotVMC6H8Kzt7aVQmu9gX9uwCLXIJUipeQ8M6R3hoh8hNaaVsz1N4CYE0tkHc4LX/5oip4BLbuZ6Fiy4WtVm7mZANQ/Ln/+dFGr4ihaL/6/yPoth2G9BA8UPfCQso5doj0n+zGn2hLNXS7G7u9HrTMhHRqwjEL7BWXdp1ZD0XjcGNN+YXC5Di7Xq7wNwSylZOL6eIC+R8kEiB75/NK+/4ANs/RPnkvG1OxnoyqVmxXpdBg9J6RRsf9xBfFxDvF/YDClV4FvBUYOU2bYSO0ZWLbE23e9+yA1RA7rBP5uFu/BHtjI7//8lDehXktuEaUDFab70AvkkSEy3K7hHsZOZsxhPPjJ66M4hw+z6M8d1g/rYglZS8acNvnMyrBL2l68ZNhY1fBgCisWrgO+6itOdEnc6vE0QEskkjAWGLd9MXB996vvZlrnetm5MAbpymlQ6uQWosT11ZPHK2Adjg+u4rfMB/SP0K4F69CwCCqGwP/3rwGzt6mibJvBZhbHEAA7Ip1xAnGIrzKherkx/jHVS0HtY2QCHy+4lm10ABPDAc4pstJl3x9ExqUOGfkDVKcZJRWUIv/v76BF9vwm7XK7eZQsMLy0nrNPsmd+mm+Nwi4nCSXRlMnP6gVHc5+xuMaJxXapXtLYFL8vkJMvf1e3FqUalK9BjhA2owwXsT1cDQQw3hm+lAoCO76tFqlaFHKG7xRXcs9vaI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a923923-f8bc-41ea-1f06-08d7f2541811
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:58:49.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLec5DX1pKQev/3FKOC98/K3s0CUtgU4Yt7zyIU4vPtDYWrkOqg8SSnsc+JyAVwjhnsBlxss1+3VOuPwA7Ju2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
eSA3LCAyMDIwIDE6NTYgUE0NCj4gDQo+IFBhdGNoZXMgcmViYXNlZCBvbiBmb3ItbmV4dA0KPiAN
Cj4gVjM6DQo+ICBBZGQgUi1iIHRhZyBmb3IgcGF0Y2ggMS02LDEwDQo+ICBVc2UgY2xrX211eF9v
cHMgaW4gcGF0Y2ggNywgZXhwbGFpbiBtb3JlIGRldGFpbHMgaW4gY29tbWl0IGxvZyAgQm9vdCB0
ZXN0IG9uDQo+IGkuTVg4TU0vTi9NUS9QDQoNCkdvb2QgaW1wcm92ZW1lbnQsIGl0J3MgbXVjaCBj
bGVhciBub3cuIA0KU28gYWxzbyBhZGQgbXkgdGFnIGZvciBQYXRjaCA1LTk6DQpSZXZpZXdlZC1i
eTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KRm9yIHBhdGNoIDEwLCBz
dGlsbCBoYXMgYSBzbWFsbCBxdWVzdGlvbi4NClNlZSBjb21tZW50IGluIHRoYXQgcGF0Y2guDQoN
ClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gVjI6DQo+ICBQYXRjaCA3LCBkcm9wIHdhaXQgYWZ0
ZXIgd3JpdGUsIGFkZCBvbmUgbGluZSBjb21tZW50IGZvciB3cml0ZSB0d2ljZQ0KPiANCj4gVjE6
DQo+IFBhdGNoIDEsMiBpcyB0byBmaXggdGhlIGxvY2tkZXAgd2FybmluZyByZXBvcnRlZCBieSBM
ZW9uYXJkIFBhdGNoIDMgaXMgdG8gZml4IHBsbA0KPiBtdXggYml0IFBhdGNoIDQgaXMgYWxpZ24g
d2l0aCBvdGhlciBpLk1YOE0gdXNpbmcgZ2F0ZSBQYXRjaCA1IGlzIHRvIHNpbXBsaWZ5DQo+IGku
TVg4TVAgY2xrIHJvb3QgdXNpbmcgY29tcG9zaXRlDQo+IA0KPiBQYXRjaCAzfjUgaXMgYWN0dWFs
bHkgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTQwMjc2MS8NCj4gd2l0aCBh
IG1pbmltYWwgY2hhbmdlIHRvIHBhdGNoIDUgaGVyZS4NCj4gDQo+IFBhdGNoIDYgaXMgdG8gdXNl
IGNvbXBvc2l0ZSBjb3JlIGNsayBmb3IgQTUzIGNsayByb290IFBhdGNoIDcsOCw5IGlzIGFjdHVh
bGx5IHRvIGZpeA0KPiBDT1JFL0JVUyBjbGsgc2xpY2UgaXNzdWUuDQo+ICBUaGlzIGlzc3VlIGlz
IHRyaWdnZXJyZWQgYWZ0ZXIgd2UgdXBkYXRlIFUtQm9vdCB0byBpbmNsdWRlICB0aGUgQTUzIGNs
ayBmaXhlcyB0bw0KPiBzb3VyY2VzIGZyb20gUExMLCBub3QgZnJvbSBBNTMgcm9vdCBjbGssICBi
ZWNhdXNlIG9mIHRoZSBzaWdub2ZmIHRpbWluZyBpcyAxR0h6Lg0KPiBVLUJvb3Qgc2V0IHRoZSBB
NTMgcm9vdCAgbXV4IHRvIDIsIHN5cyBwbGwyIDUwME1Iei4gS2VybmVsIHdpbGwgc2V0IHRoZSBB
NTMNCj4gcm9vdCBtdXggdG8gIDQsIHN5cyBwbGwxIDgwME1IeiwgdGhlbiBnYXRlIG9mZiBzeXMg
cGxsMiA1MDBNSHouIFRoZW4ga2VybmVsDQo+IHdpbGwgZ2F0ZSBvZmYgQTUzIHJvb3QgYmVjYXVz
ZSBjbGtfaWdub3JlX3Vuc2VkLCBBNTMgZGlyZWN0bHkgc291cmNlcyAgUExMLCBzbyBpdA0KPiBp
cyBvayB0byBnYXRlIG9mZiBBNTMgcm9vdC4gSG93ZXZlciB3aGVuIGdhdGUgb2ZmIEE1MyAgcm9v
dCBjbGssIHN5c3RlbSBoYW5nLA0KPiBiZWNhdXNlIHRoZSBvcmlnaW5hbCBtdXggc3lzIHBsbDIg
NTAwTUh6ICBnYXRlZCBvZmYgd2l0aA0KPiBDTEtfT1BTX1BBUkVOVF9FTkFCTEUgZmxhZy4NCj4g
DQo+ICBJdCBpcyBsdWNreSB0aGF0IHdlIG5vdCBtZXQgaXNzdWUgZm9yIG90aGVyIGNvcmUvYnVz
IGNsayBzbGljZSAgZXhjZXB0IEE1MyBST09UDQo+IGNvcmUgc2xpY2UuIEJ1dCBpdCBpcyBhbHdh
eXMgdHJpZ2dlcnJlZCBhZnRlciAgVS1Cb290IGFuZCBMaW51eCBib3RoIHN3aXRjaCB0byB1c2UN
Cj4gQVJNIFBMTCBmb3IgQTUzIGNvcmUsIGJ1dCAgaGF2ZSBkaWZmZXJlbnQgbXV4IHNldHRpbmdz
IGZvciBBNTMgcm9vdCBjbGsgc2xpY2UuDQo+IA0KPiAgU28gdGhlIHRocmVlIHBhdGNoZXMgaXMg
dG8gYWRkcmVzcyB0aGlzIGlzc3VlLg0KPiANCj4gUGF0Y2ggMTAgaXMgbWFrZSBtZW1yZXBhaXIg
YXMgY3JpdGljYWwuDQo+IA0KPiBQZW5nIEZhbiAoMTApOg0KPiAgIGFybTY0OiBkdHM6IGlteDht
OiBhc3NpZ24gY2xvY2tzIGZvciBBNTMNCj4gICBjbGs6IGlteDhtOiBkcm9wIGNsa19od19zZXRf
cGFyZW50IGZvciBBNTMNCj4gICBjbGs6IGlteDogaW14OG1wOiBmaXggcGxsIG11eCBiaXQNCj4g
ICBjbGs6IGlteDhtcDogRGVmaW5lIGdhdGVzIGZvciBwbGwxLzIgZml4ZWQgZGl2aWRlcnMNCj4g
ICBjbGs6IGlteDhtcDogdXNlIGlteDhtX2Nsa19od19jb21wb3NpdGVfY29yZSB0byBzaW1wbGlm
eSBjb2RlDQo+ICAgY2xrOiBpbXg4bTogbWlncmF0ZSBBNTMgY2xrIHJvb3QgdG8gdXNlIGNvbXBv
c2l0ZSBjb3JlDQo+ICAgY2xrOiBpbXg6IGFkZCBtdXggb3BzIGZvciBpLk1YOE0gY29tcG9zaXRl
IGNsaw0KPiAgIGNsazogaW14OiBhZGQgaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9idXMNCj4gICBj
bGs6IGlteDogdXNlIGlteDhtX2Nsa19od19jb21wb3NpdGVfYnVzIGZvciBpLk1YOE0gYnVzIGNs
ayBzbGljZQ0KPiAgIGNsazogaW14OG1wOiBtYXJrIG1lbXJlcGFpciBjbG9jayBhcyBjcml0aWNh
bA0KPiANCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgIDEw
ICstDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgIDEwICst
DQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgIDExICsrLQ0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kgfCAgIDkgKy0NCj4g
IGRyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMgICAgICAgIHwgIDU2ICsrKysrKysr
KystDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jICAgICAgICAgICAgICB8ICAyNyAr
KystLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMgICAgICAgICAgICAgIHwgIDI1
ICsrKy0tDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jICAgICAgICAgICAgICB8IDE1
MA0KPiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1xLmMgICAgICAgICAgICAgIHwgIDI5ICsrKy0tLQ0KPiAgZHJpdmVycy9jbGsvaW14
L2Nsay5oICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKysNCj4gIGluY2x1ZGUvZHQtYmluZGlu
Z3MvY2xvY2svaW14OG1wLWNsb2NrLmggIHwgIDI4ICsrKysrLQ0KPiAgMTEgZmlsZXMgY2hhbmdl
ZCwgMjI5IGluc2VydGlvbnMoKyksIDEzMyBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuMTYu
NA0KDQo=
