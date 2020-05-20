Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B54C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D59B20842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mMhLAAha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgETC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:56:14 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:39234
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbgETC4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVvOs85adMmsRP6+n/LV0BEfR1jvd+Rt/2+IEX+f4kvT6Jj9yVzxLg27VaSEjGyHMntPEt7eUMQO/3K1QO+1oVmGKKhfOSQG0qVNP7nkzWT+DEKk+lNA531if0eKFHu1AbI9Bhv8wLsrvKVYy+OfnWZbDV0kusBFNS8nPdjcNjqgVwGoP+JrXmhC7Nabn6QJTjTyb4qPCGXXmlzrfoUbQPsDVecswmKzb/H4buF5JcPOOyd3NuyuQcMkEikDD+Pgkbs+6T7fW9V1FED/bTCuzGBzuSzYTDdSXaMI7v9/ksMi4rLFTWsQ4xPWotJM1XP7wl67thii29kWEgCsV8ZxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnnRFrX2wh79qoNNox7OJFEiKA9HA2UDnBnMw6kzMOs=;
 b=cKP5VUW817LfumV7hX7/dewD3iLKjgj8okY49YkwKYX/rWtVNna1+phZYDZujWoauGvX/bbFpuqOfLed9nGZxiF2y9LSlHm9nki0RcuFHqUh7OVY0ELKydoawxY0d5rxav5mx3hGX0kjcWVNYldfW+6eylXYGdHIlDu96b9WYdoKq5CoiDCzplMbTWwRf8d86nTX55D9Nsjy9wv9UzfxJrX4nPu+hKWuJ4Oj5tBBfHxLZZGCi2Jxx022nSUnPnoBAiGrwd+OUEDM6WZxIZC1P8Yqyo2T/NmnkGkWf02YawYRZmV4+EBXYwW1pmiQqfGHv94aKo2+9Ap46Yvy4Mqb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnnRFrX2wh79qoNNox7OJFEiKA9HA2UDnBnMw6kzMOs=;
 b=mMhLAAhafnGHptDVgieLq165anT0O0FgcsKztFDPFp0v+OSZpyT94Peai7hCwJ6pz/pQOxOVJBa4un1pCxirBymYPTpXnQrG24GsAnM1OldAXt2XI8uyVkFV76ZNNK35R0XxWJ29RdGKylq+RwPowVoaEqncOWjcGxcocxIu7OQ=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Wed, 20 May
 2020 02:56:08 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 02:56:08 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for
 userspace
