Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA43EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F0420747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EvT4EEfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDHBlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:41:49 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:15779
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgDHBlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8n57X1fKg0Myy5mPZStOi8DCGm/CayCaYcKi+XbOJ6rhxghJMOmAmFqxze4Snh/iOFs1unBQn4WCRc8DfjYDQz7k+TNogQ4pPPCg26DT4Vtq8d0eFKCJnwEwqyfhat/LrbnmpTmjRQFDE6s7juLywd9dxtk3mGdvWSCgHUi7iREq5Uc5oB4eFSKiQk3kQQiGfheHNtjHtjsPeb2z7d2cH6f3owYF7LT5pVIMYOrMMYMctBvO6p2E0L49m0HOG6+DGYwYFPB5XkwNidTO2bL6wJLhGtUOalzuGSrnbgqGD4GFyaqRJxEp917KHu0AcTEWkpvr3FHDE0dJT+0vOpybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RYLY11ydxvyksZiZpvDpDOLOG2cSMYgCCIGO9F8Vbw=;
 b=PMw1d5WLxrGWne6d3ZVMu01CoohEOzACfbYjyqJfruxsNntNK1jrJTOKmxuSrpKwg1u9IviTxpirYfvuY4QxbrHsSzKvu4hFEa/OPnHVSvwW/H/GagCz3CTmg33UGGt2z101anyYqBI8u99F1QYo5C2BLa7fVscUPFwOP7JW2rBt0+TLsOJH2L/kOymwr/jSClmV46v9IwwIEERKMgbTgF6Hm5J1SNFmrEAFyLmR9DSSQLhkfQGf3Rwa1Ab9LSWRMVxisxeT4+korXG0Vi7diEVnSS7bfwBM0+50IFu2uzZMVbReW/9cJUd6rYdMOWnLg3nunMMVKm5qFUY5+IWEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RYLY11ydxvyksZiZpvDpDOLOG2cSMYgCCIGO9F8Vbw=;
 b=EvT4EEfHSTfFnA346F+71j7Wp3uUR/sa8Qj9X8nMxESj8L0jMRAAAYWBhFU1l2SFqzH00Wi8ylNoSk5hgBENI7bEJpBgrDOEdrScH7yGfgLAZ3ao2m5GOUDmw8t9ZVJJcjo2sLEc9Nlw4wyTKn0BtbvggtUCsei74IHdnUyfFB4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (52.135.57.84) by
 AM7PR04MB6837.eurprd04.prod.outlook.com (10.141.173.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Wed, 8 Apr 2020 01:41:45 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::902c:71:6377:4273%5]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 01:41:45 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 5/5] usb: chipidea: allow disabling glue drivers if
 EMBEDDED
Thread-Topic: [PATCH 5/5] usb: chipidea: allow disabling glue drivers if
 EMBEDDED
Thread-Index: AQHWChQAjD6RZ55p5EW1wRD2DjJFfqhtALoAgAEZhoCAAF9sAA==
Date:   Wed, 8 Apr 2020 01:41:44 +0000
Message-ID: <20200408014208.GA22799@b29397-desktop>
References: <2b6d70595475a3ddbd5bb8ae1765868a98c404b6.1585958250.git.mirq-linux@rere.qmqm.pl>
 <1bf89d4301baa8632daf48b3e28858aff5371954.1585958250.git.mirq-linux@rere.qmqm.pl>
 <20200407031300.GB26899@b29397-desktop> <20200407200037.GB744@qmqm.qmqm.pl>
