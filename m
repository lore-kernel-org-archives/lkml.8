Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD88C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDB22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bg7jYoo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBKDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:21:59 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:44645 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727669AbgBKDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:21:58 -0500
X-UUID: 889a99af4d5c40e2b529edd7dcc18b55-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wh/Fg1/l349rbKNkjvcOT9Th3fB69ZmWbpXxOpgu1fM=;
        b=Bg7jYoo79vs7Bn4G1jEA1SVzTS1vlfxpp1SBF0rlIDpFzjfZw4Aozb7LPDtHRZZAwkHT1jpERbU9klbdQR79/tTILepUteZX+37kY6PhNQbbgwVRMS3nyGk9Q+AOl/bXi1GtI/TefPDLjpy3Y/Slo9LS5Gvg2EMcRCqslkQM3Mc=;
X-UUID: 889a99af4d5c40e2b529edd7dcc18b55-20200211
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1267518387; Tue, 11 Feb 2020 11:21:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:20:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 03/11] dt-bindings: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Tue, 11 Feb 2020 11:21:08 +0800
Message-ID: <8cf4fceb87e051b1a9245f4e8a432a699590f832.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4869A515F4482D6EE9E2F7470DE5E956F6C45944D8315208F10E1C5AD67A56142000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHUzcGh5YV9yZWYgY2xvY2sgaXMgYWxyZWFkeSBtb3ZlZCBpbnRvIHN1Yi1ub2RlLCBhbmQN
CnJlbmFtZWQgYXMgcmVmIGNsb2NrLCBubyB1c2VkIGFueW1vcmUgbm93LCBzbyByZW1vdmUgaXQN
CnRvIGF2b2lkIGNvbmZ1c2lvbg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCi0tLQ0KdjN+djU6IG5vIGNoYW5nZXMNCg0KdjI6IGFkZCBSZXZpZXdlZC1ieSBS
b2INCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10
cGh5LnR4dCB8IDQgLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRw
aHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRw
aHkudHh0DQppbmRleCAxZjRhMzZkZDgwZTAuLjQ4YmMxYTJlOTI5OSAxMDA2NDQNCi0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0
DQpAQCAtMTMsMTAgKzEzLDYgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoY29udHJvbGxlciAocGFy
ZW50KSBub2RlKToNCiAJCSAgIm1lZGlhdGVrLG10ODE3My11M3BoeSI7DQogCQkgIG1ha2UgdXNl
IG9mICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiIG9uIG10MjcwMSBpbnN0ZWFkIGFuZA0KIAkJ
ICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIiBvbiBtdDI3MTIgaW5zdGVhZC4NCi0gLSBjbG9j
a3MJOiAoZGVwcmVjYXRlZCwgdXNlIHBvcnQncyBjbG9ja3MgaW5zdGVhZCkgYSBsaXN0IG9mIHBo
YW5kbGUgKw0KLQkJICBjbG9jay1zcGVjaWZpZXIgcGFpcnMsIG9uZSBmb3IgZWFjaCBlbnRyeSBp
biBjbG9jay1uYW1lcw0KLSAtIGNsb2NrLW5hbWVzCTogKGRlcHJlY2F0ZWQsIHVzZSBwb3J0J3Mg
b25lIGluc3RlYWQpIG11c3QgY29udGFpbg0KLQkJICAidTNwaHlhX3JlZiI6IGZvciByZWZlcmVu
Y2UgY2xvY2sgb2YgdXNiMy4wIGFuYWxvZyBwaHkuDQogDQogUmVxdWlyZWQgbm9kZXMJOiBhIHN1
Yi1ub2RlIGlzIHJlcXVpcmVkIGZvciBlYWNoIHBvcnQgdGhlIGNvbnRyb2xsZXINCiAJCSAgcHJv
dmlkZXMuIEFkZHJlc3MgcmFuZ2UgaW5mb3JtYXRpb24gaW5jbHVkaW5nIHRoZSB1c3VhbA0KLS0g
DQoyLjI1LjANCg==