Thread-Topic: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Thread-Index: AQHWKC/JBsW537XBBkm8ttCDNV27c6ivzJ6AgAB7Y7A=
Date:   Wed, 20 May 2020 02:56:08 +0000
Message-ID: <DB8PR04MB6795A3C57F2B02632D591183E6B60@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus>
In-Reply-To: <20200519185125.GB453195@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1955cee0-0fb3-4821-d1a2-08d7fc6958c6
x-ms-traffictypediagnostic: DB8PR04MB6986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6986C281430E66FA50C88F33E6B60@DB8PR04MB6986.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPBP4WrCtWBVG1zY8B/vBnqfvR/c62sysBcbBSmoVGL0k8Ei0Fr1dGKKmUhvMoBZGqPupLw3hFHLT3TyKTN2VS++blVqB9OUaHVLKXNkKuqq4qBUedMXOqA0+mbLho+AKA/aCIEqvqf/aCe19u+A16cTfsyaENdWCpOCmrYUYV/obFnzeDyyFglQlQObTCbf0ufRNPhP7EEHnASECYkx3p/rAZ6MtaKOt2LVj/QrUpq+RE0Sskmg0b4h7uEcaDgt6PavGtF57YYt1oTPxv0JGGEl0ZVulylI3l3jdIfFb6EkT5vPCnfAWnk4vhCqIIcGY8U44UWa1JJEx1gcaEJLcIlY6xiy8xTnPkzcodH/7IE6mijSdGLpwgJORbzOmsl3vLo/WrZpSAuyDPxo5rMlERAssi8LZaWgs1cCXOZSsFq7kpElPDwSsqJd62xuQHy1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6916009)(7696005)(52536014)(54906003)(86362001)(316002)(8676002)(5660300002)(4326008)(55016002)(71200400001)(9686003)(478600001)(8936002)(2906002)(76116006)(66946007)(6506007)(66556008)(53546011)(66476007)(33656002)(186003)(26005)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KJvjurPtYEACbs/jT6lPsPnhheUnpTtOWnOf0Qs9F7tKJpzAtK0opSIU0iPhQ9qG95cXZ01+GRnSnHKABQc8LqBiUztvH2xky94C4FrXebXQsLDQGfRnLi+wbc2rf+JXuLPJ7j0AUEJcNqxPxzooB9kGV38SJUGQiVbIaSJsMloAZbZ1rZriPvrYrVJY1UKwrAQmYFUxVcAJ9PIzzjs4N4/fXbMIG44TZu11ag1OZw6XNYpcacUB8sJWuanwQHkf5MhaaELPKvK+O8AqpvJ4RAzDfVw43cwoqjudLm6J2cnoKphqQWyF3rfxnd1OKVqAMpgWukzWDiEi2CCc3mdjYd4XCIz32f9I7yOwCrZHwqh09z/tJ/cDzfWByQvb9M7ikKVDgs97Qb9MeXqpvx2TjivLslizBkYcTY1mh+2l3kmxziVE00/MpS3+JRGFm1CY1C1JFoNpNkKiqPA3vs0dWVLETJvcckRO/7poLjVPbJE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1955cee0-0fb3-4821-d1a2-08d7fc6958c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 02:56:08.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMKABfOrbzdRs7yUBrZgIEBunyahmqIFyAvfNl3r4e0vZNl25QM/jonoexxJpsRaxKzdDH5kuo9JSWWkknScYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jXUwjIwyNUgMjo1MQ0KPiBUbzogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IGpvaG4uZ2FycnlAaHVhd2VpLmNv
bTsgd2lsbEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSBS
RVNFTkQgMS8zXSBwZXJmL2lteF9kZHI6IEFkZCBzeXN0ZW0gUE1VIGlkZW50aWZpZXINCj4gZm9y
IHVzZXJzcGFjZQ0KPiANCj4gT24gVHVlLCBNYXkgMTIsIDIwMjAgYXQgMDM6MzE6MTNQTSArMDgw
MCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IFRoZSBERFIgUGVyZiBmb3IgaS5NWDggaXMgYSBz
eXN0ZW0gUE1VIHdob3NlIGF4aSBpZCB3b3VsZCBkaWZmZXJlbnQNCj4gPiBmcm9tIFNvQyB0byBT
b0MuIE5lZWQgZXhwb3NlIHN5c3RlbSBQTVUgaWRlbnRpZmllciBmb3IgdXNlcnNwYWNlIHdoaWNo
DQo+ID4gcmVmZXIgdG8gL3N5cy9idXMvZXZlbnRfc291cmNlL2RldmljZXMvPFBNVSBERVZJQ0U+
L2lkZW50aWZpZXIuDQo+IA0KPiBXaHkgbm90IGp1c3QgZXhwb3NlIHRoZSBBWEkgSUQgaWYgdGhh
dCdzIHdoYXQncyBkaWZmZXJlbnQ/DQoNCkhpIFJvYiwNCg0KRWFjaCBtYXN0ZXIgaGFzIHRoZWly
IG93biBBWEkgSUQsIHN1Y2ggYXMgVVNCLCBHUFUsIFZQVSBldGMsIGl0IGlzIHZhcmlvdXMgZnJv
bSBkaWZmZXJlbnQgU29Dcy4gV2Ugd2FudCB0byBhZGQgc3lzdGVtIFBNVSBzdXBwb3J0IGluIHBl
cmYgdG9vbCwgc28gd2Ugd2FudCB0byBleHBvc2Ugc29tZXRoaW5nIGZyb20gcGVyZiBkcml2ZXIg
dG8gaWRlbnRpZnkgZWFjaCBTb0MuDQpXaGVuIHdlIGtub3cgd2hpY2ggU29DIGl0IGlzLCB3ZSBj
YW4gZ2V0IGVhY2ggbWFzdGVyIEFYSSBJRC4gSWYgdGhpcyBwYXRjaCBjYW4gYmUgYWNjZXB0ZWQs
IC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2VzLzxQTVUgREVWSUNFPi9pZGVudGlmaWVyIGNv
dWxkIGJlIGEgY29tbW9uIGludGVyZmFjZSBmb3IgYWxsIHN5c3RlbSBQTVVzLg0KDQpJIHdpbGwg
Y2hhbmdlIHRvIGFkZCBhIHByb3BlcnR5IHRvIGlkZW50aWZ5IFNvQywgdG8gc2VlIGlmIGl0IGlz
IGJldHRlci4gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wZXJmL2ZzbF9pbXg4X2Rkcl9wZXJmLmMgfCA0NQ0KPiA+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGVyZi9mc2xfaW14OF9kZHJfcGVyZi5jDQo+ID4gYi9kcml2ZXJzL3BlcmYvZnNsX2lteDhfZGRy
X3BlcmYuYw0KPiA+IGluZGV4IDk1ZGNhMmNiNTI2NS4uODhhZGRiZmZiYmQwIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGVyZi9mc2xfaW14OF9kZHJfcGVyZi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wZXJmL2ZzbF9pbXg4X2Rkcl9wZXJmLmMNCj4gPiBAQCAtNTAsMjEgKzUwLDM4IEBAIHN0YXRp
YyBERUZJTkVfSURBKGRkcl9pZGEpOw0KPiA+DQo+ID4gIHN0cnVjdCBmc2xfZGRyX2RldnR5cGVf
ZGF0YSB7DQo+ID4gIAl1bnNpZ25lZCBpbnQgcXVpcmtzOyAgICAvKiBxdWlya3MgbmVlZGVkIGZv
ciBkaWZmZXJlbnQgRERSIFBlcmYgY29yZSAqLw0KPiA+ICsJY29uc3QgY2hhciAqaWRlbnRpZmll
cjsJLyogc3lzdGVtIFBNVSBpZGVudGlmaWVyIGZvciB1c2Vyc3BhY2UgKi8NCj4gPiAgfTsNCj4g
Pg0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9kZHJfZGV2dHlwZV9kYXRhIGlteDhfZGV2
dHlwZV9kYXRhOw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9kZHJfZGV2dHlwZV9kYXRh
IGlteDhfZGV2dHlwZV9kYXRhID0gew0KPiA+ICsJLmlkZW50aWZpZXIgPSAiaS5NWDgiLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmc2xfZGRyX2RldnR5cGVfZGF0
YSBpbXg4bXFfZGV2dHlwZV9kYXRhID0gew0KPiA+ICsJLnF1aXJrcyA9IEREUl9DQVBfQVhJX0lE
X0ZJTFRFUiwNCj4gPiArCS5pZGVudGlmaWVyID0gImkuTVg4TVEiLA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmc2xfZGRyX2RldnR5cGVfZGF0YSBpbXg4bW1fZGV2
dHlwZV9kYXRhID0gew0KPiA+ICsJLnF1aXJrcyA9IEREUl9DQVBfQVhJX0lEX0ZJTFRFUiwNCj4g
PiArCS5pZGVudGlmaWVyID0gImkuTVg4TU0iLA0KPiA+ICt9Ow0KPiA+DQo+ID4gLXN0YXRpYyBj
b25zdCBzdHJ1Y3QgZnNsX2Rkcl9kZXZ0eXBlX2RhdGEgaW14OG1fZGV2dHlwZV9kYXRhID0gew0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9kZHJfZGV2dHlwZV9kYXRhIGlteDhtbl9kZXZ0
eXBlX2RhdGEgPSB7DQo+ID4gIAkucXVpcmtzID0gRERSX0NBUF9BWElfSURfRklMVEVSLA0KPiA+
ICsJLmlkZW50aWZpZXIgPSAiaS5NWDhNTiIsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBmc2xfZGRyX2RldnR5cGVfZGF0YSBpbXg4bXBfZGV2dHlwZV9kYXRhID0gew0K
PiA+ICAJLnF1aXJrcyA9IEREUl9DQVBfQVhJX0lEX0ZJTFRFUl9FTkhBTkNFRCwNCj4gPiArCS5p
ZGVudGlmaWVyID0gImkuTVg4TVAiLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9kZHJfcG11X2R0X2lkc1tdID0gew0KPiA+ICAJeyAuY29t
cGF0aWJsZSA9ICJmc2wsaW14OC1kZHItcG11IiwgLmRhdGEgPSAmaW14OF9kZXZ0eXBlX2RhdGF9
LA0KPiA+IC0JeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG0tZGRyLXBtdSIsIC5kYXRhID0gJmlt
eDhtX2RldnR5cGVfZGF0YX0sDQo+IA0KPiBZb3UgbmVlZCB0byBrZWVwIHRoZSBvbGQgb25lIGZv
ciBjb21wYXRpYmlsaXR5Lg0KPiANCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1k
ZHItcG11IiwgLmRhdGEgPSAmaW14OG1xX2RldnR5cGVfZGF0YX0sDQo+ID4gKwl7IC5jb21wYXRp
YmxlID0gImZzbCxpbXg4bW0tZGRyLXBtdSIsIC5kYXRhID0gJmlteDhtbV9kZXZ0eXBlX2RhdGF9
LA0KPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1uLWRkci1wbXUiLCAuZGF0YSA9ICZp
bXg4bW5fZGV2dHlwZV9kYXRhfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1k
ZHItcG11IiwgLmRhdGEgPSAmaW14OG1wX2RldnR5cGVfZGF0YX0sDQo+ID4gIAl7IC8qIHNlbnRp
bmVsICovIH0NCj4gPiAgfTsNCj4gPiBAQCAtODQsNiArMTAxLDI3IEBAIHN0cnVjdCBkZHJfcG11
IHsNCj4gPiAgCWludCBpZDsNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgc3NpemVfdCBkZHJf
cGVyZl9pZGVudGlmaWVyX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICsJCQkJCXN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiA+ICsJCQkJCWNoYXIgKnBhZ2UpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBkZHJfcG11ICpwbXUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gc3ByaW50ZihwYWdlLCAiJXNcbiIsIHBtdS0+ZGV2dHlwZV9kYXRhLT5p
ZGVudGlmaWVyKTsNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIHlldCBhbm90aGVyIHdheSB0byBpZGVu
dGlmeSB0aGUgU29DIGZyb20gdXNlcnNwYWNlPw0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlIGRkcl9wZXJmX2lkZW50aWZpZXJfYXR0ciA9DQo+
ID4gKwlfX0FUVFIoaWRlbnRpZmllciwgMDQ0NCwgZGRyX3BlcmZfaWRlbnRpZmllcl9zaG93LCBO
VUxMKTsNCj4gDQo+IHN5c2ZzIGF0dHJpYnV0ZXMgYXJlIHN1cHBvc2VkIHRvIGJlIGRvY3VtZW50
ZWQuDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmRkcl9wZXJmX2lk
ZW50aWZpZXJfYXR0cnNbXSA9IHsNCj4gPiArCSZkZHJfcGVyZl9pZGVudGlmaWVyX2F0dHIuYXR0
ciwNCj4gPiArCU5VTEwsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IGF0dHJp
YnV0ZV9ncm91cCBkZHJfcGVyZl9pZGVudGlmaWVyX2F0dHJfZ3JvdXAgPSB7DQo+ID4gKwkuYXR0
cnMgPSBkZHJfcGVyZl9pZGVudGlmaWVyX2F0dHJzLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgZW51
bSBkZHJfcGVyZl9maWx0ZXJfY2FwYWJpbGl0aWVzIHsNCj4gPiAgCVBFUkZfQ0FQX0FYSV9JRF9G
SUxURVIgPSAwLA0KPiA+ICAJUEVSRl9DQVBfQVhJX0lEX0ZJTFRFUl9FTkhBTkNFRCwNCj4gPiBA
QCAtMjM3LDYgKzI3NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwICph
dHRyX2dyb3Vwc1tdID0gew0KPiA+ICAJJmRkcl9wZXJmX2Zvcm1hdF9hdHRyX2dyb3VwLA0KPiA+
ICAJJmRkcl9wZXJmX2NwdW1hc2tfYXR0cl9ncm91cCwNCj4gPiAgCSZkZHJfcGVyZl9maWx0ZXJf
Y2FwX2F0dHJfZ3JvdXAsDQo+ID4gKwkmZGRyX3BlcmZfaWRlbnRpZmllcl9hdHRyX2dyb3VwLA0K
PiA+ICAJTlVMTCwNCj4gPiAgfTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
