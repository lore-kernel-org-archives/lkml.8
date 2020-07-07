Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF230C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9526E206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="fjoxYJrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGGOFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:05:04 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:5966
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgGGOFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:05:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP1O346+qZZpXrqQEJM+SYc4xISZJLuutRppd1z2elZoFtCB1C3TvPVzGBn8jzHJjgYg6ZH6b9I/+evN2CqiEuoANWkxbd9Alu/9Qrs3eFe2BrhQwDNuUvq+TD+stCDdkoADqSU7ZfdBeQVczxJTKHMxVPlOQYCoIJGPLCpXWmaj0eXAfZa6i60vxYUvFiQFtfsOZxmeU12Y5nY987zCy2HePFBksL2Tw4JkFgq2kq3o/LflTwDvo+e9NyriSMO923qA8MRnaYM8DlzM8qpv6b1FzWWQe/TbyZSvOiASIuRONETKGZSWS4b1QlGJMY7WEVHah0FQ2a7Wxzcnkf/+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0/Mt5MenAWY8wppER8v/dUAflsculDSnNaztWU63zU=;
 b=NiqL8a56XTsvcbQng71aW7idEvWk2jKBuVW+aHG65Uh1lAvuHD5lAfk0Wcdm1xOUXcXitEDJw/BEvHIHDXb7HPfFlPIC417feyVk0/+9+sBHeW5IyyBXEb6Vibq1TbOqVezMGjcINn/qOmDrPxqbyu6zrjt8XnYWq+XM+ZvHXq1aO3MimUpQ593iqgTDvYvTxL3j2acpN7h8cMzKYrKRLS6bnBPBveAVEWgCFnbYiF5emsfXyVeUbUsqWhTG0+tbPXAMHouyPJQNJKQVzLv/XzPrLVkhe1nNz8JHWuh4CcwIjvVR0xYJI8ukjUWuTGf2N6VbM477wBV0/C10dDh8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0/Mt5MenAWY8wppER8v/dUAflsculDSnNaztWU63zU=;
 b=fjoxYJrW4wFc1zOG/6iNXSmfq4ILc7l4JUfC56c0H5HFWD+lz6StdgxfiCYriOURQK0gMeR6nYccI5WMPHszI8kyA5p2Cuj/L1bfEDVK7zt/DGOraIugZ7S0LNUCTklzQo3grPonSRZgbZjRsx3MmI/likp9U/z0ox+M9ySTs6w=
