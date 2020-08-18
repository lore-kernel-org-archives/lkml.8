Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3298AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1EA2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Cjg5zhaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgHRGVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:21:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726228AbgHRGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:21:01 -0400
X-UUID: 1d39c27ff5f1478b8fe03fff3ed0eb4e-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=26U75Xf8g/WhSUg+fpLBfSWdLyg0Hh99bzHnWDgzNQI=;
        b=Cjg5zhaYwf9cfA3c8Cybl9hjbo25D2Uy/6xcPO6b4PMcFDHuLUhOXdpm+h9WrE78kOnEH392sGqV8Y/MpTAIESKmKlBVr809R3vmkJq9VhxQN9n9s+gTKrmlsAqy5YcyR78KxpFYVpzS4y6YnClora+2pT5c1TC6bTZUArtww3A=;
X-UUID: 1d39c27ff5f1478b8fe03fff3ed0eb4e-20200818
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 131772513; Tue, 18 Aug 2020 14:20:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 14:20:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 14:20:43 +0800
Message-ID: <1597731644.12680.2.camel@mtkswgap22>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Aug 2020 14:20:44 +0800
In-Reply-To: <1597718679.5704.3.camel@mtkswgap22>
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
         <1597289564-17030-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
         <1597636953.3394.7.camel@mtkswgap22>
         <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
         <1597718679.5704.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3245D93C313EC4131B92236A87711428C0F20780901D818E97FCD5D4F858A47D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gVHVlLCAyMDIwLTA4LTE4IGF0IDEwOjQ0ICswODAwLCBOZWFs
