Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF748C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7387207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jzxuroVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAMQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:21:44 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:19594 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:21:43 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 86VJW+iYXUDESJD7+KQtaN0W6p4HK+StlCVB8VfdsuKt6iQnybrAFBSoi4D1/g4NAApH/Zqy1s
 no+83EAR0gLG/zhwQUyQE9pbQDzpQWv7hLlNfzBClnPBId6wyioFXHXINjAHZZLnv2taQRlE7Q
 9wT9kZn0tfUQiiIDMUhxXQTveodjYJfMB9J8c5+n1JcFDjrAXEYWDGG8Ph3wQ4fkAxxLjEMeg+
 028xKeyFjokYqUcBXqhzPHtL2C+QrNY/78lhtxBuojNwqvtxSesdqfRkigid0EgFl4NL4HiyHO
 MTU=
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="62447853"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 09:21:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 09:21:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 09:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAsrdkF5uQcVf5ZF3KiAkCTzyyfM5DE8ofXw21XdUlxKOQk65eeGoZGudbjQ3IXqbbKfRZStf73Ee1KuUri1gKG3T7duKDJZOxMkGxTCsgUAamIDaB1e26rAUpBUsfa/+HghsG5UHKk3QSDtVOhuRnp4YvBMCsIe+j1M6U7vbQPqaRNWHxSQLt3T0RZn2p+Vr6MvrYmzQHyTE82KA5ghgS2i8PBo5Sw6TBBYk3oAPNGvULRt28ytUzPBdDh5vOzDgl/HRBvHn+OfW13n/esd+v0zZIFLySKFhIjYFXupdwQ3cuJ8ff7zA10SAK2FqclBQ1r8F+gN2JVsxzlrYhBwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPqttbWxe9aaYs6weEtaFyHItVqFhTGIrdnfVLVm4YQ=;
 b=WCxX7W77s9e4ereth1KpKk6Kdd/T6MZOUMsxS/nMwL2UNJn3yp+qPeLViUsLP7Fq6Oei6pLeVBCiyI4VBtKzeqx+oRWYmSjdxJzJTTO/PGrCu+DoBBNtLrEc25KxQnkRpNwfqCdZAnBIIK6IR+bn8AwnMDnOwkqHCEOojkdXbHLfvNfSUnXjOmkEj7BIOISqUAVbDilxU51mWsdsNDOGyp0oSOi1DGhkjOPy3+dY4RdRTQ96z5D4KT+068pSOuyVEzjyTaKKQisb55mV1C/PrskHHtlL8chSY7cXHHRWzsC3F0sieL7iRdPKGcN18fsrmn3R2Qa3b/fSUJbjMUf0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPqttbWxe9aaYs6weEtaFyHItVqFhTGIrdnfVLVm4YQ=;
 b=jzxuroVhSxREfKBb0H+HqZGlfwI5aKlrZUc1Mte5jwoYvhaX2bOI6DRPEQlNrHU4Q9i5VniuT1uuWjLEPhKC3/CfCVf0JP/4nATyz0qo5dUoBuQ+zxCA0hDL4vWIUbM2JmNgGuA93bddHyI7J+5uIETyz0SdIld+Hs+uDbMnGI8=
Received: from BY5PR11MB4497.namprd11.prod.outlook.com (52.132.255.220) by
 BY5PR11MB4241.namprd11.prod.outlook.com (52.132.255.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 16:21:39 +0000
Received: from BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd]) by BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:21:39 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <chenzhou10@huawei.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <arnd@arndb.de>
Subject: Re: [PATCH next] ASoC: atmel: fix build error with
 CONFIG_SND_ATMEL_SOC_DMA=m
Thread-Topic: [PATCH next] ASoC: atmel: fix build error with
 CONFIG_SND_ATMEL_SOC_DMA=m
