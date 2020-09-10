Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C18C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F02076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UypEheTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgIJIbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:31:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34211 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730397AbgIJIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:37 -0400
X-UUID: 127c51fee3154bd9a5212ba8b0bc5617-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RiKpsCZJex/4PNC9PXP3CBjdPJWYcy6TOG9QBDJhfJg=;
        b=UypEheTd03Zs7dYGpSOC8vGgcuuSQf8HEoyn65/jadsDBEwHF+u3ZHD4MZnhby4YvfLCmE7ESmJ2UhqzbCw3muUCOh/ZFDJwpWbSyqYjXn1n0cWEGJlhSwJX/kxBIdHPbmdAbOGdp0mMylbmU4Wkr+lYwCYvi/Z1QyM+o4uRN2c=;
X-UUID: 127c51fee3154bd9a5212ba8b0bc5617-20200910
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 111676909; Thu, 10 Sep 2020 16:24:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:10 +0800
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
Subject: [PATCH RESEND v3 09/11] usb: phy: phy-mv-usb: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:50 +0800
Message-ID: <1599726112-4439-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9E9FC7DF85F7DECF1FBA81FC92D4B5528B3C18E67E2F8B37039BCCB0CD400C822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djM6IHJlLWFsaWduIGFyZ3VtZW50IG9mIGxvZyBzdWdnZXN0ZWQgYnkgU2VyZ2VpDQoNCnYyOiB1
ZGVsYXkgMTB1cyBpbnN0ZWFkIG9mIDIwdXMgYWNjb3JkaW5nIHRvIGtlcm5lbGRvYw0KLS0tDQog
ZHJpdmVycy91c2IvcGh5L3BoeS1tdi11c2IuYyB8IDE4ICsrKysrKysrLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvcGh5L3BoeS1tdi11c2IuYyBiL2RyaXZlcnMvdXNiL3BoeS9waHkt
bXYtdXNiLmMNCmluZGV4IGNlNzY3ZWMuLjU3NmQ5MjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vz
Yi9waHkvcGh5LW12LXVzYi5jDQorKysgYi9kcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jDQpA
QCAtOCw2ICs4LDcgQEANCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9k
ZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcHJvY19mcy5oPg0KQEAgLTEzNSw4ICsxMzYsOCBA
QCBzdGF0aWMgaW50IG12X290Z19zZXRfdGltZXIoc3RydWN0IG12X290ZyAqbXZvdGcsIHVuc2ln
bmVkIGludCBpZCwNCiANCiBzdGF0aWMgaW50IG12X290Z19yZXNldChzdHJ1Y3QgbXZfb3RnICpt
dm90ZykNCiB7DQotCXVuc2lnbmVkIGludCBsb29wczsNCiAJdTMyIHRtcDsNCisJaW50IHJldDsN
CiANCiAJLyogU3RvcCB0aGUgY29udHJvbGxlciAqLw0KIAl0bXAgPSByZWFkbCgmbXZvdGctPm9w
X3JlZ3MtPnVzYmNtZCk7DQpAQCAtMTQ2LDE1ICsxNDcsMTIgQEAgc3RhdGljIGludCBtdl9vdGdf
cmVzZXQoc3RydWN0IG12X290ZyAqbXZvdGcpDQogCS8qIFJlc2V0IHRoZSBjb250cm9sbGVyIHRv
IGdldCBkZWZhdWx0IHZhbHVlcyAqLw0KIAl3cml0ZWwoVVNCQ01EX0NUUkxfUkVTRVQsICZtdm90
Zy0+b3BfcmVncy0+dXNiY21kKTsNCiANCi0JbG9vcHMgPSA1MDA7DQotCXdoaWxlIChyZWFkbCgm
bXZvdGctPm9wX3JlZ3MtPnVzYmNtZCkgJiBVU0JDTURfQ1RSTF9SRVNFVCkgew0KLQkJaWYgKGxv
b3BzID09IDApIHsNCi0JCQlkZXZfZXJyKCZtdm90Zy0+cGRldi0+ZGV2LA0KLQkJCQkiV2FpdCBm
b3IgUkVTRVQgY29tcGxldGVkIFRJTUVPVVRcbiIpOw0KLQkJCXJldHVybiAtRVRJTUVET1VUOw0K
LQkJfQ0KLQkJbG9vcHMtLTsNCi0JCXVkZWxheSgyMCk7DQorCXJldCA9IHJlYWRsX3BvbGxfdGlt
ZW91dF9hdG9taWMoJm12b3RnLT5vcF9yZWdzLT51c2JjbWQsIHRtcCwNCisJCQkJKHRtcCAmIFVT
QkNNRF9DVFJMX1JFU0VUKSwgMTAsIDEwMDAwKTsNCisJaWYgKHJldCA8IDApIHsNCisJCWRldl9l
cnIoJm12b3RnLT5wZGV2LT5kZXYsDQorCQkJIldhaXQgZm9yIFJFU0VUIGNvbXBsZXRlZCBUSU1F
T1VUXG4iKTsNCisJCXJldHVybiByZXQ7DQogCX0NCiANCiAJd3JpdGVsKDB4MCwgJm12b3RnLT5v
cF9yZWdzLT51c2JpbnRyKTsNCi0tIA0KMS45LjENCg==

