Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7FBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6A8206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JLNEaiLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHCGW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:22:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45973 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbgHCGW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:22:58 -0400
X-UUID: 50c525d60b14444d8016512d93618ded-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WDU+4JwjqH8BnoC2rwYT+kPVuQ4gCSRqYJmpgGcCCGg=;
        b=JLNEaiLZJHn3kwVxh44C5ay5GhoN09maiVYRZFGY5SF6jj+ejiYhcfta6FtpQtwBsdys8Xfrcy9lcvhPS7NUMfpdpoi6vmbVLL87TwQhSTDz0MpVupaIFsQFwlA2SIR9MRN0bA4SrBQrLxtDlp9rCe8+O9vt4YcxIixkOhOV7qc=;
X-UUID: 50c525d60b14444d8016512d93618ded-20200803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2057849103; Mon, 03 Aug 2020 14:22:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:22:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:22:52 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <yj.chiang@mediatek.com>, <alix.wu@mediatek.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/2] irqchip: irq-mt58xx: Add mt58xx series interrupt
Date:   Mon, 3 Aug 2020 14:22:12 +0800
Message-ID: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsgRFRWIFNvQ3MgY29udGFpbiBtdWx0aXBsZSBsZWdhY3kgaW50ZXJydXB0IGNvbnRy
b2xsZXJzIHRoYXQgcm91dGVzDQppbnRlcnJ1cHRzIHRvIHRoZSBHSUMuIEFuZCBhbGwgdGhlIG10
NTh4eCBzZXJpZXMgU29DcyBoYXZlIHRoaXMgY29udHJvbGxlciwNCmhlbmNlIHRoZSBuYW1lIG9m
IHRoZSBkcml2ZXIgYW5kIGJpbmRpbmcuDQoNCk1hcmstUEsgVHNhaSAoMik6DQogIGlycWNoaXA6
IGlycS1tdDU4eHg6IEFkZCBtdDU4eHggaW50ZXJydXB0IGNvbnRyb2xsZXIgc3VwcG9ydA0KICBk
dC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IEFkZCBNVDU4WFggaW50ZXJydXB0IGNv
bnRyb2xsZXINCg0KIC4uLi9tZWRpYXRlayxtdDU4eHgtaW50Yy55YW1sICAgICAgICAgICAgICAg
ICB8ICA3MCArKysrKysrDQogZHJpdmVycy9pcnFjaGlwL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA3ICsNCiBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtbXQ1OHh4LmMgICAgICAgICAgICAg
ICAgICB8IDE5NiArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDI3NCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tZWRpYXRlayxtdDU4eHgtaW50Yy55YW1sDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXJxY2hpcC9pcnEtbXQ1OHh4LmMNCg0KLS0gDQoy
LjE4LjANCg==

