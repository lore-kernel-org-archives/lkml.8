Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2094E2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cYgEm/dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGVHwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:52:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGVHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:47 -0400
X-UUID: 1574de30e5b14a2e8b656c2805101215-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=N12xt2Ho95K/5t9BUmiiTcsZXRkp+alJpZRZ6ri1tVs=;
        b=cYgEm/dz84dfE+Hrt4CMHh7NZJVt4g1dVajgdZidn1fuVihNtlUh/DXfniavf6VOwU27PbmNgfqctAeIpQEWoZH5sCJTvu4TstM+L51bFvTvbamIdcISxgBd9TsDQDjTZmSMBuFYnBZxX1GK0IFBjPI8+DOeQxZ9SZlhAyDpk3M=;
X-UUID: 1574de30e5b14a2e8b656c2805101215-20200722
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1378471531; Wed, 22 Jul 2020 15:52:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:34 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/7] usb: mtu3: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:09 +0800
Message-ID: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5EF873A7262642D7730EE5F21BCAD020E82C724D4756E7F4B20C7F02D98FE49B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMgfCA0ICstLS0NCiBkcml2
ZXJzL3VzYi9tdHUzL210dTNfcGxhdC5jIHwgNCArLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9t
dHUzL210dTNfY29yZS5jIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYw0KaW5kZXggOWRk
MDIxNi4uY2E0ODA4OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMN
CisrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCkBAIC04MjgsNyArODI4LDYgQEAg
aW50IHNzdXNiX2dhZGdldF9pbml0KHN0cnVjdCBzc3VzYl9tdGsgKnNzdXNiKQ0KIAlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSBzc3VzYi0+ZGV2Ow0KIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQogCXN0cnVjdCBtdHUzICptdHUgPSBOVUxMOw0K
LQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJaW50IHJldCA9IC1FTk9NRU07DQogDQogCW10dSA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZihzdHJ1Y3QgbXR1MyksIEdGUF9LRVJORUwpOw0KQEAg
LTg0MCw4ICs4MzksNyBAQCBpbnQgc3N1c2JfZ2FkZ2V0X2luaXQoc3RydWN0IHNzdXNiX210ayAq
c3N1c2IpDQogCQlyZXR1cm4gbXR1LT5pcnE7DQogCWRldl9pbmZvKGRldiwgImlycSAlZFxuIiwg
bXR1LT5pcnEpOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAibWFjIik7DQotCW10dS0+bWFjX2Jhc2UgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCByZXMpOw0KKwltdHUtPm1hY19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAibWFjIik7DQogCWlmIChJU19FUlIobXR1LT5tYWNf
YmFzZSkpIHsNCiAJCWRldl9lcnIoZGV2LCAiZXJyb3IgbWFwcGluZyBtZW1vcnkgZm9yIGRldiBt
YWNcbiIpOw0KIAkJcmV0dXJuIFBUUl9FUlIobXR1LT5tYWNfYmFzZSk7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvbXR1My9tdHUzX3BsYXQuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19wbGF0
LmMNCmluZGV4IDljMjU2ZWEuLmQ0NGQ1NDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9tdHUz
L210dTNfcGxhdC5jDQorKysgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfcGxhdC5jDQpAQCAtMjE2
LDcgKzIxNiw2IEBAIHN0YXRpYyBpbnQgZ2V0X3NzdXNiX3JzY3Moc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiwgc3RydWN0IHNzdXNiX210ayAqc3N1c2IpDQogCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KIAlzdHJ1Y3Qgb3RnX3N3aXRjaF9tdGsgKm90
Z19zeCA9ICZzc3VzYi0+b3RnX3N3aXRjaDsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYt
PmRldjsNCi0Jc3RydWN0IHJlc291cmNlICpyZXM7DQogCWludCBpOw0KIAlpbnQgcmV0Ow0KIA0K
QEAgLTI2Myw4ICsyNjIsNyBAQCBzdGF0aWMgaW50IGdldF9zc3VzYl9yc2NzKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdCBzc3VzYl9tdGsgKnNzdXNiKQ0KIAkJfQ0KIAl9DQog
DQotCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9N
RU0sICJpcHBjIik7DQotCXNzdXNiLT5pcHBjX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2Uo
ZGV2LCByZXMpOw0KKwlzc3VzYi0+aXBwY19iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlX2J5bmFtZShwZGV2LCAiaXBwYyIpOw0KIAlpZiAoSVNfRVJSKHNzdXNiLT5pcHBjX2Jh
c2UpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoc3N1c2ItPmlwcGNfYmFzZSk7DQogDQotLSANCjEuOS4x
DQo=

