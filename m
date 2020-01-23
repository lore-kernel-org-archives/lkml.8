Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E742020704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TV4nOYNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWOpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:45:33 -0500
Received: from mail-am6eur05on2116.outbound.protection.outlook.com ([40.107.22.116]:13249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgAWOpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:45:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie6al1RmL5nWswLTHQxrAKkHyWNhdd1KlBp9QkWsLdYIl4Si5yrU8oFJY03vB28iA6gXxj7tFypVZIuYwHmgZf1r18vZ7GMHIhmJ8mIz2YDvSDqNNYID0ILxlMV9+xkP5PrN4ngG0WVOTvN1K1h7V6k9xqGljoJhVl2j52MG/Vr3BQ7Sa487AK2rIXy9RTvjfYAL6JByMg6YumzX3R7H+opNjC0t00f40uHrbrDbJmWuW3KE1769An+GnvukjtCHSHVXQ6sgm1S2ldJMky8HGEIAL6rwx4+35pyVQjekooQWMEkBQfUHLA9vks+d+R0iMR7zKIofbLrpsw4gPh92Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFsGCrLedaPH7ntniz0lqgtuCFCWTxRCSv6KwxszsHc=;
 b=bC1/jfQf/nYyHTXafvppFc7c1T7t8rQCAck61/LZTjZbhkKm/WdD60Nj+nARKjC88hgP/KBw9w+CsvJPB+u+JRryWmd/mIb4+ZwKE0eMRElAxQ4L+b33yQj4iejY7M/EShGRSLHCd82Eccc4iV54P5WpVAhVvb+9BpiYmEZwRHv9Wgv71XvuIkDRyUuGP/kIjhCAW0xRaubTTLgsqDDb1l9RDbKY12hOS0/JQPheYpZ0+cpigGm1mvT/AaVIA+sfB7zegBdGdLgrvccZDylHI0mYd9nRkEBUyA8KBheqZsaq86lCjQ4FsdYyxbDTRF9Lvin4NcoJX7soyzvhvbUyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFsGCrLedaPH7ntniz0lqgtuCFCWTxRCSv6KwxszsHc=;
 b=TV4nOYNji4n0HJFRR/7q+AWDgXikL1tnBMzmy3FB57QiNH+o5cysbt9KoQWuF5qkQWWN81gxrCw8Yysy0Sb6ahJU2Fti/w7PXi3FvoLFtdn57tw+ar8BkzcP37paDG4IGBleiVSG14IxLyd5/ZYTIkIb8EpvxX0oll7llbJbjq4=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3338.eurprd02.prod.outlook.com (52.134.72.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Thu, 23 Jan 2020 14:45:28 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:45:28 +0000
Received: from [192.168.13.3] (213.112.138.4) by HE1P18901CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 23 Jan 2020 14:45:28 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: nattis 2: remove unnecessary include
Thread-Topic: [PATCH] ARM: dts: at91: nattis 2: remove unnecessary include
Thread-Index: AQHVvod43Bw201Hu2UKhmyhbyxCTNqf4em+A
Date:   Thu, 23 Jan 2020 14:45:28 +0000
Message-ID: <a0d80517-5528-8646-91c1-60a7c24511f9@axentia.se>
References: <20191229203503.336593-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20191229203503.336593-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-originating-ip: [213.112.138.4]
x-clientproxiedby: HE1P18901CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::29) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddfe978a-40c1-49a6-a0d1-08d7a012e3a2
x-ms-traffictypediagnostic: DB3PR0202MB3338:
x-microsoft-antispam-prvs: <DB3PR0202MB3338AF0CAA0CD68069F6FFC3BC0F0@DB3PR0202MB3338.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(39830400003)(346002)(189003)(199004)(26005)(508600001)(66476007)(66946007)(4326008)(66446008)(64756008)(66556008)(16526019)(53546011)(6486002)(36756003)(6916009)(2906002)(52116002)(186003)(956004)(2616005)(81166006)(4744005)(8936002)(54906003)(5660300002)(71200400001)(4001150100001)(31686004)(316002)(81156014)(8676002)(31696002)(86362001)(16576012);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3338;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SU5htzVeZCSH3UvBUWC6YWl/y1g7ntWcj/5LVk/Ulum/AovnzP5LIDKXYP0aZCifipg4qytMseabXkLPI4Be+nKcI9haCMNJFVFTS4xjeN30Cc2nVP+hIcSBRELhWBptTI7Uo9Jdjf9GeVKXC5USiHTxkQwk4MPw4cREfMsOMFE319p6U5ei2ZeJnO7ByHkap7OhEn3Ad7j4TFubnm4Dq/YNvd62B03RFiEcXl6kQ78YC+NCwGUoCEUqwrjlmaOaU2vmDY4AjEuG2L2q3zz9GSkILfFplXYAZnyTaKR3WtMGdMldz3bDiuwakmN10B3pkw9gfcmJnuC/ApD4bScNbu6uh+/vZIJwaXwqiFrCx7OvGi5Uq1WO+X7Nu3ET7C5aGhJ9Mn/lONi5KVrQHSI/1HteBx5fX77FqJJsvjHFW8LMrIIZNJ6/NgsyUy8GDoo/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95C48D244022944F9746CC17890F5003@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfe978a-40c1-49a6-a0d1-08d7a012e3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:45:28.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KysZujrL1/8uxUKfo5xRoZPV5lBgw++drh0slssKMy9Jq95KnHiMfJjllKMUVcp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMi0yOSAyMTozNSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IHNhbWE1ZDNf
bGNkLmR0c2kgaXMgYWxyZWFkeSBpbmNsdWRlZCBieSBzYW1hNWQzMS5kdHNpLCBpdHNlbGYgaW5j
bHVkZWQgYnkNCj4gYXQ5MS1saW5lYS5kdHNpLg0KDQpSaWdodCwgZ29vZCBjYXRjaC4NCg0KQWNr
ZWQtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQoNCkNoZWVycywNClBldGVyDQoN
CltTb3JyeSBmb3IgdGhlIGRlbGF5LCB0aGUgcGF0Y2ggd2FzIG1hcmtlZCBhcyBzcGFtIG92ZXIg
aGVyZSBhbmQgSSBmYWlsZWQgdG8NCm5vdGljZSBpdCB1bnRpbCBub3cuLi5dDQoNCj4gU2lnbmVk
LW9mZi1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
Pg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtbmF0dGlzLTItbmF0dGUtMi5kdHMg
fCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1uYXR0aXMtMi1uYXR0ZS0yLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtbmF0dGlzLTItbmF0dGUtMi5kdHMNCj4gaW5kZXggZjI0NTk0NGJkNWQ3
Li40ZjEyMzQ3N2U2MzEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtbmF0
dGlzLTItbmF0dGUtMi5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1uYXR0aXMt
Mi1uYXR0ZS0yLmR0cw0KPiBAQCAtOCw3ICs4LDYgQEANCj4gICAqLw0KPiAgL2R0cy12MS87DQo+
ICAjaW5jbHVkZSAiYXQ5MS1saW5lYS5kdHNpIg0KPiAtI2luY2x1ZGUgInNhbWE1ZDNfbGNkLmR0
c2kiDQo+ICAjaW5jbHVkZSAiYXQ5MS1uYXR0ZS5kdHNpIg0KPiAgDQo+ICAvIHsNCj4gDQoNCg==
