Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65697C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341C420826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MXugq3VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBGeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:34:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgIBGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:34:07 -0400
X-UUID: 425c785ed300459a98a811d508312c01-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=53c4sfWtEQp/XsUMnsdRSVYymnKtnC0kh8GaID/rOdQ=;
        b=MXugq3VMRYL5rjYhb/JoyiA/KO5ioxaPkVh4L1I5VXGd4hcm1pi8ljz/j4YyUaeHIYjlJQylj+oXAsqThnPiWYiCANpvpEL46LZ3kYsR/DimlTzDWqzjugSS9OR7EnMLkFVw23UQTYEZ5Fe5GlGO3HSqSdP+DIpmwIhni0RmfRo=;
X-UUID: 425c785ed300459a98a811d508312c01-20200902
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 310831958; Wed, 02 Sep 2020 14:34:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Sep 2020 14:34:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 14:33:59 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <mark-pk.tsai@mediatek.com>, <alix.wu@mediatek.com>,
        <daniel@0x0f.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: [PATCH v3 0/2] Add MStar interrupt controller support
Date:   Wed, 2 Sep 2020 14:33:42 +0800
Message-ID: <20200902063344.1852-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2774D7340570A9ED91DE96DFC9244A13846B9F0DE513AC10544567D01A222CA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVN0YXIgY29udGFpbiBhIGxlZ2FjeSBpbnRlcnJ1cHQgY29udHJvbGxlciB0aGF0IHJvdXRlcyBp
bnRlcnJ1cHRzDQp0byB0aGUgR0lDLiBTaWdtYVN0YXIgYW5kIE1lZGlhdGVrIFRWIFNvQ3MgYWxz
byBoYXZlIHRoaXMgaW50ZXJydXB0DQpjb250cm9sbGVyIElQLg0KDQpNYXJrLVBLIFRzYWkgKDIp
Og0KICBpcnFjaGlwOiBpcnEtbXN0OiBBZGQgTVN0YXIgaW50ZXJydXB0IGNvbnRyb2xsZXIgc3Vw
cG9ydA0KICBkdC1iaW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IEFkZCBNU3RhciBpbnRl
cnJ1cHQgY29udHJvbGxlcg0KDQogLi4uL2ludGVycnVwdC1jb250cm9sbGVyL21zdGFyLG1zdC1p
bnRjLnlhbWwgIHwgIDY0ICsrKysrKw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9pcnFjaGlwL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICsNCiBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtbXN0LWludGMuYyAgICAg
ICAgICAgICAgICB8IDE5OSArKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDI3
OSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc3Rhcixtc3QtaW50Yy55YW1sDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXJxY2hpcC9pcnEtbXN0LWludGMuYw0KDQotLSAN
CjIuMTguMA0K

