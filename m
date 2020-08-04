Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637AA20781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lz5xpKJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHDCIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:08:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53493 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgHDCIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:08:19 -0400
X-UUID: d56bcd55be65427baf041fcbb342cc98-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fgyIQ7DsULlTTKIxA3Jlyx2v6bU2W2sQc//rLVyQcYE=;
        b=Lz5xpKJ+f85TAWAFi4aRa830BUJDuzh8wcnYLAHoehkgjDIyPbSoTJSqau/rRx2gorfIAbBs6dsz4ISHxViTXhjLl2Wj++dUERIj3thL9kkne97EF2iJzvV1i0kzBvRAxaa0EnQxcvWgiiWgKe5OATdx6sCy4EpOS9029R13peM=;
X-UUID: d56bcd55be65427baf041fcbb342cc98-20200804
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1559518393; Tue, 04 Aug 2020 10:08:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 10:08:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 10:08:13 +0800
Message-ID: <1596506892.17917.2.camel@mtkswgap22>
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
Date:   Tue, 4 Aug 2020 10:08:12 +0800
In-Reply-To: <CAAOTY__VPXMGcR9w8EdnGbJyVbxbLQY+SRAqLbOcTy0D_WLM0w@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
         <1596427295.22971.20.camel@mtkswgap22>
         <CAAOTY__VPXMGcR9w8EdnGbJyVbxbLQY+SRAqLbOcTy0D_WLM0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A1D2B56BE3B7D7DFFE750BB73D1DE48D8AD510E630AE667407D111F587BA25032000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTA0IGF0IDAwOjA0ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAy
