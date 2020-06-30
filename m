Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8C120722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c0VPh9Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgF3CYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:24:47 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:56582
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgF3CYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:24:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlGwAuT82e2bfBk3yD4jq5AlP5vogYSQfuA8ze4JztFYZQjMjPpAJ3BWflm+rMYy1ZbqtQO13djxOyaKj6jmGk9gaE9hGSy7vtYHz4Tc/xslBzaW7HYCQsMSeLGD2Hd5JIFNPFgEYrTpkrqEmOEZzS/tK9lGrpX5flSHQQkhZm23hVxAoLS2E20jyFQMvYYi9sApor+u6d8jjGvlS7jSlZYfQctW1mJ/uC8NUUgUKeC+wgkNnz3ShRwM7Pm+8FfUbJ7nHeljnKXi014ObsK3XVBDplilLx6KyT3ZYFIRCTMApnqNry4qhVLZTcWwGyQ2twW+GJHrdc6mTZ3JVIZIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AGxf73UbYkRDGu+21SyckXljA0aW2NMnONGP/vTGcs=;
 b=NNdvcFrg97K3vZEfSAaQznoBKhilMg3yPvHzagGfcOCnifI+e5cnXZaIs9DQ5tETzE8Efko4TWyVdlvkrXtn79h/WQXgTV0gPPckis7+tF0ajscOdFQMeIeu85O9RIdgfUJKkYOKLIJwJrEm2l2RdVBqG1aMLh6kDThSMn4jVObezwiC2O6HKCLqEYL8lHY4/4WTcMhjRxD5NaLyN0kaPX70mvb0plA2HU0TVZGX/F4jNgJpRm0qIdAxBIAUIpLfCBBb1HdkIyBFZYLLP3a8tSNMd+4avIJGGX7P+aGTjuqhXsEcHzRRXF6IW0pUzFHhcGJ74KZNoQ8cYsPSLk7U3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AGxf73UbYkRDGu+21SyckXljA0aW2NMnONGP/vTGcs=;
 b=c0VPh9Tzyl+KejCqFYSovJGzC6TrqX19YUxK3BB1W52U0SwRq4gyOC5WNfB9VYjx9+V0XsaGfNEupUUFWphyM6vk2NMrzBhFFeI/Eg0UP27HK1i6GblGNMYSRIo7m8Cjdf4UiCs8uWACwbZOck3xA8an7QXhh4AGpYsoQIQNwfE=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR0402MB3496.eurprd04.prod.outlook.com
 (2603:10a6:209:7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 02:24:42 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 02:24:42 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAMhp0A==
Date:   Tue, 30 Jun 2020 02:24:42 +0000
Message-ID: <AM6PR0402MB360700E4C52AE36CC3176622FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
In-Reply-To: <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4311a052-7cf7-4704-f9b3-08d81c9cbf36
x-ms-traffictypediagnostic: AM6PR0402MB3496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB349670D5E7FE7B1397D141E6FF6F0@AM6PR0402MB3496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cciee85V21r+cIxVwlsTJV90KtFP6UvcMm0rBrJArsOAqS+28eGv1i9SBliDRqARRWfvPz1O7oIEtYOfflUdB4dOsGJ276J5CS+mYSUuIffnNF6m/vWBawuEG1qBtfEE++j8gJByX+vjuOERXIMDng25TSPHBzteLaMFS230zqnCIxwuSq7X8QUGgphlo7XkJtKKYW+pjzCeiHv3sUC32ks/qR+Q4VQ8XYHef0NA8GDYXtkvT/RkmNhH5coG78AylkQrF8HU7z2M5vW1/8kYAOHOayHkVvgNC6KF5hT+GM1T8C65h806O5VW9ymCuGy+ChKwROmw3u6nZj7ribDkAiiSVvcnO8R6cxF9S8AVm0RfG282KhOx7RjMqQiXCBYnrVEzUqT4ogqs3txDfVgRi9jLPYHAtEyLt/RXG5PYkD8Y1NcVDLhrrxFA4qDTM1De
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(7696005)(53546011)(86362001)(6506007)(52536014)(83080400001)(9686003)(83380400001)(55016002)(54906003)(71200400001)(2906002)(478600001)(33656002)(4326008)(966005)(8936002)(26005)(186003)(8676002)(76116006)(66556008)(66476007)(66446008)(316002)(110136005)(45080400002)(66946007)(5660300002)(64756008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: H8EZBs4fCnGSmZA9VUnJ6V3VzEQc/iinbYqued3i5/XU3tEID6JnJfbIcEOS7O/xxNNvFWjTph+KS3k4ce70SaLVuppMLIqIl1Inw04ytK/NwOuN1hfN12YuAAMKfF14bycHlT/kjUW33SDEYlYIk98mSFC1YR1QvFeQ9CkTkMDAEtbLLtS8MGhPUwOtEWGz336l4nb68dRAnEBooeGMp2W8YZXyqeer2Q6DasB3MQLYlW+UWvLvhmFXJMLojbLWktQ+2xEisHfcayFEXSYoWxObVH/PPmEjUcKdhb3ktaBxcgopgtfSg8PFHvSGYt7pGChjd02F9ZLeDTqQE7YWc7su46OjmgUluO3anmTr3ckpvk4CCTijbWliDWCpdBYOA9VEWg9zhbHoRF8VLq9Y4ftmfP/yEZceSXHYJMyA1YzZAvux9/WG891l8dyJ2cQooXNeAqvIeYYhLA2qLPccalgImCQGPZOL+3DbcVa9ff0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311a052-7cf7-4704-f9b3-08d81c9cbf36
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 02:24:42.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEX9dyTjrlnxfpRdVE0Ti4a8XLoUFUyUtGZWuoCcoJaf4+WgFqeqgfYGtyWDRkGtnQpSxWS4tPs/sXmWcznjkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiBTZW50OiBNb25kYXksIEp1
bmUgMjksIDIwMjAgMTA6MjYgUE0NCj4gSGkgU3ZlbiwNCj4gDQo+IE9uIE1vbiwgSnVuIDI5LCAy
MDIwIGF0IDEwOjQwIEFNIFN2ZW4gVmFuIEFzYnJvZWNrDQo+IDx0aGVzdmVuNzNAZ21haWwuY29t
PiB3cm90ZToNCj4gDQo+ID4gVGhhbmsgeW91IGZvciB0ZXN0aW5nIHRoaXMgb3V0IG9uIGEgZGlm
ZmVyZW50IHBsYXRmb3JtICENCj4gPg0KPiA+IEkgaGFkIGEgbG9vayBhdCBob3cgdGhpbmdzIGFy
ZSBkb25lIGluIHRoZSBGcmVlc2NhbGUgZm9yayBvZiB0aGUNCj4gPiBrZXJuZWwNCj4gPiAoNS40
LjI0XzIuMS4wKSBhbmQgSSBub3RpY2VkIHRoYXQgdGhpcyBrZXJuZWwgaGFzIGFsbW9zdCB0aGUg
c2FtZQ0KPiA+IGJlaGF2aW91ciBhcyB0aGlzIHByb3Bvc2VkIHBhdGNoOiB0aGUgR1BSNSBiaXQg
aXMgX2Fsd2F5c18gc2V0IG9uIGENCj4gPiBwbHVzLiBUaGUgY29kZSBkb2VzIG5vdCBjaGVjayBo
b3cgdGhlIGVuZXQgY2xvY2sgaXMgZ2VuZXJhdGVkLg0KPiA+DQo+ID4gaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGc291cg0K
PiA+DQo+IGNlLmNvZGVhdXJvcmEub3JnJTJGZXh0ZXJuYWwlMkZpbXglMkZsaW51eC1pbXglMkZ0
cmVlJTJGYXJjaCUyRmFybQ0KPiAlMkZtDQo+ID4NCj4gYWNoLWlteCUyRm1hY2gtaW14NnEuYyUz
RmglM0RyZWxfaW14XzUuNC4yNF8yLjEuMCUyNmlkJTNEYmFiYWMwMA0KPiA4ZTVjZjENCj4gPg0K
PiA2OGFiY2ExYTg1YmRhMmU4MDcxY2EyN2E1YzAlMjNuMjY5JmFtcDtkYXRhPTAyJTdDMDElN0Nm
dWdhbmcuZA0KPiB1YW4lNDBueA0KPiA+DQo+IHAuY29tJTdDODU3MGRlMDMwNDUxNDc5NmVhMDIw
OGQ4MWMzODVhMTElN0M2ODZlYTFkM2JjMmI0YzZmYTkyDQo+IGNkOTljNWMzDQo+ID4NCj4gMDE2
MzUlN0MwJTdDMSU3QzYzNzI5MDM3NTY1OTAxNjg4OCZhbXA7c2RhdGE9STl3ZXJCVCUyRkRrY1d1
DQo+IExFS2xGVnpSaTINCj4gPiBLRCUyRkx3UHoyUUNxdyUyQkhuMEhZOFUlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPg0KPiA+IE5vdywgSSdtIGFzc3VtaW5nIHRoYXQgdGhlIHNhYnJlc2QtcGx1cyBj
YW4gcnVuIG9uIHRoZSBGcmVlc2NhbGUNCj4gPiBrZXJuZWwgZm9yay4gVGhlIEdQUjUgYml0IHdp
bGwgYWx3YXlzIGJlIHNldCB0aGVyZS4NCj4gDQo+IEp1c3QgdGVzdGVkIDUuNC4yNF8yLjEuMCBv
biBhbiBpbXg2cXAgc2FicmVzZCBhbmQgREhDUCBhbHNvIGZhaWxzIHRoZXJlLg0KDQpGYWJpbywg
d2UgaGF2ZSBMQVZBIGRhaWx5IHRlc3QgYnkgbmV0d29ya2luZyBmb3IgaW14NnFwIHNhYnJlc2Qg
Ym9hcmQsIG5vIGFueSBpc3N1ZSBmb3VuZC4NClBsZWFzZSBkb3VibGUgY2hlY2sgdGhlIGlzc3Vl
IG9uIHlvdXIgbG9jYWwuDQo=
