Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8629C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925342074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pjglzq30";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="P0oU/52j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgGAGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:51:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50225 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAGvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593586292; x=1625122292;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jeA42hvst2aoeSSq56GO424femNQnJ26WcJ4qt4Zuho=;
  b=Pjglzq30Y4OjzDgQfaHCKViJLX+CtxjevzAo8FRQH1QQCzgYs7Pqa+wP
   25wY/7ICpfuPGmNkwBTAVCMcy/uvVTExrqVPJ/pIAil9TSCXIAXq7ffGl
   mcvay4UJq2S4a0cW5HZZ6KiEtAIBNfhLJBa6VrB1+gl3PiV3CQuGKNp6n
   iu7NJdo64fnecEzfBVPCy0ltnisg69jY0sakZfSfUiSTUGZZrTByAlDvA
   CsSP5ZvCXP1j2Q5/OP0rfANjusbQwHwyvtEonwVV+Y+pBqbwi0m8k0YDq
   Xdh+fa1jx9xqkRztu+YTuGOinIfmmZ6NgEuUAmvOZCQ4NJfs38Cu/rAGs
   g==;
IronPort-SDR: FNLVTDR68zh4xWmhzl1Z76NzWF97IipqBJTlRAj0EPavsHYoJQ1lYr+f+UTtPV/nH1RPbfUIzZ
 FV85NxF4kXtV3eMt4ZlaF8RpimHAIqo7Hz0cILB4f1b4p1/Aig1d1DA42ZzMpQmxJLM1iY7pBK
 dT/WxmfrzNMCEfr58nOTNemO3UDmVx8e1cKIPxHSAqp4sTRMr9v3bKrTWPwJ1Y1bcY3IT2NgCE
 KS3AtjkDlcREpPQmltx8z2OWbLHaJsdhyNr0jKU4S7nm/p+XbYC5HGrhC97YqRx63FCnwuVGul
 mIM=
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="85765212"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2020 23:51:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 23:51:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgBNUWZflO60I7NIIzysBrnKUTd40X6RUMX0PVnwLRUcezQq7VPjVDmcfNjw/GrMKVk5Qu94nejlGAPv2vjmvXH5mHG1WYXPX0Bos37mzhbL4+/CtWkqIwCJnmrUAOijKhS8UxGwdxcmchZAbxaXpb6//seglKtUdB/cgvpNnAQmLnCPaqhDgi0Kbix4YSiWp7oGCkYiSj2z9YywOCzDDNOyQH/nsZ/SmUaGLkIBo6xLV2uOKC3VlyExl3De9TtXQwW29zujIuN7FJOACWvjm+4wqsbqw3+oTsUjSvBloSmAUz8pBFEeKPq91BoQgevq7xOEvRKTNBN0m2/W94H4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeA42hvst2aoeSSq56GO424femNQnJ26WcJ4qt4Zuho=;
 b=W45jfP1jw5Cu48mKyW5TSyeMvt0AUVdNTAC0mS6e3ecoHSkrm/2EohOAuepdJFjfYSOiIDf3Ni6OMqvkI2iTGxEXYGhUMjyCFhx77LpujbCkmGsKkBdHHVoI5K8lByEfnnHde+h1LXLTruWE7oY8hW8d0mEmTk5DQuGVrxNsP/G3YCVwue7KUOLrwQdEv7GjhxW1lZEY9w3fueyvoCC9aaC3Hcd7qAWme9MooMWb0P+KOHpp9ZAeplxJP1IR2Nn5QFpc7LPeNYdQqX78Z4OynbCgS8NPXd8NuSfqPfWhbLaUb8oH2hE+NIpOhwiQOJzcqzDglhdCBmdKyxeJoPUu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeA42hvst2aoeSSq56GO424femNQnJ26WcJ4qt4Zuho=;
 b=P0oU/52jtYbcGSGaM53Z5tnEfU0UFpsEYcpUfO3OmYZ8MclH5m9MFm1qhbxp11CGagAEKRY492lVgr9Zr9wTwoYi6ouCYLmxawRjOui2VwUFGUbODbNwKuPU/KGBG/2I+acxAjmdXTsQwu2ZrHJHob4dJaSQgnVoMj15S8qFdRM=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2968.namprd11.prod.outlook.com (2603:10b6:a03:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 06:51:30 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 06:51:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <rayagonda.kokatanur@broadcom.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] drivers: mtd: spi-nor: update read capabilities
 for w25q64 and s25fl064k