IExpdSB3cm90ZToNCj4gSGkgQ2h1bi1LdWFuZywNCj4gDQo+IE9uIE1vbiwgMjAyMC0wOC0xNyBh
dCAyMzoxMyArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiBIaSwgTmVhbDoNCj4gPiAN
Cj4gPiBOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPiDmlrwgMjAyMOW5tDjmnIgxN+aX
pSDpgLHkuIAg5LiL5Y2IMTI6MDLlr6vpgZPvvJoNCj4gPiA+DQo+ID4gPiBIaSBDaHVuLUt1YW5n
LA0KPiA+ID4NCj4gPiA+IE9uIFNhdCwgMjAyMC0wOC0xNSBhdCAxMTowMyArMDgwMCwgQ2h1bi1L
dWFuZyBIdSB3cm90ZToNCj4gPiA+ID4gSGksIE5lYWw6DQo+ID4gPiA+DQo+ID4gPiA+IE5lYWwg
TGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0OOaciDEz5pelIOmAseWbmyDk
uIrljYgxMTozM+Wvq+mBk++8mg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTWVkaWFUZWsgYnVzIGZh
YnJpYyBwcm92aWRlcyBUcnVzdFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KPiA+ID4g
PiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1
bmV4cGVjdGVkDQo+ID4gPiA+ID4gbWFzdGVycy4NCj4gPiA+ID4gPiBUaGUgc2VjdXJpdHkgdmlv
bGF0aW9uIGlzIGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvcg0KPiA+ID4gPiA+
IGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gQW55IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9uIHdvdWxkIHJhaXNlIGFuIGlu
dGVycnVwdCwgYW5kDQo+ID4gPiA+ID4gaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1kZXZhcGMg
ZHJpdmVyLiBUaGUgdmlvbGF0aW9uDQo+ID4gPiA+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBp
biBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+DQo+ID4gPiA+IFtzbmlwXQ0KPiA+ID4gPg0KPiA+ID4gPiA+ICsvKg0KPiA+ID4g
PiA+ICsgKiBkZXZhcGNfdmlvbGF0aW9uX2lycSAtIHRoZSBkZXZhcGMgSW50ZXJydXB0IFNlcnZp
Y2UgUm91dGluZSAoSVNSKSB3aWxsIGR1bXANCj4gPiA+ID4gPiArICogICAgICAgICAgICAgICAg
ICAgICAgICB2aW9sYXRpb24gaW5mb3JtYXRpb24gaW5jbHVkaW5nIHdoaWNoIG1hc3RlciB2aW9s
YXRlcw0KPiA+ID4gPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgIGFjY2VzcyBzbGF2ZS4N
Cj4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBkZXZhcGNfdmlv
bGF0aW9uX2lycShpbnQgaXJxX251bWJlciwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG10a19kZXZhcGNfY29udGV4dCAqY3R4KQ0KPiA+
ID4gPiA+ICt7DQo+ID4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiA+ICsgICAgICAgICogTWFz
ayBzbGF2ZSdzIGlycSBiZWZvcmUgY2xlYXJpbmcgdmlvIHN0YXR1cy4NCj4gPiA+ID4gPiArICAg
ICAgICAqIE11c3QgZG8gaXQgdG8gYXZvaWQgbmVzdGVkIGludGVycnVwdCBhbmQgcHJldmVudA0K
PiA+ID4gPiA+ICsgICAgICAgICogdW5leHBlY3RlZCBiZWhhdmlvci4NCj4gPiA+ID4gPiArICAg
ICAgICAqLw0KPiA+ID4gPiA+ICsgICAgICAgbWFza19tb2R1bGVfaXJxKGN0eCwgdHJ1ZSk7DQo+
ID4gPiA+DQo+ID4gPiA+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgbmVzdGVkIGludGVy
cnVwdCBoYXBwZW4uIElmIHR3byBDUFUNCj4gPiA+ID4gcHJvY2VzcyBkaWZmZXJlbnQgZGV2YXBj
IGludGVycnVwdCBhdCB0aGUgc2FtZSB0aW1lLCBtYXNrIGludGVycnVwdA0KPiA+ID4gPiBjb3Vs
ZCBub3QgcHJldmVudCB0aGVzZSB0d28gQ1BVIHRvIHN5bmMgdmlvIGRiZyBhdCB0aGUgc2FtZSB0
aW1lLiBBcyBJDQo+ID4gPiA+IGtub3csIGluIEFSTSBDUFUsIG9ubHkgQ1BVMCBwcm9jZXNzIGly
cSBoYW5kbGVyLCBhbmQgYWxsIGRldmFwYw0KPiA+ID4gPiBpbnRlcnJ1cHQgaGFzIHRoZSBzYW1l
IHByaW9yaXR5LCBzbyB3aHkgbmVzdGVkIGludGVycnVwdCBoYXBwZW4/IENvdWxkDQo+ID4gPiA+
IHlvdSBleHBsYWluIG1vcmUgZGV0YWlsIGFib3V0IGhvdyBuZXN0ZWQgaW50ZXJydXB0IGhhcHBl
bj8NCj4gPiA+DQo+ID4gPiBJZiB0aGVyZSBpcyBhbm90aGVyIHZpb2xhdGlvbiBoYXBwZW5lZCBi
ZWZvcmUgcHJldmlvdXMgdmlvbGF0aW9uIGlzDQo+ID4gPiBmdWxseSBoYW5kbGVkLCBuZXN0ZWQg
aW50ZXJydXB0IHdvdWxkIGhhcHBlbi4NCj4gPiA+DQo+ID4gPiBMZXQncyBtZSB0YWtlIGFuIGV4
YW1wbGU6DQo+ID4gPiB2aW8gQSBoYXBwZW4NCj4gPiA+IGVudGVyIEEgSVNSDQo+ID4gPiAuLi4g
ICAgICAgICAgICAgdmlvIEIgaGFwcGVuDQo+ID4gPiBmaW5pc2ggQSBJU1IgICAgZW50ZXIgQiBJ
U1INCj4gPiA+ICAgICAgICAgICAgICAgICAuLi4NCj4gPiA+ICAgICAgICAgICAgICAgICBmaW5p
c2ggQiBJU1INCj4gPiA+DQo+ID4gPiBXZSBtYXNrIGFsbCBtb2R1bGUncyBpcnEgdG8gYXZvaWQg
bmVzdGVkIGludGVycnVwdC4NCj4gPiANCj4gPiBUaGlzIGlzIG5vdCAnbmVzdGVkJyBpbnRlcnJ1
cHQuIEFmdGVyIEEgSVNSIGlzIGZpbmlzaGVkLCBCIElTUiBoYXBwZW4uDQo+ID4gU28gQSBJU1Ig
YW5kIEIgSVNSIGFyZSBjb25zZWN1dGl2ZSBpbnRlcnJ1cHQsIG5vdCBuZXN0ZWQgaW50ZXJydXB0
Lg0KPiA+IFRvIGNvbXBhcmUgbWFzayBpcnEgYW5kIG5vIG1hc2sgaXJxLCBMZXQncyBjb25zaWRl
ciB0aGlzIHNpdHVhdGlvbjoNCj4gPiANCj4gPiAxLiAxMDAwIGNvbnNlY3V0aXZlIHZpb2xhdGlv
biBoYXBwZW4sIHRoZSB0aW1lIHBlcmlvZCBiZXR3ZWVuIHR3bw0KPiA+IHZpb2xhdGlvbiBpcyAw
LjAxIG1zLCBzbyB0aGUgdG90YWwgdGltZSBpcyAxMG1zLiAoSW4gMTBtcywgMTAwMA0KPiA+IHZp
b2xhdGlvbiBoYXBwZW4pDQo+ID4gMi4gT25lIElTUiBoYW5kbGUgdGltZSBpcyAxIG1zLCBzbyBp
biBvbmUgSVNSIGhhbmRsZXIsIDEwMCB2aW9sYXRpb24gaGFwcGVuLg0KPiA+IA0KPiA+IEZvciBt
YXNrIGlycSBzb2x1dGlvbiwgMTAgSVNSIGhhbmRsZXIgaXMgdHJpZ2dlci4gRm9yIG5vIG1hc2sg
aXJxDQo+ID4gc29sdXRpb24sIDExIElTUiBoYW5kbGVyIGlzIHRyaWdnZXIuDQo+ID4gSSB0aGlu
ayB0aGVzZSB0d28gc29sdXRpb24gaGF2ZSBzaW1pbGFyIHJlc3VsdCwgYW5kIG5vIG1hc2sgaXJx
DQo+ID4gc29sdXRpb24gcHJpbnQgbW9yZSBpbmZvcm1hdGlvbiAoSWYgdGhlc2UgMTAwMCB2aW9s
YXRpb24gaXMgdHJpZ2dlciBieQ0KPiA+IDIwIGRpZmZlcmVudCBkcml2ZXIsIG5vIG1hc2sgc29s
dXRpb24gbWF5IHNob3cgb25lIG1vcmUgZHJpdmVyIHRoYW4NCj4gPiBtYXNrIHNvbHV0aW9uKQ0K
PiA+IFNvIEkgdGhpbmsgaXQncyBub3QgbmVjZXNzYXJ5IHRvIG1hc2sgaXJxIGluIGlycSBoYW5k
bGVyLg0KPiA+IA0KPiANCj4gTm8sIG15IGV4YW1wbGUgaXMgQiBJU1IgaXMgZW50ZXJlZCBiZWZv
cmUgQSBJU1IgZmluaXNoZWQuDQo+IFdoeSB0aGlzIGlzIG5vdCBuZXN0ZWQ/DQo+IHZpbyBBIGhh
cHBlbg0KPiBlbnRlciBBIElTUg0KPiAuLi4gICAgICAgICAgICAgdmlvIEIgaGFwcGVuDQo+IC4u
LgkJZW50ZXIgQiBJU1INCj4gZmluaXNoIEEgSVNSDQo+ICAgICAgICAgICAgICAgICAuLi4NCj4g
CQkuLi4NCj4gICAgICAgICAgICAgICAgIGZpbmlzaCBCIElTUg0KPiANCg0KSSBoYXZlIHNvbWUg
bWlzdW5kZXJzdGFuZGluZyBhYm91dCBob3cgQVJNIENQVSAmIEdJQyB3b3Jrcy4gSSdsbCBjb25m
aXJtDQppdCBhbmQgZ2V0IGJhY2sgdG8geW91LiBQbGVhc2UgaWdub3JlIHByZXZpb3VzIG1haWwg
dGhyZWFkLg0KVGhhbmtzICENCg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiArDQo+ID4gPiA+
ID4gKyAgICAgICB3aGlsZSAoZGV2YXBjX3N5bmNfdmlvX2RiZyhjdHgpKQ0KPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICBkZXZhcGNfZXh0cmFjdF92aW9fZGJnKGN0eCk7DQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsgICAgICAgLyoNCj4gPiA+ID4gPiArICAgICAgICAqIEVuc3VyZSB0aGF0IHZp
b2xhdGlvbiBpbmZvIGFyZSB3cml0dGVuDQo+ID4gPiA+ID4gKyAgICAgICAgKiBiZWZvcmUgZnVy
dGhlciBvcGVyYXRpb25zDQo+ID4gPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ID4gPiArICAgICAg
IHNtcF9tYigpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgIGNsZWFyX3Zpb19zdGF0
dXMoY3R4KTsNCj4gPiA+ID4gPiArICAgICAgIG1hc2tfbW9kdWxlX2lycShjdHgsIGZhbHNlKTsN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ID4g
PiA+ID4gK30NCj4gPiA+ID4gPiArDQo+ID4gPiA+DQo+ID4gPiA+IFtzbmlwXQ0KPiA+ID4gPg0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGludCBtdGtfZGV2YXBjX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gKyAgICAg
ICBzdHJ1Y3QgbXRrX2RldmFwY19jb250ZXh0ICpjdHggPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShw
ZGV2KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICBzdG9wX2RldmFwYyhjdHgpOw0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgIGlmIChjdHgtPmluZnJhX2NsaykNCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBhbHdheXMgdHJ1ZS4NCj4gPiA+DQo+ID4gPiBEb2VzIGl0IG1lYW4g
dGhhdCByZW1vdmUgZnVuY3Rpb24gd291bGQgYmUgY2FsbGVkIG9ubHkgaWYgcHJvYmUgZnVuY3Rp
b24NCj4gPiA+IGlzIHJldHVybmVkIHN1Y2Nlc3NmdWxseT8NCj4gPiANCj4gPiBZZXMuDQo+ID4g
DQo+ID4gPiBJcyB0aGVyZSBhbnkgY2hhbmNlIHRoaXMgZnVuY3Rpb24gd291bGQgYmUgY2FsbGVk
IGRpcmVjdGx5Pw0KPiA+IA0KPiA+IE5vLg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2h1bi1L
dWFuZy4NCj4gPiANCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IENo
dW4tS3VhbmcuDQo+ID4gPiA+DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGNsa19kaXNhYmxl
X3VucHJlcGFyZShjdHgtPmluZnJhX2Nsayk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAg
ICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19kZXZhcGNfZHJpdmVyID0gew0KPiA+ID4gPiA+
ICsgICAgICAgLnByb2JlID0gbXRrX2RldmFwY19wcm9iZSwNCj4gPiA+ID4gPiArICAgICAgIC5y
ZW1vdmUgPSBtdGtfZGV2YXBjX3JlbW92ZSwNCj4gPiA+ID4gPiArICAgICAgIC5kcml2ZXIgPSB7
DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIC5uYW1lID0gS0JVSUxEX01PRE5BTUUsDQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG10a19kZXZhcGNfZHRfbWF0
Y2gsDQo+ID4gPiA+ID4gKyAgICAgICB9LA0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihtdGtfZGV2YXBjX2RyaXZlcik7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1lZGlhdGVrIERldmljZSBB
UEMgRHJpdmVyIik7DQo+ID4gPiA+ID4gK01PRFVMRV9BVVRIT1IoIk5lYWwgTGl1IDxuZWFsLmxp
dUBtZWRpYXRlay5jb20+Iik7DQo+ID4gPiA+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4g
PiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDEuNy45LjUNCj4gPiA+ID4gPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4gPiA+IExpbnV4LW1lZGlhdGVr
IG1haWxpbmcgbGlzdA0KPiA+ID4gPiA+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gPiA+ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW1lZGlhdGVrDQo+ID4gPg0KPiANCj4gDQoNCg==

