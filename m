Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4498FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BF320674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FKrS86B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgHQECt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:02:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22945 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgHQECs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:02:48 -0400
X-UUID: 388c34d1e23c4b7e8cf9e40e9b2d1a37-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pACLi6wbKi9AORYpzxtaOBRDENoBN/knrxeP2OFFLTY=;
        b=FKrS86B9fgmvYv0bjbxQBjEROkx4buduqT262mBjdAthGuhVBZ2kIRRPihjQ7hvv83gXmVtfjtWiPKO5dRYxVqW5s8M7RdpYIEhY/AzGvAzlVUQQKlrryrpI7gaqS2Y70nkSdnfuFdrnVJT7c6FWG49amjDE/YkC32AC8t5fo3s=;
X-UUID: 388c34d1e23c4b7e8cf9e40e9b2d1a37-20200817
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 917943585; Mon, 17 Aug 2020 12:02:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 12:02:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 12:02:33 +0800
Message-ID: <1597636953.3394.7.camel@mtkswgap22>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 17 Aug 2020 12:02:33 +0800
In-Reply-To: <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
         <1597289564-17030-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gU2F0LCAyMDIwLTA4LTE1IGF0IDExOjAzICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0OOaciDEz5pelIOmAseWbmyDkuIrljYgxMTozM+Wvq+mB