Received: from DM5PR1001MB2186.namprd10.prod.outlook.com (2603:10b6:4:35::35)
 by DM5PR10MB1594.namprd10.prod.outlook.com (2603:10b6:3:f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Tue, 7 Jul 2020 14:05:01 +0000
Received: from DM5PR1001MB2186.namprd10.prod.outlook.com
 ([fe80::d086:8298:6d8a:e6ff]) by DM5PR1001MB2186.namprd10.prod.outlook.com
 ([fe80::d086:8298:6d8a:e6ff%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 14:05:00 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "richard@nod.at" <richard@nod.at>,
        "lizhe67@huawei.com" <lizhe67@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>,
        "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "qiuxi1@huawei.com" <qiuxi1@huawei.com>
Subject: Re: [PATCH] jffs2: fix UAF problem
Thread-Topic: [PATCH] jffs2: fix UAF problem
Thread-Index: AQHWRhkioXhOUXpJp0C2OVljdhi7G6joJxSAgBQb7gA=
Date:   Tue, 7 Jul 2020 14:05:00 +0000
Message-ID: <dadc539df01b17aa5dc85e7c0f1dbc83591667cc.camel@infinera.com>
References: <20200619090635.58548-1-lizhe67@huawei.com>
         <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
In-Reply-To: <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: nod.at; dkim=none (message not signed)
 header.d=none;nod.at; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f83f0b71-6304-4677-9ad0-08d8227ebd47
x-ms-traffictypediagnostic: DM5PR10MB1594:
x-microsoft-antispam-prvs: <DM5PR10MB15946531EA1FBBEB654590AEF4660@DM5PR10MB1594.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMl8u7poNuRlZSDpVjjyHpEClOt49QYmDhxTHs+scdGzmVvEwM2OIUYem9pU/Av9sFJZAyWYmJf9BMnYMsG+GAiHMVRf8gpe+Twr4hZUt9jtZlzQAV5EkIfP2CfrXj49eoK50zP6Va5CawEuD7ZMQuLOqxKSthTeCAJTOuf3Es3d3oZeiSKq6vVzXXoWBKthR0kO3GulVkeT71VTqJtwavCQXb3bCB+r+ndXL/igg9+sufYsvXrASZ4MmdXBfkfPqlGGx4/zEY2AQ7ndM4EP3mHDpLGEfvKHAQi0HcK3DrTf40sPZXPjL8GulARNPeQ7QolEuJ4nMZ3JlCf4A1Zs+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2186.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(8676002)(5660300002)(8936002)(316002)(76116006)(64756008)(66476007)(66556008)(66946007)(66446008)(36756003)(86362001)(2616005)(91956017)(186003)(71200400001)(6486002)(110136005)(2906002)(6512007)(54906003)(478600001)(83380400001)(6506007)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wEkK3FpSlGJJjbg+sbbNNSvdXm8F71MSwXlpBJBfy6VV/wTHGmrDHfe7E5jEvOG/XpANnHNUkMFlu0Tg8HBo1ZCSyQ2SF+7soww6Kfz9SNX+neJrGq6HrLNYjWW3XcR+RHcE4V9GFrO6gmlIdx9H8sPEEx06oTv+jFHqZcdsbz55RtG0rS2JchfcjkCzDNdmvITlJONFYJKn6D7MhS/aV6AfNBlT27w48lNQKfqC089ERscixbfuTU5UnNTJhaL//EjO6j4NQFIlKFBp6XC7OCQzSmkGKqMr+B+ES26lRKc+3Tn9+hSCV3rEkC65hFD5CZ+3TgMSpAYLUmOAiEQ5gDvgyupaGnsTyYrJoowfvog5ZuuRfSYUUkvfX13IC5dAOIhtBgffzJ51b/O8O136xJTVHPcANsHiOhHMh/UiXO6Fh4uVhRO1Gd7Ckca318Bq4YirlC65/zhVSzjUHiRnIi4dmPz0xKIyacnWiIsfXxU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AA25D9B89552446813DA2AE592D750A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2186.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83f0b71-6304-4677-9ad0-08d8227ebd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 14:05:00.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdFf7sN2SXKhKqpa1YdMzesOLRLXUL8P0UfzKpIQnf+841apAqmjkv0gMQM7R4t0Oz79NrQ7e05FprFEf0bvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1594
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFpbnRhaW5lciBwaW5nID8NCg0KICAgSm9ja2UNCg0KT24gV2VkLCAyMDIwLTA2LTI0IGF0IDE4
OjU5ICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiANCj4gTmljZSBmaW5kLCBJIGp1
c3QgY2FtZSBhY3Jvc3MgYSBkZWFkbG9jayB3cnQgR0MgYW5kIHJtZGlyLA0KPiBob3BlZnVsbHkg
dGhpcyBpcyBoZSBmaXguDQo+IA0KPiBUaGlzIG5lZWRzIHRvIGdvIHRvIHN0YWJsZSB0b28sIHNv
b25lciByYXRoZXIgdGhhbiBsYXRlci4NCj4gDQo+IMKgSm9ja2UNCj4gDQo+IE9uIEZyaSwgMjAy
MC0wNi0xOSBhdCAxNzowNiArMDgwMCwgWmhlIExpIHdyb3RlOg0KPiA+IA0KPiA+IFRoZSBsb2cg
b2YgVUFGIHByb2JsZW0gaXMgbGlzdGVkIGJlbG93Lg0KPiA+IEJVRzogS0FTQU46IHVzZS1hZnRl
ci1mcmVlIGluIGpmZnMyX3JtZGlyKzB4YTQvMHgxY2MgW2pmZnMyXSBhdCBhZGRyIGMxZjE2NWZj
DQo+ID4gUmVhZCBvZiBzaXplIDQgYnkgdGFzayBybS84MjgzDQo+ID4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiBCVUcga21hbGxvYy0zMiAoVGFpbnRlZDogUCAgICBCICAgICAgTyAgICk6IGth
c2FuOiBiYWQgYWNjZXNzIGRldGVjdGVkDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAN
Cj4gPiBJTkZPOiBBbGxvY2F0ZWQgaW4gMHhiYmJiYmJiYiBhZ2U9MzA1NDM2NCBjcHU9MCBwaWQ9
MA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAweGIwYmJhNmVmDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpm
ZnMyX3dyaXRlX2RpcmVudCsweDExYy8weDljOCBbamZmczJdDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oF9fc2xhYl9hbGxvYy5pc3JhLjIxLmNvbnN0cHJvcC4yNSsweDJjLzB4NDQNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgX19rbWFsbG9jKzB4MWRjLzB4MzcwDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpmZnMy
X3dyaXRlX2RpcmVudCsweDExYy8weDljOCBbamZmczJdDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpm
ZnMyX2RvX3VubGluaysweDMyOC8weDVmYyBbamZmczJdDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpm
ZnMyX3JtZGlyKzB4MTEwLzB4MWNjIFtqZmZzMl0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgdmZzX3Jt
ZGlyKzB4MTgwLzB4MjY4DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRvX3JtZGlyKzB4MmNjLzB4MzAw
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldF9mcm9tX3N5c2NhbGwrMHgwLzB4M2MNCj4gPiBJTkZP
OiBGcmVlZCBpbiAweDIwNWIgYWdlPTMwNTQzNjQgY3B1PTAgcGlkPTANCj4gPiDCoMKgwqDCoMKg
wqDCoMKgMHgyZTkxNzMNCj4gPiDCoMKgwqDCoMKgwqDCoMKgamZmczJfYWRkX2ZkX3RvX2xpc3Qr
MHgxMzgvMHgxZGMgW2pmZnMyXQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBqZmZzMl9hZGRfZmRfdG9f
bGlzdCsweDEzOC8weDFkYyBbamZmczJdDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpmZnMyX2dhcmJh
Z2VfY29sbGVjdF9kaXJlbnQuaXNyYS4zKzB4MjFjLzB4Mjg4IFtqZmZzMl0NCj4gPiDCoMKgwqDC
oMKgwqDCoMKgamZmczJfZ2FyYmFnZV9jb2xsZWN0X2xpdmUrMHgxNmJjLzB4MTgwMCBbamZmczJd
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpmZnMyX2dhcmJhZ2VfY29sbGVjdF9wYXNzKzB4Njc4LzB4
MTFkNCBbamZmczJdDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGpmZnMyX2dhcmJhZ2VfY29sbGVjdF90
aHJlYWQrMHgxZTgvMHgzYjAgW2pmZnMyXQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBrdGhyZWFkKzB4
MWE4LzB4MWIwDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldF9mcm9tX2tlcm5lbF90aHJlYWQrMHg1
Yy8weDY0DQo+ID4gQ2FsbCBUcmFjZToNCj4gPiBbYzE3ZGRkMjBdIFtjMDI0NTJkNF0ga2FzYW5f
cmVwb3J0LnBhcnQuMCsweDI5OC8weDcyYyAodW5yZWxpYWJsZSkNCj4gPiBbYzE3ZGRkYTBdIFtk
MjUwOTY4MF0gamZmczJfcm1kaXIrMHhhNC8weDFjYyBbamZmczJdDQo+ID4gW2MxN2RkZGQwXSBb
YzAyNmRhMDRdIHZmc19ybWRpcisweDE4MC8weDI2OA0KPiA+IFtjMTdkZGUwMF0gW2MwMjZmNGU0
XSBkb19ybWRpcisweDJjYy8weDMwMA0KPiA+IFtjMTdkZGY0MF0gW2MwMDFhNjU4XSByZXRfZnJv
bV9zeXNjYWxsKzB4MC8weDNjDQo+ID4gDQo+ID4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB3ZSBk
b24ndCBnZXQgImpmZnMyX2lub2RlX2luZm8uc2VtIiBiZWZvcmUNCj4gPiB3ZSBzY2FuIGxpc3Qg
ImpmZnMyX2lub2RlX2luZm8uZGVudHMiIGluIGZ1bmN0aW9uIGpmZnMyX3JtZGlyLg0KPiA+IFRo
aXMgcGF0Y2ggYWRkIGNvZGVzIHRvIGdldCAiamZmczJfaW5vZGVfaW5mby5zZW0iIGJlZm9yZSB3
ZSBzY2FuDQo+ID4gImpmZnMyX2lub2RlX2luZm8uZGVudHMiIHRvIHNsb3ZlIHRoZSBVQUYgcHJv
YmxlbS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGUgTGkgPGxpemhlNjdAaHVhd2VpLmNv
bT4NCj4gPiAtLS0NCj4gPiDCoGZzL2pmZnMyL2Rpci5jIHwgNiArKysrKy0NCj4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZnMvamZmczIvZGlyLmMgYi9mcy9qZmZzMi9kaXIuYw0KPiA+IGluZGV4IGYyMGNm
ZjEuLjc3NjQ5MzcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvamZmczIvZGlyLmMNCj4gPiArKysgYi9m
cy9qZmZzMi9kaXIuYw0KPiA+IEBAIC01OTAsMTAgKzU5MCwxNCBAQCBzdGF0aWMgaW50IGpmZnMy
X3JtZGlyIChzdHJ1Y3QgaW5vZGUgKmRpcl9pLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoGludCByZXQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHVpbnQzMl90IG5v
dyA9IEpGRlMyX05PVygpOw0KPiA+IA0KPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmZi0+c2VtKTsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZm9yIChmZCA9IGYtPmRlbnRzIDsgZmQ7IGZkID0gZmQtPm5l
eHQpIHsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKGZkLT5pbm8pDQo+ID4gKyAgICAgICAgICAg
ICAgIGlmIChmZC0+aW5vKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5s
b2NrKCZmLT5zZW0pOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRU5PVEVNUFRZOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoH0NCj4gPiArICAgICAgIG11dGV4X3VubG9jaygmZi0+c2VtKTsNCj4g
PiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gamZmczJfZG9fdW5saW5rKGMsIGRpcl9mLCBk
ZW50cnktPmRfbmFtZS5uYW1lLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlbnRyeS0+ZF9uYW1lLmxlbiwgZiwgbm93KTsN
Cj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4gDQo+ID4gDQo+ID4gDQoNCg==
