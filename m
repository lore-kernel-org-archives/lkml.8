Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C892070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nBxJcRD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGIILl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:11:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65394 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726215AbgGIILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:11:40 -0400
X-UUID: 6e9b63f79d02473db4515b1cba2e297c-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=EmxpDFVko6vGSPtolSl68cxmu0wfDYMew3MmoQC0gGU=;
        b=nBxJcRD1CP+djsbHQpGpme/u8nI9OcJe4moXRREEiW1gud67tvRXHWdQXeoEbiqT0ryin7KMUuwazGeMxQ8DoOcgtWfUIvU5d2QtMiZYc4qAv68J7N9P5fOXoHk1W23J35yR2LDUA5aX6r+pr7nvq1zRui/VGz2AtM66INqwMz4=;
X-UUID: 6e9b63f79d02473db4515b1cba2e297c-20200709
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1010882677; Thu, 09 Jul 2020 16:11:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Jul 2020 16:11:30 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 16:11:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only core
Date:   Thu, 9 Jul 2020 16:10:50 +0800
Message-ID: <1594282250-25544-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E13421386F9A3D99A6F76BE1A8A8E25F83593278EF8CA57E9EC0A00D10D06AE22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1heGltdW1fc3BlZWQgd2lsbCBiZSBVU0JfU1BFRURfU1VQRVJfUExVUywgYnV0IHRoZQ0K
bWF4aW11bV9zcGVlZCBjaGVjayBmb3IgdXNiMi4wLW9ubHkgY29yZSBkb2Vzbid0IGNvbnNpZGVy
IGl0LA0Kc28gZml4IGl0LCBhbmQgbW92ZSB0aGUgY2tlY2sgaW50byBkd2MzX2NoZWNrX3BhcmFt
cygpLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCk5vdGU6DQoNCldoZW4gSSBsb29rIGF0IHRoZSBjb2RlLCBmaW5kIHRoYXQg
dGhpcyBtYXkgYmUgYSBwcm9ibGVtLCBidXQgbm8NCnBsYXRmb3JtIHRvIHRlc3QgaXQuDQotLS0N
CiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE0ICsrKysrKystLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCmluZGV4IDI1
YzY4NmE3Li5mZmQ1YWIzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQpAQCAtOTMwLDEzICs5MzAsNiBAQCBzdGF0aWMg
aW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQogCSAqLw0KIAlkd2MzX3dyaXRl
bChkd2MtPnJlZ3MsIERXQzNfR1VJRCwgTElOVVhfVkVSU0lPTl9DT0RFKTsNCiANCi0JLyogSGFu
ZGxlIFVTQjIuMC1vbmx5IGNvcmUgY29uZmlndXJhdGlvbiAqLw0KLQlpZiAoRFdDM19HSFdQQVJB
TVMzX1NTUEhZX0lGQyhkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMykgPT0NCi0JCQlEV0MzX0dIV1BB
UkFNUzNfU1NQSFlfSUZDX0RJUykgew0KLQkJaWYgKGR3Yy0+bWF4aW11bV9zcGVlZCA9PSBVU0Jf
U1BFRURfU1VQRVIpDQotCQkJZHdjLT5tYXhpbXVtX3NwZWVkID0gVVNCX1NQRUVEX0hJR0g7DQot
CX0NCi0NCiAJcmV0ID0gZHdjM19waHlfc2V0dXAoZHdjKTsNCiAJaWYgKHJldCkNCiAJCWdvdG8g
ZXJyMDsNCkBAIC0xNDI2LDYgKzE0MTksMTMgQEAgc3RhdGljIHZvaWQgZHdjM19jaGVja19wYXJh
bXMoc3RydWN0IGR3YzMgKmR3YykNCiANCiAJCWJyZWFrOw0KIAl9DQorDQorCS8qIEhhbmRsZSBV
U0IyLjAtb25seSBjb3JlIGNvbmZpZ3VyYXRpb24gKi8NCisJaWYgKERXQzNfR0hXUEFSQU1TM19T
U1BIWV9JRkMoZHdjLT5od3BhcmFtcy5od3BhcmFtczMpID09DQorCQkJRFdDM19HSFdQQVJBTVMz
X1NTUEhZX0lGQ19ESVMpIHsNCisJCWlmIChkd2MtPm1heGltdW1fc3BlZWQgPiBVU0JfU1BFRURf
SElHSCkNCisJCQlkd2MtPm1heGltdW1fc3BlZWQgPSBVU0JfU1BFRURfSElHSDsNCisJfQ0KIH0N
CiANCiBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Ci0tIA0KMS45LjENCg==

