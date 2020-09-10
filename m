Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D11C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C645D20732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="BHCFq1Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgIJCFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:05:08 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:57795
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbgIJBtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LglQtScYCpPqqsN51fP6quD0sIngBEnU9lyMfR45j+Hu6hDEdECu5Polu0Vz/kYGjRUXduKQXt/+LIiqS44TD24ZyzDb0VKq+iOoJ9w4RY0Lvl3qeHWY6/RQrRlqh5QA24RHIn4QVWBOhaqUiLXHRMsSa6AS/rLKsgH55b6BMJ/yulP7vt2ZYsqqWGz+qLhoWa19ZlA0NannbMAdP2V4WAr+J1aanUDyc3Hxssz7gE3De1bns5lDzEAtIJWtBKP44UFHbA3vg90epSQcDEUkWIhmCH/j7GtvfYvu+DLSVqgpKXaVhdTReRcZUsNZoZBoxY8cKlpLe0zICYfhxq38kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWdwzZtv/SnxvpEyrw+QtMWhS2B8ekcvFGuRKwMKhUQ=;
 b=eyvdb6hOHqZzuJgOR8CCEP8PlVIJ+mNvxoqjwFOvVTKYwp6NG58816iDa0ZIo+JUhhR2YvEk+NJIRfCgYytopkjlna1YEtYqVvHRw27U1RSpL4e0FYNGsljRWaUv3rACFrGSq1lbjCXMBtFATNDhFulsFT01fDc74N7Ui8gmp9U95kLB7ElQjvTIvXfLxujNlgh9PIuVA2DwFM6NjAICOvW++tZtQBlcmuc4GDt1CmyIXjUXubkbhnI3VHJzD3QCNjWf1YhSfiBj2CNCa3XSyya6dSgtfGg2BkoHcjON8rDVRERXlZ7z9lmohqJWHskGxECBWz7ChqgY4BZ4vgfWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWdwzZtv/SnxvpEyrw+QtMWhS2B8ekcvFGuRKwMKhUQ=;
 b=BHCFq1GnuQH4+kGV2RuwMspVCqcSMmTwfD6tAj9eHXyIEYgkyLZD/u81PU4PpC8QUwcqfEKCxcL01mdKIUb4MMM1YUKUPOVgRd7bLWndKJNFw0nO33L73+57gY3t/QVrItdodyc6QlMVOopa+h4qwFwkT7RILh7sZZElG4S14t0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 01:48:55 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 01:48:54 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Waiman Long <longman@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "elver@google.com" <elver@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgQ1BVIGhv?=
 =?gb2312?Q?tplug_callback?=
