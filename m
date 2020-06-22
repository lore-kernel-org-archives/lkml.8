Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264A220679
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qWtPBdjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgFVGlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:41:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13483 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbgFVGlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:41:02 -0400
X-UUID: 113fd86292b8463c85841b09498296b0-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0UhSaCVwkP3dmW3o9DgNK5ccp+DPXmFQmtvdUVswH80=;
        b=qWtPBdjl9k/PCosEmtEsrJEKPx1Z5Nw/LEaqF0mP8Uthy38jppjiIb89uAoKy9HhMBiJ/2bqkZIGj7SlJko/GjLnHXiPKB8zkdDEo9Yu1PpAJGtFwQ8A1T3zQtxyBHN5YqS/9Or71SN9DuJwqT/hrCHt1EHohp+ox6rdW4IEeSs=;
X-UUID: 113fd86292b8463c85841b09498296b0-20200622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 781094810; Mon, 22 Jun 2020 14:40:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 14:40:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 14:40:53 +0800
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
Subject: [RESEND v2 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Date:   Mon, 22 Jun 2020 14:40:46 +0800
Message-ID: <1592808050-14260-1-git-send-email-Wen.Su@mediatek.com>
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
ZnVuY3Rpb24NCg0Kd2VuLnN1ICg0KToNCiAgZHQtYmluZGluZ3M6IHJlZ3VsYXRvcjogQWRkIGRv
Y3VtZW50IGZvciBNVDYzNTkgcmVndWxhdG9yDQogIG1mZDogQWRkIGZvciBQTUlDIE1UNjM1OSBy
ZWdpc3RlcnMgZGVmaW5pdGlvbg0KICByZWd1bGF0b3I6IG10NjM1OTogQWRkIHN1cHBvcnQgZm9y
IE1UNjM1OSByZWd1bGF0b3INCiAgYXJtNjQ6IGR0czogbXQ2MzU5OiBhZGQgUE1JQyBNVDYzNTkg
cmVsYXRlZCBub2Rlcw0KDQogLi4uL2JpbmRpbmdzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9y
LnR4dCAgICAgICAgfCAgNTkgKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1
OS5kdHNpICAgICAgICAgICB8IDMxMiArKysrKysrKw0KIGRyaXZlcnMvcmVndWxhdG9yL0tjb25m
aWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3JlZ3VsYXRvci9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9yZWd1bGF0
b3IvbXQ2MzU5LXJlZ3VsYXRvci5jICAgICAgICAgICAgICAgfCA4NTkgKysrKysrKysrKysrKysr
KysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5L3JlZ2lzdGVycy5oICAgICAgICAgICAg
ICAgfCA1MzEgKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvcmVndWxhdG9yL210NjM1OS1y
ZWd1bGF0b3IuaCAgICAgICAgIHwgIDU4ICsrDQogNyBmaWxlcyBjaGFuZ2VkLCAxODI5IGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OS5kdHNpDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IuYw0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTkvcmVnaXN0ZXJzLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci5oDQo=