In-Reply-To: <20200407200037.GB744@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0be93b6-6bf9-4eaa-4ff4-08d7db5dfee1
x-ms-traffictypediagnostic: AM7PR04MB6837:
x-microsoft-antispam-prvs: <AM7PR04MB6837121918326CB34EC236138BC00@AM7PR04MB6837.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(7916004)(396003)(376002)(366004)(136003)(39860400002)(346002)(2906002)(316002)(33656002)(81156014)(9686003)(54906003)(91956017)(66446008)(8936002)(6512007)(64756008)(66476007)(66946007)(81166006)(66556008)(6916009)(76116006)(5660300002)(8676002)(86362001)(4326008)(6486002)(26005)(478600001)(71200400001)(53546011)(6506007)(1076003)(186003)(44832011)(33716001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RUYCEzVkg544bvoxidYG6aOmEv4gkgvGauAf1aWRyRFtmvQ5kU2N5Oi4Bsitqt5Ic37x4Xn1jpxe2GfoCAlS4/MlX4wv9rGGTBBA5Ors6XoNTnkvDdO5YWqBoS6fKd3d6+VyurT1DRZwZ62frwteYd3HMo790tyOvcEHX4R/cPOO+y8WadGt+lYOLS+ulxpbRypeVHf3iDdMHv+1KYY+USyiBl5CjtG/M9j8PoIQcpbYTpFhANeYnE6gtebZyDpjmCdCSu0Nhj4d7dP77+hCJeVLkis8BzoJILvfyL9w1VQG8ZvNlZ4TgzLXt1L0HBSzvUNX5RfYIoHGjUYSgyhI4JSVnZ1+aaNznSvKfDj2QIBJwz6o4e9ZOlM7tG3WihiVYEp1He1Nhlr51iDvBEB6Qa93JGFxZWSEBXP3F4bk0nMZr/lmCN3QibW1E/+yfJ1h
x-ms-exchange-antispam-messagedata: 2ckS/06b9mpmsHINIdk/NAS+9K8UCuM91xoQNFzeFmtTV2Y+Sf3vbClJobEJaT2GNQUGjHkTenXpb32lM/GuFb2l9cAPXF15/cMWuNPHSPu5z3qIentKlJVbJepEMv5tzyOWnLj9Z8jBF2bRR3Gy/Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E7F000CFFE6D24BBD2172D1044FE88E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0be93b6-6bf9-4eaa-4ff4-08d7db5dfee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 01:41:44.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M22lmVf0NnldVcaH6Upd3pTdQNZGwom4HJOSFOEjdMMhDOiClhSf6IMx5ub2wOJhxd3G84fqfLF6E/si/0K5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDQtMDcgMjI6MDA6MzcsIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlOg0KPiBPbiBUdWUs
IEFwciAwNywgMjAyMCBhdCAwMzoxMjozNkFNICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+
IE9uIDIwLTA0LTA0IDAyOjAwOjA2LCBNaWNoYcWCIE1pcm9zxYJhdyB3cm90ZToNCj4gPiA+IEFs
bG93IHRvIGN1dCBkb3duIG9uIGRyaXZlciBzaXplIGZvciBlbWJlZGRlZCBjb25maWcuDQo+ID4g
PiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJl
cmUucW1xbS5wbD4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25m
aWcgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiA+ICBkcml2
ZXJzL3VzYi9jaGlwaWRlYS9NYWtlZmlsZSB8IDEyICsrKysrLS0tLS0tLQ0KPiA+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4gPiANCj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnIGIvZHJpdmVycy91
c2IvY2hpcGlkZWEvS2NvbmZpZw0KPiA+ID4gaW5kZXggZDUzZGI1MjBlMjA5Li44YmFmY2ZjNjA4
MGQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnDQo+ID4g
PiArKysgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnDQo+ID4gPiBAQCAtMTgsMTcgKzE4
LDYgQEAgY29uZmlnIFVTQl9DSElQSURFQQ0KPiA+ID4gIA0KPiA+ID4gIGlmIFVTQl9DSElQSURF
QQ0KPiA+ID4gIA0KPiA+ID4gLWNvbmZpZyBVU0JfQ0hJUElERUFfT0YNCj4gPiA+IC0JdHJpc3Rh
dGUNCj4gPiA+IC0JZGVwZW5kcyBvbiBPRg0KPiA+ID4gLQlkZWZhdWx0IFVTQl9DSElQSURFQQ0K
PiA+ID4gLQ0KPiA+ID4gLWNvbmZpZyBVU0JfQ0hJUElERUFfUENJDQo+ID4gPiAtCXRyaXN0YXRl
DQo+ID4gPiAtCWRlcGVuZHMgb24gVVNCX1BDSQ0KPiA+ID4gLQlkZXBlbmRzIG9uIE5PUF9VU0Jf
WENFSVYNCj4gPiA+IC0JZGVmYXVsdCBVU0JfQ0hJUElERUENCj4gPiA+IC0NCj4gPiA+ICBjb25m
aWcgVVNCX0NISVBJREVBX1VEQw0KPiA+ID4gIAlib29sICJDaGlwSWRlYSBkZXZpY2UgY29udHJv
bGxlciINCj4gPiA+ICAJZGVwZW5kcyBvbiBVU0JfR0FER0VUDQo+ID4gPiBAQCAtNDMsNCArMzIs
MzAgQEAgY29uZmlnIFVTQl9DSElQSURFQV9IT1NUDQo+ID4gPiAgCWhlbHANCj4gPiA+ICAJICBT
YXkgWSBoZXJlIHRvIGVuYWJsZSBob3N0IGNvbnRyb2xsZXIgZnVuY3Rpb25hbGl0eSBvZiB0aGUN
Cj4gPiA+ICAJICBDaGlwSWRlYSBkcml2ZXIuDQo+ID4gPiArDQo+ID4gPiArY29uZmlnIFVTQl9D
SElQSURFQV9QQ0kNCj4gPiA+ICsJdHJpc3RhdGUgIkVuYWJsZSBQQ0kgZ2x1ZSBkcml2ZXIiIGlm
IEVNQkVEREVEDQo+IFsuLi5dDQo+ID4gV2h5IGRlcGVuZHMgb24gRU1CRURERUQgZm9yIHRoaXMg
ZHJpdmVyPyBOb3QgZXZlcnlvbmUgbmVlZHMgdGhpcw0KPiA+IGNvbmZpZ3VyYXRpb24uDQo+IA0K
PiBUaGlzIGRvZXMgbm90IG1ha2UgdGhlIGRyaXZlciBkZXBlbmQgb24gRU1CRURERUQsIG9ubHkg
dGhlIHByb21wdHMgYXJlLg0KPiBCeSBkZWZhdWx0ICh3aXRob3V0IENPTkZJR19FTUJFRERFRCkg
eW91IHdpbGwgaGF2ZSBhbGwgZ2x1ZSBsYXllcnMgYnVpbHQNCj4gaWYgeW91IGVuYWJsZSB0aGUg
ZHJpdmVyLiBJIGNhbiByZW1vdmUgdGhlICdpZiBFTUJFRERFRCcsIGJ1dA0KPiBJIHN1cHBvc2Ug
dGhvc2Ugb3B0aW9ucyBhcmUgb25seSByZWxldmFudCBmb3IgcGVvcGxlIGJ1aWxkaW5nIGZvcg0K
PiByZXNvdXJjZS1jb25zdHJhaW5lZCBzeXN0ZW1zLCBzbyB3b3VsZCBoYXZlIEVNQkVEREVEIGVu
YWJsZWQgYW55d2F5Lg0KPiANCg0KTWFrZSBzZW5zZS4gSSBhcHBsaWVkIHRoaXMgc2VyaWVzLCB0
aGFua3MuDQoNCi0tIA0KDQpUaGFua3MsDQpQZXRlciBDaGVu