Thread-Topic: [PATCH v2 1/1] drivers: mtd: spi-nor: update read capabilities
 for w25q64 and s25fl064k
Thread-Index: AQHWT3QL3jLieq05KESXVn3RHsNxaA==
Date:   Wed, 1 Jul 2020 06:51:30 +0000
Message-ID: <2c308101-ba40-2dd4-7304-7e2e29e9aa64@microchip.com>
References: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <20200529071655.739-1-rayagonda.kokatanur@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47deb50b-274a-48f5-008d-08d81d8b2f2b
x-ms-traffictypediagnostic: BYAPR11MB2968:
x-microsoft-antispam-prvs: <BYAPR11MB2968502086E6A3ECFCBB02A4F06C0@BYAPR11MB2968.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4ZBCG8sFRcZeotJ43+wehrz490zVeJ8qsuOkiUG5N8sRjHme4lowdsp4OtB2xTBJZ+GkEk+uZdDPNzLirPo7XMN+ymMQh6js3qahwKsrCyRVM7hQF1mF6BEMQHRObD9+KlRH76uJ7A2xn5FjPz8yq7agHE+caORXfT0nPmdeb5sw/4m/EihSDD+YJpqp8bhvypLG/JwWsn56dPQc67fp4n1ajs516+WLRgMklovP0VMGAj0654fXqBcAgIvZ6DNNObl6MW2j2jQYxYqtDwKVQXQVA7NIKneSQjC4lY4uM3zJpc/cCpZ2vwF6ET/0cyvRbT7lZhdTAC6eNrvv7OUL8Tt+znOxLOu3Y+gvnjPHV0BVbENGaIg0PbGbCQd7PFv38YsY8sDDOM6ZMRBPJArewNhfylU8dKGU8EZJilgZVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(53546011)(6506007)(6512007)(31686004)(110136005)(186003)(26005)(2616005)(316002)(83380400001)(66556008)(86362001)(64756008)(36756003)(71200400001)(478600001)(8676002)(66476007)(5660300002)(15650500001)(66946007)(8936002)(31696002)(66446008)(76116006)(2906002)(91956017)(6486002)(138113003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PqG1bKxddv3VL1V5EmFMDgc3+1mg5c6O/Y+Mtuyr70+nKCYMApe9aUedbWoVpHbORBA9eoJsGE6rQLGcfPZ7GBeWDgvyYhr1eimkHwMg1aBIgxmiP7cttBpSD9KzUXqC8qPIC6Zanl9nUZlodwrJEc4Mhb4ZoSqHXxIhtAD3/nxcf81QAx+Vcex8y91Ifx+wibXiSCH25b6cBjJ7M3NeytlMwy6RkDIGmzpemVKXoYnwwpaZ6ubBxl/QKCDh+F3aUMZQzDimL28MN0QkUK4dhjAp7fWrSMkKtrD5/KX5w/MbgKNkJIr4PUugz/BqJ44h+R2if1rxHQsL1oybWaYDqUQLDXBtRl3OG511eI/BaoP6QhQj9mb3ytez/VbJCPH2R+JOzu1327SaBFhidEHtgC8kDGwPKnKz42BTyX0ZUukEout64lT7X/UPESEwc4mL4AQsgDxPGNz/8OppThDva1n3jgNvecE5Y4OmGnSgZ9U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A25F22232D3BE748A8DB031BA23C961E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47deb50b-274a-48f5-008d-08d81d8b2f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 06:51:30.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IhbqG3Q81nnrk6FDYkg/cYiTpiBPHLZ4MT9ChN51g1q8HVRhgdci2R4aAy9SMLJQ8IAEMhwqnnB2s+ul5tOyFPRQk+IcoCBjL2ld7khn4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOS8yMCAxMDoxNiBBTSwgUmF5YWdvbmRhIEtva2F0YW51ciB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBCb3RoIHcyNXE2NCBhbmQgczI1Zmww
NjRrIG5vciBmbGFzaCBzdXBwb3J0IFFVQUQgYW5kIERVQUwgcmVhZA0KPiBjb21tYW5kLCBoZW5j
ZSB1cGRhdGUgdGhlIHNhbWUgaW4gZmxhc2hfaW5mbyB0YWJsZS4NCj4gDQo+IFRoaXMgaXMgdGVz
dGVkIG9uIEJyb2FkY29tIFN0aW5ncmF5IFNvQyAoYmNtOTU4NzQydCkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBSYXlhZ29uZGEgS29rYXRhbnVyIDxyYXlhZ29uZGEua29rYXRhbnVyQGJyb2FkY29t
LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgZnJvbSB2MToNCj4gIC1BZGRyZXNzIHJldmlldyBjb21t
ZW50cyBmcm9tIFZpZ25lc2ggUmFnaGF2ZW5kcmENCj4gICBVcGRhdGUgY29tbWl0IG1lc3NhZ2Ug
d2l0aCB0ZXN0aW5nIGRldGFpbHMuDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lv
bi5jIHwgMyArKy0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jICB8IDMgKystDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4gaW5kZXggNjc1NjIwMmFjZTRiLi5jOTFiYmI4ZDljZDYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BhbnNpb24uYw0KPiArKysgYi9k
cml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4gQEAgLTUyLDcgKzUyLDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwYW5zaW9uX3BhcnRzW10gPSB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05P
Ul9RVUFEX1JFQUQpIH0sDQo+ICAgICAgICAgeyAiczI1ZmwwMTZrIiwgIElORk8oMHhlZjQwMTUs
ICAgICAgMCwgIDY0ICogMTAyNCwgIDMyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAt
ICAgICAgIHsgInMyNWZsMDY0ayIsICBJTkZPKDB4ZWY0MDE3LCAgICAgIDAsICA2NCAqIDEwMjQs
IDEyOCwgU0VDVF80SykgfSwNCj4gKyAgICAgICB7ICJzMjVmbDA2NGsiLCAgSU5GTygweGVmNDAx
NywgICAgICAwLCAgNjQgKiAxMDI0LCAxMjgsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+
ICAgICAgICAgeyAiczI1ZmwxMTZrIiwgIElORk8oMHgwMTQwMTUsICAgICAgMCwgIDY0ICogMTAy
NCwgIDMyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9S
X0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAgICAgICAgIHsgInMyNWZsMTMy
ayIsICBJTkZPKDB4MDE0MDE2LCAgICAgIDAsICA2NCAqIDEwMjQsICA2NCwgU0VDVF80SykgfSwN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXggMTdkZWFiYWQ1N2UxLi4yMDI4Y2FiM2VmZjkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+IEBAIC0zOSw3ICszOSw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5ib25kX3BhcnRzW10gPSB7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FV
QURfUkVBRCB8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NL
IHwgU1BJX05PUl9IQVNfVEIpIH0sDQo+ICAgICAgICAgeyAidzI1eDY0IiwgSU5GTygweGVmMzAx
NywgMCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAidzI1cTY0Iiwg
SU5GTygweGVmNDAxNywgMCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+ICsgICAgICAg
eyAidzI1cTY0IiwgSU5GTygweGVmNDAxNywgMCwgNjQgKiAxMDI0LCAxMjgsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FV
QURfUkVBRCkgfSwNCg0KSSBjaGVja2VkIHRoZSB3aW5ib25kIHdlYnNpdGUgYW5kIGZyb20gYWxs
IHRoZSB3MjVxNjQgZmxhc2hlcywgVzI1UTY0SlYtSVEvSlENCmFuZCBXMjVRNjRGViBzaGFyZSB0
aGUgMHhlZjQwMTcgZmxhc2ggSUQuIEJvdGggc3VwcG9ydCAweDNiIGFuZCAweDZiIGNvbW1hbmRz
LA0Kd2hpY2ggaXMgZmluZS4NCg0KSSBzZWUgdGhhdCBzMjVmbDA2NGsgYW5kIHcyNXE2NCBzaGFy
ZSB0aGUgc2FtZSBmbGFzaCBJRC4gVGhlIHNlYXJjaCBhbGcgd2lsbA0KcmV0dXJuIHRoZSBmaXJz
dCBoaXQsIHNvIHMyNWZsMDY0ayBldmVuIGZvciB0aGUgd2luYm9uZCBwYXJ0cy4gV2hhdCBpcyB0
aGUNCmRpZmZlcmVuY2UgYmV0d2VlbiBzMjVmbDA2NGsgYW5kIFcyNVE2NEpWUS9XMjVRNjRGVj8N
Cg0KQ2hlZXJzLA0KdGENCg==
