Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65852C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B0206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lojSsEUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgGOKEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:04:16 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:36154 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgGOKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:04:15 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FA0wJS025167;
        Wed, 15 Jul 2020 10:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=PooDxYSIqGSe1gh5CMvtpIR3Xazaz91KUSvazsrts9s=;
 b=lojSsEUhUfVae9JzQCzodkGv89IShOKSaabAQad1TzUCliKDPf+DAlCrue/nONnsouou
 KkLBgBi0qxAC/AUe9hisShJ3e+u/TDtJVMruKmAGu59PEqVxfBH+rZ/qWYmd77nie8fq
 p69Id32YgYN9Qb8A/dXxJQTBYPzT+iK3OMPg+Jc9e2A2kB0T0SXQL3PCJiStV//ycbF1
 l49p+VZMiXzCz/20EUZzc1JLuHeuT7Fb3b9xVTR3s1B0UrRjdjvXlvUUbtvg+ZjKXXPe
 hrtxUO4SlT2QmbrYxeEUP5OLao4UIYMLJZGur5NpGnjIPWL+Lgy/47Itr4KAr+cdhE5Y OA== 
Received: from eur02-he1-obe.outbound.protection.outlook.com (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59])
        by mx08-001d1705.pphosted.com with ESMTP id 3273mesqfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 10:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCR7SUkCNOkL41t7zIKMAa6IonZmlwNqJBouGebiGuAANgNyEP9ToSgu9agPcKSsDC3cUybQQdMN81Zdd5LGhC/vP0FeDmO8R6JCk+WE4PJQzQM47Hse3KGi5BybPtUT7PpNb1wL1+Yk37koCgtrgoqY1RiUl6NO3//RIVFdrrwH87FG3C+Ex166nGfkQe53O2lNNTHBcVQct8ShcG0CralXxVNIw8tOJFLRAR4mTLmkiNN4eh/4iaHTFpobu7qcCt4CB5TYAkqnjKLRWD8i1nbMQxaykcAV3CzLaY5M54Nvg+rWdCwpn1bUsh3+NWETEkruQjNjpiZ0C4ffUY3ENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PooDxYSIqGSe1gh5CMvtpIR3Xazaz91KUSvazsrts9s=;
 b=mePMgSum6cDJ7EnqlRr8yAZVKDaTpHP1hoPgEHsAkL5+usAeEOxdB/FnLRQVHysGXcX7nfvy8agC9vP9xAM98ckBVosDU4+tBZu6zYERGp26O1fiiqebwSRheRdQnf4VuoLLxtTV5B/zKPunx/sH/E3D1UgOEH/Fc33wiFFSHFaq/5E8Gzmx51pL0oWaPUujELnM8Qgsj/1Ok3TBvwkfim6p5lnbpHcFKXe5+gsO2RoS6u7mHjcjTwAPUI2pEs1J+I1bv2Y8MdBvdKiNkAGN+z0f+nXedp9ji/BhppXEiGnB/hUFXqCjKCrqK6r3vf66kdI3fU9KdT9XfjWvzJNzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:14b::8)
 by AM0P193MB0563.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 10:03:19 +0000
