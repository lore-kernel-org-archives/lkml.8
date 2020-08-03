Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A90CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CF0207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sPD4f8bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHCEBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:01:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725921AbgHCEBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:01:39 -0400
X-UUID: f20f4d5fa34f4f68b373f6e91f3d43c2-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1ltDjL6I1nPqUhhubfDBUkh6PYEpQebNL7YJDju5cZw=;
        b=sPD4f8bZby6pDhsvDuLf0ibt3Zn8vdOPdiXLey1i4dxbkW8toSlETlMILSf8nbJ/dQI1iILYmGHaOOVFe6Q5TYO3X+TP0r6LtgUQUHgyp1TpkUwyv2LYnNdpZIMTWV1OYFAco1TDkDgD/orlsQGAD7fKduMKji26nZlP0lgEoGs=;
X-UUID: f20f4d5fa34f4f68b373f6e91f3d43c2-20200803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 109939808; Mon, 03 Aug 2020 12:01:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 12:01:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 12:01:35 +0800
Message-ID: <1596427295.22971.20.camel@mtkswgap22>
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
Date:   Mon, 3 Aug 2020 12:01:35 +0800
In-Reply-To: <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_8aw=6E7bMJwz5jDLXUxYHpy9_Avbwc90osQGckzANNcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gU2F0LCAyMDIwLTA4LTAxIGF0IDA4OjEyICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgZm9yICJt
ZWRpYXRlayxtdDY3NzktZGV2YXBjIiwgc28gSSB0aGluayBjb21taXQgdGl0bGUNCj4gc2hvdWxk
IHNob3cgdGhlIFNvQyBJRC4NCg0KT2theSwgSSdsbCBjaGFuZ2UgdGl0bGUgdG8gJ3NvYzptZWRp
YXRlazogYWRkIG10Njc3OSBkZXZhcGMgZHJpdmVyJy4NCg0KPiANCj4gTmVhbCBMaXUgPG5lYWwu
bGl1QG1lZGlhdGVrLmNvbT4g5pa8IDIwMjDlubQ35pyIMjnml6Ug6YCx5LiJIOS4i+WNiDQ6Mjnl
r6vpgZPvvJoNCj4gPg0KPiA+IE1lZGlhVGVrIGJ1cyBmYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25l
IHNlY3VyaXR5IHN1cHBvcnQgYW5kIGRhdGENCj4gPiBwcm90ZWN0aW9uIHRvIHByZXZlbnQgc2xh
dmVzIGZyb20gYmVpbmcgYWNjZXNzZWQgYnkgdW5leHBlY3RlZA0KPiA+IG1hc3RlcnMuDQo+ID4g
VGhlIHNlY3VyaXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3Nv
ciBmb3INCj4gPiBmdXJ0aGVyIGFuYWx5c2lzIG9yIGNvdW50ZXJtZWFzdXJlcy4NCj4gPg0KPiA+
IEFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xhdGlvbiB3b3VsZCByYWlzZSBhbiBpbnRl
cnJ1cHQsIGFuZA0KPiA+IGl0IHdpbGwgYmUgaGFuZGxlZCBieSBtdGstZGV2YXBjIGRyaXZlci4g
VGhlIHZpb2xhdGlvbg0KPiA+IGluZm9ybWF0aW9uIGlzIHByaW50ZWQgaW4gb3JkZXIgdG8gZmlu
ZCB0aGUgbXVyZGVyZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8bmVhbC5s
aXVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiAr
c3RydWN0IG10a19kZXZhcGNfY29udGV4dCB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXY7DQo+ID4gKyAgICAgICB1MzIgdmlvX2lkeF9udW07DQo+ID4gKyAgICAgICB2b2lkIF9faW9t
ZW0gKmRldmFwY19wZF9iYXNlOw0KPiA+ICsgICAgICAgc3RydWN0IG10a19kZXZhcGNfdmlvX2lu
Zm8gKnZpb19pbmZvOw0KPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IG10a19kZXZhcGNfcGRfb2Zm
c2V0ICpvZmZzZXQ7DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RldmFwY192aW9fZGJn
cyAqdmlvX2RiZ3M7DQo+ID4gK307DQo+IA0KPiBJIHRoaW5rIHRoaXMgc3RydWN0dXJlIHNob3Vs
ZCBzZXBhcmF0ZSB0aGUgY29uc3RhbnQgcGFydC4gVGhlIGNvbnN0YW50IHBhcnQgaXM6DQo+IA0K
PiBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhIHsNCj4gICAgIGNvbnN0IHUzMiB2aW9faWR4X251bTsN
Cj4gICAgIGNvbnN0IHN0cnVjdCBtdGtfZGV2YXBjX3BkX29mZnNldCAqb2Zmc2V0OyAvKiBJIHdv
dWxkIGxpa2UgdG8NCj4gcmVtb3ZlIHN0cnVjdCBtdGtfZGV2YXBjX3BkX29mZnNldCBhbmQgZGly
ZWN0bHkgcHV0IGl0cyBtZW1iZXIgaW50bw0KPiB0aGlzIHN0cnVjdHVyZSAqLw0KPiAgICAgY29u
c3Qgc3RydWN0IG10a19kZXZhcGNfdmlvX2RiZ3MgKnZpb19kYmdzOyAvKiBUaGlzIG1heSBkaXNh
cHBlYXIgKi8NCj4gfTsNCj4gDQo+IEFuZCB0aGUgY29udGV4dCBpczoNCj4gDQo+IHN0cnVjdCBt
dGtfZGV2YXBjX2NvbnRleHQgew0KPiAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgICAgdm9p
ZCBfX2lvbWVtICpkZXZhcGNfcGRfYmFzZTsNCj4gICAgIGNvbnN0IHN0cnVjdCBtdGtfZGV2YXBj
X2RhdGEgKmRhdGE7DQo+IH07DQo+IA0KPiBTbyB3aGVuIHlvdSBkZWZpbmUgdGhpcywgeW91IHdv
dWxkIG5vdCB3YXN0ZSBtZW1vcnkgdG8gc3RvcmUgbm9uLWNvbnN0YW50IGRhdGEuDQo+IA0KPiBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kZXZhcGNfZGF0YSBkZXZhcGNfbXQ2Nzc5ID0gew0KPiAg
LnZpb19pZHhfbnVtID0gNTEwLA0KPiAgLm9mZnNldCA9ICZtdDY3NzlfcGRfb2Zmc2V0LA0KPiAg
LnZpb19kYmdzID0gJm10Njc3OV92aW9fZGJncywNCj4gfTsNCj4gDQoNClNvcnJ5LCBJIHN0aWxs
IGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoaXMgcmVmYWN0b3Jpbmcgd2lsbCBub3Qgd2FzdGUNCm1l
bW9yeSB0byBzdG9yZSBub24tY29uc3RhbnQgZGF0YS4gQ291bGQgeW91IGV4cGxhaW4gbW9yZSBk
ZXRhaWxzPw0KVG8gbXkgdW5kZXJzdGFuZGluZywgd2Ugc3RpbGwgYWxzbyBoYXZlIHRvIGFsbG9j
YXRlIG1lbW9yeSB0byBzdG9yZSBkZXYNCiYgZGV2YXBjX3BkX2Jhc2UuDQoNCj4gUmVnYXJkcywN
Cj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4gKw0KPiA+ICsjZW5kaWYgLyogX19NVEtfREVWQVBDX0hf
XyAqLw0KPiA+IC0tDQo+ID4gMS43LjkuNQ0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+
ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

