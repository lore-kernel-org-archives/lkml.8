Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BDBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064842070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JanaI9bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgEUJGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:06:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11823 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728769AbgEUJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:06:38 -0400
X-UUID: 1ffef90f52b4403eafbe27e1ae4d8041-20200521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0rM0q4hkZ0DNqIzZUdev1uMbsurkkv21fpGoS3vOqow=;
        b=JanaI9bL1l2RzrYJ3umvkHGHDgZ9KONu+XkmU95qnotc5sorVjlCnK2Vw8TjiRgxL6gDn/UB7RJJC9DrtTh0hkzED9/PlHH3YLdRQk3wHrsTmQCLYjHPYXZxID7C55w5x3Cn6B2HOPRbSLyA/KWyEG7MKn8xXgUiQTw8Nzd5QpU=;
X-UUID: 1ffef90f52b4403eafbe27e1ae4d8041-20200521
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1656432827; Thu, 21 May 2020 17:06:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 17:06:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 May 2020 17:06:29 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v15 06/11] soc: mediatek: Add subsys clock control for bus protection
Date:   Thu, 21 May 2020 17:06:19 +0800
Message-ID: <1590051985-29149-7-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
References: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHRoZSBidXMgcHJvdGVjdGlvbiBvcGVyYXRpb25zLCBzb21lIHN1YnN5cyBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQpiZWZvcmUgcmVsZWFzaW5nIHRoZSBwcm90ZWN0aW9uLCBhbmQgdmlj
ZSB2ZXJzYS4NCkJ1dCB0aG9zZSBzdWJzeXMgY2xvY2tzIGNvdWxkIG9ubHkgYmUgY29udHJvbGxl
ZCBvbmNlIGl0cyBjb3JyZXNwb25kaW5nDQpwb3dlciBkb21haW4gaXMgdHVybmVkIG9uIGZpcnN0
Lg0KSW4gdGhpcyBwYXRjaCwgd2UgYWRkIHRoZSBzdWJzeXMgY2xvY2sgY29udHJvbCBpbnRvIGl0
cyByZWxldmFudCBzdGVwcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyB8IDYy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jDQppbmRleCA1OWE1MjVhLi5lZjJjNjY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCkBAIC05Nyw2ICs5Nyw3IEBADQogI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VO
X01GR19TTk9PUF9PVVQJQklUKDIzKQ0KIA0KICNkZWZpbmUgTUFYX0NMS1MJMw0KKyNkZWZpbmUg
TUFYX1NVQlNZU19DTEtTIDEwDQogDQogI2RlZmluZSBNQVhfU1RFUFMJNA0KIA0KQEAgLTE0NSw2
ICsxNDYsOCBAQCBzdHJ1Y3QgYnVzX3Byb3Qgew0KICAqIEBzcmFtX3Bkbl9iaXRzOiBUaGUgbWFz
ayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGJpdHMuDQogICogQHNyYW1fcGRuX2Fja19iaXRzOiBU
aGUgbWFzayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGFja2VkIGJpdHMuDQogICogQGJhc2ljX2Ns
a19uYW1lOiBUaGUgYmFzaWMgY2xvY2tzIHJlcXVpcmVkIGJ5IHRoaXMgcG93ZXIgZG9tYWluLg0K
KyAqIEBzdWJzeXNfY2xrX3ByZWZpeDogVGhlIHByZWZpeCBuYW1lIG9mIHRoZSBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQorICogICAgICAgICAgICAgICAgICAgICBiZWZvcmUgcmVsZWFzaW5n
IGJ1cyBwcm90ZWN0aW9uLg0KICAqIEBjYXBzOiBUaGUgZmxhZyBmb3IgYWN0aXZlIHdha2UtdXAg
YWN0aW9uLg0KICAqIEBicF90YWJsZTogVGhlIG1hc2sgdGFibGUgZm9yIG11bHRpcGxlIHN0ZXAg
YnVzIHByb3RlY3Rpb24uDQogICovDQpAQCAtMTU1LDYgKzE1OCw3IEBAIHN0cnVjdCBzY3BfZG9t
YWluX2RhdGEgew0KIAl1MzIgc3JhbV9wZG5fYml0czsNCiAJdTMyIHNyYW1fcGRuX2Fja19iaXRz
Ow0KIAljb25zdCBjaGFyICpiYXNpY19jbGtfbmFtZVtNQVhfQ0xLU107DQorCWNvbnN0IGNoYXIg
KnN1YnN5c19jbGtfcHJlZml4Ow0KIAl1OCBjYXBzOw0KIAlzdHJ1Y3QgYnVzX3Byb3QgYnBfdGFi
bGVbTUFYX1NURVBTXTsNCiB9Ow0KQEAgLTE2NSw2ICsxNjksNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFp
biB7DQogCXN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiBnZW5wZDsNCiAJc3RydWN0IHNjcCAqc2Nw
Ow0KIAlzdHJ1Y3QgY2xrICpjbGtbTUFYX0NMS1NdOw0KKwlzdHJ1Y3QgY2xrICpzdWJzeXNfY2xr
W01BWF9TVUJTWVNfQ0xLU107DQogCWNvbnN0IHN0cnVjdCBzY3BfZG9tYWluX2RhdGEgKmRhdGE7
DQogCXN0cnVjdCByZWd1bGF0b3IgKnN1cHBseTsNCiB9Ow0KQEAgLTQyNSwxNiArNDMwLDIyIEBA
IHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29uKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2Vu
cGQpDQogCXZhbCB8PSBQV1JfUlNUX0JfQklUOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQog
DQotCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShzY3BkLCBjdGxfYWRkcik7DQorCXJldCA9IHNj
cHN5c19jbGtfZW5hYmxlKHNjcGQtPnN1YnN5c19jbGssIE1BWF9TVUJTWVNfQ0xLUyk7DQogCWlm
IChyZXQgPCAwKQ0KIAkJZ290byBlcnJfcHdyX2FjazsNCiANCisJcmV0ID0gc2Nwc3lzX3NyYW1f
ZW5hYmxlKHNjcGQsIGN0bF9hZGRyKTsNCisJaWYgKHJldCA8IDApDQorCQlnb3RvIGVycl9zcmFt
Ow0KKw0KIAlyZXQgPSBzY3BzeXNfYnVzX3Byb3RlY3RfZGlzYWJsZShzY3BkKTsNCiAJaWYgKHJl
dCA8IDApDQotCQlnb3RvIGVycl9wd3JfYWNrOw0KKwkJZ290byBlcnJfc3JhbTsNCiANCiAJcmV0
dXJuIDA7DQogDQorZXJyX3NyYW06DQorCXNjcHN5c19jbGtfZGlzYWJsZShzY3BkLT5zdWJzeXNf
Y2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIGVycl9wd3JfYWNrOg0KIAlzY3BzeXNfY2xrX2Rpc2Fi
bGUoc2NwZC0+Y2xrLCBNQVhfQ0xLUyk7DQogZXJyX2NsazoNCkBAIC00NjEsNiArNDcyLDggQEAg
c3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2Vu
cGQpDQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBvdXQ7DQogDQorCXNjcHN5c19jbGtfZGlzYWJs
ZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KKw0KIAkvKiBzdWJzeXMgcG93
ZXIgb2ZmICovDQogCXZhbCA9IHJlYWRsKGN0bF9hZGRyKTsNCiAJdmFsIHw9IFBXUl9JU09fQklU
Ow0KQEAgLTQ5OCw2ICs1MTEsMzkgQEAgc3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVj
dCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRp
YyBpbnQgaW5pdF9zdWJzeXNfY2xrcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KKwkJ
Y29uc3QgY2hhciAqcHJlZml4LCBzdHJ1Y3QgY2xrICoqY2xrKQ0KK3sNCisJc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQorCXUzMiBwcmVmaXhfbGVuLCBzdWJf
Y2xrX2NudCA9IDA7DQorCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCisJY29uc3QgY2hhciAqY2xr
X25hbWU7DQorDQorCXByZWZpeF9sZW4gPSBzdHJsZW4ocHJlZml4KTsNCisNCisJb2ZfcHJvcGVy
dHlfZm9yX2VhY2hfc3RyaW5nKG5vZGUsICJjbG9jay1uYW1lcyIsIHByb3AsIGNsa19uYW1lKSB7
DQorCQlpZiAoIXN0cm5jbXAoY2xrX25hbWUsIHByZWZpeCwgcHJlZml4X2xlbikgJiYNCisJCQkJ
KGNsa19uYW1lW3ByZWZpeF9sZW5dID09ICctJykpIHsNCisJCQlpZiAoc3ViX2Nsa19jbnQgPj0g
TUFYX1NVQlNZU19DTEtTKSB7DQorCQkJCWRldl9lcnIoJnBkZXYtPmRldiwNCisJCQkJCSJzdWJz
eXMgY2xrIG91dCBvZiByYW5nZSAlZFxuIiwNCisJCQkJCXN1Yl9jbGtfY250KTsNCisJCQkJcmV0
dXJuIC1FSU5WQUw7DQorCQkJfQ0KKw0KKwkJCWNsa1tzdWJfY2xrX2NudF0gPSBkZXZtX2Nsa19n
ZXQoJnBkZXYtPmRldiwNCisJCQkJCQljbGtfbmFtZSk7DQorDQorCQkJaWYgKElTX0VSUihjbGtb
c3ViX2Nsa19jbnRdKSkNCisJCQkJcmV0dXJuIFBUUl9FUlIoY2xrW3N1Yl9jbGtfY250XSk7DQor
DQorCQkJc3ViX2Nsa19jbnQrKzsNCisJCX0NCisJfQ0KKw0KKwlyZXR1cm4gc3ViX2Nsa19jbnQ7
DQorfQ0KKw0KIHN0YXRpYyBpbnQgaW5pdF9iYXNpY19jbGtzKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsIHN0cnVjdCBjbGsgKipjbGssDQogCQkJY29uc3QgY2hhciAqIGNvbnN0ICpuYW1l
KQ0KIHsNCkBAIC01OTYsNiArNjQyLDE4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NwICppbml0X3NjcChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkJaWYgKHJldCkNCiAJCQlyZXR1cm4gRVJS
X1BUUihyZXQpOw0KIA0KKwkJaWYgKGRhdGEtPnN1YnN5c19jbGtfcHJlZml4KSB7DQorCQkJcmV0
ID0gaW5pdF9zdWJzeXNfY2xrcyhwZGV2LA0KKwkJCQkJZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgs
DQorCQkJCQlzY3BkLT5zdWJzeXNfY2xrKTsNCisJCQlpZiAocmV0IDwgMCkgew0KKwkJCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkiJXM6IHN1YnN5cyBjbGsgdW5hdmFpbGFibGVcbiIsDQor
CQkJCQlkYXRhLT5uYW1lKTsNCisJCQkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCisJCQl9DQorCQl9
DQorDQogCQlnZW5wZC0+bmFtZSA9IGRhdGEtPm5hbWU7DQogCQlnZW5wZC0+cG93ZXJfb2ZmID0g
c2Nwc3lzX3Bvd2VyX29mZjsNCiAJCWdlbnBkLT5wb3dlcl9vbiA9IHNjcHN5c19wb3dlcl9vbjsN
Ci0tIA0KMS44LjEuMS5kaXJ0eQ0K

