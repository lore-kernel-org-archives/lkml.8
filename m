Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C249121927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rJ8uNTvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGNIup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:50:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:58666 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbgGNIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:50:41 -0400
X-UUID: 96eda75a2d7c4fc3b139c3d9f297cab5-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5YIqALVMFuugFeMVZxDIGwn9ZO0g/zjUVYWtoDp2XUU=;
        b=rJ8uNTvEb2FVJfMOclrNIpmz8mtc5vPy3xQREbea1Zgr5I5aAo6N0lfVAsNyAj/UTWiMx1pcXO/KUfmW0LdqWSff7h1yy0icdP8esj9cylR06BcWH/0z0YDv4KJeK+w6psTLg94xMOfjXY0bPyjaDfNanj8/u4zXQBJ4MZguGg8=;
X-UUID: 96eda75a2d7c4fc3b139c3d9f297cab5-20200714
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1556657873; Tue, 14 Jul 2020 16:50:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 16:50:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 16:50:32 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/9] usb: gadget: bdc: fix warning of embedded function name
Date:   Tue, 14 Jul 2020 16:48:47 +0800
Message-ID: <1594716535-24699-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B8BC00DA040CFB3893839AA7B26C0A0BCC92D12777F3A9402E5ACB1AB69B73CE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlICciJXMuLi4iLCBfX2Z1bmNfXycgdG8gcmVwbGFjZSBlbWJlZGRlZCBmdW5jdGlvbiBuYW1l
DQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuYyB8IDIgKy0NCiBk
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyAgfCA2ICsrKy0tLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2RiZy5jDQppbmRleCA3YmE3NDQ4Li45YzAzZTEzIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5jDQorKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfZGJnLmMNCkBAIC02OCw3ICs2OCw3IEBAIHZvaWQgYmRjX2RiZ19z
cnIoc3RydWN0IGJkYyAqYmRjLCB1MzIgc3JyX251bSkNCiANCiAJc3IgPSBiZGMtPnNyci5zcl9i
ZHM7DQogCWFkZHIgPSBiZGMtPnNyci5kbWFfYWRkcjsNCi0JZGV2X3ZkYmcoYmRjLT5kZXYsICJi
ZGNfZGJnX3NyciBzcjolcCBkcXBfaW5kZXg6JWRcbiIsDQorCWRldl92ZGJnKGJkYy0+ZGV2LCAi
JXMgc3I6JXAgZHFwX2luZGV4OiVkXG4iLCBfX2Z1bmNfXywNCiAJCQkJCQlzciwgYmRjLT5zcnIu
ZHFwX2luZGV4KTsNCiAJZm9yIChpID0gMDsgaSA8IE5VTV9TUl9FTlRSSUVTOyBpKyspIHsNCiAJ
CXNyID0gJmJkYy0+c3JyLnNyX2Jkc1tpXTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGNfZXAuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5j
DQppbmRleCBjNTczZTllLi4wYzQ0MDAyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2VwLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19l
cC5jDQpAQCAtNzU2LDcgKzc1Niw3IEBAIHN0YXRpYyBpbnQgZXBfZGVxdWV1ZShzdHJ1Y3QgYmRj
X2VwICplcCwgc3RydWN0IGJkY19yZXEgKnJlcSkNCiANCiAJZGV2X2RiZyhiZGMtPmRldiwgIiVz
IGVwOiVzIHN0YXJ0OiVkIGVuZDolZFxuIiwNCiAJCQkJCV9fZnVuY19fLCBlcC0+bmFtZSwgc3Rh
cnRfYmRpLCBlbmRfYmRpKTsNCi0JZGV2X2RiZyhiZGMtPmRldiwgImVwX2RlcXVldWUgZXA9JXAg
ZXAtPmRlc2M9JXBcbiIsDQorCWRldl9kYmcoYmRjLT5kZXYsICIlcyBlcD0lcCBlcC0+ZGVzYz0l
cFxuIiwgX19mdW5jX18sDQogCQkJCQkJZXAsICh2b2lkICopZXAtPnVzYl9lcC5kZXNjKTsNCiAJ
LyogU3RvcCB0aGUgZXAgdG8gc2VlIHdoZXJlIHRoZSBIVyBpcyA/ICovDQogCXJldCA9IGJkY19z
dG9wX2VwKGJkYywgZXAtPmVwX251bSk7DQpAQCAtMTg1MywxMiArMTg1MywxMiBAQCBzdGF0aWMg
aW50IGJkY19nYWRnZXRfZXBfZW5hYmxlKHN0cnVjdCB1c2JfZXAgKl9lcCwNCiAJaW50IHJldDsN
CiANCiAJaWYgKCFfZXAgfHwgIWRlc2MgfHwgZGVzYy0+YkRlc2NyaXB0b3JUeXBlICE9IFVTQl9E
VF9FTkRQT0lOVCkgew0KLQkJcHJfZGVidWcoImJkY19nYWRnZXRfZXBfZW5hYmxlIGludmFsaWQg
cGFyYW1ldGVyc1xuIik7DQorCQlwcl9kZWJ1ZygiJXMgaW52YWxpZCBwYXJhbWV0ZXJzXG4iLCBf
X2Z1bmNfXyk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0KIAlpZiAoIWRlc2MtPndNYXhQ
YWNrZXRTaXplKSB7DQotCQlwcl9kZWJ1ZygiYmRjX2dhZGdldF9lcF9lbmFibGUgbWlzc2luZyB3
TWF4UGFja2V0U2l6ZVxuIik7DQorCQlwcl9kZWJ1ZygiJXMgbWlzc2luZyB3TWF4UGFja2V0U2l6
ZVxuIiwgX19mdW5jX18pOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCi0tIA0KMS45LjEN
Cg==

