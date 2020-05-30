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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68292207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fmc1P4tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgE3INT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22895 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3INS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:18 -0400
X-UUID: 3743f9c466e24b0c9adeca20aaf26bd5-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b857mO0IxNjltTZKT+A58I0DX/pCaEnU3D8hoT6uu5g=;
        b=fmc1P4tZIaeLrWDjd7yWkSoedns9J5DvTyGDKztUSqDk9EimlA+G4b4So9M8WBVLVYkHvXfmIGcqxhmAFpf8YL8k3+xKXohYjTkHaVHaTI3hSCxG1IWR9O+TrPh/lta7D5jE8UjPkVa3Q6EV1H82hbOw6oJTjmAYyxoQWx0XRG4=;
X-UUID: 3743f9c466e24b0c9adeca20aaf26bd5-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1038921384; Sat, 30 May 2020 16:13:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:12 +0800
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
        <acourbot@chromium.org>, Rick Chang <rick.chang@mediatek.com>
Subject: [PATCH v4 06/17] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
Date:   Sat, 30 May 2020 16:10:07 +0800
Message-ID: <1590826218-23653-7-git-send-email-yong.wu@mediatek.com>
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

TWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgZGV2aWNlX2xpbmsgYmV0d2VlbiB0aGUg
Y29uc3VtZXINCmFuZCBzbWktbGFyYiBkZXZpY2UuIElmIHRoZSBqcGcgZGV2aWNlIGNhbGwgdGhl
IHBtX3J1bnRpbWVfZ2V0X3N5bmMsDQp0aGUgc21pLWxhcmIncyBwbV9ydW50aW1lX2dldF9zeW5j
IGFsc28gYmUgY2FsbGVkIGF1dG9tYXRpY2FsbHkuDQoNCkNDOiBSaWNrIENoYW5nIDxyaWNrLmNo
YW5nQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0K
LS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMgfCAy
MiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBl
Zy9tdGtfanBlZ19jb3JlLmggfCAgMiAtLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19q
cGVnX2NvcmUuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5jDQppbmRleCBmODJhODFhLi4yMWZiYTZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jDQpAQCAtMjEsNyArMjEsNiBAQA0KICNpbmNs
dWRlIDxtZWRpYS92NGwyLWlvY3RsLmg+DQogI2luY2x1ZGUgPG1lZGlhL3ZpZGVvYnVmMi1jb3Jl
Lmg+DQogI2luY2x1ZGUgPG1lZGlhL3ZpZGVvYnVmMi1kbWEtY29udGlnLmg+DQotI2luY2x1ZGUg
PHNvYy9tZWRpYXRlay9zbWkuaD4NCiANCiAjaW5jbHVkZSAibXRrX2pwZWdfaHcuaCINCiAjaW5j
bHVkZSAibXRrX2pwZWdfY29yZS5oIg0KQEAgLTg5MywxMSArODkyLDYgQEAgc3RhdGljIGludCBt
dGtfanBlZ19xdWV1ZV9pbml0KHZvaWQgKnByaXYsIHN0cnVjdCB2YjJfcXVldWUgKnNyY192cSwN
CiANCiBzdGF0aWMgdm9pZCBtdGtfanBlZ19jbGtfb24oc3RydWN0IG10a19qcGVnX2RldiAqanBl
ZykNCiB7DQotCWludCByZXQ7DQotDQotCXJldCA9IG10a19zbWlfbGFyYl9nZXQoanBlZy0+bGFy
Yik7DQotCWlmIChyZXQpDQotCQlkZXZfZXJyKGpwZWctPmRldiwgIm10a19zbWlfbGFyYl9nZXQg
bGFyYnZkZWMgZmFpbCAlZFxuIiwgcmV0KTsNCiAJY2xrX3ByZXBhcmVfZW5hYmxlKGpwZWctPmNs
a19qZGVjX3NtaSk7DQogCWNsa19wcmVwYXJlX2VuYWJsZShqcGVnLT5jbGtfamRlYyk7DQogfQ0K
QEAgLTkwNiw3ICs5MDAsNiBAQCBzdGF0aWMgdm9pZCBtdGtfanBlZ19jbGtfb2ZmKHN0cnVjdCBt
dGtfanBlZ19kZXYgKmpwZWcpDQogew0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoanBlZy0+Y2xr
X2pkZWMpOw0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoanBlZy0+Y2xrX2pkZWNfc21pKTsNCi0J
bXRrX3NtaV9sYXJiX3B1dChqcGVnLT5sYXJiKTsNCiB9DQogDQogc3RhdGljIGlycXJldHVybl90
IG10a19qcGVnX2RlY19pcnEoaW50IGlycSwgdm9pZCAqcHJpdikNCkBAIC0xMDUxLDIxICsxMDQ0
LDYgQEAgc3RhdGljIGludCBtdGtfanBlZ19yZWxlYXNlKHN0cnVjdCBmaWxlICpmaWxlKQ0KIA0K
IHN0YXRpYyBpbnQgbXRrX2pwZWdfY2xrX2luaXQoc3RydWN0IG10a19qcGVnX2RldiAqanBlZykN
CiB7DQotCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCi0Jc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldjsNCi0NCi0Jbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUoanBlZy0+ZGV2LT5vZl9ub2Rl
LCAibWVkaWF0ZWssbGFyYiIsIDApOw0KLQlpZiAoIW5vZGUpDQotCQlyZXR1cm4gLUVJTlZBTDsN
Ci0JcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobm9kZSk7DQotCWlmIChXQVJOX09OKCFw
ZGV2KSkgew0KLQkJb2Zfbm9kZV9wdXQobm9kZSk7DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0JfQ0K
LQlvZl9ub2RlX3B1dChub2RlKTsNCi0NCi0JanBlZy0+bGFyYiA9ICZwZGV2LT5kZXY7DQotDQog
CWpwZWctPmNsa19qZGVjID0gZGV2bV9jbGtfZ2V0KGpwZWctPmRldiwgImpwZ2RlYyIpOw0KIAlp
ZiAoSVNfRVJSKGpwZWctPmNsa19qZGVjKSkNCiAJCXJldHVybiBQVFJfRVJSKGpwZWctPmNsa19q
ZGVjKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19q
cGVnX2NvcmUuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5oDQppbmRleCA5OTliZDE0Li44NTc5NDk0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmgNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oDQpAQCAtNDcsNyArNDcsNiBAQCBlbnVtIG10
a19qcGVnX2N0eF9zdGF0ZSB7DQogICogQGRlY19yZWdfYmFzZToJSlBFRyByZWdpc3RlcnMgbWFw
cGluZw0KICAqIEBjbGtfamRlYzoJCUpQRUcgaHcgd29ya2luZyBjbG9jaw0KICAqIEBjbGtfamRl
Y19zbWk6CUpQRUcgU01JIGJ1cyBjbG9jaw0KLSAqIEBsYXJiOgkJU01JIGRldmljZQ0KICAqLw0K
IHN0cnVjdCBtdGtfanBlZ19kZXYgew0KIAlzdHJ1Y3QgbXV0ZXgJCWxvY2s7DQpAQCAtNjEsNyAr
NjAsNiBAQCBzdHJ1Y3QgbXRrX2pwZWdfZGV2IHsNCiAJdm9pZCBfX2lvbWVtCQkqZGVjX3JlZ19i
YXNlOw0KIAlzdHJ1Y3QgY2xrCQkqY2xrX2pkZWM7DQogCXN0cnVjdCBjbGsJCSpjbGtfamRlY19z
bWk7DQotCXN0cnVjdCBkZXZpY2UJCSpsYXJiOw0KIH07DQogDQogLyoqDQotLSANCjEuOS4xDQo=

