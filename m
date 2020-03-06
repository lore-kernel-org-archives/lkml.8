Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA856C3F2CE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0BA20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UTROVOv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCFDeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:34:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10858 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbgCFDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:34:00 -0500
X-UUID: 23b6f3baa84b4464acf7df0a8a84e55c-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F8h9zECSBIwoJ3KZPuDg4X2pu8P8QW518HiyC2sC3qg=;
        b=UTROVOv65EPLq+FbJ7bO5wDnPLAKz66HsAtZMbm7qo2/rf0itFcygR5dgZ/IPaSTxuSzYpee3QmJcBWZxNmBX+Fjb3jLPbN3/iS2OherlaDzuhbiU9iaUHqO0kjzqFbVWbrvK+h1oNyMipdrjB2Ce+Bhcdn17XrzuFTsVP9m898=;
X-UUID: 23b6f3baa84b4464acf7df0a8a84e55c-20200306
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1293751731; Fri, 06 Mar 2020 11:33:55 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Mar 2020 11:31:50 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 11:33:55 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <eason.yen@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt6359: add codec document
Date:   Fri, 6 Mar 2020 11:33:41 +0800
Message-ID: <1583465622-16628-2-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
References: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG10NjM1OSBjb2RlYyBkb2N1bWVudA0KDQpTaWduZWQtb2ZmLWJ5OiBFYXNvbiBZZW4gPGVh
c29uLnllbkBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbXQ2MzU5LnR4dCB8IDE2ICsrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210NjM1OS50eHQgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnR4dA0KbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjc3ODY0ZTANCi0tLSAvZGV2L251bGwNCisrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDYzNTkudHh0DQpAQCAtMCww
ICsxLDE2IEBADQorTWVkaWF0ZWsgTVQ2MzU5IEF1ZGlvIENvZGVjDQorDQorVGhlIGNvbW11bmlj
YXRpb24gYmV0d2VlbiBNVDYzNTggYW5kIFNvQyBpcyB0aHJvdWdoIE1lZGlhdGVrIFBNSUMgd3Jh
cHBlci4NCitGb3IgbW9yZSBkZXRhaWwsIHBsZWFzZSB2aXNpdCBNZWRpYXRlayBQTUlDIHdyYXBw
ZXIgZG9jdW1lbnRhdGlvbi4NCisNCitNdXN0IGJlIGEgY2hpbGQgbm9kZSBvZiBQTUlDIHdyYXBw
ZXIuDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCisNCistIGNvbXBhdGlibGUgOiAibWVkaWF0
ZWssbXQ2MzU5LXNvdW5kIi4NCisNCitFeGFtcGxlOg0KKw0KK210NjM1OV9zbmQgew0KKwljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NjM1OS1zb3VuZCI7DQorfTsNCi0tIA0KMS45LjENCg==

