Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F02C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ABC20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tys0obY3";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d5Q67C5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgDGN76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:59:58 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:11052 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586267997; x=1617803997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qb3gjOxZ0FbCXsCymi1eabHPolKrTsKUMQiXr7TtMgQ=;
  b=Tys0obY3sAVU8w+d6MWMi0rGnJADP1lE9eF8G4wzu/KPl06h9DMiqtrg
   vjpW3YhOLrZyAiQzT3bJ8Y+A7947m/tQLd5hgkcgZvIyCz2P8bPxcGUw7
   SQ7JoxKhHR57ze8Q88tKKee8hNFjbpsRWV69KRs8oWODOMqQc7NeB651E
   O+uRg52/HvkOpj7nN6kFZrapgKsZmdXItWfRIz12TA9ecomsAZuN6b/hO
   XfTQk+2hLffpm7Rfenm7kr92JjrUo7riJakPDpXyVYmcKmJRieRI4+U88
   ehh6wyl7exgD5NNtC3Svli8vun3JB05Syju5/TzPLMSk4behPi4ZxzcY1
   g==;
IronPort-SDR: bnK1tPDhk3HS/4keqChHg1gtGhxoe7Wt8ZeUk3fvj0pGIf6weSDh3Vm9uPnj0O5U3RbaEtDYYa
 yxE7bi4yalLv+39hscvzo5mWDlg+IA3KsWsqhtDspEtLYCs90p2DSJfKcDbiTYRbdezrDLnIQs
 mB/8Mc3oAJvz4k+TBr416zCjFMN1K4qPaKlAFzrUHrkkJV6vvCaZfsWSEjFeVH9D0DQmtXAJrV
 yee3Udpda2v4MPnxErjRo5aHNpYJ9WVRfBlbPd7CbaPo6INFC4HV5NVsdhhX2d1guntEPt1vHQ
 Nho=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="71484074"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 06:59:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 06:59:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 07:00:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VklxJc84nbjmswrOFP8XSAXMvF2OL3JavnsJXNiNLlqoQQkeII8JBvxxKfcttKL8yG/NtT1zzJNr8aoi+dRM1gBjxMcs7kEmAiJGgP63OmXlfuxj9FSeUNcIhAoSWbiPrB8oQoVsF2Vd8N4P5L0E1KsB7YzCCk0XOXGqrZ/bOlSnytrb1CWg0avL0eiJVYNYnmiL9QO7z/pIdswPFKdrE1E+2Y9Bsrt72ffUyfjsCyJMeSmZUFA4bTCgaugJ5dzgoom7TrJpCvQYXlM8rhMs+a3WGmcEla9aMKpisn74djwzIysE3m8ormLeSHwlSvUMLuhOMVqAqerPebh/UQOiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb3gjOxZ0FbCXsCymi1eabHPolKrTsKUMQiXr7TtMgQ=;
 b=iEPIu103svvJIIJGuL/3pg9+fqKDZMII5cPWajai6h6I/V3j1zWL3IMnUnx9YBIkJomtYG6T5izvwDL82SNFSk1f/Rmg/vC2S/oUyhxGAfbVYpKv11owqel5dLtjEoU895afVOt+zJidsG+4Y1C2mea3kJKV/I87Uayp3fJ04GHIIEyqZLL4MRwF2iQgeeeEtEgYkGepYitcpC/OjHRTft+b+wRBdqPSGs8Z7Hep+OKmZSuApagPHOlwGc6HR792b46kMkEd9xg+l7GW3cD50LrzFml58Ply7rxyx96fWCS6DuN1Fz5+jL0zGTuao1KcSWYiXV6f1rkgX3ioxfLpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb3gjOxZ0FbCXsCymi1eabHPolKrTsKUMQiXr7TtMgQ=;
 b=d5Q67C5ldOp+tP432pawcJ6z0+TGfidmYMKb1BbqveK/6vx310FAeeaxwNznJ+OGaHjJxZqK1ZsrETW9KT3266xDb32Mol0Kwq0glhQ3eKwG2D6VXtC55G8+3x7alF4NgSqzXnYwAA6clsHXvlvb6CKDIqD4jplJM+bzFLWSLT8=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM6PR11MB3817.namprd11.prod.outlook.com (2603:10b6:5:13a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Tue, 7 Apr 2020 13:59:53 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 13:59:53 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 3/7] usb: gadget: at91_udc: Update DT binding
 documentation
Thread-Topic: [PATCH 3/7] usb: gadget: at91_udc: Update DT binding
 documentation
Thread-Index: AQHWDNhKFbapHhDil023kbgO6T/lmahtq/8AgAAD7gA=
Date:   Tue, 7 Apr 2020 13:59:52 +0000
Message-ID: <9490277e-9513-b198-1980-e8822abf67ff@microchip.com>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
 <20200407122852.19422-4-cristian.birsan@microchip.com>
 <20200407134548.GJ3628@piout.net>
