Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27947C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83A021D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="mrFNnS6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDQJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:51:32 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:34724 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgDQJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:51:30 -0400
Received: from [100.113.1.220] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id AC/96-36549-E1C799E5; Fri, 17 Apr 2020 09:51:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRWlGSWpSXmKPExsWSoc9koitXMzP
  O4FIrh8X9r0cZLS7vmsPmwORx59oeNo/Pm+QCmKJYM/OS8isSWDPanzWzFUwUq/i67DBLA+Mb
  0S5GLg5GgaXMEpu7PjJCOMdYJA639bJBOJsZJX73/gRyODlYBE4wS8xvBbOFBOYzSfy/aQlSJ
  CRwl1HixsZzrCAJNgELicknHoAViQhESuz4epIRxGYWKJfY/+MbO4gtLJAq8b7lBVRNmsTCWz
  9YIWw3iRenupkglqlKnHj2HqyeVyBWYtaaucwQy3YySbz4+BusgVNAR2JKywmwBkYBWYkvjau
  ZIZaJS9x6Mh8sLiEgILFkz3lmCFtU4uXjf6wQ9akSJ5tuMELEdSTOXn8CZStK7Dm3EKpXVuLS
  /G6gOAeQ7Svx6I01RFhL4tDy1VDlFhJLultZIEpUJP4dqoQI50gc23GaBcJWl2j5OI8VwpaRm
  Da9gQnkFQmBKSwSC/YdYp7AaDALydWzgEYxC2hKrN+lDxFWlJjS/ZB9FjgkBCVOznzCsoCRZR
  WjZVJRZnpGSW5iZo6uoYGBrqGhsa6xrqGRkV5ilW6iXmqpbnJqXklRIlBWL7G8WK+4Mjc5J0U
  vL7VkEyMw3aQUMlftYLy4/L3eIUZJDiYlUV7DqplxQnxJ+SmVGYnFGfFFpTmpxYcYNTg4BK4c
  PDKbUYolLz8vVUmC9wlInWBRanpqRVpmDjAlwpRKcPAoifC+AknzFhck5hZnpkOkTjFackx4O
  XcRM8fOo/OA5JG5SxcxC4HNkxLnNa8GahAAacgozYMbB0vblxhlpYR5GRkYGIR4ClKLcjNLUO
  VfMYpzMCoJ8yqDrOXJzCuB2/oK6CAmoIOiHaaDHFSSiJCSamCymCRsePjyX4Z9H3YVr//67sU
  99p4dsxaGha9M+vr0xc+3zmUWrh8kjA3nmuso/J+T9JqHd3m338c7s+WbNmhvF2yP65+wSGTy
  HL+AyeLMyU83Ppx0uZPZbsLuOTFHX5+b19z4++0/xdD2G4xp590DDFh5N3T/vGAUbfmwy73iv
  /YW7mVivMuXnk1aZrxwXRnH6lD1wKScbYIue590XbuRoCrebn2Tf1lApP/K/SXuZd88BM+w3t
  Db/U5oVdSdbT/vFfeaHnoqxpj/YmvHuYNPRapUDedImE9sc2I2eu/9MWvK7wUKVguYmWTfLNx
  p8Dmk11Jdw/HT27DdkR8XiQu87M6WMZ47cUVhbYriUqFzSizFGYmGWsxFxYkAJxO0V1YEAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-24.tower-229.messagelabs.com!1587117085!3253102!1
