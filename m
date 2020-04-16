Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB0C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3596E20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="wfd9CR8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503104AbgDPJFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:05:39 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:41407 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503097AbgDPJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:04:37 -0400
Received: from [100.113.4.160] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 9A/9E-46409-0AF189E5; Thu, 16 Apr 2020 09:04:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRWlGSWpSXmKPExsWSoS+YpbtAfka
  cwcn7fBb3vx5ltLi8aw6bA5PHnWt72Dw+b5ILYIpizcxLyq9IYM24/+woY8ECo4oVU9ewNDCe
  Mexi5OJgFFjKLNF/ajczhHOMReLnlkWsEM5mRonfvT/ZQBwWgRPMEnsvHGQCcYQE5jNJPPuxD
  cq5yyhx4d9UoDJODjYBC4nJJx6A2SICkRI7vp5kBLGZBcol9v/4xg5iCwukSrxveQFVkyax8N
  YPVgjbSqL/zmywOIuAqsT5aU+BjuLg4BWIlZi8Mwhi1zFGif9rnjGCxDkFdCSmzUsDKWcUkJX
  40riaGWKVuMStJ/OZQGwJAQGJJXvOM0PYohIvH/9jhahPlTjZdIMRIq4jcfb6EyhbSeJuw1uo
  elmJS/O7wVZJCPhKPHhoARHWkrh7egNUuYXEku5WFogSFYl/hyohwjkSZ/fPYoGw1SVaPs5jh
  bBlJL7OXgwONQmBKSwSq/b/ZJvAaDALydWzgEYxC2hKrN+lDxFWlJjS/ZAdxOYVEJQ4OfMJyw
  JGllWMFklFmekZJbmJmTm6hgYGuoaGxromukZGeolVukl6qaW6yal5JUWJQEm9xPJiveLK3OS
  cFL281JJNjMBkk1LIIraDcdba93qHGCU5mJREeXtkZsQJ8SXlp1RmJBZnxBeV5qQWH2LU4OAQ
  uHLwyGxGKZa8/LxUJQleYzmgOsGi1PTUirTMHGBChCmV4OBREuFdDzKGt7ggMbc4Mx0idYrRk
  mPCy7mLmDl2Hp0HJI/MXbqIWQhsnpQ4ryrIPAGQhozSPLhxsKR9iVFWSpiXkYGBQYinILUoN7
  MEVf4VozgHo5Iw70VZoCk8mXklcFtfAR3EBHRQtMN0kINKEhFSUg1MASG9NXe0JijflRJTEWz
  JP7/oyobU9kket38rLUq4GLOrWbl5euOVzSs+dlU6LtTf9m6ypLmYz+aEJ1vevfpzVqvMn2Pf
  dBWDjM4/J6RDGq+tszvS/VP41Lvj/wVzdyfOs75p4ek8eVr2yYesda9/yPz7/v7yucxLs4rXH
  1hS8mD5NOWU0zmvEuZVXfGwEJ0jpS/2NK9yXpVllnjWeoeZDGpL79auXTY3Y0EiU8pK3lfKt+
  f4mm6VKRJ8YBTIK+wkdpzFrszPQWdCg8tCr4xfdd6X/3340f+pMG+xZmzfEjszvxMvWJSLH76
  KWSTYw/bFc3trQOimF2o7Mw7vUpK02/2keMcPjX9XJ3le0tr4XImlOCPRUIu5qDgRAHN8axxV
  BAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-249.messagelabs.com!1587027871!2935547!1