Thread-Topic: [PATCH v3] debugobjects: install CPU hotplug callback
Thread-Index: AQHWhak78PcybWLZjESEa6PIBhrPbqlfDv6AgAINe3U=
Date:   Thu, 10 Sep 2020 01:48:54 +0000
Message-ID: <BYAPR11MB26324FE54B890DD73417F6B8FF270@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200908062709.11441-1-qiang.zhang@windriver.com>,<3bcdacd0-10c4-78c0-6e63-a73811a0ced6@redhat.com>
In-Reply-To: <3bcdacd0-10c4-78c0-6e63-a73811a0ced6@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63249d2a-cd3a-4037-990c-08d8552bad25
x-ms-traffictypediagnostic: BYAPR11MB2806:
x-microsoft-antispam-prvs: <BYAPR11MB2806CC5F032F859915087626FF270@BYAPR11MB2806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzxQkFbg2rS1PMlCy+AYKP8UbJ0BWP2oKyQjDneYXY8uARg5rMLs9xiWq1fdLC/gLLSXhUOyeAX6UlBR7QGBXaD6glifHzPqwzTAB35I09okDdwXMHZu0Tj3B4j4j2t7SVTHWnJj0nCmmrNQYnW4/YX6mG8lPwtInVtUpinwZLwcRT0X1jVnbCNGHI7BQ/OzC6R4Bghpc9KEHVLASMWfjwp1d4L/5d8y4nmjkmZ/cmz68HPiYy6HhPg8kgJuSzkXLvT6TgeDHvvdn2qpCxT2pxJeA8VYC/g0bEGnb/UXdgQmdtijhRsQ6p9YbygAh9aIWQy9XEmMI0JcjIixXNWXkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(66446008)(64756008)(66556008)(76116006)(66946007)(66476007)(91956017)(8936002)(83380400001)(33656002)(316002)(52536014)(5660300002)(7696005)(71200400001)(6506007)(26005)(186003)(2906002)(478600001)(224303003)(110136005)(55016002)(86362001)(9686003)(53546011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PlkD5hAeEzIej6saqGSXoZiIEoybkkK5WUPuhH91AHD3EIz5STowRCbk1+EdzjKeOff5u7UQWpNXo5niCPOjV6cUzn3WE+ONOMRh8jF+tCkOsGNof2PZSqVT/hW0iwbA8OpTOmEQjiCWtT9ag9v+lrvtVRQ2+6AfwZLe8lfCnhs0ulibLZqlz68qBGxW+vQt1bVcFVPCBny+wfX1UpdtuH+aa5xgCZZaeQq9AWmc5Ln9xBnSzpXWKO1Nzm7Fi5a+bOEfNQyiLRQ1wGM/QK5vkbxolWRqUvPeIcn9GuO87f+vqPPYsHSaC88cqg+T8E7iyGtjzzh86ihGr1LoihsXLEvH7ELOeWVwkVVq067Y4YCZtGwF3tIUEbFXoA1MWuTo9gozFGPC9jCagyWRBReTgltVfSVg884nNDn9djLAMtd/n9F5M2P+oJ/tOidaGH98Lm9pofQfOzAOnJgyEa25W8EFOu6brSAy1BAIxHrRFGqpNGfgAjJtmyrt9wRfDM0wwI7aE+QaQgEZVq84H4MVq5rcWstblJxM4xLOVyF/jE8B2mM6w24l7xDLUDOTWBFLmcdeXOZ58jzyIGJmR3MQfnqlhwhUG+p0l+BReTPSISUAQQxl9rXEF+XmA9EJgMDjb+mxGj27ChzVnoxoWpAsUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63249d2a-cd3a-4037-990c-08d8552bad25
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 01:48:54.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey5JkbkU7RNbph7wgIwWzpNIGuuzqF/nwiPCksvW1UXo3xnjz+vQdKoyqavnabb9jc7QvaOcvi0QCXukeM6nG/oyoAn3dA+96Zkza1LS98g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogV2FpbWFu
IExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4Kt6LLzcqxvOQ6IDIwMjDE6jnUwjnI1SAyOjIzCsrV
vP7IyzogWmhhbmcsIFFpYW5nOyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQGtlcm5lbC5vcmc7
IGVsdmVyQGdvb2dsZS5jb20Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW98zi
OiBSZTogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgQ1BVIGhvdHBsdWcgY2FsbGJh
Y2sKCk9uIDkvOC8yMCAyOjI3IEFNLCBxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tIHdyb3RlOgo+
IEZyb206IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPgo+IER1ZSB0byBDUFUg
aG90cGx1ZywgaXQgbWF5IG5ldmVyIGJlIG9ubGluZSBhZnRlciBpdCdzIG9mZmxpbmUsCj4gc29t
ZSBvYmplY3RzIGluIHBlcmNwdSBwb29sIGlzIG5ldmVyIGZyZWUuIGluIG9yZGVyIHRvIGF2b2lk
Cj4gdGhpcyBoYXBwZW5pbmcsIGluc3RhbGwgQ1BVIGhvdHBsdWcgY2FsbGJhY2ssIGNhbGwgdGhp
cyBjYWxsYmFjawo+IGZ1bmMgdG8gZnJlZSBvYmplY3RzIGluIHBlcmNwdSBwb29sIHdoZW4gQ1BV
IGdvaW5nIG9mZmxpbmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5nQHdp
bmRyaXZlci5jb20+Cj4gLS0tCj4gICB2MS0+djI6Cj4gICBNb2RpZnkgc3VibWlzc2lvbiBpbmZv
cm1hdGlvbi4KPgo+ICAgdjItPnYzOgo+ICAgSW4gQ1BVIGhvdHBsdWcgY2FsbGJhY2sgZnVuYywg
YWRkIGNsZWFyIHBlcmNwdSBwb29sICJvYmpfZnJlZSIgb3BlcmF0aW9uLgo+ICAgY2FwaXRhbGl6
ZSAnQ1BVJywgYW5kIHVzZSBzaG9ydGVyIHByZXByb2Nlc3NvciBzZXF1ZW5jZS4KPgo+ICAgaW5j
bHVkZS9saW51eC9jcHVob3RwbHVnLmggfCAgMSArCj4gICBsaWIvZGVidWdvYmplY3RzLmMgICAg
ICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jcHVob3RwbHVn
LmggYi9pbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaAo+IGluZGV4IDMyMTUwMjNkNDg1Mi4uMGMz
OWQ1N2U1MzQyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oCj4gKysr
IGIvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgKPiBAQCAtMzYsNiArMzYsNyBAQCBlbnVtIGNw
dWhwX3N0YXRlIHsKPiAgICAgICBDUFVIUF9YODZfTUNFX0RFQUQsCj4gICAgICAgQ1BVSFBfVklS
VF9ORVRfREVBRCwKPiAgICAgICBDUFVIUF9TTFVCX0RFQUQsCj4gKyAgICAgQ1BVSFBfREVCVUdf
T0JKX0RFQUQsCj4gICAgICAgQ1BVSFBfTU1fV1JJVEVCQUNLX0RFQUQsCj4gICAgICAgQ1BVSFBf
TU1fVk1TVEFUX0RFQUQsCj4gICAgICAgQ1BVSFBfU09GVElSUV9ERUFELAo+IGRpZmYgLS1naXQg
YS9saWIvZGVidWdvYmplY3RzLmMgYi9saWIvZGVidWdvYmplY3RzLmMKPiBpbmRleCBmZTQ1NTc5
NTVkOTcuLmJiNjlhMDJjM2U3YiAxMDA2NDQKPiAtLS0gYS9saWIvZGVidWdvYmplY3RzLmMKPiAr
KysgYi9saWIvZGVidWdvYmplY3RzLmMKPiBAQCAtMTksNiArMTksNyBAQAo+ICAgI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9oYXNoLmg+Cj4gICAjaW5jbHVkZSA8
bGludXgva21lbWxlYWsuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPgo+Cj4gICAjZGVmaW5l
IE9ERUJVR19IQVNIX0JJVFMgICAgMTQKPiAgICNkZWZpbmUgT0RFQlVHX0hBU0hfU0laRSAgICAo
MSA8PCBPREVCVUdfSEFTSF9CSVRTKQo+IEBAIC00MzMsNiArNDM0LDI0IEBAIHN0YXRpYyB2b2lk
IGZyZWVfb2JqZWN0KHN0cnVjdCBkZWJ1Z19vYmogKm9iaikKPiAgICAgICB9Cj4gICB9Cj4KPiAr
I2lmZGVmIENPTkZJR19IT1RQTFVHX0NQVQo+ICtzdGF0aWMgaW50IG9iamVjdF9jcHVfb2ZmbGlu
ZSh1bnNpZ25lZCBpbnQgY3B1KQo+ICt7Cj4gKyAgICAgc3RydWN0IGRlYnVnX3BlcmNwdV9mcmVl
ICpwZXJjcHVfcG9vbDsKPiArICAgICBzdHJ1Y3QgaGxpc3Rfbm9kZSAqdG1wOwo+ICsgICAgIHN0
cnVjdCBkZWJ1Z19vYmogKm9iajsKPiArCj4gKyAgICAgcGVyY3B1X3Bvb2wgPSBwZXJfY3B1X3B0
cigmcGVyY3B1X29ial9wb29sLCBjcHUpOwo+ICsgICAgIGhsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUob2JqLCB0bXAsICZwZXJjcHVfcG9vbC0+ZnJlZV9vYmpzLCBub2RlKSB7Cj4gKyAgICAgICAg
ICAgICBobGlzdF9kZWwoJm9iai0+bm9kZSk7Cj4gKyAgICAgICAgICAgICBrbWVtX2NhY2hlX2Zy
ZWUob2JqX2NhY2hlLCBvYmopOwo+ICsgICAgIH0KPiArICAgICBwZXJjcHVfcG9vbC0+b2JqX2Zy
ZWUgPSAwOwoKPj5Gb3IgcG9pbnRlciwgaXQgaXMgYmV0dGVyIHRvIHVzZSBOVUxMIGZvciBjbGFy
aXR5LgoKPj5DaGVlcnMsCj4+TG9uZ21hbgoKRG8geW91IG1lYW4gIi0+b2JqX2ZyZWUiIHZhcmlh
YmxlID8gICB0aGlzIHJlcHJlc2VudHMgdGhlIG51bWJlciBvZiBmcmVlIG9iamVjdHMgaW4gIHBl
cmNwdV9wb29sIC4KCj4gKwo+ICsgICAgIHJldHVybiAwOwo+ICt9Cj4gKyNlbmRpZgo+ICsKPiAg
IC8qCj4gICAgKiBXZSBydW4gb3V0IG9mIG1lbW9yeS4gVGhhdCBtZWFucyB3ZSBwcm9iYWJseSBo
YXZlIHRvbnMgb2Ygb2JqZWN0cwo+ICAgICogYWxsb2NhdGVkLgo+IEBAIC0xMzY3LDYgKzEzODYs
MTEgQEAgdm9pZCBfX2luaXQgZGVidWdfb2JqZWN0c19tZW1faW5pdCh2b2lkKQo+ICAgICAgIH0g
ZWxzZQo+ICAgICAgICAgICAgICAgZGVidWdfb2JqZWN0c19zZWxmdGVzdCgpOwo+Cj4gKyNpZmRl
ZiBDT05GSUdfSE9UUExVR19DUFUKPiArICAgICBjcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxzKENQ
VUhQX0RFQlVHX09CSl9ERUFELCAib2JqZWN0Om9mZmxpbmUiLCBOVUxMLAo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb2JqZWN0X2NwdV9vZmZsaW5lKTsKPiArI2VuZGlm
Cj4gKwo+ICAgICAgIC8qCj4gICAgICAgICogSW5jcmVhc2UgdGhlIHRocmVzaG9sZHMgZm9yIGFs
bG9jYXRpbmcgYW5kIGZyZWVpbmcgb2JqZWN0cwo+ICAgICAgICAqIGFjY29yZGluZyB0byB0aGUg
bnVtYmVyIG9mIHBvc3NpYmxlIENQVXMgYXZhaWxhYmxlIGluIHRoZSBzeXN0ZW0uCgoK
