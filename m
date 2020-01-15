Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7124656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mZx32757"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAOFmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:42:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgAOFmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:42:49 -0500
X-UUID: 858ebded93e846c89ccb6878557b2402-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NLlzXYOSoxhpcDeE66w7aM8ABD4fy1DrSnI0e/ewbHA=;
        b=mZx327575G08m6SpzlyeH/Bv4sdBUbW85LbYc4XFk27FqGg7L9RRjQHV1oVymkzwSM4s0/8jY9TceCYGI6uT1kJIcYSUND8FA08i+f44HYEoWRoyDtxp5ijNJVmdfrjvqyTVQrqLu/pTjO3Y+go814Zn5oPLAy95H7sXgfFuR30=;
X-UUID: 858ebded93e846c89ccb6878557b2402-20200115
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 347920774; Wed, 15 Jan 2020 13:42:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 Jan 2020 13:41:41 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 Jan 2020 13:42:46 +0800
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        James Liao <jamesjj.liao@mediatek.com>
Subject: [PATCH v3] arm64: dts: mt8183: Enable CPU idle-states
Date:   Wed, 15 Jan 2020 13:42:35 +0800
Message-ID: <1579066955-2214-1-git-send-email-jamesjj.liao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6A3DA06B2E6C1CE21AC270955416C9E877BDCD95EBBE1F384779E1801670C0A82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIG1jZGktY3B1IGFuZCBtY2RpLWNsdXN0ZXIgb24gTVQ4MTgzIENQVXMuDQoNClNpZ25l
ZC1vZmYtYnk6IEphbWVzIExpYW8gPGphbWVzamoubGlhb0BtZWRpYXRlay5jb20+DQotLS0NClRo
aXMgcGF0Y2ggYmFzZXMgb24gdjUuNS1yYzYsIGFkZHMgaWRsZS1zdGF0ZXMgZm9yIE1UODE4MyBD
UFVzLg0KDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDMwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXgg
MTBiMzI0Ny4uMTAwN2ExMyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgz
LmR0c2kNCkBAIC03Myw2ICs3Myw3IEBADQogCQkJcmVnID0gPDB4MDAwPjsNCiAJCQllbmFibGUt
bWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw3NDE+Ow0KKwkJCWNw
dS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQICZDTFVTVEVSX1NMRUVQPjsNCiAJCX07DQogDQog
CQljcHUxOiBjcHVAMSB7DQpAQCAtODEsNiArODIsNyBAQA0KIAkJCXJlZyA9IDwweDAwMT47DQog
CQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NzQx
PjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUCAmQ0xVU1RFUl9TTEVFUD47DQog
CQl9Ow0KIA0KIAkJY3B1MjogY3B1QDIgew0KQEAgLTg5LDYgKzkxLDcgQEANCiAJCQlyZWcgPSA8
MHgwMDI+Ow0KIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2FwYWNpdHktZG1pcHMt
bWh6ID0gPDc0MT47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVAgJkNMVVNURVJf
U0xFRVA+Ow0KIAkJfTsNCiANCiAJCWNwdTM6IGNwdUAzIHsNCkBAIC05Nyw2ICsxMDAsNyBAQA0K
IAkJCXJlZyA9IDwweDAwMz47DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQljYXBh
Y2l0eS1kbWlwcy1taHogPSA8NzQxPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVF
UCAmQ0xVU1RFUl9TTEVFUD47DQogCQl9Ow0KIA0KIAkJY3B1NDogY3B1QDEwMCB7DQpAQCAtMTA1
LDYgKzEwOSw3IEBADQogCQkJcmVnID0gPDB4MTAwPjsNCiAJCQllbmFibGUtbWV0aG9kID0gInBz
Y2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJCQljcHUtaWRsZS1zdGF0
ZXMgPSA8JkNQVV9TTEVFUCAmQ0xVU1RFUl9TTEVFUD47DQogCQl9Ow0KIA0KIAkJY3B1NTogY3B1
QDEwMSB7DQpAQCAtMTEzLDYgKzExOCw3IEBADQogCQkJcmVnID0gPDB4MTAxPjsNCiAJCQllbmFi
bGUtbWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDwxMDI0PjsNCisJ
CQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUCAmQ0xVU1RFUl9TTEVFUD47DQogCQl9Ow0K
IA0KIAkJY3B1NjogY3B1QDEwMiB7DQpAQCAtMTIxLDYgKzEyNyw3IEBADQogCQkJcmVnID0gPDB4
MTAyPjsNCiAJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOw0KIAkJCWNhcGFjaXR5LWRtaXBzLW1o
eiA9IDwxMDI0PjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUCAmQ0xVU1RFUl9T
TEVFUD47DQogCQl9Ow0KIA0KIAkJY3B1NzogY3B1QDEwMyB7DQpAQCAtMTI5LDYgKzEzNiwyOSBA
QA0KIAkJCXJlZyA9IDwweDEwMz47DQogCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCiAJCQlj
YXBhY2l0eS1kbWlwcy1taHogPSA8MTAyND47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVf
U0xFRVAgJkNMVVNURVJfU0xFRVA+Ow0KKwkJfTsNCisNCisJCWlkbGUtc3RhdGVzIHsNCisJCQll
bnRyeS1tZXRob2QgPSAicHNjaSI7DQorDQorCQkJQ1BVX1NMRUVQOiBjcHUtc2xlZXAgew0KKwkJ
CQljb21wYXRpYmxlID0gImFybSxpZGxlLXN0YXRlIjsNCisJCQkJbG9jYWwtdGltZXItc3RvcDsN
CisJCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9IDwweDAwMDEwMDAxPjsNCisJCQkJZW50cnkt
bGF0ZW5jeS11cyA9IDwyMDA+Ow0KKwkJCQlleGl0LWxhdGVuY3ktdXMgPSA8MjAwPjsNCisJCQkJ
bWluLXJlc2lkZW5jeS11cyA9IDw4MDA+Ow0KKwkJCX07DQorDQorCQkJQ0xVU1RFUl9TTEVFUDog
Y2x1c3Rlci1zbGVlcCB7DQorCQkJCWNvbXBhdGlibGUgPSAiYXJtLGlkbGUtc3RhdGUiOw0KKwkJ
CQlsb2NhbC10aW1lci1zdG9wOw0KKwkJCQlhcm0scHNjaS1zdXNwZW5kLXBhcmFtID0gPDB4MDEw
MTAwMDE+Ow0KKwkJCQllbnRyeS1sYXRlbmN5LXVzID0gPDI1MD47DQorCQkJCWV4aXQtbGF0ZW5j
eS11cyA9IDw0MDA+Ow0KKwkJCQltaW4tcmVzaWRlbmN5LXVzID0gPDEzMDA+Ow0KKwkJCX07DQog
CQl9Ow0KIAl9Ow0KIA0KLS0gDQoxLjkuMQ0K

