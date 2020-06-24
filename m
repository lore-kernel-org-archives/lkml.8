Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AD02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="CQMztYP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406179AbgFXS75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:59:57 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:53582
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405469AbgFXS74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdxPKB4OWvDU4AOTYs1w1/xmu3shfznXel78WykeuaILpGftu/8PmVmwkbVcpIqkq7HdePCEtQStHBFM1ZxeueVUCn3yjDthAYXVoIQSWC6JIaIfMP0Hew8aPicmPhSDG7gGyO1kYPvjDBWfCBchR0gl+TaxcdbGTbVzinrnhMpCkOUa7cNokMsZQOWpOSYesy5u29F/6P1qzh+IVzbExWaFUayV3gW7wHVxwhApXX5Sr+Y3gDlpAbU4UbLdkJzy8zKM71aFmJy8qZQZUsJsJomQjC6zncYcKVUZ1F3NEvk53C+SyGxUDY4vcXM78mnTLl/QMUJd0mTpsFf/AN46ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhgzuVucgavlCVQ5FLNtm/UDZ+1a6gSilUbYMAKGFrM=;
 b=YedB5xcZcIhhTxvgZ5kyjq/nm6kuyU/IRw1NmVFWG3nhf5xb9AcqT2EWxlq32V2KFh+dotOG5iHzUVQNSpNlK3f/CfiKghki1ELbRocQGMCfrbw40wC0/0uYbcDN6WozTMZANwv9hkq0JtCbwWBgWeEx3A2FZA6kP+WS9o+SKBOpI0CdI4rpdHHZtGagNAu54YhgAdQpwUHq2IysFO3COBGmZQJX5qws480e46z8QIcwz9RYHXaR3HmsHwXB/7LhNwsrciQrBve2ppcpAEtXCGrpSm/mOnxctUlPTI/VxAVj5GvAp4UzmP/u1j/uEAs4OAnSObumc3oWlWsUvVB39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhgzuVucgavlCVQ5FLNtm/UDZ+1a6gSilUbYMAKGFrM=;
 b=CQMztYP4Sw72VVE8NZi4sW38mnUutvn0ZKsGmysIZwyrq4SLpZz4LajeQk0Q61aSK2ivHH3uj+sbUs94ck1klnTcK16OdR88MgVOieKoVCq95YYmzuMv8IwIaRI4rkULluRurRBWOjqJdVcYomaR4+SsbHXai/kaS5aluDtukx8=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR10MB1680.namprd10.prod.outlook.com
 (2603:10b6:301:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 18:59:52 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 18:59:52 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "lizhe67@huawei.com" <lizhe67@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
CC:     "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>,
        "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "qiuxi1@huawei.com" <qiuxi1@huawei.com>
Subject: Re: [PATCH] jffs2: fix UAF problem
Thread-Topic: [PATCH] jffs2: fix UAF problem
Thread-Index: AQHWRhkioXhOUXpJp0C2OVljdhi7G6joJxSA
Date:   Wed, 24 Jun 2020 18:59:52 +0000
Message-ID: <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
References: <20200619090635.58548-1-lizhe67@huawei.com>
In-Reply-To: <20200619090635.58548-1-lizhe67@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c29c404-aacb-41e1-3c83-08d81870c71c
x-ms-traffictypediagnostic: MWHPR10MB1680:
x-microsoft-antispam-prvs: <MWHPR10MB1680CD16C45F9AC7D2838888F4950@MWHPR10MB1680.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIMxxT0offJiK7I67jzVEGsQi6fNxbd1ighlrqgxGputR9RI6jQXEnT46jwGS0yvXYWmmLud1GXwueW74M+Pm/MGYU5kaWjvh+xio+2ZaUBZt7NGkFij0kAI5fV4JIrDc3MhO6FhC26fs6toMVnW4/0ABuxHB93PvEtFTMzcKbR2rl51KHxYlF+zAVfRlek1RmJTsvfxHa0icUeo7WFoxnD3nOET7n39zsnF9a7VUWzmu5yDy3+WaN0W7umRTH1ZvhVl7j78FJq+5+vDEGTng/u/0bW46JD1IXSj961O9pGqwO6bu16t+lDDOkNawgo+FbyuZ5STkCedxG55HAi9tPllhWDg2njGYeoZ7Zqk/z6v/+qM5TCsPf7ce/KOkFzw59fAiRxybYZdutP0CjuBZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(83380400001)(5660300002)(76116006)(54906003)(91956017)(478600001)(86362001)(6512007)(36756003)(66446008)(2906002)(66556008)(66476007)(71200400001)(316002)(110136005)(6486002)(64756008)(45080400002)(66946007)(186003)(26005)(8676002)(966005)(8936002)(6506007)(2616005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zEIytsR7K/A/UHBz6tOgaHVrMmXz2Kzjg8uH2krmWIg43goXGA47F43+VwKPrLAn/2MKeKaZ0pqswr4Lrnu+fJ4U3bDLGbglnAm3xWV8+A+p8owP2PtWhUgDKexi9MF+iqfK+bINRxeOiYN3AcTvx/YaeVIiqWTq30GBCp7MFH2hl1cuWShcLJOVXu9fQSTsCsRVRRClZhs3m7mR/WBhp9y9rEWC3BGMFusBPtPQEhmgCbr7HcaDtKmVytB3ZZlyWaYlzqub05CpJj8gnpfn/F22aKYJxFIfqE3JmbHCxMeaAZuN4J9fRLdyao86W4LBFhobLW4pTb6HaQwUU/UkFod8AZDrhgT4iNLVHHAdGTMsbvvlr+j9+Jn9erB1npz6PrspVUCxQJevNU3bRG18e1jen+4d0OhKA+T3kiRPgJdo9qZ8N4luhI/L5CMV7rvi7MCs1qbVHpPapG4IY5FMhHzjNdgbYZfawJha+wUGZSs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2BF9CA22F8C4B46BC745821FFF3A7AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c29c404-aacb-41e1-3c83-08d81870c71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 18:59:52.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+vdIIgcMGmBCSsAwVkPW2CBYXLAAdphvrrVevu/nlgIQSA++Fe/p7mEiNYUIY9W779AUxMJ7dOWdkX2SgxGNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TmljZSBmaW5kLCBJIGp1c3QgY2FtZSBhY3Jvc3MgYSBkZWFkbG9jayB3cnQgR0MgYW5kIHJtZGly
LA0KaG9wZWZ1bGx5IHRoaXMgaXMgaGUgZml4Lg0KDQpUaGlzIG5lZWRzIHRvIGdvIHRvIHN0YWJs
ZSB0b28sIHNvb25lciByYXRoZXIgdGhhbiBsYXRlci4NCg0KIEpvY2tlDQoNCk9uIEZyaSwgMjAy
MC0wNi0xOSBhdCAxNzowNiArMDgwMCwgWmhlIExpIHdyb3RlOg0KPiANCj4gVGhlIGxvZyBvZiBV
QUYgcHJvYmxlbSBpcyBsaXN0ZWQgYmVsb3cuDQo+IEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVl
IGluIGpmZnMyX3JtZGlyKzB4YTQvMHgxY2MgW2pmZnMyXSBhdCBhZGRyIGMxZjE2NWZjDQo+IFJl
YWQgb2Ygc2l6ZSA0IGJ5IHRhc2sgcm0vODI4Mw0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBC
VUcga21hbGxvYy0zMiAoVGFpbnRlZDogUCAgICBCICAgICAgTyAgICk6IGthc2FuOiBiYWQgYWNj
ZXNzIGRldGVjdGVkDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBJTkZPOiBBbGxvY2F0
ZWQgaW4gMHhiYmJiYmJiYiBhZ2U9MzA1NDM2NCBjcHU9MCBwaWQ9MA0KPiAgICAgICAgIDB4YjBi
YmE2ZWYNCj4gICAgICAgICBqZmZzMl93cml0ZV9kaXJlbnQrMHgxMWMvMHg5YzggW2pmZnMyXQ0K
PiAgICAgICAgIF9fc2xhYl9hbGxvYy5pc3JhLjIxLmNvbnN0cHJvcC4yNSsweDJjLzB4NDQNCj4g
ICAgICAgICBfX2ttYWxsb2MrMHgxZGMvMHgzNzANCj4gICAgICAgICBqZmZzMl93cml0ZV9kaXJl
bnQrMHgxMWMvMHg5YzggW2pmZnMyXQ0KPiAgICAgICAgIGpmZnMyX2RvX3VubGluaysweDMyOC8w
eDVmYyBbamZmczJdDQo+ICAgICAgICAgamZmczJfcm1kaXIrMHgxMTAvMHgxY2MgW2pmZnMyXQ0K
PiAgICAgICAgIHZmc19ybWRpcisweDE4MC8weDI2OA0KPiAgICAgICAgIGRvX3JtZGlyKzB4MmNj
LzB4MzAwDQo+ICAgICAgICAgcmV0X2Zyb21fc3lzY2FsbCsweDAvMHgzYw0KPiBJTkZPOiBGcmVl
ZCBpbiAweDIwNWIgYWdlPTMwNTQzNjQgY3B1PTAgcGlkPTANCj4gICAgICAgICAweDJlOTE3Mw0K
PiAgICAgICAgIGpmZnMyX2FkZF9mZF90b19saXN0KzB4MTM4LzB4MWRjIFtqZmZzMl0NCj4gICAg
ICAgICBqZmZzMl9hZGRfZmRfdG9fbGlzdCsweDEzOC8weDFkYyBbamZmczJdDQo+ICAgICAgICAg
amZmczJfZ2FyYmFnZV9jb2xsZWN0X2RpcmVudC5pc3JhLjMrMHgyMWMvMHgyODggW2pmZnMyXQ0K
PiAgICAgICAgIGpmZnMyX2dhcmJhZ2VfY29sbGVjdF9saXZlKzB4MTZiYy8weDE4MDAgW2pmZnMy
XQ0KPiAgICAgICAgIGpmZnMyX2dhcmJhZ2VfY29sbGVjdF9wYXNzKzB4Njc4LzB4MTFkNCBbamZm
czJdDQo+ICAgICAgICAgamZmczJfZ2FyYmFnZV9jb2xsZWN0X3RocmVhZCsweDFlOC8weDNiMCBb
amZmczJdDQo+ICAgICAgICAga3RocmVhZCsweDFhOC8weDFiMA0KPiAgICAgICAgIHJldF9mcm9t
X2tlcm5lbF90aHJlYWQrMHg1Yy8weDY0DQo+IENhbGwgVHJhY2U6DQo+IFtjMTdkZGQyMF0gW2Mw
MjQ1MmQ0XSBrYXNhbl9yZXBvcnQucGFydC4wKzB4Mjk4LzB4NzJjICh1bnJlbGlhYmxlKQ0KPiBb
YzE3ZGRkYTBdIFtkMjUwOTY4MF0gamZmczJfcm1kaXIrMHhhNC8weDFjYyBbamZmczJdDQo+IFtj
MTdkZGRkMF0gW2MwMjZkYTA0XSB2ZnNfcm1kaXIrMHgxODAvMHgyNjgNCj4gW2MxN2RkZTAwXSBb
YzAyNmY0ZTRdIGRvX3JtZGlyKzB4MmNjLzB4MzAwDQo+IFtjMTdkZGY0MF0gW2MwMDFhNjU4XSBy
ZXRfZnJvbV9zeXNjYWxsKzB4MC8weDNjDQo+IA0KPiBUaGUgcm9vdCBjYXVzZSBpcyB0aGF0IHdl
IGRvbid0IGdldCAiamZmczJfaW5vZGVfaW5mby5zZW0iIGJlZm9yZQ0KPiB3ZSBzY2FuIGxpc3Qg
ImpmZnMyX2lub2RlX2luZm8uZGVudHMiIGluIGZ1bmN0aW9uIGpmZnMyX3JtZGlyLg0KPiBUaGlz
IHBhdGNoIGFkZCBjb2RlcyB0byBnZXQgImpmZnMyX2lub2RlX2luZm8uc2VtIiBiZWZvcmUgd2Ug
c2Nhbg0KPiAiamZmczJfaW5vZGVfaW5mby5kZW50cyIgdG8gc2xvdmUgdGhlIFVBRiBwcm9ibGVt
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhlIExpIDxsaXpoZTY3QGh1YXdlaS5jb20+DQo+IC0t
LQ0KPiAgZnMvamZmczIvZGlyLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2pmZnMyL2Rp
ci5jIGIvZnMvamZmczIvZGlyLmMNCj4gaW5kZXggZjIwY2ZmMS4uNzc2NDkzNyAxMDA2NDQNCj4g
LS0tIGEvZnMvamZmczIvZGlyLmMNCj4gKysrIGIvZnMvamZmczIvZGlyLmMNCj4gQEAgLTU5MCwx
MCArNTkwLDE0IEBAIHN0YXRpYyBpbnQgamZmczJfcm1kaXIgKHN0cnVjdCBpbm9kZSAqZGlyX2ks
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gICAgICAgICBpbnQgcmV0Ow0KPiAgICAgICAgIHVp
bnQzMl90IG5vdyA9IEpGRlMyX05PVygpOw0KPiANCj4gKyAgICAgICBtdXRleF9sb2NrKCZmLT5z
ZW0pOw0KPiAgICAgICAgIGZvciAoZmQgPSBmLT5kZW50cyA7IGZkOyBmZCA9IGZkLT5uZXh0KSB7
DQo+IC0gICAgICAgICAgICAgICBpZiAoZmQtPmlubykNCj4gKyAgICAgICAgICAgICAgIGlmIChm
ZC0+aW5vKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZi0+c2Vt
KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9URU1QVFk7DQo+ICsgICAg
ICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiArICAgICAgIG11dGV4X3VubG9jaygmZi0+c2Vt
KTsNCj4gDQo+ICAgICAgICAgcmV0ID0gamZmczJfZG9fdW5saW5rKGMsIGRpcl9mLCBkZW50cnkt
PmRfbmFtZS5uYW1lLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZW50cnktPmRf
bmFtZS5sZW4sIGYsIG5vdyk7DQo+IC0tDQo+IDIuNy40DQo+IA0KPiANCj4gDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eCBN
VEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QNCj4gaHR0cHM6Ly9uYW0wMy5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cy5pbmZyYWRlYWQub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGbGludXgtbXRkJTJGJmFtcDtkYXRhPTAyJTdDMDElN0Nq
b2FraW0udGplcm5sdW5kJTQwaW5maW5lcmEuY29tJTdDMzM5YTExODQ3NDViNGM3NmJkZjkwOGQ4
MTQzMDQzYjIlN0MyODU2NDNkZTVmNWI0YjAzYTE1MzBhZTJkYzhhYWY3NyU3QzElN0MxJTdDNjM3
MjgxNTQ0ODE1Njk3NTgyJmFtcDtzZGF0YT1qS285N2ZjM2o2alZjalZwUzJleG0wc0RMJTJCV3I2
RHFrVGU2anFlOEc5dDglM0QmYW1wO3Jlc2VydmVkPTANCg0K
