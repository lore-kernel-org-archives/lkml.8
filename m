Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899EAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B07C20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DloRHmXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHDCTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:19:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4972 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727064AbgHDCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:19:01 -0400
X-UUID: 714b210253bc4ac982b6e151df2350b5-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cCAvzIsckZTZbTXtmqXfy9+ayjfmU1U5sW/TVt9ABco=;
        b=DloRHmXWV/mcYvA0o2N8rkZ63zmRTA3WK30pEUW/MlFk5x5ojFtX/JPQZ2uHiGjkqOyanloT7k1C5UY2YjR+hfGTAxs2eBFtQBnHWF2HYUkjz46TCT1IZBmoRubm8I8eNA50/25XMaeTG43vj1tYrvTj9op8a6fSvh+iXi7ic3Y=;
X-UUID: 714b210253bc4ac982b6e151df2350b5-20200804
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 999137322; Tue, 04 Aug 2020 10:18:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 10:18:51 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 10:18:51 +0800
Message-ID: <1596507531.17917.10.camel@mtkswgap22>
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
Date:   Tue, 4 Aug 2020 10:18:51 +0800
In-Reply-To: <CAAOTY_9UcnSDTaVPDPyPLsWEYcrcq5MY=z520MWtFdeLw_FqGQ@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_8bE8Qo5-0MA9J1gcEbN4DP=Wf2O6vOUVos=VkoODeayA@mail.gmail.com>
         <1596163478.3932.17.camel@mtkswgap22>
         <CAAOTY_9kS+jrCOpZtOs+L8gBzvkewi+cSN7XWGNxuiMQocedFA@mail.gmail.com>
         <1596425521.22971.13.camel@mtkswgap22>
         <CAAOTY_9UcnSDTaVPDPyPLsWEYcrcq5MY=z520MWtFdeLw_FqGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDgtMDQgYXQgMDA6MTMgKzA4MDAsIENodW4tS3VhbmcgSHUgd3JvdGU6
