Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8197721919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="PRIUNHRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgIII5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:57:46 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:57915
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgIII5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRoqJbdUhIr/ZN7TZ0F52xQXw0vsWLXnY6EAufNAvE+oWY6+w9BnxVWqAkZSNHinb6Uqs4yO5G84jZZIZLKYUbQOFZThACOG9MDYMbqod/CXA/L4oq2WqGzVx5vhwh/RHy02H+pKLchQTyKwthpxn3kklwyTLqlee1H36iXPyK9Zg0ZFT56UBBfWjJnVN/nQhcUmhctsWrUztEuitdROqpMaj+b4VaW3jUduuUspPnn/IpWUsNZ3eCbgRImY3ysZnEwWwh5hh8s2xzTYVZ0h26LsQWdu2GFVMOsLr9lr9Ae2s40coE/2V2TfkYybzZBUsei1UD7N9SD71EDpnBYsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R8de8mfBrfW9WYPfzMOz6e3I/JILfD3Wo8p2+qQ+AE=;
 b=KJcN0Zyzd868dpf6s2H/YmUNdmUc61PWQDv1ANR4kpZx5puy8SQJ7pN4kswOGzDC1+CKC0xVWSnn7pC38QtDjTxHl5HhvzonnFg73qtqWSdE33SQTwvM/8H5GHybc2Yb2/wfNI+YJqQwdPCUmhe8JsNomM0bbQMwOP1hrQxfJgc2ZSLF1pHYU14r2vxJD94h0iPMOG0sh4IxL6xMWnMA2U03+dfPGs4ADQsG/34bgrsTYGJJkgZHlVTOfbCm86fBDN4aHQERP0GfM59UZ0F+Ipy9aLiXL1YuXnb7iqv1om92TSLY4Lu/2u6IG9X0Weni8wGb6VUezGU/g/JDcH86mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R8de8mfBrfW9WYPfzMOz6e3I/JILfD3Wo8p2+qQ+AE=;
 b=PRIUNHRBKE8jOzFpHd1PLXtJRMvTr3G3a9bH4uSfR9u+Mj0x5ZWTyduhaOQUrNIsoB+fR4bxMBvVQSXYayTJn5wpwCWME+fG+De3+fakR6d+JBqh0Tf3sj0VAr3CC8OL+hNXvUbnx9+RBnMFTzkjHlTUYOtFXoRoe7jQONuolII=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3161.eurprd03.prod.outlook.com (2603:10a6:7:57::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.19; Wed, 9 Sep 2020 08:57:36 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 08:57:36 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "rjones@gateworks.com" <rjones@gateworks.com>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Topic: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Index: AQHWhfCctrMc+RkfU02vebcoA9GUSalf2ZuAgAAdxQCAAAtDgA==
Date:   Wed, 9 Sep 2020 08:57:36 +0000
Message-ID: <745c815f716fa8245f17cb2e189529e382df63da.camel@fi.rohmeurope.com>
References: <20200908145900.4423-1-krzk@kernel.org>
         <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
         <20200909081716.GA11775@kozik-lap>
In-Reply-To: <20200909081716.GA11775@kozik-lap>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 344d24b4-a1de-4fbe-4dac-08d8549e661b
x-ms-traffictypediagnostic: HE1PR03MB3161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR03MB3161BD47E16F8E5D92A0E92EAD260@HE1PR03MB3161.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+Qz71QFfujgEnF8QyITR07fpEKchlh5DlCt0wuB46NgHO+XyBQ+vYOwvWINEbPO2rAX66p+uWS1XZhFS9NyF2HY8uOckFoNucHs8EfL4mrRG1bV6R7VWw2ibMkFuXskILG0rtWVxvL2C5UfJSSbjMFmVbhx0n2fg4ln6YwqjaWwAm7Xb9vNroqjFhSc3EE8B8vfKvgYa83AR8AASW1glkyIcx/uN2Ut1spuOV4txCmyfNafXRMcoExKc/C3ld66c9Xl9Ukecl9G+B7tR974VAqyRQoVUDNam56rVWckGXpEdwjwpeu4Pjb/fdzxMq3UImQJArpwhsVWBPgxssmaxumkhpRCaPNShYEbBdNMuaVnF14wsS7bRWGXdt1309ky
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(366004)(346002)(136003)(316002)(66446008)(64756008)(66946007)(186003)(26005)(76116006)(6512007)(2616005)(66556008)(66476007)(6916009)(6506007)(86362001)(6486002)(478600001)(8936002)(3450700001)(8676002)(5660300002)(83380400001)(2906002)(54906003)(4326008)(71200400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KGziw9Swa8tlbmUdroiOFrGGkUsn5GndTE+waT7pvA7nRYWBWB5Xp8EjnSmePRtgb3OZC8b2QiKdP7XHlYNz9huzKbpwlh1jwDmpvorzNKEqEF1A9vW342YH81fTk2tWDtFyFGSiC6nlRKcHNdLTMTVu6lHwhjKiLkrsgJTmxGwGxHQXAR9qDvQ70UAH2yrqc9HWOD4Ma8K8+X7tcA/YWJktsDXwANOQSZLADRduyT3JGsVfL/sYoKfwqg5+2MRxumfa1PwwTTOBQKvRBlVypydUbjQhthK/EmVqfDVRTj17XJ8p3LeY/RCZYIX4ZAPybGSNU2+XOJyMIbQbgmEqgp2rCTuTRZZTrB2uDGHm1KEu381VSllGR4bxJxJtoo/MWSLw5QcmbfTrao6urDYjzpcEECNgGn07n6SSgNU4U+woSdjTRta5CM4cFUUOsRQ2w1skbzlFTC+a7s95pN3pT4wmFLLaAObyDKG75tNggOG/5AZDex6RHPUbQaVAiaicPsTlyeezGdhsXqpEAnfPhi7Rf5XWQKHAk2WqOfC56Dm/B/GmQR44pQSGh8zmPr9cDLtC7kFtQkW5QJ6GrDz+QVaYe9cMaUfMuFZN2ghmlbWJuA/6Krxa1kFTm+fEB4WjJxztHaerEN46IRPpOMKbHw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <57FB3E168090F142AFD20A8FC6108C3D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344d24b4-a1de-4fbe-4dac-08d8549e661b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 08:57:36.6487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTR2ctp1KTt9pi79YzutaUArUNyp+aq5zftPE4BCUX+fVBiGFxc0wsO8Iwo4jrjMFARdpYd+l2quliTobzPzBdgBrHMM1A4EwZx3ErHHg2zMtVqsZA2o6ak9zjlX8aDK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpPbiBXZWQsIDIwMjAtMDktMDkgYXQgMTA6MTcgKzAyMDAsIGty
emtAa2VybmVsLm9yZyB3cm90ZToNCj4gT24gV2VkLCBTZXAgMDksIDIwMjAgYXQgMDY6MzA6NDRB
TSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMDktMDgg
YXQgMTY6NTkgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gPiBHUElPX0FD
VElWRV94IGZsYWdzIGFyZSBub3QgY29ycmVjdCBpbiB0aGUgY29udGV4dCBvZiBpbnRlcnJ1cHQN
Cj4gPiA+IGZsYWdzLg0KPiA+ID4gVGhlc2UgYXJlIHNpbXBsZSBkZWZpbmVzIHNvIHRoZXkgY291
bGQgYmUgdXNlZCBpbiBEVFMgYnV0IHRoZXkNCj4gPiA+IHdpbGwNCj4gPiA+IG5vdA0KPiA+ID4g
aGF2ZSB0aGUgc2FtZSBtZWFuaW5nOg0KPiA+ID4gMS4gR1BJT19BQ1RJVkVfSElHSCA9IDAgPSBJ
UlFfVFlQRV9OT05FDQo+ID4gPiAyLiBHUElPX0FDVElWRV9MT1cgID0gMSA9IElSUV9UWVBFX0VE
R0VfUklTSU5HDQo+ID4gPiANCj4gPiA+IENvcnJlY3QgdGhlIGludGVycnVwdCBmbGFncywgYXNz
dW1pbmcgdGhlIGF1dGhvciBvZiB0aGUgY29kZQ0KPiA+ID4gd2FudGVkDQo+ID4gPiBzb21lDQo+
ID4gPiBsb2dpY2FsIGJlaGF2aW9yIGJlaGluZCB0aGUgbmFtZSAiQUNUSVZFX3h4eCIsIHRoaXMg
aXM6DQo+ID4gPiAgIEFDVElWRV9MT1cgPT4gSVJRX1RZUEVfTEVWRUxfTE9XDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4N
Cj4gPiANCj4gPiBGb3IgQkQ3MDUyODoNCj4gPiBBY2tlZC1CeTogTWF0dGkgVmFpdHRpbmVuIDxt
YXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4gDQo+ID4gPiAtLS0NCj4gPiA+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FjdDg5NDVhLnR4dCAgICAg
ICAgICB8IDINCj4gPiA+ICstDQo+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9nYXRld29ya3MtZ3NjLnlhbWwgICAgfCAzDQo+ID4gPiArKy0NCj4gPiA+ICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC1wbWljLnR4dCB8
IDINCj4gPiA+ICstDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcm9obSxiZDcwNTI4LQ0KPiA+ID4gcG1pYy50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC0N
Cj4gPiA+IHBtaWMudHh0DQo+ID4gPiBpbmRleCBjM2MwMmNlNzNjZGUuLjM4NmVlYzA2Y2YwOCAx
MDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
cm9obSxiZDcwNTI4LXBtaWMudHh0DQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC1wbWljLnR4dA0KPiA+ID4gQEAgLTM5LDcgKzM5
LDcgQEAgcG1pYzogcG1pY0A0YiB7DQo+ID4gPiAgCWNvbXBhdGlibGUgPSAicm9obSxiZDcwNTI4
IjsNCj4gPiA+ICAJcmVnID0gPDB4NGI+Ow0KPiA+ID4gIAlpbnRlcnJ1cHQtcGFyZW50ID0gPCZn
cGlvMT47DQo+ID4gPiAtCWludGVycnVwdHMgPSA8MjkgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiA+
ICsJaW50ZXJydXB0cyA9IDwyOSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+IA0KPiA+IFRoaXMg
aXMgaG93IGl0IHNob3VsZCBoYXZlIGJlZW4gZnJvbSB0aGUgYmVnaW5uaW5nIDopIFRoYW5rcyEN
Cj4gDQo+IEkgc3RhcnQgdG8gd29uZGVyIG5vdy4gSXQgc2VlbXMgc29tZSBib2FyZHMgZG8gbm90
IGNvbmZpZ3VyZSBhIHB1bGwNCj4gdXANCj4gdGhlcmUsIHNvIElSUV9UWVBFX0xFVkVMX0xPVyBp
cyB3cm9uZyAtIGNhdXNlcyB0aGUgbGluZSB0byBzdGF5IGluDQo+IGxvdw0KPiBzdGF0ZS4gIEJ1
dCBhY3R1YWxseSB0aGlzIG1heWJlIGlzIGEgcHJvYmxlbSBvZiBtaXNzaW5nIHB1bGwgdXAsIG5v
dA0KPiB0aGUNCj4gSVJRIGZsYWc/DQoNClRoZSBCRDcwNTI4IGlzIGRlc2lnbmVkIHNvIHRoYXQg
aXQgd2lsbCB1c2UgbGV2ZWwgYWN0aXZlIGludGVycnVwdHMgLQ0KYW5kIGxpbmUgaXMgcHVsbGVk
IGRvd24gd2hlbiBJUlEgaXMgYWN0aXZlLiBUaHVzIHRoZSBleGFtcGxlIHNob3VsZA0KaGF2ZSBJ
UlFfVFlQRV9MRVZFTF9MT1cgLSBhbmQgeW91ciBmaXggaXMgY29ycmVjdC4NCg0KQWZ0ZXIgdGhh
dCBiZWluZyBzYWlkIC0gSSBjYW4ndCBjb21tZW50IG9uIGFjdHVhbCBib2FyZCB1c2luZyBCRDcw
NTI4DQoob3Igb3RoZXIgUk9ITSBJQ3MpIC0gZXZlbiBsZXNzIEkgY2FuIGNvbW1lbnQgYm9hcmRz
IHVzaW5nIG90aGVyIElDcy4NCg0KQWZ0ZXIgdGhhdCBiZWluZyBzYWlkIC0gaXQncyBub3QgYSBy
YXJlIG1pc3Rha2UgdG8gY29uZmlndXJlIGxldmVsDQphY3RpdmUgSVJRcyB0byBiZSB0cmlnZ2Vy
ZWQgYXQgZWRnZSAtIGl0IGFjdHVhbGx5IHdvcmtzIG1vc3Qgb2YgdGhlDQp0aW1lIC0gdW50aWxs
IHRoZXkgZGVhZGxvY2sgYXQgdGhlIHJhY2Ugb2YgZ2VuZXJhdGluZyBuZXcgSVJRIGJldHdlZW4N
CnJlYWRpbmcgdGhlIHN0YXR1cyBhbmQgYWNraW5nIHRoZSBsaW5lLi4uIEkndmUgZGVidWdnZWQg
d2F5IHRvbyBtYW55DQpzdWNoIGNhc2VzLi4uDQoNCkFueXdheXMsIGZvciBCRDcwNTI4IERUUyBl
eGFtcGxlIHlvdXIgZml4IGxvb2tzIGNvcnJlY3QuIFRoYW5rcy4NCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==
