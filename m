Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50282C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6920728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="izdTNWFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAQHmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:42:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42877 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729159AbgAQHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:42:13 -0500
X-UUID: 91eeb4d187c7412cb5fc19a8ebfeeb86-20200117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XlVHRJUiQa0Jm/lTprpguXiXjS3b7Bht7uRo2za199k=;
        b=izdTNWFqdjMNAZtC4TMrjRJqR7uydOUzTwPTMWwgbMNFRRdhKsruhxQ8XqwdwQ4H8QCQqE5VeuCoCE3HFk+Ph51sqchHrDhIXo1LRH24121x0aoe/J6YDu29INUT94yIJAtVCrgS7TCTgU4DcYzk5IvilT4rA7hFFswPLfzAvHA=;
X-UUID: 91eeb4d187c7412cb5fc19a8ebfeeb86-20200117
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 17940661; Fri, 17 Jan 2020 15:42:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 17 Jan 2020 15:41:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 17 Jan 2020 15:41:10 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Subject: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq() for shared_hcd
Date:   Fri, 17 Jan 2020 15:41:50 +0800
Message-ID: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIHRvIE5VTEwgcG9pbnRlciBmaXg6IGh0dHBzOi8vdGlueXVybC5jb20vdXFmdDVy
YQ0KeGhjaTogRml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aXRoIHhoY2lfaXJxKCkgZm9y
IHNoYXJlZF9oY2QNClRoZSBzaW1pbGFyIGlzc3VlIGhhcyBhbHNvIGJlZW4gZm91bmQgaW4gUUMg
YWN0aXZpdGllcyBpbiBNZWRpYXRlay4NCg0KSGVyZSBxdW90ZSB0aGUgZGVzY3JpcHRpb24gZnJv
bSB0aGUgcmVmZXJlbmNlZCBwYXRjaCBhcyBmb2xsb3dzLg0KIkNvbW1pdCAoImYwNjgwOTA0MjZl
YSB4aGNpOiBGaXggbGVha2luZyBVU0IzIHNoYXJlZF9oY2QNCmF0IHhoY2kgcmVtb3ZhbCIpIHNl
dHMgeGhjaV9zaGFyZWRfaGNkIHRvIE5VTEwgd2l0aG91dA0Kc3RvcHBpbmcgeGhjaSBob3N0LiBU
aGlzIHJlc3VsdHMgaW50byBhIHJhY2UgY29uZGl0aW9uDQp3aGVyZSBzaGFyZWRfaGNkIChzdXBl
ciBzcGVlZCByb290aHViKSByZWxhdGVkIGludGVycnVwdHMNCmFyZSBiZWluZyBoYW5kbGVkIHdp
dGggeGhjaV9pcnEgaGFwcGVucyB3aGVuIHRoZQ0KeGhjaV9wbGF0X3JlbW92ZSBpcyBjYWxsZWQg
YW5kIHNoYXJlZF9oY2QgaXMgc2V0IHRvIE5VTEwuDQpGaXggdGhpcyBieSBzZXR0aW5nIHRoZSBz
aGFyZWRfaGNkIHRvIE5VTEwgb25seSBhZnRlciB0aGUNCmNvbnRyb2xsZXIgaXMgaGFsdGVkIGFu
ZCBubyBpbnRlcnJ1cHRzIGFyZSBnZW5lcmF0ZWQuIg0KDQpTaWduZWQtb2ZmLWJ5OiBTcmloYXJz
aGEgQWxsZW5raSA8c2FsbGVua2lAY29kZWF1cm9yYS5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBNYWNw
YXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvaG9z
dC94aGNpLW10ay5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQppbmRleCBiMThhNmJhZWYyMDQuLmMyMjdjNjdm
NWRjNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KKysrIGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLW10ay5jDQpAQCAtNTkzLDExICs1OTMsMTEgQEAgc3RhdGljIGlu
dCB4aGNpX210a19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KIAlzdHJ1Y3Qg
dXNiX2hjZCAgKnNoYXJlZF9oY2QgPSB4aGNpLT5zaGFyZWRfaGNkOw0KIA0KIAl1c2JfcmVtb3Zl
X2hjZChzaGFyZWRfaGNkKTsNCi0JeGhjaS0+c2hhcmVkX2hjZCA9IE5VTEw7DQogCWRldmljZV9p
bml0X3dha2V1cCgmZGV2LT5kZXYsIGZhbHNlKTsNCiANCiAJdXNiX3JlbW92ZV9oY2QoaGNkKTsN
CiAJdXNiX3B1dF9oY2Qoc2hhcmVkX2hjZCk7DQorCXhoY2ktPnNoYXJlZF9oY2QgPSBOVUxMOw0K
IAl1c2JfcHV0X2hjZChoY2QpOw0KIAl4aGNpX210a19zY2hfZXhpdChtdGspOw0KIAl4aGNpX210
a19jbGtzX2Rpc2FibGUobXRrKTsNCi0tIA0KMi4xOC4wDQo=

