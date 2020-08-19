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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72ABC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B2C206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QazGoteN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgHSMo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:44:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23905 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728281AbgHSMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:02 -0400
X-UUID: 3049c8ad1f5446a8874adc130c91897b-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8uPUV+WuJUk2y2D4BlVGYPxJs4zQfi1SnztFfLAGohI=;
        b=QazGoteNiwD18kEomorQZ0EOcrtmDC/HfBdmV1SD7JbVHnTElOLkfCf5826y4qQxXBPbVKbumnV9mDnv3FU24mcEba0woY3ef5IIM0VjuamST7st+GsuzdqClU5c07Dc3EEYRQfLglN2JldmHngr93KQfgeGsAlJCXP8/S5nZOk=;
X-UUID: 3049c8ad1f5446a8874adc130c91897b-20200819
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1013727161; Wed, 19 Aug 2020 20:42:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:51 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/10] usb: phy: phy-mv-usb: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:04 +0800
Message-ID: <1597840865-26631-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 880C2D39F7C81EB325277EEE0174E037DFB900233850FB14E9242C8AAB137E272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL3BoeS9waHktbXYtdXNiLmMgfCAxNiArKysrKysrLS0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL3BoeS9waHktbXYtdXNiLmMgYi9kcml2ZXJzL3VzYi9waHkvcGh5LW12
LXVzYi5jDQppbmRleCBjZTc2N2VjLi4wMDhlZDU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
cGh5L3BoeS1tdi11c2IuYw0KKysrIGIvZHJpdmVycy91c2IvcGh5L3BoeS1tdi11c2IuYw0KQEAg
LTgsNiArOCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvaW9w
b2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4NCiAjaW5jbHVkZSA8bGludXgvZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Byb2NfZnMuaD4NCkBAIC0xMzUsOCArMTM2LDggQEAg
c3RhdGljIGludCBtdl9vdGdfc2V0X3RpbWVyKHN0cnVjdCBtdl9vdGcgKm12b3RnLCB1bnNpZ25l
ZCBpbnQgaWQsDQogDQogc3RhdGljIGludCBtdl9vdGdfcmVzZXQoc3RydWN0IG12X290ZyAqbXZv
dGcpDQogew0KLQl1bnNpZ25lZCBpbnQgbG9vcHM7DQogCXUzMiB0bXA7DQorCWludCByZXQ7DQog
DQogCS8qIFN0b3AgdGhlIGNvbnRyb2xsZXIgKi8NCiAJdG1wID0gcmVhZGwoJm12b3RnLT5vcF9y
ZWdzLT51c2JjbWQpOw0KQEAgLTE0NiwxNSArMTQ3LDEyIEBAIHN0YXRpYyBpbnQgbXZfb3RnX3Jl
c2V0KHN0cnVjdCBtdl9vdGcgKm12b3RnKQ0KIAkvKiBSZXNldCB0aGUgY29udHJvbGxlciB0byBn
ZXQgZGVmYXVsdCB2YWx1ZXMgKi8NCiAJd3JpdGVsKFVTQkNNRF9DVFJMX1JFU0VULCAmbXZvdGct
Pm9wX3JlZ3MtPnVzYmNtZCk7DQogDQotCWxvb3BzID0gNTAwOw0KLQl3aGlsZSAocmVhZGwoJm12
b3RnLT5vcF9yZWdzLT51c2JjbWQpICYgVVNCQ01EX0NUUkxfUkVTRVQpIHsNCi0JCWlmIChsb29w
cyA9PSAwKSB7DQotCQkJZGV2X2VycigmbXZvdGctPnBkZXYtPmRldiwNCisJcmV0ID0gcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYygmbXZvdGctPm9wX3JlZ3MtPnVzYmNtZCwgdG1wLA0KKwkJCQko
dG1wICYgVVNCQ01EX0NUUkxfUkVTRVQpLCAyMCwgMTAwMDApOw0KKwlpZiAocmV0IDwgMCkgew0K
KwkJZGV2X2VycigmbXZvdGctPnBkZXYtPmRldiwNCiAJCQkJIldhaXQgZm9yIFJFU0VUIGNvbXBs
ZXRlZCBUSU1FT1VUXG4iKTsNCi0JCQlyZXR1cm4gLUVUSU1FRE9VVDsNCi0JCX0NCi0JCWxvb3Bz
LS07DQotCQl1ZGVsYXkoMjApOw0KKwkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KIAl3cml0ZWwoMHgw
LCAmbXZvdGctPm9wX3JlZ3MtPnVzYmludHIpOw0KLS0gDQoxLjkuMQ0K

