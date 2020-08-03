Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2075A206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oiHjCpxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHCDlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:41:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726772AbgHCDlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:41:20 -0400
X-UUID: 0acfa016a5124402bc0b6eaa734a0198-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=m42oonF9rgHK7bYhLL7BB3uQil5O3aZLfSzxPT96WEM=;
        b=oiHjCpxjBd8wBVGpIbex+vdM5MPG1Dk5S2nVcHhzf9q//1exnYqtuMudXhOvzjiLzCzbJMU35+WWvu1yaO7mcgvcC/GhluIeU9F1gVfg88+NfaKcSVQGR/RfDYlQ2I5Q449OX6/WfjiEbCiEbZkH9q4zzeHaoujZN4SE8j/xta4=;
X-UUID: 0acfa016a5124402bc0b6eaa734a0198-20200803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 331396198; Mon, 03 Aug 2020 11:41:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 11:41:11 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 11:41:11 +0800
Message-ID: <1596426072.22971.14.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
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
Date:   Mon, 3 Aug 2020 11:41:12 +0800
In-Reply-To: <CAAOTY_-3vs9VdAs3RHc_-MQJ7HbmqXKgULC_H0grr3q7oNDxMQ@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
         <1596163970.3932.24.camel@mtkswgap22>
         <CAAOTY_-3vs9VdAs3RHc_-MQJ7HbmqXKgULC_H0grr3q7oNDxMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FDFDD2EEAC8AC8967E0E57305B8F10599BF0B0EF43AB126F2242C878BE64C3FF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gRnJpLCAyMDIwLTA3LTMxIGF0IDIzOjU1ICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0N+aciDMx5pelIOmAseS6lCDkuIrljYgxMDo1MuWvq+mB
