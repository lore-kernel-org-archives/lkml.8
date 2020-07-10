Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E22077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="yljIXpRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGJKRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:17:09 -0400
Received: from mail-eopbgr1310044.outbound.protection.outlook.com ([40.107.131.44]:52592
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbgGJKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+wqaUvtJloU4sDYukIJk5ezSa7SQ0acM2LJ+Yud/4Lyaxk8+E2aRNot3W8kS5D9VQK2wtCwYyTiPTCOWG3mHNgPdgVT2ApZMIo9zwpj6m0rMPjfvR6Ik/oTL4jegmstLywRX2jB/Hk2c3k768JtkKe8i2N508GRCEGA1W45IfgPVYUJyKVa6uCD97GqJYvX4cOO09qASemjdlH73pkL1h9n5JwCBxlqXaN97mZxssu1jh1CqebQyOLO4ssDAuECtU4jkN0pQRub6sAONTY5nQHBkfJVyDUlpDcV6od2hfT/9ksIVwrn+Gx1X6AXGJTor4uHa5ENM43nEMcoHDN7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVKOCT+dI4v0T1xaUP4JnYuygX8fE7YkFq7ywfv2yyA=;
 b=GlyoRQoyrZfEF6pL2zgL4DxKvf4wio2RcaNKvprdQ6T/4Ao9ASo7Gy1w2iV5YqeitpiI5xs3c+HNVz0o+8Dhw465th8YAyPVEsDtisWEWn+b92p+AZcxyG/kUWFdBKHr4ipjN9pP9yVezOKBHtLLcxQldKFHUI+xEZZjTecXzS8O50IHJXPahDm7wkevWSJ5OEjGUmHJ6gfJAPr3Y8JEZzUknXNMtgpjC9+UwWQ8rXQK4cyQMjWlX9tpcIuTgDAqqhenLb8NbEid+sfXVbCj9llzoVcNsQ6zW+3jtBoBNkx+n/X2sZ7Bo97Yi9py44FXtbeadR1GmEH5tt3GLC0yxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVKOCT+dI4v0T1xaUP4JnYuygX8fE7YkFq7ywfv2yyA=;
 b=yljIXpRGVGCXAq7gp49VtQnw2eXmu5a/4qteiOiFEKf7VIWo/tqmaehyuPT60e3iKq7dUwtYaCl518moVNh6xZSqaHPmvYyilqe6gRed6EoDJ17Yg77Q/Xcwp1XiVH1f4/lFRPiVpuUjQoDOH5jfqmTaYEWq0lFon1ocpevjMl0=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4387.apcprd02.prod.outlook.com (2603:1096:203:c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 10:17:03 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 10:17:03 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Topic: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Index: AdZVxomlyXL2KYiRQzS3gTED+d01Tw==
Date:   Fri, 10 Jul 2020 10:17:03 +0000
Message-ID: <HKAPR02MB4291B9C45F1411607620575CE0650@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.252.5.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bde3113-4e18-4150-c936-08d824ba63fb
x-ms-traffictypediagnostic: HKAPR02MB4387:
x-microsoft-antispam-prvs: <HKAPR02MB4387BA1FB9D4242D235465E4E0650@HKAPR02MB4387.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryr7ODXf1DQfIzAqrlelUiZS8x1DC8UQHSiVQV+Cs1T70fo714gieEAJWhSiwYpgC9l9FV6eXJudWjCUAg88F7LgqItmvYlRAlfij4tFOeY11ddmBkGEPWOT4hiZCH4C0SiKRK2X9LWX7LcqhWUMlnMY3DC3uMJAPfT1q3a3cvdwqhYn4OJYoX9wUgDxbLBMKF3pzdlx9mpDbBPDLSUJVLbx9U7CAa03xdSGl0XwbaFzgulZNfD81uHtEx2ezoq217weDk2YMBZXrneUgTu3VjsFWmqHCLRhI8FzkI0fT8Tr0gluaILty2O3pvk1vtBaR54kEiO7hUo/H9YqTZUK7CbG0lQoU9bGnHGipJ8hkBQFdENkDtvn4YMGA2TwgaGX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(66446008)(64756008)(6506007)(66556008)(85182001)(186003)(66476007)(26005)(71200400001)(9686003)(33656002)(316002)(8676002)(86362001)(2906002)(478600001)(83380400001)(110136005)(55016002)(76116006)(52536014)(66946007)(4326008)(5660300002)(8936002)(7696005)(54906003)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T0YjH3qSUr/bBvN+hGcF1njcpMLmGHpO21xZ8SBOIqvcBhtKaS1y7dq2JZW8tP9E86dghSS/RhqugFs7ezfoopFyJCJ2xQHSUBrMvu+tpUiKfSeL6GYe0FrPpioQdpJv8rskb4JvX7G/oFubup2hZuSV+aARkpexVssfoJmafp8knZ8dqOBw5aSiiyD9LHj/SLIaw96EFG6KwjOqVB5d1ajoMTzjITf/f+ccwGwtv4dPB4xv7q4n8QzSQVE4IIpYR1gFMXO0tiJijJ2aARvEF2DbUAZ3v+C55wb2sBdDPXB8dQbeX1rPCUdDkQvaOjWzM+1TmxaOjR79u+iWvG5U2w2WU5gpchnqAWaoOvVPNBW2fd5HNJkIBq+C5d1KvpeP+xMgPKhST2WpbvsF0ajwlwEwor8LfeYdFcEF6X18+epKEEq68BWHZpeHROcgT2eHfJ4m7TMx0NSblOntzXVPY5sTyLq69SEBdJa0+A5nAHg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bde3113-4e18-4150-c936-08d824ba63fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 10:17:03.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcknUF4fKSsptVRKhAW6zYVE08g3243Nkjb4I+VOaEUVP2Q7VEdIAzYRVBsufn+w+xy7a2zxpGle9NWVdaXzaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMDksIDIwMjAgYXQgMDc6MTg6MDFBTSArMDAwMCwgUGVuZyBIYW8oUmljaGFy
ZCkgd3JvdGU6DQo+PiBPbiBUaHUsIDkgSnVsIDIwMjAgYXQgMDk6NTAsIFBlbmcgSGFvIChSaWNo
YXJkKSA8cmljaGFyZC5wZW5nQG9wcG8uY29tPiB3cm90ZToNCj4+ID4+ID5BcHBhcmVudGx5LCB5
b3UgYXJlIGhpdHRpbmcgYSBSX0FBUkNINjRfSlVNUDI2IG9yIFJfQUFSQ0g2NF9DQUxMMjYNCj4+
ID4+ID5yZWxvY2F0aW9uIHRoYXQgb3BlcmF0ZXMgb24gYSBiIG9yIGJsIGluc3RydWN0aW9uIHRo
YXQgaXMgbW9yZSB0aGFuDQo+PiA+PiA+MTI4IG1lZ2FieXRlcyBhd2F5IGZyb20gaXRzIHRhcmdl
dC4NCj4+ID4+ID4NCj4+ID4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBhIG1vZHVsZSB0aGF0
IGNhbGxzIGZ1bmN0aW9ucyB0aGF0IGFyZSBub3QgcGFydCBvZiB0aGUgbW9kdWxlIHdpbGwgdXNl
IFBMVC4NCj4+ID4+IFBsdF9tYXhfZW50cmllcyA9MCBNYXkgb2NjdXIgaWYgYSBtb2R1bGUgZG9l
cyBub3QgZGVwZW5kIG9uIG90aGVyIG1vZHVsZSBmdW5jdGlvbnMuDQo+PiA+Pg0KPj4gPg0KPj4g
PkEgUExUIHNsb3QgaXMgYWxsb2NhdGVkIGZvciBlYWNoIGIgb3IgYmwgaW5zdHJ1Y3Rpb24gdGhh
dCByZWZlcnMgdG8gYQ0KPj4gPnN5bWJvbCB0aGF0IGxpdmVzIGluIGEgZGlmZmVyZW50IHNlY3Rp
b24sIGVpdGhlciBvZiB0aGUgc2FtZSBtb2R1bGUNCj4+ID4gKGUuZy4sIGJsIGluIC5pbml0IGNh
bGxpbmcgaW50byAudGV4dCksIG9mIGFub3RoZXIgbW9kdWxlLCBvciBvZiB0aGUNCj4+ID5jb3Jl
IGtlcm5lbC4NCj4+ID4NCj4+ID5JIGRvbid0IHNlZSBob3cgeW91IGVuZCB1cCB3aXRoIHBsdF9t
YXhfZW50cmllcyBpbiB0aGlzIGNhc2UsIHRob3VnaC4NCj4+IGlmIGEgbW9kdWxlIGRvZXMgbm90
IGRlcGVuZCBvbiBvdGhlciBtb2R1bGUgZnVuY3Rpb25zLCBQTFQgZW50cmllcyBpbiB0aGUgbW9k
dWxlIGlzIGVxdWFsIHRvIDAuDQo+DQo+VGhpcyBicmluZ3MgbWUgYmFjayB0byBteSBlYXJsaWVy
IHF1ZXN0aW9uOiBpZiB0aGVyZSBhcmUgbm8gUExUIGVudHJpZXMgaW4NCj50aGUgbW9kdWxlLCB0
aGVuIGNvdW50X3BsdHMoKSB3aWxsIG5vdCBmaW5kIGFueSBSX0FBUkNINjRfSlVNUDI2IG9yDQo+
Ul9BQVJDSDY0X0NBTEwyNiByZWxvY2F0aW9ucyB0aGF0IHJlcXVpcmUgUExUcyBhbmQgd2lsbCB0
aGVyZWZvcmUgcmV0dXJuIDAuDQo+VGhlIGFic2VuY2Ugb2YgdGhlc2UgcmVsb2NhdGlvbnMgbWVh
bnMgdGhhdCBtb2R1bGVfZW1pdF9wbHRfZW50cnkoKSB3aWxsIG5vdA0KPmJlIGNhbGxlZCBieSBh
cHBseV9yZWxvY2F0ZV9hZGQoKSwgYW5kIHNvIHlvdXIgcGF0Y2ggc2hvdWxkIGhhdmUgbm8gZWZm
ZWN0Lg0KPg0KPllvdSBzZWVtIHRvIGJlIHNheWluZyB0aGF0IG1vZHVsZV9lbWl0X3BsdF9lbnRy
eSgpIF9pc18gYmVpbmcgY2FsbGVkLA0KPmRlc3BpdGUgY291bnRfcGx0cygpIHJldHVybmluZyAw
LiBPbmUgd2F5IHRoYXQgY2FuIGhhcHBlbiBpcyBpZiBQTFRzIGFyZQ0KPm5lZWRlZCBmb3IgYnJh
bmNoZXMgd2l0aGluIGEgc2luZ2xlLCB2ZXJ5IGxhcmdlIHRleHQgc2VjdGlvbiwgYnV0IHlvdSBh
bHNvDQo+c2F5IHRoYXQncyBub3QgdGhlIGNhc2UuDQo+DQpPbmUgb2YgeWVzdGVyZGF5J3MgcmVw
bHkgd2FzIHdyb25nLiBXYXJuaW5nIGFwcGVhcnMgb24gdGhlIHR3byBzZXJ2ZXJzIHdob3NlIENP
TkZJR19SQU5ET01JWkVfQkFTRSBpcyBuLg0KdGhlcmUgaXMgYSBzZXJ2ZXIgaXMgc29tZW9uZSBj
b3BpZWQgYSBuZXcgY29uZmlnLCB3aGljaCBjYW4gZW5hYmxlIENPTkZJR19SQU5ET01JWkVfQkFT
RSwNCiBjb21waWxlZCB0aGUga2VybmVsLCBidXQgaGFzIG5vdCByZXN0YXJ0ZWQgdGhlIGhvc3Qu
IEBBcmQNCg0KPlNvIEkgdGhpbmsgd2UgbmVlZCBtb3JlIGluZm9ybWF0aW9uIGZyb20geW91IHNv
IHRoYXQgd2UgY2FuIGVpdGhlciByZXByb2R1Y2UNCj50aGlzIG91cnNlbHZlcywgb3IgYmV0dGVy
IHVuZGVyc3RhbmQgd2hlcmUgdGhpbmdzIGFyZSBnb2luZyB3cm9uZy4NCj4NCkFmdGVyIEkgYWRk
IHRoZSBwcmludCBpbmZvcm1hdGlvbiwgdGhlIG1vZHVsZSB0aGF0IHRyaWdnZXJlZCB0aGUgd2Fy
bmluZyBkaWZmZXJzIGVhY2ggdGltZSBJIHJlc3RhcnQgdGhlIGhvc3QuDQo+RmluYWxseSwgeW91
IHNhaWQgdGhhdCB5b3VyIGtlcm5lbCBpcyAiNS42LjAtcmMzKyIuIEFyZSB5b3UgYWJsZSB0bw0K
PnJlcHJvZHVjZSB3aXRoIG1haW5saW5lICg1LjgtcmM0KT8NCj4NCkkgd2lsbCB0cnkgaXQuDQo+
V2lsbA0KPg0KPlAuUy4gd2hlbmV2ZXIgeW91IHJlcGx5LCB0aGUgbWFpbCB0aHJlYWRpbmcgYnJl
YWtzIDooDQpNYXliZSB0aGUgbWFpbGJveCBjbGllbnQgYXV0b21hdGljYWxseSBhcHBlbmRzIENo
aW5lc2UgY2hhcmFjdGVycy4NCkknbGwgYWRqdXN0IGl0IGFuZCBzZWUgaWYgSSBjYW4gZml4IGl0
Lg0K