X-Originating-IP: [104.47.17.106]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32316 invoked from network); 16 Apr 2020 09:04:32 -0000
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) (104.47.17.106)
  by server-11.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Apr 2020 09:04:32 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3p6M30IR2ipDIXpNiVo1kGVYX4JEQhRYXZSwfkSVT+/VsDVPzbCZMuSZO/8YiVy0pZzC36KLRPWcPf6Klf+kSj8hCp9n3KdPYvwpHkZZLIBTROxvtwG4CR97WsP2X2h7FG7UDqSlqo3HT3Al1DjfEuCciinVkINsYi1iBlR/PfFg5KATwr79npME/b7Xz6bAF4Ti69mJ+bpEr9TSWDb/IEOGtAeY9dsEfGfHZzTIm6xgyfOdcUfQHL+cKz303xj1ljsO9yD4+T+bMzmSwUASfOw+ZOq1q/dWcTdJ62zZAC56w6+/IauZT/JQyu6BsSNrr5Y7rmKq6RGa5csIX779A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4d6T4hVBGRRG6g1b851tGB5MQut6wtVIpsz5VSuD9s=;
 b=aThKplDu2VI2wGHZg1QI6HoO3OOV+a5h/7AJ9HbkFFwzCJfhjglAND+uEhcGsZzzgK0jIrtr9kPrxygoXfNA+5bCawQVCqPQe4IlLwzvw6hJaQcs8vmaUKLSVATH+i7TbTpHq+SFXxG6Ns2Q5317p17HFGJIRsHRBttaOifR1XVc5FEffCchC9iZX3Namb+RbzfZViKEnnht7I2JDO1pFf5RLXCA2pZ9TkXrMZV28iopYnMCLVRnCNsxENxm5+61GxOHgFsI+3qUfxGNcwj5C1Iaa9sU/BIo7tmmmtCU1KAh937RApY4D2X0N2UnwzRPq8Xih5/jDphLL34aF+wUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4d6T4hVBGRRG6g1b851tGB5MQut6wtVIpsz5VSuD9s=;
 b=wfd9CR8UnFecCKfK8GCJ/aee4YAKIG8lHrpilWqtw5T0r1xVKqjqHjfsScOa/RK8b4eLAimb+RLAoyEMcswGIqQGj+MiK7McljwYNX7aZqP3FWcmOODgaILvQf1doqtx6OA38EjMfQHdpyAX++XGRf+9rc/sHc6SWXC+MQOWvGc=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2421.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Thu, 16 Apr
 2020 09:04:31 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:04:31 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHWC/ENSER4gvf5u0yNBk4BhQAwn6h7chgAgAARuaA=
