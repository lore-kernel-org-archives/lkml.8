Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D4C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC022072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EWQYwgKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHVIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:09:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63964 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726938AbgHVIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:23 -0400
X-UUID: fb20312230ef4a369dace70f1eb4e5b3-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vQDriCyMjYjM6pnqq6iAk0QyjJohTMSr6/4Cj53MUf4=;
        b=EWQYwgKW9INvhUdqVoPGVHQ4lRCeAX+DIS/0eKiqI46NBFpzqFBZn2dxGXvOayJL96dPfdb3Cxb1JDQpV9wuJOrEYQzrXOgVzVfFYWtPui296h9JfQzmchfMGeocup3PmmhQgscaTsS0lWZfY+eyp1vk57iwShxVTuv1q1KjrS4=;
X-UUID: fb20312230ef4a369dace70f1eb4e5b3-20200822
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 645605410; Sat, 22 Aug 2020 16:09:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v3 03/11] usb: pci-quirks: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:45 +0800
Message-ID: <1598083553-31896-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 14BCA79F542CC2DF6DF6C45CF08EFBF2CF6ED65BFFE122FDEB764F68DF392D022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjJ+djM6
IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jIHwgMTMgKysr
Ky0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3BjaS1xdWlya3MuYyBiL2RyaXZl
cnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jDQppbmRleCBiODk2MWMwLi44OTIwNTY2IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy91c2IvaG9zdC9wY2ktcXVpcmtzLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hv
c3QvcGNpLXF1aXJrcy5jDQpAQCAtMTYsNiArMTYsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9leHBv
cnQuaD4NCiAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4N
CisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogDQogI2luY2x1ZGUgPHNvYy9iY20yODM1L3Jh
c3BiZXJyeXBpLWZpcm13YXJlLmg+DQogDQpAQCAtMTAxMiwxNSArMTAxMyw5IEBAIHN0YXRpYyBp
bnQgaGFuZHNoYWtlKHZvaWQgX19pb21lbSAqcHRyLCB1MzIgbWFzaywgdTMyIGRvbmUsDQogew0K
IAl1MzIJcmVzdWx0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJcmVz
dWx0ICY9IG1hc2s7DQotCQlpZiAocmVzdWx0ID09IGRvbmUpDQotCQkJcmV0dXJuIDA7DQotCQl1
ZGVsYXkoZGVsYXlfdXNlYyk7DQotCQl3YWl0X3VzZWMgLT0gZGVsYXlfdXNlYzsNCi0JfSB3aGls
ZSAod2FpdF91c2VjID4gMCk7DQotCXJldHVybiAtRVRJTUVET1VUOw0KKwlyZXR1cm4gcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSAoKHJlc3VsdCAmIG1hc2sp
ID09IGRvbmUpLA0KKwkJCQkJIGRlbGF5X3VzZWMsIHdhaXRfdXNlYyk7DQogfQ0KIA0KIC8qDQot
LSANCjEuOS4xDQo=

