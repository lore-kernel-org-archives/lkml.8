Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7DF20720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="BjoJQdxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGIHSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:18:07 -0400
Received: from mail-eopbgr1300052.outbound.protection.outlook.com ([40.107.130.52]:35424
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgGIHSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:18:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5/MVieZ7CJOsjACNUUtJMCZdI7yAiN+CxQAgCJbVj7jz7XeGxcx4MAnCO+iDue/5m6fZwGYZW5edoBDzRTuUVr+IUSoJ9WfSaPHFaXaMDGzGpQDY2tMY2nH/bkKA0G46UK1MQrYarjmv6HsF0JZ4nINXZUE8bEC/9czSgAyROcGDQGxtrUpDCzXPDJs0D/Ih8gJZGDWddbVF8LTcOhwkKahLcqcv2C2a7Jfn0IgHUaRZcLVRrNWPgUXQHh8S8sNuqxVETmHyyFQAUShnSpSArd1FiGi+tmZy4rpDeEpxlqEpOQ/ukx9LYtt/+2eXNkImdc53pr58vVgjOnqGFT1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FQEBgR21iNmeHoVZwiSteoO6dU+Z3ZzaaZeGsW72S8=;
 b=UdOivQKMUfk3cMhB3t45qLvOPR7PoDamhMOfY8bEySGjDeoA9VUcXUm0dCa1iEYPFsN3zgNkozIxe47Z71acf9S6CDQlBqoZvU6B1f3eYhhiYPGXF7mZ/6bL2jUIcbynPlnoVgNnvjJX7igJAOR6j38clFaV+dVEEo9VD0rpxHg+W4ClNvwlGVoLllxbzJ3scrO878mmS10tieKYTUV6PYOH4C3OEMvyPbmMitoX1EW9RwvloupiEJWIMMrrG/kTheM5ZnaPBk+tKALnBYA1Kv3YtWTRJS7ZE+D2dLupeV0VEniQqpSvKsSn8W1b47q5P2l/AWDVXfN2bAbIzjBLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FQEBgR21iNmeHoVZwiSteoO6dU+Z3ZzaaZeGsW72S8=;
 b=BjoJQdxFrXfwBPWScJUA5dp2to3zCPHxJ5Clo0xVFc/6hhElTLYYFcFcLQAd4dxJAcX7TPOUYGiDrN2bnJ+Sm0Nu5RQqsoJX7coK2Bbb51KGEswdpsyVwUmOgUTMM7Ta7AU6JG1LC573qG0oiL6c075OHXHCGSkXaC5FGT31IqU=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4435.apcprd02.prod.outlook.com (2603:1096:203:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 07:18:02 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 07:18:02 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Topic: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Index: AdZVv7xTVVaHdvP3RP6MtY7GpRijyg==
Date:   Thu, 9 Jul 2020 07:18:01 +0000
Message-ID: <HKAPR02MB429186AF5DC0A187A345F3BCE0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77662d81-b378-421a-bf46-08d823d83752
x-ms-traffictypediagnostic: HKAPR02MB4435:
x-microsoft-antispam-prvs: <HKAPR02MB4435FF2B35AF6E341C48CED7E0640@HKAPR02MB4435.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1UH1dCC7USqfFedyrLqQdvE/Z4ywQxc9sjBzEECEI32fHsH+JAXFNirAdBNSky+evh7J8heOcssjAtpQh4WC38Pg1CfEZ4ZUpPGUhJD7Y0vlk03rZt/W679Kx5hCodKV7576T/+i82IxksLPoRmKNjJVYgAL/Kh/yqCzn5uqRn+6X3QIdw0oGeOKvMwFH0mTlpPwtdYAHYgV9ZKCyQ35+Mc3TIitRRGMumHCWD2fNPvofie/zNtXh7Wbtr7x8TvBu/IarW8B/bDhabOiE4LNgq/VQw4TOCoaUH2UgN5CVEqsD67tVoNjYrTtDO5bNIkUCQVGt3KGQyMJJ9IFlPo/FeK/7c+te1TImO8aWxsWzNWi/u8O/15vk4gkkVwgIfIV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(346002)(366004)(376002)(76116006)(83380400001)(6506007)(186003)(26005)(52536014)(6916009)(4326008)(2906002)(55016002)(54906003)(316002)(5660300002)(86362001)(7696005)(478600001)(8936002)(66446008)(66556008)(66476007)(8676002)(66946007)(33656002)(64756008)(85182001)(9686003)(71200400001)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: caVX93AbdpGJOrwLgz1shx+jzoF0CLE4DGzCd+y0OfoGBhiiMzZY2M2RyJ+s9HyY0GY+RMe3RhA04GlmubbB5PpFLed3fKM2tPfGdfkpYrS0d7dHppx4F3RG225SWHGDHExodhh10ZPQ517GvIcfTvSxMnRnA+FWDKVO5soLet6c1WuIWRnxG3y0vsctPoRVDr5sLLRA9/iRYl6g5iVjwwPrDobwLCLWsyjYXD+gkwfApNVpidh/xE/BaYDPFVNnWGgnBn7SA1Foq14OjgME82u6sPLNE1QbAca0OIthxYPO3cgezMuHA39QKJKZq1k9FU9YvHtVM3VCAWxUhqVfnSxEnAc0MsXpsW3m30xWskaEvZxUd3Gcjr+QroOgNoKkhBJra74vVqg3Jd4PNnBoPeRJGgfLgccspiWJS3bFi6Dbl+2d0u5GzPDtOJ33+C9pYC7bstPQI8ddnt0szaqy2udauxD9PCx0dlBSbGyxXbA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77662d81-b378-421a-bf46-08d823d83752
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 07:18:01.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esPMWISg6aogHzq1nMqjqLDscyEvRWZfVNgULarrT8imr2VeHHKgSxjQgdRSk4M6hfXehEl0ZdNI63CI70bb9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCA5IEp1bCAyMDIwIGF0IDA5OjUwLCDlva3mtakoUmljaGFyZCkgPHJpY2hhcmQucGVu
Z0BvcHBvLmNvbT4gd3JvdGU6DQo+PiA+QXBwYXJlbnRseSwgeW91IGFyZSBoaXR0aW5nIGEgUl9B
QVJDSDY0X0pVTVAyNiBvciBSX0FBUkNINjRfQ0FMTDI2DQo+PiA+cmVsb2NhdGlvbiB0aGF0IG9w
ZXJhdGVzIG9uIGEgYiBvciBibCBpbnN0cnVjdGlvbiB0aGF0IGlzIG1vcmUgdGhhbg0KPj4gPjEy
OCBtZWdhYnl0ZXMgYXdheSBmcm9tIGl0cyB0YXJnZXQuDQo+PiA+DQo+PiBNeSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgYSBtb2R1bGUgdGhhdCBjYWxscyBmdW5jdGlvbnMgdGhhdCBhcmUgbm90IHBh
cnQgb2YgdGhlIG1vZHVsZSB3aWxsIHVzZSBQTFQuDQo+PiBQbHRfbWF4X2VudHJpZXMgPTAgTWF5
IG9jY3VyIGlmIGEgbW9kdWxlIGRvZXMgbm90IGRlcGVuZCBvbiBvdGhlciBtb2R1bGUgZnVuY3Rp
b25zLg0KPj4NCj4NCj5BIFBMVCBzbG90IGlzIGFsbG9jYXRlZCBmb3IgZWFjaCBiIG9yIGJsIGlu
c3RydWN0aW9uIHRoYXQgcmVmZXJzIHRvIGENCj5zeW1ib2wgdGhhdCBsaXZlcyBpbiBhIGRpZmZl
cmVudCBzZWN0aW9uLCBlaXRoZXIgb2YgdGhlIHNhbWUgbW9kdWxlDQo+IChlLmcuLCBibCBpbiAu
aW5pdCBjYWxsaW5nIGludG8gLnRleHQpLCBvZiBhbm90aGVyIG1vZHVsZSwgb3Igb2YgdGhlDQo+
Y29yZSBrZXJuZWwuDQo+DQo+SSBkb24ndCBzZWUgaG93IHlvdSBlbmQgdXAgd2l0aCBwbHRfbWF4
X2VudHJpZXMgaW4gdGhpcyBjYXNlLCB0aG91Z2guDQppZiBhIG1vZHVsZSBkb2VzIG5vdCBkZXBl
bmQgb24gb3RoZXIgbW9kdWxlIGZ1bmN0aW9ucywgUExUIGVudHJpZXMgaW4gdGhlIG1vZHVsZSBp
cyBlcXVhbCB0byAwLg0KSWYgdGhpcyBpcyB0aGUgY2FzZSBJIGRvbid0IHRoaW5rIEkgbmVlZCB0
byBkbyBhbnl0aGluZywganVzdCByZXR1cm4gMC5XaGF0IGRvIHlvdSB0aGluayBzaG91bGQgYmUg
DQpkb25lIGFib3V0IHRoaXMgc2l0dWF0aW9uPyBBbnkgU3VnZ2VzdGlvbnM/DQpUaGFua3MuDQo+
QXJlIHlvdSBzdXJlIHlvdSBoYXZlIENPTkZJR19SQU5ET01JWkVfQkFTRSBlbmFibGVkPw0KPg0K
Q09ORklHX1JBTkRPTUlaRV9CQVNFID0geSBvciBuIGhhcyB0aGlzIHdhcm5pbmcgKHR3byBzZXJ2
ZXJzLCBrZXJuZWwgdmVyc2lvbiBpcyBkaWZmZXJlbnQpLg0KDQo+PiA+SW4gbW9kdWxlX2Zyb2Jf
YXJjaF9zZWN0aW9ucygpLCB3ZSBjb3VudCBhbGwgc3VjaCByZWxvY2F0aW9ucyB0aGF0DQo+PiA+
cG9pbnQgdG8gb3RoZXIgc2VjdGlvbnMsIGFuZCBhbGxvY2F0ZSBhIFBMVCBzbG90IGZvciBlYWNo
IChhbmQgdXBkYXRlDQo+PiA+cGx0X21heF9lbnRyaWVzKSBhY2NvcmRpbmdseS4gU28gdGhpcyBt
ZWFucyB0aGF0IHRoZSByZWxvY2F0aW9uIGluDQo+PiA+cXVlc3Rpb24gd2FzIGRpc3JlZ2FyZGVk
LCBhbmQgdGhpcyBjb3VsZCBoYXBwZW4gZm9yIG9ubHkgdHdvIHJlYXNvbnM6DQo+PiA+LSB0aGUg
YnJhbmNoIGluc3RydWN0aW9uIGFuZCBpdHMgdGFyZ2V0IGFyZSBib3RoIGluIHRoZSBzYW1lIHNl
Y3Rpb24sDQo+PiA+aW4gd2hpY2ggY2FzZSB0aGlzIHNlY3Rpb24gaXMgKnJlYWxseSogbGFyZ2Us
DQo+PiA+LSBDT05GSUdfUkFORE9NSVpFX0JBU0UgaXMgZGlzYWJsZWQsIGJ1dCB5b3UgYXJlIHN0
aWxsIGVuZGluZyB1cCBpbiBhDQo+PiA+c2l0dWF0aW9uIHdoZXJlIHRoZSBtb2R1bGVzIGFyZSBy
ZWFsbHkgZmFyIGF3YXkgZnJvbSB0aGUgY29yZSBrZXJuZWwNCj4+ID5vciBmcm9tIG90aGVyIG1v
ZHVsZXMuDQo+PiA+DQo+PiA+RG8geW91IGhhdmUgYSBsb3Qgb2YgW2xhcmdlXSBtb2R1bGVzIGxv
YWRlZCB3aGVuIHRoaXMgaGFwcGVucz8NCj4+IEkgZG9u4oCZdCB0aGluayBJIGhhdmUgW2xhcmdl
XSBtb2R1bGVzLiAgSSdsbCB0cmFjZSB3aGljaCBtb2R1bGUgY2F1c2VkIHRoaXMgd2FybmluZy4N
Cj4NCj5ZZXMgcGxlYXNlLg0KSSBjYW4ndCBwcmludCBkZWJ1ZyB1bnRpbCBzb21lb25lIGVsc2Ug
aXMgbm90IHVzaW5nIHRoZSBzZXJ2ZXIuDQo=