Received: from AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7]) by AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
 ([fe80::b0e8:5856:6fa9:71b7%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 10:03:19 +0000
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
Thread-Index: AQHWWoPfDn+JEjIBf0W3BsLx2no9AqkIYomAgAAGt4A=
Date:   Wed, 15 Jul 2020 10:03:19 +0000
Message-ID: <a07943bf-fb7f-872d-4bc6-307bbaf57a3f@sony.com>
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
x-ms-office365-filtering-correlation-id: fb1b7d32-60b9-439d-7d38-08d828a64cea
x-ms-traffictypediagnostic: AM0P193MB0563:
x-microsoft-antispam-prvs: <AM0P193MB0563CA4FABCE7AF05A448A75867E0@AM0P193MB0563.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmJdoebMrZCB2plEJTtxMsZy4/ph+yekaL9PT7AiDvZyx7aBNqqBbuB+N/vRTKdARdp1s1/Ump7NHtUGb8NJJQU4l98xYOrJbpbsUaPbXKu6cT15Di24K1Uwq6W2hhegmEX1OiISDnaHLms6ShMO7Kx5LuPHH7DbWf5pjsxWMXpBX5uJuVtmm0nVKJu8+0WlzJPs41THkUN7F7cQkfcpgoZ220cSNwmvAO8MRnfndJUdKtgHToVKRRbcpGLVgsGEq3xt0/IcVnEiRtMQJg1egT7I0no5CIssRzfPtv5xdxKF1bmow1g/Xtc8gyf4EkUNwocLOnbnN7qvmz3prZgiOETM5CVWqcsRlO/MGZZz4p0uX/IFdQfYcI1FRomZ21uK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0626.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(64756008)(66476007)(36756003)(66556008)(66446008)(8676002)(316002)(54906003)(91956017)(6512007)(66946007)(86362001)(76116006)(8936002)(6486002)(186003)(31686004)(31696002)(6916009)(478600001)(26005)(5660300002)(53546011)(2906002)(6506007)(2616005)(83380400001)(4326008)(71200400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fHjf9tLk98bbEv6TFh3ml08HDzTIL9lPEEPQpAb1G2ns/MxyyMKwvttfKMbV2GQ93xOajBC96vmD58ID/0RfjBlr7ftuc3BYM0ViYSIqZ6vxpJiUf29AJ/XdVRlCSvlfgDiVEhDANrH7mcuW05pa26s1SUae7zc6NzhqmKSfmpbqXk5uXz1nlyweyaC9jaamzusESqluTDSSV2+vAyYRa2jF2aEs3mH+YGp84KpLd0hSvjcvE7t0XPqFDQoxutCD+QEagFddzMsmpeemVe5/Z2FVmqKFoaZfAUJKrEAnoVM0MXqWN2eLIe9mGQWqw0xdbWjcM5AacsEbcNp69iivyzGqZKHNIjcnKkvQNF2MC6dx83NEKstdwtYtNMOBh8xkJs0tZRID/FPN0twq6sR30DuHVoKVfHV1o13LVWzR5+/oBaiyJnTf7kCD3Pb5kBhT5YITfr13HQC1Nfvnr9lyYS7ukDrt+aoqdruL4OJPp3Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E786E8E0AAE6E4BAE42B0EDFCB5E930@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0626.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1b7d32-60b9-439d-7d38-08d828a64cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 10:03:19.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AERPoE4atQRnYgaBgDoy86tyydfXR5MgJKa19osIADEuPYp+qoXF+nUt5E4opi0DAOKcsyC+/3SC/FRKwpXdXFaHfHSrDGvvxN28lhMAubE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0563
X-Sony-Outbound-GUID: jnP3RJNbW_pUljqRFfyQFwUMl5qoe1zj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_07:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150083
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
YXQncyBhIGJldHRlciBkZXNjcmlwdGlvbiBvZiB3aGF0IGl0IGRvZXMsIHJpZ2h0Pw0KDQpJIHRo
aW5rIG5vLWZzIGNvdmVyIGl0IGJldHRlciBzaW5jZSBpdCBkb2VzIG5vdCByZWdpc3RlciBhIGZp
bGVzeXN0ZW0NCmJ1dCBwcm92aWRlcyB0aGUgaW50ZXJmYWNlcy4gTW91bnRpbmcgaXMgdGhlbiBp
bmRpcmVjdGx5IHN0b3BwZWQuDQoNClRoZSBpZGVhIHN0YXJ0IHdpdGggYSBjaGVjayBmb3IgbW91
bnRpbmcgYnV0IGl0IGlzIG11Y2ggbW9yZQ0KZGVmaW5pdGVseSBzdG9wcGVkIGJ5IHByZXZlbnRp
b24gb2YgcmVnaXN0ZXIgb2YgdGhlIGZpbGVzeXN0ZW0uDQpJIGNhbiBpbWFnaW5lIHRvIGhhdmUg
YSBmb3J0aCAibW9kZSIgd2hlcmUgaXQgcmVnaXN0ZXIgYSBmcyBidXQNCm5vdCBhbGxvd2luZyBt
b3VudGluZy4gU3VjaCBtb2RlIG1heWJlIHVzZWZ1bCBmb3Igc29tZSBydW50aW1lDQpjb25maWd1
cmF0aW9uLiBCdXQgdGhpcyBwYXRjaCBpcyBhYm91dCBib290IHRpbWUgY29uZmlndXJhdGlvbi4N
Cg0KPiBUaGVuIHdlIGNhbiByZW5hbWUgdGhlIGJpdHMgdG8gbWF0Y2ggdGhlIGRvY3VtZW50YXRp
b24gc28gd2UgYXJlbid0DQo+IGNvbnN0YW50bHkgdGhpbmtpbmcgb2YgZGlmZmVyZW50IHRoaW5n
cyBhbmQgdHJ5aW5nIHRvIG1hdGNoIHRoZW0gdXA6DQo+DQo+DQo+PiAtLS0gYS9mcy9kZWJ1Z2Zz
L2ludGVybmFsLmgNCj4+ICsrKyBiL2ZzL2RlYnVnZnMvaW50ZXJuYWwuaA0KPj4gQEAgLTI5LDQg
KzI5LDE4IEBAIHN0cnVjdCBkZWJ1Z2ZzX2ZzZGF0YSB7DQo+PiAgICovDQo+PiAgI2RlZmluZSBE
RUJVR0ZTX0ZTREFUQV9JU19SRUFMX0ZPUFNfQklUIEJJVCgwKQ0KPj4gIA0KPj4gKy8qIEFjY2Vz
cyBCSVRTICovDQo+PiArI2RlZmluZSBERUJVR0ZTX0FMTE9XX0FQSQlCSVQoMCkNCj4+ICsjZGVm
aW5lIERFQlVHRlNfQUxMT1dfRlMJQklUKDEpDQo+ICNkZWZpbmUgREVCVUdGU19BTExPV19BUEkJ
QklUKDApDQo+ICNkZWZpbmUgREVCVUdGU19BTExPV19NT1VOVAlCSVQoMSkNCj4NCj4+ICsjaWZk
ZWYgQ09ORklHX0RFQlVHX0ZTX0FDQ0VTU19BTEwNCj4+ICsjZGVmaW5lIERFRkFVTFRfREVCVUdG
U19BQ0NFU1NfQklUUyAoREVCVUdGU19BTExPV19GUyB8IERFQlVHRlNfQUxMT1dfQVBJKQ0KPj4g
KyNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlNfQUNDRVNTX05PX0ZTDQo+PiArI2Rl
ZmluZSBERUZBVUxUX0RFQlVHRlNfQUNDRVNTX0JJVFMgKERFQlVHRlNfQUxMT1dfQVBJKQ0KPj4g
KyNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlNfQUNDRVNTX05PTkUNCj4+ICsjZGVm
aW5lIERFRkFVTFRfREVCVUdGU19BQ0NFU1NfQklUUyAoMCkNCj4+ICsjZW5kaWYNCj4+ICsNCj4+
ICAjZW5kaWYgLyogX0RFQlVHRlNfSU5URVJOQUxfSF8gKi8NCj4+IGRpZmYgLS1naXQgYS9saWIv
S2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRlYnVnDQo+PiBpbmRleCA5YWQ5MjEwZDcwYTEu
LmI2MDlhZDdjMTM0MyAxMDA2NDQNCj4+IC0tLSBhL2xpYi9LY29uZmlnLmRlYnVnDQo+PiArKysg
Yi9saWIvS2NvbmZpZy5kZWJ1Zw0KPj4gQEAgLTQ3Niw2ICs0NzYsMzggQEAgY29uZmlnIERFQlVH
X0ZTDQo+PiAgDQo+PiAgCSAgSWYgdW5zdXJlLCBzYXkgTi4NCj4+ICANCj4+ICtjaG9pY2UNCj4+
ICsJcHJvbXB0ICJEZWJ1Z2ZzIGRlZmF1bHQgYWNjZXNzIg0KPj4gKwlkZXBlbmRzIG9uIERFQlVH
X0ZTDQo+PiArCWRlZmF1bHQgREVCVUdfRlNfQUNDRVNTX0FMTA0KPiBkZWZhdWx0IERFQlVHRlNf
RlNfQUxMT1dfQUxMDQo+DQo+PiArCWhlbHANCj4+ICsJICBUaGlzIHNlbGVjdCB0aGUgZGVmYXVs
dCBhY2Nlc3MgcmVzdHJpY2lvbnMgZm9yIGRlYnVnZnMuDQo+PiArCSAgSXQgY2FuIGJlIG92ZXJy
aWRkZW4gd2l0aCBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbg0KPj4gKwkgIGRlYnVnZnM9W29u
LG5vLWZzLG9mZl0gVGhlIHJlc3RyaWN0aW9ucyBhcHBseSBmb3IgQVBJIGFjY2Vzcw0KPj4gKwkg
IGFuZCBmaWxlc3lzdGVtIHJlZ2lzdHJhdGlvbi4gLg0KPj4gKw0KPj4gK2NvbmZpZyBERUJVR19G
U19BQ0NFU1NfQUxMDQo+IGNvbmZpZyBERUJVR19GU19BTExPV19BTEwNCj4NCj4+ICsgICAgICAg
Ym9vbCAiQWNjZXNzIG5vcm1hbCINCj4+ICsgICAgICAgaGVscA0KPj4gKwkgIE5vIHJlc3RyaWN0
aW9ucyBhcHBsaWVzLiBCb3RoIEFQSSBhbmQgZmlsZXN5c3RlbSByZWdpc3RyYXRpb24NCj4+ICsJ
ICBpcyBvbi4gVGhpcyBpcyB0aGUgbm9ybWFsIGRlZmF1bHQgb3BlcmF0aW9uLg0KPj4gKw0KPj4g
K2NvbmZpZyBERUJVR19GU19BQ0NFU1NfTk9fRlMNCj4gY29uZmlnIERFQlVHX0ZTX0RJU0FMTE9X
X01PVU5UDQo+DQo+PiArICAgICAgIGJvb2wgIkRvIG5vdCByZWdpc3RlciBkZWJ1Z2ZzIGFzIGZp
bGVzeXN0ZW0iDQo+PiArICAgICAgIGhlbHANCj4+ICsJIFRoZSBBUEkgaXMgb3BlbiBidXQgZmls
ZXN5c3RlbSBub3QgbG9hZGVkLiBDbGllbnQgY2FuIHN0aWxsIGRvDQo+PiArCSB0aGVpciB3b3Jr
IGFuZCByZWFkZWQgd2l0aCBkZWJ1ZyB0b29scyB0aGF0IGRvZXMgbm90IG5lZWQNCj4+ICsJIGRl
YnVnZnMgZmlsZXN5c3RlbS4NCj4+ICsNCj4+ICtjb25maWcgREVCVUdfRlNfQUNDRVNTX05PTkUN
Cj4gY29uZmlnIERFQlVHX0ZTX0FMTE9XX05PTkUNCj4NCj4gRG9lcyB0aGF0IHNvdW5kIGJldHRl
cj8NCj4NCj4gSSdtIG5vdCB0cnlpbmcgdG8gYmUgYSBwYWluLCBqdXN0IHRyeWluZyB0byBuYW1l
IHRoaXMgYWxsIGNvcnJlY3RseSBhcw0KPiBpdCdzIG1lc3N5IHdpdGggZGlmZmVyZW50IGNvbmZp
ZyBvcHRpb25zIGFuZCBiaXRzIGFuZCBtYXBwaW5nIHRoYXQgdG8NCj4gY2hlY2tzIGluIHRoZSBj
b2RlIHdpdGhvdXQgZXZlcnl0aGluZyBjYWxsZWQgdGhlIHNhbWUuDQo+DQo+IHRoYW5rcywNCj4N
Cj4gZ3JlZyBrLWgNCg0K
