Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322CDC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825020674
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EvYkwqsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgBFDHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:07:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5153 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727307AbgBFDHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:07:08 -0500
X-UUID: b173328609774f689a7a2d88ea64cc44-20200206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=T7kvNsa0joGaKP0pe9UMwN6WD2P1Rppfsrt81EbaJM0=;
        b=EvYkwqsUcuh+csHXMVTcsfWr9Qtl0cq1SP2aTFBfImdFSOFS1BWXud9TC3PotZITKIMZrPcVCXSW+wptVODVBheU6kiFcmU0js2jit0LrYP3HDA7TYMJQMmhMfkiyr5qNHqcG3AiuSM3hduo1Q3ExxoPmBeaagFjHCkjOqavVNI=;
X-UUID: b173328609774f689a7a2d88ea64cc44-20200206
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 53172226; Thu, 06 Feb 2020 11:07:01 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Feb 2020 11:06:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Feb 2020 11:07:18 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [PATCH v2 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Date:   Thu, 6 Feb 2020 11:06:47 +0800
Message-ID: <1580958411-2478-1-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGQgc3VwcG9ydCB0byBNVDYzNTkgUE1JQyByZWd1bGF0b3IuIE1UNjM1
OSBpcyBwcmltYXJ5DQpQTUlDIGZvciBNVDY3NzkgcGxhdGZvcm0uDQoNCkNoYW5nZXMgc2luY2Ug
djI6DQotIHJlbW92ZSBvcGVuIGNvZGluZyBpbiB0aGUgbXQ2MzU5IHJlZ3VsYXRvciBmb3Igdm9s
dF90YWJsZSB0eXBlIHJlZ3VsYXRvcnMNCi0gcmVmaW5lIGNvZGluZyBzdHlsZSBpbiB0aGUgbXQ2
MzU5IHJlZ3VsYXRvciB0byBhdm9pZCB1c2luZyB0ZXJuZXJ5IG9wZXJhdG9yDQotIHJlbW92ZSB1
bm5lY2Vzc2FyeSByZWplY3Qgb3BlcmF0aW9uIGluIG10NjM1OSByZWd1bGF0b3Igc2V0IG1vZGUg
ZnVuY3Rpb24NCg0KDQpXZW4gU3UgKDQpOg0KICBkdC1iaW5kaW5nczogcmVndWxhdG9yOiBBZGQg
ZG9jdW1lbnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCiAgbWZkOiBBZGQgZm9yIFBNSUMgTVQ2MzU5
IHJlZ2lzdGVycyBkZWZpbml0aW9uDQogIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBm
b3IgTVQ2MzU5IHJlZ3VsYXRvcg0KICBhcm02NDogZHRzOiBtdDYzNTk6IGFkZCBQTUlDIE1UNjM1
OSByZWxhdGVkIG5vZGVzDQoNCiAuLi4vYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0
b3IudHh0ICAgICAgICB8ICA1OCArKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2
MzU5LmR0c2kgICAgICAgICAgIHwgMzA2ICsrKysrKysrKw0KIGRyaXZlcnMvcmVndWxhdG9yL0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3JlZ3VsYXRv
ci9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9yZWd1
bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci5jICAgICAgICAgICAgICAgfCA3MzggKysrKysrKysrKysr
KysrKysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5L3JlZ2lzdGVycy5oICAgICAgICAg
ICAgICAgfCA1MzEgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2
MzU5LXJlZ3VsYXRvci5oICAgICAgICAgfCAgNTggKysNCiA3IGZpbGVzIGNoYW5nZWQsIDE3MDEg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0DQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci5jDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM1OS9yZWdpc3RlcnMuaA0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLmgN
Cg0KLS0gDQoxLjkuMQ0K

