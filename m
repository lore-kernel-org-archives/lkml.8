Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A5A2065C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Cdf/Sn/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgFDJIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:08:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56880 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728050AbgFDJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:08:12 -0400
X-UUID: ba78196d233a49a3a2a949bbfc845bb4-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QieJajFUSDAATn0RLbYQatSFJzOR4F4C/wwtZYRLLOI=;
        b=Cdf/Sn/hcsPK7Abxy7d3sdbghbWmi3ORzrYgCXsE5+AAbVOH7RZY129hcV9ovRPe4S25LH26eocrLL8n1LhaREiktpjK7lDOJwWzFU5XGenG4trnHwz2WyN1rgFhIKJ/8qDajzzi3+93vC6nOWLnLtCE+zsD/CPer+l18ENJdhw=;
X-UUID: ba78196d233a49a3a2a949bbfc845bb4-20200604
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1574764099; Thu, 04 Jun 2020 17:08:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 17:08:05 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 17:08:03 +0800
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
        <srv_heupstream@mediatek.com>, <senozhatsky@chromium.org>,
        <mojahsu@chromium.org>, <drinkcat@chromium.org>,
        <maoguang.meng@mediatek.com>, <sj.huang@mediatek.com>,
        Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH RESEND v9 04/18] media: platform: Change the fixed device node number to unfixed value
Date:   Thu, 4 Jun 2020 17:05:39 +0800
Message-ID: <20200604090553.10861-6-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200604090553.10861-1-xia.jiang@mediatek.com>
References: <20200604090553.10861-1-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRyaXZlciBjYW4gYmUgaW5zdGFudGlhdGVkIG11bHRpcGxlIHRpbWVzLCBlLmcuIGZvciBh
IGRlY29kZXIgYW5kDQphbiBlbmNvZGVyLiBNb3Jlb3Zlciwgb3RoZXIgZHJpdmVycyBjb3VsZCBj
b2V4aXN0IG9uIHRoZSBzYW1lIHN5c3RlbS4NClRoaXMgbWFrZXMgdGhlIHN0YXRpYyB2aWRlbyBu
b2RlIG51bWJlciBhc3NpZ25tZW50IHBvaW50bGVzcywgc28gc3dpdGNoDQp0byBhdXRvbWF0aWMg
YXNzaWdubWVudCBpbnN0ZWFkLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWEgSmlhbmcgPHhpYS5qaWFu
Z0BtZWRpYXRlay5jb20+DQotLS0NCnY5OiBjaGFuZ2UgdGhlIGNvbW1pdCBtZXNzYWdlDQotLS0N
CiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYyB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jIGIv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMNCmluZGV4IDI2
Nzc1ODA5NDFiMC4uMTI2MDljYTQ2ZmQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jDQpAQCAtMTE1NCw3ICsxMTU0LDcgQEAgc3RhdGlj
IGludCBtdGtfanBlZ19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlqcGVn
LT5kZWNfdmRldi0+ZGV2aWNlX2NhcHMgPSBWNEwyX0NBUF9TVFJFQU1JTkcgfA0KIAkJCQkgICAg
ICBWNEwyX0NBUF9WSURFT19NMk1fTVBMQU5FOw0KIA0KLQlyZXQgPSB2aWRlb19yZWdpc3Rlcl9k
ZXZpY2UoanBlZy0+ZGVjX3ZkZXYsIFZGTF9UWVBFX1ZJREVPLCAzKTsNCisJcmV0ID0gdmlkZW9f
cmVnaXN0ZXJfZGV2aWNlKGpwZWctPmRlY192ZGV2LCBWRkxfVFlQRV9WSURFTywgLTEpOw0KIAlp
ZiAocmV0KSB7DQogCQl2NGwyX2VycigmanBlZy0+djRsMl9kZXYsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgdmlkZW8gZGV2aWNlXG4iKTsNCiAJCWdvdG8gZXJyX2RlY192ZGV2X3JlZ2lzdGVyOw0KLS0g
DQoyLjE4LjANCg==

