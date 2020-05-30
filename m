Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86986C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B19208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZIWmh0hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgE3INL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22337 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3INJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:09 -0400
X-UUID: f321be2973164b41999d2e448eacb62c-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QagKBSo8QFwvJ//9sIEJ70vkMyQb9zwTGgIpL4HmXWw=;
        b=ZIWmh0hgyzfM47NOPcGg87+tcwnyHfBZRpjX3V0Mr2sSm9gabqs3ADYzeTzJcEj+OZE5Js8DQ8KnwyhG8ACyzTU0vTN5A5IIB024c/9Ift7G37dCznt40QArPsvc58Oa0YXalnE+SldAa2bs9hMPFcbvg+/ejOyK+Rt0QxU0gsE=;
X-UUID: f321be2973164b41999d2e448eacb62c-20200530
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 445777656; Sat, 30 May 2020 16:13:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 05/17] memory: mtk-smi: Add device-link between smi-larb and smi-common
Date:   Sat, 30 May 2020 16:10:06 +0800
Message-ID: <1590826218-23653-6-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm9ybWFsbHksIElmIHRoZSBzbWktbGFyYiBIVyBuZWVkIHdvcmssIHdlIHNob3VsZCBlbmFibGUg
dGhlIHNtaS1jb21tb24NCkhXIHBvd2VyIGFuZCBjbG9jayBmaXJzdGx5Lg0KVGhpcyBwYXRjaCBh
ZGRzIGRldmljZS1saW5rIGJldHdlZW4gdGhlIHNtaS1sYXJiIGRldiBhbmQgdGhlIHNtaS1jb21t
b24NCmRldi4gdGhlbiBJZiBwbV9ydW50aW1lX2dldF9zeW5jKHNtaS1sYXJiLWRldiksIHRoZSBw
bV9ydW50aW1lX2dldF9zeW5jDQooc21pLWNvbW1vbi1kZXYpIHdpbGwgYmUgY2FsbGVkIGF1dG9t
YXRpY2FsbHkuDQoNCkFsc28sIEFkZCBETF9GTEFHX1NUQVRFTEVTUyB0byBhdm9pZCB0aGUgc21p
LWNvbW1vbiBjbG9ja3MgYmUgZ2F0ZWQgd2hlbg0KcHJvYmUuDQoNCkNDOiBNYXR0aGlhcyBCcnVn
Z2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU3VnZ2VzdGVkLWJ5OiBUb21hc3ogRmlnYSA8
dGZpZ2FAY2hyb21pdW0ub3JnPg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxOSArKysrKysrKysr
LS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMgYi9kcml2ZXJzL21l
bW9yeS9tdGstc21pLmMNCmluZGV4IGExMTNlODEuLjZjZGVmZGEgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAg
LTI3Myw2ICsyNzMsNyBAQCBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0K
IAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnNtaV9ub2RlOw0KIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpzbWlfcGRldjsNCisJc3RydWN0IGRldmljZV9saW5rICpsaW5rOw0KIA0KIAlsYXJiID0gZGV2
bV9remFsbG9jKGRldiwgc2l6ZW9mKCpsYXJiKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghbGFyYikN
CkBAIC0zMTIsNiArMzEzLDEyIEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlpZiAoIXBsYXRmb3JtX2dldF9kcnZkYXRhKHNt
aV9wZGV2KSkNCiAJCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCiAJCWxhcmItPnNtaV9jb21tb25f
ZGV2ID0gJnNtaV9wZGV2LT5kZXY7DQorCQlsaW5rID0gZGV2aWNlX2xpbmtfYWRkKGRldiwgbGFy
Yi0+c21pX2NvbW1vbl9kZXYsDQorCQkJCSAgICAgICBETF9GTEFHX1BNX1JVTlRJTUUgfCBETF9G
TEFHX1NUQVRFTEVTUyk7DQorCQlpZiAoIWxpbmspIHsNCisJCQlkZXZfZXJyKGRldiwgIlVuYWJs
ZSB0byBsaW5rIHNtaS1jb21tb24gZGV2XG4iKTsNCisJCQlyZXR1cm4gLUVOT0RFVjsNCisJCX0N
CiAJfSBlbHNlIHsNCiAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCB0aGUgc21pX2NvbW1v
biBkZXZpY2VcbiIpOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQpAQCAtMzI0LDYgKzMzMSw5IEBAIHN0
YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogDQogc3RhdGljIGludCBtdGtfc21pX2xhcmJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQogew0KKwlzdHJ1Y3QgbXRrX3NtaV9sYXJiICpsYXJiID0gcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldik7DQorDQorCWRldmljZV9saW5rX3JlbW92ZSgmcGRldi0+ZGV2LCBsYXJi
LT5zbWlfY29tbW9uX2Rldik7DQogCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCiAJ
Y29tcG9uZW50X2RlbCgmcGRldi0+ZGV2LCAmbXRrX3NtaV9sYXJiX2NvbXBvbmVudF9vcHMpOw0K
IAlyZXR1cm4gMDsNCkBAIC0zMzUsMTcgKzM0NSw5IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgbXRrX3NtaV9sYXJiX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCWNvbnN0IHN0cnVj
dCBtdGtfc21pX2xhcmJfZ2VuICpsYXJiX2dlbiA9IGxhcmItPmxhcmJfZ2VuOw0KIAlpbnQgcmV0
Ow0KIA0KLQkvKiBQb3dlciBvbiBzbWktY29tbW9uLiAqLw0KLQlyZXQgPSBwbV9ydW50aW1lX2dl
dF9zeW5jKGxhcmItPnNtaV9jb21tb25fZGV2KTsNCi0JaWYgKHJldCA8IDApIHsNCi0JCWRldl9l
cnIoZGV2LCAiRmFpbGVkIHRvIHBtIGdldCBmb3Igc21pLWNvbW1vbiglZCkuXG4iLCByZXQpOw0K
LQkJcmV0dXJuIHJldDsNCi0JfQ0KLQ0KIAlyZXQgPSBtdGtfc21pX2Nsa19lbmFibGUoJmxhcmIt
PnNtaSk7DQogCWlmIChyZXQgPCAwKSB7DQogCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBlbmFi
bGUgY2xvY2soJWQpLlxuIiwgcmV0KTsNCi0JCXBtX3J1bnRpbWVfcHV0X3N5bmMobGFyYi0+c21p
X2NvbW1vbl9kZXYpOw0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KQEAgLTM2MCw3ICszNjIsNiBA
QCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19zbWlfbGFyYl9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikNCiAJc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYiA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KIA0KIAltdGtfc21pX2Nsa19kaXNhYmxlKCZsYXJiLT5zbWkpOw0KLQlwbV9ydW50
aW1lX3B1dF9zeW5jKGxhcmItPnNtaV9jb21tb25fZGV2KTsNCiAJcmV0dXJuIDA7DQogfQ0KIA0K
LS0gDQoxLjkuMQ0K

