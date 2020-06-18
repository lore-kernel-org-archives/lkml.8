Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918B82085B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="qW1EItv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgFRK56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:57:58 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:18861
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbgFRK5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:57:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2sC77C/gP3PrTcZTyscUG+8WPQDECVFiwqwft9lZnVwyKw4KKJoikci4hn1O/8kGlHlTR91K0GCtSqxFq2Ve5GhuscFNQndUUZJ/jR0WNmCNeCVyhnZHcYbFZYLtp5+xy9zcBcE7y/kv46bWEIUfHoKJ3PxJ7bfbLT4dB0QKADnpKhCDlMuIbJ9f/F9wqecPx6y33KSL0VAK7ertPSZjqvavCOiIBwGsbwgtq1suI4zoSnmmtmDOovpJbYNrSzv/UZdYgSc7KOtKz4EquBpNThfNqOcYE1v0nJPSuUgVXopLOKnDDWWAczlxZKI7Yw6Bc1V9eM4QscqhLWRy3ifig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8at9DrWZtpKn6/VgLTEt/vW6R2ghgrKn/zpexohwEow=;
 b=Z+LWXDRsRNulUzef9MwZ4NHai/qzSF2V2C6DGY7PIn72y0/YofU8r+9azA06skmyKCahfDrXMNDt3IEVoepgXqwRzwsZv/Baftv9LGeduxtEbi0rgi+ypCPyPwmcMYadPoomyhv3KJE87gMAZx3zVRRKCU8Bq1GEmVjJdjlKWC+llTpoyYvewi17ZV+6hsxvPdFYRFRz/DnXidNmkMnTR1lJWyknt46NEOon3kt+MvzCdH/6+kNEBi6OI5dAXvIwwTH+dudGnsdEGv6//GYLR5w32dKkF9bhmdtr4xblYjw07x885The/ArdV0J614BfAUSwNkoL3f2X4eIluIj/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8at9DrWZtpKn6/VgLTEt/vW6R2ghgrKn/zpexohwEow=;
 b=qW1EItv/AFYMQw+BlmwPaSmzurT1CnPFOiJ2Iuao2jtm0Ke5AvwzeypfldWeW7PnfRxe/kXrJ33/bt19OrknvHzzDWL2x9dCO2cWTnNnIDliS0dRndS75rkfVe5EmCY2tnx2MFYH33vgaVQkS5jmIWEP1Jl4uBwgCj8do4nL/J4=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB3432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:d6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 18 Jun
 2020 10:57:47 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d54:9ddd:f235:d379%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 10:57:47 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly
 select reg tables
Thread-Topic: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly
 select reg tables
