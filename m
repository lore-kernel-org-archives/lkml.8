Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A097C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A17B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="aPSmAV54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgHYEx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:53:27 -0400
Received: from mail-dm6nam08on2068.outbound.protection.outlook.com ([40.107.102.68]:52961
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgHYEx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIU+XMghcbuNWqF7XlRkLaaVePNE3GZjLZIW/ub+gqiFZ/+I/scyWEJLppzspMLDLfdfmt62knNAVT9pi8FvPqvlbfyNW9PUIrtpzJmCUImGlgWNrTYZ4+rl1tPfzvXhohGc0P0R0JHXq/C6RSLqQiEo8L1IgomPByAZhXQqG91iSaRNUMWTH8cykHywB984OrCoDwuzhL73y4ieqL+bbev0s2nMGIekAgFENaYXZEFkDeuAAknh1BfyFRNOtDPhqqYenoLMci7MPeXNUfqs9RHWrPPy/7Y6FPR8ogtE4hhOj7euZwRHwvFa3ndXHsy6CYtUKa+Qa9RrTHq+ayN/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF3YIjgPxUrY4zloqL+FLQGYcP14KRCTY4O6AUKdzIQ=;
 b=RcdOPDlYpoReXFyGcLspX9JtXTmdDT5eaey5aEKNGxFPOKkAON0Br6ETqsEWjsoVg9iIAASJibfDF6U7Zlq6zW5DHt2p0V/FLep0Z2Y4kiO2glsx79WNqNdGwEw7VaNVYEQsJhTpeDfApbUR9Ko1ZsEP7XODebA40bLH4XO5rVQtrh+9rfY/dFsyQSRWjqbHGdjNvC/Xer3SAUjXTrHE2CG0zsqbNo4zbt+HsMbnJQdXXgleiVolT2BLsEVF4CY/5UTb9oP6NsyPzWVpGDt+sp974oSstYSWemT5DPNeBvgAyzy9kjAXQML97euM7g81D6sBUNetMUqUqIRKvZTTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF3YIjgPxUrY4zloqL+FLQGYcP14KRCTY4O6AUKdzIQ=;
 b=aPSmAV54cshcZuz3rsmMJSKHqcri18Z1rKKK214u9636F8OQNOVMx6fsat9RXvhUwDhPIW2ygms1IRO6uyerL9RwM32otOt8ENmTf+nWXBUY+VaXijamWIsP/3ZxzaikUaRJPO3GTB7F9S35z1WV2AsFinjS9RLJZU1jJT+IOf4=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2839.namprd11.prod.outlook.com (2603:10b6:a02:c8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 04:53:22 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 04:53:21 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "elver@google.com" <elver@google.com>,
        "longman@redhat.com" <longman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgY3B1IGhvdHBs?=
 =?gb2312?Q?ug_callback?=
Thread-Topic: [PATCH] debugobjects: install cpu hotplug callback
Thread-Index: AQHWdqGQIvF/RGEPjEiN5JxhAX5OO6lISeXK
Date:   Tue, 25 Aug 2020 04:53:21 +0000
Message-ID: <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
In-Reply-To: <20200820032453.5222-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 461abb61-c612-49e7-b1a4-08d848b2cafe
x-ms-traffictypediagnostic: BYAPR11MB2839:
x-microsoft-antispam-prvs: <BYAPR11MB28397695170655C11ADC29E6FF570@BYAPR11MB2839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbAFAOoDrY+9ontH5y278+CF+oYq655VWwem/SSL7FbeoVXwhBi7t0wQEdzlOC8uEd13AGbOjmgDJji+K535QlO7AqjYhiTro7ttPAmphHyG7po9IutMUeJArfKZ0WQ1zo/yv4PbJPMByu6gv90uYg50PjjrmBkUz/ArLp9IRLE6kwIEORpfgaYBPXgOyig6y4MIRNHhlAm9TN2nibAmAeomrhY5A+fo8Pa2Awj86qjB8HbMEQ0wlCPD1t+GwacivN9QJkGkzJZGUFhDqXu3U/r/yrt79eVsZYRuorzjFm3l3FZ3eSELTpX/huAIkPD7vGci0/X8HYOq9z3cj8FGOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(376002)(346002)(136003)(52536014)(71200400001)(33656002)(478600001)(2906002)(8936002)(55016002)(86362001)(224303003)(110136005)(54906003)(6506007)(66446008)(26005)(66946007)(316002)(64756008)(66476007)(76116006)(91956017)(66556008)(5660300002)(186003)(7696005)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AuMNl9sZyTfqN3dZq9lW3QmnVUeVXzicyNk3TVnMxPhroxwV8fzZBQNGMzu8hgnyR2wRYil1zfAYiD5jcR67X1ZEtkvI9kq/gsWIGTNNSW3wcwY7oau9ClDYEAnqhZXstHdcLQJgRcJbhZUB8plCrvfOmz/yO0XpnJQ9NWcISTWP1SM9v0Jn27GPKS+WxkTImcmjBX9I6Saw+1s5eCkIvxWXyZRQ1875Yhp2jUbTkwu09BhfocjdQwCR3MeN+9WuJGIKw4wVqMdPf7eCFbxtXXtiMIU0W40TDeXO8AGsC2NJFWGzlhI4g2hD/StR6MDFj8EKR0c7Lw8RjMNKQaEB/QhMe2ElGahA4xulr06QDyD/1FynkMrGGjNgP/9zR+kXQQdrd9lt/DTJZCps2ZErl9NHNQZbQkF4ui63Re8pc4eHULcEIqJ49c/miQUVLA+muwwXLKFLvgfAb58vtNp3CrdEfwB9cOFXupPlsf/b0FQPcw00T5Acx2PoFFLR53H20tWgjo/IEdZzGpz9z8pklsoHVvmHbF5g7PzF/Scb2Z89cHU2ZzVJDBqGETzNCG/n+e6kg3xCxIPeRZmOayVOkUyzlGGudB1WTmvNFKSu7FRAb5P3bStFjNyzSSZDl637UacfyhxjG3LrHijR4cv4aA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461abb61-c612-49e7-b1a4-08d848b2cafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 04:53:21.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PX5UERxwp0N0yid8wgANfRGMjTt2JbCVS791im2Tb2XURBMRDp6URqbOJ8yecx8I5mdk6HK1d550rS1BSWM8CHXcu2aRzjdCwlBBTqX7s6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IGxpbnV4
LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtl
cm5lbC5vcmc+ILT6se0gcWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbSA8cWlhbmcuemhhbmdAd2lu
ZHJpdmVyLmNvbT4NCreiy83KsbzkOiAyMDIwxOo41MIyMMjVIDExOjI0DQrK1bz+yMs6IHRnbHhA
bGludXRyb25peC5kZTsgZWx2ZXJAZ29vZ2xlLmNvbTsgbG9uZ21hbkByZWRoYXQuY29tDQqzrcvN
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBbUEFUQ0hdIGRlYnVnb2JqZWN0
czogaW5zdGFsbCBjcHUgaG90cGx1ZyBjYWxsYmFjaw0KDQpGcm9tOiBacWlhbmcgPHFpYW5nLnpo
YW5nQHdpbmRyaXZlci5jb20+DQoNCldoZW4gYSBjcHUgZ29pbmcgb2ZmbGluZSwgd2Ugc2hvdWxk
IGZyZWUgb2JqZWN0cyBpbiAicGVyY3B1X29ial9wb29sIg0KZnJlZV9vYmpzIGxpc3Qgd2hpY2gg
Y29ycmVzcG9uZGluZyB0byB0aGlzIGNwdS4NCg0KU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFu
Zy56aGFuZ0B3aW5kcml2ZXIuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgg
fCAgMSArDQogbGliL2RlYnVnb2JqZWN0cy5jICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysr
KysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmggYi9pbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcu
aA0KaW5kZXggYTI3MTBlNjU0YjY0Li4yZTc3ZGI2NTVjZmEgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2xpbnV4L2NwdWhvdHBsdWcuaA0KKysrIGIvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgNCkBA
IC0zNiw2ICszNiw3IEBAIGVudW0gY3B1aHBfc3RhdGUgew0KICAgICAgICBDUFVIUF9YODZfTUNF
X0RFQUQsDQogICAgICAgIENQVUhQX1ZJUlRfTkVUX0RFQUQsDQogICAgICAgIENQVUhQX1NMVUJf
REVBRCwNCisgICAgICAgQ1BVSFBfREVCVUdfT0JKX0RFQUQsDQogICAgICAgIENQVUhQX01NX1dS
SVRFQkFDS19ERUFELA0KICAgICAgICBDUFVIUF9NTV9WTVNUQVRfREVBRCwNCiAgICAgICAgQ1BV
SFBfU09GVElSUV9ERUFELA0KZGlmZiAtLWdpdCBhL2xpYi9kZWJ1Z29iamVjdHMuYyBiL2xpYi9k
ZWJ1Z29iamVjdHMuYw0KaW5kZXggZmU0NTU3OTU1ZDk3Li41MGUyMWVkMDUxOWUgMTAwNjQ0DQot
LS0gYS9saWIvZGVidWdvYmplY3RzLmMNCisrKyBiL2xpYi9kZWJ1Z29iamVjdHMuYw0KQEAgLTE5
LDYgKzE5LDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9o
YXNoLmg+DQogI2luY2x1ZGUgPGxpbnV4L2ttZW1sZWFrLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Nw
dS5oPg0KDQogI2RlZmluZSBPREVCVUdfSEFTSF9CSVRTICAgICAgIDE0DQogI2RlZmluZSBPREVC
VUdfSEFTSF9TSVpFICAgICAgICgxIDw8IE9ERUJVR19IQVNIX0JJVFMpDQpAQCAtNDMzLDYgKzQz
NCwyMyBAQCBzdGF0aWMgdm9pZCBmcmVlX29iamVjdChzdHJ1Y3QgZGVidWdfb2JqICpvYmopDQog
ICAgICAgIH0NCiB9DQoNCisjaWYgZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpDQorc3RhdGlj
IGludCBvYmplY3RfY3B1X29mZmxpbmUodW5zaWduZWQgaW50IGNwdSkNCit7DQorICAgICAgIHN0
cnVjdCBkZWJ1Z19wZXJjcHVfZnJlZSAqcGVyY3B1X3Bvb2w7DQorICAgICAgIHN0cnVjdCBobGlz
dF9ub2RlICp0bXA7DQorICAgICAgIHN0cnVjdCBkZWJ1Z19vYmogKm9iajsNCisNCisgICAgICAg
cGVyY3B1X3Bvb2wgPSBwZXJfY3B1X3B0cigmcGVyY3B1X29ial9wb29sLCBjcHUpOw0KKyAgICAg
ICBobGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKG9iaiwgdG1wLCAmcGVyY3B1X3Bvb2wtPmZyZWVf
b2Jqcywgbm9kZSkgew0KKyAgICAgICAgICAgICAgIGhsaXN0X2RlbCgmb2JqLT5ub2RlKTsNCisg
ICAgICAgICAgICAgICBrbWVtX2NhY2hlX2ZyZWUob2JqX2NhY2hlLCBvYmopOw0KKyAgICAgICB9
DQorDQorICAgICAgIHJldHVybiAwOw0KK30NCisjZW5kaWYNCisNCiAvKg0KICAqIFdlIHJ1biBv
dXQgb2YgbWVtb3J5LiBUaGF0IG1lYW5zIHdlIHByb2JhYmx5IGhhdmUgdG9ucyBvZiBvYmplY3Rz
DQogICogYWxsb2NhdGVkLg0KQEAgLTEzNjcsNiArMTM4NSwxMSBAQCB2b2lkIF9faW5pdCBkZWJ1
Z19vYmplY3RzX21lbV9pbml0KHZvaWQpDQogICAgICAgIH0gZWxzZQ0KICAgICAgICAgICAgICAg
IGRlYnVnX29iamVjdHNfc2VsZnRlc3QoKTsNCg0KKyNpZiBkZWZpbmVkKENPTkZJR19IT1RQTFVH
X0NQVSkNCisgICAgICAgY3B1aHBfc2V0dXBfc3RhdGVfbm9jYWxscyhDUFVIUF9ERUJVR19PQkpf
REVBRCwgIm9iamVjdDpvZmZsaW5lIiwgTlVMTCwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBvYmplY3RfY3B1X29mZmxpbmUpOw0KKyNlbmRpZg0KKw0KICAgICAgICAv
Kg0KICAgICAgICAgKiBJbmNyZWFzZSB0aGUgdGhyZXNob2xkcyBmb3IgYWxsb2NhdGluZyBhbmQg
ZnJlZWluZyBvYmplY3RzDQogICAgICAgICAqIGFjY29yZGluZyB0byB0aGUgbnVtYmVyIG9mIHBv
c3NpYmxlIENQVXMgYXZhaWxhYmxlIGluIHRoZSBzeXN0ZW0uDQotLQ0KMi4xNy4xDQoNCg==
