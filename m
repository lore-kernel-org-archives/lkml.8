Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A86C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B603720658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T+a3pvn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHQCub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:50:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55152 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgHQCu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:26 -0400
X-UUID: cad84e5fa4974dec912b7cfcf71b4926-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MgYUQXlp69yp7mKaPcEZgq7fYcJApihBC9PfPYl1V5Y=;
        b=T+a3pvn5Riwc1Td3C+29fVB27q6BnhS4e9ipbaKgZzGyi7o3qG1leAsvOd3ysWujeGihYELuCIkkVkn4D9o9ljC702X6Lpi7uYc9Yd2YW2F6DuCP+gRJOCodb26QxXTFY8F8xhmFT6rPmI39ujvtxkHXIjHgW0DaJBlZD/Os4tY=;
X-UUID: cad84e5fa4974dec912b7cfcf71b4926-20200817
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1349151528; Mon, 17 Aug 2020 10:50:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 10:50:14 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 10:50:13 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v4,4/4] arm64: dts: mt8192: add infracfg_rst node
Date:   Mon, 17 Aug 2020 10:48:42 +0800
Message-ID: <20200817024842.5289-5-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817024842.5289-1-crystal.guo@mediatek.com>
References: <20200817024842.5289-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5FFF82912C4D34533A815E971113554A0C15B8FFE38DEDC7CA39E726646117A82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGluZnJhY2ZnX3JzdCBub2RlIHdoaWNoIGlzIGZvciBNVDgxOTIgcGxhdGZvcm0NCg0KU2ln
bmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCAxMSArKysrKysrKysr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KaW5kZXggOTMxZTFjYTE3MjIw
Li5hMGNiOTkwNDcwNmIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE5Mi5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5k
dHNpDQpAQCAtMTAsNiArMTAsNyBAQA0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQt
Y29udHJvbGxlci9pcnEuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGluY3RybC9tdDgxOTIt
cGluZnVuYy5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaD4N
CisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLmg+DQogDQogLyB7DQogCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyIjsNCkBAIC0yMTksOSArMjIwLDE3IEBADQogCQl9
Ow0KIA0KIAkJaW5mcmFjZmc6IGluZnJhY2ZnQDEwMDAxMDAwIHsNCi0JCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIsICJzeXNjb24iOw0KKwkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTkyLWluZnJhY2ZnIiwgInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCiAJCQly
ZWcgPSA8MCAweDEwMDAxMDAwIDAgMHgxMDAwPjsNCiAJCQkjY2xvY2stY2VsbHMgPSA8MT47DQor
DQorCQkJaW5mcmFjZmdfcnN0OiByZXNldC1jb250cm9sbGVyIHsNCisJCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxpbmZyYS1yZXNldCIsICJ0aSxzeXNjb24tcmVzZXQiOw0KKwkJCQkjcmVzZXQt
Y2VsbHMgPSA8MT47DQorCQkJCXRpLHJlc2V0LWJpdHMgPSA8DQorCQkJCQkweDE0MCAxNSAweDE0
NCAxNSAwIDAgKEFTU0VSVF9TRVQgfCBERUFTU0VSVF9TRVQgfCBTVEFUVVNfTk9ORSkgLyogMDog
cGNpZSAqLw0KKwkJCQk+Ow0KKwkJCX07DQogCQl9Ow0KIA0KIAkJcGVyaWNmZzogcGVyaWNmZ0Ax
MDAwMzAwMCB7DQotLSANCjIuMTguMA0K

