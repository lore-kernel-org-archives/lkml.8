Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675AAC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C820714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Uu8Wd33S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgC2SBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:01:33 -0400
Received: from mail-eopbgr60130.outbound.protection.outlook.com ([40.107.6.130]:26241
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727726AbgC2SBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgGU4wfXBexOIHDOr5yQWuHE19iKbdrT3KeGzZzlMcYXFhztbLDPRFSKXhfke/NeAfqW8nKivO9FYjJQNpELdAS4NsfyQmeZMUVPIqbD53a6ATjUEueNyGDb+kwPqUHZZSSvDYw/ZHvd1AnAd++JzVle/iWXOZzFH3zmotd4piXTiabzN3YxFxhBgdkVdf1xeWdB70Vyh2AsnZNp7Se66zzeq003XZhI/R9WfuzPVoAMTG0w5fw2ef1hr13pcmL61TsC7Afk7YRZ+xDsPFejq0LOXE25OSmRjSrn8bBDZ3VcNK/O2WShPaTfZlcDpaMolTchrR2cK8GT/sQ0zBf5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fibUIJuw84xDoEot7hkB0MjQfe4KDtirgZu/v+ng1Lo=;
 b=ADjgAbil1eT6P80FTNjo9skmEDmvS8VwTOSie90a24ZAVp6KElW54ax4y2yO1AS7oS4P3zVOPJ652yLKzMd/d+4zV6hgtLg7CCY2WqmR/D+NwWUSJ3itn2pY5FG934EMWfOfoeIQSYoPxYTmDmfa6HX66d5Gjc14pyxftvFDrxr5+LKStvt5d0XG/XhaR+rjs/Rln9dMOLclxHR0dfq2lpA49iprbIleCgKP3YsxD7DnHpqkVKF1SeQAgiXmMH3b4jU1vpbczafjlWY9mfPXbr/HGosWr8amx01ZPCAZOXO7ck3jFLxuzs2N+7X5km8kWBx2jvReOG9mhcWK7CU6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fibUIJuw84xDoEot7hkB0MjQfe4KDtirgZu/v+ng1Lo=;
 b=Uu8Wd33SoZFK2gVVMRUBv6EByFbpO0en4KIVdvlzdrF3MKZmy1h6AjHR04HCcTdrlCDv68Z2JWD0lPFmd3JiEueEFis/PUNmZwbfn67gY5nil0IAB1VT7tFrCJf0aL97f+jIl66ZYscSrYRYRXb6cuNkjDuelpkOBoiSM7KSaLg=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB4129.eurprd02.prod.outlook.com (20.177.43.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Sun, 29 Mar 2020 18:01:29 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::4448:48ca:9345:37b5%3]) with mapi id 15.20.2856.019; Sun, 29 Mar 2020
 18:01:29 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: update firmware definitions
Thread-Topic: [PATCH] habanalabs: update firmware definitions
Thread-Index: AQHWBSmWLyXZXWovDkK9JLQAl15UTahf3NLw
Date:   Sun, 29 Mar 2020 18:01:29 +0000
Message-ID: <AM0PR02MB552396E21E7A4D75DAC2D814B8CA0@AM0PR02MB5523.eurprd02.prod.outlook.com>
References: <20200328175157.29308-1-oded.gabbay@gmail.com>
In-Reply-To: <20200328175157.29308-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.15.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6604b55b-4faf-4cc8-f275-08d7d40b3525
x-ms-traffictypediagnostic: AM0PR02MB4129:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR02MB412986C13574756252C5ADE8B8CA0@AM0PR02MB4129.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(136003)(346002)(39840400004)(376002)(4326008)(316002)(2906002)(6636002)(8676002)(53546011)(26005)(66556008)(64756008)(66446008)(6506007)(110136005)(8936002)(81156014)(81166006)(4744005)(478600001)(33656002)(71200400001)(7696005)(52536014)(66476007)(55016002)(86362001)(9686003)(66946007)(186003)(5660300002)(76116006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqbCCiu5R/muAyQX545gXFyUlP3PCuRgvLtpMj9LSSFlMEu/Epne6v1UjOb3lClv2qZFD7W2bfhutNfxf+oyIXllOprFi2uTRKMtEyHiSYi4ya2HrCpFdO441y8+LHNQ2NK6uRijAAtsp/7HCM3LNqMCaBa+SiTqmkAtkdKeDiFEtN7ZUQDho4icPI+zlguoSmmzv2tUcSnPM3pTRj+z0k/8AQuIgIARy9t9Mb9+10sObOn0Ky2zsTg9MhpKgALbzh5sHSg0/Dkjn47w3lhM6XhmqkHvIuqY4FjfSQGgRMMtWXOKWMFv9+7FTt999UXJNkXH8b7Lv9C0hJ4et2SZSV+tl4cbL0RGKmFz9FUczKbUz5XMTOTccYoWfS2TdFRNrPdnkeDUuL3tGva71j93QInd9oL37SrYUmLHu05j8rFnbGYwc6JeEt2h7LqaVkES
x-ms-exchange-antispam-messagedata: yKaRhlFk+flpGuNqyAq/PquL7tYMtks5yJmKN4DoYavAtoKTNOcpatMw+bmltB20X76YRk1tjUXh2RsHdJGiXkSNqg739XeQy0LtOXGN6XyuIeJEyNkFzGycye6wwKMvDOcLaFA1z35S9TzwkcpQtw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6604b55b-4faf-4cc8-f275-08d7d40b3525
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 18:01:29.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/LUljwYZe+p3zGGB8dYkrc0wFmn8p0YdMQsIbU2rVoe471V5mx7O5ss9is7FW2x0Bt4Ot4vZJ05XM1lWwleDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXIgMjgsIDIwMjAgYXQgODo1MiBQTSwgT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IEFkZCBjb21tZW50cyBmb3IgdGhlIHZhcmlvdXMgZXJyb3Jz
IGFuZCBzdGF0ZXMgb2YgdGhlIGZpcm13YXJlIGR1cmluZyBib290Lg0KPiBBZGQgYSBtYXBwaW5n
IG9mIGEgbmV3IHJlZ2lzdGVyIHRoYXQgd2lsbCB0ZWxsIHRoZSBkcml2ZXIgd2hldGhlciB0aGUg
ZmlybXdhcmUNCj4gZXhlY3V0ZWQgdGhlIHJlcXVlc3QgZnJvbSB0aGUgZHJpdmVyIG9yIGlmIGl0
IGhhcyBlbmNvdW50ZXJlZCBhbiBlcnJvci4NCj4gQWRkIGEgbmV3IGVudW0gZm9yIHRoZSBwb3Nz
aWJsZSB2YWx1ZXMgb2YgdGhpcyByZWdpc3Rlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBH
YWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdl
bG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
