Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71388C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03720828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="la09PMXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:08:57 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:35424 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBXLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:08:56 -0500
Received: from [100.112.199.127] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id E6/0D-44550-5CEA35E5; Mon, 24 Feb 2020 11:08:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRWlGSWpSXmKPExsWSoc9nrXtkXXC
  cQcMGY4v7X48yWlzeNYfNgcnjzrU9bB6fN8kFMEWxZuYl5VcksGZsbd7IWHBAtGLhwXNsDYxz
  RLsYuTgYBZYyS0yeOocNwjnGItGxdwULhLOZUeJ370+wDIvACWaJPQ8/M4M4QgITmSQe9nQyQ
  Th3GSXWPj4G1MPJwSZgITH5xAM2EFtEIFJix9eTjCA2s0C5xP4f39hBbGGBJImdX44AxTmAap
  IlzvTJQZRbSVz4OBmshEVAVeLr39NMIDavQKxES8MRNohdhxkl2vZdBEtwCmhKdD3bwgpiMwr
  ISnxpXM0MsUtc4taT+WA1EgICEkv2nGeGsEUlXj7+B1WfKnGy6QYjRFxH4uz1J1C2osSecwuh
  emUlLs3vhor7Snx/cRnK1pJYfOwVVI2FxJLuVhaQXyQEVCT+HaqECOdIdDyfwgphq0lc/XSUB
  cKWkdj2ai0jyC8SAutZJI6v7WWewGgwC8nZs4BGMQO9tn6XPkRYUWJK90P2WeCgEJQ4OfMJyw
  JGllWMFklFmekZJbmJmTm6hgYGuoaGRrqGlua6hmYmeolVukl6qaW65anFJbqGeonlxXrFlbn
  JOSl6eaklmxiBCSel4OiSHYzblr/XO8QoycGkJMpbOC84TogvKT+lMiOxOCO+qDQntfgQowwH
  h5IEb85ioJxgUWp6akVaZg4w+cGkJTh4lER43y0ASvMWFyTmFmemQ6ROMVpyTHg5dxEzx86j8
  4DkkblLFzELseTl56VKifOuXQPUIADSkFGaBzcOlqAvMcpKCfMyMjAwCPEUpBblZpagyr9iFO
  dgVBLmnQoyhSczrwRu6yugg5iADlLmCAA5qCQRISXVwCTCv7u63eJeo6TQ3x/du+9PTO5875Q
  e/9RS2C7pg8k+jfB9rRPeLGfUa3y3Pv1bauZ17x1a9/iZY/222J5Lz596/UbTsn/WM4rF647Z
  rmM7t3/7xefZBze+VVTmf8/sV6vDe3elh8wqs5zn/NN+bryR/Gnp8VVPp/w1ueZa/WLBFZcI0
  30dcTJZKlNySntV2CZb6M29nXPifb/kZCPjAMYXH7cyvrp+zLY+XntHyM0TtV2qy/dIx/EqBb
  OZ7+P7o2R7duFHAXtZlZP1MxYfmj3p/0t910klQWkPdBLuvOap22zIcK8+pGLZudwf3HeP3FN
  Q2ji9cNkN2cM6j8xDbkgH+LvNtr8XKfPJ857FDQ4lluKMREMt5qLiRAAa6BqCSwQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-292.messagelabs.com!1582542532!599789!1
