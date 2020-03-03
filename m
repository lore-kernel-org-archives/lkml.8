Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A64C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87D215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uLwSXjc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgCCMfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:35:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728547AbgCCMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:35:06 -0500
X-UUID: 8b14ac13378043b99e5610dc3af33df6-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GaJflJ+2Rxwghotqp7Z2Yh0hJVib/vuajeUPw3js15E=;
        b=uLwSXjc/D2weXykZr+dTileho7CZSgv3wj35IKM0ex+6Pcd2ZA8yYdlIPsUekXUdg048IRep75en3I10gc/0YG/EFlBnt1TPxsLzAB2swvouwULIdOGsTpbjIV8lQz58t42Fpoxucb+UUlrTWp4ddfOcDtyVFcTFBf/OO5t3ITA=;
X-UUID: 8b14ac13378043b99e5610dc3af33df6-20200303
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 617703403; Tue, 03 Mar 2020 20:34:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 20:34:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 20:35:37 +0800
From:   Xia Jiang <xia.jiang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v7 01/11] media: platform: Improve subscribe event flow for bug fixing
Date:   Tue, 3 Mar 2020 20:34:36 +0800
Message-ID: <20200303123446.20095-2-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200303123446.20095-1-xia.jiang@mediatek.com>
References: <20200303123446.20095-1-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGV0IHY0bDJfY3RybF9zdWJzY3JpYmVfZXZlbnQoKSBkbyB0aGUgam9iIGZvciBvdGhlciB0eXBl
cyBleGNlcHQNClY0TDJfRVZFTlRfU09VUkNFX0NIQU5HRS4NCg0KU2lnbmVkLW9mZi1ieTogWGlh
IEppYW5nIDx4aWEuamlhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMgYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYw0KaW5kZXggZWU4MDJmYzNiY2RmLi5jZGU1
OTI3NWQ0OWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210
a19qcGVnX2NvcmUuYw0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtf
anBlZ19jb3JlLmMNCkBAIC00NDYsOSArNDQ2LDkgQEAgc3RhdGljIGludCBtdGtfanBlZ19zdWJz
Y3JpYmVfZXZlbnQoc3RydWN0IHY0bDJfZmggKmZoLA0KIAlzd2l0Y2ggKHN1Yi0+dHlwZSkgew0K
IAljYXNlIFY0TDJfRVZFTlRfU09VUkNFX0NIQU5HRToNCiAJCXJldHVybiB2NGwyX3NyY19jaGFu
Z2VfZXZlbnRfc3Vic2NyaWJlKGZoLCBzdWIpOw0KLQlkZWZhdWx0Og0KLQkJcmV0dXJuIC1FSU5W
QUw7DQogCX0NCisNCisJcmV0dXJuIHY0bDJfY3RybF9zdWJzY3JpYmVfZXZlbnQoZmgsIHN1Yik7
DQogfQ0KIA0KIHN0YXRpYyBpbnQgbXRrX2pwZWdfZ19zZWxlY3Rpb24oc3RydWN0IGZpbGUgKmZp
bGUsIHZvaWQgKnByaXYsDQotLSANCjIuMTguMA0K

