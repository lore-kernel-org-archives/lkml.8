Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CDF206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g+dboQR1";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tLtBP4w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGPQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:57:23 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:62320 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594918641; x=1626454641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A0/WJ/+sfINubFtPqhDEriIvYIVBkUz1TxROWxUL9Rw=;
  b=g+dboQR1JoR54FfS9kfhBpTM7mxpsJRE+vJBrj/Z1S3f922+NdLsl3vP
   uMgdFHcA10Z7AeqEvRs5q70Z4xpfxlOW6tQsksUHopJu0xgQwwKbSOyzr
   96oWr7bXRqIuhTI6yNEHwy0r9OcxzWPG/sPLzfj8YqOSsu43Yv0PNc9xt
   OOcSPpEzaBVQLE7rxpCDz69/63ZQTyUmnl9tkNR7gwjpGcQ/wDCyTbu2m
   MN7LI+0gH/GJjeEL45KDm8Z+OG4s7b6GvNQO8gptj5XmOnDN+EO+p5cSj
   BQIaVLlQS+iZP1A4aDWmYgcnDOyIwNjSlZOl0VWPj0DTnf3DXASQbpzde
   w==;
IronPort-SDR: CdI1HlxiT8fB7d4+Bh0g9Z3/EqEDjbJ/A+CaSe5d8GnfjZ37fta/pIC/OfDYyGsy3pyXlfN6kW
 9ZTGiqI/sIm0yvqYyYxaXEpqpznfmAQXe4XD93rlMofHdwueoM/jeCXSkA8ETja94gakXZYi6T
 9fiuOW4U/9F7CfFEXKGSdukG1y4y4G9VBktxsvX86Z4JvFY7mktMvCLuehkN/kDEyXryk1MA8X
 srYSUOtovQCnF94AZzSeMG9hD7af61YqniXXMkcbWVV6V0Ym1sLGWSIxHsv6WIc9efeHOf2Y+9
 WV0=
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="82126048"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 09:57:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 09:57:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 16 Jul 2020 09:57:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRirdTT7xba7xviR/YVvQSC+qoUu/lIBsrCpsYdIWmZwixmo01EFeEHcZwt5gY4rQTxjwM8MKSEt4BtK/2vikTPNHxS9ZXt83+3EgqHPcfTwFWOOPJ1DEYLj2G/SR9V26IRlcxox5ERhighE7jxk6X/NL8eA4B7Wqo66w1Gdk2yipedzIepf0GVEEzjS0Nl9nOExfcy15BubnS5L+cac/5R5kOHeDboniJBmM6Xln/BFY4IuUWraCAI2s5B0BvNYBoJdLdTnxsVq7zLTWbHhVF6TvpRRLNpDBcwW8n0jNWQCdqiNw9syGnQJbLftF6+wSL/U+SZTIler+0i+/Lm8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0/WJ/+sfINubFtPqhDEriIvYIVBkUz1TxROWxUL9Rw=;
 b=dh3w4A6SPe6EcWqsPNpWS2dYb8j8hFfYrOscr1K/3sU0i9rZD1aGjEk2lD85TIbCDT3ge4J9WTxENnRQJ9e9Mo3sYoW3pMjIMT1P15PGPp3p9mGsf94VBW4Vt1EaeJmaS2GtAcqKa2DO0kEULwFZP3Nna5uHG5kA5qunIdz1OqQ5bdsvRgqugCsx8fH+f1QVFZ8Ka2OG+9SNSmU3q/IZLnrCnuAuK/qk9g/WhnJv4g+Wq+lFU2faVM2WVG7+pAI/FjKrBnUUOrpTM1q/nCVj5nXlNlf6WzkwriU4pFFXZryGcWbTlpr8ziOV3B+3iYutYiLjPxU7pe8iMLvDTn1KNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0/WJ/+sfINubFtPqhDEriIvYIVBkUz1TxROWxUL9Rw=;
 b=tLtBP4w928jncJtgn8L/0OlY+ioE4b7ehNftm39t3ZNdJxIj8xNuWG8jP88Z2+vBPPoJ2anA5XkG9s0rzu9ibNoVOyep4INONSb4LNPJG5M66rqiLv1VxdfNz8t+O9iZCP/sR1UnGDzyNAgSed2wsd3rFQFGEriFgsRx1gR4Oi8=
