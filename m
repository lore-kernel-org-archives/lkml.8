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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6665C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837D82070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uvAnnSAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgE3IOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:14:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32551 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728762AbgE3IOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:40 -0400
X-UUID: af53a1923917446cbd3040c63b67634c-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=A7Ij86f1Labbs4iNJzkgqVTmCUzg7B1wyI2Cz/ZNwIM=;
        b=uvAnnSAE5cdgiz8mYQgX/1yHJvg4Mun3w4M8CqidFpKH8i0dDWGx+hjLHZum0Um9BgIGwHH60ECt8yQKBvmS4GoSuUiJKKWyFzbl5ucqmyzotWHnpcUEFbVz1fkX0fUA9I7FxI3ImT5bc8+QJp7HMzlLI1AExH7Nc/AwwkRtlT4=;
X-UUID: af53a1923917446cbd3040c63b67634c-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1038220398; Sat, 30 May 2020 16:14:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:33 +0800
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
        <acourbot@chromium.org>
Subject: [PATCH v4 14/17] memory: mtk-smi: Use device_is_bound to check if smi-common is ready
Date:   Sat, 30 May 2020 16:10:15 +0800
Message-ID: <1590826218-23653-15-git-send-email-yong.wu@mediatek.com>
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

c21pLWxhcmIgZHJpdmVyIHNob3VsZCBydW4gYWZ0ZXIgc21pLWNvbW1vbiwgVXNlIGRldmljZV9p
c19ib3VuZCB0byBjb25maXJtDQp3aGV0aGVyIHNtaWNvbW1vbiBkcml2ZXIgaXMgcmVhZHkuDQoN
CkNDOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9m
Zi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21lbW9y
eS9tdGstc21pLmMgfCA4ICsrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
IGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQppbmRleCAxOWMzOTQ5Li4wZjhjZDUwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQorKysgYi9kcml2ZXJzL21lbW9yeS9t
dGstc21pLmMNCkBAIC0yOTYsOCArMjk2LDE0IEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXNtaV9wZGV2ID0gb2ZfZmluZF9k
ZXZpY2VfYnlfbm9kZShzbWlfbm9kZSk7DQogCW9mX25vZGVfcHV0KHNtaV9ub2RlKTsNCiAJaWYg
KHNtaV9wZGV2KSB7DQotCQlpZiAoIXBsYXRmb3JtX2dldF9kcnZkYXRhKHNtaV9wZGV2KSkNCisJ
CWJvb2wgc21pY29tbW9uX2lzX2JvdW5kOw0KKw0KKwkJZGV2aWNlX2xvY2soJnNtaV9wZGV2LT5k
ZXYpOw0KKwkJc21pY29tbW9uX2lzX2JvdW5kID0gZGV2aWNlX2lzX2JvdW5kKCZzbWlfcGRldi0+
ZGV2KTsNCisJCWRldmljZV91bmxvY2soJnNtaV9wZGV2LT5kZXYpOw0KKwkJaWYgKCFzbWljb21t
b25faXNfYm91bmQpDQogCQkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQorDQogCQlsYXJiLT5zbWlf
Y29tbW9uX2RldiA9ICZzbWlfcGRldi0+ZGV2Ow0KIAkJbGluayA9IGRldmljZV9saW5rX2FkZChk
ZXYsIGxhcmItPnNtaV9jb21tb25fZGV2LA0KIAkJCQkgICAgICAgRExfRkxBR19QTV9SVU5USU1F
IHwgRExfRkxBR19TVEFURUxFU1MpOw0KLS0gDQoxLjkuMQ0K

