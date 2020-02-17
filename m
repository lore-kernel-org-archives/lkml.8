Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29831C7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0251621744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iiGUMubU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBQDfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:35:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50592 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727842AbgBQDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:35:37 -0500
X-UUID: 11d6a31c01564af7aa61e857e8923ac2-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=osVJTfc3+O5/SgQjZzRAFBfpLdVSpvPrB0t6KZJcqcE=;
        b=iiGUMubU9tkEV4QlhsLSOkkFj4KTN5/GfyFHkEbCC9R1YrjOiFuJB82jtjH7M/6SRxpud6ccMsm7fVmTB0BrVhTHHHc+Q5ZUk5/lQ9QIdNJYDjPN7Rtxb1ILnLmesNOQPQDXmvpel5w52ZpbY02h1vlMAcP6D7/VUxyFuOBZbZg=;
X-UUID: 11d6a31c01564af7aa61e857e8923ac2-20200217
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1842744209; Mon, 17 Feb 2020 11:35:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 11:33:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 11:35:08 +0800
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
Subject: [PATCH v12 07/10] soc: mediatek: Add extra sram control
Date:   Mon, 17 Feb 2020 11:35:24 +0800
Message-ID: <1581910527-1636-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com>
References: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7270D9102BF5A08544586E1DD8B16973E11E82F97F029B8A937CBC2B781CBFE92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNvbWUgcG93ZXIgZG9tYWlucyBsaWtlIHZwdV9jb3JlIG9uIE1UODE4MyB3aG9zZSBzcmFt
IG5lZWQgdG8NCmRvIGNsb2NrIGFuZCBpbnRlcm5hbCBpc29sYXRpb24gd2hpbGUgcG93ZXIgb24v
b2ZmIHNyYW0uDQpXZSBhZGQgYSBjYXAgIk1US19TQ1BEX1NSQU1fSVNPIiB0byBqdWRnZSBpZiB3
ZSBuZWVkIHRvIGRvDQp0aGUgZXh0cmEgc3JhbSBpc29sYXRpb24gY29udHJvbCBvciBub3QuDQoN
ClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgfCAyMiArKysrKysrKysrKysrKysrKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDJhOTQ3OGYuLjk4Y2M1ZWQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTI2LDYgKzI2LDcgQEANCiANCiAjZGVmaW5l
IE1US19TQ1BEX0FDVElWRV9XQUtFVVAJCUJJVCgwKQ0KICNkZWZpbmUgTVRLX1NDUERfRldBSVRf
U1JBTQkJQklUKDEpDQorI2RlZmluZSBNVEtfU0NQRF9TUkFNX0lTTwkJQklUKDIpDQogI2RlZmlu
ZSBNVEtfU0NQRF9DQVBTKF9zY3BkLCBfeCkJKChfc2NwZCktPmRhdGEtPmNhcHMgJiAoX3gpKQ0K
IA0KICNkZWZpbmUgU1BNX1ZERV9QV1JfQ09OCQkJMHgwMjEwDQpAQCAtNTcsNiArNTgsOCBAQA0K
ICNkZWZpbmUgUFdSX09OX0JJVAkJCUJJVCgyKQ0KICNkZWZpbmUgUFdSX09OXzJORF9CSVQJCQlC
SVQoMykNCiAjZGVmaW5lIFBXUl9DTEtfRElTX0JJVAkJCUJJVCg0KQ0KKyNkZWZpbmUgUFdSX1NS
QU1fQ0xLSVNPX0JJVAkJQklUKDUpDQorI2RlZmluZSBQV1JfU1JBTV9JU09JTlRfQl9CSVQJCUJJ
VCg2KQ0KIA0KICNkZWZpbmUgUFdSX1NUQVRVU19DT05OCQkJQklUKDEpDQogI2RlZmluZSBQV1Jf
U1RBVFVTX0RJU1AJCQlCSVQoMykNCkBAIC0yMzQsNiArMjM3LDE0IEBAIHN0YXRpYyBpbnQgc2Nw
c3lzX3NyYW1fZW5hYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lkIF9faW9tZW0gKmN0
bF9hZGRyKQ0KIAkJCXJldHVybiByZXQ7DQogCX0NCiANCisJaWYgKE1US19TQ1BEX0NBUFMoc2Nw
ZCwgTVRLX1NDUERfU1JBTV9JU08pKQl7DQorCQl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBQV1Jf
U1JBTV9JU09JTlRfQl9CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl1ZGVsYXko
MSk7DQorCQl2YWwgJj0gflBXUl9TUkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxf
YWRkcik7DQorCX0NCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTI0Myw4ICsyNTQsMTUgQEAg
c3RhdGljIGludCBzY3BzeXNfc3JhbV9kaXNhYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2
b2lkIF9faW9tZW0gKmN0bF9hZGRyKQ0KIAl1MzIgcGRuX2FjayA9IHNjcGQtPmRhdGEtPnNyYW1f
cGRuX2Fja19iaXRzOw0KIAlpbnQgdG1wOw0KIA0KLQl2YWwgPSByZWFkbChjdGxfYWRkcik7DQot
CXZhbCB8PSBzY3BkLT5kYXRhLT5zcmFtX3Bkbl9iaXRzOw0KKwlpZiAoTVRLX1NDUERfQ0FQUyhz
Y3BkLCBNVEtfU0NQRF9TUkFNX0lTTykpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBX
Ul9TUkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl2YWwgJj0g
flBXUl9TUkFNX0lTT0lOVF9CX0JJVDsNCisJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsNCisJCXVk
ZWxheSgxKTsNCisJfQ0KKw0KKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRhLT5z
cmFtX3Bkbl9iaXRzOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQogCS8qIEVpdGhlciB3
YWl0IHVudGlsIFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQotLSANCjEuOC4xLjEuZGlydHkN
Cg==