Received: from SN6PR11MB3504.namprd11.prod.outlook.com (2603:10b6:805:d0::17)
 by SN6PR11MB2719.namprd11.prod.outlook.com (2603:10b6:805:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 16:57:18 +0000
Received: from SN6PR11MB3504.namprd11.prod.outlook.com
 ([fe80::851c:67fc:a034:9ea0]) by SN6PR11MB3504.namprd11.prod.outlook.com
 ([fe80::851c:67fc:a034:9ea0%4]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 16:57:18 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 11/19] clk: at91: clk-generated: pass the id of changeable
 parent at registration
Thread-Topic: [PATCH 11/19] clk: at91: clk-generated: pass the id of
 changeable parent at registration
Thread-Index: AQHWWpqmLj3AWsaxS0Wt27tY+1cwjqkKbx2A
Date:   Thu, 16 Jul 2020 16:57:18 +0000
Message-ID: <bb3a3aac-c513-9f8c-975d-0bfddaa61bfc@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-12-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1594812267-6697-12-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [84.232.220.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: becef67c-7deb-4368-3f98-08d829a94cdf
x-ms-traffictypediagnostic: SN6PR11MB2719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB27198322E188F5903E8688EDE77F0@SN6PR11MB2719.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoqt3qMEfwYEe/bklOpFjYhU8tefzlLapCHCzLquD3kX42HYBW8FxXbgoeEJZOhEZRiEtc9h/ACn9mS7ljJN5BjII2o3wsVsRHfCdQf9CoFfoaTD4QurVqEC/nM0GudE0hqYsQTG1TkYngDGdVlnhSzDcJ6RfUtYYA14OvqX8CBkTPccWY3oMYQUdkoxQrPVSJfdBtpx0kAQ8gZRPBCheRrdGWHiYUAlREN10+9bdqQ/OhICxxksi912Cp+E5BR+Xj4EjIG5d+/fhIooUnf9QTRCXnIZctJzg3murtRY3gpxYtwgzlEQvBxVyLHJsdZoQDpQVE+y6T81k5qHL7qErFjhkxptrze0A7rmHX9ajp3yEg96iDSyZa+fnGnB9p7d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3504.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(39860400002)(376002)(64756008)(8676002)(53546011)(6506007)(478600001)(110136005)(66556008)(91956017)(66446008)(66476007)(36756003)(54906003)(316002)(4326008)(8936002)(71200400001)(66946007)(76116006)(31686004)(6512007)(26005)(6486002)(86362001)(83380400001)(6636002)(31696002)(2616005)(2906002)(186003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SCdIYo/fY7R+KIiDfKa9KX1TBEzQ50dEoElBLA+gFt5sXwxAL0LgNFrL/4mq7CAAEqTlfL5kwJBi64liWkNYEQ0+txoeuZRwH4nST8SK5MOF55qsnRR9Chh2qsu3V7x5Bkg20QV6ndY37uJRc3yr9NXWMaQV4Yw3SktD4VDIq7Rk/NFf+OuPLr2JKatE06o020vOG5dkwEIcWxz09PJBXl2FFwr+BFYmJ6mUFHO/ds4Vla9t+YVvI4o9uI21oJsVC/XIOReJSgWdR4OPb5IlIFrZaB6hhs9HRBooFWmawrul4e8YUFsUPD45YYSuDK0ot3ozN8Cwq0LTdnsirb4i4E6QqIIU2IzzWS4GVlZ1cpWns9DwQ8+P1kX/L/Gr7Z/97IZFuF+dCpmN/hfpDC49TVD6bdgSMabsaWQOWQxCaIoQe/V+jrmDC6B+A1YgYYeQjroDTh6cK/Z1AJI217KVfHdO1CLhGNo99XsYvrprl1toSfX/Wp5xf5isnFw+xDCE
Content-Type: text/plain; charset="utf-8"
Content-ID: <17256814E676D24FABF11043D270CA34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3504.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becef67c-7deb-4368-3f98-08d829a94cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 16:57:18.7207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFe9MBwhLsuXROngF6Az7ETv3NeTXSxPLuGLw88MsZufcRb+HhD0SnHJ5606PUy8xCvHS5i6GMNWsSKTKveuMfEJ8EtjKY/X9QKp8VJjy38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2xhdWRpdSwNCg0KT24gMTUuMDcuMjAyMCAxNDoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6
DQo+IFBhc3MgdGhlIElEIG9mIGNoYW5nZWFibGUgcGFyZW50IGF0IHJlZ2lzdHJhdGlvbi4gVGhp
cyB3aWxsIGFsbG93DQo+IHRoZSBzY2FsYWJpbGl0eSBvZiB0aGlzIGNsb2NrIGRyaXZlciB3aXRo
IHJlZ2FyZHMgdG8gdGhlIGNoYW5nZWFibGUNCj4gcGFyZW50IElEIGZvciB2ZXJzaW9ucyBvZiB0
aGlzIElQIHdoZXJlIGNoYW5nZWFibGUgcGFyZW50IGlzIG5vdCB0aGUNCj4gbGFzdCBvbmUgaW4g
dGhlIHBhcmVudHMgbGlzdCAoZS5nLiBTQU1BN0c1KS4gSW4NCj4gY2xrX2dlbmVyYXRlZF9iZXN0
X2RpZmYoKSB0aGUgKmJlc3RfZGlmZiB2YXJpYWJsZSBpcyBjaGVjayBhZ2FpbnN0DQo+IHRtcF9k
aWZmIHZhcmlhYmxlIHVzaW5nICI+PSIgb3BlcmF0b3IgaW5zdGVhZCBvZiAiPiIgc28gdGhhdCBp
biBjYXNlDQo+IHRoZSByZXF1ZXN0ZWQgZnJlcXVlbmN5IGNvdWxkIGJlIG9idGFpbmVkIHVzaW5n
IGZpeCBwYXJlbnRzICsgZ2NrDQo+IGRpdmlkZXJzIGJ1dCB0aGUgY2xvY2sgYWxzbyBzdXBwb3J0
cyBjaGFuZ2VhYmxlIHBhcmVudCB0byBiZSBhYmxlDQo+IHRvIGZvcmNlIHRoZSB1c2FnZSBvZiB0
aGUgY2hhbmdlYWJsZSBwYXJlbnQuDQoNClRoaXMgaXMgYSBncmVhdCBmZWF0dXJlIQ0KDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMgfCAyNiAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvY2xrL2F0OTEvZHQtY29tcGF0
LmMgICAgIHwgIDggKysrKystLS0NCj4gICBkcml2ZXJzL2Nsay9hdDkxL3BtYy5oICAgICAgICAg
ICB8ICA0ICsrLS0NCj4gICBkcml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAuYyAgICAgICB8ICAzICst
LQ0KPiAgIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jICAgICAgIHwgMzEgKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygr
KSwgMzUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9j
bGstZ2VuZXJhdGVkLmMgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1nZW5lcmF0ZWQuYw0KPiBpbmRl
eCAyNDQ4YmRjNjM0MjUuLmY5Y2EwNGM5NzEyOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsv
YXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJh
dGVkLmMNCj4gQEAgLTE4LDggKzE4LDYgQEANCj4gICANCj4gICAjZGVmaW5lIEdFTkVSQVRFRF9N
QVhfRElWCTI1NQ0KPiAgIA0KPiAtI2RlZmluZSBHQ0tfSU5ERVhfRFRfQVVESU9fUExMCTUNCj4g
LQ0KPiAgIHN0cnVjdCBjbGtfZ2VuZXJhdGVkIHsNCj4gICAJc3RydWN0IGNsa19odyBodzsNCj4g
ICAJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPiBAQCAtMjksNyArMjcsNyBAQCBzdHJ1Y3QgY2xr
X2dlbmVyYXRlZCB7DQo+ICAgCXUzMiBnY2tkaXY7DQo+ICAgCWNvbnN0IHN0cnVjdCBjbGtfcGNy
X2xheW91dCAqbGF5b3V0Ow0KPiAgIAl1OCBwYXJlbnRfaWQ7DQo+IC0JYm9vbCBhdWRpb19wbGxf
YWxsb3dlZDsNCj4gKwlpbnQgY2hnX3BpZDsNCj4gICB9Ow0KPiAgIA0KPiAgICNkZWZpbmUgdG9f
Y2xrX2dlbmVyYXRlZChodykgXA0KPiBAQCAtMTA5LDcgKzEwNyw3IEBAIHN0YXRpYyB2b2lkIGNs
a19nZW5lcmF0ZWRfYmVzdF9kaWZmKHN0cnVjdCBjbGtfcmF0ZV9yZXF1ZXN0ICpyZXEsDQo+ICAg
CQl0bXBfcmF0ZSA9IHBhcmVudF9yYXRlIC8gZGl2Ow0KPiAgIAl0bXBfZGlmZiA9IGFicyhyZXEt
PnJhdGUgLSB0bXBfcmF0ZSk7DQo+ICAgDQo+IC0JaWYgKCpiZXN0X2RpZmYgPCAwIHx8ICpiZXN0
X2RpZmYgPiB0bXBfZGlmZikgew0KPiArCWlmICgqYmVzdF9kaWZmIDwgMCB8fCAqYmVzdF9kaWZm
ID49IHRtcF9kaWZmKSB7DQo+ICAgCQkqYmVzdF9yYXRlID0gdG1wX3JhdGU7DQo+ICAgCQkqYmVz
dF9kaWZmID0gdG1wX2RpZmY7DQo+ICAgCQlyZXEtPmJlc3RfcGFyZW50X3JhdGUgPSBwYXJlbnRf
cmF0ZTsNCj4gQEAgLTEyOSw3ICsxMjcsMTAgQEAgc3RhdGljIGludCBjbGtfZ2VuZXJhdGVkX2Rl
dGVybWluZV9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LA0KPiAgIAlpbnQgaTsNCj4gICAJdTMyIGRp
djsNCj4gICANCj4gLQlmb3IgKGkgPSAwOyBpIDwgY2xrX2h3X2dldF9udW1fcGFyZW50cyhodykg
LSAxOyBpKyspIHsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgY2xrX2h3X2dldF9udW1fcGFyZW50cyho
dyk7IGkrKykgew0KPiArCQlpZiAoZ2NrLT5jaGdfcGlkID09IGkpDQo+ICsJCQljb250aW51ZTsN
Cj4gKw0KDQpPbmUgdGhpbmcgdGhhdCB0aGUgcHJldmlvdXMgbG9vcCB3YXMgcHJldmVudGluZyB3
YXMgdG8gbm90IGFsbG93IG90aGVyIA0KZ2NrcyB0YWtlIGNsa19od19nZXRfbnVtX3BhcmVudHMo
aHcpIC0gMSBhcyBhIHBhcmVudC4gU28gdGhlIGF1ZGlvIHBsbCANCihsYXN0IG9uZSkgd2FzIHJl
c2VydmVkIGZvciB0aGUgZ2NrIG9mIHRoZSBhdWRpbyBwZXJpcGhlcmFscyBvbmx5LiBXaXRoIA0K
dGhpcyBjaGFuZ2UsIGFueSBwZXJpcGhlcmFsIGNhbiB1c2UgY2hnX3BpZCBhcyBhIHBhcmVudCwg
cHJldmVudGluZyB0aHVzIA0KaXRzIGNvcnJlY3QgdXNlIGJ5IHRoZSBwZXJpcGhlcmFscyB0aGF0
IGNhbiBhY3R1YWxseSBuZWVkIGFuZCBjaGFuZ2UgdGhlIA0KcmF0ZSBvZiBjaGdfcGlkLg0KDQo+
ICAgCQlwYXJlbnQgPSBjbGtfaHdfZ2V0X3BhcmVudF9ieV9pbmRleChodywgaSk7DQo+ICAgCQlp
ZiAoIXBhcmVudCkNCj4gICAJCQljb250aW51ZTsNCj4gQEAgLTE2MSwxMCArMTYyLDEwIEBAIHN0
YXRpYyBpbnQgY2xrX2dlbmVyYXRlZF9kZXRlcm1pbmVfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywN
Cj4gICAJICogdGhhdCB0aGUgb25seSBjbGtzIGFibGUgdG8gbW9kaWZ5IGdjayByYXRlIGFyZSB0
aG9zZSBvZiBhdWRpbyBJUHMuDQo+ICAgCSAqLw0KDQpUaGUgYWJvdmUgY29tbWVudCBzaG91bGQg
YmUgdXBkYXRlZC4NCg0KPiAgIA0KPiAtCWlmICghZ2NrLT5hdWRpb19wbGxfYWxsb3dlZCkNCj4g
KwlpZiAoZ2NrLT5jaGdfcGlkIDwgMCkNCj4gICAJCWdvdG8gZW5kOw0KDQpCZXN0IHJlZ2FyZHMs
DQpDb2RyaW4NCg==
