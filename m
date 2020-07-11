Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F9C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA51420720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GjWaSidQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGKGwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59510 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:16 -0400
X-UUID: 4490030669b647798ec9db558a86c0d1-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kznFAnlvVI8E28pnGJ0/BnIvoymQFbZ9+Ti34/1EQug=;
        b=GjWaSidQb/BdnjnMhZu52SacfqS5KGedPpYNn8PVPdeTntcJHb0Om4BgMQ9l/zentJ7v72IY6V9OjDaZzbh0IdKerFsuNjS9cLDwKSk7KHED+I0N0Fbh6keIMo00F1cYQTm8Qn+EZaAX3sK2Nw6Qv8Ig9DhNSJqZBXLnqYzAiTw=;
X-UUID: 4490030669b647798ec9db558a86c0d1-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 501575543; Sat, 11 Jul 2020 14:52:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:07 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 16/21] iommu/mediatek: Support up to 34bit iova in tlb invalid
Date:   Sat, 11 Jul 2020 14:48:41 +0800
Message-ID: <20200711064846.16007-17-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 94E84565E7ABE2763EB78F18C2A62045D3EEEDC73A96018C3CCE6E2D860438812000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlvdmEgaXMgMzRiaXQsIHRoZSBpb3ZhWzMyXVszM10gaXMgdGhlIGJpdDAvMSBpbiB0
aGUgdGxiIGZsdXNoDQpyZWdpc3Rlci4gQWRkIGEgbmV3IG1hY3JvIGZvciB0aGlzLg0KDQp0aGVy
ZSBpcyBhIG1pbm9yIGNoYW5nZSB1bnJlbGF0ZWQgd2l0aCB0aGlzIHBhdGNoLiBpdCBhbHNvIHVz
ZSB0aGUgbmV3DQptYWNyby4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTAgKysrKysrLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KaW5kZXggM2IyNzE0YmVhNDVhLi45YzY2NDlhOTdiZDcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQpAQCAtMTIzLDYgKzEyMyw4IEBAIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluIHsNCiANCiBzdGF0
aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzOw0KIA0KKyNkZWZpbmUgTVRL
X0lPTU1VX0FERFIoYWRkcikgICAobG93ZXJfMzJfYml0cyhhZGRyKSB8IHVwcGVyXzMyX2JpdHMo
YWRkcikpDQorDQogLyoNCiAgKiBJbiBNNFUgNEdCIG1vZGUsIHRoZSBwaHlzaWNhbCBhZGRyZXNz
IGlzIHJlbWFwcGVkIGFzIGJlbG93Og0KICAqDQpAQCAtMjI1LDggKzIyNyw5IEBAIHN0YXRpYyB2
b2lkIG10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25lZCBsb25nIGlvdmEsIHNp
emVfdCBzaXplLA0KIAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwN
CiAJCQkgICAgICAgZGF0YS0+YmFzZSArIGRhdGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0K
IA0KLQkJd3JpdGVsX3JlbGF4ZWQoaW92YSwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RB
UlRfQSk7DQotCQl3cml0ZWxfcmVsYXhlZChpb3ZhICsgc2l6ZSAtIDEsDQorCQl3cml0ZWxfcmVs
YXhlZChNVEtfSU9NTVVfQUREUihpb3ZhKSwNCisJCQkgICAgICAgZGF0YS0+YmFzZSArIFJFR19N
TVVfSU5WTERfU1RBUlRfQSk7DQorCQl3cml0ZWxfcmVsYXhlZChNVEtfSU9NTVVfQUREUihpb3Zh
ICsgc2l6ZSAtIDEpLA0KIAkJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlZMRF9FTkRf
QSk7DQogCQl3cml0ZWxfcmVsYXhlZChGX01NVV9JTlZfUkFOR0UsDQogCQkJICAgICAgIGRhdGEt
PmJhc2UgKyBSRUdfTU1VX0lOVkFMSURBVEUpOw0KQEAgLTY1Myw4ICs2NTYsNyBAQCBzdGF0aWMg
aW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkN
CiAJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0gTTRVX01UODE3MykNCiAJCXJlZ3Zh
bCA9IChkYXRhLT5wcm90ZWN0X2Jhc2UgPj4gMSkgfCAoZGF0YS0+ZW5hYmxlXzRHQiA8PCAzMSk7
DQogCWVsc2UNCi0JCXJlZ3ZhbCA9IGxvd2VyXzMyX2JpdHMoZGF0YS0+cHJvdGVjdF9iYXNlKSB8
DQotCQkJIHVwcGVyXzMyX2JpdHMoZGF0YS0+cHJvdGVjdF9iYXNlKTsNCisJCXJlZ3ZhbCA9IE1U
S19JT01NVV9BRERSKGRhdGEtPnByb3RlY3RfYmFzZSk7DQogCXdyaXRlbF9yZWxheGVkKHJlZ3Zh
bCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSVZSUF9QQUREUik7DQogDQogCWlmIChkYXRhLT5lbmFi
bGVfNEdCICYmDQotLSANCjIuMTguMA0K

