Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B6C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FC521D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pzXyR7ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:33:12 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:19331
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbgIKJdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPH+mIdWH3yvxGPfKX2L1AtmR9WBV1Ovp8FtlZIj70eQbWsOujVpkO/MAOSSZ1oJTS7kUNVSSipvifqKm0DAD4KbOshrPR2umTTy0/r4EeiS2R/NMTl9rbp9/qXlTA1u6MwMzcd1gyzU53mM/WgC+Ex3iIIA1gw5cvvhkWYk4QquhTnjRkoenBn2pyvsL7Cj4JgaJslyYiE6c9tuKiAqkqyX4jg9im5ISZRxg3WcPivKlO3TJZi8ZScUNsPUxt7g94jtj4e+cKQJFHf3/C5VYDfBCmVtL4+kYTsy6BSedH4IpdwVJclzjOMHlnLayuFFudyBTgAKSFyfwa6eHzYSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+L9R6ulNlmeBCi2MFcW2/AP7K+eT9BEElbcb9+a5yw=;
 b=Vm8w/oD05TVsnDtjDb8J70G9ICKs0AwkG6n5L/TWTTdc2ByG9k86vHO2DCcUdTJGuPdKyXpcdKGWYWt+D8g3Fq3codyb9wiZuv47V+za5btdLEIozcqHtkpFoqMrzjYMSL2e2cgJou6eiRrBDjxXJu0WI85rYX3E0fnI25kP91eahQf05KeH814hL3wpLxLlli4ZthO+bBAK23AtsTGIFrlXtPpltpnsSKWEBMFKYo+2Hjfkcnw62bKc9FHBMHcNvfbg0lzessP1pmIPDo22vBVJDQvatxtbbjL0lJPrqjx/njKJVzQzEUyU7vqy3FSmwBa73qtabposamWiPavnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+L9R6ulNlmeBCi2MFcW2/AP7K+eT9BEElbcb9+a5yw=;
 b=pzXyR7ZZdvPnXYT8D6d1Wod/z6p6u3mXvey04dZTFU7SWBXLDUsYJxWcZynZSRnR1SR4UyPldaq9ridYj3nvAPnSDVMY52BvlXgVHLdT/azJLmGar1n1ECOTqntNLO/leLa3bgg/uHwl+sDsVk8YJZ5WsCJE2s7dzcJ73AzqLfk=