Thread-Index: AQHWFKbBqbtHKKO0gEa+qOberAGalqjeiWWAgAAL3DA=
Date:   Thu, 18 Jun 2020 10:57:47 +0000
Message-ID: <AM6PR10MB226325A1203A99CE49C364EC809B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <20200618101511.GE954398@dell>
In-Reply-To: <20200618101511.GE954398@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [146.199.34.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806717b3-11d4-4bd2-6d67-08d813766ffc
x-ms-traffictypediagnostic: AM6PR10MB3432:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB3432876DFB6A918037EB7BF7A79B0@AM6PR10MB3432.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgwgZDHQ//7afrRl+J+xXC9UIgLEuXQZg4VkT8Qm6+GWMl29B0UriZgdhmVM0qZUQZGOLjlaf9TT65FdqIab5v4KEqwhwBkVVZU4xVKk9g8ZJOE4Tr1yLz0tCjychT8qUgs1pdvg/sTFCLkkULP1UvX1gWowfPNdDySVTav3bgBYnxBjnI4LUNGn+yNLxSWRacqb7n0QEgYQUWGhSJldcyRGqIx9h/wFWA6zvpk1RgOxUPuxR3oYe0AYFMygRjgHi0H724rGiOYsi3qOvo49xXYzS9CcsnVg8P2TtCe7R6kkB8GBqGsBDvERwePT/rzOgeX4AW6XhPmXn35Y2KAahg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(4326008)(2906002)(33656002)(186003)(9686003)(26005)(107886003)(55016002)(8676002)(71200400001)(7696005)(76116006)(5660300002)(52536014)(83380400001)(86362001)(53546011)(66476007)(110136005)(478600001)(6506007)(316002)(54906003)(66446008)(8936002)(66946007)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PVbUEyZwuE018PhAM3z04PUgQAKz7Ju4ypon2Sc0kaqRuLM0oyVjXVuttTctofOW9vyYRBykTMe8XF+aFDpeZuI4o0jDqeHJpuANRT/Chdlrnsd5PDSoK7aOYJ1i4QZ4HhmqEHf07iAqYHkLSBS9Dw0gie8OYnYQdF1Wk0yofv+TZQvOZon+JZHzynO6U91VRV6gpKOrAdoVUhtz0F7ZZ3o0lZzfr00n9u+YfOETDOHww5xVCbyt9srtOeHMEfzcweIEtCM3+RgFq16ZQmH3FuvHsx81qxapOtDfQAZPybrj0xHi+IHDo8/XntodIf9kUx18bYWGY/VbErd+U0GBMv6WwvlCPZ7v8JuNttw95EYtImwB4m7Cg8lfSPaw0bLSX904+PMIocJUWx6CsBSH0heePIhOF0YbkuP7Bcr8laOKkitixEYc5NoqgNy5ZdRR8v32A0egAo97kRx6ZHFwtGkfBaAp9Zg+bOySFNvG6dWsej3z28z38nIhQA5g354k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806717b3-11d4-4bd2-6d67-08d813766ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 10:57:47.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WekADebQpz8Ogx3gE6z5PT4R2MEQUOTwBMZawMZ2YjxOOVHEGY2NEB0Rz0HCVgpJ8LrA53746jVw2KQBcyHd8Ab19+8miM7YzwM0e9VDrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTggSnVuZSAyMDIwIDExOjE1LCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gPiBUaGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBwZXJmb3JtcyBjaGVja2luZyBpbiB0aGUgaTJjX3Byb2JlKCkNCj4g
PiBmdW5jdGlvbiBvZiB0aGUgdmFyaWFudF9jb2RlIGJ1dCBkb2VzIHRoaXMgaW1tZWRpYXRlbHkg
YWZ0ZXIgdGhlDQo+ID4gY29udGFpbmluZyBzdHJ1Y3QgaGFzIGJlZW4gaW5pdGlhbGlzZWQgYXMg
YWxsIHplcm8uIFRoaXMgbWVhbnMgdGhlDQo+ID4gY2hlY2sgZm9yIHZhcmlhbnQgY29kZSB3aWxs
IGFsd2F5cyBkZWZhdWx0IHRvIHVzaW5nIHRoZSBCQiB0YWJsZXMNCj4gPiBhbmQgd2lsbCBuZXZl
ciBzZWxlY3QgQUQuIFRoZSB2YXJpYW50IGNvZGUgaXMgc3Vic2VxdWVudGx5IHNldA0KPiA+IGJ5
IGRldmljZV9pbml0KCkgYW5kIGxhdGVyIHVzZWQgYnkgdGhlIFJUQyBzbyByZWFsbHkgaXQncyBh
IGxpdHRsZQ0KPiA+IGZvcnR1bmF0ZSB0aGlzIG1pc21hdGNoIHdvcmtzLg0KPiA+DQo+ID4gVGhp
cyB1cGRhdGUgYWRkcyByYXcgSTJDIHJlYWQgYWNjZXNzIGZ1bmN0aW9uYWxpdHkgdG8gcmVhZCB0
aGUgY2hpcA0KPiA+IGFuZCB2YXJpYW50L3JldmlzaW9uIGluZm9ybWF0aW9uIChjb21tb24gdG8g
YWxsIHJldmlzaW9ucykgc28gdGhhdA0KPiA+IGl0IGNhbiBzdWJzZXF1ZW50bHkgY29ycmVjdGx5
IGNob29zZSB0aGUgcHJvcGVyIHJlZ21hcCB0YWJsZXMgZm9yDQo+ID4gcmVhbCBpbml0aWFsaXNh
dGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29u
Lk9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWZkL2RhOTA2
My1jb3JlLmMgICAgICAgICAgICB8ICAzMSAtLS0tLS0NCj4gPiAgZHJpdmVycy9tZmQvZGE5MDYz
LWkyYy5jICAgICAgICAgICAgIHwgMTg0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9kYTkwNjMvcmVnaXN0ZXJzLmggfCAgMTUg
KystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTc3IGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9u
cygtKQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyAqIFJhdyBJMkMgYWNjZXNzIHJlcXVpcmVkIGZv
ciBqdXN0IGFjY2Vzc2luZyBjaGlwIGFuZCB2YXJpYW50IGluZm8gYmVmb3JlIHdlDQo+ID4gKyAq
IGtub3cgd2hpY2ggZGV2aWNlIGlzIHByZXNlbnQuIFRoZSBpbmZvIHJlYWQgZnJvbSB0aGUgZGV2
aWNlIHVzaW5nIHRoaXMNCj4gPiArICogYXBwcm9hY2ggaXMgdGhlbiB1c2VkIHRvIHNlbGVjdCB0
aGUgY29ycmVjdCByZWdtYXAgdGFibGVzLg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNkZWZpbmUg
REE5MDYzX1JFR19QQUdFX1NJWkUJCTB4MTAwDQo+ID4gKyNkZWZpbmUgREE5MDYzX1JFR19QQUdF
RF9BRERSX01BU0sJMHhGRg0KPiA+ICsNCj4gPiArZW51bSBkYTkwNjNfcGFnZV9zZWxfYnVmX2Zt
dCB7DQo+ID4gKwlEQTkwNjNfUEFHRV9TRUxfQlVGX1BBR0VfUkVHID0gMCwNCj4gPiArCURBOTA2
M19QQUdFX1NFTF9CVUZfUEFHRV9WQUwsDQo+ID4gKwlEQTkwNjNfUEFHRV9TRUxfQlVGX1NJWkUs
DQo+ID4gK307DQo+ID4gKw0KPiA+ICtlbnVtIGRhOTA2M19wYWdlZF9yZWFkX21zZ3Mgew0KPiA+
ICsJREE5MDYzX1BBR0VEX1JFQURfTVNHX1BBR0VfU0VMID0gMCwNCj4gPiArCURBOTA2M19QQUdF
RF9SRUFEX01TR19SRUdfU0VMLA0KPiA+ICsJREE5MDYzX1BBR0VEX1JFQURfTVNHX0RBVEEsDQo+
ID4gKwlEQTkwNjNfUEFHRURfUkVBRF9NU0dfQ05ULA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBkYTkwNjNfaTJjX2Jsb2NrcmVnX3JlYWQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVu
dCwgdTE2IGFkZHIsDQo+ID4gKwkJCQkgICAgdTggKmJ1ZiwgaW50IGNvdW50KQ0KPiA+ICt7DQo+
ID4gKwlzdHJ1Y3QgaTJjX21zZyB4ZmVyW0RBOTA2M19QQUdFRF9SRUFEX01TR19DTlRdOw0KPiA+
ICsJdTggcGFnZV9zZWxfYnVmW0RBOTA2M19QQUdFX1NFTF9CVUZfU0laRV07DQo+ID4gKwl1OCBw
YWdlX251bSwgcGFnZWRfYWRkcjsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJLyogRGV0
ZXJtaW5lIHBhZ2UgaW5mbyBiYXNlZCBvbiByZWdpc3RlciBhZGRyZXNzICovDQo+ID4gKwlwYWdl
X251bSA9IChhZGRyIC8gREE5MDYzX1JFR19QQUdFX1NJWkUpOw0KPiA+ICsJaWYgKHBhZ2VfbnVt
ID4gMSkgew0KPiA+ICsJCWRldl9lcnIoJmNsaWVudC0+ZGV2LCAiSW52YWxpZCByZWdpc3RlciBh
ZGRyZXNzIHByb3ZpZGVkXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlwYWdlZF9hZGRyID0gKGFkZHIgJSBEQTkwNjNfUkVHX1BBR0VfU0laRSkgJg0K
PiBEQTkwNjNfUkVHX1BBR0VEX0FERFJfTUFTSzsNCj4gPiArCXBhZ2Vfc2VsX2J1ZltEQTkwNjNf
UEFHRV9TRUxfQlVGX1BBR0VfUkVHXSA9DQo+IERBOTA2M19SRUdfUEFHRV9DT047DQo+ID4gKwlw
YWdlX3NlbF9idWZbREE5MDYzX1BBR0VfU0VMX0JVRl9QQUdFX1ZBTF0gPQ0KPiA+ICsJCShwYWdl
X251bSA8PCBEQTkwNjNfSTJDX1BBR0VfU0VMX1NISUZUKSAmDQo+IERBOTA2M19SRUdfUEFHRV9N
QVNLOw0KPiA+ICsNCj4gPiArCS8qIFdyaXRlIHJlZyBhZGRyZXNzLCBwYWdlIHNlbGVjdGlvbiAq
Lw0KPiA+ICsJeGZlcltEQTkwNjNfUEFHRURfUkVBRF9NU0dfUEFHRV9TRUxdLmFkZHIgPSBjbGll
bnQtPmFkZHI7DQo+ID4gKwl4ZmVyW0RBOTA2M19QQUdFRF9SRUFEX01TR19QQUdFX1NFTF0uZmxh
Z3MgPSAwOw0KPiA+ICsJeGZlcltEQTkwNjNfUEFHRURfUkVBRF9NU0dfUEFHRV9TRUxdLmxlbiA9
DQo+IERBOTA2M19QQUdFX1NFTF9CVUZfU0laRTsNCj4gPiArCXhmZXJbREE5MDYzX1BBR0VEX1JF
QURfTVNHX1BBR0VfU0VMXS5idWYgPSBwYWdlX3NlbF9idWY7DQo+ID4gKw0KPiA+ICsJLyogU2Vs
ZWN0IHJlZ2lzdGVyIGFkZHJlc3MgKi8NCj4gPiArCXhmZXJbREE5MDYzX1BBR0VEX1JFQURfTVNH
X1JFR19TRUxdLmFkZHIgPSBjbGllbnQtPmFkZHI7DQo+ID4gKwl4ZmVyW0RBOTA2M19QQUdFRF9S
RUFEX01TR19SRUdfU0VMXS5mbGFncyA9IDA7DQo+ID4gKwl4ZmVyW0RBOTA2M19QQUdFRF9SRUFE
X01TR19SRUdfU0VMXS5sZW4gPSBzaXplb2YocGFnZWRfYWRkcik7DQo+ID4gKwl4ZmVyW0RBOTA2
M19QQUdFRF9SRUFEX01TR19SRUdfU0VMXS5idWYgPSAmcGFnZWRfYWRkcjsNCj4gPiArDQo+ID4g
KwkvKiBSZWFkIGRhdGEgKi8NCj4gPiArCXhmZXJbREE5MDYzX1BBR0VEX1JFQURfTVNHX0RBVEFd
LmFkZHIgPSBjbGllbnQtPmFkZHI7DQo+ID4gKwl4ZmVyW0RBOTA2M19QQUdFRF9SRUFEX01TR19E
QVRBXS5mbGFncyA9IEkyQ19NX1JEOw0KPiA+ICsJeGZlcltEQTkwNjNfUEFHRURfUkVBRF9NU0df
REFUQV0ubGVuID0gY291bnQ7DQo+ID4gKwl4ZmVyW0RBOTA2M19QQUdFRF9SRUFEX01TR19EQVRB
XS5idWYgPSBidWY7DQo+ID4gKw0KPiA+ICsJcmV0ID0gaTJjX3RyYW5zZmVyKGNsaWVudC0+YWRh
cHRlciwgeGZlciwNCj4gREE5MDYzX1BBR0VEX1JFQURfTVNHX0NOVCk7DQo+ID4gKwlpZiAocmV0
IDwgMCkgew0KPiA+ICsJCWRldl9lcnIoJmNsaWVudC0+ZGV2LCAiUGFnZWQgYmxvY2sgcmVhZCBm
YWlsZWQ6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJaWYgKHJldCAhPSBEQTkwNjNfUEFHRURfUkVBRF9NU0dfQ05UKSB7DQo+ID4gKwkJZGV2
X2VycigmY2xpZW50LT5kZXYsICJQYWdlZCBibG9jayByZWFkIGZhaWxlZCB0byBjb21wbGV0ZVxu
Iik7DQo+ID4gKwkJcmV0dXJuIC1FSU87DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gDQo+IFJhdGhlciB0aGFuIG9wZW4gY29kaW5nIHRoaXMsIGRvZXMgaXQgbWFr
ZSBzZW5zZSB0byByZWdpc3RlciBhIHNtYWxsDQo+ICh0ZW1wb3Jhcnk/KSBEZXZpY2UgSUQgUmVn
bWFwIHRvIHJlYWQgZnJvbT8NCg0KVGhlIG9yaWdpbmFsIHBhdGNoIHN1Ym1pc3Npb24gZGlkIGV4
YWN0bHkgdGhhdCBidXQgeW91IGluZGljYXRlZCB5b3Ugd2VyZW4ndA0Ka2VlbiBkdWUgdG8gb3Zl
cmhlYWRzLCBoZW5jZSB0aGUgaW1wbGVtZW50YXRpb24gYWJvdmUuIEFjdHVhbGx5IHdoYXQgd2Ug
aGF2ZQ0KaGVyZSBpcyBhIGJpdCBzbWFsbGVyIHRoYW4gdGhlIHJlZ21hcCBhcHByb2FjaCBhbmQg
SSByZWFsbHkgSSdkIHJhdGhlciBub3QNCmhhdmUgdG8gcmVzcGluIGFnYWluIGp1c3QgdG8gcmV2
ZXJ0IHRvIHNvbWV0aGluZyB0aGF0IHdhcyBkaXNtaXNzZWQgaW4gdGhlIGZpcnN0DQpwbGFjZSBv
dmVyIDYgbW9udGhzIGFnby4NCg==
