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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2051C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2C720720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JJT0GDkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGKGwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32437 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:07 -0400
X-UUID: 3beb8af861d2426e931ceaa8c58584eb-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W54Ty6QRMwKDgv6G7is1nGP3+DDMbubqS7XzqnzrYfY=;
        b=JJT0GDkOQ47f4LZ7Nrj33bezqlwPqqEyR+2o7ygjoVTXr/84MyrBPjoeUmRASLJhXm8rMHo9Y/4F5BVNeP/tdsRClen34sL/tASKedhwLrF3YaKS5Xhg5JBhbz6zG90fZO5lkPlznyen+l42FUFhWAIfjBc+24z8gEYQ1VZdzM8=;
X-UUID: 3beb8af861d2426e931ceaa8c58584eb-20200711
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1598117566; Sat, 11 Jul 2020 14:52:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:59 +0800
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
Subject: [PATCH 15/21] iommu/mediatek: Support master use iova over 32bit
Date:   Sat, 11 Jul 2020 14:48:40 +0800
Message-ID: <20200711064846.16007-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgZXh0ZW5kaW5nIHY3cywgb3VyIHBhZ2V0YWJsZSBhbHJlYWR5IHN1cHBvcnQgaW92YSBy
ZWFjaA0KMTZHQigzNGJpdCkuIHRoZSBtYXN0ZXIgZ290IHRoZSBpb3ZhIHZpYSBkbWFfYWxsb2Nf
YXR0cnMgbWF5IHJlYWNoDQozNGJpdHMsIGJ1dCBpdHMgSFcgcmVnaXN0ZXIgc3RpbGwgaXMgMzJi
aXQuIHRoZW4gaG93IHRvIHNldCB0aGUNCmJpdDMyL2JpdDMzIGlvdmE/IHRoaXMgZGVwZW5kIG9u
IGEgU01JIGxhcmIgc2V0dGluZyhiYW5rX3NlbCkuDQoNCndlIHNlcGFyYXRlIHdob2xlIDE2R0Ig
aW92YSB0byBmb3VyIGJhbmtzOg0KYmFuazogMDogMH40RzsgMTogNH44RzsgMjogOC0xMkc7IDM6
IDEyLTE2RzsNClRoZSBiYW5rIG51bWJlciBpcyAoaW92YSA+PiAzMikuDQoNCldlIHdpbGwgcHJl
YXNzaWduIHdoaWNoIGJhbmsgdGhlIGxhcmJzIGJlbG9uZyB0by4gY3VycmVudGx5IHdlIGRvbid0
DQpoYXZlIGEgaW50ZXJmYWNlIGZvciBtYXN0ZXIgdG8gYWRqdXN0IGl0cyBiYW5rIG51bWJlci4N
Cg0KRWFjaCBhIGJhbmsgaXMgYSBpb3ZhX3JlZ2lvbiB3aGljaCBpcyBhIGluZGVwZW5kZW50IGlv
bW11LWRvbWFpbi4NCnRoZSBpb3ZhIHJhbmdlIGZvciBlYWNoIGlvbW11LWRvbWFpbiBjYW4ndCBj
cm9zcyA0Ry4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICB8IDEyICsrKysrKysrKy0tLQ0KIGRy
aXZlcnMvbWVtb3J5L210ay1zbWkuYyAgIHwgIDUgKysrKysNCiBpbmNsdWRlL3NvYy9tZWRpYXRl
ay9zbWkuaCB8ICAxICsNCiAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggZGIxZjA2MzI0ZWNjLi4zYjI3MTRiZWE0NWEg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQpAQCAtMzE1LDE3ICszMTUsMjMgQEAgc3RhdGljIHZvaWQgbXRrX2lv
bW11X2NvbmZpZyhzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEsDQogCQkJICAgICBzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGJvb2wgZW5hYmxlKQ0KIHsNCiAJc3RydWN0IG10a19zbWlfbGFyYl9pb21t
dSAgICAqbGFyYl9tbXU7DQotCXVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgbGFyYmlkLCBw
b3J0aWQ7DQorCXVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgbGFyYmlkLCBwb3J0aWQsIGRv
bWlkOw0KIAlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dl
dChkZXYpOw0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpyZWdpb247DQog
CWludCBpOw0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgZndzcGVjLT5udW1faWRzOyArK2kpIHsNCiAJ
CWxhcmJpZCA9IE1US19NNFVfVE9fTEFSQihmd3NwZWMtPmlkc1tpXSk7DQogCQlwb3J0aWQgPSBN
VEtfTTRVX1RPX1BPUlQoZndzcGVjLT5pZHNbaV0pOw0KKwkJZG9taWQgPSBNVEtfTTRVX1RPX0RP
TShmd3NwZWMtPmlkc1tpXSk7DQorDQogCQlsYXJiX21tdSA9ICZkYXRhLT5sYXJiX2ltdVtsYXJi
aWRdOw0KKwkJcmVnaW9uID0gZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbiArIGRvbWlkOw0K
KwkJbGFyYl9tbXUtPmJhbmtbcG9ydGlkXSA9IHVwcGVyXzMyX2JpdHMocmVnaW9uLT5pb3ZhX2Jh
c2UpOw0KIA0KLQkJZGV2X2RiZyhkZXYsICIlcyBpb21tdSBwb3J0OiAlZFxuIiwNCi0JCQllbmFi
bGUgPyAiZW5hYmxlIiA6ICJkaXNhYmxlIiwgcG9ydGlkKTsNCisJCWRldl9kYmcoZGV2LCAiJXMg
aW9tbXUgZm9yIGxhcmIoJXMpIHBvcnQgJWQgZG9tICVkIGJhbmsgJWQuXG4iLA0KKwkJCWVuYWJs
ZSA/ICJlbmFibGUiIDogImRpc2FibGUiLCBkZXZfbmFtZShsYXJiX21tdS0+ZGV2KSwNCisJCQlw
b3J0aWQsIGRvbWlkLCBsYXJiX21tdS0+YmFua1twb3J0aWRdKTsNCiANCiAJCWlmIChlbmFibGUp
DQogCQkJbGFyYl9tbXUtPm1tdSB8PSBNVEtfU01JX01NVV9FTihwb3J0aWQpOw0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0K
aW5kZXggZjY1MTY5MjEyODdmLi5mMmY2MTAwYzc0ZWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21l
bW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAgLTQxLDYg
KzQxLDggQEANCiAvKiBtdDI3MTIgKi8NCiAjZGVmaW5lIFNNSV9MQVJCX05PTlNFQ19DT04oaWQp
CSgweDM4MCArICgoaWQpICogNCkpDQogI2RlZmluZSBGX01NVV9FTgkJQklUKDApDQorI2RlZmlu
ZSBCQU5LX1NFTChhKQkJKCgoKGEpICYgMHgzKSA8PCA4KSB8ICgoKGEpICYgMHgzKSA8PCAxMCkg
fFwNCisJCQkJICgoKGEpICYgMHgzKSA8PCAxMikgfCAoKChhKSAmIDB4MykgPDwgMTQpKQ0KIA0K
IC8qIFNNSSBDT01NT04gKi8NCiAjZGVmaW5lIFNNSV9CVVNfU0VMCQkJMHgyMjANCkBAIC04NSw2
ICs4Nyw3IEBAIHN0cnVjdCBtdGtfc21pX2xhcmIgeyAvKiBsYXJiOiBsb2NhbCBhcmJpdGVyICov
DQogCWNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuCSpsYXJiX2dlbjsNCiAJaW50CQkJCWxh
cmJpZDsNCiAJdTMyCQkJCSptbXU7DQorCXVuc2lnbmVkIGNoYXIJCQkqYmFuazsNCiB9Ow0KIA0K
IHN0YXRpYyBpbnQgbXRrX3NtaV9jbGtfZW5hYmxlKGNvbnN0IHN0cnVjdCBtdGtfc21pICpzbWkp
DQpAQCAtMTUxLDYgKzE1NCw3IEBAIG10a19zbWlfbGFyYl9iaW5kKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGRldmljZSAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KIAkJaWYgKGRldiA9PSBsYXJi
X21tdVtpXS5kZXYpIHsNCiAJCQlsYXJiLT5sYXJiaWQgPSBpOw0KIAkJCWxhcmItPm1tdSA9ICZs
YXJiX21tdVtpXS5tbXU7DQorCQkJbGFyYi0+YmFuayA9IGxhcmJfbW11W2ldLmJhbms7DQogCQkJ
cmV0dXJuIDA7DQogCQl9DQogCX0NCkBAIC0xNjksNiArMTczLDcgQEAgc3RhdGljIHZvaWQgbXRr
X3NtaV9sYXJiX2NvbmZpZ19wb3J0X2dlbjJfZ2VuZXJhbChzdHJ1Y3QgZGV2aWNlICpkZXYpDQog
CWZvcl9lYWNoX3NldF9iaXQoaSwgKHVuc2lnbmVkIGxvbmcgKilsYXJiLT5tbXUsIDMyKSB7DQog
CQlyZWcgPSByZWFkbF9yZWxheGVkKGxhcmItPmJhc2UgKyBTTUlfTEFSQl9OT05TRUNfQ09OKGkp
KTsNCiAJCXJlZyB8PSBGX01NVV9FTjsNCisJCXJlZyB8PSBCQU5LX1NFTChsYXJiLT5iYW5rW2ld
KTsNCiAJCXdyaXRlbChyZWcsIGxhcmItPmJhc2UgKyBTTUlfTEFSQl9OT05TRUNfQ09OKGkpKTsN
CiAJfQ0KIH0NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaCBiL2luY2x1
ZGUvc29jL21lZGlhdGVrL3NtaS5oDQppbmRleCA5MzcxYmY1NzJhYjguLjRjZjQ0NWRiYmRhYSAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQorKysgYi9pbmNsdWRlL3Nv
Yy9tZWRpYXRlay9zbWkuaA0KQEAgLTE2LDYgKzE2LDcgQEANCiBzdHJ1Y3QgbXRrX3NtaV9sYXJi
X2lvbW11IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAl1bnNpZ25lZCBpbnQgICBtbXU7DQor
CXVuc2lnbmVkIGNoYXIgIGJhbmtbMzJdOw0KIH07DQogDQogLyoNCi0tIA0KMi4xOC4wDQo=

