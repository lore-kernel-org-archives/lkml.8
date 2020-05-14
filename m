Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1522920575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W0Bs7A4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgENEBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:01:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55251 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgENEB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:01:29 -0400
X-UUID: 2d07cbdbd61b41e19992e24d852812ac-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Vq25CpGWDu4hIaBmnMbm4KOdW3U78xl9MWNuHHP8T8w=;
        b=W0Bs7A4Jn2c2RwT1+rEF3uzTWZ5LFHb0PuxVMa6PhglatDohufz/Hhi9W7q/kG0AiwVvZc8lIyN1FXVXTWJO/3pHf8/Cqp/cEwiId1OT9Pzz9d5VW+fQTQLgtX4PL50gB/Myhh+p/f+E1l1nsC7D91JatSF72695Izozx0KJm3Q=;
X-UUID: 2d07cbdbd61b41e19992e24d852812ac-20200514
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1918152551; Thu, 14 May 2020 12:01:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 May 2020 12:01:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 12:01:19 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Min Guo <min.guo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH] usb: musb: mediatek: add reset FADDR to zero in reset interrupt handle
Date:   Thu, 14 May 2020 12:01:12 +0800
Message-ID: <1589428872-29282-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7786936E7E97A400A420A3B5D83AA16F375A89018EEAA40ED48FEFC21FA816762000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiByZWNlaXZpbmcgcmVzZXQgaW50ZXJydXB0LCBGQUREUiBuZWVkIHRvIGJlIHJlc2V0IHRv
IHplcm8gaW4NCnBlcmlwaGVhcmwgbW9kZS4gT3RoZXJ3aXNlIGVwMCBjYW5ub3QgZG8gZW51bWVy
YXRpb24gd2hlbiByZS1wbHVnaW5nIFVTQg0KY2FibGUuDQoNClNpZ25lZC1vZmYtYnk6IE1hY3Bh
dWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9tdXNi
L21lZGlhdGVrLmMgfCAgICA2ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL211c2IvbWVkaWF0ZWsuYyBiL2RyaXZlcnMv
dXNiL211c2IvbWVkaWF0ZWsuYw0KaW5kZXggNjE5NmIwZS4uZWViZWFkZCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdXNiL211c2IvbWVkaWF0ZWsuYw0KKysrIGIvZHJpdmVycy91c2IvbXVzYi9tZWRp
YXRlay5jDQpAQCAtMjA4LDYgKzIwOCwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZ2VuZXJpY19p
bnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX19oY2kpDQogCW11c2ItPmludF9yeCA9IG11c2JfY2xl
YXJ3KG11c2ItPm1yZWdzLCBNVVNCX0lOVFJSWCk7DQogCW11c2ItPmludF90eCA9IG11c2JfY2xl
YXJ3KG11c2ItPm1yZWdzLCBNVVNCX0lOVFJUWCk7DQogDQorCWlmICgobXVzYi0+aW50X3VzYiAm
IE1VU0JfSU5UUl9SRVNFVCkgJiYgIWlzX2hvc3RfYWN0aXZlKG11c2IpKSB7DQorCQkvKiBlcDAg
RkFERFIgbXVzdCBiZSAwIHdoZW4gKHJlKWVudGVyaW5nIHBlcmlwaGVyYWwgbW9kZSAqLw0KKwkJ
bXVzYl9lcF9zZWxlY3QobXVzYi0+bXJlZ3MsIDApOw0KKwkJbXVzYl93cml0ZWIobXVzYi0+bXJl
Z3MsIE1VU0JfRkFERFIsIDApOw0KKwl9DQorDQogCWlmIChtdXNiLT5pbnRfdXNiIHx8IG11c2It
PmludF90eCB8fCBtdXNiLT5pbnRfcngpDQogCQlyZXR2YWwgPSBtdXNiX2ludGVycnVwdChtdXNi
KTsNCiANCi0tIA0KMS43LjkuNQ0K