In-Reply-To: <20200407134548.GJ3628@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Cristian.Birsan@microchip.com; 
x-originating-ip: [2a02:2f01:5825:1b00:3c12:302d:fb00:70e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9a15d9-eab6-46bd-2e2f-08d7dafbf233
x-ms-traffictypediagnostic: DM6PR11MB3817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3817C61832CE583B25754486EFC30@DM6PR11MB3817.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(966005)(107886003)(6512007)(66446008)(64756008)(66556008)(66476007)(498600001)(66946007)(76116006)(81166006)(6506007)(53546011)(8676002)(81156014)(5660300002)(36756003)(91956017)(54906003)(6916009)(186003)(6486002)(2906002)(2616005)(71200400001)(8936002)(86362001)(4326008)(31686004)(31696002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMERcla0v9PJbXZTE0nUZbfEV2N0umb/8v2hKP3BgUmKK/6oWzbki9Ea08ZKqejBoBcnvaHF/ROfhwVMbo4f4dWCOKIhN5wdRLeafWzRvkn7N6r/cchOCGxyN5D1oCXr6GttYlG+oOlbCUU4V4xw3uZ0awbSYESe9rfmT83iYoVyPlRFBuTVITa2ncjLNfPtCO21NFu9oF0RG41uQoYBUgBFeXZUEuVoHTgJt5pz6u8H+bU3IkW7iRNiykbFyW53ydh2v89HS5vMrBlU2DpITKJFdwJL6uS5UAHvrISBC27qYNP6sf3CG/lcTOa2I3h/nQecMeNbjKDKf2UXlyKfsv9OFECnlZX5qBlpKSsJYYVwWJ1CvazDGiSRcfcmvZ2D8W8poJkGvJ9FbYbJ9DOe1jAoKg86bGAmTXHaNjXEYLFAnp9qFu6ccAlCWWiMH6NGZs6BV0pVZA9FmsJThevLhecOUnrF++a/ikb8ophIE1k7u+1/KrL89nR4z4tFPeBqbggq9i74hcm6zXMslTulcw==
x-ms-exchange-antispam-messagedata: hpizuN8NSldMWkXhI5W3TdtA+Lz2NcE7schX3Fr13/XhTFZ81xnNnE2BdfZExkPn9E2iMrO+pkkDHGjuqHX+C41SNUj03U28YlFltlh1VKRsFh6n25dKFmQyn9co4mo9PlG5VmtnUvmWFVEyMOOf59Lbqr5dYl3PssoLhAb9FDSIxwtr0jEI4Kfx5YxEidrjRZUm8NYmv4TvKLGtKMPEWQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <493CCD0376AB0A4CAB6EC9E01C00D9ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a15d9-eab6-46bd-2e2f-08d7dafbf233
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 13:59:53.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADXVeCoWXrAnAphOdimw1gbk97dnR5JIGFwRGR/Si3/aQ6SO5XjbezcA1oa1Z+P7H8xh6Ji/YdAp/e2JuY2SDWHCH2ovRIVOBhdfFr+FuzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC83LzIwIDQ6NDUgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gVGhlIHByZWZpeCBmb3Ig
dGhpcyBwYXRjaCBzaG91bGQgYmUgZHQtYmluZGluZ3M6IHVzYjoNCj4gDQoNClllcywgdGhhbmtz
LiBJJ2xsIHNlbmQgdGhpcyBwYXRjaCB0b2dldGhlciB3aXRoIHRoZSBkZXZpY2UgdHJlZSBub2Rl
IHNlcGFyYXRlbHkuDQoNCj4gT24gMDcvMDQvMjAyMCAxNToyODo0OCswMzAwLCBjcmlzdGlhbi5i
aXJzYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IENyaXN0aWFuIEJpcnNhbiA8Y3Jp
c3RpYW4uYmlyc2FuQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQWRkIHNhbTl4NjAgYmluZGluZy4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDcmlzdGlhbiBCaXJzYW4gPGNyaXN0aWFuLmJpcnNhbkBt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9hdG1lbC11c2IudHh0IHwgMSArDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvYXRtZWwtdXNiLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvYXRtZWwtdXNiLnR4dA0KPj4gaW5kZXggNDRlODAxNTNiMTQ4Li5iYWUyYjkyOGEwMTQg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2F0
bWVsLXVzYi50eHQNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvYXRtZWwtdXNiLnR4dA0KPj4gQEAgLTgyLDYgKzgyLDcgQEAgUmVxdWlyZWQgcHJvcGVydGll
czoNCj4+ICAgICAgICAgICAgICAiYXRtZWwsYXQ5MXNhbTlybC11ZGMiDQo+PiAgICAgICAgICAg
ICAgImF0bWVsLGF0OTFzYW05ZzQ1LXVkYyINCj4+ICAgICAgICAgICAgICAiYXRtZWwsc2FtYTVk
My11ZGMiDQo+PiArICAgICAgICAgICAgIm1pY3JvY2hpcCxzYW05eDYwLXVkYyINCj4+ICAgLSBy
ZWc6IEFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGUgZGV2aWNl
DQo+PiAgIC0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gdXNiYSBpbnRlcnJ1cHQNCj4+ICAg
LSBjbG9ja3M6IFNob3VsZCByZWZlcmVuY2UgdGhlIHBlcmlwaGVyYWwgYW5kIGhvc3QgY2xvY2tz
DQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIEJv
b3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczov
L2Jvb3RsaW4uY29tDQo+IA0KDQo=
