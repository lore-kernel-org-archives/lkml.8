Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BCC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1A2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u3E73+go";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NqYSkgf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDXJln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:41:43 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33861 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgDXJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587721300; x=1619257300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/aAoHxfxUh4C7gtMRbP8Axn11eHji48KlimHmFBRdTk=;
  b=u3E73+go/u4dLZfytPaDVKhY8bR/dETkhki+0VOBF51K/T39NERHNzFv
   9EjYHIZ07+3j9XYtFwfQT1GERR5L98zpsD2AIo8BTT5jLHNAx9PHo8VB7
   ZRNYDk8SFlmF0LctO8oTgUgRXTf5XxLsVi4OZe1srbLpM0GxnO8bPLy+M
   76+F9K5hgZYU6tD8SPWAKJNWw38RsrZfwN8fzk/qtR91i16QDIT06tsqq
   nxiHHD32IMQS9bfBJ020GASr8d+UUFjmt0uxkC0XtQ86yA5/KchrBDtY5
   V6y7i4IPVm7AzIRleYl0FNvjLZB2Vqc2tdl/KluhKy+BdHr6owfpxSadt
   A==;
IronPort-SDR: SugeHfCelkbcUYL76zepOY63ZR/wa8wBy+nOCXe3MQhA2IOwttArBAyGOLwP09/BEmJ3LtYVHK
 Jibf3aBBdo1VREy2m20PUZB4Ry30ekKAz8qBn50G7k9L0OauTJAlDM5tq+kTDUdBn1+g/bjUz7
 QyHjJjKzfbAKnW18u1whQXakaSjAz9+tKPoBlnfxs79sdBXNoY0rmTXzm6i51yNJAaymZM96fQ
 qWMA+yZ93Z2Dz7JcyVjVaJng1ziZ1SnzclpKDRWn2ti4iPyfArtiJ73UxeeRySawdjqzjGZHYc
 R7I=
X-IronPort-AV: E=Sophos;i="5.73,311,1583218800"; 
   d="scan'208";a="71407323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Apr 2020 02:41:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 Apr 2020 02:41:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 24 Apr 2020 02:41:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liGEssBkPUSq2fVlexIZN7zy0WmRSkSxt6/zTvrcxLVO8fK3HfzEezxiT7qAQwtoj5yQBMJSb7mz5xO6ufkNaWAg7ZOs7HvcD6HSVWz2orDUwlhO7nHmzWp7nFZ0gwk74VSGfpXf9ZlG/OYWEP1sxzfWWT2Z3BSClcu776GjJ7kkGadqMvXWJW9zVvhH996aOTs8os3TgaDT6GANmK++qzu4UC3+J94iv2DnDNQkjgIEx6scxijvOFbFh2f9eTXz9G6m3Adyz7LZdQLIpdBfq3/w0157AGCufwjQxoHFBSJIq4CqUO9/vWZk8x59qBb9ei7wi8NGmi+IZ2+OByvd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aAoHxfxUh4C7gtMRbP8Axn11eHji48KlimHmFBRdTk=;
 b=TQlx5AzUyGqGeUo48XtZQywUqazgYSsaxAo+BHM6Z4qt2C0eimR+RIu2Ey77tAxNli8r1kH2fMh52caX0Jx6APoSXngBz1bVWbYYPCMSgegMW8ZIlefJ1/lZyvcrSRM6on+O1hvOWW3imQxb8WjD0v8nhsCfXJfMHnF4DYSIl8UnfN120B2YHX9+/kR+H/Rng3v9qq0vDc2hJkcHsW8igf8Pej/Q0tyswQakg7uk5++EF6uRUm3SElh55fMH2uvloDHDYyNwRiJP5jxYjgb5BXcUaeGmg+8TpkLT3HxkKS738bPflDhlBHJFSsxYmSClm4p2YMhLL/4VuMjWqfbodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aAoHxfxUh4C7gtMRbP8Axn11eHji48KlimHmFBRdTk=;
 b=NqYSkgf5dghTPDtJM8qF0o0QMfDWJNrN2YRAMunpuDIsiYH8ylR4UafFveziIHdwiiZaR/9dUh6nj6svQ1LjTqdWJ2t/SJnyoDjRwemLUr02DHTQSZI+kXJgcVFdKBFR16Rn2eQXMvguqt97ytkt26g17LbK1W4wCziR5rTsJJI=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3772.namprd11.prod.outlook.com (2603:10b6:5:143::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Fri, 24 Apr 2020 09:41:36 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::91cb:6555:db9b:53fa]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::91cb:6555:db9b:53fa%7]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 09:41:36 +0000
