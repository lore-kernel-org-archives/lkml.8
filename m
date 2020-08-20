Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F17C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C44F20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rguRe/s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHTFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:30621 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgHTFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:21 -0400
X-UUID: cc999b98498d42cdb13ac7af8900fc75-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8MLwD3gkfbEFQ+qj1XGRZ5pG2UR6AqYlaUwnbuLOed8=;
        b=rguRe/s8BkMBvXJQheCoid/PGEZvd0xgYlZ6QdV4WBXImRL+f5qLzfvDUsbIJdnWKusBKLUhkl5qLXlk1QuJ5FYKGvf4vrKjKmA/C/iC+6j6cqBO7ZqmHws/m7hlHpUcZF2r6a+z405mlooi50SfFNQivdM/fJ5J7tk6TlKVAIY=;
X-UUID: cc999b98498d42cdb13ac7af8900fc75-20200820
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1405888067; Thu, 20 Aug 2020 13:47:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2 01/11] usb: early: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:39 +0800
Message-ID: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 969B85A066FD04249CC8CF2E942C15D3031504E50D3B0C4302B76F80AD73868D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KQ2M6IE1hdGhpYXMgTnltYW4gPG1h
dGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hhbmdlcw0KLS0tDQog
ZHJpdmVycy91c2IvZWFybHkveGhjaS1kYmMuYyB8IDE0ICsrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9lYXJseS94aGNpLWRiYy5jIGIvZHJpdmVycy91c2IvZWFybHkveGhjaS1k
YmMuYw0KaW5kZXggYzA1MDc3Ni4uYmU0ZWNiYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vh
cmx5L3hoY2ktZGJjLmMNCisrKyBiL2RyaXZlcnMvdXNiL2Vhcmx5L3hoY2ktZGJjLmMNCkBAIC0x
NCw2ICsxNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3BjaV9pZHMuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvbWVtYmxvY2suaD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgv
aW9wb2xsLmg+DQogI2luY2x1ZGUgPGFzbS9wY2ktZGlyZWN0Lmg+DQogI2luY2x1ZGUgPGFzbS9m
aXhtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvYmNkLmg+DQpAQCAtMTM1LDE2ICsxMzYsOSBAQCBz
dGF0aWMgaW50IGhhbmRzaGFrZSh2b2lkIF9faW9tZW0gKnB0ciwgdTMyIG1hc2ssIHUzMiBkb25l
LCBpbnQgd2FpdCwgaW50IGRlbGF5KQ0KIHsNCiAJdTMyIHJlc3VsdDsNCiANCi0JZG8gew0KLQkJ
cmVzdWx0ID0gcmVhZGwocHRyKTsNCi0JCXJlc3VsdCAmPSBtYXNrOw0KLQkJaWYgKHJlc3VsdCA9
PSBkb25lKQ0KLQkJCXJldHVybiAwOw0KLQkJdWRlbGF5KGRlbGF5KTsNCi0JCXdhaXQgLT0gZGVs
YXk7DQotCX0gd2hpbGUgKHdhaXQgPiAwKTsNCi0NCi0JcmV0dXJuIC1FVElNRURPVVQ7DQorCXJl
dHVybiByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHB0ciwgcmVzdWx0LA0KKwkJCQkJICgocmVz
dWx0ICYgbWFzaykgPT0gZG9uZSksDQorCQkJCQkgZGVsYXksIHdhaXQpOw0KIH0NCiANCiBzdGF0
aWMgdm9pZCBfX2luaXQgeGRiY19iaW9zX2hhbmRvZmYodm9pZCkNCi0tIA0KMS45LjENCg==

