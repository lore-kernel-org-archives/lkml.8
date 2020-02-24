Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RHS_DOB autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE47C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1DA20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="d4xZ5EoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBXMLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:11:09 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:34516 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbgBXMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:11:09 -0500
Received: from [100.113.3.112] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id C5/9B-28499-95DB35E5; Mon, 24 Feb 2020 12:11:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRWlGSWpSXmKPExsWSoc9qoRu5Nzj
  O4MVyEYv7X48yWlzeNYfNgcnjzrU9bB6fN8kFMEWxZuYl5VcksGZMOnKbuWCOVMX2d7MYGxg/
  SHYxcnEwCixllpg3eRYzhHOMReLusc1sEM5mRonfvT/BHBaBE8wSG3csZwdxhAT6mSQuz3/NC
  OHcZZQ4/fYYSxcjJwebgIXE5BMP2EBsEYFIiR1fTzKC2MwC5RL7f3xjB7GFBZIkdn45AhTnAK
  pJljjTJwdR7iZxYst5JhCbRUBVYubDXWwgJbwCsRI/t7JArNrMJPF/5zqwGk4BTYkfTTvBVjE
  KyEp8aVzNDLFKXOLWk/lgNRICAhJL9pxnhrBFJV4+/scKUZ8qcbLpBiNEXEfi7PUnULaixJ5z
  C6F6ZSUuze+GivtK7J1xHWqOlsTn9m1QtoXEku5WFpA7JQRUJP4dqoQI50jc6djCDmGrSWy/d
  h5qpIzEtldrwcEmIbCdReLNy/0sExgNZiE5exbQKGag19bv0ocIK0pM6X7IDmLzCghKnJz5hG
  UBI8sqRsukosz0jJLcxMwcXUMDA11DQ2NdEGmgl1ilm6iXWqqbnJpXUpQIlNVLLC/WK67MTc5
  J0ctLLdnECEw4KYUMeTsYG+e/1zvEKMnBpCTKy7UpOE6ILyk/pTIjsTgjvqg0J7X4EKMMB4eS
  BO+MPUA5waLU9NSKtMwcYPKDSUtw8CiJ8IrtBkrzFhck5hZnpkOkTjFackx4OXcRM8fOo/OA5
  JG5SxcxC7Hk5eelSonzBoLMEwBpyCjNgxsHS9CXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKg
  nzGoFM4cnMK4Hb+groICagg5Q5AkAOKklESEk1MKXFdLZKef7OM+A9eizm6e2kmpuHf/j3W2Z
  GfLM/Wui3MarWYuqxDIZ9l5jl74ZnfWk0kb4q3xZ6/Z20TYjutbCMXU5fmi98mVO4n+lax/Tq
  HfkL2y5OZp9c/Ojok4iOgzVmPyfb/XgfVsTjUhO6+Hv7zdPid9re3egK35sxaUWp8+xt6ptms
  Jnu5/bivL7nnmSHgU35ofAv+h+myd6Ns0vVTUpaocChc312nLez2YGteTIz1l5/8tXntnJrxM
  4nun+vxyberT135KDEp32Pp07RvvLKee+h32+utJVHTzj8ahdjnYbmvIJLFooaGirfH81Z9KS
  2foLRRv5/AZyWSUvaf9olROwLaF2y8qiOD4sSS3FGoqEWc1FxIgCNoxcXSwQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-233.messagelabs.com!1582546264!2319049!1
