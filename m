Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A6FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C192076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rjB/g/PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgEXRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:32:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47943 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387656AbgEXRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:32:07 -0400
X-UUID: a81777fc366a4390920a534f53bb5e25-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bEukpIDc33kmSBnyaSWesUR3coz87RG9SGtY78KDiQM=;
        b=rjB/g/PYoVvsoAeButEc65q4Ml22yNb+QvyhY2w8xqxgta7N/5GD7nNL4ki47C4h0pkRq+QNiGRWnyqWEnr32TdrSGnQjnVLgyIEU2Xlh+CywLgKsC/H+0sDEOK7lw05ldhiA8fBPvkfKV3aBYKu5DbxwWn6kXLOIk4e2Uk0/rk=;
X-UUID: a81777fc366a4390920a534f53bb5e25-20200525
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1274283432; Mon, 25 May 2020 01:32:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 May 2020 01:31:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 01:31:59 +0800
Message-ID: <1590341522.31286.20.camel@mtkswgap22>
Subject: Re: [PATCH v5 10/13] soc: mediatek: cmdq: export finalize function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 25 May 2020 01:32:02 +0800
In-Reply-To: <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <5d6b61b2-23c9-647f-fa22-73e779010bd8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBTYXQsIDIwMjAt
MDUtMTYgYXQgMjA6MjIgKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAw
OC8wMy8yMDIwIDExOjUyLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gRXhwb3J0IGZpbmFs
aXplIGZ1bmN0aW9uIHRvIGNsaWVudCB3aGljaCBoZWxwcyBhcHBlbmQgZW9jIGFuZCBqdW1wDQo+
ID4gY29tbWFuZCB0byBwa3QuIExldCBjbGllbnQgZGVjaWRlIGNhbGwgZmluYWxpemUgb3Igbm90
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhz
aWVoQG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jIHwgMSArDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICB8
IDcgKystLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAg
fCA4ICsrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gaW5kZXggMGRmY2QxNzg3ZTY1Li43ZGFhYWJjMjZlYjEgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTQ5MCw2ICs0OTAs
NyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBtdGtfZHJtX2Ny
dGMgKm10a19jcnRjKQ0KPiA+ICAJCWNtZHFfcGt0X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBt
dGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gIAkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBt
dGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBj
bWRxX2hhbmRsZSk7DQo+ID4gKwkJY21kcV9wa3RfZmluYWxpemUoY21kcV9oYW5kbGUpOw0KPiA+
ICAJCWNtZHFfcGt0X2ZsdXNoX2FzeW5jKGNtZHFfaGFuZGxlLCBkZHBfY21kcV9jYiwgY21kcV9o
YW5kbGUpOw0KPiA+ICAJfQ0KPiA+ICAjZW5kaWYNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGEgaW5k
ZXBlbmRlbnQgcGF0Y2guDQo+IE90aGVyIHRoZW4gdGhhdCBwYXRjaCBsb29rcyBnb29kLg0KDQpv
aywgSSdsbCBzZXBhcmF0ZSB0aGlzIHBhcnQuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQo+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBi
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggYTllYmJh
YmI3NDM5Li41OWJjMTE2NGI0MTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiA+IEBAIC0zNzIsNyArMzcyLDcgQEAgaW50IGNtZHFfcGt0X2Fzc2ln
bihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCj4gPiAgfQ0K
PiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+ID4gIA0KPiA+IC1zdGF0aWMg
aW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICtpbnQgY21k
cV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ID4gIHsNCj4gPiAgCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICAJaW50IGVycjsNCj4gPiBA
QCAtMzkyLDYgKzM5Miw3IEBAIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QpDQo+ID4gIA0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+ICtFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X2ZpbmFsaXplKTsNCj4gPiAgDQo+ID4gIHN0YXRpYyB2b2lkIGNt
ZHFfcGt0X2ZsdXNoX2FzeW5jX2NiKHN0cnVjdCBjbWRxX2NiX2RhdGEgZGF0YSkNCj4gPiAgew0K
PiA+IEBAIC00MjYsMTAgKzQyNyw2IEBAIGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgY21kcV9hc3luY19mbHVzaF9jYiBjYiwNCj4gPiAgCXVuc2lnbmVkIGxv
bmcgZmxhZ3MgPSAwOw0KPiA+ICAJc3RydWN0IGNtZHFfY2xpZW50ICpjbGllbnQgPSAoc3RydWN0
IGNtZHFfY2xpZW50ICopcGt0LT5jbDsNCj4gPiAgDQo+ID4gLQllcnIgPSBjbWRxX3BrdF9maW5h
bGl6ZShwa3QpOw0KPiA+IC0JaWYgKGVyciA8IDApDQo+ID4gLQkJcmV0dXJuIGVycjsNCj4gPiAt
DQo+ID4gIAlwa3QtPmNiLmNiID0gY2I7DQo+ID4gIAlwa3QtPmNiLmRhdGEgPSBkYXRhOw0KPiA+
ICAJcGt0LT5hc3luY19jYi5jYiA9IGNtZHFfcGt0X2ZsdXNoX2FzeW5jX2NiOw0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IGZlYzI5MmFhYzgzYy4uOTll
NzcxNTVmOTY3IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQo+ID4gQEAgLTIxMyw2ICsyMTMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+ICAgKi8NCj4gPiAgaW50IGNtZHFfcGt0X2Fz
c2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSk7DQo+ID4g
IA0KPiA+ICsvKioNCj4gPiArICogY21kcV9wa3RfZmluYWxpemUoKSAtIEFwcGVuZCBFT0MgYW5k
IGp1bXAgY29tbWFuZCB0byBwa3QuDQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+
ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUg
aXMgcmV0dXJuZWQNCj4gPiArICovDQo+ID4gK2ludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3RfZmx1c2hf
YXN5bmMoKSAtIHRyaWdnZXIgQ01EUSB0byBhc3luY2hyb25vdXNseSBleGVjdXRlIHRoZSBDTURR
DQo+ID4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICBwYWNrZXQgYW5kIGNhbGwgYmFjayBh
dCB0aGUgZW5kIG9mIGRvbmUgcGFja2V0DQo+ID4gDQoNCg==

