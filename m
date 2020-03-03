Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87694C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2BF20873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JizWLdZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgCCMfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:35:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727121AbgCCMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:35:07 -0500
X-UUID: 553873c5fef840868644bdf38e09f7b5-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8tqG320za0mW9RIagYkPiOg3CQwLqQXnwr9xDSmqpV8=;
        b=JizWLdZlpPPNtQH32HMGhQpCj+5goKG9bCY2Qjd6sXz7kWaltL4m5yKL7ty6CBO2WhwOQacqmp7JWQbmFMUSTCfxVHXLrhRveS5qyoVMZRlpmTHytMKkswR/xdw6R6hAWjB5d4+iVHjS9CMgRoay07jjxtr+F+VIdjG3R3AEBQM=;
X-UUID: 553873c5fef840868644bdf38e09f7b5-20200303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1281166939; Tue, 03 Mar 2020 20:35:00 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 20:34:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 20:35:39 +0800
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
Subject: [PATCH v7 03/11] media: platform: Improve s_selection flow for bug fixing
Date:   Tue, 3 Mar 2020 20:34:38 +0800
Message-ID: <20200303123446.20095-4-xia.jiang@mediatek.com>
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

R2V0IGNvcnJlY3QgY29tcG9zZSB2YWx1ZSBpbiBtdGtfanBlZ19zX3NlbGVjdGlvbiBmdW5jdGlv
bi4NCg0KU2lnbmVkLW9mZi1ieTogWGlhIEppYW5nIDx4aWEuamlhbmdAbWVkaWF0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMgfCA0
ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19j
b3JlLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYw0K
aW5kZXggZGEwZGFlNGIwZmM5Li5mYjJjOGQwMjY1ODAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYw0KKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmMNCkBAIC00OTIsOCArNDkyLDggQEAg
c3RhdGljIGludCBtdGtfanBlZ19zX3NlbGVjdGlvbihzdHJ1Y3QgZmlsZSAqZmlsZSwgdm9pZCAq
cHJpdiwNCiAJY2FzZSBWNEwyX1NFTF9UR1RfQ09NUE9TRToNCiAJCXMtPnIubGVmdCA9IDA7DQog
CQlzLT5yLnRvcCA9IDA7DQotCQlzLT5yLndpZHRoID0gY3R4LT5vdXRfcS53Ow0KLQkJcy0+ci5o
ZWlnaHQgPSBjdHgtPm91dF9xLmg7DQorCQljdHgtPm91dF9xLncgPSBzLT5yLndpZHRoOw0KKwkJ
Y3R4LT5vdXRfcS5oID0gcy0+ci5oZWlnaHQ7DQogCQlicmVhazsNCiAJZGVmYXVsdDoNCiAJCXJl
dHVybiAtRUlOVkFMOw0KLS0gDQoyLjE4LjANCg==

