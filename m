Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CA82065C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nx0ywG3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGJDbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:31:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8845 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbgGJDbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:31:47 -0400
X-UUID: 60e408bae5c34e8199bd39f6c963ffae-20200710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EGM3/BWA8LhSsl+HU+sSKjzVuEq3sKi1FpSTwosiG/Y=;
        b=nx0ywG3UFrBU0jPuTeVq7HNV5sLjB56T57UY7fFULkQTJYkIT4dhVbW4K97Ev+6/oUAkkB3uLcsaVrqGMn5TL8AYc5mOaLvOoxhSaSamMQo8eo8y4TWwzbqPL94LvpjZezJ2DgT9coKBwx876y7Z4lBhoiFEjNLk1T7SbRi/u4o=;
X-UUID: 60e408bae5c34e8199bd39f6c963ffae-20200710
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2019534727; Fri, 10 Jul 2020 11:31:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Jul 2020 11:31:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Jul 2020 11:31:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify code
Date:   Fri, 10 Jul 2020 11:30:56 +0800
Message-ID: <1594351856-876-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FE010D8AB826172DBF251444CD9B52F4A7F285AF900E9FB851C849394F2C0CB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dCgpIHRvIHBvbGwgcmVnaXN0ZXIgc3RhdHVzDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMgfCAyMiArKysrKysrKy0tLS0t
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY29yZS5j
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KaW5kZXggMDJhM2E3Ny4u
ZmExNzNkZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3Jl
LmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMNCkBAIC0xMiw2
ICsxMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQogI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCisjaW5j
bHVkZSA8bGludXgvaW9wb2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPg0KICNpbmNs
dWRlIDxsaW51eC9pby5oPg0KICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQpAQCAtMzIsMjEgKzMz
LDE0IEBADQogc3RhdGljIGludCBwb2xsX29pcChzdHJ1Y3QgYmRjICpiZGMsIGludCB1c2VjKQ0K
IHsNCiAJdTMyIHN0YXR1czsNCi0JLyogUG9sbCB0aWxsIFNUUyE9IE9JUCAqLw0KLQl3aGlsZSAo
dXNlYykgew0KLQkJc3RhdHVzID0gYmRjX3JlYWRsKGJkYy0+cmVncywgQkRDX0JEQ1NDKTsNCi0J
CWlmIChCRENfQ1NUUyhzdGF0dXMpICE9IEJEQ19PSVApIHsNCi0JCQlkZXZfZGJnKGJkYy0+ZGV2
LA0KLQkJCQkicG9sbF9vaXAgY29tcGxldGUgc3RhdHVzPSVkIiwNCi0JCQkJQkRDX0NTVFMoc3Rh
dHVzKSk7DQotCQkJcmV0dXJuIDA7DQotCQl9DQotCQl1ZGVsYXkoMTApOw0KLQkJdXNlYyAtPSAx
MDsNCi0JfQ0KLQlkZXZfZXJyKGJkYy0+ZGV2LCAiRXJyOiBvcGVyYXRpb24gdGltZWRvdXQgQkRD
U0M6IDB4JTA4eFxuIiwgc3RhdHVzKTsNCisJaW50IHJldDsNCiANCi0JcmV0dXJuIC1FVElNRURP
VVQ7DQorCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dChiZGMtPnJlZ3MgKyBCRENfQkRDU0MsIHN0
YXR1cywNCisJCShCRENfQ1NUUyhzdGF0dXMpICE9IEJEQ19PSVApLCAxMCwgdXNlYyk7DQorCWlm
IChyZXQpDQorCQlkZXZfZXJyKGJkYy0+ZGV2LCAiRXJyOiBvcGVyYXRpb24gdGltZWRvdXQgQkRD
U0M6IDB4JTA4eFxuIiwgc3RhdHVzKTsNCisNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogU3Rv
cCB0aGUgQkRDIGNvbnRyb2xsZXIgKi8NCi0tIA0KMS45LjENCg==

