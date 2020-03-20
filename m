Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29762C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC2F20776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gm1jrdTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCTHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:32:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22824 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgCTHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:41 -0400
X-UUID: 9972461f735c48cd8d0f560ef66fd953-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+x/RaKoCkfCwpMICuvDH7GptQeRs7CoQEiKEdnihIqI=;
        b=Gm1jrdTtUsoDWDLyhccTwFUUO3jZSp+iWtT+e8B1RWKWrUy5YmhbZ9xTqsh9zkRvF0DzFGBe8MZ43Km6fgYhJcfm/UjhrdW2zb+j11l0M/ow+WRmJUctjehTf7mwdX2+gHS/aZMWh6CEuRtz9DPsFbQV53Dw5RTHxx8SYUa6c9w=;
X-UUID: 9972461f735c48cd8d0f560ef66fd953-20200320
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 167501818; Fri, 20 Mar 2020 15:32:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:29:30 +0800
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
Subject: [PATCH v13 07/11] soc: mediatek: Add extra sram control
Date:   Fri, 20 Mar 2020 15:32:16 +0800
Message-ID: <1584689540-5227-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 785C2CB3905C9FE7BC01CA5227E1AFA33C49322C18505C559705BE1FC2B71E742000:8
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
ClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQotLS0NCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDJhOTQ3OGYuLjk4Y2M1ZWQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTI2LDYgKzI2LDcgQEANCiANCiAjZGVmaW5lIE1U
S19TQ1BEX0FDVElWRV9XQUtFVVAJCUJJVCgwKQ0KICNkZWZpbmUgTVRLX1NDUERfRldBSVRfU1JB
TQkJQklUKDEpDQorI2RlZmluZSBNVEtfU0NQRF9TUkFNX0lTTwkJQklUKDIpDQogI2RlZmluZSBN
VEtfU0NQRF9DQVBTKF9zY3BkLCBfeCkJKChfc2NwZCktPmRhdGEtPmNhcHMgJiAoX3gpKQ0KIA0K
ICNkZWZpbmUgU1BNX1ZERV9QV1JfQ09OCQkJMHgwMjEwDQpAQCAtNTcsNiArNTgsOCBAQA0KICNk
ZWZpbmUgUFdSX09OX0JJVAkJCUJJVCgyKQ0KICNkZWZpbmUgUFdSX09OXzJORF9CSVQJCQlCSVQo
MykNCiAjZGVmaW5lIFBXUl9DTEtfRElTX0JJVAkJCUJJVCg0KQ0KKyNkZWZpbmUgUFdSX1NSQU1f
Q0xLSVNPX0JJVAkJQklUKDUpDQorI2RlZmluZSBQV1JfU1JBTV9JU09JTlRfQl9CSVQJCUJJVCg2
KQ0KIA0KICNkZWZpbmUgUFdSX1NUQVRVU19DT05OCQkJQklUKDEpDQogI2RlZmluZSBQV1JfU1RB
VFVTX0RJU1AJCQlCSVQoMykNCkBAIC0yMzQsNiArMjM3LDE0IEBAIHN0YXRpYyBpbnQgc2Nwc3lz
X3NyYW1fZW5hYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lkIF9faW9tZW0gKmN0bF9h
ZGRyKQ0KIAkJCXJldHVybiByZXQ7DQogCX0NCiANCisJaWYgKE1US19TQ1BEX0NBUFMoc2NwZCwg
TVRLX1NDUERfU1JBTV9JU08pKQl7DQorCQl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBQV1JfU1JB
TV9JU09JTlRfQl9CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl1ZGVsYXkoMSk7
DQorCQl2YWwgJj0gflBXUl9TUkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRk
cik7DQorCX0NCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTI0Myw4ICsyNTQsMTUgQEAgc3Rh
dGljIGludCBzY3BzeXNfc3JhbV9kaXNhYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lk
IF9faW9tZW0gKmN0bF9hZGRyKQ0KIAl1MzIgcGRuX2FjayA9IHNjcGQtPmRhdGEtPnNyYW1fcGRu
X2Fja19iaXRzOw0KIAlpbnQgdG1wOw0KIA0KLQl2YWwgPSByZWFkbChjdGxfYWRkcik7DQotCXZh
bCB8PSBzY3BkLT5kYXRhLT5zcmFtX3Bkbl9iaXRzOw0KKwlpZiAoTVRLX1NDUERfQ0FQUyhzY3Bk
LCBNVEtfU0NQRF9TUkFNX0lTTykpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9T
UkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl2YWwgJj0gflBX
Ul9TUkFNX0lTT0lOVF9CX0JJVDsNCisJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsNCisJCXVkZWxh
eSgxKTsNCisJfQ0KKw0KKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRhLT5zcmFt
X3Bkbl9iaXRzOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQogCS8qIEVpdGhlciB3YWl0
IHVudGlsIFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQotLSANCjEuOC4xLjEuZGlydHkNCg==

