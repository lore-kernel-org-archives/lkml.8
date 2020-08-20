Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866CD207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SEQhdBXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgHTLfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:35:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54303 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730466AbgHTLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:52 -0400
X-UUID: bc5c02753e5d461896acb71e9c51863d-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nqIW9nkZa6YaLLhjqZ7kmnfueTv+c8ATeMbx5VhqlUE=;
        b=SEQhdBXIF8ROjXFdVnu+kla5OJm65Tvr34j0+dGje5LjpmP3MIYk5mceSPZ0TcetG4lcctW1zNWOlxwW09XUuSBLZ7kKzFlS56UBum4kG7KiyadFNJT5tVv4dXOGo4Ve8u1zaUSIut1hJ3KlXxTa/cF1xhFDpSISVOBPUKmk2iw=;
X-UUID: bc5c02753e5d461896acb71e9c51863d-20200820
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1728909835; Thu, 20 Aug 2020 19:32:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:23 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 04/11] usb: gadget: bdc: fix warning of embedded function name
Date:   Thu, 20 Aug 2020 19:30:39 +0800
Message-ID: <1597923046-12535-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6383ADABD7F212A8A9044CDB2A9F22B99617E7E34FD6E99648EA7A911117483D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlICciJXMuLi4iLCBfX2Z1bmNfXycgdG8gcmVwbGFjZSBlbWJlZGRlZCBmdW5jdGlvbiBuYW1l
DQoNCkNjOiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjI6
IGFkZCBDYyBGbG9yaWFuDQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJn
LmMgfCAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgIHwgNiArKyst
LS0NCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuYw0KaW5kZXggN2JhNzQ0OC4uOWMwM2UxMyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuYw0KKysrIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5jDQpAQCAtNjgsNyArNjgsNyBAQCB2
b2lkIGJkY19kYmdfc3JyKHN0cnVjdCBiZGMgKmJkYywgdTMyIHNycl9udW0pDQogDQogCXNyID0g
YmRjLT5zcnIuc3JfYmRzOw0KIAlhZGRyID0gYmRjLT5zcnIuZG1hX2FkZHI7DQotCWRldl92ZGJn
KGJkYy0+ZGV2LCAiYmRjX2RiZ19zcnIgc3I6JXAgZHFwX2luZGV4OiVkXG4iLA0KKwlkZXZfdmRi
ZyhiZGMtPmRldiwgIiVzIHNyOiVwIGRxcF9pbmRleDolZFxuIiwgX19mdW5jX18sDQogCQkJCQkJ
c3IsIGJkYy0+c3JyLmRxcF9pbmRleCk7DQogCWZvciAoaSA9IDA7IGkgPCBOVU1fU1JfRU5UUklF
UzsgaSsrKSB7DQogCQlzciA9ICZiZGMtPnNyci5zcl9iZHNbaV07DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZXAuYw0KaW5kZXggNzY0NjNkZS4uNDRmM2ExMiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfZXAuYw0KQEAgLTc1Niw3ICs3NTYsNyBAQCBzdGF0aWMgaW50IGVwX2RlcXVl
dWUoc3RydWN0IGJkY19lcCAqZXAsIHN0cnVjdCBiZGNfcmVxICpyZXEpDQogDQogCWRldl9kYmco
YmRjLT5kZXYsICIlcyBlcDolcyBzdGFydDolZCBlbmQ6JWRcbiIsDQogCQkJCQlfX2Z1bmNfXywg
ZXAtPm5hbWUsIHN0YXJ0X2JkaSwgZW5kX2JkaSk7DQotCWRldl9kYmcoYmRjLT5kZXYsICJlcF9k
ZXF1ZXVlIGVwPSVwIGVwLT5kZXNjPSVwXG4iLA0KKwlkZXZfZGJnKGJkYy0+ZGV2LCAiJXMgZXA9
JXAgZXAtPmRlc2M9JXBcbiIsIF9fZnVuY19fLA0KIAkJCQkJCWVwLCAodm9pZCAqKWVwLT51c2Jf
ZXAuZGVzYyk7DQogCS8qIGlmIHN0aWxsIGNvbm5lY3RlZCwgc3RvcCB0aGUgZXAgdG8gc2VlIHdo
ZXJlIHRoZSBIVyBpcyA/ICovDQogCWlmICghKGJkY19yZWFkbChiZGMtPnJlZ3MsIEJEQ19VU1BD
KSAmIEJEQ19QU1RfTUFTSykpIHsNCkBAIC0xODU4LDEyICsxODU4LDEyIEBAIHN0YXRpYyBpbnQg
YmRjX2dhZGdldF9lcF9lbmFibGUoc3RydWN0IHVzYl9lcCAqX2VwLA0KIAlpbnQgcmV0Ow0KIA0K
IAlpZiAoIV9lcCB8fCAhZGVzYyB8fCBkZXNjLT5iRGVzY3JpcHRvclR5cGUgIT0gVVNCX0RUX0VO
RFBPSU5UKSB7DQotCQlwcl9kZWJ1ZygiYmRjX2dhZGdldF9lcF9lbmFibGUgaW52YWxpZCBwYXJh
bWV0ZXJzXG4iKTsNCisJCXByX2RlYnVnKCIlcyBpbnZhbGlkIHBhcmFtZXRlcnNcbiIsIF9fZnVu
Y19fKTsNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQogCWlmICghZGVzYy0+d01heFBhY2tl
dFNpemUpIHsNCi0JCXByX2RlYnVnKCJiZGNfZ2FkZ2V0X2VwX2VuYWJsZSBtaXNzaW5nIHdNYXhQ
YWNrZXRTaXplXG4iKTsNCisJCXByX2RlYnVnKCIlcyBtaXNzaW5nIHdNYXhQYWNrZXRTaXplXG4i
LCBfX2Z1bmNfXyk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KIA0KLS0gDQoxLjkuMQ0K

