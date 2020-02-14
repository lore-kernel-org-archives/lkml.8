Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A2C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB2F2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UnjUPL4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBNEfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:35:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:20335 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728263AbgBNEfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:35:52 -0500
X-UUID: f85b9144fd644cf09b66769a0f4c63ab-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FRORBBixj2fM+LQrd6toHYB6M+ouwMB+JqVq9MHaeNQ=;
        b=UnjUPL4vd0EMGgB039q5Mb3RrNENY7IcqtGeDlHE3jRtPXpiF2zYPgkubNxpmheA7TignvGi7A0E0R4Sg5UEaDlHmzc1mlCyCZbUuNo3udghsUorIvX6o84lZ2A47U5wh9ktC4aQBX2PR1TBFx55H33ScLo0PeECe/0ZCWTcrtU=;
X-UUID: f85b9144fd644cf09b66769a0f4c63ab-20200214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2009086190; Fri, 14 Feb 2020 12:35:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:34:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:35:39 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH] soc: mediatek: knows_txdone needs to be set in Mediatek CMDQ helper
Date:   Fri, 14 Feb 2020 12:35:45 +0800
Message-ID: <20200214043545.16713-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsgQ01EUSBkcml2ZXIgaGF2ZSBhIG1lY2hhbmlzbSB0byBkbyBUWERPTkVfQllfQUNL
LA0Kc28gd2Ugc2hvdWxkIHNldCBrbm93c190eGRvbmUuDQoNCkZpeGVzOjU3NmYxYjRiYzgwMiAo
InNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhlbHBlciIpDQoNClNpZ25lZC1vZmYt
Ynk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5k
ZXggOWFkZDBmZDVmYTZjLi4yY2ExYTc1OWEzNDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEtaGVscGVyLmMNCkBAIC04MCw2ICs4MCw3IEBAIHN0cnVjdCBjbWRxX2NsaWVudCAqY21k
cV9tYm94X2NyZWF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpbmRleCwgdTMyIHRpbWVvdXQp
DQogCWNsaWVudC0+cGt0X2NudCA9IDA7DQogCWNsaWVudC0+Y2xpZW50LmRldiA9IGRldjsNCiAJ
Y2xpZW50LT5jbGllbnQudHhfYmxvY2sgPSBmYWxzZTsNCisJY2xpZW50LT5jbGllbnQua25vd3Nf
dHhkb25lID0gdHJ1ZTsNCiAJY2xpZW50LT5jaGFuID0gbWJveF9yZXF1ZXN0X2NoYW5uZWwoJmNs
aWVudC0+Y2xpZW50LCBpbmRleCk7DQogDQogCWlmIChJU19FUlIoY2xpZW50LT5jaGFuKSkgew0K
LS0gDQoyLjE4LjANCg==

