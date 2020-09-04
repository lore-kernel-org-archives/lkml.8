Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0753BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA00206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JjjKr8id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgIDGpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:45:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52747 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgIDGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:45:05 -0400
X-UUID: cee1b582b5fd41cc94607be22f18b1f0-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VwEG62ZinjOJQ7i1HuY68zs84FT+XWmhinFNtU9FoFA=;
        b=JjjKr8idBiS8GDNDAseDxPNRfVaj5CnUQP8draGgUxJ9yUAwiPiD1qv+fjBJ1F+oRE05lBux5EJywmqaqhAupbcJwetJ6cSbsUwYYQYwyDsynA75c7Rc8GrFKYClmFffHxmo9u9wIfWzIuW5lVI6gunu46H29f/Q7UlxkZ/CZUw=;
X-UUID: cee1b582b5fd41cc94607be22f18b1f0-20200904
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1214379933; Fri, 04 Sep 2020 14:44:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 14:44:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 14:44:55 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: soc: Add MT8192 power dt-bindings
Date:   Fri, 4 Sep 2020 14:44:53 +0800
Message-ID: <1599201895-11013-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
References: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGR0LWJpbmRpbmdzIG9mIE1UODE5Mg0KDQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBM
dSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL3NjcHN5cy50eHQgICAgfCAgNSArKysrDQogaW5jbHVkZS9kdC1iaW5kaW5n
cy9wb3dlci9tdDgxOTItcG93ZXIuaCAgICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysr
KysrDQogMiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmgNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lz
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nw
c3lzLnR4dA0KaW5kZXggZWZlMjAyNS4uN2YzMjJmOSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQpA
QCAtMTYsNiArMTYsNyBAQCBwb3dlci9wb3dlci1kb21haW4ueWFtbC4gSXQgcHJvdmlkZXMgdGhl
IHBvd2VyIGRvbWFpbnMgZGVmaW5lZCBpbg0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9t
dDI3MTItcG93ZXIuaA0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDc2MjItcG93ZXIu
aA0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KKy0gaW5jbHVk
ZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaA0KIA0KIFJlcXVpcmVkIHByb3BlcnRp
ZXMgZm9yIHBvd2VyIGNvbnRyb2xsZXI6DQogLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9m
Og0KQEAgLTI5LDYgKzMwLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllcyBmb3IgcG93ZXIgY29udHJv
bGxlcjoNCiAJLSAibWVkaWF0ZWssbXQ3NjI5LXNjcHN5cyIsICJtZWRpYXRlayxtdDc2MjItc2Nw
c3lzIjogRm9yIE1UNzYyOSBTb0MNCiAJLSAibWVkaWF0ZWssbXQ4MTczLXNjcHN5cyINCiAJLSAi
bWVkaWF0ZWssbXQ4MTgzLXNjcHN5cyINCisJLSAibWVkaWF0ZWssbXQ4MTkyLXNjcHN5cyINCiAt
ICNwb3dlci1kb21haW4tY2VsbHM6IE11c3QgYmUgMQ0KIC0gI2FkZHJlc3MtY2VsbHM6IFNob3Vs
ZCBiZSAxDQogLSAjc2l6ZS1jZWxsczogU2hvdWxkIGJlIDANCkBAIC01MCw2ICs1Miw5IEBAIFJl
cXVpcmVkIHByb3BlcnRpZXMgZm9yIHBvd2VyIGNvbnRyb2xsZXI6DQogCVJlcXVpcmVkIGNsb2Nr
cyBmb3IgTVQ4MTgzOiAiYXVkaW8iLCAiYXVkaW8xIiwgImF1ZGlvMiIsICJtZmciLCAibW0iLA0K
IAkJCQkgICAgImNhbSIsICJpc3AiLCAidnB1IiwgInZwdTEiLCAidnB1MiIsDQogCQkJCSAgICAi
dnB1MyI7DQorCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ4MTkyOiAiYXVkaW8iLCAiYXVkaW8xIiwg
ImF1ZGlvMiIsICJjb25uIiwgIm1mZyIsDQorCQkJCSAgICAiZGlzcCIsICJkaXNwMSIsICJpcGUi
LCAiaXNwIiwgImlzcDEiLA0KKwkJCQkgICAgIm1kcCIsICJ2ZW5jIiwgInZkZWMiLCAiY2FtIg0K
IA0KIE9wdGlvbmFsIHByb3BlcnRpZXMgZm9yIHBvd2VyIGNvbnRyb2xsZXI6DQogLSB2ZGVjLXN1
cHBseTogUG93ZXIgc3VwcGx5IGZvciB0aGUgdmRlYyBwb3dlciBkb21haW4NCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1wb3dlci5oIGIvaW5jbHVkZS9kdC1i
aW5kaW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4
IDAwMDAwMDAuLjRlYWE1M2QNCi0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1ZGUvZHQtYmluZGlu
Z3MvcG93ZXIvbXQ4MTkyLXBvd2VyLmgNCkBAIC0wLDAgKzEsMzIgQEANCisvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlh
VGVrIEluYy4NCisgKiBBdXRob3I6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQor
ICovDQorDQorI2lmbmRlZiBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTkyX1BPV0VSX0gNCisjZGVm
aW5lIF9EVF9CSU5ESU5HU19QT1dFUl9NVDgxOTJfUE9XRVJfSA0KKw0KKyNkZWZpbmUgTVQ4MTky
X1BPV0VSX0RPTUFJTl9BVURJTwkwDQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0NPTk4J
MQ0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRkcwCTINCisjZGVmaW5lIE1UODE5Ml9Q
T1dFUl9ET01BSU5fTUZHMQkzDQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX01GRzIJNA0K
KyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRkczCTUNCisjZGVmaW5lIE1UODE5Ml9QT1dF
Ul9ET01BSU5fTUZHNAk2DQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX01GRzUJNw0KKyNk
ZWZpbmUgTVQ4MTkyX1BPV0VSX0RPTUFJTl9NRkc2CTgNCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9E
T01BSU5fRElTUAk5DQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0lQRQkJMTANCisjZGVm
aW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fSVNQCQkxMQ0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RP
TUFJTl9JU1AyCTEyDQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX01EUAkJMTMNCisjZGVm
aW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fVkVOQwkxNA0KKyNkZWZpbmUgTVQ4MTkyX1BPV0VSX0RP
TUFJTl9WREVDCTE1DQorI2RlZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX1ZERUMyCTE2DQorI2Rl
ZmluZSBNVDgxOTJfUE9XRVJfRE9NQUlOX0NBTQkJMTcNCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9E
T01BSU5fQ0FNX1JBV0EJMTgNCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fQ0FNX1JBV0IJ
MTkNCisjZGVmaW5lIE1UODE5Ml9QT1dFUl9ET01BSU5fQ0FNX1JBV0MJMjANCisNCisjZW5kaWYg
LyogX0RUX0JJTkRJTkdTX1BPV0VSX01UODE5Ml9QT1dFUl9IICovDQotLSANCjEuOC4xLjEuZGly
dHkNCg==

