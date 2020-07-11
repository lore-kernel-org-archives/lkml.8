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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B282C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C020720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G9rruAgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGKGun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:50:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57635 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:50:43 -0400
X-UUID: 611b96dc5baf4b4eb1ff4fb9afb2de9e-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dIm9QvJA4EDLMqFKpW7/RJwYmqQVAH3p/C0RPnf4QwE=;
        b=G9rruAgCEt3Y4HNjPz42vEmiqDVG6Ef0lxlgZxa6HjN3Uy8CxcAhbsJP5cCvx4uqVKUQftBvlm13d9xXD9DnRK5JG3921mWVMPuilJmV9A9h86hHGG3DBPLk2oUnddTNBz6izhYMg1jWHffEshfM2k0YEA8hBcwfLNYi2hRBuY8=;
X-UUID: 611b96dc5baf4b4eb1ff4fb9afb2de9e-20200711
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1840359348; Sat, 11 Jul 2020 14:50:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:50:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:50:35 +0800
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
Subject: [PATCH 06/21] iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
Date:   Sat, 11 Jul 2020 14:48:31 +0800
Message-ID: <20200711064846.16007-7-yong.wu@mediatek.com>
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

QXMgdGl0bGUuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDIgKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBn
dGFibGUtYXJtLXY3cy5jDQppbmRleCA0MjcyZmU0ZTE3ZjQuLjAxZjJhODg3NjgwOCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCisrKyBiL2RyaXZlcnMv
aW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCkBAIC03MTcsNyArNzE3LDcgQEAgc3RhdGljIHNp
emVfdCBhcm1fdjdzX3VubWFwKHN0cnVjdCBpb19wZ3RhYmxlX29wcyAqb3BzLCB1bnNpZ25lZCBs
b25nIGlvdmEsDQogew0KIAlzdHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxlICpkYXRhID0gaW9fcGd0
YWJsZV9vcHNfdG9fZGF0YShvcHMpOw0KIA0KLQlpZiAoV0FSTl9PTih1cHBlcl8zMl9iaXRzKGlv
dmEpKSkNCisJaWYgKFdBUk5fT04oaW92YSA+PSAoMVVMTCA8PCBkYXRhLT5pb3AuY2ZnLmlhcykp
KQ0KIAkJcmV0dXJuIDA7DQogDQogCXJldHVybiBfX2FybV92N3NfdW5tYXAoZGF0YSwgZ2F0aGVy
LCBpb3ZhLCBzaXplLCAxLCBkYXRhLT5wZ2QpOw0KLS0gDQoyLjE4LjANCg==