k++8mg0KPiA+DQo+ID4gTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVzdFpvbmUgc2Vj
dXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KPiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMg
ZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkDQo+ID4gbWFzdGVycy4NCj4gPiBUaGUg
c2VjdXJpdHkgdmlvbGF0aW9uIGlzIGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZv
cg0KPiA+IGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+DQo+ID4gQW55
IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9uIHdvdWxkIHJhaXNlIGFuIGludGVycnVw
dCwgYW5kDQo+ID4gaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1kZXZhcGMgZHJpdmVyLiBUaGUg
dmlvbGF0aW9uDQo+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBvcmRlciB0byBmaW5kIHRo
ZSBtdXJkZXJlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKy8qDQo+ID4gKyAq
IGRldmFwY192aW9sYXRpb25faXJxIC0gdGhlIGRldmFwYyBJbnRlcnJ1cHQgU2VydmljZSBSb3V0
aW5lIChJU1IpIHdpbGwgZHVtcA0KPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgIHZpb2xh
dGlvbiBpbmZvcm1hdGlvbiBpbmNsdWRpbmcgd2hpY2ggbWFzdGVyIHZpb2xhdGVzDQo+ID4gKyAq
ICAgICAgICAgICAgICAgICAgICAgICAgYWNjZXNzIHNsYXZlLg0KPiA+ICsgKi8NCj4gPiArc3Rh
dGljIGlycXJldHVybl90IGRldmFwY192aW9sYXRpb25faXJxKGludCBpcnFfbnVtYmVyLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXRrX2RldmFw
Y19jb250ZXh0ICpjdHgpDQo+ID4gK3sNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBN
YXNrIHNsYXZlJ3MgaXJxIGJlZm9yZSBjbGVhcmluZyB2aW8gc3RhdHVzLg0KPiA+ICsgICAgICAg
ICogTXVzdCBkbyBpdCB0byBhdm9pZCBuZXN0ZWQgaW50ZXJydXB0IGFuZCBwcmV2ZW50DQo+ID4g
KyAgICAgICAgKiB1bmV4cGVjdGVkIGJlaGF2aW9yLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAg
ICAgICBtYXNrX21vZHVsZV9pcnEoY3R4LCB0cnVlKTsNCj4gDQo+IEkgc3RpbGwgZG9uJ3QgdW5k
ZXJzdGFuZCB3aHkgbmVzdGVkIGludGVycnVwdCBoYXBwZW4uIElmIHR3byBDUFUNCj4gcHJvY2Vz
cyBkaWZmZXJlbnQgZGV2YXBjIGludGVycnVwdCBhdCB0aGUgc2FtZSB0aW1lLCBtYXNrIGludGVy
cnVwdA0KPiBjb3VsZCBub3QgcHJldmVudCB0aGVzZSB0d28gQ1BVIHRvIHN5bmMgdmlvIGRiZyBh
dCB0aGUgc2FtZSB0aW1lLiBBcyBJDQo+IGtub3csIGluIEFSTSBDUFUsIG9ubHkgQ1BVMCBwcm9j
ZXNzIGlycSBoYW5kbGVyLCBhbmQgYWxsIGRldmFwYw0KPiBpbnRlcnJ1cHQgaGFzIHRoZSBzYW1l
IHByaW9yaXR5LCBzbyB3aHkgbmVzdGVkIGludGVycnVwdCBoYXBwZW4/IENvdWxkDQo+IHlvdSBl
eHBsYWluIG1vcmUgZGV0YWlsIGFib3V0IGhvdyBuZXN0ZWQgaW50ZXJydXB0IGhhcHBlbj8NCg0K
SWYgdGhlcmUgaXMgYW5vdGhlciB2aW9sYXRpb24gaGFwcGVuZWQgYmVmb3JlIHByZXZpb3VzIHZp
b2xhdGlvbiBpcw0KZnVsbHkgaGFuZGxlZCwgbmVzdGVkIGludGVycnVwdCB3b3VsZCBoYXBwZW4u
DQoNCkxldCdzIG1lIHRha2UgYW4gZXhhbXBsZToNCnZpbyBBIGhhcHBlbg0KZW50ZXIgQSBJU1IN
Ci4uLgkJdmlvIEIgaGFwcGVuDQpmaW5pc2ggQSBJU1IJZW50ZXIgQiBJU1INCgkJLi4uDQoJCWZp
bmlzaCBCIElTUg0KDQpXZSBtYXNrIGFsbCBtb2R1bGUncyBpcnEgdG8gYXZvaWQgbmVzdGVkIGlu
dGVycnVwdC4NCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICB3aGlsZSAoZGV2YXBjX3N5bmNfdmlv
X2RiZyhjdHgpKQ0KPiA+ICsgICAgICAgICAgICAgICBkZXZhcGNfZXh0cmFjdF92aW9fZGJnKGN0
eCk7DQo+ID4gKw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIEVuc3VyZSB0aGF0IHZp
b2xhdGlvbiBpbmZvIGFyZSB3cml0dGVuDQo+ID4gKyAgICAgICAgKiBiZWZvcmUgZnVydGhlciBv
cGVyYXRpb25zDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIHNtcF9tYigpOw0KPiA+ICsN
Cj4gPiArICAgICAgIGNsZWFyX3Zpb19zdGF0dXMoY3R4KTsNCj4gPiArICAgICAgIG1hc2tfbW9k
dWxlX2lycShjdHgsIGZhbHNlKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IG10a19kZXZhcGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
K3sNCj4gPiArICAgICAgIHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmN0eCA9IHBsYXRmb3Jt
X2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIHN0b3BfZGV2YXBjKGN0eCk7
DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGN0eC0+aW5mcmFfY2xrKQ0KPiANCj4gVGhpcyBhbHdh
eXMgdHJ1ZS4NCg0KRG9lcyBpdCBtZWFuIHRoYXQgcmVtb3ZlIGZ1bmN0aW9uIHdvdWxkIGJlIGNh
bGxlZCBvbmx5IGlmIHByb2JlIGZ1bmN0aW9uDQppcyByZXR1cm5lZCBzdWNjZXNzZnVsbHk/DQpJ
cyB0aGVyZSBhbnkgY2hhbmNlIHRoaXMgZnVuY3Rpb24gd291bGQgYmUgY2FsbGVkIGRpcmVjdGx5
Pw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCj4gPiArICAgICAgICAgICAg
ICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGN0eC0+aW5mcmFfY2xrKTsNCj4gPiArDQo+ID4gKyAg
ICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgbXRrX2RldmFwY19kcml2ZXIgPSB7DQo+ID4gKyAgICAgICAucHJvYmUgPSBtdGtf
ZGV2YXBjX3Byb2JlLA0KPiA+ICsgICAgICAgLnJlbW92ZSA9IG10a19kZXZhcGNfcmVtb3ZlLA0K
PiA+ICsgICAgICAgLmRyaXZlciA9IHsNCj4gPiArICAgICAgICAgICAgICAgLm5hbWUgPSBLQlVJ
TERfTU9ETkFNRSwNCj4gPiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gbXRrX2Rl
dmFwY19kdF9tYXRjaCwNCj4gPiArICAgICAgIH0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICttb2R1
bGVfcGxhdGZvcm1fZHJpdmVyKG10a19kZXZhcGNfZHJpdmVyKTsNCj4gPiArDQo+ID4gK01PRFVM
RV9ERVNDUklQVElPTigiTWVkaWF0ZWsgRGV2aWNlIEFQQyBEcml2ZXIiKTsNCj4gPiArTU9EVUxF
X0FVVEhPUigiTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4iKTsNCj4gPiArTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOw0KPiA+IC0tDQo+ID4gMS43LjkuNQ0KPiA+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFp
bGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsN
Cg0K

