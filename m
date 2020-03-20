Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9BC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228092051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="npDHTsLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCTHdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:33:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23390 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbgCTHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:41 -0400
X-UUID: ec5da989951e4654b6ce6b5cc8626d7d-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9X5uWL1YgmrDZcTKHn0A/YVVUbEE9hPvqMSvyGyBAwc=;
        b=npDHTsLp09QKtFP8h7dJT5qeUz2rCZrCCV39Ft2OBQTp48hyXaCnSdwVl1JnRF1yyl47C0M4TFjK5B8qHXWIYdkIktNK7ebgEKxwOVnCt/7QnoWlHx+elgDne5A7mUojOmSYEdsmfIyZCECK63RbylVk/F7qazE7KSGdMomOMmM=;
X-UUID: ec5da989951e4654b6ce6b5cc8626d7d-20200320
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1222437964; Fri, 20 Mar 2020 15:32:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:31:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:19 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v13 06/11] soc: mediatek: Add subsys clock control for bus protection
Date:   Fri, 20 Mar 2020 15:32:15 +0800
Message-ID: <1584689540-5227-7-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHRoZSBidXMgcHJvdGVjdGlvbiBvcGVyYXRpb25zLCBzb21lIHN1YnN5cyBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQpiZWZvcmUgcmVsZWFzaW5nIHRoZSBwcm90ZWN0aW9uLCBhbmQgdmlz
ZSB2ZXJzYS4NCkJ1dCB0aG9zZSBzdWJzeXMgY2xvY2tzIGNvdWxkIG9ubHkgYmUgY29udHJvbGxl
ZCBvbmNlIGl0cyBjb3JyZXNwb25kaW5nDQpwb3dlciBkb21haW4gaXMgdHVybmVkIG9uIGZpcnN0
Lg0KSW4gdGhpcyBwYXRjaCwgd2UgYWRkIHRoZSBzdWJzeXMgY2xvY2sgY29udHJvbCBpbnRvIGl0
cyByZWxhdmVudCBzdGVwcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyB8IDcx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jDQppbmRleCBhNGZiMGIyMy4uMmE5NDc4ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jDQpAQCAtODAsNiArODAsNyBAQA0KICNkZWZpbmUgUFdSX1NUQVRVU19XQgkJCUJJVCgy
NykJLyogTVQ3NjIyICovDQogDQogI2RlZmluZSBNQVhfQ0xLUwkzDQorI2RlZmluZSBNQVhfU1VC
U1lTX0NMS1MgMTANCiANCiAvKioNCiAgKiBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIC0gc2NwIGRv
bWFpbiBkYXRhIGZvciBwb3dlciBvbi9vZmYgZmxvdw0KQEAgLTg5LDYgKzkwLDggQEANCiAgKiBA
c3JhbV9wZG5fYml0czogVGhlIG1hc2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBiaXRzLg0KICAq
IEBzcmFtX3Bkbl9hY2tfYml0czogVGhlIG1hc2sgZm9yIHNyYW0gcG93ZXIgY29udHJvbCBhY2tl
ZCBiaXRzLg0KICAqIEBiYXNpY19jbGtfbmFtZTogVGhlIGJhc2ljIGNsb2NrcyByZXF1aXJlZCBi
eSB0aGlzIHBvd2VyIGRvbWFpbi4NCisgKiBAc3Vic3lzX2Nsa19wcmVmaXg6IFRoZSBwcmVmaXgg
bmFtZSBvZiB0aGUgY2xvY2tzIG5lZWQgdG8gYmUgZW5hYmxlZA0KKyAqICAgICAgICAgICAgICAg
ICAgICAgYmVmb3JlIHJlbGVhc2luZyBidXMgcHJvdGVjdGlvbi4NCiAgKiBAY2FwczogVGhlIGZs
YWcgZm9yIGFjdGl2ZSB3YWtlLXVwIGFjdGlvbi4NCiAgKiBAYnBfdGFibGU6IFRoZSBtYXNrIHRh
YmxlIGZvciBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uLg0KICAqLw0KQEAgLTk5LDYgKzEw
Miw3IEBAIHN0cnVjdCBzY3BfZG9tYWluX2RhdGEgew0KIAl1MzIgc3JhbV9wZG5fYml0czsNCiAJ
dTMyIHNyYW1fcGRuX2Fja19iaXRzOw0KIAljb25zdCBjaGFyICpiYXNpY19jbGtfbmFtZVtNQVhf
Q0xLU107DQorCWNvbnN0IGNoYXIgKnN1YnN5c19jbGtfcHJlZml4Ow0KIAl1OCBjYXBzOw0KIAlz
dHJ1Y3QgYnVzX3Byb3QgYnBfdGFibGVbTUFYX1NURVBTXTsNCiB9Ow0KQEAgLTEwOSw2ICsxMTMs
NyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbiB7DQogCXN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiBnZW5w
ZDsNCiAJc3RydWN0IHNjcCAqc2NwOw0KIAlzdHJ1Y3QgY2xrICpjbGtbTUFYX0NMS1NdOw0KKwlz
dHJ1Y3QgY2xrICpzdWJzeXNfY2xrW01BWF9TVUJTWVNfQ0xLU107DQogCWNvbnN0IHN0cnVjdCBz
Y3BfZG9tYWluX2RhdGEgKmRhdGE7DQogCXN0cnVjdCByZWd1bGF0b3IgKnN1cHBseTsNCiB9Ow0K
QEAgLTM4NCwxNiArMzg5LDIyIEBAIHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29uKHN0cnVjdCBn
ZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCXZhbCB8PSBQV1JfUlNUX0JfQklUOw0KIAl3cml0
ZWwodmFsLCBjdGxfYWRkcik7DQogDQotCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShzY3BkLCBj
dGxfYWRkcik7DQorCXJldCA9IHNjcHN5c19jbGtfZW5hYmxlKHNjcGQtPnN1YnN5c19jbGssIE1B
WF9TVUJTWVNfQ0xLUyk7DQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBlcnJfcHdyX2FjazsNCiAN
CisJcmV0ID0gc2Nwc3lzX3NyYW1fZW5hYmxlKHNjcGQsIGN0bF9hZGRyKTsNCisJaWYgKHJldCA8
IDApDQorCQlnb3RvIGVycl9zcmFtOw0KKw0KIAlyZXQgPSBzY3BzeXNfYnVzX3Byb3RlY3RfZGlz
YWJsZShzY3BkKTsNCiAJaWYgKHJldCA8IDApDQotCQlnb3RvIGVycl9wd3JfYWNrOw0KKwkJZ290
byBlcnJfc3JhbTsNCiANCiAJcmV0dXJuIDA7DQogDQorZXJyX3NyYW06DQorCXNjcHN5c19jbGtf
ZGlzYWJsZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIGVycl9wd3JfYWNr
Og0KIAlzY3BzeXNfY2xrX2Rpc2FibGUoc2NwZC0+Y2xrLCBNQVhfQ0xLUyk7DQogZXJyX2NsazoN
CkBAIC00MjAsNiArNDMxLDggQEAgc3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVjdCBn
ZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBvdXQ7DQog
DQorCXNjcHN5c19jbGtfZGlzYWJsZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1Mp
Ow0KKw0KIAkvKiBzdWJzeXMgcG93ZXIgb2ZmICovDQogCXZhbCA9IHJlYWRsKGN0bF9hZGRyKTsN
CiAJdmFsIHw9IFBXUl9JU09fQklUOw0KQEAgLTQ1Nyw2ICs0NzAsNDggQEAgc3RhdGljIGludCBz
Y3BzeXNfcG93ZXJfb2ZmKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCXJldHVy
biByZXQ7DQogfQ0KIA0KK3N0YXRpYyBpbnQgaW5pdF9zdWJzeXNfY2xrcyhzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2LA0KKwkJY29uc3QgY2hhciAqcHJlZml4LCBzdHJ1Y3QgY2xrICoqY2xr
KQ0KK3sNCisJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQor
CXUzMiBwcmVmaXhfbGVuLCBzdWJfY2xrX2NudCA9IDA7DQorCXN0cnVjdCBwcm9wZXJ0eSAqcHJv
cDsNCisJY29uc3QgY2hhciAqY2xrX25hbWU7DQorDQorCWlmICghbm9kZSkgew0KKwkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgc2Nwc3lzIG5vZGU6ICVsZFxuIiwNCisJCQlQVFJf
RVJSKG5vZGUpKTsNCisJCXJldHVybiBQVFJfRVJSKG5vZGUpOw0KKwl9DQorDQorCXByZWZpeF9s
ZW4gPSBzdHJsZW4ocHJlZml4KTsNCisNCisJb2ZfcHJvcGVydHlfZm9yX2VhY2hfc3RyaW5nKG5v
ZGUsICJjbG9jay1uYW1lcyIsIHByb3AsIGNsa19uYW1lKSB7DQorCQlpZiAoIXN0cm5jbXAoY2xr
X25hbWUsIHByZWZpeCwgcHJlZml4X2xlbikgJiYNCisJCQkJKGNsa19uYW1lW3ByZWZpeF9sZW5d
ID09ICctJykpIHsNCisJCQlpZiAoc3ViX2Nsa19jbnQgPj0gTUFYX1NVQlNZU19DTEtTKSB7DQor
CQkJCWRldl9lcnIoJnBkZXYtPmRldiwNCisJCQkJCSJzdWJzeXMgY2xrIG91dCBvZiByYW5nZSAl
ZFxuIiwNCisJCQkJCXN1Yl9jbGtfY250KTsNCisJCQkJcmV0dXJuIC1FSU5WQUw7DQorCQkJfQ0K
Kw0KKwkJCWNsa1tzdWJfY2xrX2NudF0gPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwNCisJCQkJ
CQljbGtfbmFtZSk7DQorDQorCQkJaWYgKElTX0VSUihjbGtbc3ViX2Nsa19jbnRdKSkgew0KKwkJ
CQlkZXZfZXJyKCZwZGV2LT5kZXYsDQorCQkJCQkiU3Vic3lzIGNsayBnZXQgZmFpbCAlbGRcbiIs
DQorCQkJCQlQVFJfRVJSKGNsa1tzdWJfY2xrX2NudF0pKTsNCisJCQkJcmV0dXJuIFBUUl9FUlIo
Y2xrW3N1Yl9jbGtfY250XSk7DQorCQkJfQ0KKwkJCXN1Yl9jbGtfY250Kys7DQorCQl9DQorCX0N
CisNCisJcmV0dXJuIHN1Yl9jbGtfY250Ow0KK30NCisNCiBzdGF0aWMgaW50IGluaXRfYmFzaWNf
Y2xrcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCBzdHJ1Y3QgY2xrICoqY2xrLA0KIAkJ
CWNvbnN0IGNoYXIgKiBjb25zdCAqbmFtZSkNCiB7DQpAQCAtNTU5LDYgKzYxNCwxOCBAQCBzdGF0
aWMgc3RydWN0IHNjcCAqaW5pdF9zY3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJ
CWlmIChyZXQpDQogCQkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCiANCisJCWlmIChkYXRhLT5zdWJz
eXNfY2xrX3ByZWZpeCkgew0KKwkJCXJldCA9IGluaXRfc3Vic3lzX2Nsa3MocGRldiwNCisJCQkJ
CWRhdGEtPnN1YnN5c19jbGtfcHJlZml4LA0KKwkJCQkJc2NwZC0+c3Vic3lzX2Nsayk7DQorCQkJ
aWYgKHJldCA8IDApIHsNCisJCQkJZGV2X2VycigmcGRldi0+ZGV2LA0KKwkJCQkJIiVzOiBzdWJz
eXMgY2xrIHVuYXZhaWxhYmxlXG4iLA0KKwkJCQkJZGF0YS0+bmFtZSk7DQorCQkJCXJldHVybiBF
UlJfUFRSKHJldCk7DQorCQkJfQ0KKwkJfQ0KKw0KIAkJZ2VucGQtPm5hbWUgPSBkYXRhLT5uYW1l
Ow0KIAkJZ2VucGQtPnBvd2VyX29mZiA9IHNjcHN5c19wb3dlcl9vZmY7DQogCQlnZW5wZC0+cG93
ZXJfb24gPSBzY3BzeXNfcG93ZXJfb247DQotLSANCjEuOC4xLjEuZGlydHkNCg==