Thread-Index: AQHVyhaj92blbJDFUkGfqKFxX0UlQafoxtsA
Date:   Mon, 13 Jan 2020 16:21:39 +0000
Message-ID: <50064e1e-8295-7ddf-6860-c4b798127dd6@microchip.com>
References: <20200113133242.144550-1-chenzhou10@huawei.com>
In-Reply-To: <20200113133242.144550-1-chenzhou10@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b6c9e7c-cc92-47da-9710-08d79844ab84
x-ms-traffictypediagnostic: BY5PR11MB4241:
x-microsoft-antispam-prvs: <BY5PR11MB42419142C8F549C54B344872E7350@BY5PR11MB4241.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(966005)(66476007)(478600001)(76116006)(66946007)(91956017)(8676002)(2616005)(2906002)(81156014)(81166006)(26005)(5660300002)(316002)(186003)(66556008)(64756008)(66446008)(53546011)(6506007)(36756003)(110136005)(54906003)(6486002)(31686004)(8936002)(86362001)(31696002)(4326008)(71200400001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4241;H:BY5PR11MB4497.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFdKqhGkhr3E8QPr7rtiwauwNq+zhs8wOK20rtXFOd4rentpOKDLB0scHfvg+/lVNpghpFnMn01ndpEb2OnSyLwrA/yYnODgxffpvg1G5X8Pyznjpi4Yg0w690IA2yBI6Icxs/Z/XTdDwD0gZ7hMuhEIuqTISqokmY8Oc5/u2w7l1imJa5+tKEpMSUi5zBV3ZZ2ew3Tjl4WpYpHuSz3ngtGFsARmlNvyTRKtLBOlR6SMMg6MtUcEAUDg5XMdWx5k1Jb5lRYftOPgsCRbee2vKTgGI8kMJA3CVIb+PwGIUje1XGenquZOuTk5BcFTXDWYFOdbhy+lvxbhapupiBLuUwgI9BlJdwA9cWvJz5BrOSDKJQtAKPU3dwMu8NcLGb97IOkat211HH1RykhtvJeDAfeXd+trFG3i5Fo+5KTGM2pw3yItHscPQHOUHcCfLKMzxpPQXbKhUKWIH9PqyEnJxjtj7ohmSqQ5hZLOugCCaKk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <218BA23E7577CE4BB334EBE10AC70474@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6c9e7c-cc92-47da-9710-08d79844ab84
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 16:21:39.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0BlToqMNztfGDAbgjG5bmUQtk+IYwM0cHTjpG7XUFfjEVdOH6LeKiZC8HDONOEKfKnrzjFtdqQpgOhYXers2IVHQn5PcnaETJTMtbALYhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDEuMjAyMCAxNTozMiwgQ2hlbiBaaG91IHdyb3RlOg0KPiBJZiBDT05GSUdfU05EX0FU
TUVMX1NPQ19ETUE9bSwgYnVpbGQgZXJyb3I6DQo+IA0KPiBzb3VuZC9zb2MvYXRtZWwvYXRtZWxf
c3NjX2RhaS5vOiBJbiBmdW5jdGlvbiBgYXRtZWxfc3NjX3NldF9hdWRpbyc6DQo+ICgudGV4dCsw
eDdjZCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGF0bWVsX3BjbV9kbWFfcGxhdGZvcm1fcmVn
aXN0ZXInDQo+IA0KPiBGdW5jdGlvbiBhdG1lbF9wY21fZG1hX3BsYXRmb3JtX3JlZ2lzdGVyIGlz
IGRlZmluZWQgdW5kZXINCj4gQ09ORklHIFNORF9BVE1FTF9TT0NfRE1BLCBzbyBzZWxlY3QgU05E
X0FUTUVMX1NPQ19ETUEgaW4NCj4gQ09ORklHIFNORF9BVE1FTF9TT0NfU1NDLCBzYW1lIHRvIENP
TkZJR19TTkRfQVRNRUxfU09DX1BEQy4NCg0KQXJuZCBzZW50IGEgbW9yZSBjb21wbGV0ZSBwYXRj
aCBmb3IgdGhpcyBpc3N1ZToNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEwLzEvNjIwDQoN
Ckl0IHdhc24ndCBtZXJnZWQgZHVlIHRvIHNvbWUgaW50ZWdyYXRpb24gaXNzdWVzLiBDb3VsZCB5
b3UgcGxlYXNlIHRyeSBpdCANCmFuZCBsZXQgdXMga25vdyBpZiBpdCBmaXhlcyB5b3VyIGlzc3Vl
Pw0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcywNCkNvZHJpbg0KDQo+IA0KPiBSZXBvcnRlZC1i
eTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoZW4g
WmhvdSA8Y2hlbnpob3UxMEBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBzb3VuZC9zb2MvYXRtZWwv
S2NvbmZpZyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2F0bWVsL0tjb25maWcgYi9zb3VuZC9zb2MvYXRtZWwv
S2NvbmZpZw0KPiBpbmRleCBmMTE4YzIyLi5kMWRjOGU2IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9z
b2MvYXRtZWwvS2NvbmZpZw0KPiArKysgYi9zb3VuZC9zb2MvYXRtZWwvS2NvbmZpZw0KPiBAQCAt
MTksNiArMTksOCBAQCBjb25maWcgU05EX0FUTUVMX1NPQ19ETUENCj4gDQo+ICAgY29uZmlnIFNO
RF9BVE1FTF9TT0NfU1NDDQo+ICAgICAgICAgIHRyaXN0YXRlDQo+ICsgICAgICAgc2VsZWN0IFNO
RF9BVE1FTF9TT0NfRE1BDQo+ICsgICAgICAgc2VsZWN0IFNORF9BVE1FTF9TT0NfUERDDQo+IA0K
PiAgIGNvbmZpZyBTTkRfQVRNRUxfU09DX1NTQ19QREMNCj4gICAgICAgICAgdHJpc3RhdGUgIlNv
QyBQQ00gREFJIHN1cHBvcnQgZm9yIEFUOTEgU1NDIGNvbnRyb2xsZXIgdXNpbmcgUERDIg0KPiAt
LQ0KPiAyLjcuNA0KPiANCg==
