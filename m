Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D922BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kgvreEWx";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ia07EofM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGTKg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:36:28 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:54956 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595241386; x=1626777386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KQw5TycU3ZAHGyC7RDGFN1geUrV0EavqWYgQLuQsmyo=;
  b=kgvreEWx/8Mi7uu+kpmgnGhmOVwxczR0vjGv4UfXySE8aj15JzGTPyRO
   yhwlpkrFWYN02tg1dHWkfWSSwDtlS36Gevbkq6kXJi6/P4lsS7dn5AH8X
   bxP+yqyBKWgomED3Zu3tqraqEInred+A+0k/iftAaVQ17PTPTjQ3An/b+
   vPYI2I+4KiLpyZ+y6ni5W9xo3c2UALdlhC9zkdosqQRxbFrxiSB0tniaq
   GXcHHx7NMBjl1K9rnv3XlStK6DbLWPgd+W3VLG7AlhgE+/2eMSGgsYFRY
   R5zDacUPfORNgjZayZq+HGKSSJrfek8gNqgvoOV+Qhn50FH2tQxlY9ilS
   Q==;
IronPort-SDR: kfq760Zm5rhzFC3xjKkLcL3oIYcN27mwEKvpcJRj38X83Z18PKUdT1RNuG9slTF7x4koQ7HPUP
 NH+/tfJIa4ca9+HpZFEocnOajvrY+ePrdZOfIA1sZIH8XW5Idf+pVPQ6NxdkCqoP5G6SECikLC
 ZfaDn5lKadsRiCzwS51OCwq/yGp2JEyQ/WmZfOyAEJ1rS5Y5hUsu4L7aSev5xiLN1ycomGAZ4V
 j7VkT8M17t7dnNdpTjR1WcrdXR3Ef2Pum0WkNG+Rr67jnUcqVxQvvDGaB/nbpE0mM7iz7hNbDV
 erI=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="84592622"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2020 03:36:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 03:35:50 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 20 Jul 2020 03:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPc4Ai8hadmBTR++JzMQs70rhjXnKxyefSVVogeR8L52XusqALav5wOqePErG09TNX8Om6OFMix55zbz9ZH8xPxcrL1I3MDSQ9fUPdW/dFxw2BNmKaM3IQA5+nX1WygKaToY8gziOqKtvvYfcZSGSvdv/GPqoyI9xEjCgONNpOwc+hCVk2zY/DoGf6lzO553Chsb0Wqi9T8kVCnU+PJ2/kKkKHBlj5R7v+ZNi4naimaVdTSrKOOhO28Pzyk7YgfigpPGQIFi55qEOQwwrCAeQnNf7ft76Pf9w3EnMTU/MBZLdmYWKN1Kc1yMn+9y3whBbnqDGMQLL22sAfPXBu9Q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQw5TycU3ZAHGyC7RDGFN1geUrV0EavqWYgQLuQsmyo=;
 b=ljExzAYVha4LrFV3GXXUtGwIKTn6bNEmPxqDd5SPCI+TOYfydy7xH9MCVHqsDMkBkRieGMJrka8Q2LKc6mfjaCLOYqNVVRgpJrKzCwwZt602DEJiLOMaSNy0si2KiP3eOs9bAK/xdTED6Vgj/O/MMEVcwOW51dlY98hLFpZQDDEINo6ODYmR3f1Wz0pepzPywe3uXbqatUXT4TFa7gJyxyJ3c9Vp9/u/a1UtNuE8NEdUzKvjO47woijWm8uPoXzQlZJD4gCsP+dZcOxflzyB/MZYXKtvZccr9VRvGLpQfqBJ6PZK6C7SA7KR3uf/tCU49rTT6LUJox78OOdXZ1qbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQw5TycU3ZAHGyC7RDGFN1geUrV0EavqWYgQLuQsmyo=;
 b=ia07EofMn8XqxWJ7kaW8jl1NWVgRwlw6qIn52onvDJ1x39rfWAaF3JfSigkQrTVpwkTOaVgZM/o4V1kZuLcDJ/QjjCM2PyDJ3GarM5kbnV4uSmKGJrp6t8VheWWWMt6KjqgpwwhwhipZTJ9LHn/sgbCcmEhjRduTFaOcPPKd9nU=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR1101MB2105.namprd11.prod.outlook.com (2603:10b6:4:51::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 10:36:25 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 10:36:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/19] clk: at91: replace conditional operator with double
 logical not