X-Originating-IP: [104.47.5.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28931 invoked from network); 24 Feb 2020 12:11:05 -0000
Received: from mail-he1eur02lp2056.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.56)
  by server-4.tower-233.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Feb 2020 12:11:05 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPMi+Bb/l7z5mPog0PmWT0hBZuuIW1utrybYiX7Psd4FQSnHtZX13meKK2LKqIZKvWGJIBowLQdbfDbPzsSy1awfVUtMlMhvcZCxTdnuZxU+QjX8PSbu1AFZDwPp3MiwAlBTO3TipZllnaX6Kyl5oEvEdcqufDy6VLHX0ajIV34FAr4rbAUJ2b17Gx3BSdg3YYdSDeiOLiFH8XFihSzvSwlMXcTS0ksGDx6EsNG05Zi8KmyxIDb0iLwRD/HhEXs+w9zEctERoK7fAdr29SQqQ4tpX/Logr941/C3Lx5XyH3Bh/id069RW4aGzTto8G+D82YX0B6k7xvjcNMKODD8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXI8jAjtfnbgWHKYklmIWpCQ7gGjsvRytWMQICB/5YI=;
 b=FLpVtGovcF7o2Z27vKsfWgnWvieBHbRqcO78f2g0llUkYH1IJwITHT3ulMUvnuIHWOx2WB2V3P2NO+cPG14oLYVrlDz2NF4wqsU03O7KwYjmS9HZvJmZSbdiW/CFrCGdZUElr3OZW93MocwwPRW+jzXnJXJkzZGdSGvTz7jkURHblwzomoUbs7hNTDXmEPsVl9XFIfKz8vJgzmrDX4QGUOZp/PH9Hz4yTo78dJkKyvCyDz6sIK55tXzuIVCU7hKzaxfZXp9Fk77ZzkmU19w7DAU5uZZ0PFH3T2gb8ZGfJ1orBPFK6ZPspAOSeNwS8OViYjaOn81UTafKvwDBWAmiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXI8jAjtfnbgWHKYklmIWpCQ7gGjsvRytWMQICB/5YI=;
 b=d4xZ5EoRSCEANqYXkrBjrPFwjYF7OP+1v0SpD0Ypxlulh3vP9ZIiVmDpTbWUSkgs3o1E69PAt0kLB6yMek5bO8fMsXB6diPAl9nsF7IM2DtXDedXETCr5fvOTwTrJuCk5n8CXrbbFtkshCxz+Ie1ZuCuv7cCxHL/ULMI3HF/xZQ=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2806.EURPRD10.PROD.OUTLOOK.COM (20.179.0.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 12:11:03 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 12:11:03 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHV0qj+Kh78pvF+10az+5Z3RzvBLKgqTCoAgAANAuCAAAw7AIAAC5Bg
Date:   Mon, 24 Feb 2020 12:11:03 +0000
Message-ID: <AM6PR10MB226325120B64509E3372C21980EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <20200224095654.GI3494@dell>
 <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200224112714.GT3494@dell>
In-Reply-To: <20200224112714.GT3494@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47c21509-94f2-4bdf-cb63-08d7b9229e8b
x-ms-traffictypediagnostic: AM6PR10MB2806:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB28064260281DC5B77EAD4009A7EC0@AM6PR10MB2806.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(39850400004)(136003)(199004)(189003)(5660300002)(81156014)(55236004)(53546011)(81166006)(71200400001)(6506007)(316002)(4326008)(966005)(2906002)(478600001)(86362001)(55016002)(33656002)(64756008)(66446008)(107886003)(7696005)(26005)(110136005)(54906003)(66476007)(8936002)(66946007)(8676002)(186003)(9686003)(76116006)(66556008)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2806;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mp3mp9XMfmj1pqaEAkhUJV1P/+F28P6hgIzBIIleTizza4SgVU2sUmkX73oUZ7jxFzZPMcgXAW2TXLEE3eLLacSsfFh02BghFPCimbKhKypnqbcGmXmybOucKPinBkweDLGw/+wlEaNb1k5LbQ5XiXb5gPLZoHSycMlFYFP64NtPjZlLth8ADgPIjsS6d+8WA4grPwi2OqrUuy6pi/T0goab7or3iHFHa7Yf+MxgAXXQmk3Bmn7JsXa7Dej9U6TulzgAAZ2sbP5dy00qgO73lcktsdD6SmtIOXFlD6o+deBfO28ud2g9FHnmryOfrn0+nd51+fyUMsGqXh5/48/ErBnOn+6UJjL+a80LgX9qTiVFXx1YZtoSwoNBvJbS/y+Hij+n66y8OeuqCO+U3NRzDpeW1eAJvKAfsFLCHfJdiEK7eKNSKvzh8Zk5VkdvRGkqRsA0rqveLE46pI+r1oM/9iyfjHwyIjK9A9hxFF7WbyHJ/56WUsedo4B7ZZUrg1sxOrYpf7WmyBnRO3BafQkxow==
x-ms-exchange-antispam-messagedata: 5F7W6zEQPDXoAmTiheyKzSODbgAziJkIBvU8SWi5rZBoeWX9VWtOt4DAbeGWSq/TkFMckkJiWdVLsIssTtWaDko7B87FlD6xMHdBgFszdFzYfnAVEu5aVygaNkZ9V03Hi03i82TSP06RY4EiuCCkPA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c21509-94f2-4bdf-cb63-08d7b9229e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 12:11:03.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JncSL6zpiByGVbnLpk6luO0rOCcqFus8oyZvTEBN721j2Jhn1qJa3D+ogRUfxeRQi/a+OaVkxheS1xksBoUVFaLUCN9AEFHVgQiUB3Wh0DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQgRmVicnVhcnkgMjAyMCAxMToyNywgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IE9uIE1vbiwg
MjQgRmViIDIwMjAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gDQo+ID4gT24gMjQgRmVicnVhcnkg
MjAyMCAwOTo1NywgTGVlIEpvbmVzIHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBGcmksIDI0IEphbiAy
MDIwLCBBZGFtIFRob21zb24gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBUaGUgY3VycmVudCBpbXBs
ZW1lbnRhdGlvbiBwZXJmb3JtcyBjaGVja2luZyBpbiB0aGUgaTJjX3Byb2JlKCkNCj4gPiA+ID4g
ZnVuY3Rpb24gb2YgdGhlIHZhcmlhbnRfY29kZSBidXQgZG9lcyB0aGlzIGltbWVkaWF0ZWx5IGFm
dGVyIHRoZQ0KPiA+ID4gPiBjb250YWluaW5nIHN0cnVjdCBoYXMgYmVlbiBpbml0aWFsaXNlZCBh
cyBhbGwgemVyby4gVGhpcyBtZWFucyB0aGUNCj4gPiA+ID4gY2hlY2sgZm9yIHZhcmlhbnQgY29k
ZSB3aWxsIGFsd2F5cyBkZWZhdWx0IHRvIHVzaW5nIHRoZSBCQiB0YWJsZXMNCj4gPiA+ID4gYW5k
IHdpbGwgbmV2ZXIgc2VsZWN0IEFELiBUaGUgdmFyaWFudCBjb2RlIGlzIHN1YnNlcXVlbnRseSBz
ZXQNCj4gPiA+ID4gYnkgZGV2aWNlX2luaXQoKSBhbmQgbGF0ZXIgdXNlZCBieSB0aGUgUlRDIHNv
IHJlYWxseSBpdCdzIGEgbGl0dGxlDQo+ID4gPiA+IGZvcnR1bmF0ZSB0aGlzIG1pc21hdGNoIHdv
cmtzLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHVwZGF0ZSBjcmVhdGVzIGFuIGluaXRpYWwgdGVt
cG9yYXJ5IHJlZ21hcCBpbnN0YW50aWF0aW9uIHRvDQo+ID4gPiA+IHNpbXBseSByZWFkIHRoZSBj
aGlwIGFuZCB2YXJpYW50L3JldmlzaW9uIGluZm9ybWF0aW9uIChjb21tb24gdG8NCj4gPiA+ID4g
YWxsIHJldmlzaW9ucykgc28gdGhhdCBpdCBjYW4gc3Vic2VxdWVudGx5IGNvcnJlY3RseSBjaG9v
c2UgdGhlDQo+ID4gPiA+IHByb3BlciByZWdtYXAgdGFibGVzIGZvciByZWFsIGluaXRpYWxpc2F0
aW9uLg0KPiA+ID4NCj4gPiA+IElJVUMsIHlvdSBoYXZlIGEgZGVwZW5kZW5jeSBpc3N1ZSB3aGVy
ZWJ5IHRoZSBkZXZpY2UgdHlwZSBpcyByZXF1aXJlZA0KPiA+ID4gYmVmb3JlIHlvdSBjYW4gc2Vs
ZWN0IHRoZSBjb3JyZWN0IFJlZ21hcCBjb25maWd1cmF0aW9uLiAgSXMgdGhhdA0KPiA+ID4gY29y
cmVjdD8NCj4gPg0KPiA+IFllcCwgc3BvdCBvbi4NCj4gPg0KPiA+ID4gSWYgc28sIHVzaW5nIFJl
Z21hcCBmb3IgdGhlIGluaXRpYWwgcmVnaXN0ZXIgcmVhZHMgc291bmRzIGxpa2UNCj4gPiA+IG92
ZXIta2lsbC4gIFdoYXQncyBzdG9wcGluZyB5b3Ugc2ltcGx5IHVzaW5nIHJhdyByZWFkcyBiZWZv
cmUgdGhlDQo+ID4gPiBSZWdtYXAgaXMgaW5zdGFudGlhdGVkPw0KPiA+DQo+ID4gQWN0dWFsbHkg
bm90aGluZyBhbmQgSSBkaWQgY29uc2lkZXIgdGhpcyBhdCB0aGUgc3RhcnQuIE5pY2UgdGhpbmcg
d2l0aCByZWdtYXANCj4gPiBpcyBpdCdzIGFsbCB0aWRpbHkgY29udGFpbmVkIGFuZCBwcm92aWRl
cyB0aGUgcGFnZSBzd2FwcGluZyBtZWNoYW5pc20gdG8gYWNjZXNzDQo+ID4gaGlnaGVyIHBhZ2Ug
cmVnaXN0ZXJzIGxpa2UgdGhlIHZhcmlhbnQgaW5mb3JtYXRpb24uIEdpdmVuIHRoaXMgaXMgb25s
eSBvbmNlIGF0DQo+ID4gcHJvYmUgdGltZSBpdCBmZWx0IGxpa2UgdGhpcyB3YXMgYSByZWFzb25h
YmxlIHNvbHV0aW9uLiBIb3dldmVyIGlmIHlvdSdyZSBub3QNCj4gPiBrZWVuIEkgY2FuIHVwZGF0
ZSB0byB1c2UgcmF3IGFjY2VzcyBpbnN0ZWFkLg0KPiANCj4gSXQgd291bGQgYmUgbmljZSB0byBj
b21wYXJlIHRoZSAyIHNvbHV0aW9ucyBzaWRlIGJ5IHNpZGUuICBJIGNhbid0IHNlZQ0KPiB0aGUg
cmF3IHJlYWRzIG9mIGEgZmV3IGRldmljZS1JRCByZWdpc3RlcnMgYmVpbmcgYW55d2hlcmUgbmVh
ciAxNzANCj4gbGluZXMgdGhvdWdoLg0KDQpUbyBiZSBmYWlyIHRoZSByZWdtYXAgc3BlY2lmaWMg
YWRkaXRpb25zIGZvciB0aGUgdGVtcG9yYXJ5IHJlZ2lzdGVyIGFjY2VzcywgYXJlDQptYXliZSA1
MCAtIDYwIGxpbmVzLiBUaGUgcmVzdCBpcyB0byBkbyB3aXRoIGhhbmRsaW5nIHRoZSByZXN1bHQg
d2hpY2ggeW91J2xsDQpuZWVkIGFueXdheSB0byBzZWxlY3QgdGhlIGNvcnJlY3QgcmVnaXN0ZXIg
bWFwLiBJIHJlY2tvbiB0byBwcm92aWRlIHJhdyByZWFkIGFuZA0Kd3JpdGUgYWNjZXNzIHdlJ3Jl
IGdvaW5nIHRvIHByb2JhYmx5IGJlIHNpbWlsYXIgb3IgbW9yZSBhcyB3ZSdsbCBuZWVkIHRvIHdy
aXRlDQp0aGUgcGFnZSByZWdpc3RlciB0aGVuIHJlYWQgZnJvbSB0aGUgcmVsZXZhbnQgSUQgcmVn
aXN0ZXJzLiBVc2luZyB0aGlzIGFuDQpleGFtcGxlIGZvciB0aGUgbGluZXMgY291bnQ6DQoNCmh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9tZmQv
dHBzNjUwN3guYyNMMzcNCg0KSSBjYW4ga25vY2sgc29tZXRoaW5nIHRvZ2V0aGVyIHRob3VnaCBq
dXN0IHRvIHNlZSB3aGF0IGl0IGxvb2tzIGxpa2UuDQo=
