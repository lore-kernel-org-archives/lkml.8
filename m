Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EE3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2CF2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YtqKtOui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGUGs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:48:59 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:11706 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgGUGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:48:58 -0400
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L6b3Ow003028;
        Tue, 21 Jul 2020 06:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=bPpSp4GJLRANOrfqpt9+tyV4ECLKe0X03WsYWtFEJCk=;
 b=YtqKtOuibuRpIq6Lwrnw2VRPOmYPqrPyelt4DTU1D5yDoLOKoHniBPaPvCN4jMs5lKah
 X8/nNa0XWoJddIgEL88jyaJdCmpm8z+FfierbEAw6rDg5Xi/wMzH2grqdKG5GG7CxK3y
 PmP57fBUd77aqyS82eZGliBEyX7ncXWSMmmdq7INsOMRuGYDDWrcLIk5hQ0PYaxQ5eMg
 2g0D5a6R3y+yn91FSJ4o1FNM0BtboZE/DnkoPvMW4QmPN8CU5+wHElWCO7Wg8UskTLfc
 Yrx3JdA16yZX/u8Uc0+Hd4qdSOsMFOfNS3edz3a+J822lTUdr+dRuUV3KwPsxGCiKoDr Qw== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
        by mx08-001d1705.pphosted.com with ESMTP id 32bpaxs6df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 06:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye8JePvS8et03RruyfPRaQORgDLvS3Iy846eQ/rArrr5uXXvujGtZtK0ka/HwL1Mte0EvkQFUmG8Jaup2ACjcTpKiUBq4LxEg/PO21ammQLvN0bWrwg8+9GaULE/v3FE/Uj0JNWsDQCeSA8qh1zR5HSslhUOtXG6Q6Jpb1MhZjmH7X9TumFQVc4I3cw7nadReu0L+XlUbuApLzITpU0WS2Sn408no7lZ5UxVyNVn0GJJ/KleskVbR8sIwZ6eZBlAVsdZG8IAUixCz/wZ1nyw23WSNEjuvYGvvNV9N/bf8+t9uHpYIC5DYetXwTFsqOYpvQXYFeVTiWM2s1qSfrFzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPpSp4GJLRANOrfqpt9+tyV4ECLKe0X03WsYWtFEJCk=;
 b=SmuT0GBYr8oFZtffcMK5mZ2N4Ih8wM7I07eObEcuSTArws/EYSPISZ6L0pni5QrFW0lYUDL84j12voeWC209J18DML+KscPlurUzSCIGZP96gN6kJtfPb6q+n4QZG0E/wi0j3fUJNMz92aEbFS7kukmhWkDtzH59zVRnCx4N0db1+Iux97e7vTSMcAbavE0xkEdYlrF6TL2zZgHXlv23RAK7EIxnl+sYcEbhPkSnzQrx5oO7xvtn+pY0noXeSmYflZShkgR6T3CbdMYgmSozOwMjj3N+fipe2x9ePpw0lfkPXE09ftNm3kbbJwrpJMr+jX7eZYjpfwUlbDkrFTEgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14b::8)
 by AM0P193MB0370.EURP193.PROD.OUTLOOK.COM (2603:10a6:208:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 06:47:59 +0000
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7]) by AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7%4]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 06:47:59 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
Thread-Topic: [PATCH 2/2] debugfs: Add access restriction option
Thread-Index: AQHWWoPfDn+JEjIBf0W3BsLx2no9AqkIYomAgAk+K4A=
Date:   Tue, 21 Jul 2020 06:47:58 +0000
Message-ID: <7b992dc0-0939-b45e-48c3-2e5eae2a1199@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
 <20200715084207.7639-3-peter.enderborg@sony.com>
 <20200715093907.GC2759174@kroah.com>