Received: from BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18)
 by BY5PR02MB6050.namprd02.prod.outlook.com (2603:10b6:a03:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 09:33:07 +0000
Received: from BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e]) by BYAPR02MB3941.namprd02.prod.outlook.com
 ([fe80::f923:e06c:f837:bd7e%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 09:33:06 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michals@xilinx.com>
CC:     Amit Sunil Dhamne <amitsuni@xilinx.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>
Subject: RE: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from
 late_initcall_sync instead of probe
Thread-Topic: [PATCH v2] drivers: soc: xilinx: Call InitFinalize from
 late_initcall_sync instead of probe
Thread-Index: AQHWhv8ae1R7ycHxGkKEc9urnEU0WKlhbzEAgAAdY4CAAZ92AIAAAt9A
Date:   Fri, 11 Sep 2020 09:33:06 +0000
Message-ID: <BYAPR02MB39410A04E3B271B90ED15771B7240@BYAPR02MB3941.namprd02.prod.outlook.com>
References: <1599693000-25641-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <ac2ab6d1-69c9-34aa-6c25-588bacc78002@xilinx.com>
 <CAK8P3a1aaS85m5nv0hmmxgEVss-hNGL7Qg8iosSFDjDdzzP87Q@mail.gmail.com>
 <f90e00b6-2663-c5cd-41b6-93cd54432a6a@xilinx.com>
In-Reply-To: <f90e00b6-2663-c5cd-41b6-93cd54432a6a@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91526dde-0d82-4102-a957-08d85635b099
x-ms-traffictypediagnostic: BY5PR02MB6050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6050C7C9B59285216517960FB7240@BY5PR02MB6050.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eiCnp/v++mElTt5qveN0wGOz2a1PC0Ih90g/D9kE7AQzU5zOg6T7Rka4apO4h8zWJpOHlZP761b9ukkDwLmvjJJ8EPAu0QSNY4Qmy7fUC3zow8YP3ci9yUc3DXPZ6gLqh3ugnFKCNLRtotsX4SHSmbzFsB10dLmo9co1/LdMeoB8rFe/cSvE4zXaANIcFOhaBIi/oyUY72wUJtxkfMpp1Gayj9+W+2Z7zE1NRMYN5esaLbytomfpEyFoZ/NJSU1lmPHXslouvEcEGuQI/xHeWwMz31hc/HlAS8y76WitBF5u/f33dpjYcXcUCMLrIZ/61pgrCqdP9cYirX2sY5zng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3941.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(396003)(346002)(136003)(107886003)(478600001)(316002)(54906003)(55016002)(8936002)(66476007)(5660300002)(76116006)(52536014)(110136005)(66446008)(66946007)(64756008)(66556008)(4326008)(86362001)(7696005)(7416002)(53546011)(6506007)(2906002)(26005)(186003)(8676002)(6636002)(83380400001)(33656002)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0SE1jNhdkIlXMheVo5WuU6uAr4cP4cphuD4vvDJ9bDck9PgGrP7RBLReJFGUVtwh7ppitvTUuotM62e0QDLyR2qZ0Wmm62oOizAsab9zNLSB+EbU2tPN+OttBX4njaZBW7ZJir3nnE8UyA0V4nU6pU0PZsifVNzKWz1L6VktHL8KUXaRp24hNa3WkuCUFFkBIuXAAcfSjr6/tvrZXuvvMewZw2MMSPwuDV/2dbhfkpNLvO4duCNDxlLYtenqzX97X7LNBGTXgqhc+nAcgVgHoftDlMrE/axiEhgW7oeM3KRWnhKvjocoQYGXdhEKWrMEhJ/74mzr+eRn5GagMacgeuxxn3GIQhVgsYeqz9vu8amAnmkzqTxHRfX8iWzK2tkFRvGSKhLSEXJcFYd2tjdh9UpeRTobpLePF8yWV7ptVSevgESCQVLhiMuPzb44V8U+weYWo9kMEa5FGYpgs5sXH01jIYm60XhSc5MaT9gsIk2Pbs9Fut8yNFLP0ogWdmLW5pMuHLSeJHxg4s0zoONeban0VciRno8m0oEmAH+ejjBkPT8sUTy0CLOLajLyr4JH1FJmw6aVYsTqeWbC9vS9JxyjooHr4jPE0xMqkxSalSttUEDtEaaqYmfDTSqIJoAwB6NhXc0Icg36/5ZvoCz1sw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91526dde-0d82-4102-a957-08d85635b099
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 09:33:06.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OESTO73xrFTebfJwLpI1hg7nx0hyWcwwaJVhyrQ9JTMxLKw+b8/bqXYzv+ksEF5JMo/wioNl7eSXVAGN+6a8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVt
YmVyIDExLCAyMDIwIDI6NTIgUE0NCj4gVG86IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT4NCj4gQ2M6IEFtaXQgU3VuaWwgRGhh
bW5lIDxhbWl0c3VuaUB4aWxpbnguY29tPjsgQXJkIEJpZXNoZXV2ZWwNCj4gPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47IGdyZWdraA0K
PiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBNYXR0IEZsZW1pbmcgPG1hdHRAY29kZWJs
dWVwcmludC5jby51az47DQo+IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBI
ZWluZXIgS2FsbHdlaXQNCj4gPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgS2VlcyBDb29rIDxrZWVz
Y29va0BjaHJvbWl1bS5vcmc+OyBEbWl0cnkNCj4gVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBn
bWFpbC5jb20+OyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47DQo+IExpbnV4IEFSTSA8
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFRlamFzIFBhdGVsIDxURUpBU1BAeGlsaW54LmNvbT47IEpvbGx5IFNo
YWgNCj4gPEpPTExZU0B4aWxpbnguY29tPjsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRyaXZlcnM6IHNvYzogeGlsaW54OiBDYWxsIElu
aXRGaW5hbGl6ZSBmcm9tDQo+IGxhdGVfaW5pdGNhbGxfc3luYyBpbnN0ZWFkIG9mIHByb2JlDQo+
IA0KPiANCj4gDQo+IE9uIDEwLiAwOS4gMjAgMTA6MzUsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+
ID4gT24gVGh1LCBTZXAgMTAsIDIwMjAgYXQgODo1MCBBTSBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0B4aWxpbnguY29tPg0KPiB3cm90ZToNCj4gPj4+IEBAIC0yNDYsNiArMjQ1LDIzIEBAIHN0
YXRpYyBpbnQgenlucW1wX3BtX3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+Pj4gICAgICAgcmV0dXJuIDA7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICtzdGF0aWMg
aW50IF9faW5pdCBkb19pbml0X2ZpbmFsaXplKHZvaWQpIHsNCj4gPj4+ICsgICAgIHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnA7DQo+ID4+PiArDQo+ID4+PiArICAgICBucCA9IG9mX2ZpbmRfY29tcGF0
aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJ4bG54LHp5bnFtcCIpOw0KPiA+Pj4gKyAgICAgaWYgKCFu
cCkgew0KPiA+Pj4gKyAgICAgICAgICAgICBucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5V
TEwsIE5VTEwsICJ4bG54LHZlcnNhbCIpOw0KPiA+Pj4gKyAgICAgICAgICAgICBpZiAoIW5wKQ0K
PiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+Pj4gKyAgICAgfQ0KPiA+
Pj4gKyAgICAgb2Zfbm9kZV9wdXQobnApOw0KPiA+Pj4gKw0KPiA+Pj4gKyAgICAgcmV0dXJuIHp5
bnFtcF9wbV9pbml0X2ZpbmFsaXplKCk7IH0NCj4gPj4+ICsNCj4gPj4+ICtsYXRlX2luaXRjYWxs
X3N5bmMoZG9faW5pdF9maW5hbGl6ZSk7DQo+ID4+PiArDQo+ID4+PiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgcG1fb2ZfbWF0Y2hbXSA9IHsNCj4gPj4+ICAgICAgIHsgLmNvbXBh
dGlibGUgPSAieGxueCx6eW5xbXAtcG93ZXIiLCB9LA0KPiA+Pj4gICAgICAgeyAvKiBlbmQgb2Yg
dGFibGUgKi8gfSwNCj4gPj4+DQo+ID4+DQo+ID4+IEFybmQ6IGFyZSB5b3UgZmluZSB3aXRoIHRo
aXMgd2F5IGhvdyB0byBjaGVjayB0aGF0IGl0IHJ1bnMgb24genlucW1wDQo+ID4+IG9yIHZlcnNh
bD8NCj4gPg0KPiA+IEkgbWlnaHQgYmUgbWlzc2luZyBzb21ldGhpbmcsIGJ1dCB0aGlzIHNvdW5k
cyBsaWtlIHRoZSB3cm9uZyB3YXkgdG8gZG8gaXQuDQo+ID4gVGhlcmUgaXMgYWxyZWFkeSBhIHBs
YXRmb3JtIGRyaXZlciBwcm9iZWQgaW4gdGhlIHByZXNlbmNlIG9mIHRoZQ0KPiA+ICJ4bG54LHp5
bnFtcC1wb3dlciIgbm9kZSBpbiB0aGUgc2FtZSBmaWxlLiBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIg
dG8NCj4gPiBlaXRoZXIgY2hlY2sgZm9yIHRoZSBzYW1lIG5vZGUgaW5zdGVhZCBvZiBhbiBhcmJp
dHJhcmlseSBkaWZmZXJlbnQgc2V0DQo+ID4gb2YgU29DIG5hbWVzLCBvciB0byBtYWtlIHRoZSBw
bGF0Zm9ybSBkcml2ZXIgaXRzZWxmIGdldCByZWdpc3RlcmVkDQo+ID4gZm9ybSB0aGUgbGF0ZSBp
bml0Y2FsbD8NCj4gDQo+IFJhamFuL0FtaXQ6IE9uIHRoZSB0b3Agb2YgbXkgaGVhZCBJIGV4cGVj
dCB0aGF0IHlvdSBjYW4ndCBjYWxsIGl0IGFzIGxhdGUgaW5pdGNhbGwNCj4gYmVjYXVzZSB5b3Ug
bmVlZCB0aGUgZmlyc3QgcGFydCBlYXJsaWVyLg0KPiANCj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRv
IGNoZWNrIHNhbWUgbm9kZT8NCj4gVGhlcmUgaXMgYW5kIHNob3VsZCBiZSBvbmx5IG9uZSBpbnN0
YW5jZSBvZiB0aGlzIGRyaXZlci4NCj4gSXNuJ3QgaXQgZWFzaWVyIGp1c3QgdG8gc2V0dXAgb25l
IHN0YXRpYyB2YXJpYWJsZSBpbnN0ZWFkIG9mIGNhbGxpbmcgZHQgZnVuY3Rpb25zDQo+IHdoaWNo
IHdpbGwgdGFrZSB0aW1lIGFuZCByZXN1bHQgd2lsbCBiZSB0aGUgc2FtZS4NCltSYWphbiBWYWph
XSBZZXMgTWljaGFsLCB0aGF0IG1ha2Ugc2Vuc2UuIFdlIHdpbGwgbWFrZSBjaGFuZ2VzIGFuZCB3
aWxsIHN1Ym1pdCBuZXcgdmVyc2lvbi4NCg0KVGhhbmtzLA0KUmFqYW4NCj4gDQo+IFRoYW5rcywN
Cj4gTWljaGFsDQo=
