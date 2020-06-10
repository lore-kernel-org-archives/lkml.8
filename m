Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66260207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NL4pbin7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgFJFr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:47:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:4095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726249AbgFJFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:47:26 -0400
X-UUID: 4df5e063d4354aa3ae61207f68479f05-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=R2nKHBp5Cvsj2AhiULL9paxjnUyMgPHkofrlWMrINHY=;
        b=NL4pbin7KeDovszSfsOG3qB4M0CD3YS0FscB7IQtqlzpt0oYhA+X0ZBzEI04O5LwT2T5jp1dh4GaL2arl/v2SHASJCxdA0Aq3i8v65FOWd3gHqZomJ4KjRbm+To/crQV9J781b1ZFGM8vA/yfpSrTmF6S198eFFmWzSNhWXlhZE=;
X-UUID: 4df5e063d4354aa3ae61207f68479f05-20200610
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 445095560; Wed, 10 Jun 2020 13:47:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 13:47:17 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 13:47:17 +0800
Message-ID: <1591768038.527.6.camel@mtksdaap41>
Subject: Re: [PATCH v4 09/17] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From:   CK Hu <ck.hu@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Maoguang Meng <Maoguang.Meng@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <eizan@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <ming-fan.chen@mediatek.com>,
        <anan.sun@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
        <acourbot@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Date:   Wed, 10 Jun 2020 13:47:18 +0800
In-Reply-To: <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
         <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBUaWZmYW55ICYgTWFvZ3VhbmcuDQoNCk9uIFNhdCwgMjAyMC0wNS0zMCBhdCAxNjoxMCArMDgw