X-Originating-IP: [104.47.14.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5059 invoked from network); 24 Feb 2020 11:08:52 -0000
Received: from mail-vi1eur04lp2059.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.59)
  by server-13.tower-292.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Feb 2020 11:08:52 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8CJm3FwanvW4ldeo2YTH8lh8QhU9XfyX0mqWfv+Y8vppJjH1EMgQrMogE/5Q/DqS3/ezsGXg573EiyHucdDVWk0kQdWYmCqmMWBIGRuGDebAk367jLmq0l8rLY9+NvNCnHNafKL4Bt82KGuqjntmbt93xWi/asRmlMCCfld0JRUUuLawO47eR7fFzwk7i94Lg3pmNWl1SZza53fGKOs3K3Ak/FjaFhMIrTpbzpuBwZQh3uM2h5QZWBeGx0bZClEVlLhTb/IX83ejS31zQL8RQxE4SGceArt0lTCk5+bGYQba9goPDvoIysm+/XC8G4XI7Us+umWTgIeJP8wNJ/Lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+kmRxrUaFvsyj2M8dX2xvYjxJReya8enrtXklvsinw=;
 b=G1/bRi4NGxuy27qPV8jLhtijvVl+cL/y3Aq4b16PbFCpKVdduk9/SRHm96i0RixZdEo3F0e41tjGAKlXG1hjL+YPBDMySV9jEoTbg0QtVh0RktlDyvSka7YaM7/jfwUDm54WjFZ5bvvNHycjwECQaJkjP9NwoPqFP7lLJ4SLdaJX4kXCoDMyy9KvFx4utCFg1URiNfny2RMKUp0O3f2SOg35HtALgEdERm/R2IsYe+nfbKl7zcoutF3o0Yu9+3LFbhws4giRqB/Z8oQkS0UmVFnTnD5QmPeRZYAMorTIX/PRWp6lVqA0Ajva2/RRp5a5lWW0OuLU+e7vHQD7IHr57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+kmRxrUaFvsyj2M8dX2xvYjxJReya8enrtXklvsinw=;
 b=la09PMXq4obbi3x/Ff9Z6zOZCLLoi30ECqbucaM3NXpSFJN+mfRigVakPgdogclUwF4VPZU8zbafByIuhez0+L0pm/QFcRec8Y5qYn70u8zkQVA2hYf5OA/2K4ZlfEnoHI0iSGK9g58jjCggy1F0o8Ye9ejWKeeSPKokSnUolXY=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2904.EURPRD10.PROD.OUTLOOK.COM (10.255.123.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 11:08:51 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:08:51 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHV0qj+Kh78pvF+10az+5Z3RzvBLKgqTCoAgAANAuA=
Date:   Mon, 24 Feb 2020 11:08:51 +0000
Message-ID: <AM6PR10MB22638EDDDDFABB34D0DFC21B80EC0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <20200224095654.GI3494@dell>
In-Reply-To: <20200224095654.GI3494@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ac5ddd-e365-4027-3b38-08d7b919edd5
x-ms-traffictypediagnostic: AM6PR10MB2904:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2904FC019D4935AA4B3F9C2CA7EC0@AM6PR10MB2904.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(55236004)(76116006)(26005)(186003)(64756008)(54906003)(107886003)(7696005)(8936002)(66946007)(66556008)(66476007)(66446008)(110136005)(6506007)(52536014)(9686003)(81166006)(81156014)(8676002)(71200400001)(55016002)(4326008)(316002)(5660300002)(2906002)(33656002)(86362001)(53546011)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2904;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtDAkFDNmTo26atEoVSwEizEiWdaefsPHbvKgP7z8PCq9A3pnR8BaJCTNQ8IkTMoIr0LW5LL/cLXQ2ISPDbIrVoIwP36rs+h2SK8IuZSJhlvZzXVSii18SMnqetnMWw9lkFjHbOcBXFjxwmxV1Wq5g/kSwyPuxK745vDiHsKa4CeQLWCBBOKNRQUG/RJVfjQ2UxHKxovCOPaNSs39ol1CC6tJxsaTb7O81SVC/CU/Yarru90ROzJO7HPLjwLJj5KeZwCdyvyswLZhsFA9Pp3JtCVc9Gc2vMhX7+wTiR7hWUwyD3jBFzqop5sHgSgWbsySCmj37pd6jMmZ3Ap/YRBj+YW5bs0JBN8kwTterJPiYxWxYPukxiXWQCA7Fl7Da+RBzR2sCUeTMa6NDwiLR/huQ91A5nmvkByW4KSqgvelMtyRbnUSihSVVCQeXToglz2
x-ms-exchange-antispam-messagedata: rZ/zFcZK6Dwfw6jEMdPstdvbYOAo+ZuyBBKvGMNhSuJ67H1n2Wr5MLyeXnUv3bMjg/DqSz0LNJoXwmegdMQqEFPH7Y9no2zTEv9K+zjwGQrxKsczPlxDrGXQjjl8b1oqrtofx7wrHWSxAZaaXATz7w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ac5ddd-e365-4027-3b38-08d7b919edd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:08:51.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1VIZHYI0c5TUf2rGzXGL961G9npGvuB0/s5DVx4uQpay6BsGkTHKPQOE1rbysJS5QJTgPosgBEcclFC0YxySlpdsmISDs52lX0LZz190Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQgRmVicnVhcnkgMjAyMCAwOTo1NywgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IE9uIEZyaSwg
MjQgSmFuIDIwMjAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gDQo+ID4gVGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gcGVyZm9ybXMgY2hlY2tpbmcgaW4gdGhlIGkyY19wcm9iZSgpDQo+ID4gZnVu
Y3Rpb24gb2YgdGhlIHZhcmlhbnRfY29kZSBidXQgZG9lcyB0aGlzIGltbWVkaWF0ZWx5IGFmdGVy
IHRoZQ0KPiA+IGNvbnRhaW5pbmcgc3RydWN0IGhhcyBiZWVuIGluaXRpYWxpc2VkIGFzIGFsbCB6
ZXJvLiBUaGlzIG1lYW5zIHRoZQ0KPiA+IGNoZWNrIGZvciB2YXJpYW50IGNvZGUgd2lsbCBhbHdh
eXMgZGVmYXVsdCB0byB1c2luZyB0aGUgQkIgdGFibGVzDQo+ID4gYW5kIHdpbGwgbmV2ZXIgc2Vs
ZWN0IEFELiBUaGUgdmFyaWFudCBjb2RlIGlzIHN1YnNlcXVlbnRseSBzZXQNCj4gPiBieSBkZXZp
Y2VfaW5pdCgpIGFuZCBsYXRlciB1c2VkIGJ5IHRoZSBSVEMgc28gcmVhbGx5IGl0J3MgYSBsaXR0
bGUNCj4gPiBmb3J0dW5hdGUgdGhpcyBtaXNtYXRjaCB3b3Jrcy4NCj4gPg0KPiA+IFRoaXMgdXBk
YXRlIGNyZWF0ZXMgYW4gaW5pdGlhbCB0ZW1wb3JhcnkgcmVnbWFwIGluc3RhbnRpYXRpb24gdG8N
Cj4gPiBzaW1wbHkgcmVhZCB0aGUgY2hpcCBhbmQgdmFyaWFudC9yZXZpc2lvbiBpbmZvcm1hdGlv
biAoY29tbW9uIHRvDQo+ID4gYWxsIHJldmlzaW9ucykgc28gdGhhdCBpdCBjYW4gc3Vic2VxdWVu
dGx5IGNvcnJlY3RseSBjaG9vc2UgdGhlDQo+ID4gcHJvcGVyIHJlZ21hcCB0YWJsZXMgZm9yIHJl
YWwgaW5pdGlhbGlzYXRpb24uDQo+IA0KPiBJSVVDLCB5b3UgaGF2ZSBhIGRlcGVuZGVuY3kgaXNz
dWUgd2hlcmVieSB0aGUgZGV2aWNlIHR5cGUgaXMgcmVxdWlyZWQNCj4gYmVmb3JlIHlvdSBjYW4g
c2VsZWN0IHRoZSBjb3JyZWN0IFJlZ21hcCBjb25maWd1cmF0aW9uLiAgSXMgdGhhdA0KPiBjb3Jy
ZWN0Pw0KDQpZZXAsIHNwb3Qgb24uDQoNCj4gDQo+IElmIHNvLCB1c2luZyBSZWdtYXAgZm9yIHRo
ZSBpbml0aWFsIHJlZ2lzdGVyIHJlYWRzIHNvdW5kcyBsaWtlDQo+IG92ZXIta2lsbC4gIFdoYXQn
cyBzdG9wcGluZyB5b3Ugc2ltcGx5IHVzaW5nIHJhdyByZWFkcyBiZWZvcmUgdGhlDQo+IFJlZ21h
cCBpcyBpbnN0YW50aWF0ZWQ/DQoNCkFjdHVhbGx5IG5vdGhpbmcgYW5kIEkgZGlkIGNvbnNpZGVy
IHRoaXMgYXQgdGhlIHN0YXJ0LiBOaWNlIHRoaW5nIHdpdGggcmVnbWFwDQppcyBpdCdzIGFsbCB0
aWRpbHkgY29udGFpbmVkIGFuZCBwcm92aWRlcyB0aGUgcGFnZSBzd2FwcGluZyBtZWNoYW5pc20g
dG8gYWNjZXNzDQpoaWdoZXIgcGFnZSByZWdpc3RlcnMgbGlrZSB0aGUgdmFyaWFudCBpbmZvcm1h
dGlvbi4gR2l2ZW4gdGhpcyBpcyBvbmx5IG9uY2UgYXQNCnByb2JlIHRpbWUgaXQgZmVsdCBsaWtl
IHRoaXMgd2FzIGEgcmVhc29uYWJsZSBzb2x1dGlvbi4gSG93ZXZlciBpZiB5b3UncmUgbm90DQpr
ZWVuIEkgY2FuIHVwZGF0ZSB0byB1c2UgcmF3IGFjY2VzcyBpbnN0ZWFkLg0KDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5UaG9tc29uLk9wZW5zb3VyY2VAZGlhc2Vt
aS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWZkL2RhOTA2My1jb3JlLmMgICAgICAgICAg
ICB8ICAzMSAtLS0tLS0tDQo+ID4gIGRyaXZlcnMvbWZkL2RhOTA2My1pMmMuYyAgICAgICAgICAg
ICB8IDE2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAtLS0NCj4gPiAgaW5j
bHVkZS9saW51eC9tZmQvZGE5MDYzL3JlZ2lzdGVycy5oIHwgIDE1ICsrLS0NCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCAxNjAgaW5zZXJ0aW9ucygrKSwgNTMgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0K
PiBMZWUgSm9uZXMgW+adjueQvOaWr10NCj4gTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFk
DQo+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiBG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nDQo=
