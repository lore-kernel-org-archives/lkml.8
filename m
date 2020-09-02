Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC8DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795220826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rYA9GFWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBG7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:59:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgIBG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:59:04 -0400
X-UUID: 119f0345a88c4236a3efd4bbda9cf244-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hTLcyNYyBPWJYX2Mc3Z8w8kIsOdBU9WJXUAKmauSMIk=;
        b=rYA9GFWeBpUrANWsPKg5hciadlHGfWgnVuiexqjjlFIJxgDFMiwrr41/YSNdasHZMKacInal3/WJTPKDYoHDN+w3IQcHKAAhSoyYrsgbfxC4ubXdkF6+lLOPdVAmvI6J5Wc9SahuE9LDTcxkZr4ITG9M7mUU27xuQ5vklgXQk3M=;
X-UUID: 119f0345a88c4236a3efd4bbda9cf244-20200902
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1716032037; Wed, 02 Sep 2020 14:59:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Sep 2020 14:59:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 14:59:00 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Daniel Palmer <daniel@0x0f.com>
CC:     <alix.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 1/2] irqchip: irq-mst: Add MStar interrupt controller support
Date:   Wed, 2 Sep 2020 14:59:00 +0800
Message-ID: <20200902065900.2804-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ec3dd6b7664d647b2dc27926539eadda@kernel.org>
References: <ec3dd6b7664d647b2dc27926539eadda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCg0KPk9uIDIwMjAtMDgtMjAgMTM6
MzYsIERhbmllbCBQYWxtZXIgd3JvdGU6DQo+PiBIaSBNYXJrLVBLLCBNYXJjDQo+PiANCj4+IEkn
bSBub3Qgc3VyZSB0aGlzIHdpbGwgYmUgdGhlIGZpbmFsIHZlcnNpb24gYnV0IEknbSBnb2luZyB0
byB0cnkgdG8NCj4+IGludGVncmF0ZSB0aGlzIHdpdGggbXkgY3VycmVudCBNU3Rhci9TaWdtYVN0
YXIgdHJlZSBvdmVyIHRoZSB3ZWVrZW5kDQo+PiBhbmQgdGhlbiBJIGd1ZXNzIEkgY2FuIGdpdmUg
dGhpcyBhIHRlc3RlZC1ieT8NCj4NCj5UaGF0J2QgYmUgZ29vZC4NCj4NCj4+IEFzc3VtaW5nIHRo
aXMgdmVyc2lvbiBvciB0aGUgbmV4dCBpcyBhY2NlcHRhYmxlIGNhbiBJIGp1c3QgZm9sbG93IHVw
DQo+PiB3aXRoIGEgc21hbGwgcGF0Y2ggdG8gYWRkIHRoZSBpbnN0YW5jZXMgSSBuZWVkIGluIG15
IGR0c2kgb3Igc2hvdWxkIEkNCj4+IHdhaXQgdW50aWwgaXQncyBtZXJnZWQgYmVmb3JlIGRvaW5n
IHRoYXQ/DQo+DQo+Tm8gbmVlZCB0byB3YWl0LCBhbHRob3VnaCB0aGUgcGxhdGZvcm0tc3BlY2lm
aWMgZGV0YWlscyBzaG91bGQgZ28NCj52aWEgdGhlIGFybS1zb2MgdHJlZS4NCj4NCj5JJ20gbm90
IGdvaW5nIHRvIHJldmlldyB0aGUgbmV3IHZlcnNpb24gYmVmb3JlIG5leHQgd2VlayBhbnl3YXkN
Cj4oSSdtIG1ha2luZyBhIHBvaW50IGluIHJldmlld2luZyBhbnkgZ2l2ZW4gc2VyaWVzIGF0IG1v
c3Qgb25jZQ0KPmEgd2VlaykuDQo+DQo+ICAgICAgICAgTS4NCj4tLSANCj5KYXp6IGlzIG5vdCBk
ZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0KDQpJJ3ZlIHBvc3QgdGhlIHBhdGNoIHYzWzFd
IGFuZCB0aGUgZHJpdmVyIGlzIHNhbWUgYXMgdjIuDQpUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IEkg
YWRkIHRoZSB0ZXN0LWJ5IGxhYmVsIGJ5IERhbmllbCBhbmQgYWRkDQphbiBlbnRyeSBpbiBNQUlO
VEFJTkVSUyBmb3IgbXN0LWludGMuDQoNClBsZWFzZSByZXZpZXcgaXQgYW5kIGxldCBtZSBrbm93
IGlmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucy4NClRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA5MDIwNjMzNDQuMTg1Mi0yLW1hcmstcGsudHNhaUBtZWRp
YXRlay5jb20v

