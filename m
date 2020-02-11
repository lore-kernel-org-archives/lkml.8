Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1FC352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OflNnNmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBKDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:21:59 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58045 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727697AbgBKDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:21:58 -0500
X-UUID: 279d14474d654630bd47f8e963492b34-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Przgcn+caKj20u1aUM314jPYjqMO0fjjKp7YGppq5UI=;
        b=OflNnNmMnjG9fGswLEYXi2MP0dTN3Mh62lcSBUMIxzoGMzGli2yqdNL5y6R40J3pqmdknlb3FaLKuK/YB/EhiKnqtc1towbDz+/Dhd7BbM7QHQGyyKCc4rcFeJvOnjN1L8H1iCVBD7/VU+WnTXLMzcbdkKORKOszV4MPwNt6yrY=;
X-UUID: 279d14474d654630bd47f8e963492b34-20200211
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 933524121; Tue, 11 Feb 2020 11:21:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:20:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 01/11] dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Date:   Tue, 11 Feb 2020 11:21:06 +0800
Message-ID: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 73A7B8D2F734242113F0EA94675AEA20FAAF7F1E295A14BE518A57E453EFCBB12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzLCBvbmUgZm9yIHR1bmluZyBKLUsgdm9sdGFnZSBi
eSBJTlRSLA0KYW5vdGhlciBmb3IgZGlzY29ubmVjdCB0aHJlc2hvbGQsIGJvdGggb2YgdGhlbSBh
cmUgcmVsYXRlZCB3aXRoDQpjb25uZWN0IGRldGVjdGlvbg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjU6IGFkZCBhY2tlZC1ieSBSb2INCg0KdjQ6IG5v
IGNoYW5nZXMNCg0KdjM6IGNoYW5nZSBjb21taXQgbG9nDQoNCnYyOiBjaGFuZ2UgZGVzY3JpcHRp
b24NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10
cGh5LnR4dCB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQNCmluZGV4IGE1ZjdhNGYwZGJjMS4uY2U2YWJmYmRmYmUxIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQN
CkBAIC01Miw2ICs1Miw4IEBAIE9wdGlvbmFsIHByb3BlcnRpZXMgKFBIWV9UWVBFX1VTQjIgcG9y
dCAoY2hpbGQpIG5vZGUpOg0KIC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVjdGlv
biBvZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2UNCiAtIG1lZGlhdGVrLGV5ZS10ZXJtCTogdTMyLCB0
aGUgc2VsZWN0aW9uIG9mIEhTX1RYIFRFUk0gcmVmZXJlbmNlIHZvbHRhZ2UNCiAtIG1lZGlhdGVr
LGJjMTIJOiBib29sLCBlbmFibGUgQkMxMiBvZiB1MnBoeSBpZiBzdXBwb3J0IGl0DQorLSBtZWRp
YXRlayxkaXNjdGgJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgZGlzY29ubmVjdCB0aHJlc2hvbGQN
CistIG1lZGlhdGVrLGludHIJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgaW50ZXJuYWwgUiAocmVz
aXN0YW5jZSkNCiANCiBFeGFtcGxlOg0KIA0KLS0gDQoyLjI1LjANCg==

