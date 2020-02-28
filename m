Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BA82468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aMF7wJde";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jv712IdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgB1TDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:03:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49105 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgB1TDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582916584; x=1614452584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QKFNgn/08Bf8rn8ZePMHJ0UHB3SKvgRw+Q3FGsM4I3Q=;
  b=aMF7wJdetDKaUzWxKAHIH1pkHzIAHhJWWbAcK3v0v9bq/DXplZSiD1vZ
   CfyyX/qKb4RV9ikWyUxzMJB3UrT8BhSmUQmvDnnkx4ZI/I7Do5KyvZ0qI
   gGonnQ3TRpmpMZD6qsAU43mTxtl+muNIBFm+VBSTIbF7/xUexa4QuSHc8
   JnINvozNM02Dc87Fy6xOpXFQjiYNsyRuuv2M9yt+CR9CxrInD6LcpQQpq
   iYtwLSrd0wDlCqOvOKkGwVhAS0RhHvPMt1pGBgjwKYRf6U2PBGqOfpKX+
   VDBl6tYDIHJ70EwOuxg10XVNTHfJHbKfofFX64zvbrZN6+m2vc8qOX2EH
   w==;
IronPort-SDR: Slbb9UafPfv6qMOWOsZI39UUhvOBvORQp6183RRGkvEwWxJ3HbxZxbgPpA4MQjjWchYv2SJvdW
 j4yPlg12vuZL/AnJLY2NMlFLHs0JdM5j7fddv8kubnGrJiY08CRjnETRwAbNSXVA2O5QJ2AP1r
 RR6MhwUQdvfmv0o1CcNZlW6loZ21pUk9SsMisavVqdSOdk6euXZnr3GN1b7F8ZCzcF4SrtWAAa
 UgAVq0lmXUM5u3TC/fLWjCJ/QcIkr6/a0s1ozULbqMStuD3HNxzfiA53NoDSbBCqQME7MUbu7Q
 RiA=
