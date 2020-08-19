Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76989206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NU/6cjoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHSMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:44:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39628 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728285AbgHSMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:03 -0400
X-UUID: 68e5bc0619e64324aae4ceb87398d0ed-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BwV3u0UCzhuW0Euj9HoyhyyD5L8KPMx+OzfJoFQQAdE=;
        b=NU/6cjoGTlFPEHz8TeVyYJ1nQlhS+AqhE5Qt7/Rx1dvEQjmsJzmKoNqYQkuOBYGqPuuHKS5zQ6iANlUXnYa283NvZz/+VUuEahCJ2kp+kIN7sC49RMesc3aOJDRawUwbm5aZ3Zof/8HwxfNYhZRhzEHCGxU4hTUmZKfjZFcfgV4=;
X-UUID: 68e5bc0619e64324aae4ceb87398d0ed-20200819
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1275289551; Wed, 19 Aug 2020 20:42:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:50 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/10] usb: phy-ulpi-viewport: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:41:03 +0800
Message-ID: <1597840865-26631-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 540DEF74C77FA8C5F52AD2B56CB2756BDC5DDF21B9D2E21F148585182723DFB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3cG9ydC5jIHwgMTIgKysrLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3cG9ydC5jIGIvZHJpdmVycy91c2Iv
cGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCmluZGV4IDdhMTRlMGUuLjBmNjFlMzIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LXVscGktdmlld3BvcnQuYw0KKysrIGIvZHJpdmVycy91
c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCkBAIC03LDYgKzcsNyBAQA0KICNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNiLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC91c2Iv
b3RnLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi91bHBpLmg+DQogDQpAQCAtMjAsMTYgKzIxLDkg
QEANCiANCiBzdGF0aWMgaW50IHVscGlfdmlld3BvcnRfd2FpdCh2b2lkIF9faW9tZW0gKnZpZXcs
IHUzMiBtYXNrKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyB1c2VjID0gMjAwMDsNCisJdTMyIHZhbDsN
CiANCi0Jd2hpbGUgKHVzZWMtLSkgew0KLQkJaWYgKCEocmVhZGwodmlldykgJiBtYXNrKSkNCi0J
CQlyZXR1cm4gMDsNCi0NCi0JCXVkZWxheSgxKTsNCi0JfQ0KLQ0KLQlyZXR1cm4gLUVUSU1FRE9V
VDsNCisJcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWModmlldywgdmFsLCAhKHZhbCAm
IG1hc2spLCAxLCAyMDAwKTsNCiB9DQogDQogc3RhdGljIGludCB1bHBpX3ZpZXdwb3J0X3JlYWQo
c3RydWN0IHVzYl9waHkgKm90ZywgdTMyIHJlZykNCi0tIA0KMS45LjENCg==

