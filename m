Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B78B2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K/IUHLwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgIJIcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:32:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32736 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730394AbgIJIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:35 -0400
X-UUID: 4143ed2616294f21b32a495ddb00ebd0-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vQDriCyMjYjM6pnqq6iAk0QyjJohTMSr6/4Cj53MUf4=;
        b=K/IUHLwNzVVXGw1qbAR659zWN1Fx3FbcxTAXnoNrvCt1f6h0QI3GBYrHordWtIK56V82efgkCBa2HXRPKMmS7yQIZO8CntYmYhkpNuGQiBChZPgnAZu2h4YjkM/2QDbsnTeaXMLgGQTTmz+ZEE9JgjJNSSh6p530Gc2mPn0HMqc=;
X-UUID: 4143ed2616294f21b32a495ddb00ebd0-20200910
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1186567138; Thu, 10 Sep 2020 16:24:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:01 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH RESEND v3 03/11] usb: pci-quirks: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:44 +0800
Message-ID: <1599726112-4439-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8E101BFE2F788B63AD5617A9332290E2362D4EC28CE6A38C9B5E42E2FA50F632000:8
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