k++8mg0KPiA+DQo+ID4gSGkgQ2h1bi1LdWFuZywNCj4gPg0KPiA+IE9uIEZyaSwgMjAyMC0wNy0z
MSBhdCAwMDoxNCArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiA+IEhpLCBOZWFsOg0K
PiA+ID4NCj4gPiA+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0
N+aciDI55pelIOmAseS4iSDkuIvljYg0OjI55a+r6YGT77yaDQo+ID4gPiA+DQo+ID4gPiA+IE1l
ZGlhVGVrIGJ1cyBmYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQgYW5k
IGRhdGENCj4gPiA+ID4gcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5nIGFj
Y2Vzc2VkIGJ5IHVuZXhwZWN0ZWQNCj4gPiA+ID4gbWFzdGVycy4NCj4gPiA+ID4gVGhlIHNlY3Vy
aXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3INCj4g
PiA+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4gPiA+DQo+ID4g
PiA+IEFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xhdGlvbiB3b3VsZCByYWlzZSBhbiBp
bnRlcnJ1cHQsIGFuZA0KPiA+ID4gPiBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFwYyBk
cml2ZXIuIFRoZSB2aW9sYXRpb24NCj4gPiA+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBv
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPg0K
PiA+ID4gW3NuaXBdDQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICog
ZGV2YXBjX2V4dHJhY3RfdmlvX2RiZyAtIGV4dHJhY3QgZnVsbCB2aW9sYXRpb24gaW5mb3JtYXRp
b24gYWZ0ZXIgZG9pbmcNCj4gPiA+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICBzaGlm
dCBtZWNoYW5pc20uDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyB2b2lkIGRldmFwY19l
eHRyYWN0X3Zpb19kYmcoc3RydWN0IG10a19kZXZhcGNfY29udGV4dCAqY3R4KQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZGV2YXBjX3Zpb19kYmdzICp2aW9f
ZGJnczsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXRrX2RldmFwY192aW9faW5mbyAqdmlvX2lu
Zm87DQo+ID4gPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICp2aW9fZGJnMF9yZWc7DQo+ID4gPiA+
ICsgICAgICAgdm9pZCBfX2lvbWVtICp2aW9fZGJnMV9yZWc7DQo+ID4gPiA+ICsgICAgICAgdTMy
IGRiZzA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICB2aW9fZGJnMF9yZWcgPSBjdHgtPmRl
dmFwY19wZF9iYXNlICsgY3R4LT5vZmZzZXQtPnZpb19kYmcwOw0KPiA+ID4gPiArICAgICAgIHZp
b19kYmcxX3JlZyA9IGN0eC0+ZGV2YXBjX3BkX2Jhc2UgKyBjdHgtPm9mZnNldC0+dmlvX2RiZzE7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICB2aW9fZGJncyA9IGN0eC0+dmlvX2RiZ3M7DQo+
ID4gPiA+ICsgICAgICAgdmlvX2luZm8gPSBjdHgtPnZpb19pbmZvOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgICAgICAgLyogU3RhcnRzIHRvIGV4dHJhY3QgdmlvbGF0aW9uIGluZm9ybWF0aW9uICov
DQo+ID4gPiA+ICsgICAgICAgZGJnMCA9IHJlYWRsKHZpb19kYmcwX3JlZyk7DQo+ID4gPiA+ICsg
ICAgICAgdmlvX2luZm8tPnZpb19hZGRyID0gcmVhZGwodmlvX2RiZzFfcmVnKTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgIHZpb19pbmZvLT5tYXN0ZXJfaWQgPSAoZGJnMCAmIHZpb19kYmdz
LT5tc3RpZC5tYXNrKSA+Pg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
aW9fZGJncy0+bXN0aWQuc3RhcnQ7DQo+ID4gPiA+ICsgICAgICAgdmlvX2luZm8tPmRvbWFpbl9p
ZCA9IChkYmcwICYgdmlvX2RiZ3MtPmRtbmlkLm1hc2spID4+DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZpb19kYmdzLT5kbW5pZC5zdGFydDsNCj4gPiA+ID4gKyAgICAg
ICB2aW9faW5mby0+d3JpdGUgPSAoKGRiZzAgJiB2aW9fZGJncy0+dmlvX3cubWFzaykgPj4NCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpb19kYmdzLT52aW9fdy5zdGFydCkg
PT0gMTsNCj4gPiA+ID4gKyAgICAgICB2aW9faW5mby0+cmVhZCA9ICgoZGJnMCAmIHZpb19kYmdz
LT52aW9fci5tYXNrKSA+Pg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIHZpb19k
YmdzLT52aW9fci5zdGFydCkgPT0gMTsNCj4gPiA+ID4gKyAgICAgICB2aW9faW5mby0+dmlvX2Fk
ZHJfaGlnaCA9IChkYmcwICYgdmlvX2RiZ3MtPmFkZHJfaC5tYXNrKSA+Pg0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlvX2RiZ3MtPmFkZHJfaC5zdGFydDsNCj4g
PiA+DQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBsaWtlIHRvIGRlZmluZSB0aGUgdHlwZSBvZiBjdHgt
PnZpb19pbmZvIHRvIGJlDQo+ID4gPg0KPiA+ID4gc3RydWN0IG10a19kZXZhcGNfdmlvX2RiZ3Mg
ew0KPiA+ID4gICAgIHUzMiBtc3RpZDoxNjsNCj4gPiA+ICAgICB1MzIgZG1uaWQ6NjsNCj4gPiA+
ICAgICB1MzIgdmlvX3c6MTsNCj4gPiA+ICAgICB1MzIgdmlvX3I6MTsNCj4gPiA+ICAgICB1MzIg
YWRkcl9oOjQ7DQo+ID4gPiAgICAgdTMyIHJlc3Y6NDsNCj4gPiA+IH07DQo+ID4gPg0KPiA+ID4g
c28gdGhlIGNvZGUgd291bGQgbGlrZSB0aGUgc2ltcGxlIHdheQ0KPiA+ID4NCj4gPiA+IGN0eC0+
dmlvX2luZm8gPSAoc3RydWN0IG10a19kZXZhcGNfdmlvX2RiZ3MpcmVhZGwodmlvX2RiZzFfcmVn
KTsNCj4gPiA+DQo+ID4NCj4gPiBUaGlzIGlkZWEgbG9va3MgZ3JlYXQhIElzIHRoZXJlIGFueSBw
b3NzaWJsZSB0byBwYXNzIHRoZSBiaXQgbGF5b3V0IGJ5DQo+ID4gRFQgZGF0YSwgYW5kIHN0aWxs
IG1ha2UgdGhpcyBvcGVyYXRpb24gc2ltcGxlPw0KPiA+IFdoeSBhbSBJIGFza2luZyB0aGlzIHF1
ZXN0aW9uIGlzIGJlY2F1c2UgdGhpcyBiaXQgbGF5b3V0IGlzIHBsYXRmb3JtDQo+ID4gZGVwZW5k
ZW50Lg0KPiANCj4gSSBkb3VidCB0aGVzZSBpbmZvIHdvdWxkIGJlIGluIGEgc2luZ2xlIDMyLWJp
dHMgcmVnaXN0ZXIgZm9yIGFsbA0KPiBmdXR1cmUgU29DLiBJZiB0aGV5IGFyZSBub3QgaW4gc2lu
Z2xlIDMyLWJpdHMgcmVnaXN0ZXIsIHlvdSBtYXkgY3JlYXRlDQo+IGEgdmlvX2RiZ3NfdHlwZSBp
biBEVCBkYXRhLCBhbmQgdGhlIGNvZGUgbWF5IGJlDQo+IA0KPiBpZiAoY3R4LT52aW9fZGJnc190
eXBlID09IFZJT19EQkdTX1RZUEVfTVR4eHh4KSB7DQo+ICAgICBjdHgtPnZpb19pbmZvID0gKHN0
cnVjdCBtdGtfZGV2YXBjX3Zpb19kYmdzKXJlYWRsKHZpb19kYmcxX3JlZyk7DQo+IH0gZWxzZSBp
ZiAoY3R4LT52aW9fZGJnc190eXBlID09IFZJT19EQkdTX1RZUEVfTVR5eXl5KSB7DQo+ICAgICBj
dHgtPnZpb19pbmZvLT5tc3RpZCA9IHJlYWRsKHZpb19tc3RpZF9yZWcpOw0KPiAgICAgY3R4LT52
aW9faW5mby0+ZG1uaWQgPSByZWFkbCh2aW9fZG1uaWRfcmVnKTsNCj4gICAgIGN0eC0+dmlvX2lu
Zm8tPnZpb193ID0gcmVhZGwodmlvX3Zpb193X3JlZyk7DQo+ICAgICBjdHgtPnZpb19pbmZvLT52
aW9fciA9IHJlYWRsKHZpb192aW9fcl9yZWcpOw0KPiB9DQo+IA0KPiBJIHRoaW5rIHdlIG5lZWQg
bm90IHRvIGNvbnNpZGVyIGhvdyB0aGUgZnV0dXJlIHdvdWxkIGJlLiBPbmNlIHRoZQ0KPiBzZWNv
bmQgU29DIGRyaXZlciBpcyB1cHN0cmVhbWluZywgd2UgY291bGQgZmluZCBvdXQgdGhlIGJlc3Qg
c29sdXRpb24NCj4gZm9yIGl0Lg0KPiANCg0KT2theSwgSSdsbCBhcHBseSB0aGlzIG9uIG5leHQg
cGF0Y2guDQpUaGFua3MgIQ0KDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KPiA+DQo+
ID4gPiBSZWdhcmRzLA0KPiA+ID4gQ2h1bi1LdWFuZy4NCj4gPiA+DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgICAgICBkZXZhcGNfdmlvX2luZm9fcHJpbnQoY3R4KTsNCj4gPiA+ID4gK30NCj4gPiA+
ID4gKw0KPiA+DQoNCg==

