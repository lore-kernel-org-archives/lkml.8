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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270F820724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZJOu6mg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHTFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:48:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23552 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726796AbgHTFrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:25 -0400
X-UUID: 080bf78ed7e141f8a01f37d05917633a-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Nc0xHfObKL/RWS7ZAxeg2rlR3blXBPF5PPHcyocyv1c=;
        b=ZJOu6mg2H4CT+HMNr+QKTWIb1u+uR5FpVY09mNRqmIJc2caObXwAKeqD3P9e3LuKlKg4b+SrQsCZ/oFa2DreCrJwvw2Z6SKQG4LszLJvkP/UIjHBrHpkf2ZaPod+cPw20ddKHkkYz8Myug/yG/95xUO3Omz89DOivTdAaDmnmu8=;
X-UUID: 080bf78ed7e141f8a01f37d05917633a-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 159762519; Thu, 20 Aug 2020 13:47:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:09 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2 03/11] usb: pci-quirks: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:41 +0800
Message-ID: <1597902349-8998-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5AB5EDAEF39C74CE5C3D2A953878BA10D2FB4F876CAD65B53CA02DA6F369C1AD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6IG5v
IGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jIHwgMTMgKysrKy0t
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3BjaS1xdWlya3MuYyBiL2RyaXZlcnMv
dXNiL2hvc3QvcGNpLXF1aXJrcy5jDQppbmRleCBiODk2MWMwLi44OTIwNTY2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvaG9zdC9wY2ktcXVpcmtzLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3Qv
cGNpLXF1aXJrcy5jDQpAQCAtMTYsNiArMTYsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9leHBvcnQu
aD4NCiAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4NCisj
aW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogDQogI2luY2x1ZGUgPHNvYy9iY20yODM1L3Jhc3Bi
ZXJyeXBpLWZpcm13YXJlLmg+DQogDQpAQCAtMTAxMiwxNSArMTAxMyw5IEBAIHN0YXRpYyBpbnQg
aGFuZHNoYWtlKHZvaWQgX19pb21lbSAqcHRyLCB1MzIgbWFzaywgdTMyIGRvbmUsDQogew0KIAl1
MzIJcmVzdWx0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJcmVzdWx0
ICY9IG1hc2s7DQotCQlpZiAocmVzdWx0ID09IGRvbmUpDQotCQkJcmV0dXJuIDA7DQotCQl1ZGVs
YXkoZGVsYXlfdXNlYyk7DQotCQl3YWl0X3VzZWMgLT0gZGVsYXlfdXNlYzsNCi0JfSB3aGlsZSAo
d2FpdF91c2VjID4gMCk7DQotCXJldHVybiAtRVRJTUVET1VUOw0KKwlyZXR1cm4gcmVhZGxfcG9s
bF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSAoKHJlc3VsdCAmIG1hc2spID09
IGRvbmUpLA0KKwkJCQkJIGRlbGF5X3VzZWMsIHdhaXRfdXNlYyk7DQogfQ0KIA0KIC8qDQotLSAN
CjEuOS4xDQo=

