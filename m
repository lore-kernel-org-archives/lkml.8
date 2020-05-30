Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11BC2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nex3X0ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgE3INa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25240 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:29 -0400
X-UUID: 4a4812554fa14c0c9f44175554c76e2a-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iCWpalRO0XdbVaztaRZx/ne1mVNpXmxirc1lXZWueNc=;
        b=Nex3X0caJOFuI6fN54Rw5cd84ndGj86LMCJKjWRmAzqvw3EDPu+b0apOv86+klv39SVkc83asvHMXy9wGdN1xUW+acX6t5/r8N1WNpnuOVAuJiuTQYXNqUPt4+mDXjgFYagneAJwryIXIpk6H4AAzUpr6VIPlZkNUvM4kbK/rZU=;
X-UUID: 4a4812554fa14c0c9f44175554c76e2a-20200530
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2132094191; Sat, 30 May 2020 16:13:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:22 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH v4 07/17] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
Date:   Sat, 30 May 2020 16:10:08 +0800
Message-ID: <1590826218-23653-8-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgdGhlIGRldmljZV9saW5rIGJldHdlZW4g
dGhlIGNvbnN1bWVyDQphbmQgc21pLWxhcmIgZGV2aWNlLiBJZiB0aGUgbWRwIGRldmljZSBjYWxs
IHRoZSBwbV9ydW50aW1lX2dldF9zeW5jLA0KdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGltZV9nZXRf
c3luYyBhbHNvIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5Lg0KDQpDQzogTWluZ2hzaXUgVHNhaSA8
bWluZ2hzaXUudHNhaUBtZWRpYXRlay5jb20+DQpDQzogSG91bG9uZyBXZWkgPGhvdWxvbmcud2Vp
QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0KUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0KLS0t
DQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRwL210a19tZHBfY29tcC5jIHwgNDQgKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRw
L210a19tZHBfY29tcC5oIHwgIDIgLS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAv
bXRrX21kcF9jb3JlLmMgfCAgMSAtDQogMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
NDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay1tZHAvbXRrX21kcF9jb21wLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRr
X21kcF9jb21wLmMNCmluZGV4IDIyOGM1OGYuLjM4OGFlNjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb21wLmMNCisrKyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtfbWRwX2NvbXAuYw0KQEAgLTEzLDcgKzEzLDYgQEANCiAj
aW5jbHVkZSA8bGludXgvb2YuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQogI2luY2x1
ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQotI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4N
CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Bt
X3J1bnRpbWUuaD4NCiANCkBAIC01OCwxOCArNTcsNiBAQCB2b2lkIG10a19tZHBfY29tcF9jbG9j
a19vbihzdHJ1Y3QgbXRrX21kcF9jb21wICpjb21wKQ0KIHsNCiAJaW50IGksIGVycjsNCiANCi0J
aWYgKGNvbXAtPmxhcmJfZGV2KSB7DQotCQllcnIgPSBtdGtfc21pX2xhcmJfZ2V0KGNvbXAtPmxh
cmJfZGV2KTsNCi0JCWlmIChlcnIpIHsNCi0JCQllbnVtIG10a19tZHBfY29tcF90eXBlIGNvbXBf
dHlwZSA9DQotCQkJCShlbnVtIG10a19tZHBfY29tcF90eXBlKQ0KLQkJCQlvZl9kZXZpY2VfZ2V0
X21hdGNoX2RhdGEoY29tcC0+ZGV2KTsNCi0JCQlkZXZfZXJyKGNvbXAtPmRldiwNCi0JCQkJImZh
aWxlZCB0byBnZXQgbGFyYiwgZXJyICVkLiB0eXBlOiVkXG4iLA0KLQkJCQllcnIsIGNvbXBfdHlw
ZSk7DQotCQl9DQotCX0NCi0NCiAJZXJyID0gcG1fcnVudGltZV9nZXRfc3luYyhjb21wLT5kZXYp
Ow0KIAlpZiAoZXJyIDwgMCkNCiAJCWRldl9lcnIoY29tcC0+ZGV2LA0KQEAgLTk3LDkgKzg0LDYg
QEAgdm9pZCBtdGtfbWRwX2NvbXBfY2xvY2tfb2ZmKHN0cnVjdCBtdGtfbWRwX2NvbXAgKmNvbXAp
DQogCQljbGtfZGlzYWJsZV91bnByZXBhcmUoY29tcC0+Y2xrW2ldKTsNCiAJfQ0KIA0KLQlpZiAo
Y29tcC0+bGFyYl9kZXYpDQotCQltdGtfc21pX2xhcmJfcHV0KGNvbXAtPmxhcmJfZGV2KTsNCi0N
CiAJcG1fcnVudGltZV9wdXRfc3luYyhjb21wLT5kZXYpOw0KIH0NCiANCkBAIC0xMzIsMTIgKzEx
NiwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfbWRwX2NvbXBfdW5iaW5kKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZSAqbWFzdGVyLA0KIA0KIGludCBtdGtfbWRwX2NvbXBfaW5pdChzdHJ1
Y3QgbXRrX21kcF9jb21wICpjb21wLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQogew0KLQlzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKmxhcmJfbm9kZTsNCi0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqbGFyYl9w
ZGV2Ow0KLQlpbnQgaTsNCiAJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2Rl
Ow0KIAllbnVtIG10a19tZHBfY29tcF90eXBlIGNvbXBfdHlwZSA9DQogCQkgKGVudW0gbXRrX21k
cF9jb21wX3R5cGUpb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQorCWludCBpOw0KIA0K
IAlJTklUX0xJU1RfSEVBRCgmY29tcC0+bm9kZSk7DQogCWNvbXAtPmRldiA9IGRldjsNCkBAIC0x
NTYsMzAgKzEzOCw2IEBAIGludCBtdGtfbWRwX2NvbXBfaW5pdChzdHJ1Y3QgbXRrX21kcF9jb21w
ICpjb21wLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCQkJYnJlYWs7DQogCX0NCiANCi0JLyogT25s
eSBETUEgY2FwYWJsZSBjb21wb25lbnRzIG5lZWQgdGhlIExBUkIgcHJvcGVydHkgKi8NCi0JY29t
cC0+bGFyYl9kZXYgPSBOVUxMOw0KLQlpZiAoY29tcF90eXBlICE9IE1US19NRFBfUkRNQSAmJg0K
LQkgICAgY29tcF90eXBlICE9IE1US19NRFBfV0RNQSAmJg0KLQkgICAgY29tcF90eXBlICE9IE1U
S19NRFBfV1JPVCkNCi0JCXJldHVybiAwOw0KLQ0KLQlsYXJiX25vZGUgPSBvZl9wYXJzZV9waGFu
ZGxlKG5vZGUsICJtZWRpYXRlayxsYXJiIiwgMCk7DQotCWlmICghbGFyYl9ub2RlKSB7DQotCQlk
ZXZfZXJyKGRldiwNCi0JCQkiTWlzc2luZyBtZWRpYWRlayxsYXJiIHBoYW5kbGUgaW4gJXBPRiBu
b2RlXG4iLCBub2RlKTsNCi0JCXJldHVybiAtRUlOVkFMOw0KLQl9DQotDQotCWxhcmJfcGRldiA9
IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobGFyYl9ub2RlKTsNCi0JaWYgKCFsYXJiX3BkZXYpIHsN
Ci0JCWRldl93YXJuKGRldiwgIldhaXRpbmcgZm9yIGxhcmIgZGV2aWNlICVwT0ZcbiIsIGxhcmJf
bm9kZSk7DQotCQlvZl9ub2RlX3B1dChsYXJiX25vZGUpOw0KLQkJcmV0dXJuIC1FUFJPQkVfREVG
RVI7DQotCX0NCi0Jb2Zfbm9kZV9wdXQobGFyYl9ub2RlKTsNCi0NCi0JY29tcC0+bGFyYl9kZXYg
PSAmbGFyYl9wZGV2LT5kZXY7DQotDQogCXJldHVybiAwOw0KIH0NCiANCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb21wLmggYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb21wLmgNCmluZGV4IGRlMTU4ZDMuLjM1NWUy
MjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9j
b21wLmgNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtfbWRwX2NvbXAu
aA0KQEAgLTExLDEzICsxMSwxMSBAQA0KICAqIHN0cnVjdCBtdGtfbWRwX2NvbXAgLSB0aGUgTURQ
J3MgZnVuY3Rpb24gY29tcG9uZW50IGRhdGENCiAgKiBAbm9kZToJbGlzdCBub2RlIHRvIHRyYWNr
IHNpYmluZyBNRFAgY29tcG9uZW50cw0KICAqIEBjbGs6CWNsb2NrcyByZXF1aXJlZCBmb3IgY29t
cG9uZW50DQotICogQGxhcmJfZGV2OglTTUkgZGV2aWNlIHJlcXVpcmVkIGZvciBjb21wb25lbnQN
CiAgKiBAZGV2Ogljb21wb25lbnQncyBkZXZpY2UNCiAgKi8NCiBzdHJ1Y3QgbXRrX21kcF9jb21w
IHsNCiAJc3RydWN0IGxpc3RfaGVhZAlub2RlOw0KIAlzdHJ1Y3QgY2xrCQkqY2xrWzJdOw0KLQlz
dHJ1Y3QgZGV2aWNlCQkqbGFyYl9kZXY7DQogCXN0cnVjdCBkZXZpY2UJCSpkZXY7DQogfTsNCiAN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb3Jl
LmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb3JlLmMNCmluZGV4
IDEzM2QxMDcuLmJjNTQ3MmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay1tZHAvbXRrX21kcF9jb3JlLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1k
cC9tdGtfbWRwX2NvcmUuYw0KQEAgLTE4LDcgKzE4LDYgQEANCiAjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCiAjaW5jbHVk
ZSA8bGludXgvd29ya3F1ZXVlLmg+DQotI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCiAN
CiAjaW5jbHVkZSAibXRrX21kcF9jb21wLmgiDQogI2luY2x1ZGUgIm10a19tZHBfY29yZS5oIg0K
LS0gDQoxLjkuMQ0K

