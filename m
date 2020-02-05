Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D66C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AC32082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="LcvAbqvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgBELSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:18:38 -0500
Received: from mail-eopbgr130094.outbound.protection.outlook.com ([40.107.13.94]:18594
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727231AbgBELSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:18:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYSobzTmM6Dv6j3/CMwlPvFBfCrUBMeZny/oG8hw3GgH0UdvLEE7LSM9Iyqqy2YttDx9DtbCj8n4aAE5hJ8N3HrTcYxLRs9Do3XPXQGj6ppgLrYZwV2W2sW3FKJ3IusYsXeQa6DN5zZQAMb298Su/VEeFliDq7YG6Pvd22hOoNYjrOSck6TD0lDhVNEuonkipw1sJZbYkacc3hQufCwjzawaKAY32Nfqu/U1CeDdaQJBqTzgaDhf/tohDCfNeY4GmOfWhxa6YBK8Dcfd4Y2Hx0czGSGStaDRM5XppvD1+SlAQlrpa0k0RnNgn+TbRApHJQeK3ANy7QJ8qjIL+3vx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxfClRwcPa59NMQ+cFuS/JBDHmiRLl91tFUyAe6dmMQ=;
 b=UVFJoAowltaX3hnL8U2MJTaTuwwJJWsdF8tRZmpFJ+foiO3PJiKiEF5D5DjaSbrZaXtzIwt03VDB1xN0/bNpEb8SVPtT9X2fYfqzZTmuDdDKMYUBp8IP1bmEZUeUSIm6DFkno2nqKdWRod/HM7bRWchFFkVPXxA7wGWno5voR75D1F5taunUTA6BZC2SQ2WzDB/GprdRsrcH5HjAiDS/HFKdpqfdTv15X0ANEo21x+3ksqDP+FsEkgsDK3KAAVWI+UBd3Ne14GH14JaJF3l2JN5iCE7ewBMHOgzJ1lY7AMG8W6HpVRoZxuoCDFQ1RnHwnTltpMr9kMDiUJ8efb89qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxfClRwcPa59NMQ+cFuS/JBDHmiRLl91tFUyAe6dmMQ=;
 b=LcvAbqvZ/J0dvEztSSz6qonxpSvMJEaoAfwN/N4NGljkZTFuxL3yRaWLu+gXBHLxcQAIgnHhgMrNlw22zNjBUef6xkeaHT1VGw2tbOU2ln/wkhz86BFAv8gxNE2lld2Psd6xP7zGL9WVT+5xjoJkLX1ensFHn0c5rFSuNHE3uLk=
Received: from HE1PR07MB3067.eurprd07.prod.outlook.com (10.170.247.30) by
 HE1PR07MB4201.eurprd07.prod.outlook.com (20.176.163.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.16; Wed, 5 Feb 2020 11:18:35 +0000
Received: from HE1PR07MB3067.eurprd07.prod.outlook.com
 ([fe80::f5cf:6d45:7129:5aa1]) by HE1PR07MB3067.eurprd07.prod.outlook.com
 ([fe80::f5cf:6d45:7129:5aa1%6]) with mapi id 15.20.2707.018; Wed, 5 Feb 2020
 11:18:35 +0000
From:   "Huttunen, Janne (Nokia - FI/Espoo)" <janne.huttunen@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: BUG: perf script python SIGSEGV
Thread-Topic: BUG: perf script python SIGSEGV
Thread-Index: AQHV3BYBQIMI1+J6Ak6TNEAyRgRm8A==
Date:   Wed, 5 Feb 2020 11:18:34 +0000
Message-ID: <54196e8caa4ac8b4a40f89799656ad8defa02f6b.camel@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=janne.huttunen@nokia.com; 
x-originating-ip: [131.228.2.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3dff578-5d90-47eb-a86f-08d7aa2d240f
x-ms-traffictypediagnostic: HE1PR07MB4201:
x-microsoft-antispam-prvs: <HE1PR07MB420119E89B7411B81F0341299A020@HE1PR07MB4201.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(81166006)(81156014)(6916009)(66946007)(8676002)(66476007)(66446008)(76116006)(5660300002)(2616005)(66556008)(8936002)(478600001)(86362001)(64756008)(26005)(6512007)(316002)(6486002)(186003)(36756003)(71200400001)(6506007)(2906002)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4201;H:HE1PR07MB3067.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXeQCxVAYQiBqjVIexfKV/qXWjAg9ie7pDGvafuASLBeJ4k/bMT4j76hAM45dRm8GUCMBVdKe2IfXSLbS9VFPLUhHCJ71Dhh8XXTnqi2v1zxphsj7xd1w+Ngkscyly/9tbA64ZnW0j8gBIFko9+Z9LuVX6kI+f2WSNcaL7V1QThqx++VTmGDQp/463I772GvWsHuYPbeCUVfTU3JOC/gGnTbkg7Uo+npxbdD+Yw6dxGv0uuI3kWNawE63/5oSXbM6Ihh3+nmXizdJJ23q8zgB6uQG1ECRnokFEk/EvrKdJ67u+9lURnrNA1H89CxVAHb6oz5unZ0iVaVpGBNl1MNaNre8H+YSd9ZvhJ33EloBsNuI17RfDM3CF7umhF+lzB1p5sX5gs+953XJY1jVgqF7qMK0+FY1rPr5a2R7bZemQDOdwV+Zrx8KZjBnILAvE8tlFYAdx3Ily4PJKvLRhWBPDTtsMovoHArYfisA/MjAT2h/GLksfhb1IeMhF2saYJY
x-ms-exchange-antispam-messagedata: OWUjgXGiOTgGqy+ZWK5VgpXQEbrJtvbeHtcT69eKqycdgxnYGJVOxnXxXepzcZSLDocmW3/ULSdm/VC3A5Oei47by8l4XkCxYhup7Gu30UIODzZfmBV3aOmWIRZYrvQZexU00J9w1tinTpNKVXTqLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FB9C01D6208BD4796D71F769AF37B42@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dff578-5d90-47eb-a86f-08d7aa2d240f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 11:18:35.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW/S2T89Kyn8UcrpTh9mprpPJeZGDJotLWyeQVy9lanWFUSkMOfU5kgTJ3R+vuzIlRreloE0stsT/nikBEMJmgdDhK6tf/pHFyZUmeGIDDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpJdCBhcHBlYXJzIHRoYXQgdGhlIHBlcmYgY29tbWFuZCBjcmFzaGVzIHdoZW4gcHJvY2Vzc2lu
Zw0KcmVjb3JkaW5nIHdpdGggYSBQeXRob24gc2NyaXB0IGFuZCB0aGUgZmlyc3QgcmVjb3JkZWQg
ZXZlbnQNCmluIGhhcHBlbnMgdG8gYmUgImNvbnRleHRfdHJhY2tpbmc6dXNlcl9lbnRlciIgb3IN
CiJjb250ZXh0X3RyYWNraW5nOnVzZXJfZXhpdCIuDQoNCg0KJCBwZXJmIHNjcmlwdCAtZyBQeXRo
b24NCmdlbmVyYXRlZCBQeXRob24gc2NyaXB0OiBwZXJmLXNjcmlwdC5weQ0KJCBwZXJmIHNjcmlw
dCAtcyBwZXJmLXNjcmlwdC5weSAtaSBwZXJmLmRhdGENCmluIHRyYWNlX2JlZ2luDQpObyBrYWxs
c3ltcyBvciB2bWxpbnV4IHdpdGggYnVpbGQtaWQgMGNkMWU2MWUzNzAzNTIxZWU0ZGUxNGExZjEz
YWFjMTdiNzYyZmU1NyB3YXMgZm91bmQNClNlZ21lbnRhdGlvbiBmYXVsdCAoY29yZSBkdW1wZWQp
DQoNCg0KIzAgIDB4MDAwMDdmZmZmNThmNDZmYSBpbiBzdHJsZW4gKCkgZnJvbSAvbGliNjQvbGli
Yy5zby42DQpObyBzeW1ib2wgdGFibGUgaW5mbyBhdmFpbGFibGUuDQojMSAgMHgwMDAwN2ZmZmY1
NTM1MzYwIGluIFB5U3RyaW5nX0Zyb21TdHJpbmcgKCkNCiAgIGZyb20gL2xpYjY0L2xpYnB5dGhv
bjIuNy5zby4xLjANCk5vIHN5bWJvbCB0YWJsZSBpbmZvIGF2YWlsYWJsZS4NCiMyICAweDAwMDAw
MDAwMDA1OWQ1MmYgaW4gZGVmaW5lX3ZhbHVlICgNCiAgICBmaWVsZF90eXBlPWZpZWxkX3R5cGVA
ZW50cnk9VEVQX1BSSU5UX0ZMQUdTLCANCiAgICBldl9uYW1lPWV2X25hbWVAZW50cnk9MHhkNzMz
MjAgPGhhbmRsZXJfbmFtZT4gImNvbnRleHRfdHJhY2tpbmdfX3VzZXJfZW50ZXIiLCBmaWVsZF9u
YW1lPTB4MCwgZmllbGRfdmFsdWU9ZmllbGRfdmFsdWVAZW50cnk9MHg2ZWQ1NTYgIjAiLCANCiAg
ICBmaWVsZF9zdHI9MHhkODhhYzAgIiIpIGF0IHV0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2Ut
ZXZlbnQtcHl0aG9uLmM6MjIxDQogICAgICAgIGhhbmRsZXJfbmFtZSA9IDxvcHRpbWl6ZWQgb3V0
Pg0KICAgICAgICB0ID0gMHg3ZmZmZjdlODQ5ZjANCiAgICAgICAgdmFsdWUgPSAwDQogICAgICAg
IG4gPSAxDQojMyAgMHgwMDAwMDAwMDAwNTllNWJkIGluIGRlZmluZV9ldmVudF9zeW1ib2xzIChl
dmVudD1ldmVudEBlbnRyeT0weGQ3Zjg5MCwgDQogICAgZXZfbmFtZT1ldl9uYW1lQGVudHJ5PTB4
ZDczMzIwIDxoYW5kbGVyX25hbWU+ICJjb250ZXh0X3RyYWNraW5nX191c2VyX2VudGVyIiwgYXJn
cz08b3B0aW1pemVkIG91dD4pIGF0IHV0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQt
cHl0aG9uLmM6MjgyDQpObyBsb2NhbHMuDQojNCAgMHgwMDAwMDAwMDAwNTlmNzQxIGluIHB5dGhv
bl9wcm9jZXNzX3RyYWNlcG9pbnQgKGFsPTB4N2ZmZmZmZmZiYTIwLCANCiAgICBldnNlbD0weGQ4
ODIzMCwgc2FtcGxlPTB4N2ZmZmZmZmZiY2UwKQ0KICAgIGF0IHV0aWwvc2NyaXB0aW5nLWVuZ2lu
ZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmM6ODIxDQogICAgICAgIGNvbW0gPSAweDEwNDA0NDAgIjoz
NjgyNjcxIg0KICAgICAgICBoYW5kbGVyX25hbWUgPSAiY29udGV4dF90cmFja2luZ19fdXNlcl9l
bnRlciIsICdcMDAwJyA8cmVwZWF0cyAyMjcgdGltZXM+DQogICAgICAgIGV2ZW50ID0gMHhkN2Y4
OTANCiAgICAgICAgaGFuZGxlciA9IDxvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBmaWVsZCA9IDxv
cHRpbWl6ZWQgb3V0Pg0KICAgICAgICBucyA9IDxvcHRpbWl6ZWQgb3V0Pg0KICAgICAgICBuID0g
MA0KICAgICAgICBjb250ZXh0ID0gPG9wdGltaXplZCBvdXQ+DQogICAgICAgIG9iaiA9IDB4MA0K
ICAgICAgICBjYWxsY2hhaW4gPSA8b3B0aW1pemVkIG91dD4NCiAgICAgICAgZGljdCA9IDB4MA0K
ICAgICAgICBzID0gPG9wdGltaXplZCBvdXQ+DQogICAgICAgIHBpZCA9IDM2ODI2NzENCiAgICAg
ICAgZGF0YSA9IDB4N2ZmZmVkMTQ0MmRjDQogICAgICAgIGRlZmF1bHRfaGFuZGxlcl9uYW1lID0g
MHg2ZjUzMzIgInRyYWNlX3VuaGFuZGxlZCINCiAgICAgICAgdCA9IDB4NGM2YjhiIDxtYWNoaW5l
X19yZXNvbHZlKzM5NT4NCiAgICAgICAgYWxsX2VudHJpZXNfZGljdCA9IDB4MA0KICAgICAgICBj
cHUgPSAxNg0KICAgICAgICBuc2VjcyA9IDU4OTE4NzM1Njg2NjQ2OA0KIzUgIHB5dGhvbl9wcm9j
ZXNzX2V2ZW50IChldmVudD08b3B0aW1pemVkIG91dD4sIHNhbXBsZT0weDdmZmZmZmZmYmNlMCwg
DQogICAgZXZzZWw9MHhkODgyMzAsIGFsPTB4N2ZmZmZmZmZiYTIwKQ0KICAgIGF0IHV0aWwvc2Ny
aXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmM6MTMyMQ0KICAgICAgICB0YWJsZXMg
PSAweGQ3MzUyMCA8dGFibGVzX2dsb2JhbD4NCg0KDQpUaGUgY3Jhc2ggc2VlbXMgdG8gaGFwcGVu
IGJlY2F1c2UgdGhvc2UgZXZlbnRzIGRlZmluZSB0aGUgcHJpbnQNCmZvcm1hdCBsaWtlIHRoaXM6
DQoNCiAgcHJpbnQgZm10OiAiJXMiLCAiIg0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGlzIGdl
bmVyYXRlcyBvbmx5IGEgc2luZ2xlIFRFUF9QUklOVF9BVE9NDQphcmcuIFdoZW4gcHJvY2Vzc2lu
ZyB0aGUgZXZlbnQsIGRlZmluZV92YWx1ZSgpIHRyaWVzIHRvIGNvbnZlcnQNCmN1cl9maWVsZF9u
YW1lIHRvIGEgcHl0aG9uIHN0cmluZy4gU2luY2UgaXQgaGFzbid0IHNlZW4gYW55DQpURVBfUFJJ
TlRfRklFTEQgYXJncywgdGhlIGN1cl9maWVsZF9uYW1lIGlzIHN0aWxsIE5VTEwgd2hpY2gNCnRy
aWdnZXJzIHRoZSBTSUdTRUdWLg0KDQpBIHRyaXZpYWwgd29ya2Fyb3VuZCBmb3IgdGhlIGNyYXNo
IHdvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCmRpZmYgLS1naXQgYS90b29scy9wZXJm
L3V0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMgYi90b29scy9wZXJm
L3V0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCmluZGV4IDgwY2E1
ZDAuLjhmZDAzZDUgMTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3V0aWwvc2NyaXB0aW5nLWVuZ2lu
ZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMNCisrKyBiL3Rvb2xzL3BlcmYvdXRpbC9zY3JpcHRpbmct
ZW5naW5lcy90cmFjZS1ldmVudC1weXRob24uYw0KQEAgLTIwOCw2ICsyMDgsOSBAQCBzdGF0aWMg
dm9pZCBkZWZpbmVfdmFsdWUoZW51bSB0ZXBfcHJpbnRfYXJnX3R5cGUgZmllbGRfdHlwZSwNCiAJ
dW5zaWduZWQgbG9uZyBsb25nIHZhbHVlOw0KIAl1bnNpZ25lZCBuID0gMDsNCiANCisJaWYgKGZp
ZWxkX25hbWUgPT0gTlVMTCkNCisJCXJldHVybjsNCisNCiAJaWYgKGZpZWxkX3R5cGUgPT0gVEVQ
X1BSSU5UX1NZTUJPTCkNCiAJCWhhbmRsZXJfbmFtZSA9ICJkZWZpbmVfc3ltYm9saWNfdmFsdWUi
Ow0KIA0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgd2hpbGUgcGVyZiBkb2Vzbid0IGNyYXNoIGFueW1v
cmUgd2l0aCB0aGF0DQpwYXRjaCwgaW4gYSBtb3JlIGNvbXBsZXggY2FzZSBpdCB3b3VsZCBsaWtl
bHkgc3RpbGwgZG8NCnNvbWV0aGluZyB0aGF0IHdvdWxkIG5vdCBtYWtlIG11Y2ggc2Vuc2UuIEFz
IGZhciBhcyBJIGNhbiBzZWUsDQpzb21lIG9sZCB2YWx1ZSBjb3VsZCBlYXNpbHkgYmUgbGVmdCBp
biB0aGUgZmlsZSBzY29wZWQNCmN1cl9maWVsZF9uYW1lIHZhcmlhYmxlLiBBIG1vcmUgY29ycmVj
dCBmaXggd291bGQgcmVxdWlyZQ0KYSBiaXQgYmV0dGVyIHVuZGVyc3RhbmRpbmcgb2YgdGhlIGlu
dGVuZGVkIHNlbWFudGljcywgbGlrZQ0KZS5nLiB3aGF0IGV4YWN0bHkgaXMgdGhlIGFwcGFyZW50
bHkgcXVpdGUgdW51c2VkDQonemVyb19mbGFnX2F0b20nIHZhcmlhYmxlIGluIHRoZXJlIHN1cHBv
c2VkIHRvIGFjaGlldmU/DQoNCg0K
