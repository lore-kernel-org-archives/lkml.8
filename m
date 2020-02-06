Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF2C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0721775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBFRGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:06:55 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28721 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbgBFRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:06:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-244-k3KJlLTsOyOEt3BxP61xAA-1; Thu, 06 Feb 2020 17:06:48 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 6 Feb 2020 17:06:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 6 Feb 2020 17:06:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Osipenko' <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sharadg@nvidia.com" <sharadg@nvidia.com>,
        "mkumard@nvidia.com" <mkumard@nvidia.com>,
        "viswanathl@nvidia.com" <viswanathl@nvidia.com>,
        "rlokhande@nvidia.com" <rlokhande@nvidia.com>,
        "dramesh@nvidia.com" <dramesh@nvidia.com>,
        "atalambedu@nvidia.com" <atalambedu@nvidia.com>
Subject: RE: [PATCH v2 4/9] ASoC: tegra: add Tegra210 based I2S driver
Thread-Topic: [PATCH v2 4/9] ASoC: tegra: add Tegra210 based I2S driver
Thread-Index: AQHV3Q7P9u0Xi3sD8kGXpD/1/LgEEKgOY//Q
Date:   Thu, 6 Feb 2020 17:06:47 +0000
Message-ID: <90ae7badcb3441daa8144233de8f6825@AcuMS.aculab.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-5-git-send-email-spujar@nvidia.com>
 <3a586a6b-5f53-dc44-b9fc-67c633c626ef@gmail.com>
In-Reply-To: <3a586a6b-5f53-dc44-b9fc-67c633c626ef@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: k3KJlLTsOyOEt3BxP61xAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogZiBEbWl0cnkgT3NpcGVua28NCj4gU2VudDogMDYgRmVicnVhcnkgMjAyMCAxNjo1OQ0K
PiANCj4gMzAuMDEuMjAyMCAxMzozMywgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6DQo+IC4uLg0K
PiA+ICtzdGF0aWMgY29uc3QgaW50IHRlZ3JhMjEwX2NpZl9mbXRbXSA9IHsNCj4gPiArCTAsDQo+
ID4gKwlURUdSQV9BQ0lGX0JJVFNfMTYsDQo+ID4gKwlURUdSQV9BQ0lGX0JJVFNfMzIsDQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgaW50IHRlZ3JhMjEwX2kyc19iaXRfZm10W10g
PSB7DQo+ID4gKwkwLA0KPiA+ICsJSTJTX0JJVFNfMTYsDQo+ID4gKwlJMlNfQklUU18zMiwNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBpbnQgdGVncmEyMTBfaTJzX3NhbXBsZV9z
aXplW10gPSB7DQo+ID4gKwkwLA0KPiA+ICsJMTYsDQo+ID4gKwkzMiwNCj4gPiArfTsNCj4gDQo+
IHN0YXRpYyBjb25zdCAqdW5zaWduZWQqIGludD8NCg0KT3IgZ2V0IHJpZCBvZiB0aGUgdGFibGUg
bG9va3VwcyBjb21wbGV0ZWx5Lg0KQXNzdW1pbmcgdGhlIGluZGV4IGlzIG5ldmVyIHplcm8gdGhl
biB0aGUgdmFsdWUNCmNhbiBiZSBjYWxjdWxhdGVkIGFzIChjb25zdF9hICsgY29uc3RfYiAqIGlu
ZGV4KS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

