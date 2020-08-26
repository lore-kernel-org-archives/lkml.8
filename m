Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8F1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830BF207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hJsl+gk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHZIiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:38:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1643 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbgHZIiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:38:12 -0400
X-UUID: 3db2b801262d4196988bcb3e681503fa-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SeM0LuWXoTr2HkSqQ9VoSRaNEjqOckocCFsNhXZ3E4A=;
        b=hJsl+gk7EdBxoFdn7FxoKEbwNwk7TouXzPjauS9KphbaSLSkercWd8fN9ONODQO+OkflL8/i4C3zWN8exIL2o6ERCLmNK3ZFeDTF4ocolXwZd4G5jPHzfS2CMga29of1JVdEyP8xyK1auSCHBohxTY9fYCX5boQuFSzVelL0CMg=;
X-UUID: 3db2b801262d4196988bcb3e681503fa-20200826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chih-en.hsu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 74354673; Wed, 26 Aug 2020 16:38:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:38:05 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 16:38:03 +0800
Message-ID: <1598431085.604.0.camel@mtksdccf07>
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Remove EFUSE register write support
From:   Chih-En Hsu <chih-en.hsu@mediatek.com>
To:     andrew-ct chen <andrew-ct.chen@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 16:38:05 +0800
In-Reply-To: <1598430653.18394.5.camel@mtksdaap41>
References: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
         <1598430653.18394.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 230897339FD2DDD8A52EDA204395388F61ABE40773C273A37E540230021FF5F42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3Og0KDQpPSywgSSB3aWxsIGZpeCBpdC4NCg0KVGhhbmtzIGEgbG90Lg0KDQpBbGV4
DQoNCk9uIFdlZCwgMjAyMC0wOC0yNiBhdCAxNjozMCArMDgwMCwgYW5kcmV3LWN0IGNoZW4gd3Jv
dGU6DQo+IEhpIENoaWgtRW4sDQo+IA0KPiBPbiBXZWQsIDIwMjAtMDgtMjYgYXQgMTQ6MjEgKzA4
MDAsIENoaWgtRW4gSHN1IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIGZ1bmN0
aW9uICJtdGtfcmVnX3dyaXRlIiBzaW5jZQ0KPiA+IE1lZGlhdGVrIEVGVVNFIGhhcmR3YXJlIG9u
bHkgc3VwcG9ydHMgcmVhZCBmdW5jdGlvbmFsaXR5DQo+ID4gZm9yIE5WTUVNIGNvbnN1bWVycy4N
Cj4gDQo+IFRoZSBmaXhlZCBwYXRjaCBzaG91bGQgYmUgYmEzNjBmZDA0MGUzNCAoIm52bWVtOiBt
dGstZWZ1c2U6IHJlbW92ZSBudm1lbQ0KPiByZWdtYXAgZGVwZW5kZW5jeSIpDQo+IA0KPiA+IEZp
eGVzOiA0YzdlNGZlMzc3NjYgKCJudm1lbTogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBFRlVTRSBk
cml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWgtRW4gSHN1IDxjaGloLWVuLmhzdUBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgfCAxNCAt
LS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgYi9kcml2ZXJzL252
bWVtL210ay1lZnVzZS5jDQo+ID4gaW5kZXggODU2ZDljM2ZjMzhlLi42YTUzN2Q5NTlmMTQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbnZtZW0vbXRrLWVmdXNlLmMNCj4gPiBAQCAtMjgsMTkgKzI4LDYgQEAgc3RhdGljIGludCBt
dGtfcmVnX3JlYWQodm9pZCAqY29udGV4dCwNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4g
IA0KPiA+IC1zdGF0aWMgaW50IG10a19yZWdfd3JpdGUodm9pZCAqY29udGV4dCwNCj4gPiAtCQkJ
IHVuc2lnbmVkIGludCByZWcsIHZvaWQgKl92YWwsIHNpemVfdCBieXRlcykNCj4gPiAtew0KPiA+
IC0Jc3RydWN0IG10a19lZnVzZV9wcml2ICpwcml2ID0gY29udGV4dDsNCj4gPiAtCXUzMiAqdmFs
ID0gX3ZhbDsNCj4gPiAtCWludCBpID0gMCwgd29yZHMgPSBieXRlcyAvIDQ7DQo+ID4gLQ0KPiA+
IC0Jd2hpbGUgKHdvcmRzLS0pDQo+ID4gLQkJd3JpdGVsKCp2YWwrKywgcHJpdi0+YmFzZSArIHJl
ZyArIChpKysgKiA0KSk7DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gLX0NCj4gPiAtDQo+
ID4gIHN0YXRpYyBpbnQgbXRrX2VmdXNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4g
QEAgLTYxLDcgKzQ4LDYgQEAgc3RhdGljIGludCBtdGtfZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiAgCWVjb25maWcuc3RyaWRlID0gNDsNCj4gPiAgCWVjb25m
aWcud29yZF9zaXplID0gNDsNCj4gPiAgCWVjb25maWcucmVnX3JlYWQgPSBtdGtfcmVnX3JlYWQ7
DQo+ID4gLQllY29uZmlnLnJlZ193cml0ZSA9IG10a19yZWdfd3JpdGU7DQo+ID4gIAllY29uZmln
LnNpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+ID4gIAllY29uZmlnLnByaXYgPSBwcml2Ow0K
PiA+ICAJZWNvbmZpZy5kZXYgPSBkZXY7DQo+IA0KPiANCg0K

