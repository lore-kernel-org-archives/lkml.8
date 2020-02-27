Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3619C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B02468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=camlinlimited.onmicrosoft.com header.i=@camlinlimited.onmicrosoft.com header.b="XVHx+5OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgB0LJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:09:54 -0500
Received: from mail-eopbgr110042.outbound.protection.outlook.com ([40.107.11.42]:56623
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726813AbgB0LJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:09:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUB++LULOij4pQJFGuwwD5i4mBQNmzt9NrDigw4CXMwFV6kZIRY4DR9BOisjelcbmrFOknNb4mYW4JJb1PCC0PznGpI2S+6R15xiytYLNbsmj42US0vrWucRx9l4flntkmI5qDqIQBdKj8es9TRRhlEDWEzcxNhCoK+RYAUlc3bPG2tZFtfaZ8moRrRUSDl8P2YzxTOFrj7smKxaoFFtMm26RO/MRjaIVeaGvEXdnsMqqihCjCMc8fEWbsNXGxjh3tkiyobEDKJa+jb9BsbNH76IJeQ6P7egFtL7E12PiLLlYAp3w9n/qr5DJl7wWRu/V1KZE/TFLMzfAgYZlnNyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn1BLn/I8XG54p4qvPDNlI6pBN2rL4801KSwYKIDyDo=;
 b=AnPFyhWmvGPh990tFIkYFHeX/O0wWg5r0rG2KigFqYMl6R1FEayXyjAIiVZsbnKmW9j5gD2oVlO1kTHuBYMmB9Bg4Z2UoAsQthQOaRM3JH9oKddue4GdpdHXQ1K9W+evAJAjSfhhQ/Y+h2qlZ7r+SYR4xKKwWTedAL/JkZwZRqu5t2YRmP1rSSmaU3wq8qeLuj8aYnL36Mw1d2U8w9B2SrLqrdnLKzRykfnB00rw/EICc4lJiyWIPfUsCTA2LNVFyhqW7LqWoxJQiiRjHMvtmMJIETJPGeAqH8VbKOxXodYkT6+7/w/2++Fp3qfTH/0uhO618ixh25fCpHYmnZvWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=camlintechnologies.com; dmarc=pass action=none
 header.from=camlintechnologies.com; dkim=pass
 header.d=camlintechnologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=camlinlimited.onmicrosoft.com; s=selector2-camlinlimited-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn1BLn/I8XG54p4qvPDNlI6pBN2rL4801KSwYKIDyDo=;
 b=XVHx+5OFDQR7jjkaaGE9Q2Tj9EAewVuLCM9r1cOyu4afuDQPVaZxZ6EfHrsbHZ+MX2OlrWZ9C/FwKDFmsIsapKUc8r3Oi5jYmdcEaEoFyQHX723ZWLeAaZCheP05Z7radERNAl0RI8HUxszNbNjoPvcsf5LBUr6jOtDFmDG7ynk=
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM (20.176.61.151) by
 CWLP123MB2257.GBRP123.PROD.OUTLOOK.COM (20.176.62.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 11:09:50 +0000
Received: from CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78]) by CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 ([fe80::fc9c:3a7e:f857:3c78%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 11:09:49 +0000
Received: from [192.168.10.194] (95.143.242.242) by ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 11:09:49 +0000
From:   Lech Perczak <l.perczak@camlintechnologies.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     =?utf-8?B?S3J6eXN6dG9mIERyb2JpxYRza2k=?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>
Subject: Regression in v4.19.106 breaking waking up of readers of /proc/kmsg
 and /dev/kmsg
Thread-Topic: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Thread-Index: AQHV7V5tbBfGfem9XEK90Lf/mGAlSA==
Date:   Thu, 27 Feb 2020 11:09:49 +0000
Message-ID: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:6d::23)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=l.perczak@camlintechnologies.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.143.242.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 699c999c-0d23-44e1-765f-08d7bb758fd4
x-ms-traffictypediagnostic: CWLP123MB2257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP123MB22578EF758ED59138A24FBFA87EB0@CWLP123MB2257.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(136003)(366004)(189003)(199004)(36756003)(66446008)(64756008)(478600001)(5660300002)(6486002)(66476007)(66556008)(66946007)(2906002)(107886003)(86362001)(52116002)(2616005)(26005)(956004)(186003)(16526019)(71200400001)(81156014)(8936002)(8676002)(81166006)(110136005)(54906003)(4326008)(16576012)(316002)(31686004)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CWLP123MB2257;H:CWLP123MB2209.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: camlintechnologies.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIZ6i0huk72pNHPONkOyNOVu+fv9QYTDGVrmFfjMgh6Asw0F4Pj70HzMw5hVHYhJ4t/BeUei1fkayJQhf/fu80jrlizHWtvnekhby0qvxovNfX29y0iPfr93Gu/kbjR2gfUzFqAiFtH93KQw7ucO4WhVx5r+ct2KaUXkBIG5hWLUucDbWIS6TlT4x8zSRVg+UWkk2oDNVb63vwOdC6BrjM6ByTvy6HsNZDa7+AJd5Za3UmURzqW7WPPjkoXdXQs0ozS2NoSW/ryP/mp/VEGtY7UhZk1k5i6wgkgc6l6httrfnWexhyki/JTPbkrElshJMwcpahss3/8aKCnVgg7U71NB6i5wKtUcVyQ0s1eKHgO7JbCGEe63bpM1D5oHcI9UEHQ3fwjgqqnmL46gIg67dAf+6zib//VoIGbsUbRzHg3iS62WEEdC9rVSBoq2/gvO
x-ms-exchange-antispam-messagedata: Up5hZ8WIiYNiBphcE6Ti5TFpnACBRLX1JY74ZExYUsSsQsz6S8SFFw9mfqpp/ktg9TA6odWtwi/dITuLtK0+REdhmZI9QGcadYCtteP1+4GvkwNOyak54zXoIgVuy9JcDwGBOL3FPMdxX4vDHt80zA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <334BA7AF7B2374469C95FF0E11F7E12C@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: camlintechnologies.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699c999c-0d23-44e1-765f-08d7bb758fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:09:49.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uxqc8BZAX/TMpf/8AqFva1TZ2jM4Rk9sLt+hTZGoH+7T/Wg6zINFrpE1oQDqJGM9nXZx1DXapBhV2G7vyWGULLRkvI3TQLl7S0zdFnwmaCFwDcD0B5n2JMKkHZt0yOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkFmdGVyIHVwZ3JhZGluZyBrZXJuZWwgb24gb3VyIGJvYXJkcyBmcm9tIHY0LjE5
LjEwNSB0byB2NC4xOS4xMDYgd2UgZm91bmQgb3V0IHRoYXQgc3lzbG9nIGZhaWxzIHRvIHJlYWQg
dGhlIG1lc3NhZ2VzIGFmdGVyIG9uZXMgcmVhZCBpbml0aWFsbHkgYWZ0ZXIgb3BlbmluZyAvcHJv
Yy9rbXNnIGp1c3QgYWZ0ZXIgYm9vdGluZy4NCkkgYWxzbyBmb3VuZCBvdXQsIHRoYXQgb3V0cHV0
IG9mICdkbWVzZyAtLWZvbGxvdycgYWxzbyBkb2Vzbid0IHJlYWN0IG9uIG5ldyBwcmludGtzIGFw
cGVhcmluZyBmb3Igd2hhdGV2ZXIgcmVhc29uIC0gdG8gcmVhZCBuZXcgbWVzc2FnZXMsIHJlb3Bl
bmluZyAvcHJvYy9rbXNnIG9yIC9kZXYva21zZyB3YXMgbmVlZGVkLg0KSSBiaXNlY3RlZCB0aGlz
IGRvd24gdG8gY29tbWl0IDE1MzQxYjFkZDQwOTc0OWZhNTYyNWU0YjYzMjAxM2I2YmE4MTYwOWIg
KCJjaGFyL3JhbmRvbTogc2lsZW5jZSBhIGxvY2tkZXAgc3BsYXQgd2l0aCBwcmludGsoKSIpLCBh
bmQgcmV2ZXJ0aW5nIGl0IG9uIHRvcCBvZiB2NC4xOS4xMDYgcmVzdG9yZWQgY29ycmVjdCBiZWhh
dmlvdXIuDQoNCk15IHRlc3Qgc2NlbmFyaW8gZm9yIGJpc2VjdGluZyB3YXM6DQoxLiBydW4gJ2Rt
ZXNnIC0tZm9sbG93JyBhcyByb290DQoyLiBydW4gJ2VjaG8gdCA+IC9wcm9jL3N5c3JxLXRyaWdn
ZXInDQozLiBJZiB0cmFjZSBhcHBlYXJzIGluIGRtZXNnIG91dHB1dCAtPiBnb29kLCBvdGhlcndp
c2UsIGJhZC4gSWYgdHJhY2UgZG9lc24ndCBhcHBlYXIgaW4gb3V0cHV0IG9mICdkbWVzZyAtLWZv
bGxvdycsIHJlLXJ1bm5pbmcgaXQgd2lsbCBzaG93IHRoZSB0cmFjZS4NCg0KSSByYW4gbXkgdGVz
dHMgb24gRGViaWFuIDEwLjMgd2l0aCBjb25maWd1cmF0aW9uIGJhc2VkIGRpcmVjdGx5IG9uIG9u
ZSBmcm9tIDQuMTkuMC04LWFtZDY0ICg0LjE5Ljk4LTEpIGluIFFlbXUuDQpJIGNvdWxkIHJlcHJv
ZHVjZSB0aGUgc2FtZSBpc3N1ZSBvbiBzZXZlcmFsIGJvYXJkcyB3aXRoIHg4NiBhbmQgQVJNdjcg
Q1BVcyBhbGlrZSwgd2l0aCAxMDAlIHJlcHJvZHVjaWJpbGl0eS4NCg0KSSBoYXZlbid0IHlldCBk
aWdnZWQgaW50byB3aHkgZXhhY3RseSB0aGlzIGNvbW1pdCBicmVha3Mgbm90aWZpY2F0aW9ucyBm
b3IgcmVhZGVycyBvZiAvcHJvYy9rbXNnIGFuZCAvZGV2L2ttc2csIGJ1dCBhcyByZXZlcnRpbmcg
aXQgZml4ZWQgdGhlIGlzc3VlLCBJJ20gcHJldHR5IHN1cmUgdGhpcyBpcyB0aGUgb25lLiBJdCBp
cyBwb3NzaWJsZSB0aGF0IHRoZSBzYW1lIGhhcHBlbmVkIGluIDUuNCBsaW5lLCBidSBJIGhhZG4n
dCBoYWQgYSBjaGFuY2UgdG8gdGVzdCB0aGlzIGFzIHdlbGwgeWV0Lg0KDQpGb3IgcmVmZXJlbmNl
LCBoZXJlIGlzIG15IGJpc2VjdCBsb2c6DQpnaXQgYmlzZWN0IHN0YXJ0DQojIGJhZDogW2YyNTgw
NGYzODk4NDY4MzU1MzVkYjI1NWU3YmE4MGVlZWQ5NjdlZDddIExpbnV4IDQuMTkuMTA2DQpnaXQg
YmlzZWN0IGJhZCBmMjU4MDRmMzg5ODQ2ODM1NTM1ZGIyNTVlN2JhODBlZWVkOTY3ZWQ3DQojIGdv
b2Q6IFs0ZmNjYzI1MDM1MzZhNTY0YTRiYTMxYTFkNTA0Mzk4NTQyMDE2NTlmXSBMaW51eCA0LjE5
LjEwNQ0KZ2l0IGJpc2VjdCBnb29kIDRmY2NjMjUwMzUzNmE1NjRhNGJhMzFhMWQ1MDQzOTg1NDIw
MTY1OWYNCiMgYmFkOiBbYWVjNDhkOGQwZTZlMjkxZjYxZDBhMDc0MWJlZjJmOGNjMDcxMjU4NF0g
Y2xrOiB1bmlwaGllcjogQWRkIFNDU1NJIGNsb2NrIGdhdGUgZm9yIGVhY2ggY2hhbm5lbA0KZ2l0
IGJpc2VjdCBiYWQgYWVjNDhkOGQwZTZlMjkxZjYxZDBhMDc0MWJlZjJmOGNjMDcxMjU4NA0KIyBi
YWQ6IFs1ZmU2OWQyYmEwOGY1MTZhY2U2NDk2ZDQwYWM0N2ZlMzNkM2Q0ZWM3XSBLVk06IHMzOTA6
IEVOT1RTVVBQIC0+IEVPUE5PVFNVUFAgZml4dXBzDQpnaXQgYmlzZWN0IGJhZCA1ZmU2OWQyYmEw
OGY1MTZhY2U2NDk2ZDQwYWM0N2ZlMzNkM2Q0ZWM3DQojIGJhZDogWzE1MzQxYjFkZDQwOTc0OWZh
NTYyNWU0YjYzMjAxM2I2YmE4MTYwOWJdIGNoYXIvcmFuZG9tOiBzaWxlbmNlIGEgbG9ja2RlcCBz
cGxhdCB3aXRoIHByaW50aygpDQpnaXQgYmlzZWN0IGJhZCAxNTM0MWIxZGQ0MDk3NDlmYTU2MjVl
NGI2MzIwMTNiNmJhODE2MDliDQojIGdvb2Q6IFtiOWRjNGQ2MWI1YzJkOGVhMjg5MDg3ZjU3ODk4
NDI2MDE3NDMxMzkxXSBjcHUvaG90cGx1Zywgc3RvcF9tYWNoaW5lOiBGaXggc3RvcF9tYWNoaW5l
IHZzIGhvdHBsdWcgb3JkZXINCmdpdCBiaXNlY3QgZ29vZCBiOWRjNGQ2MWI1YzJkOGVhMjg5MDg3
ZjU3ODk4NDI2MDE3NDMxMzkxDQojIGdvb2Q6IFtlNWM4ZDQ5YjliZTA0MDgwZjVhYWI2N2VhMzZh
YzY1YTMwNzU4NDQyXSBwaW5jdHJsOiBzaC1wZmM6IHNoNzI2NDogRml4IENBTiBmdW5jdGlvbiBH
UElPcw0KZ2l0IGJpc2VjdCBnb29kIGU1YzhkNDliOWJlMDQwODBmNWFhYjY3ZWEzNmFjNjVhMzA3
NTg0NDINCiMgZ29vZDogWzY3ZjdmMGM3ZTlmNGE2YzUyMTVlNzg3MjgyNjFiMWQ0YWI1N2RjYzZd
IHBvd2VycGMvcG93ZXJudi9pb3Y6IEVuc3VyZSB0aGUgcGRuIGZvciBWRnMgYWx3YXlzIGNvbnRh
aW5zIGEgdmFsaWQgUEUgbnVtYmVyDQpnaXQgYmlzZWN0IGdvb2QgNjdmN2YwYzdlOWY0YTZjNTIx
NWU3ODcyODI2MWIxZDRhYjU3ZGNjNg0KIyBnb29kOiBbNDgwMmIyNTdkMzUyZTQ4YTBiMTA4ODZi
MmQxYTEyYjM2NmExN2M0OF0gaW9tbXUvdnQtZDogRml4IG9mZi1ieS1vbmUgaW4gUEFTSUQgYWxs
b2NhdGlvbg0KZ2l0IGJpc2VjdCBnb29kIDQ4MDJiMjU3ZDM1MmU0OGEwYjEwODg2YjJkMWExMmIz
NjZhMTdjNDgNCiMgZmlyc3QgYmFkIGNvbW1pdDogWzE1MzQxYjFkZDQwOTc0OWZhNTYyNWU0YjYz
MjAxM2I2YmE4MTYwOWJdIGNoYXIvcmFuZG9tOiBzaWxlbmNlIGEgbG9ja2RlcCBzcGxhdCB3aXRo
IHByaW50aygpDQoNCi0tIA0KUG96ZHJhd2lhbS9XaXRoIGtpbmQgcmVnYXJkcywNCkxlY2ggUGVy
Y3phaw0KDQpTci4gU29mdHdhcmUgRW5naW5lZXINCkNhbWxpbiBUZWNobm9sb2dpZXMgUG9sYW5k
IExpbWl0ZWQgU3AuIHogby5vLg0KDQo=