DQo+IEhpLCBOZWFsOg0KPiANCj4gTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4g5pa8
IDIwMjDlubQ45pyIM+aXpSDpgLHkuIAg5LiK5Y2IMTE6MzLlr6vpgZPvvJoNCj4gPg0KPiA+IEhp
IENodW4tS3VhbmcsDQo+ID4NCj4gPiBPbiBGcmksIDIwMjAtMDctMzEgYXQgMjM6MDMgKzA4MDAs
IENodW4tS3VhbmcgSHUgd3JvdGU6DQo+ID4gPiBIaSwgTmVhbDoNCj4gPiA+DQo+ID4gPiBOZWFs
IExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPiDmlrwgMjAyMOW5tDfmnIgzMeaXpSDpgLHkupQg
5LiK5Y2IMTA6NDTlr6vpgZPvvJoNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQ2h1bi1LdWFuZywNCj4g
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gT24gVGh1LCAyMDIwLTA3LTMwIGF0IDAwOjM4ICswODAw
LCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0KPiA+ID4gPiA+IEhpLCBOZWFsOg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4g5pa8IDIwMjDlubQ35pyI
Mjnml6Ug6YCx5LiJIOS4i+WNiDQ6Mjnlr6vpgZPvvJoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBzdXBwb3J0
IGFuZCBkYXRhDQo+ID4gPiA+ID4gPiBwcm90ZWN0aW9uIHRvIHByZXZlbnQgc2xhdmVzIGZyb20g
YmVpbmcgYWNjZXNzZWQgYnkgdW5leHBlY3RlZA0KPiA+ID4gPiA+ID4gbWFzdGVycy4NCj4gPiA+
ID4gPiA+IFRoZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBw
cm9jZXNzb3IgZm9yDQo+ID4gPiA+ID4gPiBmdXJ0aGVyIGFuYWx5c2lzIG9yIGNvdW50ZXJtZWFz
dXJlcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0
eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0LCBhbmQNCj4gPiA+ID4gPiA+IGl0
IHdpbGwgYmUgaGFuZGxlZCBieSBtdGstZGV2YXBjIGRyaXZlci4gVGhlIHZpb2xhdGlvbg0KPiA+
ID4gPiA+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBvcmRlciB0byBmaW5kIHRoZSBtdXJk
ZXJlci4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8
bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBbc25pcF0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKy8qDQo+
ID4gPiA+ID4gPiArICogZGV2YXBjX2V4dHJhY3RfdmlvX2RiZyAtIGV4dHJhY3QgZnVsbCB2aW9s
YXRpb24gaW5mb3JtYXRpb24gYWZ0ZXIgZG9pbmcNCj4gPiA+ID4gPiA+ICsgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2hpZnQgbWVjaGFuaXNtLg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4g
PiA+ID4gK3N0YXRpYyB2b2lkIGRldmFwY19leHRyYWN0X3Zpb19kYmcoc3RydWN0IG10a19kZXZh
cGNfY29udGV4dCAqY3R4KQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICsgICAgICAgY29u
c3Qgc3RydWN0IG10a19kZXZhcGNfdmlvX2RiZ3MgKnZpb19kYmdzOw0KPiA+ID4gPiA+ID4gKyAg
ICAgICBzdHJ1Y3QgbXRrX2RldmFwY192aW9faW5mbyAqdmlvX2luZm87DQo+ID4gPiA+ID4gPiAr
ICAgICAgIHZvaWQgX19pb21lbSAqdmlvX2RiZzBfcmVnOw0KPiA+ID4gPiA+ID4gKyAgICAgICB2
b2lkIF9faW9tZW0gKnZpb19kYmcxX3JlZzsNCj4gPiA+ID4gPiA+ICsgICAgICAgdTMyIGRiZzA7
DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIHZpb19kYmcwX3JlZyA9IGN0eC0+
ZGV2YXBjX3BkX2Jhc2UgKyBjdHgtPm9mZnNldC0+dmlvX2RiZzA7DQo+ID4gPiA+ID4gPiArICAg
ICAgIHZpb19kYmcxX3JlZyA9IGN0eC0+ZGV2YXBjX3BkX2Jhc2UgKyBjdHgtPm9mZnNldC0+dmlv
X2RiZzE7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIHZpb19kYmdzID0gY3R4
LT52aW9fZGJnczsNCj4gPiA+ID4gPiA+ICsgICAgICAgdmlvX2luZm8gPSBjdHgtPnZpb19pbmZv
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAgICAvKiBTdGFydHMgdG8gZXh0cmFj
dCB2aW9sYXRpb24gaW5mb3JtYXRpb24gKi8NCj4gPiA+ID4gPiA+ICsgICAgICAgZGJnMCA9IHJl
YWRsKHZpb19kYmcwX3JlZyk7DQo+ID4gPiA+ID4gPiArICAgICAgIHZpb19pbmZvLT52aW9fYWRk
ciA9IHJlYWRsKHZpb19kYmcxX3JlZyk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAg
ICAgIHZpb19pbmZvLT5tYXN0ZXJfaWQgPSAoZGJnMCAmIHZpb19kYmdzLT5tc3RpZC5tYXNrKSA+
Pg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlvX2RiZ3MtPm1z
dGlkLnN0YXJ0Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCBpcyBtYXN0ZXJfaWQ/IEhvdyBj
b3VsZCB3ZSB1c2UgaXQgdG8gZGVidWc/IEZvciBleGFtcGxlLCBpZiB3ZQ0KPiA+ID4gPiA+IGdl
dCBhIG1hc3Rlcl9pZCA9IDEsIHdoYXQgc2hvdWxkIHdlIGRvIGZvciB0aGlzPw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiArICAgICAgIHZpb19pbmZvLT5kb21haW5faWQgPSAoZGJnMCAmIHZpb19k
YmdzLT5kbW5pZC5tYXNrKSA+Pg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmlvX2RiZ3MtPmRtbmlkLnN0YXJ0Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCBp
cyBkb21haW5faWQ/IEhvdyBjb3VsZCB3ZSB1c2UgaXQgdG8gZGVidWc/IEZvciBleGFtcGxlLCBp
ZiB3ZQ0KPiA+ID4gPiA+IGdldCBhIGRvbWFpbl9pZCA9IDIsIHdoYXQgc2hvdWxkIHdlIGRvIGZv
ciB0aGlzPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IG1hc3Rlcl9pZCBhbmQgZG9tYWlu
X2lkIGJlbG9uZ3Mgb3VyIGJ1cyBzaWRlLWJhbmQgc2lnbmFsIGluZm8uIEl0IGNhbg0KPiA+ID4g
PiBoZWxwIHVzIHRvIGZpbmQgdGhlIHZpb2xhdGlvbiBtYXN0ZXIuDQo+ID4gPg0KPiA+ID4gRG9l
cyAndmlvbGF0aW9uIG1hc3RlcicgbWVhbnMgdGhlIGhhcmR3YXJlIGNvdWxkIGFjY2VzcyB0aGUg
cHJvdGVjdGVkDQo+ID4gPiByZWdpc3Rlcj8gKGV4LiBDUFUsIEdDRSwgLi4uKSBJZiBzbywgSSB0
aGluayBpdCdzIGJldHRlciB0byBhZGQNCj4gPiA+IGNvbW1lbnQgdG8gZXhwbGFpbiBob3cgdG8g
bWFwIChtYXN0ZXJfaWQsIGRvbWFpbl9pZCkgdG8gYSBoYXJkd2FyZQ0KPiA+ID4gKG1heWJlIHRo
ZSBkZXZpY2UgaW4gZGV2aWNlIHRyZWUpIGJlY2F1c2UgZXZlcnkgYm9keSBkb2VzIG5vdCBrbm93
DQo+ID4gPiB3aGF0IHRoZSBudW1iZXIgbWVhbnMuIERvbid0IHRyeSB0byB0cmFuc2xhdGUgdGhl
IG51bWJlciB0byBhIHN0cmluZw0KPiA+ID4gYmVjYXVzZSB0aGlzIHdvdWxkIGNvc3QgbXVjaCB0
aW1lIHRvIGRvIHRoaXMuIEp1c3QgcHJpbnQgYSBudW1iZXIgYW5kDQo+ID4gPiB3ZSBjb3VsZCBm
aW5kIG91dCB0aGUgbWFzdGVyIGJ5IHRoZSBjb21tZW50Lg0KPiA+DQo+ID4gJ3Zpb2xhdGlvbiBt
YXN0ZXInIG1lYW5zIHRoZSBtYXN0ZXIgd2hpY2ggdmlvbGF0ZXMgdGhlIHBlcm1pc3Npb24NCj4g
PiBjb250cm9sLiBGb3IgZXhhbXBsZSwgaWYgd2Ugc2V0IHBlcm1pc3Npb24gJ1NlY3VyZSBSL1cg
b25seScgYXMgQ1BVIHRvDQo+ID4gc3BpIHJlZ2lzdGVyLiBXaGVuIHZpb2xhdGlvbiBpcyB0cmln
Z2VyZWQsIGl0IG1lYW5zIENQVSBhY2Nlc3Mgc3BpDQo+ID4gcmVnaXN0ZXIgdGhyb3VnaCBub3Jt
YWwgd29ybGQgaW5zdGVhZCBvZiBzZWN1cmUgd29ybGQsIHdoaWNoIGlzIG5vdA0KPiA+IGFsbG93
ZWQuDQo+ID4NCj4gPiAnbWFzdGVyX2lkJyBjYW5ub3QgdXNlIHRoZSBzaW1wbGUgY29tbWVudHMg
dG8gZGVzY3JpYmUgd2hpY2ggbWFzdGVyIGl0DQo+ID4gaXMuIEl0IGRlcGVuZHMgb24gdmlvbGF0
aW9uIHNsYXZlcy4gRm9yIGV4YW1wbGUsIGlmIHRoZXJlIGFyZSB0d28NCj4gPiB2aW9sYXRpb25z
Og0KPiA+IDEuIENQVSBhY2Nlc3Mgc3BpIHJlZw0KPiA+IDIuIENQVSBhY2Nlc3MgdGltZXIgcmVn
DQo+ID4gSXQgbWlnaHQgYmUgZGlmZmVyZW50ICdtYXN0ZXJfaWQnIGZvciBDUFUgb24gdGhlc2Ug
dHdvIGNhc2VzLg0KPiA+IEkgd291bGQgcHJlZmVyIHRvIHJlbWFpbiB0aGUgaWQgbnVtYmVyIGlm
IHRyYW5zbGF0ZSB0byBhIHN0cmluZyBpcyBhIGJhZA0KPiA+IGlkZWEuDQo+ID4gVGhhbmtzICEN
Cj4gDQo+IEl0IHNlYW1zIHRoYXQgbWFzdGVyX2lkIGFuZCBkb21haW5faWQgZG9lcyBub3QgaGVs
cCBmb3IgZGVidWcuIFdoZW4gd2UNCj4gZ2V0IG1hc3Rlcl9pZCA9IDEgYW5kIGRvbWFpbl9pZCA9
IDIsIHdlIGRvbid0IGtub3cgd2hhdCBpdCBtZWFuLiBJDQo+IHRoaW5rIHdlIGp1c3QgbmVlZCB2
aW9sYXRpb24gYWRkcmVzcyBiZWNhdXNlIHdlIGNvdWxkIGZpbmQgdGhlIGRyaXZlcg0KPiB0aGF0
IHdyaXRlIHRoaXMgYWRkcmVzcyBhbmQgdGhlIGJ1ZyB3b3VsZCBiZSBpbnNpZGUgdGhpcyBkcml2
ZXIuIFNvDQo+IG5lZWQgbm90IHRvIHByb2Nlc3MgbWFzdGVyX2lkIGFuZCBkb21haW5faWQuDQo+
IA0KDQpBY3R1YWxseSwgaXQgZG9lcyBoZWxwIHVzIGZvciBkZWJ1Zy4gdmlvbGF0aW9uIG1hc3Rl
ciBpcyBub3QgQ1BVIG9ubHkuDQpJdCBtaWdodCBiZSBhbnkgb3RoZXIgbWFzdGVyIGluIG91ciBT
b0MuIFNvIHRoZSBidWcgbWlnaHQgbm90IGJlIGluc2lkZQ0KdGhlIGtlcm5lbCBkcml2ZXIuDQpJ
J2xsIHByZWZlciB0byByZW1haW4gdGhpcyBpbmZvcm1hdGlvbi4NClRoYW5rcyAhDQoNCj4gUmVn
YXJkcywNCj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4g
PiArICAgICAgIHZpb19pbmZvLT53cml0ZSA9ICgoZGJnMCAmIHZpb19kYmdzLT52aW9fdy5tYXNr
KSA+Pg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpb19kYmdzLT52
aW9fdy5zdGFydCkgPT0gMTsNCj4gPiA+ID4gPiA+ICsgICAgICAgdmlvX2luZm8tPnJlYWQgPSAo
KGRiZzAgJiB2aW9fZGJncy0+dmlvX3IubWFzaykgPj4NCj4gPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgdmlvX2RiZ3MtPnZpb19yLnN0YXJ0KSA9PSAxOw0KPiA+ID4gPiA+ID4g
KyAgICAgICB2aW9faW5mby0+dmlvX2FkZHJfaGlnaCA9IChkYmcwICYgdmlvX2RiZ3MtPmFkZHJf
aC5tYXNrKSA+Pg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZpb19kYmdzLT5hZGRyX2guc3RhcnQ7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGlzIHZp
b19hZGRyX2hpZ2g/IEFzIEkga25vdyBhbGwgcmVnaXN0ZXIgYWRkcmVzcyBhcmUgMzIgYml0cywg
aXMNCj4gPiA+ID4gPiB2aW9fYWRkcl9oaWdoIHRoZSBhZGRyZXNzIGFib3ZlIDMyIGJpdHM/DQo+
ID4gPiA+DQo+ID4gPiA+IFllcywgeW91IGFyZSByaWdodC4gSW4gTVQ2Nzc5LCBhbGwgcmVnaXN0
ZXIgYmFzZSBhcmUgMzIgYml0cy4gV2UgY2FuDQo+ID4gPiA+IGlnbm9yZSB0aGlzIGluZm8gZm9y
IGN1cnJlbnQgZHJpdmVyLiBJJ2xsIHVwZGF0ZSBvbiBuZXh0IHBhdGNoLg0KPiA+ID4gPiBUaGFu
a3MgIQ0KPiA+ID4NCj4gPiA+IFN1Y2ggYSBzdHJhbmdlIGhhcmR3YXJlLCBhbGwgcmVnaXN0ZXIg
aXMgMzIgYml0cyBidXQgaXQgaGFzIGENCj4gPiA+IHZpb19hZGRyX2hpZ2ggaW4gaXRzIHJlZ2lz
dGVyLiBPSywganVzdCBkcm9wIHRoaXMuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIGRldmFwY192aW9faW5mb19wcmludChjdHgp
Ow0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPg0KDQo=

