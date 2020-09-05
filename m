Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28369C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59E12074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ATDR5DIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIEIMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728421AbgIEIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:37 -0400
X-UUID: c2a6177ed475481aa4aa3a39f34bb4d8-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fVTu26LyCKzBlLT+q4InPS1WNj1J5XPYdCFSzH70Ufg=;
        b=ATDR5DIRYegW/pS5ak7Fcgvjb0X3ezaujLhh3wLEoy7N/0jeTD33IH5KCf+ZK/mKMlNE67hZzIiQuUNy0+RQwVTQrAImPqGeoIE8cGgf0+ivRf3aO1BNrca6bZ0cLZPNbepUPnQkq7ltDCF2tcrhJ4639wEurZHf+JUA3HFe4hU=;
X-UUID: c2a6177ed475481aa4aa3a39f34bb4d8-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 777265787; Sat, 05 Sep 2020 16:12:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:32 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 08/23] iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
Date:   Sat, 5 Sep 2020 16:09:05 +0800
Message-ID: <20200905080920.13396-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AE7A0A50BF80425BF08DA5E0CE699E64A00E22E4CFB98D7B17BD8F91B247F7E02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXMgdGl0bGUuDQpCVFcsIGNoYW5nZSB0aGUgaWFzL29hcyBjaGVja2luZyBmb3JtYXQgaW4gdjdz
X21hcC4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jIHwgNSArKy0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jIGIvZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYw0KaW5kZXggYTY4OGYyMmNiZTNiLi40YzlkOGRjY2ZjNWEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQorKysgYi9kcml2ZXJz
L2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQpAQCAtNTI2LDggKzUyNiw3IEBAIHN0YXRpYyBp
bnQgYXJtX3Y3c19tYXAoc3RydWN0IGlvX3BndGFibGVfb3BzICpvcHMsIHVuc2lnbmVkIGxvbmcg
aW92YSwNCiAJaWYgKCEocHJvdCAmIChJT01NVV9SRUFEIHwgSU9NTVVfV1JJVEUpKSkNCiAJCXJl
dHVybiAwOw0KIA0KLQlpZiAoV0FSTl9PTihpb3ZhID49ICgxVUxMIDw8IGRhdGEtPmlvcC5jZmcu
aWFzKSB8fA0KLQkJICAgIHBhZGRyID49ICgxVUxMIDw8IGRhdGEtPmlvcC5jZmcub2FzKSkpDQor
CWlmIChXQVJOX09OKGlvdmEgPj4gZGF0YS0+aW9wLmNmZy5pYXMgfHwgcGFkZHIgPj4gZGF0YS0+
aW9wLmNmZy5vYXMpKQ0KIAkJcmV0dXJuIC1FUkFOR0U7DQogDQogCXJldCA9IF9fYXJtX3Y3c19t
YXAoZGF0YSwgaW92YSwgcGFkZHIsIHNpemUsIHByb3QsIDEsIGRhdGEtPnBnZCwgZ2ZwKTsNCkBA
IC03MTcsNyArNzE2LDcgQEAgc3RhdGljIHNpemVfdCBhcm1fdjdzX3VubWFwKHN0cnVjdCBpb19w
Z3RhYmxlX29wcyAqb3BzLCB1bnNpZ25lZCBsb25nIGlvdmEsDQogew0KIAlzdHJ1Y3QgYXJtX3Y3
c19pb19wZ3RhYmxlICpkYXRhID0gaW9fcGd0YWJsZV9vcHNfdG9fZGF0YShvcHMpOw0KIA0KLQlp
ZiAoV0FSTl9PTih1cHBlcl8zMl9iaXRzKGlvdmEpKSkNCisJaWYgKFdBUk5fT04oaW92YSA+PiBk
YXRhLT5pb3AuY2ZnLmlhcykpDQogCQlyZXR1cm4gMDsNCiANCiAJcmV0dXJuIF9fYXJtX3Y3c191
bm1hcChkYXRhLCBnYXRoZXIsIGlvdmEsIHNpemUsIDEsIGRhdGEtPnBnZCk7DQotLSANCjIuMTgu
MA0K

