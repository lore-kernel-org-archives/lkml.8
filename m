Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298FE22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CwMdNAXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgHEUO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:14:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57483 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726793AbgHEQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
X-UUID: 1b958955b04a4447aec755d2b776b42c-20200805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rgglf6GVKnv1Jkvp64Ht2UoQ1fYb0dBQwks3oFNLEHQ=;
        b=CwMdNAXHypaiPgbzk0HdMEaZbUntKlPxOeopJwJQ9VZCsuS8KH1SPvpAt+UzKy0KhkGg3ov/ssOCSJVknV5TDiF11FkEsYN4UUaADFOEWqk1IIFSABa4atRhzY5kypeSUz+WpvgcEZB6wC6KYtPjU4AfHSrJzdJV7uZ7C039WG4=;
X-UUID: 1b958955b04a4447aec755d2b776b42c-20200805
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 550693179; Wed, 05 Aug 2020 18:53:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 5 Aug 2020 18:53:18 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Aug 2020 18:53:19 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <robh+dt@kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <qii.wang@mediatek.com>
Subject: [PATCH v3 3/4] dt-bindings: i2c: update bindings for MT8192 SoC
Date:   Wed, 5 Aug 2020 18:52:21 +0800
Message-ID: <1596624742-14727-4-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1596624742-14727-1-git-send-email-qii.wang@mediatek.com>
References: <1596624742-14727-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgRFQgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciB0aGUgTVQ4MTkyIHNvYy4NCg0KQWNr
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBRaWkg
V2FuZyA8cWlpLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pMmMvaTJjLW10NjV4eC50eHQNCmluZGV4IDg4YjcxYzEuLjdmMDE5NGYgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1eHgudHh0
DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1eHgu
dHh0DQpAQCAtMTQsNiArMTQsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KICAgICAgICJtZWRp
YXRlayxtdDc2MjktaTJjIiwgIm1lZGlhdGVrLG10MjcxMi1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ3
NjI5DQogICAgICAgIm1lZGlhdGVrLG10ODE3My1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ4MTczDQog
ICAgICAgIm1lZGlhdGVrLG10ODE4My1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ4MTgzDQorICAgICAg
Im1lZGlhdGVrLG10ODE5Mi1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ4MTkyDQogICAgICAgIm1lZGlh
dGVrLG10ODUxNi1pMmMiLCAibWVkaWF0ZWssbXQyNzEyLWkyYyI6IGZvciBNZWRpYVRlayBNVDg1
MTYNCiAgIC0gcmVnOiBwaHlzaWNhbCBiYXNlIGFkZHJlc3Mgb2YgdGhlIGNvbnRyb2xsZXIgYW5k
IGRtYSBiYXNlLCBsZW5ndGggb2YgbWVtb3J5DQogICAgIG1hcHBlZCByZWdpb24uDQotLSANCjEu
OS4xDQo=

