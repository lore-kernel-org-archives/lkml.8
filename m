Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEB8208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kia3kxh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgGaCwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:52:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47927 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731124AbgGaCwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:52:55 -0400
X-UUID: e8de2b2ae81e483e9073d83b4e937833-20200731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cFIZ7AH8wP53gxkMXNCyFCEQBG9OwGZTiAZ/fcp/WMM=;
        b=kia3kxh/xLsY5o/LAnggUes2TxPWk6hh7M5Ketp2D/F3ooE+WYlo03VvAChdW63y/QhV5/pLE5BtARSuKGAh6FiVorWlJ0JRCn24JZfctEQIRhqeO3Rg3pgPi/RO1oHDKnMV66Uykf1mfV6VAsWtaJCZE3mGnZYGL9gepb3MdOY=;
X-UUID: e8de2b2ae81e483e9073d83b4e937833-20200731
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1583896948; Fri, 31 Jul 2020 10:52:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 31 Jul 2020 10:52:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 31 Jul 2020 10:52:50 +0800
Message-ID: <1596163970.3932.24.camel@mtkswgap22>
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
Date:   Fri, 31 Jul 2020 10:52:50 +0800
In-Reply-To: <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_9HXv+OsSRF7P9=cRy9AYZ0vwffgo3Kc8V=qQ6ce90uJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DEF49C35DD5F7474C2C42C04E1153A4CCCB758172807FE52D0D1CF94F024EAA82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gRnJpLCAyMDIwLTA3LTMxIGF0IDAwOjE0ICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0N+aciDI55pelIOmAseS4iSDkuIvljYg0OjI55a+r6YGT
77yaDQo+ID4NCj4gPiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1
cml0eSBzdXBwb3J0IGFuZCBkYXRhDQo+ID4gcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBm
cm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQNCj4gPiBtYXN0ZXJzLg0KPiA+IFRoZSBz
ZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9y
DQo+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4NCj4gPiBBbnkg
b2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0
LCBhbmQNCj4gPiBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFwYyBkcml2ZXIuIFRoZSB2
aW9sYXRpb24NCj4gPiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9yZGVyIHRvIGZpbmQgdGhl
IG11cmRlcmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVhbCBMaXUgPG5lYWwubGl1QG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiArDQo+ID4gKy8qDQo+
ID4gKyAqIGRldmFwY19leHRyYWN0X3Zpb19kYmcgLSBleHRyYWN0IGZ1bGwgdmlvbGF0aW9uIGlu
Zm9ybWF0aW9uIGFmdGVyIGRvaW5nDQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICBz
aGlmdCBtZWNoYW5pc20uDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCBkZXZhcGNfZXh0cmFj
dF92aW9fZGJnKHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmN0eCkNCj4gPiArew0KPiA+ICsg
ICAgICAgY29uc3Qgc3RydWN0IG10a19kZXZhcGNfdmlvX2RiZ3MgKnZpb19kYmdzOw0KPiA+ICsg
ICAgICAgc3RydWN0IG10a19kZXZhcGNfdmlvX2luZm8gKnZpb19pbmZvOw0KPiA+ICsgICAgICAg
dm9pZCBfX2lvbWVtICp2aW9fZGJnMF9yZWc7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKnZp
b19kYmcxX3JlZzsNCj4gPiArICAgICAgIHUzMiBkYmcwOw0KPiA+ICsNCj4gPiArICAgICAgIHZp
b19kYmcwX3JlZyA9IGN0eC0+ZGV2YXBjX3BkX2Jhc2UgKyBjdHgtPm9mZnNldC0+dmlvX2RiZzA7
DQo+ID4gKyAgICAgICB2aW9fZGJnMV9yZWcgPSBjdHgtPmRldmFwY19wZF9iYXNlICsgY3R4LT5v
ZmZzZXQtPnZpb19kYmcxOw0KPiA+ICsNCj4gPiArICAgICAgIHZpb19kYmdzID0gY3R4LT52aW9f
ZGJnczsNCj4gPiArICAgICAgIHZpb19pbmZvID0gY3R4LT52aW9faW5mbzsNCj4gPiArDQo+ID4g
KyAgICAgICAvKiBTdGFydHMgdG8gZXh0cmFjdCB2aW9sYXRpb24gaW5mb3JtYXRpb24gKi8NCj4g
PiArICAgICAgIGRiZzAgPSByZWFkbCh2aW9fZGJnMF9yZWcpOw0KPiA+ICsgICAgICAgdmlvX2lu
Zm8tPnZpb19hZGRyID0gcmVhZGwodmlvX2RiZzFfcmVnKTsNCj4gPiArDQo+ID4gKyAgICAgICB2
aW9faW5mby0+bWFzdGVyX2lkID0gKGRiZzAgJiB2aW9fZGJncy0+bXN0aWQubWFzaykgPj4NCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aW9fZGJncy0+bXN0aWQuc3RhcnQ7DQo+
ID4gKyAgICAgICB2aW9faW5mby0+ZG9tYWluX2lkID0gKGRiZzAgJiB2aW9fZGJncy0+ZG1uaWQu
bWFzaykgPj4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aW9fZGJncy0+ZG1u
aWQuc3RhcnQ7DQo+ID4gKyAgICAgICB2aW9faW5mby0+d3JpdGUgPSAoKGRiZzAgJiB2aW9fZGJn
cy0+dmlvX3cubWFzaykgPj4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlvX2Ri
Z3MtPnZpb193LnN0YXJ0KSA9PSAxOw0KPiA+ICsgICAgICAgdmlvX2luZm8tPnJlYWQgPSAoKGRi
ZzAgJiB2aW9fZGJncy0+dmlvX3IubWFzaykgPj4NCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpb19kYmdzLT52aW9fci5zdGFydCkgPT0gMTsNCj4gPiArICAgICAgIHZpb19pbmZvLT52
aW9fYWRkcl9oaWdoID0gKGRiZzAgJiB2aW9fZGJncy0+YWRkcl9oLm1hc2spID4+DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpb19kYmdzLT5hZGRyX2guc3RhcnQ7DQo+
IA0KPiANCj4gSSB3b3VsZCBsaWtlIHRvIGRlZmluZSB0aGUgdHlwZSBvZiBjdHgtPnZpb19pbmZv
IHRvIGJlDQo+IA0KPiBzdHJ1Y3QgbXRrX2RldmFwY192aW9fZGJncyB7DQo+ICAgICB1MzIgbXN0
aWQ6MTY7DQo+ICAgICB1MzIgZG1uaWQ6NjsNCj4gICAgIHUzMiB2aW9fdzoxOw0KPiAgICAgdTMy
IHZpb19yOjE7DQo+ICAgICB1MzIgYWRkcl9oOjQ7DQo+ICAgICB1MzIgcmVzdjo0Ow0KPiB9Ow0K
PiANCj4gc28gdGhlIGNvZGUgd291bGQgbGlrZSB0aGUgc2ltcGxlIHdheQ0KPiANCj4gY3R4LT52
aW9faW5mbyA9IChzdHJ1Y3QgbXRrX2RldmFwY192aW9fZGJncylyZWFkbCh2aW9fZGJnMV9yZWcp
Ow0KPiANCg0KVGhpcyBpZGVhIGxvb2tzIGdyZWF0ISBJcyB0aGVyZSBhbnkgcG9zc2libGUgdG8g
cGFzcyB0aGUgYml0IGxheW91dCBieQ0KRFQgZGF0YSwgYW5kIHN0aWxsIG1ha2UgdGhpcyBvcGVy
YXRpb24gc2ltcGxlPw0KV2h5IGFtIEkgYXNraW5nIHRoaXMgcXVlc3Rpb24gaXMgYmVjYXVzZSB0
aGlzIGJpdCBsYXlvdXQgaXMgcGxhdGZvcm0NCmRlcGVuZGVudC4NCg0KPiBSZWdhcmRzLA0KPiBD
aHVuLUt1YW5nLg0KPiANCj4gPiArDQo+ID4gKyAgICAgICBkZXZhcGNfdmlvX2luZm9fcHJpbnQo
Y3R4KTsNCj4gPiArfQ0KPiA+ICsNCg0K