MCwgWW9uZyBXdSB3cm90ZToNCj4gTWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgdGhl
IGRldmljZV9saW5rIGJldHdlZW4gdGhlIGNvbnN1bWVyDQo+IGFuZCBzbWktbGFyYiBkZXZpY2Uu
IElmIHRoZSB2Y29kZWMgZGV2aWNlIGNhbGwgdGhlIHBtX3J1bnRpbWVfZ2V0X3N5bmMsDQo+IHRo
ZSBzbWktbGFyYidzIHBtX3J1bnRpbWVfZ2V0X3N5bmMgYWxzbyBiZSBjYWxsZWQgYXV0b21hdGlj
YWxseS4NCj4gDQo+IENDOiBUaWZmYW55IExpbiA8dGlmZmFueS5saW5AbWVkaWF0ZWsuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIC4uLi9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX3BtLmMgIHwgMTkgLS0tLS0t
LS0tLS0tLS0tDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2Rl
Y19kcnYuaCB8ICAzIC0tLQ0KPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210
a192Y29kZWNfZW5jLmMgfCAgMSAtDQo+ICAuLi4vbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9t
dGtfdmNvZGVjX2VuY19wbS5jICB8IDI3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDQgZmls
ZXMgY2hhbmdlZCwgNTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZGVjX3BtLmMgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYw0KPiBpbmRleCAzNmRm
ZTNmLi4xZDdkMTRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12
Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYw0KPiBAQCAtOCwxNCArOCwxMiBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0
Zm9ybS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gLSNpbmNsdWRlIDxz
b2MvbWVkaWF0ZWsvc21pLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfdmNvZGVjX2RlY19wbS5o
Ig0KPiAgI2luY2x1ZGUgIm10a192Y29kZWNfdXRpbC5oIg0KPiAgDQo+ICBpbnQgbXRrX3Zjb2Rl
Y19pbml0X2RlY19wbShzdHJ1Y3QgbXRrX3Zjb2RlY19kZXYgKm10a2RldikNCj4gIHsNCj4gLQlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGU7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
djsNCj4gIAlzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG07DQo+ICAJc3RydWN0IG10a192Y29kZWNf
Y2xrICpkZWNfY2xrOw0KPiBAQCAtMjYsMTggKzI0LDcgQEAgaW50IG10a192Y29kZWNfaW5pdF9k
ZWNfcG0oc3RydWN0IG10a192Y29kZWNfZGV2ICptdGtkZXYpDQo+ICAJcG0gPSAmbXRrZGV2LT5w
bTsNCj4gIAlwbS0+bXRrZGV2ID0gbXRrZGV2Ow0KPiAgCWRlY19jbGsgPSAmcG0tPnZkZWNfY2xr
Ow0KPiAtCW5vZGUgPSBvZl9wYXJzZV9waGFuZGxlKHBkZXYtPmRldi5vZl9ub2RlLCAibWVkaWF0
ZWssbGFyYiIsIDApOw0KPiAtCWlmICghbm9kZSkgew0KPiAtCQltdGtfdjRsMl9lcnIoIm9mX3Bh
cnNlX3BoYW5kbGUgbWVkaWF0ZWssbGFyYiBmYWlsISIpOw0KPiAtCQlyZXR1cm4gLTE7DQo+IC0J
fQ0KPiAgDQo+IC0JcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobm9kZSk7DQo+IC0Jb2Zf
bm9kZV9wdXQobm9kZSk7DQo+IC0JaWYgKFdBUk5fT04oIXBkZXYpKSB7DQo+IC0JCXJldHVybiAt
MTsNCj4gLQl9DQo+IC0JcG0tPmxhcmJ2ZGVjID0gJnBkZXYtPmRldjsNCj4gIAlwZGV2ID0gbXRr
ZGV2LT5wbGF0X2RldjsNCj4gIAlwbS0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gIA0KPiBAQCAtMTEz
LDExICsxMDAsNiBAQCB2b2lkIG10a192Y29kZWNfZGVjX2Nsb2NrX29uKHN0cnVjdCBtdGtfdmNv
ZGVjX3BtICpwbSkNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IG10a19zbWlfbGFyYl9n
ZXQocG0tPmxhcmJ2ZGVjKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCW10a192NGwyX2VycigibXRr
X3NtaV9sYXJiX2dldCBsYXJidmRlYyBmYWlsICVkIiwgcmV0KTsNCj4gLQkJZ290byBlcnJvcjsN
Cj4gLQl9DQo+ICAJcmV0dXJuOw0KPiAgDQo+ICBlcnJvcjoNCj4gQEAgLTEzMCw3ICsxMTIsNiBA
QCB2b2lkIG10a192Y29kZWNfZGVjX2Nsb2NrX29mZihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0p
DQo+ICAJc3RydWN0IG10a192Y29kZWNfY2xrICpkZWNfY2xrID0gJnBtLT52ZGVjX2NsazsNCj4g
IAlpbnQgaSA9IDA7DQo+ICANCj4gLQltdGtfc21pX2xhcmJfcHV0KHBtLT5sYXJidmRlYyk7DQo+
ICAJZm9yIChpID0gZGVjX2Nsay0+Y2xrX251bSAtIDE7IGkgPj0gMDsgaS0tKQ0KPiAgCQljbGtf
ZGlzYWJsZV91bnByZXBhcmUoZGVjX2Nsay0+Y2xrX2luZm9baV0udmNvZGVjX2Nsayk7DQo+ICB9
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zj
b2RlY19kcnYuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVj
X2Rydi5oDQo+IGluZGV4IDUyZDFjZTEuLjdkMzk2NmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Rydi5oDQo+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Rydi5oDQo+IEBAIC0xOTAs
MTAgKzE5MCw3IEBAIHN0cnVjdCBtdGtfdmNvZGVjX2NsayB7DQo+ICAgKi8NCj4gIHN0cnVjdCBt
dGtfdmNvZGVjX3BtIHsNCj4gIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsJdmRlY19jbGs7DQo+IC0J
c3RydWN0IGRldmljZQkqbGFyYnZkZWM7DQo+IC0NCj4gIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsJ
dmVuY19jbGs7DQo+IC0Jc3RydWN0IGRldmljZQkqbGFyYnZlbmM7DQo+ICAJc3RydWN0IGRldmlj
ZQkqZGV2Ow0KPiAgCXN0cnVjdCBtdGtfdmNvZGVjX2RldgkqbXRrZGV2Ow0KPiAgfTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Vu
Yy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMN
Cj4gaW5kZXggNTMwMWRjYS4uMTgwMjVmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMNCj4gKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMNCj4gQEAgLTgsNyArOCw2IEBA
DQo+ICAjaW5jbHVkZSA8bWVkaWEvdjRsMi1ldmVudC5oPg0KPiAgI2luY2x1ZGUgPG1lZGlhL3Y0
bDItbWVtMm1lbS5oPg0KPiAgI2luY2x1ZGUgPG1lZGlhL3ZpZGVvYnVmMi1kbWEtY29udGlnLmg+
DQo+IC0jaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Bt
X3J1bnRpbWUuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIm10a192Y29kZWNfZHJ2LmgiDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19lbmNf
cG0uYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuY19w
bS5jDQo+IGluZGV4IDAxYzZhNTUuLjA0NzkxOWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuY19wbS5jDQo+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuY19wbS5jDQo+IEBAIC04
LDQ0ICs4LDI1IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5o
Pg0KPiAtI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIm10
a192Y29kZWNfZW5jX3BtLmgiDQo+ICAjaW5jbHVkZSAibXRrX3Zjb2RlY191dGlsLmgiDQo+ICAN
Cj4gIGludCBtdGtfdmNvZGVjX2luaXRfZW5jX3BtKHN0cnVjdCBtdGtfdmNvZGVjX2RldiAqbXRr
ZGV2KQ0KPiAgew0KPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gIAlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2Ow0KPiAgCXN0cnVjdCBtdGtfdmNvZGVjX3BtICpwbTsNCj4gIAlz
dHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmVuY19jbGs7DQo+ICAJc3RydWN0IG10a192Y29kZWNfY2xr
X2luZm8gKmNsa19pbmZvOw0KPiAgCWludCByZXQgPSAwLCBpID0gMDsNCj4gLQlzdHJ1Y3QgZGV2
aWNlICpkZXY7DQo+ICANCj4gIAlwZGV2ID0gbXRrZGV2LT5wbGF0X2RldjsNCj4gIAlwbSA9ICZt
dGtkZXYtPnBtOw0KPiAgCW1lbXNldChwbSwgMCwgc2l6ZW9mKHN0cnVjdCBtdGtfdmNvZGVjX3Bt
KSk7DQo+ICAJcG0tPm10a2RldiA9IG10a2RldjsNCj4gIAlwbS0+ZGV2ID0gJnBkZXYtPmRldjsN
Cj4gLQlkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCWVuY19jbGsgPSAmcG0tPnZlbmNfY2xrOw0KPiAg
DQo+IC0Jbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbGFy
YiIsIDApOw0KPiAtCWlmICghbm9kZSkgew0KPiAtCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVr
LGxhcmIgZm91bmQiKTsNCj4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+IC0JfQ0KPiAtCXBkZXYgPSBv
Zl9maW5kX2RldmljZV9ieV9ub2RlKG5vZGUpOw0KPiAtCW9mX25vZGVfcHV0KG5vZGUpOw0KPiAt
CWlmICghcGRldikgew0KPiAtCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVrLGxhcmIgZGV2aWNl
IGZvdW5kIik7DQo+IC0JCXJldHVybiAtRU5PREVWOw0KPiAtCX0NCj4gLQlwbS0+bGFyYnZlbmMg
PSAmcGRldi0+ZGV2Ow0KPiAtCXBkZXYgPSBtdGtkZXYtPnBsYXRfZGV2Ow0KPiAtCXBtLT5kZXYg
PSAmcGRldi0+ZGV2Ow0KPiAtDQo+ICAJZW5jX2Nsay0+Y2xrX251bSA9IG9mX3Byb3BlcnR5X2Nv
dW50X3N0cmluZ3MocGRldi0+ZGV2Lm9mX25vZGUsDQo+ICAJCSJjbG9jay1uYW1lcyIpOw0KPiAg
CWlmIChlbmNfY2xrLT5jbGtfbnVtID4gMCkgew0KPiBAQCAtOTMsMTMgKzc0LDYgQEAgdm9pZCBt
dGtfdmNvZGVjX2VuY19jbG9ja19vbihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0pDQo+ICAJCX0N
Cj4gIAl9DQo+ICANCj4gLQlyZXQgPSBtdGtfc21pX2xhcmJfZ2V0KHBtLT5sYXJidmVuYyk7DQo+
IC0JaWYgKHJldCkgew0KPiAtCQltdGtfdjRsMl9lcnIoIm10a19zbWlfbGFyYl9nZXQgbGFyYjMg
ZmFpbCAlZCIsIHJldCk7DQo+IC0JCWdvdG8gY2xrZXJyOw0KPiAtCX0NCj4gLQlyZXR1cm47DQo+
IC0NCj4gIGNsa2VycjoNCj4gIAlmb3IgKGkgLT0gMTsgaSA+PSAwOyBpLS0pDQo+ICAJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShlbmNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsNCj4gQEAg
LTExMCw3ICs4NCw2IEBAIHZvaWQgbXRrX3Zjb2RlY19lbmNfY2xvY2tfb2ZmKHN0cnVjdCBtdGtf
dmNvZGVjX3BtICpwbSkNCj4gIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmVuY19jbGsgPSAmcG0t
PnZlbmNfY2xrOw0KPiAgCWludCBpID0gMDsNCj4gIA0KPiAtCW10a19zbWlfbGFyYl9wdXQocG0t
PmxhcmJ2ZW5jKTsNCj4gIAlmb3IgKGkgPSBlbmNfY2xrLT5jbGtfbnVtIC0gMTsgaSA+PSAwOyBp
LS0pDQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShlbmNfY2xrLT5jbGtfaW5mb1tpXS52Y29k
ZWNfY2xrKTsNCj4gIH0NCg0K