From:   <Christian.Gromm@microchip.com>
To:     <lkp@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: Re: b276527539 ("staging: most: move core files out of the staging
 .."): [   12.247349] BUG: kernel NULL pointer dereference, address: 00000000
Thread-Topic: b276527539 ("staging: most: move core files out of the staging
 .."): [   12.247349] BUG: kernel NULL pointer dereference, address: 00000000
Thread-Index: AQHWBc+TuKJ+f2owr0iaAkl6WPDuc6iILXeA
Date:   Fri, 24 Apr 2020 09:41:36 +0000
Message-ID: <1e725f60c598cd8a5f167fd63ade6ee173960f01.camel@microchip.com>
References: <20200329133917.GE11705@shao2-debian>
In-Reply-To: <20200329133917.GE11705@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Gromm@microchip.com; 
x-originating-ip: [46.142.77.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d9ab3c-8a85-4e49-2389-08d7e833aead
x-ms-traffictypediagnostic: DM6PR11MB3772:
x-microsoft-antispam-prvs: <DM6PR11MB3772D7BA237A2215EE158A92F8D00@DM6PR11MB3772.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(6916009)(966005)(66556008)(186003)(5660300002)(64756008)(6512007)(66446008)(6486002)(26005)(91956017)(66476007)(478600001)(76116006)(36756003)(2906002)(66946007)(4326008)(2616005)(6506007)(81156014)(8676002)(8936002)(316002)(71200400001)(86362001)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IlCTUfwI9Y2cqiecw/AHrHAq+dYEv32yvDP9Wb3H+RTHcmaMBZZdYMwRPFn+Na9IjWE0n1FwRelJKRoJmCHDPxLihSg64IQCcaEIgO9JcVD6/SOknCj8KRiQ3zki2FMqoZ85LoTY1fKdIda2jkvQ1izPHsU3wO1ZuHeA4rsZ/hOxTqGkvKWjf/8HrETqdEh2UDiwWlPctCJ4qkT4Ih2s+ZEpB0+nJvyBvwetkMsTgnpoTiGU4EQFHS0T2AbhjoiHgl0w6gs7KsCDooASEqeCuFjYUQueFNqafgoWRQuzlJvXoBu+GQ0DfH8lox2dL/7medjmKhjb9NofhHSdpjrYHphp/l3upxGHznGstJfZkBNLClh/EENOET7dp1/M3VgRtTJ5pI8V3hi8YkSsjIKcpKj533ksMDJfZ806WvxqDLkiIDM0ww26gz9N2QkLPq9OBFuc+TYtDdyB/OgUOYHH/yBuyYKUvK1e2jYoavYYk7d0qyK+uzGO59PcXS1vKvNC9aHarvKNlgit9LWAw30+A==
x-ms-exchange-antispam-messagedata: Y26urbJ1a2G3QyY+JQGwvhEVihWCYtAbuP3I/AYjr6dl7wvGaXgasva6LkveLk04kXpPPMktXhxY8hfrgn9xoREY5llmld3PyGVbXwYyJet9HQZZ8ZC3m9JCsJmGw2bq+fvWW7Av61B++HM7/nOeBg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E516CCD77ECBA40B5FEAA3E64E72631@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d9ab3c-8a85-4e49-2389-08d7e833aead
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 09:41:36.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4GDJxkuqrpeKYD4pwvStaWh2RMfUI1s8Uu5l7jbdcd+cRqMxTNiYjgNvPyoJMnhcM32YfwacJ3LvZM1su3hhQsuizm9d3cmX9rDiJg3DoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTI5IGF0IDIxOjM5ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBHcmVldGlu
Z3MsDQo+IA0KPiAwZGF5IGtlcm5lbCB0ZXN0aW5nIHJvYm90IGdvdCB0aGUgYmVsb3cgZG1lc2cg
YW5kIHRoZSBmaXJzdCBiYWQNCj4gY29tbWl0IGlzDQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ncmVna2gvc3RhZ2luZy5naXQNCj4gc3RhZ2lu
Zy1uZXh0DQo+IA0KPiBjb21taXQgYjI3NjUyNzUzOTE4OGYxZjYxYzA4MmViZWYyNzgwM2RiOTNl
NTM2ZA0KPiBBdXRob3I6ICAgICBDaHJpc3RpYW4gR3JvbW0gPGNocmlzdGlhbi5ncm9tbUBtaWNy
b2NoaXAuY29tPg0KPiBBdXRob3JEYXRlOiBUdWUgTWFyIDEwIDE0OjAyOjQwIDIwMjAgKzAxMDAN
Cj4gQ29tbWl0OiAgICAgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCj4gQ29tbWl0RGF0ZTogVHVlIE1hciAyNCAxMzo0Mjo0NCAyMDIwICswMTAwDQo+IA0K
PiAgICAgc3RhZ2luZzogbW9zdDogbW92ZSBjb3JlIGZpbGVzIG91dCBvZiB0aGUgc3RhZ2luZyBh
cmVhDQo+IA0KPiAgICAgVGhpcyBwYXRjaCBtb3ZlcyB0aGUgY29yZSBtb2R1bGUgdG8gdGhlIC9k
cml2ZXJzL21vc3QgZGlyZWN0b3J5DQo+ICAgICBhbmQgbWFrZXMgYWxsIG5lY2Vzc2FyeSBjaGFu
Z2VzIGluIG9yZGVyIHRvIG5vdCBicmVhayB0aGUgYnVpbGQuDQo+IA0KPiAgICAgU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEdyb21tIDxjaHJpc3RpYW4uZ3JvbW1AbWljcm9jaGlwLmNvbT4NCj4g
ICAgIExpbms6IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE1ODM4NDUzNjItMjY3MDct
Mi1naXQtc2VuZC1lbWFpbC1jaHJpc3RpYW4uZ3JvbW1AbWljcm9jaGlwLmNvbQ0KPiAgICAgU2ln
bmVkLW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4NCj4gDQo+IDIyZGQ0YWNjODAgIFN0YWdpbmc6IHNwZWFrdXA6IEFkZCBpZGVudGlmaWVyIG5h
bWUgdG8gZnVuY3Rpb24NCj4gZGVjbGFyYXRpb24gYXJndW1lbnRzLg0KPiBiMjc2NTI3NTM5ICBz
dGFnaW5nOiBtb3N0OiBtb3ZlIGNvcmUgZmlsZXMgb3V0IG9mIHRoZSBzdGFnaW5nIGFyZWENCj4g
ZTY4MWJiMjg3ZiAgc3RhZ2luZzogdnQ2NjU2OiBVc2UgRElWX1JPVU5EX1VQIG1hY3JvIGluc3Rl
YWQgb2YNCj4gc3BlY2lmaWMgY29kZQ0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tDQo+IC0tKy0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0rDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyMmRkNGFjYzgwDQo+ID4gfCBiMjc2NTI3NTM5IHwgZTY4MWJiMjg3
ZiB8DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0NCj4gLS0rLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLSsNCj4gPiBi
b290X3N1Y2Nlc3NlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+
ID4gMjYgICAgICAgICB8IDAgICAgICAgICAgfCAwICAgICAgICAgIHwNCj4gPiBib290X2ZhaWx1
cmVzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gOCAgICAg
ICAgICB8IDExICAgICAgICAgfCAxMSAgICAgICAgIHwNCj4gPiBXQVJOSU5HOnBvc3NpYmxlX2Np
cmN1bGFyX2xvY2tpbmdfZGVwZW5kZW5jeV9kZXRlY3RlZCB8DQo+ID4gOCAgICAgICAgICB8ICAg
ICAgICAgICAgfCAgICAgICAgICAgIHwNCj4gPiBCVUc6a2VybmVsX05VTExfcG9pbnRlcl9kZXJl
ZmVyZW5jZSxhZGRyZXNzICAgICAgICAgICB8DQo+ID4gMCAgICAgICAgICB8IDExICAgICAgICAg
fCAxMSAgICAgICAgIHwNCj4gPiBPb3BzOiNbIyNdICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ID4gMCAgICAgICAgICB8IDExICAgICAgICAgfCAxMSAgICAg
ICAgIHwNCj4gPiBFSVA6X19saXN0X2FkZF92YWxpZCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+ID4gMCAgICAgICAgICB8IDExICAgICAgICAgfCAxMSAgICAgICAgIHwNCj4g
PiBLZXJuZWxfcGFuaWMtbm90X3N5bmNpbmc6RmF0YWxfZXhjZXB0aW9uICAgICAgICAgICAgICB8
DQo+ID4gMCAgICAgICAgICB8IDExICAgICAgICAgfCAxMSAgICAgICAgIHwNCj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LQ0KPiAtLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tKw0KPiANCj4gSWYgeW91IGZpeCB0aGUg
aXNzdWUsIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZw0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRl
c3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBbICAgMTIuMjQyMDkwXSBubyBvcHRpb25z
Lg0KPiBbICAgMTIuMjQ1MzY0XSBGUEdBIERPV05MT0FEIC0tLT4NCj4gWyAgIDEyLjI0NTcyM10g
RlBHQSBpbWFnZSBmaWxlIG5hbWU6IHhsaW54X2ZwZ2FfZmlybXdhcmUuYml0DQo+IFsgICAxMi4y
NDY1NDhdIEdQSU8gSU5JVCBGQUlMISENCj4gWyAgIDEyLjI0Njk5NV0gbW9zdF9zb3VuZDogaW5p
dCgpDQo+IFsgICAxMi4yNDczNDldIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZSwgYWRkcmVzczogDQoNCg0KVGhlIGluaXQgb3JkZXIgb2YgdGhlIG1vZHVsZXMgaXMgd3Jvbmcg
aW4gY2FzZSB0aGUgZHJpdmVyIGlzDQpiZWluZyBidWlsdCBpbi10cmVlLg0KDQpUaGUgaW5pdCBm
dW5jdGlvbiBvZiBtb2R1bGUgbW9zdF9zb3VuZCBpcyBjYWxsZWQgYmVmb3JlIHRoZQ0KY29yZSBp
dHNlbGYgaXMgYmVpbmcgaW5pdGlhbGl6ZWQuDQoNClsgICAgNS4xNzkxODldIG1vc3Rfc291bmQ6
IGluaXQoKQ0KWyAgICA1LjE4MDIwNV0gbW9zdGNvcmU6IF9faW5pdCgpDQoNCkhlbmNlIHRoZSBs
aXN0IHVzZWQgaW4gdGhlIGNvcmUgdG8gc3RvcmUgYW5kIHRyYWNrIHRoZQ0KcmVnaXN0ZXJlZCBj
b21wb25lbnRzIGhhcyBub3QgYmVlbiBpbml0aWFsaXplZCB3aXRoDQpJTklUX0xJU1RfSEVBRCgm
Y29tcF9saXN0KSBieSB0aGUgdGltZSB0aGUgc291bmQgbW9kdWxlDQp0cmllcyB0byByZWdpc3Rl
ciBpdHNlbGYgd2l0aCB0aGUgY29yZS4NCg0KVGhlIEtjb25maWcgb2YgbW9zdF9zb3VuZCwgaG93
ZXZlciwgaGFzIGEgZGVwZW5kZW5jeSB0bw0KTU9TVC4gSG93IGNhbiB0aGUgYnVpbGQgc3lzdGVt
IGJlIGZvcmNlZCB0byBpbml0aWFsaXplIHRoZQ0KY29yZSBtb2R1bGUgZmlyc3Q/DQoNCnRoYW5r
cywNCkNocmlzICANCg0K
