Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3886AC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0336720757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N94cVU5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIEIMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46012 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgIEIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:10 -0400
X-UUID: 063cfce881274713aa9065b95c3f9c83-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OKnMLRRVuoIcgS5aIEFwmMOna1kSiQnret3TGnTwRls=;
        b=N94cVU5WCnuUjBAmARGUpkQovfpHJ3PnSZsje5ufDSWcLMrk+uf9JmbIwqULo9csTKcwY9onewHLszL6F7hCJ3U78uv4AOpwwY6X0bWf/RmLqZG4CodQqAOrOCKUWAVl89Y83mIRKCefyhgPnta/fUIoqcpgqlb7jDt3550lnA8=;
X-UUID: 063cfce881274713aa9065b95c3f9c83-20200905
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 45886555; Sat, 05 Sep 2020 16:12:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:02 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 04/23] dt-bindings: memory: mediatek: Extend LARB_NR_MAX to 32
Date:   Sat, 5 Sep 2020 16:09:01 +0800
Message-ID: <20200905080920.13396-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 184159C0C52A59F0F86A1F2834490BAB06944A950F397786991DCDAABF9EE53E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXh0ZW5kIHRoZSBtYXggbGFyYiBudW1iZXIgZGVmaW5pdGlvbiBhcyBtdDgxOTIgaGFzIGxhcmJf
bnIgb3ZlciAxNi4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KIGluY2x1
ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmggfCA0ICsrLS0NCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCBiL2luY2x1
ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCmluZGV4IDJlYzdmZTVj
ZTRlOS4uZjRkOGUzYWVkMGJjIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1v
cnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkv
bXRrLXNtaS1sYXJiLXBvcnQuaA0KQEAgLTYsMTAgKzYsMTAgQEANCiAjaWZuZGVmIF9fRFRTX01U
S19JT01NVV9QT1JUX0hfDQogI2RlZmluZSBfX0RUU19NVEtfSU9NTVVfUE9SVF9IXw0KIA0KLSNk
ZWZpbmUgTVRLX0xBUkJfTlJfTUFYCQkJMTYNCisjZGVmaW5lIE1US19MQVJCX05SX01BWAkJCTMy
DQogDQogI2RlZmluZSBNVEtfTTRVX0lEKGxhcmIsIHBvcnQpCQkoKChsYXJiKSA8PCA1KSB8IChw
b3J0KSkNCi0jZGVmaW5lIE1US19NNFVfVE9fTEFSQihpZCkJCSgoKGlkKSA+PiA1KSAmIDB4ZikN
CisjZGVmaW5lIE1US19NNFVfVE9fTEFSQihpZCkJCSgoKGlkKSA+PiA1KSAmIDB4MWYpDQogI2Rl
ZmluZSBNVEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4MWYpDQogDQogI2VuZGlmDQotLSAN
CjIuMTguMA0K

