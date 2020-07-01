Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589BD2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vS5BfBSO";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RPNUvM1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgGAJru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:47:50 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:13758 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgGAJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593596868; x=1625132868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f8njmB0Cv8UwYGw7t2XG/4T60/CXMZmYFYSHtgLYA1A=;
  b=vS5BfBSON+ztxzby0krPNYinAgXZIOq3apDlKJTn2YMu8igQGvO7k9sj
   1iVl6cuYgOGEL4My5zB+4dnmZFlr3PYxhqpFzxxQ3QUnZ6e+coXPs75gE
   piNDvKqTyu+ekGhpWCL5F0q73+4x+duyvNPu2/OKt0D4R4xFthvP1Tm7f
   FW1Rfh+HpJl1Et8JS2coLl0DGwmp0GW8DXgQtn157wLmoEDWRar8XW+ey
   K022/Ve2TM5hEJUEaYfmARJeQI9l7OCxfaYndVolM9eNCeWFoSsGjUFUC
   EYPBav3CzKOKvl/3TNJnQfkaDJYyZs7LtM3oai+pg+Ll4iGE+CoMN1LsH
   w==;
IronPort-SDR: qZUo9P+c/SaQ9OixZbJmaMbv+1e7p45O1MWdB1fE13ERdxWURYC19aczUTodJOtplkk9G206Gv
 IB/PDgkD8btV69B3vrbfEzcC+QXwjC2Nz6D+6b8G9g4uQnvCjr3cMy2fTQsQLl5vRgZ3MiM8KQ
 m1APhop3FR1U4JIgqRJCt9HE63R7dvksuCRGDeLFjk+2azFNdmVMKe5DH00PbL5Osx0NuNEzNM
 IRe2BkSYShUnYHUZOoy2K04yJtKGfMFOURbzpggzZm+BcBselRC/gxldtGVXFU0JEksL4AE0XA
 WLg=
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="78403906"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2020 02:47:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 02:47:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 1 Jul 2020 02:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVYzxOi9+hs5SJShDSBVZJs2qdDc/Klh3LYzyOZa3yHIU3bkebOKmYFm0HagSEqScn53CgTQAJLyAjS8LwY9B/38ks/sSJ3Pp7h7O1+ADw+XGTzWSwICBWyhTx0RX64ymysMWVOTzqSGHht7fCcib9CnQHteKWlL6+I4ND1GH5TpApLNXrzlAHalCFrRay6cAfpAU5KVdBzpQdzqHWRqu5hnw2JzI7RM1qWVBGl5Mj74i49T0AKc791Y4D2VgvVrIBxAcc6y0g8oXRjbkweQc7YVzS4QSkcTovTJMZUW6nB82hgaeoG+DQKYrHqfSvQBIlSq/V9DodiDQru7P19qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8njmB0Cv8UwYGw7t2XG/4T60/CXMZmYFYSHtgLYA1A=;
 b=X2KZlGjJEepnvFZ5wf/3cST38RFM8mKCQf2d+LgbU4azBsFoB1BpB9x/2QCf+6P5WNvpuWWdQgZM9U5WzKVdr2eXn3JZ4yuv7v8awEnuoTef6KNkrePW3DtMEKt5n8jsnlr5Xb4vOQFQ61zjadcnGL4C8uGKGr+qoVncGKkVsuu2hN5TovgCh8e2LURFTAeNA1Xr3fxFeml6Gnpmglm2ernRTB8KT+d41kAhNPRWqYK8MlEbBJI5txzLlUPp4JaH5phvkn4AxZPKm4bC5oySXOPbOYjoldWCdCPij2v7XOXtwS/M/83jb4OWwpi4zze/B5bjDDy3tLg+UQn8RBHdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8njmB0Cv8UwYGw7t2XG/4T60/CXMZmYFYSHtgLYA1A=;
 b=RPNUvM1hnPu5Jc4nTTmUasPpOx1DhwbdY6agjDqxNu0RmmBK/+NVYVxXEDVq99KTYt2MSujNBnyeiL3Sjjl4LeQxaY2J18RFLyGkd324CtbpPg088EDUkZYOJS/w04rxWNZwfeqVAZVz8Vx62blZ027ywFTxOxKm+4nAFDFAJJY=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1786.namprd11.prod.outlook.com (2603:10b6:3:113::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21; Wed, 1 Jul 2020 09:47:40 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8fd:29e5:1fa6:c01d]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8fd:29e5:1fa6:c01d%5]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 09:47:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>, <mturquette@linaro.org>,
        <bbrezillon@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] clk: at91: main: do not continue if oscillators
 already prepared
Thread-Topic: [PATCH 2/2] clk: at91: main: do not continue if oscillators
 already prepared