MDIw5bm0OOaciDPml6Ug6YCx5LiAIOS4i+WNiDEyOjAx5a+r6YGT77yaDQo+ID4NCj4gPiBIaSBD
aHVuLUt1YW5nLA0KPiA+DQo+ID4gT24gU2F0LCAyMDIwLTA4LTAxIGF0IDA4OjEyICswODAwLCBD
aHVuLUt1YW5nIEh1IHdyb3RlOg0KPiA+ID4gSGksIE5lYWw6DQo+ID4gPg0KPiA+ID4gVGhpcyBw
YXRjaCBpcyBmb3IgIm1lZGlhdGVrLG10Njc3OS1kZXZhcGMiLCBzbyBJIHRoaW5rIGNvbW1pdCB0
aXRsZQ0KPiA+ID4gc2hvdWxkIHNob3cgdGhlIFNvQyBJRC4NCj4gPg0KPiA+IE9rYXksIEknbGwg
Y2hhbmdlIHRpdGxlIHRvICdzb2M6bWVkaWF0ZWs6IGFkZCBtdDY3NzkgZGV2YXBjIGRyaXZlcicu
DQo+ID4NCj4gPiA+DQo+ID4gPiBOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPiDmlrwg
MjAyMOW5tDfmnIgyOeaXpSDpgLHkuIkg5LiL5Y2INDoyOeWvq+mBk++8mg0KPiA+ID4gPg0KPiA+
ID4gPiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBzdXBw
b3J0IGFuZCBkYXRhDQo+ID4gPiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBi
ZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkDQo+ID4gPiA+IG1hc3RlcnMuDQo+ID4gPiA+IFRo
ZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3Ig
Zm9yDQo+ID4gPiA+IGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4g
Pg0KPiA+ID4gPiBBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFp
c2UgYW4gaW50ZXJydXB0LCBhbmQNCj4gPiA+ID4gaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1k
ZXZhcGMgZHJpdmVyLiBUaGUgdmlvbGF0aW9uDQo+ID4gPiA+IGluZm9ybWF0aW9uIGlzIHByaW50
ZWQgaW4gb3JkZXIgdG8gZmluZCB0aGUgbXVyZGVyZXIuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4NCj4gPiA+IFtzbmlwXQ0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RydWN0IG10
a19kZXZhcGNfY29udGV4dCB7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0K
PiA+ID4gPiArICAgICAgIHUzMiB2aW9faWR4X251bTsNCj4gPiA+ID4gKyAgICAgICB2b2lkIF9f
aW9tZW0gKmRldmFwY19wZF9iYXNlOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBtdGtfZGV2YXBj
X3Zpb19pbmZvICp2aW9faW5mbzsNCj4gPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2Rl
dmFwY19wZF9vZmZzZXQgKm9mZnNldDsNCj4gPiA+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgbXRr
X2RldmFwY192aW9fZGJncyAqdmlvX2RiZ3M7DQo+ID4gPiA+ICt9Ow0KPiA+ID4NCj4gPiA+IEkg
dGhpbmsgdGhpcyBzdHJ1Y3R1cmUgc2hvdWxkIHNlcGFyYXRlIHRoZSBjb25zdGFudCBwYXJ0LiBU
aGUgY29uc3RhbnQgcGFydCBpczoNCj4gPiA+DQo+ID4gPiBzdHJ1Y3QgbXRrX2RldmFwY19kYXRh
IHsNCj4gPiA+ICAgICBjb25zdCB1MzIgdmlvX2lkeF9udW07DQo+ID4gPiAgICAgY29uc3Qgc3Ry
dWN0IG10a19kZXZhcGNfcGRfb2Zmc2V0ICpvZmZzZXQ7IC8qIEkgd291bGQgbGlrZSB0bw0KPiA+
ID4gcmVtb3ZlIHN0cnVjdCBtdGtfZGV2YXBjX3BkX29mZnNldCBhbmQgZGlyZWN0bHkgcHV0IGl0
cyBtZW1iZXIgaW50bw0KPiA+ID4gdGhpcyBzdHJ1Y3R1cmUgKi8NCj4gPiA+ICAgICBjb25zdCBz
dHJ1Y3QgbXRrX2RldmFwY192aW9fZGJncyAqdmlvX2RiZ3M7IC8qIFRoaXMgbWF5IGRpc2FwcGVh
ciAqLw0KPiA+ID4gfTsNCj4gPiA+DQo+ID4gPiBBbmQgdGhlIGNvbnRleHQgaXM6DQo+ID4gPg0K
PiA+ID4gc3RydWN0IG10a19kZXZhcGNfY29udGV4dCB7DQo+ID4gPiAgICAgc3RydWN0IGRldmlj
ZSAqZGV2Ow0KPiA+ID4gICAgIHZvaWQgX19pb21lbSAqZGV2YXBjX3BkX2Jhc2U7DQo+ID4gPiAg
ICAgY29uc3Qgc3RydWN0IG10a19kZXZhcGNfZGF0YSAqZGF0YTsNCj4gPiA+IH07DQo+ID4gPg0K
PiA+ID4gU28gd2hlbiB5b3UgZGVmaW5lIHRoaXMsIHlvdSB3b3VsZCBub3Qgd2FzdGUgbWVtb3J5
IHRvIHN0b3JlIG5vbi1jb25zdGFudCBkYXRhLg0KPiA+ID4NCj4gPiA+IHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RldmFwY19kYXRhIGRldmFwY19tdDY3NzkgPSB7DQo+ID4gPiAgLnZpb19pZHhf
bnVtID0gNTEwLA0KPiA+ID4gIC5vZmZzZXQgPSAmbXQ2Nzc5X3BkX29mZnNldCwNCj4gPiA+ICAu
dmlvX2RiZ3MgPSAmbXQ2Nzc5X3Zpb19kYmdzLA0KPiA+ID4gfTsNCj4gPiA+DQo+ID4NCj4gPiBT
b3JyeSwgSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGlzIHJlZmFjdG9yaW5nIHdpbGwg
bm90IHdhc3RlDQo+ID4gbWVtb3J5IHRvIHN0b3JlIG5vbi1jb25zdGFudCBkYXRhLiBDb3VsZCB5
b3UgZXhwbGFpbiBtb3JlIGRldGFpbHM/DQo+ID4gVG8gbXkgdW5kZXJzdGFuZGluZywgd2Ugc3Rp
bGwgYWxzbyBoYXZlIHRvIGFsbG9jYXRlIG1lbW9yeSB0byBzdG9yZSBkZXYNCj4gPiAmIGRldmFw
Y19wZF9iYXNlLg0KPiANCj4gSW4gc29tZSBzaXR1YXRpb24sIGl0IGlzLiBZb3UgbWFrZSB0aGUg
bm9uLWNvbnN0YW50IGRhdGEgYSBnbG9iYWwNCj4gdmFyaWFibGUuIEkgdGhpbmsgdGhlIGNvbnRl
eHQgZGF0YSBzaG91bGQgYmUgZHluYW1pYyBhbGxvY2F0ZWQuIElmDQo+IHRoaXMgZHJpdmVyIGlz
IG5vdCBwcm9iZWQsIHRoZSBub24tY29uc3RhbnQgZGF0YSBvY2N1cHkgdGhlIG1lbW9yeS4NCj4g
DQoNCkkgZ290IHlvdXIgcG9pbnQhIEluIHRoaXMgY2FzZSwgd2UgY2FuIHNhdmUgdGhlc2UgMiBk
YXRhIHN0cnVjdHVyZQ0Kc3BhY2UsIHJpZ2h0Pw0KDQpzdHJ1Y3QgZGV2aWNlICpkZXY7DQp2b2lk
IF9faW9tZW0gKmRldmFwY19wZF9iYXNlOw0KDQpJJ2xsIHJlZmFjdG9yaW5nIHRoaXMgZGF0YSBz
dHJ1Y3R1cmVzIG9uIG5leHQgcGF0Y2guIFRoYW5rcyAhDQoNCj4gUmVnYXJkcywNCj4gQ2h1bi1L
dWFuZy4NCj4gDQo+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDaHVuLUt1YW5nLg0KPiA+ID4N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArI2VuZGlmIC8qIF9fTVRLX0RFVkFQQ19IX18gKi8NCj4gPiA+
ID4gLS0NCj4gPiA+ID4gMS43LjkuNQ0KPiA+ID4gPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4gPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxp
c3QNCj4gPiA+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVr
DQo+ID4NCg0K