In-Reply-To: <20200715093907.GC2759174@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f77eea30-af69-4250-c9fd-08d82d420190
x-ms-traffictypediagnostic: AM0P193MB0370:
x-microsoft-antispam-prvs: <AM0P193MB0370DB01FD35E4D757E2DF1286780@AM0P193MB0370.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xu5R9PJUF70i9tn5l9Xia8sGX6ZNDK8cHn92M899220WfTuhcT/Qazi+FjmAcQd4nQfU+VZdmFmBTaczM15+Ue7n8ubB0RNsEYliHMvJAjMKusuJS/qpYuER6Hm5S5oCTsJiHQLgiVo9XE3CIQckSQgEtlYplQB6tziHIiXpo3C9beZ5vGzyEEdwehFQ2VZL4wR79WRh1vgwMz0I0y19IT/DmutfUfNi+0tcML9IMde+pIDISJ20sIBHkF7zvBClO4B7TXIIfbVjN5U3X1TFQACMQfsSDziSEqCJSPmCWXMKNZiKuzd11Xqr/QqczlLDLhpADTjQWT2pbq5ab50DGQxwnw2FTdvZEWiYc2aFKyQlJObk+sqRlRtKObhev0H6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0626.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(8936002)(8676002)(86362001)(2616005)(54906003)(6486002)(6916009)(316002)(31686004)(36756003)(478600001)(83380400001)(53546011)(2906002)(26005)(6506007)(66476007)(186003)(64756008)(66446008)(91956017)(76116006)(66946007)(71200400001)(6512007)(4326008)(31696002)(5660300002)(66556008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CND3zjmAoMd+Nw49SHtRDSLWHXVaYE5VwoyEsinTJQCYmi0jVINoOY4CqTQAObhzbRmkazbGEGs17jOjRpuQJ2c9oaKdLNRVUq20AH4ErpmxLzU4MzrszjwKZS4Lte1p+u3c5MfiIVLmr/f41eaHvzklI0+3gRpbwDs3aa12EzFjwM1GoIOCQ0ljfk5ohRlmjDE6NMauVnxuNBUZVOnid+NttHTx+BK64/fxVzF83hEOpwfGW3BrTEjTEFnRMB5yo34sG0Cr57/r9AnK5xkvJLCGE/3s6i3rEfJZwX/6GzUIxLt538DUByC4sU7TnaPenp4qvl7ke7MaXAtUXLuDfl5GyExur9aufVIX2L/EOi43xdF7bjlPYu7ch//sinYHpzrs6Bvgpk9QTSc+T2Zq329ZzPZL7tlDz6wsBJ+hkA/fa7fDk3kkf7nA0MoLn5Y2WgKw12JHtapD+LwxoeJ16NngWT9uJw1zizSvsnAjcqo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <88ABF436EFF8524B846B3BD38A197E44@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f77eea30-af69-4250-c9fd-08d82d420190
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 06:47:58.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpH1wdT6QeOH2MqzxDPj+UuLEO5auh3Czkbpkp2zgiF1ebubDkqeO5AdYLsXE6HmwmnoJwAf5ja8VNiTH3A0sW7KZx0NMWZJBt2HbtEWJy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0370
X-Sony-Outbound-GUID: lNkuyhE2xm9msRqsmzNNxxrIYJ66MtLJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xNS8yMCAxMTozOSBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBXZWQs
IEp1bCAxNSwgMjAyMCBhdCAxMDo0MjowN0FNICswMjAwLCBQZXRlciBFbmRlcmJvcmcgd3JvdGU6
DQo+PiBTaW5jZSBkZWJ1Z2ZzIGluY2x1ZGUgc2Vuc2l0aXZlIGluZm9ybWF0aW9uIGl0IG5lZWQg
dG8gYmUgdHJlYXRlZA0KPj4gY2FyZWZ1bGx5LiBCdXQgaXQgYWxzbyBoYXMgbWFueSB2ZXJ5IHVz
ZWZ1bCBkZWJ1ZyBmdW5jdGlvbnMgZm9yIHVzZXJzcGFjZS4NCj4+IFdpdGggdGhpcyBvcHRpb24g
d2UgY2FuIGhhdmUgc2FtZSBjb25maWd1cmF0aW9uIGZvciBzeXN0ZW0gd2l0aA0KPj4gbmVlZCBv
ZiBkZWJ1Z2ZzIGFuZCBhIHdheSB0byB0dXJuIGl0IG9mZi4gVGhpcyBnaXZlcyBhIGV4dHJhIHBy
b3RlY3Rpb24NCj4+IGZvciBleHBvc3VyZSBvbiBzeXN0ZW1zIHdoZXJlIHVzZXItc3BhY2Ugc2Vy
dmljZXMgd2l0aCBzeXN0ZW0NCj4+IGFjY2VzcyBhcmUgYXR0YWNrZWQuDQo+Pg0KPj4gSXQgaXMg
Y29udHJvbGxlZCBieSBhIGNvbmZpZ3VyYWJsZSBkZWZhdWx0IHZhbHVlIHRoYXQgY2FuIGJlIG92
ZXJyaWRlDQo+PiB3aXRoIGEga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIuIChkZWJ1Z2Zz
PSkNCj4+DQo+PiBJdCBjYW4gYmUgb24gb3Igb2ZmLCBidXQgYWxzbyBpbnRlcm5hbGx5IG9uIGJ1
dCBub3Qgc2VlbiBmcm9tIHVzZXItc3BhY2UuDQo+PiBUaGlzIG5vLWZzIG1vZGUgZG8gbm90IHJl
Z2lzdGVyIGEgZGVidWdmcyBhcyBmaWxlc3lzdGVtLCBidXQgY2xpZW50IGNhbg0KPj4gcmVnaXN0
ZXIgdGhlaXIgcGFydHMgaW4gdGhlIGludGVybmFsIHN0cnVjdHVyZXMuIFRoaXMgZGF0YSBjYW4g
YmUgcmVhZGVkDQo+PiB3aXRoIGEgZGVidWdnZXIgb3Igc2F2ZWQgd2l0aCBhIGNyYXNoa2VybmVs
LiBXaGVuIGl0IGlzIG9mZiBjbGllbnRzDQo+PiBnZXQgRVBFUk0gZXJyb3Igd2hlbiBhY2Nlc3Np
bmcgdGhlIGZ1bmN0aW9ucyBmb3IgcmVnaXN0ZXJpbmcgdGhlaXINCj4+IGNvbXBvbmVudHMuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29u
eS5jb20+DQo+PiAtLS0NCj4+ICAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0
ICAgICAgICAgfCAxNCArKysrKysrDQo+PiAgZnMvZGVidWdmcy9pbm9kZS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKw0KPj4gIGZzL2RlYnVnZnMv
aW50ZXJuYWwuaCAgICAgICAgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysNCj4+ICBsaWIv
S2NvbmZpZy5kZWJ1ZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzMiArKysrKysrKysr
KysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0
IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+IGlu
ZGV4IGZiOTVmYWQ4MWM3OS4uODA1YWEyZTU4NDkxIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+PiBAQCAtODI3LDYgKzgy
NywyMCBAQA0KPj4gIAkJCXVzZWZ1bCB0byBhbHNvIGVuYWJsZSB0aGUgcGFnZV9vd25lciBmdW5j
dGlvbmFsaXR5Lg0KPj4gIAkJCW9uOiBlbmFibGUgdGhlIGZlYXR1cmUNCj4+ICANCj4+ICsJZGVi
dWdmcz0gICAgCVtLTkxdIFRoaXMgcGFyYW1ldGVyIGVuYWJsZXMgd2hhdCBpcyBleHBvc2VkIHRv
IHVzZXJzcGFjZQ0KPj4gKwkJCWFuZCBkZWJ1Z2ZzIGludGVybmFsIGNsaWVudHMuDQo+PiArCQkJ
Rm9ybWF0OiB7IG9uLCBuby1mcywgb2ZmIH0NCj4+ICsJCQlvbjogCUFsbCBmdW5jdGlvbnMgYXJl
IGVuYWJsZWQuDQo+PiArCQkJbm8tZnM6IAlGaWxlc3lzdGVtIGlzIG5vdCByZWdpc3RlcmVkIGJ1
dCBrZXJuZWwgY2xpZW50cyBjYW4NCj4+ICsJCQkgICAgICAgIGFjY2VzcyBBUElzIGFuZCBhIGNy
YXNoa2VybmVsIGNhbiBiZSB1c2VkIHRvIHJlYWQNCj4+ICsJCQkJaXRzIGNvbnRlbnQuIFRoZXJl
IGlzIG5vdGhpbmcgdG8gbW91bnQuDQo+PiArCQkJb2ZmOiAJRmlsZXN5c3RlbSBpcyBub3QgcmVn
aXN0ZXJlZCBhbmQgY2xpZW50cw0KPj4gKwkJCSAgICAgICAgZ2V0IGEgLUVQRVJNIGFzIHJlc3Vs
dCB3aGVuIHRyeWluZyB0byByZWdpc3RlciBmaWxlcw0KPj4gKwkJCQlvciBkaXJlY3RvcmllcyB3
aXRoaW4gZGVidWdmcy4NCj4+ICsJCQkJVGhpcyBpcyBlcXVpbGl2YW50IG9mIHRoZSBydW50aW1l
IGZ1bmN0aW9uYWxpdHkgaWYNCj4+ICsJCQkJZGVidWdmcyB3YXMgbm90IGVuYWJsZWQgaW4gdGhl
IGtlcm5lbCBhdCBhbGwuDQo+PiArCQkJRGVmYXVsdCB2YWx1ZSBpcyBzZXQgaW4gYnVpbGQtdGlt
ZSB3aXRoIGEga2VybmVsIGNvbmZpZ3VyYXRpb24uDQo+IE5hbWluZyBpcyBoYXJkLiAgSW4gbG9v
a2luZyBhdCB0aGlzLCBzaG91bGQgIm5vLWZzIiBiZSBjYWxsZWQNCj4gIm5vLW1vdW50Ij8gIFRo
YXQncyBhIGJldHRlciBkZXNjcmlwdGlvbiBvZiB3aGF0IGl0IGRvZXMsIHJpZ2h0Pw0KT25lIG5h
bWUgdGhhdCBoYWQgaW4gbWluZCB3YXMgU3RlYWx0aC4gSXQgaXMgbW9yZSBvZiB3aGF0IGl0IGlz
IGludGVuZGVkIHRvIGRvIHRoYW4gaG93Lg0KPiBUaGVuIHdlIGNhbiByZW5hbWUgdGhlIGJpdHMg
dG8gbWF0Y2ggdGhlIGRvY3VtZW50YXRpb24gc28gd2UgYXJlbid0DQo+IGNvbnN0YW50bHkgdGhp
bmtpbmcgb2YgZGlmZmVyZW50IHRoaW5ncyBhbmQgdHJ5aW5nIHRvIG1hdGNoIHRoZW0gdXA6DQo+
DQo+DQo+PiAtLS0gYS9mcy9kZWJ1Z2ZzL2ludGVybmFsLmgNCj4+ICsrKyBiL2ZzL2RlYnVnZnMv
aW50ZXJuYWwuaA0KPj4gQEAgLTI5LDQgKzI5LDE4IEBAIHN0cnVjdCBkZWJ1Z2ZzX2ZzZGF0YSB7
DQo+PiAgICovDQo+PiAgI2RlZmluZSBERUJVR0ZTX0ZTREFUQV9JU19SRUFMX0ZPUFNfQklUIEJJ
VCgwKQ0KPj4gIA0KPj4gKy8qIEFjY2VzcyBCSVRTICovDQo+PiArI2RlZmluZSBERUJVR0ZTX0FM
TE9XX0FQSQlCSVQoMCkNCj4+ICsjZGVmaW5lIERFQlVHRlNfQUxMT1dfRlMJQklUKDEpDQo+ICNk
ZWZpbmUgREVCVUdGU19BTExPV19BUEkJQklUKDApDQo+ICNkZWZpbmUgREVCVUdGU19BTExPV19N
T1VOVAlCSVQoMSkNCj4NCj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTX0FDQ0VTU19BTEwNCj4+
ICsjZGVmaW5lIERFRkFVTFRfREVCVUdGU19BQ0NFU1NfQklUUyAoREVCVUdGU19BTExPV19GUyB8
IERFQlVHRlNfQUxMT1dfQVBJKQ0KPj4gKyNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdf
RlNfQUNDRVNTX05PX0ZTDQo+PiArI2RlZmluZSBERUZBVUxUX0RFQlVHRlNfQUNDRVNTX0JJVFMg
KERFQlVHRlNfQUxMT1dfQVBJKQ0KPj4gKyNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdf
RlNfQUNDRVNTX05PTkUNCj4+ICsjZGVmaW5lIERFRkFVTFRfREVCVUdGU19BQ0NFU1NfQklUUyAo
MCkNCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICAjZW5kaWYgLyogX0RFQlVHRlNfSU5URVJOQUxfSF8g
Ki8NCj4+IGRpZmYgLS1naXQgYS9saWIvS2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRlYnVn
DQo+PiBpbmRleCA5YWQ5MjEwZDcwYTEuLmI2MDlhZDdjMTM0MyAxMDA2NDQNCj4+IC0tLSBhL2xp
Yi9LY29uZmlnLmRlYnVnDQo+PiArKysgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPj4gQEAgLTQ3Niw2
ICs0NzYsMzggQEAgY29uZmlnIERFQlVHX0ZTDQo+PiAgDQo+PiAgCSAgSWYgdW5zdXJlLCBzYXkg
Ti4NCj4+ICANCj4+ICtjaG9pY2UNCj4+ICsJcHJvbXB0ICJEZWJ1Z2ZzIGRlZmF1bHQgYWNjZXNz
Ig0KPj4gKwlkZXBlbmRzIG9uIERFQlVHX0ZTDQo+PiArCWRlZmF1bHQgREVCVUdfRlNfQUNDRVNT
X0FMTA0KPiBkZWZhdWx0IERFQlVHRlNfRlNfQUxMT1dfQUxMDQo+DQo+PiArCWhlbHANCj4+ICsJ
ICBUaGlzIHNlbGVjdCB0aGUgZGVmYXVsdCBhY2Nlc3MgcmVzdHJpY2lvbnMgZm9yIGRlYnVnZnMu
DQo+PiArCSAgSXQgY2FuIGJlIG92ZXJyaWRkZW4gd2l0aCBrZXJuZWwgY29tbWFuZCBsaW5lIG9w
dGlvbg0KPj4gKwkgIGRlYnVnZnM9W29uLG5vLWZzLG9mZl0gVGhlIHJlc3RyaWN0aW9ucyBhcHBs
eSBmb3IgQVBJIGFjY2Vzcw0KPj4gKwkgIGFuZCBmaWxlc3lzdGVtIHJlZ2lzdHJhdGlvbi4gLg0K
Pj4gKw0KPj4gK2NvbmZpZyBERUJVR19GU19BQ0NFU1NfQUxMDQo+IGNvbmZpZyBERUJVR19GU19B
TExPV19BTEwNCj4NCj4+ICsgICAgICAgYm9vbCAiQWNjZXNzIG5vcm1hbCINCj4+ICsgICAgICAg
aGVscA0KPj4gKwkgIE5vIHJlc3RyaWN0aW9ucyBhcHBsaWVzLiBCb3RoIEFQSSBhbmQgZmlsZXN5
c3RlbSByZWdpc3RyYXRpb24NCj4+ICsJICBpcyBvbi4gVGhpcyBpcyB0aGUgbm9ybWFsIGRlZmF1
bHQgb3BlcmF0aW9uLg0KPj4gKw0KPj4gK2NvbmZpZyBERUJVR19GU19BQ0NFU1NfTk9fRlMNCj4g
Y29uZmlnIERFQlVHX0ZTX0RJU0FMTE9XX01PVU5UDQo+DQo+PiArICAgICAgIGJvb2wgIkRvIG5v
dCByZWdpc3RlciBkZWJ1Z2ZzIGFzIGZpbGVzeXN0ZW0iDQo+PiArICAgICAgIGhlbHANCj4+ICsJ
IFRoZSBBUEkgaXMgb3BlbiBidXQgZmlsZXN5c3RlbSBub3QgbG9hZGVkLiBDbGllbnQgY2FuIHN0
aWxsIGRvDQo+PiArCSB0aGVpciB3b3JrIGFuZCByZWFkZWQgd2l0aCBkZWJ1ZyB0b29scyB0aGF0
IGRvZXMgbm90IG5lZWQNCj4+ICsJIGRlYnVnZnMgZmlsZXN5c3RlbS4NCj4+ICsNCj4+ICtjb25m
aWcgREVCVUdfRlNfQUNDRVNTX05PTkUNCj4gY29uZmlnIERFQlVHX0ZTX0FMTE9XX05PTkUNCj4N
Cj4gRG9lcyB0aGF0IHNvdW5kIGJldHRlcj8NCj4NCj4gSSdtIG5vdCB0cnlpbmcgdG8gYmUgYSBw
YWluLCBqdXN0IHRyeWluZyB0byBuYW1lIHRoaXMgYWxsIGNvcnJlY3RseSBhcw0KPiBpdCdzIG1l
c3N5IHdpdGggZGlmZmVyZW50IGNvbmZpZyBvcHRpb25zIGFuZCBiaXRzIGFuZCBtYXBwaW5nIHRo
YXQgdG8NCj4gY2hlY2tzIGluIHRoZSBjb2RlIHdpdGhvdXQgZXZlcnl0aGluZyBjYWxsZWQgdGhl
IHNhbWUuDQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBrLWgNCg0K
