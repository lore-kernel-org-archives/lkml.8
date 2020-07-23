Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E0C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F42086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KftOPWyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGWM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:59:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6419 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728820AbgGWM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:59:11 -0400
X-UUID: 9a8b0d2efcf3493992e37b8774c41135-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/rExF285VSbk1mjvljQ5FLR36AFJHuvXyBHgEJEnBpU=;
        b=KftOPWyOqj/G7abGXcy5754zHifOID0/b51oLzVZJSu5Rp+fcwgUt+D55RQTvWj+GW0Fu6W74yHLOHssZ5vho8r2JK+tSQn4o3taNPtptUhRbyRrAcd12XV0bxzcvxvkjoSJahI30oC3JzMDbIqRKJT6A7bgl8aeKGlALmP9+cU=;
X-UUID: 9a8b0d2efcf3493992e37b8774c41135-20200723
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 970600036; Thu, 23 Jul 2020 20:59:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 20:59:04 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 20:59:05 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: [PATCH 0/8] Add Support for MediaTek PMIC MT6359
Date:   Thu, 23 Jul 2020 20:58:45 +0800
Message-ID: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRlcyByZWZhY3RvcmluZyBpbnRlcnJ1cHQgYW5kIGFkZGluZyBz
dXBwb3J0IHRvIE1UNjM1OSBQTUlDLg0KTVQ2MzU5IGlzIHRoZSBwcmltYXJ5IFBNSUMgZm9yIE1U
Njc3OSBhbmQgcHJvYmFibHkgb3RoZXIgU09Dcy4NClRoZSBzZXJpZXNbMV0gc2VudCBieSBXZW4g
d2lsbCBjb250aW51ZSB0byB1cHN0cmVhbSBpbiB0aGlzIHBhdGNoc2V0IGFmdGVyd2FyZHMuDQoN
ClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsv
bGlzdC8/c2VyaWVzPTMwNjU3OQ0KDQpIc2luLUhzaXVuZyBXYW5nICg1KToNCiAgbWZkOiBtdDYz
NTg6IHJlZmluZSBpbnRlcnJ1cHQgY29kZQ0KICBkdC1iaW5kaW5nczogbWZkOiBBZGQgY29tcGF0
aWJsZSBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OSBQTUlDDQogIG1mZDogQWRkIHN1cHBvcnQgZm9y
IHRoZSBNZWRpYVRlayBNVDYzNTkgUE1JQw0KICByZWd1bGF0b3I6IG10NjM1OTogU2V0IHRoZSBl
bmFibGUgdGltZSBmb3IgTERPcw0KICByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBvcnQgZm9y
IE1UNjM1OVAgcmVndWxhdG9yDQoNCldlbiBTdSAoMyk6DQogIGR0LWJpbmRpbmdzOiByZWd1bGF0
b3I6IEFkZCBkb2N1bWVudCBmb3IgTVQ2MzU5IHJlZ3VsYXRvcg0KICByZWd1bGF0b3I6IG10NjM1
OTogQWRkIHN1cHBvcnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCiAgYXJtNjQ6IGR0czogbXQ2MzU5
OiBhZGQgUE1JQyBNVDYzNTkgcmVsYXRlZCBub2Rlcw0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0ICAgfCAgICA4ICstDQogLi4uL2JpbmRpbmdzL3Jl
Z3VsYXRvci9tdDYzNTktcmVndWxhdG9yLnR4dCAgICAgICAgfCAgIDU4ICsNCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OS5kdHNpICAgICAgICAgICB8ICAyOTYgKysrKysNCiBk
cml2ZXJzL21mZC9tdDYzNTgtaXJxLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgODkg
Ky0NCiBkcml2ZXJzL21mZC9tdDYzOTctY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMjMgKw0KIGRyaXZlcnMvcmVndWxhdG9yL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgOSArDQogZHJpdmVycy9yZWd1bGF0b3IvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLmMg
ICAgICAgICAgICAgICB8IDExMzYgKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4
L21mZC9tdDYzNTgvY29yZS5oICAgICAgICAgICAgICAgICAgICB8ICAgIDggKy0NCiBpbmNsdWRl
L2xpbnV4L21mZC9tdDYzNTkvY29yZS5oICAgICAgICAgICAgICAgICAgICB8ICAxMzMgKysrDQog
aW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5L3JlZ2lzdGVycy5oICAgICAgICAgICAgICAgfCAgNTI5
ICsrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWZkL210NjM1OXAvcmVnaXN0ZXJzLmggICAgICAg
ICAgICAgIHwgIDI0NiArKysrKw0KIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQogaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2MzU5
LXJlZ3VsYXRvci5oICAgICAgICAgfCAgIDU5ICsNCiAxNCBmaWxlcyBjaGFuZ2VkLCAyNTYzIGlu
c2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5
LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3Vs
YXRvci5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM1OS9jb3Jl
LmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5L3JlZ2lzdGVy
cy5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM1OXAvcmVnaXN0
ZXJzLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2MzU5
LXJlZ3VsYXRvci5oDQoNCi0tIA0KMi42LjQNCg==

