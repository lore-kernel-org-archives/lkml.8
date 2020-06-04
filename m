Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E29C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1A4206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cMNc4UTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgFDIB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:01:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63815 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbgFDIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:01:28 -0400
X-UUID: 23c42885bc43477493215089ebc73e9a-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PTiPt0eASFWtTJtbLfkkvOk+F6XVglwV/gBrDeSnaHA=;
        b=cMNc4UTx0vMHrdXBgLAdVyXYk2I9SFbEurepxOERT1dVpu2jWPEll+ah54uIJaXrFXqjtsK/4B18kVq1pjEPRGmySH3q6jt/jpWNbEh6JmreBdlQzYcuhDMgHRO8tkfetzHBLAHp2Fojg26t/e87P8zWJ8/fKiOYz7doqO6GI+s=;
X-UUID: 23c42885bc43477493215089ebc73e9a-20200604
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 564593313; Thu, 04 Jun 2020 16:01:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 16:01:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 16:01:18 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH] iommu/mediatek: Use totalram_pages to setup enable_4GB
Date:   Thu, 4 Jun 2020 16:01:20 +0800
Message-ID: <20200604080120.2628-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 302719ED3089E2DF6B542E554C0642AB15FA15964EDC318E0CE26D1C0920F5F82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VG8gYnVpbGQgdGhpcyBkcml2ZXIgYXMgYSBrZXJuZWwgbW9kdWxlLCB3ZSBjYW5ub3QgdXNlDQp0
aGUgdW5leHBvcnRlZCBzeW1ib2wgIm1heF9wZm4iIHRvIHNldHVwIGVuYWJsZV80R0IuDQoNClVz
ZSB0b3RhbHJhbV9wYWdlcygpIGluc3RlYWQgdG8gc2V0dXAgZW5hYmxlXzRHQi4NCg0KU3VnZ2Vz
dGVkLWJ5OiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCkNjOiBEYXZpZCBIaWxkZW5i
cmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCkNjOiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDUgKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDVmNGQ2ZGY1OWNmNi4uYzI3
OThhNmUwZTM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTMsNyArMyw2IEBADQogICogQ29weXJpZ2h0
IChjKSAyMDE1LTIwMTYgTWVkaWFUZWsgSW5jLg0KICAqIEF1dGhvcjogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQogICovDQotI2luY2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L2J1Zy5oPg0KICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCiAjaW5jbHVkZSA8
bGludXgvY29tcG9uZW50Lmg+DQpAQCAtNjI2LDggKzYyNSw4IEBAIHN0YXRpYyBpbnQgbXRrX2lv
bW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlyZXR1cm4gLUVOT01F
TTsNCiAJZGF0YS0+cHJvdGVjdF9iYXNlID0gQUxJR04odmlydF90b19waHlzKHByb3RlY3QpLCBN
VEtfUFJPVEVDVF9QQV9BTElHTik7DQogDQotCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBp
cyBvdmVyIDRHQiAqLw0KLQlkYXRhLT5lbmFibGVfNEdCID0gISEobWF4X3BmbiA+IChCSVRfVUxM
KDMyKSA+PiBQQUdFX1NISUZUKSk7DQorCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBv
dmVyIDRHQiwgbm90ZTogRFJBTSBzdGFydCBhdCAxR0IgICovDQorCWRhdGEtPmVuYWJsZV80R0Ig
PSAhISh0b3RhbHJhbV9wYWdlcygpID4gKChTWl8yRyArIFNaXzFHKSA+PiBQQUdFX1NISUZUKSk7
DQogCWlmICghZGF0YS0+cGxhdF9kYXRhLT5oYXNfNGdiX21vZGUpDQogCQlkYXRhLT5lbmFibGVf
NEdCID0gZmFsc2U7DQogDQotLSANCjIuMTguMA0K

