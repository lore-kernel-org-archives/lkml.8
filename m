Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD12086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="a44izKW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgGWLoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:44:54 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:55687
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgGWLoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icH4b3C5rj7Go2xg4hCcpGV2Chb2b8SB7ps+PKYr+HooCA4Hd0soLFWS4OjgapG8IS39bobHXkobW3jBdId8G6UeSmujweR/QrwY+uOZk+Ncm0PSpBgHT90lwNGrMC17BWeV4qrcpURtsBSNkjcjSkk54ug1NZusuYRsmV0dJsihS63Yq3d1Z/htDExmVR+G4/aa7LE1E5b4aDNxgP0eOJlMGSHU7R99IJI/RlmapScjq1dmdwD3vD1mHhaLEYn5wTUqP2MbYPKhtL2LrsLmD1BX1qMs1/tJKPmdyg6SOY0vkdhxFNAMnsRQhArfkPhErl4/COg6XtPtu6slB1VsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCG4A1yu9zXJqiS4xCtkQsKV+5um3ivb8EpssX5+Igc=;
 b=MdAvACuUUQUjDB6uJkJGIFs+vf7759qchynphrlqEVmwaqsrcko5lwFlPmQjTz2D0FhND4xGbALsKInnXWGLNpzAKEZ0faPD+tO+84e8d+gLlSuFjLDpSZ+f8u3ocFqqYWL19ACPsXHWEP3Uvsv/rY1vk1cmPgUSpc1GfhSXtRSZ4FVjRdUj1z7NkoN+mGikD6JoJgkWbM0igHi5MXtngWNfc2pWzrvQ1uTH2cvjoC63uLSutpAqPxp5G45OSAF2DeerPXVGe9Pn+k3gN8AZsyGNoqaAlXPwMxlTUNibnZUy4OnzlgRkOs1S5a7IFZRVW8qZUQYw0DtbhPu11dshFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCG4A1yu9zXJqiS4xCtkQsKV+5um3ivb8EpssX5+Igc=;
 b=a44izKW2ma6DXCZlThgCaiiVQ33WrD9qLOxF9Vj+GNtDVNDbDn/LzLKDr9pfSBiw6Si15JWoZQ6izYokPua899EW7M+YXSYU3cxCfuMRzfo2HxHnBOvcYTMCQEvzpmEq34aHc0WiOUWK3H/0kXF8GbTX1IXqIM6PuRlrmYy9bjs=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5411.eurprd05.prod.outlook.com (2603:10a6:20b:36::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Thu, 23 Jul
 2020 11:44:49 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 11:44:49 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Topic: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Index: AQHWVr15sZvxLwnO3E+b+KcqajdLWakFR14AgAAjuQCAAU+xgIAABwcAgAkG2gCAAFsvgIAE/AIA
Date:   Thu, 23 Jul 2020 11:44:48 +0000
Message-ID: <60f571d4ba50bb3377d0c2b7f2dfcfc31fad578a.camel@toradex.com>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
         <20200710132423.497230-3-philippe.schenker@toradex.com>
         <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
         <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
         <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
         <83b230cef109e1a413ab1036c21ad763a1d127eb.camel@toradex.com>
         <20200720021125.GC11560@dragon>
         <5616f6e189845de7c4acfd9eede540ef6e6e9eb0.camel@toradex.com>
In-Reply-To: <5616f6e189845de7c4acfd9eede540ef6e6e9eb0.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edef8900-d217-41ba-df79-08d82efdce5b
x-ms-traffictypediagnostic: AM6PR05MB5411:
x-microsoft-antispam-prvs: <AM6PR05MB5411A5568A781A8E998D2AE0F4760@AM6PR05MB5411.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Stg5DnKdzQT2ayTLIZu19jY14AjzicdlKnC226hvL8Ve3eKNVs5z5U1eYmGSxpfoFW97F9xuHmzbqPqNabScMFmtuMDvc6Gsunl6lBnOXMxGmdHJoqMkqpaftHC58QVKVFyImXAcPnaQUzxJJ9uUKI+qyBJn9fs7EEcwJuzZuxbfY9SGlqe0heMJQPeDOba5Hi9KwI/XbrKL2ZmosBSV3bcENp+tdIlqOsTXwRKs+seUNj+6wCGVoKTLEpSI3YhD2I452oF5N/LMfjAw4qVpalrJudmd12AxE6a4slbGNFhjPChEaeFGqngETOKL3B+tMdZKxFwzz9bO+Isto5RaFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(136003)(376002)(396003)(346002)(6486002)(2616005)(44832011)(6916009)(36756003)(71200400001)(64756008)(66556008)(66946007)(66476007)(91956017)(5660300002)(76116006)(66446008)(54906003)(6512007)(2906002)(316002)(7416002)(86362001)(8936002)(8676002)(26005)(186003)(6506007)(53546011)(478600001)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O9x7M/wsIATqlopJAWAEBG68Q73cyXO+A1fnHJj3TwEyV5VHKDSgcmPJEIy6p/kg7XR/ojDFU3ksfY9iCm4JXTneTrwjjbOqGwo9k7/7cskrXeDvbI+aKq5YlfdWwG9NnumHJvmoQudNCUlEZ/VPLNSRaMN7HiFiv1VMMDNrkGvcYrIqFXuUYrqhsLkSyQMxWi1b+kuqPRfnzje61w+0Kijry7ENkVkVy0Dni+Ve849N7rEUwI82PHx8SQ4mBIG3vhvXL9Pa/bmH5Dk77xYi8w4Tdf8k3qFoT4w/ATH5VbQ6hDelXvi3ugRDGkZQyKYTZAGskQ642a9tcSB4vvbkJ/lLBEBRkAnQK83YIGBLOZBnUxamwhZlxON2nKG2dE1J0v/YmwSclnzQqjYDgi9MQOHx3LYAjwn7StarMHvTd8a6XQdWTfbKMwKyf0lEUh3n4mc8cuB+hE1YvTtETQ45KyGciyCahuBQ06M5uJqBsHA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFD314B8F0A0314C878865052B9EEC29@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edef8900-d217-41ba-df79-08d82efdce5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 11:44:49.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lf3g2+UdzYDlHOZqwBWakRz8wkOvts3EbGpnijXln9s/JrwFYqnhKWyFH7+xHOSi3LhEbxcucO66BBiC6UYnzU0ZmzUaF/fB2Ml1O4fF9Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5411
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDA5OjM3ICswMjAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gT24gTW9uLCAyMDIwLTA3LTIwIGF0IDEwOjExICswODAwLCBTaGF3biBHdW8gd3JvdGU6
DQo+ID4gT24gVHVlLCBKdWwgMTQsIDIwMjAgYXQgMDg6MjA6MzRBTSArMDAwMCwgUGhpbGlwcGUg
U2NoZW5rZXIgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjAtMDctMTQgYXQgMDk6NTUgKzAyMDAs
IEFobWFkIEZhdG91bSB3cm90ZToNCj4gPiA+ID4gSGVsbG8gUGhpbGlwcGUsDQo+ID4gPiA+IA0K
PiA+ID4gPiBPbiA3LzEzLzIwIDE6NTMgUE0sIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+
ID4gPiA+IE9uIE1vbiwgMjAyMC0wNy0xMyBhdCAxMTo0NiArMDIwMCwgQWhtYWQgRmF0b3VtIHdy
b3RlOg0KPiA+ID4gPiA+ID4gSGVsbG8gUGhpbGlwcGUsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gKwlleHRjb25fdXNiY19kZXQ6IHVzYmNfZGV0IHsNCj4gPiA+ID4gPiA+ID4gKwkJY29t
cGF0aWJsZSA9ICJsaW51eCxleHRjb24tdXNiLWdwaW8iOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBBY2NvcmRpbmcgdG8gNDYwMmYzYmZmMjY2ICgidXNiOiBjb21tb246IGFkZCBVU0IgR1BJ
TyBiYXNlZA0KPiA+ID4gPiA+ID4gY29ubmVjdGlvbg0KPiA+ID4gPiA+ID4gZGV0ZWN0aW9uIGRy
aXZlciIpOg0KPiA+ID4gPiA+ID4gInRoZSBvbGQgd2F5IHVzaW5nIGV4dGNvbiB0byBzdXBwb3J0
IFVTQiBEdWFsLVJvbGUgc3dpdGNoIGlzDQo+ID4gPiA+ID4gPiBub3cNCj4gPiA+ID4gPiA+IGRl
cHJlY2F0ZWQNCj4gPiA+ID4gPiA+ICB3aGVuIHVzZSBUeXBlLUIgY29ubmVjdG9yLiINCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGF2ZSB5b3UgY29uc2lkZXJlZCB1c2luZyBhIGNvbXBhdGli
bGUgPSAiZ3Bpby11c2ItYi0NCj4gPiA+ID4gPiA+IGNvbm5lY3RvciINCj4gPiA+ID4gPiA+IGNo
aWxkDQo+ID4gPiA+ID4gPiBub2RlIGluc3RlYWQ/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IENoZWVycywNCj4gPiA+ID4gPiA+IEFobWFkDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhbmtz
IGZvciB0aGUgSGludCBBaG1hZCwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGFscmVhZHkgdHJp
ZWQgYW5kIGp1c3Qgbm93IHRyaWVkIGFnYWluIGJ1dCBpdCBkb2Vzbid0IHdvcmsNCj4gPiA+ID4g
PiBvbg0KPiA+ID4gPiA+IG91cg0KPiA+ID4gPiA+IGhhcmR3YXJlLiBBcmUgeW91IHN1cmUgdGhp
cyB3b3JrcyB3aXRoIGNoaXBpZGVhIGRyaXZlcj8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgaGF2ZW4n
dCwganVzdCB3YW50ZWQgdG8gcG9pbnQgaXRzIGV4aXN0ZW5jZSBvdXQgaW4gY2FzZSB5b3UNCj4g
PiA+ID4gZGlkbid0DQo+ID4gPiA+IGtub3cuDQo+ID4gPiA+IFNlZW1zIHdlIG5lZWQgdG8gY2Fs
bCBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSBzb21ld2hlcmUgaW4gdGhlDQo+ID4gPiA+IGRyaXZlci4N
Cj4gPiA+ID4gVW5zdXJlIHdoYXQgb3RoZXIgY2hhbmdlcyBhcmUgbmVjZXNzYXJ5Lg0KPiA+ID4g
DQo+ID4gPiBZZXAsIHRoYW5rcyBmb3IgdGhhdCEgSXQgc2VlbXMgbGlrZSB0aGF0IG5lZWQgdG8g
YmUgcmVhbGx5IGNhbGxlZA0KPiA+ID4gYXMNCj4gPiA+IEkNCj4gPiA+IGNhbid0IGdldCBhIHBy
b2JlIG9mIHRoZSBuZXcgdXNiIGNvbm5lY3RvciBkcml2ZXIuIEkgcXVpY2tseQ0KPiA+ID4gZ3Jl
cHBlZA0KPiA+ID4gdGhyb3VnaCBjb2RlIGFuZCBzYXcgdGhhdCB0ZWdyYSBVU0IgZHJpdmVyIGlz
IGNhbGxpbmcNCj4gPiA+IG9mX3BsYXRmb3JtX3BvcHVsYXRlIGFuZCB0aGV5IGFsc28gdXNlIHRo
YXQgZ3Bpby11c2ItYi1jb25uZWN0b3IuDQo+ID4gPiANCj4gPiA+ID4gPiBTaG91bGQgdGhpcyBu
ZXcgdXNiLWNvbm5lY3RvciBzdHVmZiB3b3JrIGluIGdlbmVyYWwgd2l0aCBldmVyeQ0KPiA+ID4g
PiA+IG9sZA0KPiA+ID4gPiA+IGRyaXZlcj8NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHRoZSBkcml2
ZXIgc3VwcG9ydCBpc24ndCB0aGVyZSB5ZXQsIEkgdGhpbmsgdXNlIG9mIGV4dGNvbiBpcw0KPiA+
ID4gPiBmaW5lDQo+ID4gPiA+IGFzIGlzLg0KPiA+IA0KPiA+IFNob3VsZG4ndCB3ZSBpbXByb3Zl
IGNoaXBpZGVhIGRyaXZlciB0byBnZXQgaXQgd29yayB3aXRoIGdwaW8tdXNiLWItDQo+ID4gY29u
bmVjdG9yPw0KPiANCj4gSSBrbm93IHRoaXMgd291bGQgYmUgbmljZSBidXQgSSBkb24ndCBrbm93
IHRoYXQgY29kZSB3ZWxsIGVub3VnaCB0byBiZQ0KPiBhYmxlIHRvIG1ha2UgdGhpcyBjaGFuZ2Vz
IGluIGEgdGltZWx5IG1hbm5lci4gQW5kIEkgcmF0aGVyIGxpa2UgdG8NCj4gaGF2ZQ0KPiBzdXBw
b3J0IGZvciBVU0IgZHVhbC1yb2xlIHN1cHBvcnQgInRoZSBvbGQgd2F5IiBub3cgdGhhbiBuZXZl
ciAod2UNCj4gYWN0dWFsbHkgdHJpZWQgdGhpcyBmb3IgYWxvbmcgdGltZSBvbiBvdXIgQ29saWJy
aSBib2FyZHMpLg0KPiANCj4gSSBkaXNjb3ZlcmVkIGEgYnVnIGluIHRoYXQgZHJpdmVyIHRvZ2V0
aGVyIHdpdGggUGV0ZXIgQ2hlbiwgd2hpY2ggZ290DQo+IG5vdyBzb2x2ZWQgYnkgaGltIGFuZCBJ
IHdvdWxkIGxpa2UgdG8gdXNlIHRoZSBob3N0L2RldmljZSBzd2l0Y2hpbmcgb24NCj4gY29saWJy
aS1pbXg2LzcgYm9hcmRzIG5vdy4NCg0KSGkgU2hhd24sDQoNCkNvdWxkIHlvdSBsZXQgbWUga25v
dyBob3cgSSBzaG91bGQgcHJvY2VlZCB3aXRoIHRoZXNlIHBhdGNoZXM/DQoNClRoYW5rcywNClBo
aWxpcHBlDQo=
