Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A1D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EDUlgwlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHSDmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:42:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50966 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgHSDmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:42:45 -0400
X-UUID: 8dee8c07bb214345a39f2a92cf71bd02-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BBwz+j7u0DHhfO3j7HHVfe4+gppkE3CUJRX7VRb2kew=;
        b=EDUlgwlEVpbpAng48076fGnq7J9+mYGFgJGxdBSewbG9cbwawTusOLSCGaRhb12Oe2GenPy/BoFKXmW3xEZLgP/0By/qGAel9Lvq8Cuwpf29FJKmcvoBBdwZaHVd/T8IMIOcKd5o8X4XtEm+IyhhHnNsKw/AZMjbvFrk8JEbcbw=;
X-UUID: 8dee8c07bb214345a39f2a92cf71bd02-20200819
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 519107776; Wed, 19 Aug 2020 11:42:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 11:42:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 11:42:37 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <mark-pk.tsai@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <alix.wu@mediatek.com>, <daniel@0x0f.com>
Subject: [PATCH 0/2] Add MStar interrupt controller support
Date:   Wed, 19 Aug 2020 11:42:29 +0800
Message-ID: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1570C025066250D22F5BBE36C595C40AD7EEDC98868CD0C0D4C72959324F3BCF2000:8
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
bnRjLnlhbWwgIHwgIDgyICsrKysrKysrDQogZHJpdmVycy9pcnFjaGlwL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA3ICsNCiBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtbXN0LWludGMuYyAg
ICAgICAgICAgICAgICB8IDE5NSArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQs
IDI4NSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc3Rhcixtc3QtaW50Yy55YW1s
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaXJxY2hpcC9pcnEtbXN0LWludGMuYw0KDQot
LSANCjIuMTguMA0K

