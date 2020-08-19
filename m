Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12637C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE623206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D2VdRfCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgHSMnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:43:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55439 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728036AbgHSMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:42:54 -0400
X-UUID: 042201c97e8e4e7c9fbbb760b83da56f-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b6owPCjpasIYidgAsRKMlqeM1EqM75qi1guA0uBBWPk=;
        b=D2VdRfCZPov7x0Q60+MMI16NKwrzI8UNqhVXwxZ871VCbMCHcN46XKl1t4wqBIGwj66oseTIjXIEzb1lbENdf8WF9UHGIuVaqaL9fHqmcoMr5D6WwknValScNaO+VAhOAUmyk7peuW3QabOfYyJ9wmgXE02ynruNqsAinpA7ApA=;
X-UUID: 042201c97e8e4e7c9fbbb760b83da56f-20200819
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1644332579; Wed, 19 Aug 2020 20:42:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:44 +0800
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
Subject: [PATCH 03/10] usb: pci-quirks: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:40:58 +0800
Message-ID: <1597840865-26631-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 06646778FB2686F5E984FAB9759175ECDE1BBAA36A064A42CB520E8BAA7E74D02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jIHwgMTMgKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9ob3N0L3BjaS1xdWlya3MuYyBiL2RyaXZlcnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5j
DQppbmRleCBiODk2MWMwLi44OTIwNTY2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9w
Y2ktcXVpcmtzLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jDQpAQCAtMTYs
NiArMTYsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCiAjaW5jbHVkZSA8bGludXgv
YWNwaS5oPg0KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xs
Lmg+DQogDQogI2luY2x1ZGUgPHNvYy9iY20yODM1L3Jhc3BiZXJyeXBpLWZpcm13YXJlLmg+DQog
DQpAQCAtMTAxMiwxNSArMTAxMyw5IEBAIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHZvaWQgX19pb21l
bSAqcHRyLCB1MzIgbWFzaywgdTMyIGRvbmUsDQogew0KIAl1MzIJcmVzdWx0Ow0KIA0KLQlkbyB7
DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJcmVzdWx0ICY9IG1hc2s7DQotCQlpZiAocmVz
dWx0ID09IGRvbmUpDQotCQkJcmV0dXJuIDA7DQotCQl1ZGVsYXkoZGVsYXlfdXNlYyk7DQotCQl3
YWl0X3VzZWMgLT0gZGVsYXlfdXNlYzsNCi0JfSB3aGlsZSAod2FpdF91c2VjID4gMCk7DQotCXJl
dHVybiAtRVRJTUVET1VUOw0KKwlyZXR1cm4gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIs
IHJlc3VsdCwNCisJCQkJCSAoKHJlc3VsdCAmIG1hc2spID09IGRvbmUpLA0KKwkJCQkJIGRlbGF5
X3VzZWMsIHdhaXRfdXNlYyk7DQogfQ0KIA0KIC8qDQotLSANCjEuOS4xDQo=