X-Originating-IP: [104.47.2.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26854 invoked from network); 17 Apr 2020 09:51:26 -0000
Received: from mail-db5eur01lp2052.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.52)
  by server-24.tower-229.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Apr 2020 09:51:26 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9MH7yQKYRk90a98NRTw6dmD5mI/DV38T0J4iH9WU1mNLlMLCea27hLMLZykpBz0k/mtJCeVgWJOroYMqEjVX5/ayV95Nc8zh39zmpteRhsJ6SHsCWeQlZAXp2cZO6o/sCnj2pxSfJO5nIw12wbjnd9UpxPwcMe0yM0PYk5X1HBimOLH5R9QPLsuOc34MG9/sddGrbK8Wax83+8zzBcaeDAkVNykUV+dQD1YoMLvbv0+S4ou0adsTcSMDsYzXfclIJhdFjT+Le9ttAd4JaJ7wP1x0/XiWvDIzmpIu6XYwl+Wvihk80+QDyOAiXJUlOEFP99fB1vynvAZUASq/45bHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl79i8Crwu80MjJwwwJw/+QU7olPIg0FgIVhSorO3dw=;
 b=XBsDF1oaPbOZG/f2WGiSU9qdBeIKI6aJNFPomqbtMTLOOQ/oUPwx5tGxnGeYcKBAN1s7wJrjFvMIx6RA/JJX2VlvT0KbspKtgbFBl8LDHVU/olltQ9XelpZ2Bt3jdoxnPng1jsiDPD6S+Q9e5BVYuKeQOAXi4XfYEf3iP1QzvsnwZRwozjDWlt8GCk/Dmi1iDsrBhebArJLdWT/FUzYTR/PbW3u6PbusSYAwJpA0BW4LJa8p8oTdP82vBfgVBAo5YnEjkLAvT9vYCEuLqZSwQQlX7IvlgMJrT8A4khPhe51bQTKkquw7KLyZCx8AV5Dvu5ETBHX1h7ur94MdzY9GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl79i8Crwu80MjJwwwJw/+QU7olPIg0FgIVhSorO3dw=;
 b=mrFNnS6Yj04gDCFVaW3MA7vpGQ1tGRInnO513h8r9wNM+NKGRq9bCZqcy1w2D39/IQiRDoBkS7OOgEUlBixD/LHTxqyRL5NBmZQTXRNrOhDtRq4C/0l7EQIAbdnGkXBKq5PLYCq6OSZtnFOCnrWNgxliE++c3DWJWTIGsHiXop0=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Fri, 17 Apr
 2020 09:51:24 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 09:51:24 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Topic: [RESEND PATCH v2 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Thread-Index: AQHWC/ENSER4gvf5u0yNBk4BhQAwn6h7chgAgAARuaCAAZgzAIAABiBA
Date:   Fri, 17 Apr 2020 09:51:24 +0000
Message-ID: <AM6PR10MB2263F5CE9B3627A256BD695880D90@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f830d0c2c2210253855d26c05b0e941e9e6f77a9.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <20200416075944.GU2167633@dell>
 <AM6PR10MB22634D3B677E57EED0514DF680D80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200417092410.GF2167633@dell>
In-Reply-To: <20200417092410.GF2167633@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7fed6d0-fe53-4988-fb99-08d7e2b4e451
x-ms-traffictypediagnostic: AM6PR10MB2758:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2758F10BE862D7E7691DE213A7D90@AM6PR10MB2758.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(4326008)(107886003)(478600001)(5660300002)(81156014)(71200400001)(55016002)(52536014)(9686003)(8676002)(66946007)(26005)(66446008)(33656002)(76116006)(66476007)(66556008)(2906002)(86362001)(7696005)(186003)(64756008)(53546011)(6506007)(316002)(54906003)(55236004)(8936002)(110136005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sg/SWukXSYeAxFzYR7MpvfctvdL4IsyCoKN2GCLB0eB/Za1tTY9CK6WzL+3NiJwhnplb2Hd/ZcG/6kQ02qk/q/HI1oLxV0aQWjKsHDNQZ5pw6azv7JxJTunBhOl9rVW6Kv7wh6yCLisebJjDjkMfCnoRyDxBiHsIMxGiOFeikqltu3Sr5HuoR6fwG5Ukt33MxFGOR7RP3W3WAHzqs/GrkKceFXysHX1GaPrljWx4AUA3nwR9KXauxRCua5bGBNZCgVrzPVMN1TqMNuEP/Nj943aOm7aiFxY/1lg3U9bvWfimRuclH9popfv3hGBcCOSzoFqKwhvx4VJGTPF57oVgFb+gwyvFEqCyLQKNgOiOMhocgWM72xci6Aj4bk+/8BC379QZX4Y4tsqvLJSl2OInk8GNS7dHmhdbsNf5IazI7yCfG3AeKV0iVWdCBScVkBrK
x-ms-exchange-antispam-messagedata: sG0dM+a7w0IxB9EFttip+ieEsviPVHca6t9zn3VBDMvpICOLB1kFhBKvH/io7kLT6z1qjtpr9T5XU1D84EnQhW2bVqPqieb+ikxgwubOBnFp6GLIxnXOiacWNkTgSrJ5LLmYWnqqPmAVuh1cCmvS0g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fed6d0-fe53-4988-fb99-08d7e2b4e451
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 09:51:24.7114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZXRTGCjaX3jwag6yHBAkx5/gpdyBLqClFmVytxcPSzlHJl7/zpbx2gNa3JZ9VUhsuCjKXozTaEAdh8QRfJXh8kpVdJo8qXjpZxzv8cedp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcgQXByaWwgMjAyMCAxMDoyNCwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+ID4gPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ID4NCj4gPiA+IERvIHlvdSB3YW50IHRvIGZhaWwgc2lsZW50bHkg
aGVyZT8NCj4gPg0KPiA+IFdlbGwgYW4gZXJyb3IgbWVzc2FnZSBpcyBwcmludGVkIGluIHRoZSBj
YWxsaW5nIGNvZGUsIHNvIGRpZG4ndCBmZWVsIGxpa2UgaXQNCj4gPiB3YXMgbmVjZXNzYXJ5IHRv
IGhhdmUgYWRkaXRpb25hbCBkZWJ1ZyBoZXJlLiBGZWx0IGxpa2UgYmxvYXQuDQo+IA0KPiBBcyBh
IHVzZXIsIEkgd291bGQgcHJlZmVyIGEgbW9yZSBzcGVjaWZpYyByZWFzb24uDQo+IA0KPiBUaHVz
LCBJIHdvdWxkIHByb3ZpZGUgYW4gZXJyb3IgbWVzc2FnZSBoZXJlIGFuZCBvbWl0IHRoZSBnZW5l
cmljIG9uZS4NCg0KSSBjYW4gdXBkYXRlIGFsdGhvdWdoIEknbGwgb2YgY291cnNlIHRoZW4gbmVl
ZCB0byBkbyBzaW1pbGFyIG1lc3NhZ2VzIGZvciB0aGUNCm90aGVyIGVycm9yIGxlZ3Mgb2YgdGhp
cyBmdW5jdGlvbi4gRldJVywgYXMgdGhpcyBpcyBvbmx5IGJlaW5nIGNhbGxlZCBvbmNlIGluDQp0
aGUgc2FtZSBmaWxlIHRoaXMgZXJyb3IgbGVnIG9mIGNvZGUgY3VycmVudGx5IGNhbiBuZXZlciBv
Y2N1ci4NCg0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtlbnVtIHsNCj4gPiA+ID4g
KwlEQTkwNjNfREVWX0lEX1JFRyA9IDAsDQo+ID4gPiA+ICsJREE5MDYzX1ZBUl9JRF9SRUcsDQo+
ID4gPiA+ICsJREE5MDYzX0NISVBfSURfUkVHUywNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4g
PiA+ID4gK3N0YXRpYyBpbnQgZGE5MDYzX2dldF9kZXZpY2VfdHlwZShzdHJ1Y3QgaTJjX2NsaWVu
dCAqaTJjLCBzdHJ1Y3QgZGE5MDYzDQo+ID4gPiAqZGE5MDYzKQ0KPiA+ID4gPiArew0KPiA+ID4g
PiArCWludCByZXQ7DQo+ID4gPiA+ICsJdTggYnVmW0RBOTA2M19DSElQX0lEX1JFR1NdOw0KPiA+
ID4NCj4gPiA+IFJlYWxseSBzbWFsbCBuaXQ6IENvdWxkIHlvdSByZXZlcnNlIHRoZXNlIHBsZWFz
ZS4NCj4gPg0KPiA+IFllcCwgYWdyZWVkLg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArCXJldCA9IGRh
OTA2M19pMmNfYmxvY2tyZWdfcmVhZChpMmMsIERBOTA2M19SRUdfREVWSUNFX0lELCBidWYsDQo+
ID4gPiA+ICsJCQkJICAgICAgIERBOTA2M19DSElQX0lEX1JFR1MpOw0KPiA+ID4gPiArCWlmIChy
ZXQgPCAwKSB7DQo+ID4gPg0KPiA+ID4gaWYgKHJldCkNCj4gPiA+DQo+ID4gPiBPciBiZXR0ZXIg
eWV0LCBhcyB0aGlzIGlzIGEgcmVhZCBmdW5jdGlvbiwgeW91IGNvdWxkIGp1c3QgcmV0dXJuDQo+
ID4gPiBpMmNfdHJhbnNmZXIoKSBhbmQgZG8gdGhlIGFwcHJvcHJpYXRlIGVycm9yIGNoZWNraW5n
IGhlcmUgKmluc3RlYWQqLg0KPiA+DQo+ID4gSSB0aGluayBnaXZlbiB0aGF0IHRoZSBmdW5jdGlv
biBoYW5kbGVzIGFsbCBvZiB0aGUgSTJDIHNwZWNpZmljIHN0dWZmIEknZCBwcmVmZXINCj4gPiBp
dCBiZSBrZXB0IHRoZXJlLiBMb2dpY2FsbHkgdGhhdCB0byBtZSBtYWtlcyBtb3JlIHNlbnNlLiBD
YW4gY2hhbmdlIHRoaXMgdG8NCj4gPiAnaWYgKHJldCknDQo+IA0KPiBZZXMsIG5vdCB0aGF0IEkg
dW5kZXJzdGFuZCB0aGUgbWVzc2FnZSBsZW5ndGggKDMpIGhhcyBtb3JlIGRvIHRvIHdpdGgNCj4g
dGhlIEkyQyBpbnRlcmFjdGlvbnMgKHJhdGhlciB0aGFuIGEgZGVyaXNpdmUgb2YgJ2NvdW50Jyks
IGl0IG1ha2VzDQo+IHNlbnNlIHRvIGhhbmRsZSB0aGF0IGluc2lkZSB0aGUgZnVuY3Rpb24uDQo+
IA0KPiBIb3dldmVyLCBpdCBkb2VzIHNlZW0gb2RkIHRvIGhhbmRsZSB0aGUgcmV0dXJuIHZhbHVl
IG9mIGEgKl9yZWFkKCkNCj4gZnVuY3Rpb24gaW4gdGhpcyB3YXkuICBUaGV5IHVzdWFsbHkgcmV0
dXJuIHRoZSBudW1iZXIgb2YgYnl0ZXMgcmVhZCwNCj4gd2hpY2ggaW4gdGhpcyBjYXNlIHdvdWxk
IGJlIERBOTA2M19DSElQX0lEX1JFR1MgKGNvdW50KSwgcmlnaHQ/DQoNCldlbGwgcmVnbWFwX2J1
bGtfcmVhZCBhbmQgcmVnbWFwX3JlYWQgcmV0dXJuIDAgZm9yIHN1Y2Nlc3MgYW5kIG5lZ2F0aXZl
IGZvcg0KZmFpbHVyZSBzbyBJJ2QgZGlzYWdyZWUgb24gdGhpcyBwYXJ0Lg0K