Thread-Topic: [PATCH 10/19] clk: at91: replace conditional operator with
 double logical not
Thread-Index: AQHWXoGeEy+dD2mSC06zh/rlGuHIyw==
Date:   Mon, 20 Jul 2020 10:36:25 +0000
Message-ID: <65c18837-7452-f970-e777-11929dbf8975@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-11-git-send-email-claudiu.beznea@microchip.com>
 <20200717150744.GU3428@piout.net>
In-Reply-To: <20200717150744.GU3428@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d247144-de35-43de-a8c7-08d82c98c0a5
x-ms-traffictypediagnostic: DM5PR1101MB2105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2105C93DEF44136D06AD56DD877B0@DM5PR1101MB2105.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmQLzzWxVgLoN3CnlGlyT1ThVXYzfpli1hobyJAoOje2UoQwmXJ/8mcdo3kZCHsuEToJAYYK28yx6ok/8vwGsMCgBXhgyPbKIqfrTjouOWte2OXqMM3jsHEfnqVecrJajdzIQM+a9J4K49FLWRdRnkvlBb8ltK8IOddDQ2otw/0QiW4QszDwZ0xHco6o9W4kn0+7A2vB3zO8Y6xrLpwz0MIBcXctUPeDRtjziujzfLGq6rlsngbdgwW+Vxuh7vvnVpnCTsejYWv7lE1MvoDZ35EbM3WXBaqs6mAB5x8o0VlJFASOB4VtYdKrZmDramQNzvXpX4dHpnQmd9ZLiomQMyxVmfzkf6T3aEkc+y/ZahsouQO5yYee47l19jz4AJvTytfQ6hQ5dIFcStxEEnxox8ZTyTqgOre6KN5kPAv5iPjYXtqszgikMn/1uiMYIOixq4w0JdL6fX7Hudkr9rZ/2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(66946007)(76116006)(91956017)(2616005)(66556008)(66476007)(53546011)(6506007)(64756008)(8676002)(86362001)(66446008)(6916009)(5660300002)(83380400001)(6512007)(2906002)(36756003)(26005)(316002)(8936002)(31686004)(71200400001)(31696002)(478600001)(4326008)(6486002)(186003)(966005)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2nAbF88KUuoKoCU2AK1uIQhotNyktkkzboQHz39NgcEG0GSAD5J+YQwavkpdkD5T/FIG/8lG855Jp24PaaeEb+dMf+dl3+pfrYr++fxuH9DSNRQHvJg8Uu267DWjrQxB+BsyxKaGhSfBV8Hi+qJWEF+gFEhbxACNI3cytX8p2QfXsdJs//edrSbyHJejYifmTwcnWbGf9/ErXbVdc7Fl+w+JCUYdYNxEA6D/aYE8vS86ny4y1xo6akEuyVZydUO5gWvqT/HFo5Das62HnxZ0Tkz1owx8Kq9Yp12xc6nKjyNxVEOWiFdHPMKSQheThG6q52Z4+GKOrjTpeKxvgnEefkX8YC0Ubtriq1Zf+OKBakIWv8ndaQXdqM7rPkZecUz3nI6fTVHLoHbmxKCDq8v52QEgzuGVMkb8l13Wwk/XsyqIp5Bd9FORZr2+L765Wf3N7zT1ofY2bFI8bV3tJdfHA2Khq8yN/X/DSvxMvhORok8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80B16C12E5383E4493BEF0B372AD48C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d247144-de35-43de-a8c7-08d82c98c0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:36:25.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yht5JDtySlA84yOO0z7nbFqzv4jUoLbcBZrFzveZ2vcyBDMQBkgzk9Bp5eRUzQNEUJNdRnNYtJgKzXjqkOenvFxsL1n8un19gU6c49yNCY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LjA3LjIwMjAgMTg6MDcsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gT24gMTUvMDcv
MjAyMCAxNDoyNDoxOCswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IFJlcGxhY2UgY29u
ZGl0aW9uYWwgb3BlcmF0b3Igd2l0aCBkb3VibGUgbG9naWNhbCBub3QuDQo+IA0KPiBJIHRoaW5r
IHlvdSBuZWVkIHRvIGVsYWJvcmF0ZSB3aHkgeW91IGRvIGl0IGFzIHRoZSBnZW5lcmF0ZWQNCj4g
aW5zdHJ1Y3Rpb25zIGFyZSBleGFjdGx5IHRoZSBzYW1lLg0KDQpJIGRvbid0IGhhdmUgc3Ryb25n
IHN1cHBvcnQgZm9yIHRoaXMgb25lLiBJbiBnZW5lcmFsIEknbSBzZWVpbmcNCnRoZSB1c2FnZSBv
ZiAhISBpbnN0ZWFkIG9mID86IGZvciAwIGFuZCAxIHJlc3VsdHMgYXMgYmVpbmcgc2ltcGxlcg0K
aW4gdGVybXMgb2YgY29kZSByZWFkaW5nLg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAg
ZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMgIHwgMiArLQ0KPj4gIGRyaXZlcnMvY2xr
L2F0OTEvY2xrLW1haW4uYyAgICAgICB8IDYgKysrLS0tDQo+PiAgZHJpdmVycy9jbGsvYXQ5MS9j
bGstbWFzdGVyLmMgICAgIHwgMiArLQ0KPj4gIGRyaXZlcnMvY2xrL2F0OTEvY2xrLXBlcmlwaGVy
YWwuYyB8IDIgKy0NCj4+ICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1zeXN0ZW0uYyAgICAgfCA0ICsr
LS0NCj4+ICA1IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMgYi9k
cml2ZXJzL2Nsay9hdDkxL2Nsay1nZW5lcmF0ZWQuYw0KPj4gaW5kZXggZjhlNTU3ZTBlMWI4Li4y
NDQ4YmRjNjM0MjUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL2Nsay1nZW5lcmF0
ZWQuYw0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstZ2VuZXJhdGVkLmMNCj4+IEBAIC04
Myw3ICs4Myw3IEBAIHN0YXRpYyBpbnQgY2xrX2dlbmVyYXRlZF9pc19lbmFibGVkKHN0cnVjdCBj
bGtfaHcgKmh3KQ0KPj4gICAgICAgcmVnbWFwX3JlYWQoZ2NrLT5yZWdtYXAsIGdjay0+bGF5b3V0
LT5vZmZzZXQsICZzdGF0dXMpOw0KPj4gICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShnY2st
PmxvY2ssIGZsYWdzKTsNCj4+DQo+PiAtICAgICByZXR1cm4gc3RhdHVzICYgQVQ5MV9QTUNfUENS
X0dDS0VOID8gMSA6IDA7DQo+PiArICAgICByZXR1cm4gISEoc3RhdHVzICYgQVQ5MV9QTUNfUENS
X0dDS0VOKTsNCj4+ICB9DQo+Pg0KPj4gIHN0YXRpYyB1bnNpZ25lZCBsb25nDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFpbi5jIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGst
bWFpbi5jDQo+PiBpbmRleCAzN2MyMjY2N2U4MzEuLjVjODNlODk5MDg0ZiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLW1haW4uYw0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5
MS9jbGstbWFpbi5jDQo+PiBAQCAtMTc1LDcgKzE3NSw3IEBAIHN0YXRpYyBib29sIGNsa19tYWlu
X3JjX29zY19yZWFkeShzdHJ1Y3QgcmVnbWFwICpyZWdtYXApDQo+Pg0KPj4gICAgICAgcmVnbWFw
X3JlYWQocmVnbWFwLCBBVDkxX1BNQ19TUiwgJnN0YXR1cyk7DQo+Pg0KPj4gLSAgICAgcmV0dXJu
IHN0YXR1cyAmIEFUOTFfUE1DX01PU0NSQ1M7DQo+PiArICAgICByZXR1cm4gISEoc3RhdHVzICYg
QVQ5MV9QTUNfTU9TQ1JDUyk7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgaW50IGNsa19tYWluX3Jj
X29zY19wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPj4gQEAgLTMzNiw3ICszMzYsNyBAQCBz
dGF0aWMgaW50IGNsa19ybTkyMDBfbWFpbl9pc19wcmVwYXJlZChzdHJ1Y3QgY2xrX2h3ICpodykN
Cj4+DQo+PiAgICAgICByZWdtYXBfcmVhZChjbGttYWluLT5yZWdtYXAsIEFUOTFfQ0tHUl9NQ0ZS
LCAmc3RhdHVzKTsNCj4+DQo+PiAtICAgICByZXR1cm4gc3RhdHVzICYgQVQ5MV9QTUNfTUFJTlJE
WSA/IDEgOiAwOw0KPj4gKyAgICAgcmV0dXJuICEhKHN0YXR1cyAmIEFUOTFfUE1DX01BSU5SRFkp
Ow0KPj4gIH0NCj4+DQo+PiAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3JtOTIwMF9tYWluX3Jl
Y2FsY19yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LA0KPj4gQEAgLTM5OCw3ICszOTgsNyBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgY2xrX3NhbTl4NV9tYWluX3JlYWR5KHN0cnVjdCByZWdtYXAgKnJlZ21h
cCkNCj4+DQo+PiAgICAgICByZWdtYXBfcmVhZChyZWdtYXAsIEFUOTFfUE1DX1NSLCAmc3RhdHVz
KTsNCj4+DQo+PiAtICAgICByZXR1cm4gc3RhdHVzICYgQVQ5MV9QTUNfTU9TQ1NFTFMgPyAxIDog
MDsNCj4+ICsgICAgIHJldHVybiAhIShzdGF0dXMgJiBBVDkxX1BNQ19NT1NDU0VMUyk7DQo+PiAg
fQ0KPj4NCj4+ICBzdGF0aWMgaW50IGNsa19zYW05eDVfbWFpbl9wcmVwYXJlKHN0cnVjdCBjbGtf
aHcgKmh3KQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLW1hc3Rlci5jIGIv
ZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFzdGVyLmMNCj4+IGluZGV4IGU3ZTBiYTY1MmRlMS4uODhk
NTQ1YjE2OThjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstbWFzdGVyLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLW1hc3Rlci5jDQo+PiBAQCAtMzMsNyArMzMs
NyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgY2xrX21hc3Rlcl9yZWFkeShzdHJ1Y3QgcmVnbWFwICpy
ZWdtYXApDQo+Pg0KPj4gICAgICAgcmVnbWFwX3JlYWQocmVnbWFwLCBBVDkxX1BNQ19TUiwgJnN0
YXR1cyk7DQo+Pg0KPj4gLSAgICAgcmV0dXJuIHN0YXR1cyAmIEFUOTFfUE1DX01DS1JEWSA/IDEg
OiAwOw0KPj4gKyAgICAgcmV0dXJuICEhKHN0YXR1cyAmIEFUOTFfUE1DX01DS1JEWSk7DQo+PiAg
fQ0KPj4NCj4+ICBzdGF0aWMgaW50IGNsa19tYXN0ZXJfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpo
dykNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2Nsay1wZXJpcGhlcmFsLmMgYi9k
cml2ZXJzL2Nsay9hdDkxL2Nsay1wZXJpcGhlcmFsLmMNCj4+IGluZGV4IGMyYWI0ODYwYTJiZi4u
NGM5YTQxNDdkZmU1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstcGVyaXBo
ZXJhbC5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1wZXJpcGhlcmFsLmMNCj4+IEBA
IC0yMDgsNyArMjA4LDcgQEAgc3RhdGljIGludCBjbGtfc2FtOXg1X3BlcmlwaGVyYWxfaXNfZW5h
YmxlZChzdHJ1Y3QgY2xrX2h3ICpodykNCj4+ICAgICAgIHJlZ21hcF9yZWFkKHBlcmlwaC0+cmVn
bWFwLCBwZXJpcGgtPmxheW91dC0+b2Zmc2V0LCAmc3RhdHVzKTsNCj4+ICAgICAgIHNwaW5fdW5s
b2NrX2lycXJlc3RvcmUocGVyaXBoLT5sb2NrLCBmbGFncyk7DQo+Pg0KPj4gLSAgICAgcmV0dXJu
IHN0YXR1cyAmIEFUOTFfUE1DX1BDUl9FTiA/IDEgOiAwOw0KPj4gKyAgICAgcmV0dXJuICEhKHN0
YXR1cyAmIEFUOTFfUE1DX1BDUl9FTik7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdW5zaWduZWQg
bG9uZw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLXN5c3RlbS5jIGIvZHJp
dmVycy9jbGsvYXQ5MS9jbGstc3lzdGVtLmMNCj4+IGluZGV4IGM0YjM4NzdhYTQ0NS4uZjgzZWMw
ZGU4NmMzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstc3lzdGVtLmMNCj4+
ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvY2xrLXN5c3RlbS5jDQo+PiBAQCAtMzQsNyArMzQsNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wgY2xrX3N5c3RlbV9yZWFkeShzdHJ1Y3QgcmVnbWFwICpyZWdt
YXAsIGludCBpZCkNCj4+DQo+PiAgICAgICByZWdtYXBfcmVhZChyZWdtYXAsIEFUOTFfUE1DX1NS
LCAmc3RhdHVzKTsNCj4+DQo+PiAtICAgICByZXR1cm4gc3RhdHVzICYgKDEgPDwgaWQpID8gMSA6
IDA7DQo+PiArICAgICByZXR1cm4gISEoc3RhdHVzICYgKDEgPDwgaWQpKTsNCj4+ICB9DQo+Pg0K
Pj4gIHN0YXRpYyBpbnQgY2xrX3N5c3RlbV9wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPj4g
QEAgLTc0LDcgKzc0LDcgQEAgc3RhdGljIGludCBjbGtfc3lzdGVtX2lzX3ByZXBhcmVkKHN0cnVj
dCBjbGtfaHcgKmh3KQ0KPj4NCj4+ICAgICAgIHJlZ21hcF9yZWFkKHN5cy0+cmVnbWFwLCBBVDkx
X1BNQ19TUiwgJnN0YXR1cyk7DQo+Pg0KPj4gLSAgICAgcmV0dXJuIHN0YXR1cyAmICgxIDw8IHN5
cy0+aWQpID8gMSA6IDA7DQo+PiArICAgICByZXR1cm4gISEoc3RhdHVzICYgKDEgPDwgc3lzLT5p
ZCkpOw0KPj4gIH0NCj4+DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIHN5c3RlbV9v
cHMgPSB7DQo+PiAtLQ0KPj4gMi43LjQNCj4+DQo+IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9u
aSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0
dHBzOi8vYm9vdGxpbi5jb20NCj4g