Date:   Thu, 16 Apr 2020 09:04:30 +0000
Message-ID: <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416075944.GU2167633@dell>
In-Reply-To: <20200416075944.GU2167633@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [146.200.27.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 197ee13b-34df-40fb-ec0c-08d7e1e52cb6
x-ms-traffictypediagnostic: AM6PR10MB2421:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2421D4DCC8E5229B37BBEE2AA7D80@AM6PR10MB2421.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(136003)(39850400004)(346002)(376002)(478600001)(55016002)(81156014)(2906002)(86362001)(9686003)(8936002)(8676002)(55236004)(186003)(71200400001)(52536014)(107886003)(4326008)(6506007)(53546011)(33656002)(26005)(7696005)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(316002)(110136005)(5660300002)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWGJpEoPBzJOaQtxBiael0KR1jZsj7Xlx9FkLX8ox5Zwi6XTx12qGeUDssenekh6LRNz/JP+5NhOHqNpRCRiVuld3TJKw01Qmk82KZr77cfJSVAhqraa2JuABtUZ/T1fI4vvO6s4iPOSwRV01jgVONI1D91DNsO02H3qQGdDeFleqzP7pSt/rowyuT2sp7FLs49Xt7fFgHGtu65kq01SCvaJB0Vn6XJQy+an65ktScpMMBdSDbOmnYL2nGeQusID/VrdTMAWmS+OkNwMuR+knDkDWQNFwXbGqI00QCG0gkZtW1ib20LYMX4TD07ZdoX7GUrPnZcUcmQDKlSleb2RfVpsrX5YGb+2oqVLKA1A3H7LgDN/R7kEDtfFFLqF+kSeqsrRki1SZi3H5q70RlZbrV6qmUrSusKsyYb/4NmbfRnynbi9qCWdhAM0WKYj3lyr
x-ms-exchange-antispam-messagedata: 5rdirxgYXIkt7CJQsnlbQXS9X8vtXOUgLeqhY/5CRnu/VJhoazHHNQy5/1/EFRVDN9sww4HSB5kDbxyCkNEEJ6cirI0EjYN1tIPF4o0pchbjXBUr17Yb8JWz9zKUEdYPZb0O+QyP2dKdtes5cDtz1Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197ee13b-34df-40fb-ec0c-08d7e1e52cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:04:30.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Am8Wrgb1EJn7wnOnvxBG9u7DMpT7qMn5fZiGo+ZVwpb54fe7f2e4z1iD04kojo6nsxbWYfQBTN+6/rUg+H10tSn8gPPblfDHcjUhyKmViFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYgQXByaWwgMjAyMCAwOTowMCwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+ID4gKy8qDQo+ID4g
KyAqIFJhdyBJMkMgYWNjZXNzIHJlcXVpcmVkIGZvciBqdXN0IGFjY2Vzc2luZyBjaGlwIGFuZCB2
YXJpYW50IGluZm8gYmVmb3JlIHdlDQo+ID4gKyAqIGtub3cgd2hpY2ggZGV2aWNlIGlzIHByZXNl
bnQuIFRoZSBpbmZvIHJlYWQgZnJvbSB0aGUgZGV2aWNlIHVzaW5nIHRoaXMNCj4gPiArICogYXBw
cm9hY2ggaXMgdGhlbiB1c2VkIHRvIHNlbGVjdCB0aGUgY29ycmVjdCByZWdtYXAgdGFibGVzLg0K
PiA+ICsgKi8NCj4gPiArc3RhdGljIGludCBkYTkwNjNfaTJjX2Jsb2NrcmVnX3JlYWQoc3RydWN0
IGkyY19jbGllbnQgKmNsaWVudCwgdTE2IGFkZHIsDQo+ID4gKwkJCQkgICAgdTggKmJ1ZiwgaW50
IGNvdW50KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaTJjX21zZyB4ZmVyWzNdOw0KPiA+ICsJdTgg
cGFnZV9udW0sIHBhZ2VkX2FkZHI7DQo+ID4gKwl1OCBwYWdlX2J1ZlsyXTsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJLyogRGV0ZXJtaW5lIHBhZ2UgaW5mbyBiYXNlZCBvbiByZWdpc3Rl
ciBhZGRyZXNzICovDQo+ID4gKwlwYWdlX251bSA9IChhZGRyIC8gMHgxMDApOw0KPiANCj4gUGxl
YXNlIGRlZmluZSBtYWdpYyBudW1iZXJzLg0KPiANCj4gPiArCWlmIChwYWdlX251bSA+IDEpDQo+
IA0KPiBQbGVhc2UgZGVmaW5lIG1hZ2ljIG51bWJlcnMuDQoNCkkgd2FzIGdvaW5nIHRvIGJ1dCBk
ZWNpZGVkIGFnYWluc3QgaXQgZ2l2ZW4gdGhlIG1pbmltYWwgdXNlLiBFYXN5IGVub3VnaCB0bw0K
Y2hhbmdlIHRob3VnaC4NCg0KPiANCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IERvIHlv
dSB3YW50IHRvIGZhaWwgc2lsZW50bHkgaGVyZT8NCg0KV2VsbCBhbiBlcnJvciBtZXNzYWdlIGlz
IHByaW50ZWQgaW4gdGhlIGNhbGxpbmcgY29kZSwgc28gZGlkbid0IGZlZWwgbGlrZSBpdA0Kd2Fz
IG5lY2Vzc2FyeSB0byBoYXZlIGFkZGl0aW9uYWwgZGVidWcgaGVyZS4gRmVsdCBsaWtlIGJsb2F0
Lg0KDQo+IA0KPiA+ICsJcGFnZWRfYWRkciA9IChhZGRyICUgMHgxMDApICYgMHhGRjsNCj4gPiAr
CXBhZ2VfYnVmWzBdID0gREE5MDYzX1JFR19QQUdFX0NPTjsNCj4gPiArCXBhZ2VfYnVmWzFdID0g
KHBhZ2VfbnVtIDw8IERBOTA2M19JMkNfUEFHRV9TRUxfU0hJRlQpICYNCj4gPiArCQkgICAgICBE
QTkwNjNfUkVHX1BBR0VfTUFTSzsNCj4gPiArDQo+ID4gKwkvKiBXcml0ZSByZWcgYWRkcmVzcywg
cGFnZSBzZWxlY3Rpb24gKi8NCj4gPiArCXhmZXJbMF0uYWRkciA9IGNsaWVudC0+YWRkcjsNCj4g
PiArCXhmZXJbMF0uZmxhZ3MgPSAwOw0KPiA+ICsJeGZlclswXS5sZW4gPSAyOw0KPiA+ICsJeGZl
clswXS5idWYgPSBwYWdlX2J1ZjsNCj4gPiArDQo+ID4gKwkvKiBTZWxlY3QgcmVnaXN0ZXIgYWRk
cmVzcyAqLw0KPiA+ICsJeGZlclsxXS5hZGRyID0gY2xpZW50LT5hZGRyOw0KPiA+ICsJeGZlclsx
XS5mbGFncyA9IDA7DQo+ID4gKwl4ZmVyWzFdLmxlbiA9IDE7DQo+ID4gKwl4ZmVyWzFdLmJ1ZiA9
ICZwYWdlZF9hZGRyOw0KPiA+ICsNCj4gPiArCS8qIFJlYWQgZGF0YSAqLw0KPiA+ICsJeGZlclsy
XS5hZGRyID0gY2xpZW50LT5hZGRyOw0KPiA+ICsJeGZlclsyXS5mbGFncyA9IEkyQ19NX1JEOw0K
PiA+ICsJeGZlclsyXS5sZW4gPSBjb3VudDsNCj4gPiArCXhmZXJbMl0uYnVmID0gYnVmOw0KPiA+
ICsNCj4gPiArCXJldCA9IGkyY190cmFuc2ZlcihjbGllbnQtPmFkYXB0ZXIsIHhmZXIsIDMpOw0K
PiANCj4gV2h5IGlzIHRoaXMgMz8gICdjb3VudCcgYW5kIGEgTlVMTCBjaGFyPw0KDQpXZWxsIHRo
ZXJlIGFyZSAzIG1lc3NhZ2VzIGRlZmluZWQgYWJvdmUgc28gSSB3YW50IHRvIHByb2Nlc3MgYWxs
IG9mIHRoZW0uIE9uZSB0bw0Kc2V0IHRoZSBwYWdlIHJlZ2lzdGVyIHRvIHRoZSBwYWdlIHdlIHdh
bnQgdG8gcmVhZCBmcm9tLCBvbmUgdG8gc2VsZWN0IHRoZQ0KcmVnaXN0ZXIgd2Ugd2FudCB0byBy
ZWFkIGZyb20gaW4gdGhhdCBwYWdlIGFuZCB0aGVuIGZpbmFsbHkgdGhlIHJlYWQgYmFjayBvZiAN
CnRoZSBjaGlwIGlkIGFuZCByZXZpc2lvbi92YXJpYW50IGluZm8uDQoNCj4gDQo+ID4gKwlpZiAo
cmV0ID09IDMpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwllbHNlIGlmIChyZXQgPCAwKQ0KPiA+
ICsJCXJldHVybiByZXQ7DQo+ID4gKwllbHNlDQo+ID4gKwkJcmV0dXJuIC1FSU87DQo+IA0KPiBJ
IHRoaW5rIHRoZSBmb2xsb3dpbmcgbWFrZXMgaXQgc2xpZ2h0bHkgY2xlYXJlci4NCj4gDQo+IAlp
ZiAocmV0IDwgMCkNCj4gCQlyZXR1cm4gcmV0Ow0KPiANCj4gCWlmIChyZXQgPT0gMykNCj4gCQly
ZXR1cm4gMDsNCj4gCWVsc2UNCj4gCQlyZXR1cm4gLUVJTzsNCj4NCg0KT2suIERvbid0IHRoaW5r
IGl0IG1ha2VzIG11Y2ggb2YgYSBkaWZmZXJlbmNlIGJ1dCBkb24ndCBtaW5kIHJlYWxseS4gSSBj
YW4gYWRkIGENCiNkZWZpbmUgZm9yIHRoZSBudW1iZXIgb2YgbWVzc2FnZXMgdG8gYmUgc2VudCB3
aGljaCB3aWxsIGNsYXJpZnkgdGhpcyBzbGlnaHRseQ0KYW55d2F5Lg0KDQo+ID4gK30NCj4gPiAr
DQo+ID4gK2VudW0gew0KPiA+ICsJREE5MDYzX0RFVl9JRF9SRUcgPSAwLA0KPiA+ICsJREE5MDYz
X1ZBUl9JRF9SRUcsDQo+ID4gKwlEQTkwNjNfQ0hJUF9JRF9SRUdTLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBkYTkwNjNfZ2V0X2RldmljZV90eXBlKHN0cnVjdCBpMmNfY2xpZW50
ICppMmMsIHN0cnVjdCBkYTkwNjMNCj4gKmRhOTA2MykNCj4gPiArew0KPiA+ICsJaW50IHJldDsN
Cj4gPiArCXU4IGJ1ZltEQTkwNjNfQ0hJUF9JRF9SRUdTXTsNCj4gDQo+IFJlYWxseSBzbWFsbCBu
aXQ6IENvdWxkIHlvdSByZXZlcnNlIHRoZXNlIHBsZWFzZS4NCg0KWWVwLCBhZ3JlZWQuDQoNCj4g
DQo+ID4gKwlyZXQgPSBkYTkwNjNfaTJjX2Jsb2NrcmVnX3JlYWQoaTJjLCBEQTkwNjNfUkVHX0RF
VklDRV9JRCwgYnVmLA0KPiA+ICsJCQkJICAgICAgIERBOTA2M19DSElQX0lEX1JFR1MpOw0KPiA+
ICsJaWYgKHJldCA8IDApIHsNCj4gDQo+IGlmIChyZXQpDQo+IA0KPiBPciBiZXR0ZXIgeWV0LCBh
cyB0aGlzIGlzIGEgcmVhZCBmdW5jdGlvbiwgeW91IGNvdWxkIGp1c3QgcmV0dXJuDQo+IGkyY190
cmFuc2ZlcigpIGFuZCBkbyB0aGUgYXBwcm9wcmlhdGUgZXJyb3IgY2hlY2tpbmcgaGVyZSAqaW5z
dGVhZCouDQoNCkkgdGhpbmsgZ2l2ZW4gdGhhdCB0aGUgZnVuY3Rpb24gaGFuZGxlcyBhbGwgb2Yg
dGhlIEkyQyBzcGVjaWZpYyBzdHVmZiBJJ2QgcHJlZmVyDQppdCBiZSBrZXB0IHRoZXJlLiBMb2dp
Y2FsbHkgdGhhdCB0byBtZSBtYWtlcyBtb3JlIHNlbnNlLiBDYW4gY2hhbmdlIHRoaXMgdG8NCidp
ZiAocmV0KScNCg0KPiANCj4gPiArCQlkZXZfZXJyKGRhOTA2My0+ZGV2LCAiQ2Fubm90IHJlYWQg
Y2hpcCBpZCBpbmZvLlxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlpZiAoYnVmW0RBOTA2M19ERVZfSURfUkVHXSAhPSBQTUlDX0NISVBfSURfREE5MDYzKSB7
DQo+ID4gKwkJZGV2X2VycihkYTkwNjMtPmRldiwNCj4gPiArCQkJIkludmFsaWQgY2hpcCBkZXZp
Y2UgaWQ6IDB4JTAyeFxuIiwNCj4gDQo+IHMvaWQvSUQvDQoNCnllcCwgd2lsbCB1cGRhdGUuDQoN
Cj4gPiBAQCAtMTk5LDE4ICsyODksNTYgQEAgc3RhdGljIGludCBkYTkwNjNfaTJjX3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICppMmMsDQo+ID4gIAlkYTkwNjMtPmNoaXBfaXJxID0gaTJjLT5pcnE7
DQo+ID4gIAlkYTkwNjMtPnR5cGUgPSBpZC0+ZHJpdmVyX2RhdGE7DQo+ID4NCj4gPiAtCWlmIChk
YTkwNjMtPnZhcmlhbnRfY29kZSA9PSBQTUlDX0RBOTA2M19BRCkgew0KPiA+IC0JCWRhOTA2M19y
ZWdtYXBfY29uZmlnLnJkX3RhYmxlID0gJmRhOTA2M19hZF9yZWFkYWJsZV90YWJsZTsNCj4gPiAt
CQlkYTkwNjNfcmVnbWFwX2NvbmZpZy53cl90YWJsZSA9DQo+ICZkYTkwNjNfYWRfd3JpdGVhYmxl
X3RhYmxlOw0KPiA+IC0JCWRhOTA2M19yZWdtYXBfY29uZmlnLnZvbGF0aWxlX3RhYmxlID0NCj4g
JmRhOTA2M19hZF92b2xhdGlsZV90YWJsZTsNCj4gPiAtCX0gZWxzZSBpZiAoZGE5MDYzLT50eXBl
ID09IFBNSUNfVFlQRV9EQTkwNjNMKSB7DQo+ID4gLQkJZGE5MDYzX3JlZ21hcF9jb25maWcucmRf
dGFibGUgPSAmZGE5MDYzbF9iYl9yZWFkYWJsZV90YWJsZTsNCj4gPiAtCQlkYTkwNjNfcmVnbWFw
X2NvbmZpZy53cl90YWJsZSA9DQo+ICZkYTkwNjNsX2JiX3dyaXRlYWJsZV90YWJsZTsNCj4gPiAt
CQlkYTkwNjNfcmVnbWFwX2NvbmZpZy52b2xhdGlsZV90YWJsZSA9DQo+ICZkYTkwNjNsX2JiX3Zv
bGF0aWxlX3RhYmxlOw0KPiA+IC0JfSBlbHNlIHsNCj4gPiAtCQlkYTkwNjNfcmVnbWFwX2NvbmZp
Zy5yZF90YWJsZSA9ICZkYTkwNjNfYmJfcmVhZGFibGVfdGFibGU7DQo+ID4gLQkJZGE5MDYzX3Jl
Z21hcF9jb25maWcud3JfdGFibGUgPQ0KPiAmZGE5MDYzX2JiX3dyaXRlYWJsZV90YWJsZTsNCj4g
PiAtCQlkYTkwNjNfcmVnbWFwX2NvbmZpZy52b2xhdGlsZV90YWJsZSA9DQo+ICZkYTkwNjNfYmJf
dm9sYXRpbGVfdGFibGU7DQo+ID4gKwlyZXQgPSBkYTkwNjNfZ2V0X2RldmljZV90eXBlKGkyYywg
ZGE5MDYzKTsNCj4gPiArCWlmIChyZXQgPCAwKQ0KPiANCj4gSXMgYSBwb3NpdGl2ZSByZXR1cm4g
dmFsdWUgdmFsaWQ/DQo+IA0KPiBJZiBub3Q6IGlmIChyZXQpDQo+IA0KDQpZZXAsIHRoaW5rIHRo
aXMgY2FuIGJlIGp1c3QgJ2lmIChyZXQpJw0KDQo=
