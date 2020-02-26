Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D5C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0B222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KCj77MDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgBZCJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:09:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:11315 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgBZCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:09:01 -0500
X-UUID: 3d4c6f9141cf485caad1c856ab37d957-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4G50YT7BXruqV2bmMQ1wFG6jQuwy2URnoGbMjXzFMIU=;
        b=KCj77MDHGBUI5+HsG1pveLqvpV1Ohv+SDCeRpDLBbwfqhlPOK58JXecbgYKHrcb39OPvxqyxkvA/uH2u9YJohLi36N0JNAL2QnQTlJN9LjsMg4+kddnasRC6wNgcGEMGudj2nOPkce2q/vNf4H2mAv3M8sE9Iykx/bBsusi8AGY=;
X-UUID: 3d4c6f9141cf485caad1c856ab37d957-20200226
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 347331116; Wed, 26 Feb 2020 10:08:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 10:08:04 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 10:09:02 +0800
Message-ID: <1582682933.16944.8.camel@mtksdaap41>
Subject: Re: [PATCH v8 5/7] drm/mediatek: dpi sample mode support
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>
Date:   Wed, 26 Feb 2020 10:08:53 +0800
In-Reply-To: <20200225094057.120144-6-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-6-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDE3OjQwICswODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+IERQ
SSBjYW4gc2FtcGxlIG9uIGZhbGxpbmcsIHJpc2luZyBvciBib3RoIGVkZ2UuDQo+IFdoZW4gRFBJ
IHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KPiBJdCBjYW4g
cmVkdWNlIGhhbGYgZGF0YSBpbyBwaW5zLg0KPiANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlA
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBp
LmMgfCAxOCArKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
DQo+IGluZGV4IDAxZmE4YjhkNzYzZC4uZGY1OThmODdhNDBmIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMNCj4gQEAgLTc1LDYgKzc1LDcgQEAgc3RydWN0IG10a19kcGkgew0K
PiAgCWVudW0gbXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KPiAgCWVudW0gbXRrX2RwaV9v
dXRfY2hhbm5lbF9zd2FwIGNoYW5uZWxfc3dhcDsNCj4gIAlpbnQgcmVmY291bnQ7DQo+ICsJdTMy
IHBjbGtfc2FtcGxlOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbXRrX2Rw
aSAqbXRrX2RwaV9mcm9tX2VuY29kZXIoc3RydWN0IGRybV9lbmNvZGVyICplKQ0KPiBAQCAtMzQ4
LDYgKzM0OSwxMyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZpZ19kaXNhYmxlX2VkZ2Uoc3Ry
dWN0IG10a19kcGkgKmRwaSkNCj4gIAkJbXRrX2RwaV9tYXNrKGRwaSwgZHBpLT5jb25mLT5yZWdf
aF9mcmVfY29uLCAwLCBFREdFX1NFTF9FTik7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIG10
a19kcGlfZW5hYmxlX3BjbGtfc2FtcGxlX2R1YWxfZWRnZShzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0K
PiArew0KPiArCW10a19kcGlfbWFzayhkcGksIERQSV9ERFJfU0VUVElORywgRERSX0VOIHwgRERS
XzRQSEFTRSwNCj4gKwkJICAgICBERFJfRU4gfCBERFJfNFBIQVNFKTsNCj4gKwltdGtfZHBpX21h
c2soZHBpLCBEUElfT1VUUFVUX1NFVFRJTkcsIEVER0VfU0VMLCBFREdFX1NFTCk7DQo+ICt9DQo+
ICsNCj4gIHN0YXRpYyB2b2lkIG10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChzdHJ1Y3QgbXRr
X2RwaSAqZHBpLA0KPiAgCQkJCQllbnVtIG10a19kcGlfb3V0X2NvbG9yX2Zvcm1hdCBmb3JtYXQp
DQo+ICB7DQo+IEBAIC00MzksNyArNDQ3LDggQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNw
bGF5X21vZGUoc3RydWN0IG10a19kcGkgKmRwaSwNCj4gIAlwbGxfcmF0ZSA9IGNsa19nZXRfcmF0
ZShkcGktPnR2ZF9jbGspOw0KPiAgDQo+ICAJdm0ucGl4ZWxjbG9jayA9IHBsbF9yYXRlIC8gZmFj
dG9yOw0KPiAtCWNsa19zZXRfcmF0ZShkcGktPnBpeGVsX2Nsaywgdm0ucGl4ZWxjbG9jayk7DQo+
ICsJY2xrX3NldF9yYXRlKGRwaS0+cGl4ZWxfY2xrLA0KPiArCQkgICAgIHZtLnBpeGVsY2xvY2sg
KiAoZHBpLT5wY2xrX3NhbXBsZSA+IDEgPyAyIDogMSkpOw0KPiAgCXZtLnBpeGVsY2xvY2sgPSBj
bGtfZ2V0X3JhdGUoZHBpLT5waXhlbF9jbGspOw0KPiAgDQo+ICAJZGV2X2RiZyhkcGktPmRldiwg
IkdvdCAgUExMICVsdSBIeiwgcGl4ZWwgY2xvY2sgJWx1IEh6XG4iLA0KPiBAQCAtNDUwLDcgKzQ1
OSw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVjdCBtdGtfZHBp
ICpkcGksDQo+ICAJbGltaXQueV9ib3R0b20gPSAweDAwMTA7DQo+ICAJbGltaXQueV90b3AgPSAw
eDBGRTA7DQo+ICANCj4gLQlkcGlfcG9sLmNrX3BvbCA9IE1US19EUElfUE9MQVJJVFlfRkFMTElO
RzsNCj4gKwlkcGlfcG9sLmNrX3BvbCA9IGRwaS0+cGNsa19zYW1wbGUgPT0gMSA/DQo+ICsJCQkg
TVRLX0RQSV9QT0xBUklUWV9SSVNJTkcgOiBNVEtfRFBJX1BPTEFSSVRZX0ZBTExJTkc7DQo+ICAJ
ZHBpX3BvbC5kZV9wb2wgPSBNVEtfRFBJX1BPTEFSSVRZX1JJU0lORzsNCj4gIAlkcGlfcG9sLmhz
eW5jX3BvbCA9IHZtLmZsYWdzICYgRElTUExBWV9GTEFHU19IU1lOQ19ISUdIID8NCj4gIAkJCSAg
ICBNVEtfRFBJX1BPTEFSSVRZX0ZBTExJTkcgOiBNVEtfRFBJX1BPTEFSSVRZX1JJU0lORzsNCj4g
QEAgLTUwNCw2ICs1MTQsOCBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShz
dHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiAgCW10a19kcGlfY29uZmlnX2NvbG9yX2Zvcm1hdChkcGks
IGRwaS0+Y29sb3JfZm9ybWF0KTsNCj4gIAltdGtfZHBpX2NvbmZpZ18ybl9oX2ZyZShkcGkpOw0K
PiAgCW10a19kcGlfY29uZmlnX2Rpc2FibGVfZWRnZShkcGkpOw0KPiArCWlmIChkcGktPnBjbGtf
c2FtcGxlID4gMSkNCj4gKwkJbXRrX2RwaV9lbmFibGVfcGNsa19zYW1wbGVfZHVhbF9lZGdlKGRw
aSk7DQo+ICAJbXRrX2RwaV9zd19yZXNldChkcGksIGZhbHNlKTsNCj4gIA0KPiAgCXJldHVybiAw
Ow0KPiBAQCAtNjg5LDYgKzcwMSw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJZHBpLT5kZXYgPSBkZXY7DQo+ICAJZHBp
LT5jb25mID0gKHN0cnVjdCBtdGtfZHBpX2NvbmYgKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEo
ZGV2KTsNCj4gKwlvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsICJwY2xr
LXNhbXBsZSIsIDEsDQo+ICsJCQkJICAgJmRwaS0+cGNsa19zYW1wbGUpOw0KPiAgDQo+ICAJbWVt
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gIAlk
cGktPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBtZW0pOw0KDQo=

