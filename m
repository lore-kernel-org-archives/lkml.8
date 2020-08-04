Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EC6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5CB207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ekgvuixi";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mmuOEyYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgHDPBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:01:50 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37096 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgHDPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596553246; x=1628089246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1jUrswAmdMCrJneZGpJuWy1gnXXYApWRabwwQ1K8BqY=;
  b=ekgvuixiYz4hZFG6iCZyjeoym6mRT6ipOfJz+mw3Y6z6fAecmDJGqe2o
   1mN9kSQam7aHH/mxo5zK8GcSt1vPvOvtToGEdgZBcLNGtQNwB3mBGDT3D
   6Bu6OKsvrCZpe21TUsRS1epdNpj9VjDI10UG0ooLWy7yaPo1EGKOmPYvH
   LVERRAscmTUtExIzZvZB0YEEZ3rljc7dkqpZJZMH2F9dqzg1Z8VFpRnmO
   HogscJQwPnxGjKxrCs6GztNWUlaAjErzXjI4rqXNLrfZRdxeNNVX6sakE
   lsB9igvCsG/CbM/YRlZOZACLVN0ZFh1rCHgB9k2fhvBpbZCnKDac0rBBL
   Q==;
IronPort-SDR: l9dS15Jf08vWJ8+SNPzumfypfMTf9k1aqUFUYtKANkn3cE38k84rFYcI3VCNGetpeJ50dgx335
 jnvDGvHKvRS8bVhnt9MrUlZzzANZXKrQu8Y0EfJYrt9C10ojSoZ58lrXw1nuEelvBc5qWxHaxP
 YMdFENVm3ftfznU9b5DRaCuZJ1ZcI6UCtkz1q2UrLG/jPSGKcsnnE8alLOKr631EYroGBjzYk4
 h6zqF5I0LQEsdi8AlEW7R1MmBus9/B9qbQYFPlBXr/iaIfKnv1yEVy6dWv4uLepKn+KKA59tAa
 vz4=
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="84380120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 08:00:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 08:00:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 4 Aug 2020 08:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCOVr8lsClzpGYR9ikWX/QJR2F//GqIIrupVcx4g+/5kj9P4PQx2J96XSoYShGS4TaZWWHWakyNZqFxCgbjwixPL3a/ABuME7aVEtlO+rgBZ/jiKLFpnnSEEz4IeJT9Kzh4JPhIRn/UCwW2EKS/8F775tRRXErlC+qkAD312ic7qM+kcMIHMLt2YInxYieToNeZzIxmRQnUSd9MrcJ4fIZ8M15dBIiCpRRq5KYoG+GoXekCqxhVfFSh0Jhiqtv0/cfUZaoT7vvYVDGijkpsS8GJSnB1gFNe+Z3k2740emUJmCWMAq6sANgCknNaQEUb57xQXiJ1d0/8BPXlTsfEskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jUrswAmdMCrJneZGpJuWy1gnXXYApWRabwwQ1K8BqY=;
 b=IyJqluSYOe3uDZl6EJLFiP05ZmeV1fR8bfgf2zImEOn/91Hy9lLFszfzIENf092anE1qx3/nYA8aTLOTyPoVIfAkoF9LJLWymYylykojaTzuCHXsoUl/miA0zIkCOqBGhOVU7f7NSLJtt3wAOkmjyUfmj2PuySA+Q5SCglgEQRs5YxlcWEwhYtn3gLQnbvWdsfJGes637dthsv8xX2RvHscteM+idsW38bnXLa6yVKmxpHK8Qc2bUgIoxom2oTGixXslgFIJboym7N5NN3/DdUuPd2F0ZBb6J9DF4xKagA7WsRovVPjY7LbqdLJotX/Ix8+4TP3jvu6ZLyTaCDlkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jUrswAmdMCrJneZGpJuWy1gnXXYApWRabwwQ1K8BqY=;
 b=mmuOEyYLk0E3HJV+TmPEleQ+Lb3p1vfzFa76T0PXMmcq6L0vSPyEAWX8ioN48f5JpdwoNT/G0qJwXbJ9wl+ln5w8j8HY/TDmy9ln4884qNX+w0L9Zb3xeazb3zrDmwHzNK9OOY8EhwhwLfptnMoHlTvZjqm+qHjGUQ0+2KF6BzQ=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4297.namprd11.prod.outlook.com (2603:10b6:5:14e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.21; Tue, 4 Aug 2020 15:00:38 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 15:00:38 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <wenyou.yang@atmel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Thread-Topic: [PATCH v2 2/3] ARM: at91: pm: add per soc validation of pm modes
Thread-Index: AQHWanACN1d1n4sWwEaqiqSQihqxnQ==
Date:   Tue, 4 Aug 2020 15:00:38 +0000
Message-ID: <f9e1d923-225e-7a18-ed48-c8c7e7d4d8cf@microchip.com>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
 <1596539258-20719-3-git-send-email-claudiu.beznea@microchip.com>
 <20200804114223.GC7836@piout.net>
In-Reply-To: <20200804114223.GC7836@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1994078a-642b-4068-5ecc-08d838872661
x-ms-traffictypediagnostic: DM6PR11MB4297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4297D4F6F03413E1C9669D0E874A0@DM6PR11MB4297.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XxNhKG9z60Yritm7pOg6DtZbE50J+VuFgZpQNypfBaQLIkZWHR+cTkHfc1nTco18OYqSIkl2op6GZYTxbveWPllNx5iYEi3AB9bPmBGPtvKNgIgdmgqNc+5oZFzN+y2s+kV3tptXI3Tlz17npcfEot7x5MPFnhgugzjUdNspvQcNUnoR8MohGR5z2esmX0+dDUtu4d4zYxiUh9nAERMhr1kiXzh9wok7Ptnzr4eXB3DY8deagJ8YaS7aWc1bzh/9FuCsi0xhy+fVBZHxS3RsaQdO+MwWKPmoqAwQhmozVbVuQjJ2RMC1riDPbhUbGVf/LelkZwrQDiCXtAKziyqDiyRzEufVEOPjLQWSl3Nv/Bjbjgf+DpQsDWhmuRKJbZ7TtDSMY3JHLJjACQJaK/4qeFm8DPB6hCGWEiDectDPyJSXwpQWyrrrNkzIPuwf6PtgnZdr1WyH7aSr1/3R5Kf2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(186003)(5660300002)(31686004)(2616005)(6512007)(71200400001)(4326008)(31696002)(498600001)(6486002)(83380400001)(966005)(86362001)(66946007)(91956017)(2906002)(54906003)(8936002)(53546011)(6506007)(66446008)(66556008)(64756008)(66476007)(6916009)(36756003)(26005)(8676002)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lnRsvvoBlKd9eWofF3X0LtwOtF2bp+WurWqW9wEVkHKxg4Euo4pjFkuMdpBRRWqOhMCJ834UNsABfBWefOywHIxnoS3CcrDnMWXpn35yzOw2zbxgc8tzYwXnKvPfCFdV3ySw9JdVTJZxU96coDK7tlfj3Sq+qX3leo4MEomXOlwZN8Qywc2yGmOQ/AjuxDWsLkxTSRnpTjcMyS+X/Xf8EmklatVwPJHt7zg+vls/hweOMdQvOaTpMJOiD9XZ888JqSg6OaJ0N/eDIefv5hnLLXcAfYeAaK2g/UugJXq7Vt5iZ2re981nNw5xyt0e1NUgSUowLH6yKoPOPfF3jRo6fb6+R91X881FTVAL+Ecqum4dpE27zBk7KE2ufHi4Mmv6rSuHZqtuwoTdw6FtAnijPLQB6fzqNP28x4+gTuIypDUtbNICRkcwh97mMM89wV80/6q1v8fV34T65YCZwQGYUL5Twfl3FnVbwa1gpZaiXABBjcV+Xw5+hi6y03SVqJskBt/VW16yP0QpJJRpZ/f9NPnGNJ7Z2nvmKlW99jjo+TJAvWCC6pZKg2+v7rnRJkxE4/tx0HA7M91MACqwjjmX/NLyl/PZRkCOeZTPRv/kzMlrZLX/JQvK1/O/onZq3ZQdXOre2H+Qu5ygoZsuanw6Ng==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AF9F7DB3997434CA756AC5D107F8726@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1994078a-642b-4068-5ecc-08d838872661
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 15:00:38.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSMs1nnvpycoHe6OiZFDCO+aro13VILFcZG4VWN9sme+oLullu5IWS96xhqhU9Yah9wyxJh2pnU1mBxw+Gx8P5Y6YWmyGm6ZcOz5ZQS6dbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjA4LjIwMjAgMTQ6NDIsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gMDQv
MDgvMjAyMCAxNDowNzozNyswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+ICB2b2lkIF9f
aW5pdCBhdDkxcm05MjAwX3BtX2luaXQodm9pZCkNCj4+ICB7DQo+PiArICAgICBzdGF0aWMgY29u
c3QgaW50IG1vZGVzW10gX19pbml0Y29uc3QgPSB7DQo+IA0KPiBZb3UgZG9uJ3QgbmVlZCB0aGF0
IHRvIGJlIHN0YXRpYyBhcyBpdCBpcyBub3cgbG9jYWwgdG8gdGhlIGZ1bmN0aW9uLg0KPiANCj4+
ICsgICAgICAgICAgICAgQVQ5MV9QTV9TVEFOREJZLCBBVDkxX1BNX1VMUDANCj4+ICsgICAgIH07
DQo+PiArDQo+PiAgICAgICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NPQ19BVDkxUk05MjAwKSkN
Cj4+ICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4NCj4+ICsgICAgIGF0OTFfcG1fbW9kZXNfdmFs
aWRhdGUobW9kZXMsIEFSUkFZX1NJWkUobW9kZXMpKTsNCj4gDQo+IEZvciBybTkyMDAgYW5kIGF0
OTFzYW05LCBJIHdvdWxkIG5vdCBhbGxvdyBjaGFuZ2luZyB0aGUgcG1fbW9kZXMgYW5kDQo+IHNp
bXBseSBlbmZvcmNlIHN0YW5kYnlfbW9kZSA9IEFUOTFfUE1fU1RBTkRCWSBhbmQgc3VzcGVuZF9t
b2RlID0NCj4gQVQ5MV9QTV9VTFAwLkkgZG9uJ3QgdGhpbmsgeW91IGhhdmUgYW55IHVzZXIgdGhh
dCBldmVyIGNoYW5nZWQgdGhhdA0KPiBiZWhhdmlvdXIgYWxzbyB0aGF0IGF2b2lkcyBpbmNyZWFz
aW5nIHRoZSBib290IHRpbWUgZm9yIHRob3NlIHNsb3cgU29Dcy4NCg0KT0ssIGJ1dCBib290YXJn
cyBpcyBwYXJzZWQgYXQgYSBtb21lbnQgd2hlbiB0aGVyZSBpcyBubyBpbmZvcm1hdGlvbiBhYm91
dA0KdGhlIG1hY2hpbmUgdGhhdCBpcyBydW5uaW5nIHRoZSBjb2RlLiBBbmQgZW5mb3JjaW5nIHRo
aXMgaW4gKl9wbV9pbml0KCkNCmZ1bmN0aW9ucyBmb3Igcm05MjAwIGFuZCBhdDkxc2FtOSBtYXkg
Y2hhbmdlIHN1c3BlbmQgYW5kIHN0YW5kYnkgbW9kZSB0aGF0DQp1c2VyIHNlbGVjdGVkLiBJZiB0
aGVyZSBpcyBubyB1c2VyIHVwIHRvIHRoaXMgbW9tZW50IHRoZXJlIGlzIHN0aWxsIHRoZQ0KcG9z
c2liaWxpdHkgb2YgYmVpbmcgb25lIGluIHRoZSBmdXR1cmUuDQoNCj4gDQo+PiAgICAgICBhdDkx
X2R0X3JhbWMoKTsNCj4+DQo+PiAgICAgICAvKg0KPj4gQEAgLTgzOCw5ICs4ODgsMTQgQEAgdm9p
ZCBfX2luaXQgYXQ5MXJtOTIwMF9wbV9pbml0KHZvaWQpDQo+Pg0KPj4gIHZvaWQgX19pbml0IHNh
bTl4NjBfcG1faW5pdCh2b2lkKQ0KPj4gIHsNCj4+ICsgICAgIHN0YXRpYyBjb25zdCBpbnQgbW9k
ZXNbXSBfX2luaXRjb25zdCA9IHsNCj4+ICsgICAgICAgICAgICAgQVQ5MV9QTV9TVEFOREJZLCBB
VDkxX1BNX1VMUDAsIEFUOTFfUE1fVUxQMF9GQVNULCBBVDkxX1BNX1VMUDEsDQo+PiArICAgICB9
Ow0KPj4gKw0KPj4gICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19TT0NfU0FNOVg2MCkpDQo+
PiAgICAgICAgICAgICAgIHJldHVybjsNCj4+DQo+PiArICAgICBhdDkxX3BtX21vZGVzX3ZhbGlk
YXRlKG1vZGVzLCBBUlJBWV9TSVpFKG1vZGVzKSk7DQo+PiAgICAgICBhdDkxX3BtX21vZGVzX2lu
aXQoKTsNCj4+ICAgICAgIGF0OTFfZHRfcmFtYygpOw0KPj4gICAgICAgYXQ5MV9wbV9pbml0KGF0
OTFzYW05eDYwX2lkbGUpOw0KPj4gQEAgLTg1MSwxNCArOTA2LDE5IEBAIHZvaWQgX19pbml0IHNh
bTl4NjBfcG1faW5pdCh2b2lkKQ0KPj4NCj4+ICB2b2lkIF9faW5pdCBhdDkxc2FtOV9wbV9pbml0
KHZvaWQpDQo+PiAgew0KPj4gKyAgICAgc3RhdGljIGNvbnN0IGludCBtb2Rlc1tdIF9faW5pdGNv
bnN0ID0gew0KPj4gKyAgICAgICAgICAgICBBVDkxX1BNX1NUQU5EQlksIEFUOTFfUE1fVUxQMCwN
Cj4+ICsgICAgIH07DQo+PiArDQo+PiAgICAgICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NPQ19B
VDkxU0FNOSkpDQo+PiAgICAgICAgICAgICAgIHJldHVybjsNCj4+DQo+PiArICAgICBhdDkxX3Bt
X21vZGVzX3ZhbGlkYXRlKG1vZGVzLCBBUlJBWV9TSVpFKG1vZGVzKSk7DQo+PiAgICAgICBhdDkx
X2R0X3JhbWMoKTsNCj4+ICAgICAgIGF0OTFfcG1faW5pdChhdDkxc2FtOV9pZGxlKTsNCj4+ICB9
DQo+Pg0KPj4gLXZvaWQgX19pbml0IHNhbWE1X3BtX2luaXQodm9pZCkNCj4+ICtzdGF0aWMgdm9p
ZCBfX2luaXQgc2FtYTVfcG0odm9pZCkNCj4+ICB7DQo+PiAgICAgICBpZiAoIUlTX0VOQUJMRUQo
Q09ORklHX1NPQ19TQU1BNSkpDQo+PiAgICAgICAgICAgICAgIHJldHVybjsNCj4+IEBAIC04Njcs
MTMgKzkyNywzMiBAQCB2b2lkIF9faW5pdCBzYW1hNV9wbV9pbml0KHZvaWQpDQo+PiAgICAgICBh
dDkxX3BtX2luaXQoTlVMTCk7DQo+PiAgfQ0KPj4NCj4+ICt2b2lkIF9faW5pdCBzYW1hNV9wbV9p
bml0KHZvaWQpDQo+PiArew0KPj4gKyAgICAgc3RhdGljIGNvbnN0IGludCBtb2Rlc1tdIF9faW5p
dGNvbnN0ID0gew0KPj4gKyAgICAgICAgICAgICBBVDkxX1BNX1NUQU5EQlksIEFUOTFfUE1fVUxQ
MCwgQVQ5MV9QTV9VTFAwX0ZBU1QsDQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgaWYgKCFJ
U19FTkFCTEVEKENPTkZJR19TT0NfU0FNQTUpKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm47DQo+
PiArDQo+PiArICAgICBhdDkxX3BtX21vZGVzX3ZhbGlkYXRlKG1vZGVzLCBBUlJBWV9TSVpFKG1v
ZGVzKSk7DQo+PiArICAgICBzYW1hNV9wbSgpOw0KPj4gK30NCj4+ICsNCj4+ICB2b2lkIF9faW5p
dCBzYW1hNWQyX3BtX2luaXQodm9pZCkNCj4+ICB7DQo+PiArICAgICBzdGF0aWMgY29uc3QgaW50
IG1vZGVzW10gX19pbml0Y29uc3QgPSB7DQo+PiArICAgICAgICAgICAgIEFUOTFfUE1fU1RBTkRC
WSwgQVQ5MV9QTV9VTFAwLCBBVDkxX1BNX1VMUDBfRkFTVCwgQVQ5MV9QTV9VTFAxLA0KPj4gKyAg
ICAgICAgICAgICBBVDkxX1BNX0JBQ0tVUCwNCj4+ICsgICAgIH07DQo+PiArDQo+PiAgICAgICBp
ZiAoIUlTX0VOQUJMRUQoQ09ORklHX1NPQ19TQU1BNUQyKSkNCj4+ICAgICAgICAgICAgICAgcmV0
dXJuOw0KPj4NCj4+ICsgICAgIGF0OTFfcG1fbW9kZXNfdmFsaWRhdGUobW9kZXMsIEFSUkFZX1NJ
WkUobW9kZXMpKTsNCj4+ICAgICAgIGF0OTFfcG1fbW9kZXNfaW5pdCgpOw0KPj4gLSAgICAgc2Ft
YTVfcG1faW5pdCgpOw0KPj4gKyAgICAgc2FtYTVfcG0oKTsNCj4gDQo+IEkgd291bGQgY2FsbCB0
aG9zZSB0d28gZGlyZWN0bHk6DQo+ICAgICAgICAgYXQ5MV9kdF9yYW1jKCk7DQo+ICAgICAgICAg
YXQ5MV9wbV9pbml0KE5VTEwpOw0KPiANCj4gaW5zdGVhZCBvZiBoYXZpbmcgYSBmdW5jdGlvbiB0
aGF0IGRvZXNuJ3QgZG8gbXVjaC4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290
bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9i
b290bGluLmNvbQ0KPiA=
