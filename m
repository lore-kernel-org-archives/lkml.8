Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEEFC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760CC2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eiVtWza7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBUL3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:29:40 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:59009 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728032AbgBUL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:29:39 -0500
X-UUID: 052b074eb7614261a01c8e5279b70408-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FEmqX8k1XxKtpg6LtV267K/kVK82s0J/+1oiECAtDr8=;
        b=eiVtWza7lzxEFCLndw31k7qJIWOII6gD5pjTPkjq/6wrO8p1+SXSIDEU4d+sQdcYZflsnpyx5f0FyhTtRO5o15kP27VGaj+YJFzX3f/1jDUqVL7WuFHyDNDfsJhDCaNLVSR/g9MF9i4E8NNFnZB7U6ykVxUol6xQ2o+9CwF/l8s=;
X-UUID: 052b074eb7614261a01c8e5279b70408-20200221
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 582895744; Fri, 21 Feb 2020 19:28:35 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Feb
 2020 19:29:09 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 19:27:35 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 2/4] drm/mediatek: dpi dual edge support
Date:   Fri, 21 Feb 2020 19:28:26 +0800
Message-ID: <20200221112828.55837-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221112828.55837-1-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 636B543D83D9CE9FA7A8E41EE0DC7016EB30FCD39AC3129F92B4388D8A2F89C72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFBJIHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KSXQgY2Fu
IHJlZHVjZSBoYWxmIGRhdGEgaW8gcGlucy4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcGkuYyB8IDE0ICsrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQppbmRl
eCAwMWZhOGI4ZDc2M2QuLjM2ZTRkYmQyN2QxYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMNCkBAIC03NSw2ICs3NSw3IEBAIHN0cnVjdCBtdGtfZHBpIHsNCiAJZW51bSBtdGtfZHBp
X291dF9iaXRfbnVtIGJpdF9udW07DQogCWVudW0gbXRrX2RwaV9vdXRfY2hhbm5lbF9zd2FwIGNo
YW5uZWxfc3dhcDsNCiAJaW50IHJlZmNvdW50Ow0KKwlib29sIGR1YWxfZWRnZTsNCiB9Ow0KIA0K
IHN0YXRpYyBpbmxpbmUgc3RydWN0IG10a19kcGkgKm10a19kcGlfZnJvbV9lbmNvZGVyKHN0cnVj
dCBkcm1fZW5jb2RlciAqZSkNCkBAIC0zNDgsNiArMzQ5LDEzIEBAIHN0YXRpYyB2b2lkIG10a19k
cGlfY29uZmlnX2Rpc2FibGVfZWRnZShzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAkJbXRrX2RwaV9t
YXNrKGRwaSwgZHBpLT5jb25mLT5yZWdfaF9mcmVfY29uLCAwLCBFREdFX1NFTF9FTik7DQogfQ0K
IA0KK3N0YXRpYyB2b2lkIG10a19kcGlfZW5hYmxlX2R1YWxfZWRnZShzdHJ1Y3QgbXRrX2RwaSAq
ZHBpKQ0KK3sNCisJbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0REUl9TRVRUSU5HLCBERFJfRU4gfCBE
RFJfNFBIQVNFLA0KKwkJICAgICBERFJfRU4gfCBERFJfNFBIQVNFKTsNCisJbXRrX2RwaV9tYXNr
KGRwaSwgRFBJX09VVFBVVF9TRVRUSU5HLCBFREdFX1NFTCwgRURHRV9TRUwpOw0KK30NCisNCiBz
dGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZpZ19jb2xvcl9mb3JtYXQoc3RydWN0IG10a19kcGkgKmRw
aSwNCiAJCQkJCWVudW0gbXRrX2RwaV9vdXRfY29sb3JfZm9ybWF0IGZvcm1hdCkNCiB7DQpAQCAt
NDM5LDcgKzQ0Nyw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVj
dCBtdGtfZHBpICpkcGksDQogCXBsbF9yYXRlID0gY2xrX2dldF9yYXRlKGRwaS0+dHZkX2Nsayk7
DQogDQogCXZtLnBpeGVsY2xvY2sgPSBwbGxfcmF0ZSAvIGZhY3RvcjsNCi0JY2xrX3NldF9yYXRl
KGRwaS0+cGl4ZWxfY2xrLCB2bS5waXhlbGNsb2NrKTsNCisJY2xrX3NldF9yYXRlKGRwaS0+cGl4
ZWxfY2xrLA0KKwkJICAgICB2bS5waXhlbGNsb2NrICogKGRwaS0+ZHVhbF9lZGdlID8gMiA6IDEp
KTsNCiAJdm0ucGl4ZWxjbG9jayA9IGNsa19nZXRfcmF0ZShkcGktPnBpeGVsX2Nsayk7DQogDQog
CWRldl9kYmcoZHBpLT5kZXYsICJHb3QgIFBMTCAlbHUgSHosIHBpeGVsIGNsb2NrICVsdSBIelxu
IiwNCkBAIC01MDQsNiArNTEzLDggQEAgc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNwbGF5X21v
ZGUoc3RydWN0IG10a19kcGkgKmRwaSwNCiAJbXRrX2RwaV9jb25maWdfY29sb3JfZm9ybWF0KGRw
aSwgZHBpLT5jb2xvcl9mb3JtYXQpOw0KIAltdGtfZHBpX2NvbmZpZ18ybl9oX2ZyZShkcGkpOw0K
IAltdGtfZHBpX2NvbmZpZ19kaXNhYmxlX2VkZ2UoZHBpKTsNCisJaWYgKGRwaS0+ZHVhbF9lZGdl
KQ0KKwkJbXRrX2RwaV9lbmFibGVfZHVhbF9lZGdlKGRwaSk7DQogCW10a19kcGlfc3dfcmVzZXQo
ZHBpLCBmYWxzZSk7DQogDQogCXJldHVybiAwOw0KQEAgLTY4OSw2ICs3MDAsNyBAQCBzdGF0aWMg
aW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJZHBp
LT5kZXYgPSBkZXY7DQogCWRwaS0+Y29uZiA9IChzdHJ1Y3QgbXRrX2RwaV9jb25mICopb2ZfZGV2
aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQorCWRwaS0+ZHVhbF9lZGdlID0gb2ZfcHJvcGVydHlf
cmVhZF9ib29sKGRldi0+b2Zfbm9kZSwgImRwaV9kdWFsX2VkZ2UiKTsNCiANCiAJbWVtID0gcGxh
dGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZHBpLT5yZWdz
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCi0tIA0KMi4yMS4wDQo=

