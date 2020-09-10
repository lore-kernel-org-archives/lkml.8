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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC06C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B782076D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TzlolGJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgIJI1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:27:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24230 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730412AbgIJIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:37 -0400
X-UUID: 5e76e5d89b0f4a5da4c1d25555c79537-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=alOtbDy8sNebdE7u73c0CBOo4U8QiV6rJoaa+rnc/yY=;
        b=TzlolGJjnKElZdgaXcrNDRlRqueyhjY2DKRU0wdiG/7bcesAgIRDiKRTkzMp7gZbKCKjFAmnxRit4Xb23eVS/+lmZEfTEhWD4zKrbpNMnm65efTa4FUFdYZOyBjGv8IFjU1R34jPq0rnwUPa6ILDb0gen2egrWDhwyyDJuXAjU4=;
X-UUID: 5e76e5d89b0f4a5da4c1d25555c79537-20200910
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1316339729; Thu, 10 Sep 2020 16:24:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:09 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH RESEND v3 08/11] usb: phy-ulpi-viewport: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:49 +0800
Message-ID: <1599726112-4439-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0F0E5AEE4A43A08AF82FBC584F94AC36F0023DD0166A4C8724EEB7840B8A51B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3cG9y
dC5jIHwgMTIgKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12
aWV3cG9ydC5jIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCmluZGV4IDdh
MTRlMGUuLjBmNjFlMzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LXVscGktdmll
d3BvcnQuYw0KKysrIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCkBAIC03
LDYgKzcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgv
dXNiLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KICNpbmNsdWRlIDxsaW51eC91c2Ivb3RnLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi91bHBp
Lmg+DQogDQpAQCAtMjAsMTYgKzIxLDkgQEANCiANCiBzdGF0aWMgaW50IHVscGlfdmlld3BvcnRf
d2FpdCh2b2lkIF9faW9tZW0gKnZpZXcsIHUzMiBtYXNrKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyB1
c2VjID0gMjAwMDsNCisJdTMyIHZhbDsNCiANCi0Jd2hpbGUgKHVzZWMtLSkgew0KLQkJaWYgKCEo
cmVhZGwodmlldykgJiBtYXNrKSkNCi0JCQlyZXR1cm4gMDsNCi0NCi0JCXVkZWxheSgxKTsNCi0J
fQ0KLQ0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9h
dG9taWModmlldywgdmFsLCAhKHZhbCAmIG1hc2spLCAxLCAyMDAwKTsNCiB9DQogDQogc3RhdGlj
IGludCB1bHBpX3ZpZXdwb3J0X3JlYWQoc3RydWN0IHVzYl9waHkgKm90ZywgdTMyIHJlZykNCi0t
IA0KMS45LjENCg==