Thread-Index: AQHWT4yoeo1FeyzI40WRQ/N11qPgjA==
Date:   Wed, 1 Jul 2020 09:47:40 +0000
Message-ID: <0558282c-1471-84fb-d0f2-00e998db5cab@microchip.com>
References: <1593079768-9349-1-git-send-email-claudiu.beznea@microchip.com>
 <1593079768-9349-2-git-send-email-claudiu.beznea@microchip.com>
 <20200626210357.GX131826@piout.net>
In-Reply-To: <20200626210357.GX131826@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.222.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de25ecd9-47ba-4de2-b0b8-08d81da3cb74
x-ms-traffictypediagnostic: DM5PR11MB1786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1786C070DC645C89CC7477D9876C0@DM5PR11MB1786.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lq0csEfE5k40+ZSa1N6pTzX4iCSBrknEFDPnaNSOEnfR/rQLyKXw4+3cT3TTJwMIIonhaZcZTiPXaf19337VbDfO5wqXK/vRO1gTL+L0O1MgziqzfEXdNlLmuHKxtWt5Oq06iGHk6zGo71rBfF7DVO9V3HJtSXdlfstoeqh+X7pKp61tdSUiwvHvp6BtjZlqiXB6st5G12JrEgOsQoXeqTy7GttGX4/yDIG7CeRqRQtE/UFDFBz9nV8/Y2dyCHpXN3ZCkKQRR3rVxoAoDRCinJIDgoxzWlJ0UiIIOmjQe5mATpHrVvN9+DlKoJ1rho28erKwCu0ZFY27lqHxP0luKbyKWexJK0YSBjG3O/02TeA8U7/p7jbEYZ7meg47kYzjrz+Yx7MJXhfLt9J9fF44nX9AOqaXPQGU1QzY8eQEovV1vTonnPvY5+mTz9tnP5wKKR9B5pCGezXlFoVc/YPhdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39860400002)(136003)(376002)(346002)(6512007)(478600001)(2906002)(186003)(36756003)(316002)(54906003)(6486002)(2616005)(4326008)(83380400001)(6916009)(8676002)(31696002)(66946007)(91956017)(76116006)(6506007)(53546011)(8936002)(966005)(31686004)(5660300002)(26005)(86362001)(71200400001)(66446008)(64756008)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T55GNlJB5m4EKn8nz3NpIZ5aAyXeS4dF7v4MDk31sH3rW4O96/vVGNrumCYzezQ9yfPbpwsKawBg5yPDYqFU15qgdsxln3m4zG4AqCkqOTJHdGMuq05PSQRl9cSyXX3htJ+6409846pdvkdcVUkhUIM7pTHk291LO2wdoCO6qGUfu6o/abYXZL9IuMT3S0/IC/yk7JQRYLmojvVeYntJ/4LExR4CiqTApWkOqOn+cRNMTahr4Qy0xTsd4eHa9M/K9/JRMK9Kuf409fH9aEFC0iE+3Ii70x+JMnqyjsN1ICh5GX/cyX8ipzutea24gL1AcTN2w5alA9/R/RkakBNUhTeSACXyJ+ACNykYb2C3EYbuEHIaktKRy6nZBFH64OQSjayTYHjVnRuVvyJ4Qd2Y9b9PudVWZ6ohw65cwdKo7m8erAwOyQJ20OEghqT1JIYK/LRhFmB9IIawWNniw2LoMYeqMf15yUS9NPkFIuirJUre+KjItI6l0KK3/IrmXzr9
Content-Type: text/plain; charset="utf-8"
Content-ID: <37090B53A3E58D4ABDC11BD5047CCA5E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de25ecd9-47ba-4de2-b0b8-08d81da3cb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:47:40.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBL/HwkVCleQd818Oqok1owHdvF/K4M1I50vXGATgpQjrqWcEbj73G9yi0zNOalH7Wp8xXhnyGh5pTryFPxQa7Y1Ur/CVR5R7m4z3oYVhww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI3LjA2LjIwMjAgMDA6MDMsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI1LzA2LzIwMjAgMTM6MDk6
MjgrMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBSZXR1cm4gaW4gY2xrX21haW5fb3Nj
X3ByZXBhcmUoKS9jbGtfbWFpbl9yY19vc2NfcHJlcGFyZSgpIGlmDQo+PiBvc2NpbGxhdG9ycyBh
cmUgYWxyZWFkeSBlbmFibGVkLg0KPj4NCj4+IEZpeGVzOiAyN2NiMWMyMDgzMzczICgiY2xrOiBh
dDkxOiByZXdvcmsgbWFpbiBjbGsgaW1wbGVtZW50YXRpb24iKQ0KPj4gRml4ZXM6IDFiZGYwMjMy
NmI3MWUgKCJjbGs6IGF0OTE6IG1ha2UgdXNlIG9mIHN5c2Nvbi9yZWdtYXAgaW50ZXJuYWxseSIp
DQo+IA0KPiBJcyB0aGlzIHJlYWxseSBhIGZpeD8gV2hhdCBpcyB0aGUgb2JzZXJ2ZWQgaXNzdWU/
DQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMgfCAx
OCArKysrKysrKystLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2Ns
ay1tYWluLmMgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMNCj4+IGluZGV4IDM3YzIyNjY3
ZTgzMS4uNDZiNGQyMTMxOTg5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGst
bWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMNCj4+IEBAIC03NCwx
MyArNzQsMTEgQEAgc3RhdGljIGludCBjbGtfbWFpbl9vc2NfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3
ICpodykNCj4+ICAgICAgIHJlZ21hcF9yZWFkKHJlZ21hcCwgQVQ5MV9DS0dSX01PUiwgJnRtcCk7
DQo+PiAgICAgICB0bXAgJj0gfk1PUl9LRVlfTUFTSzsNCj4+DQo+PiAtICAgICBpZiAodG1wICYg
QVQ5MV9QTUNfT1NDQllQQVNTKQ0KPj4gKyAgICAgaWYgKHRtcCAmIChBVDkxX1BNQ19PU0NCWVBB
U1MgfCBBVDkxX1BNQ19NT1NDRU4pKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+
IFdoaWxlIHRoaXMgc2VlbXMgbGlrZSBhIGdvb2Qgb3B0aW1pemF0aW9uLCBpdCBpcyBhbHNvIG5v
dCBjb3JyZWN0Lg0KPiBIYXZpbmcgQVQ5MV9QTUNfTU9TQ0VOIHNldCBkb2Vzbid0IG1lYW4gdGhh
dCB0aGUgY2xvY2sgaXMgcmVhZHksIHlvdQ0KPiBuZWVkIHRvIGF0IGxlYXN0IGNoZWNrIE1PU0NT
IG9uY2UuDQoNCkkgYWdyZWUhIFRoaXMgaXMgbWF5IGludHJvZHVjZSBpc3N1ZXMuIFRoYW5rIHlv
dSBmb3IgcmV2aWV3aW5nIGl0Lg0KDQo+IA0KPj4NCj4+IC0gICAgIGlmICghKHRtcCAmIEFUOTFf
UE1DX01PU0NFTikpIHsNCj4+IC0gICAgICAgICAgICAgdG1wIHw9IEFUOTFfUE1DX01PU0NFTiB8
IEFUOTFfUE1DX0tFWTsNCj4+IC0gICAgICAgICAgICAgcmVnbWFwX3dyaXRlKHJlZ21hcCwgQVQ5
MV9DS0dSX01PUiwgdG1wKTsNCj4+IC0gICAgIH0NCj4+ICsgICAgIHRtcCB8PSBBVDkxX1BNQ19N
T1NDRU4gfCBBVDkxX1BNQ19LRVk7DQo+PiArICAgICByZWdtYXBfd3JpdGUocmVnbWFwLCBBVDkx
X0NLR1JfTU9SLCB0bXApOw0KPj4NCj4+ICAgICAgIHdoaWxlICghY2xrX21haW5fb3NjX3JlYWR5
KHJlZ21hcCkpDQo+PiAgICAgICAgICAgICAgIGNwdV9yZWxheCgpOw0KPj4gQEAgLTE4NiwxMCAr
MTg0LDEyIEBAIHN0YXRpYyBpbnQgY2xrX21haW5fcmNfb3NjX3ByZXBhcmUoc3RydWN0IGNsa19o
dyAqaHcpDQo+Pg0KPj4gICAgICAgcmVnbWFwX3JlYWQocmVnbWFwLCBBVDkxX0NLR1JfTU9SLCAm
bW9yKTsNCj4+DQo+PiAtICAgICBpZiAoIShtb3IgJiBBVDkxX1BNQ19NT1NDUkNFTikpDQo+PiAt
ICAgICAgICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhyZWdtYXAsIEFUOTFfQ0tHUl9NT1IsDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNT1JfS0VZX01BU0sgfCBBVDkxX1BN
Q19NT1NDUkNFTiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUOTFfUE1D
X01PU0NSQ0VOIHwgQVQ5MV9QTUNfS0VZKTsNCj4+ICsgICAgIGlmIChtb3IgJiBBVDkxX1BNQ19N
T1NDUkNFTikNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiArDQo+PiArICAgICByZWdt
YXBfdXBkYXRlX2JpdHMocmVnbWFwLCBBVDkxX0NLR1JfTU9SLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIE1PUl9LRVlfTUFTSyB8IEFUOTFfUE1DX01PU0NSQ0VOLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIEFUOTFfUE1DX01PU0NSQ0VOIHwgQVQ5MV9QTUNfS0VZKTsNCj4+DQo+
PiAgICAgICB3aGlsZSAoIWNsa19tYWluX3JjX29zY19yZWFkeShyZWdtYXApKQ0KPj4gICAgICAg
ICAgICAgICBjcHVfcmVsYXgoKTsNCj4+IC0tDQo+PiAyLjcuNA0KPj4NCj4gDQo+IC0tDQo+IEFs
ZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5n
aW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiA=
