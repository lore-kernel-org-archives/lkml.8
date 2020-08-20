Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A032078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ps3TGsMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHTGHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:07:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44885 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726752AbgHTGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:44 -0400
X-UUID: d516c7290ae8408b8c50f470c07e4ad8-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SeN+3ui8NePEAt6N9JFqIUxBM5eFCQtSTaGjXEX2kQc=;
        b=ps3TGsMqb8xK2VWJKpZJdWnJNxIwCZTqzoLJMqmeSMoMvIohabzb7sY1u04M9L5Q2rTT5uh6fGB08t7XVzMQ+Pb6wKcpb27bij2GCX22sgQYnUQyzgMm/p2ITktsfNkctl/HNtsOyn9zZHMgP453WY+fwnbn8In4Di3yPe8WgJM=;
X-UUID: d516c7290ae8408b8c50f470c07e4ad8-20200820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1443451804; Thu, 20 Aug 2020 14:05:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:37 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 07/21] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
Date:   Thu, 20 Aug 2020 14:04:04 +0800
Message-ID: <1597903458-8055-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZW5hYmxlIE9WTF9MQVlFUl9TTUlfSURfRU4gZm9yIG11bHRpLWxheWVyIHVzZWNhc2UNCg0KU2ln
bmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCAzICsrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9vdmwuYw0KaW5kZXggOGNmOWYzYi4uNDI3ZmU3ZiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jDQpAQCAtMjMsNiArMjMsNyBAQA0KICNkZWZpbmUgRElT
UF9SRUdfT1ZMX1JTVAkJCTB4MDAxNA0KICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JPSV9TSVpFCQkJ
MHgwMDIwDQogI2RlZmluZSBESVNQX1JFR19PVkxfREFUQVBBVEhfQ09OCQkweDAwMjQNCisjZGVm
aW5lIE9WTF9MQVlFUl9TTUlfSURfRU4JCQkJQklUKDApDQogI2RlZmluZSBPVkxfQkdDTFJfU0VM
X0lOCQkJCUJJVCgyKQ0KICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JPSV9CR0NMUgkJCTB4MDAyOA0K
ICNkZWZpbmUgRElTUF9SRUdfT1ZMX1NSQ19DT04JCQkweDAwMmMNCkBAIC0xMTYsNiArMTE3LDgg
QEAgc3RhdGljIHZvaWQgbXRrX292bF9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgbXRrX2RkcF9jb21w
ICpjb21wKQ0KIHN0YXRpYyB2b2lkIG10a19vdmxfc3RhcnQoc3RydWN0IG10a19kZHBfY29tcCAq
Y29tcCkNCiB7DQogCXdyaXRlbF9yZWxheGVkKDB4MSwgY29tcC0+cmVncyArIERJU1BfUkVHX09W
TF9FTik7DQorCW10a19kZHBfd3JpdGVfbWFzayhOVUxMLCBPVkxfTEFZRVJfU01JX0lEX0VOLCBj
b21wLA0KKwkJCSAgIERJU1BfUkVHX09WTF9EQVRBUEFUSF9DT04sIE9WTF9MQVlFUl9TTUlfSURf
RU4pOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBtdGtfb3ZsX3N0b3Aoc3RydWN0IG10a19kZHBfY29t
cCAqY29tcCkNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