X-IronPort-AV: E=Sophos;i="5.70,497,1574092800"; 
   d="scan'208";a="131543172"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Feb 2020 03:03:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3WZhDMIYVfHoczFoeMdHdGM1+/p+g4nsZ2/VZt2EL82aT70PQgkXgzVgLQ8CaNiWpxXKNn4jWb6Y/7ksDhlIbI89PdNcYCUYBrTGmvjuw7h5mVr+5KM2eKUJbnoVPuETPjfAWCiN2bwbA75q45OnekQJJ0obV27Ge1SWFFgiJ1B8ezcYfg03IqGE64oJl2JpUjhMrpdI2Nqj8NXJaqPlz8VxMAUgO7tQmcNSDfjubGik3VXHcr33TKGrsHrCs73uGzCeTQK8yRyyf6cn8Y/LkFC3LjOjYp0lCvOlba7RZ8Nglbv6THSEyhphO+6eakHmW3J5HombFJINxv5E4EdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFNgn/08Bf8rn8ZePMHJ0UHB3SKvgRw+Q3FGsM4I3Q=;
 b=TYTpbitUurZpLAlPMuW63560ckznyBAYd9hzdv0Baku3wd+qBfL5MCvgHGK92Y4gQZg2YeGdGrsfff2Ls+W0wK5kF3MzVxABmthiNWxdmeyU5IClaqCCbefcAdwrcp3OkDcUY+ELwnVa4YMU1jg+7wE+5JqVJcAtgVtvCw56zaIVDbVJCKWhtgosaahclF3REHj0Af7jggLqJzr7BK4lQJsQ7m9XH0/qTnSzdiIfF1QfhOyEvUUR/qoNf/F8xXp3vtuJxBS0I2W14eJT5YRMqvwNxvLr55mSnvi1xcyg12194//pcPbBIk7assXBaPfDFlUQ/sLxSE3DvDe5/cpCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFNgn/08Bf8rn8ZePMHJ0UHB3SKvgRw+Q3FGsM4I3Q=;
 b=jv712IdW61h7mrtbnowO+RYNN4x68dkpqj797P81A/ZGM5FCRFlamKyagsLaWLrexD0YUAClPMr/4CeZzkXuT+8hShPgQ228hXs+276iC7I+AAJrghhsz4YwoqNW932hNLajsdYGhGXttk56bcN6tLnuFUSHiRaE9vCIlIhGsik=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB3894.namprd04.prod.outlook.com (2603:10b6:a02:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 28 Feb
 2020 19:03:00 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 19:03:00 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
Subject: Re: [v2 PATCH] irqchip/sifive-plic: Add support for multiple PLICs
Thread-Topic: [v2 PATCH] irqchip/sifive-plic: Add support for multiple PLICs
Thread-Index: AQHV6Q3tn8hvurxLp0+iAdxe4kYX3Kgw/rKAgAAClIA=
Date:   Fri, 28 Feb 2020 19:03:00 +0000
Message-ID: <39c1cd2c80d67b8b39fe6e2f867e65fd2d42f6d6.camel@wdc.com>
References: <20200221232246.9176-1-atish.patra@wdc.com>
         <6a1320aed9609788ccb61d6c66d670bb@kernel.org>
In-Reply-To: <6a1320aed9609788ccb61d6c66d670bb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ce6b8ce-ec5f-49c5-8c7b-08d7bc80d4af
x-ms-traffictypediagnostic: BYAPR04MB3894:
x-microsoft-antispam-prvs: <BYAPR04MB38945682FB9ACE23F7A3C8E9FAE80@BYAPR04MB3894.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(2906002)(6916009)(71200400001)(5660300002)(186003)(81156014)(4326008)(6512007)(8936002)(81166006)(8676002)(26005)(86362001)(6486002)(36756003)(316002)(478600001)(966005)(66946007)(53546011)(6506007)(66556008)(64756008)(66446008)(66476007)(2616005)(54906003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3894;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMEPp1WU+dS+HuxLzXz0yxFr+skMfFiUBKQa4+qqyP1S7+tPVqmbYmVXb6kcADzBauwjuzTA18uikZnxALFJuxSOnPQJ/FIMOzFKsGM3iBID/O58qco0nZ95FDWq4RlDlKCQDXV0b/qMFkC/JSkJYjLnGC77EIwRZ+4oPCXtoX/dwi6X7lIFbOyTkMNY8xWhKR53nGWna18WoKE/5XiOu80HjNqup/W1i8PlNOXE3YIpqsbMRy+pqbu6cJhprohjc1tcL987QtGkMXcUIRJV84qC2XWCliGnJGkYebvDlZsswoiGZvDEyA5/3HbouI3wnk7P/f7wifshA0h8ehEVOuhLYpi2t1+4TykxJjK2/ZDEq2gzfv1HuBnY4KDEpdLWPGUsO4sFmiSEgovBkqcQAzgOe4RhovRDeuxGCFX5DJ/RDpB7Y4405eiUpPyMiew0zPVo6TUgcjH3n47hhZdYgOWkBzX9vynDawdoAh6f2BaGytRHDPxkLdSwmht+4LMvifYgeyOhwRqZPeNxEcn/Ag==
x-ms-exchange-antispam-messagedata: ekg3Ra3t/FSEzJiDeYTjqLEIRNZZqPvLTrgsene6ErI8eEbDLt/zQwHwT2l16D/v13HkYQ3dhkhzF15OS1MxyYOQJ/uhWi3rTQwRw9KDeqHHTnikqezbCk2iN4iqmzqXWUg2rcduOYY7jGKxIRmdLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D5AC372C6297F43917DE3076CECA168@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce6b8ce-ec5f-49c5-8c7b-08d7bc80d4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 19:03:00.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lYOcDvXA2H8bKHf0TnYWZMqUxM9AFajEFay1Ifdt0hhz5Z2JzyVDoePHXHHz2uJ2wd3rrmOaOI2eD3l8leXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTI4IGF0IDE4OjUzICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDIwMjAtMDItMjEgMjM6MjIsIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiA+IEN1cnJlbnQsIFBM
SUMgZHJpdmVyIGNhbiBzdXBwb3J0IG9ubHkgMSBQTElDIG9uIHRoZSBib2FyZC4gSG93ZXZlciwN
Cj4gPiB0aGVyZSBjYW4gYmUgbXVsdGlwbGUgUExJQ3MgcHJlc2VudCBvbiBhIHR3byBzb2NrZXQg
c3lzdGVtcyBpbg0KPiA+IFJJU0MtVi4NCj4gPiANCj4gPiBNb2RpZnkgdGhlIGRyaXZlciBzbyB0
aGF0IGVhY2ggUExJQyBoYW5kbGVyIGNhbiBoYXZlIGEgaW5mb3JtYXRpb24NCj4gPiBhYm91dCBp
bmRpdmlkdWFsIFBMSUMgcmVnaXN0ZXJzIGFuZCBhbiBpcnFkb21haW4gYXNzb2NpYXRlZCB3aXRo
DQo+ID4gaXQuDQo+ID4gDQo+ID4gVGVzdGVkIG9uIHR3byBzb2NrZXQgUklTQy1WIHN5c3RlbSBi
YXNlZCBvbiBWQ1UxMTggRlBHQSBjb25uZWN0ZWQNCj4gPiB2aWENCj4gPiBPbW5pWHRlbmQgcHJv
dG9jb2wuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJh
QHdkYy5jb20+DQo+ID4gLS0tDQo+ID4gVGhpcyBwYXRjaCBpcyByZWJhc2VkIG9uIHRvcCBvZiA1
LjYtcmMyIGFuZCBmb2xsb3dpbmcgcGxpYyBmaXggZnJvbQ0KPiA+IGhvdHBsdWcgc2VyaWVzLg0K
PiA+IA0KPiA+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzIvMjAvMTIyMA0KPiANCj4gSG93
IGRvIHlvdSB3YW50IHRoaXMgdG8gYmUgbWVyZ2VkPyBJIGhhdmVuJ3QgcmVhbGx5IGZvbGxvd2Vk
IHRoZQ0KPiBob3RwbHVnDQo+IHNlcmllcywgYnV0IGdpdmVuIHRoYXQgdGhpcyBpcyBhIHByZXR0
eSBzaW1wbGUgcGF0Y2gsIEknZCByYXRoZXINCj4gaGF2ZSANCj4gdGhpbmdzDQo+IGJhc2VkIHRo
ZSBvdGhlciB3YXkgYXJvdW5kIHNvIHRoYXQgaXQgY2FuIGJlIG1lcmdlZCBpbmRlcGVuZGVudGx5
Lg0KPiANCkkgYW0gZmluZSB3aXRoIHRoYXQgb3INCg0KSSBjYW4gcmVtb3ZlIHRoZSBQTElDIHBh
dGNoIGZyb20gdGhlIGhvdHBsdWcgc2VyaWVzIGFuZCBpbmNsdWRlIHRoaXMNCnNlcmllcyBhcyB0
aGF0IHBhdGNoIGlzIG5vdCByZWFsbHkgZGVwZW5kYW50IG9uIGhvdHBsdWcgY29kZS4NCg0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTQwNzM3OS8NCg0KTGV0IG1lIGtub3cg
d2hhdCBkbyB5b3UgcHJlZmVyLg0KDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgIE0uDQoNCi0t
IA0KUmVnYXJkcywNCkF0aXNoDQo=
