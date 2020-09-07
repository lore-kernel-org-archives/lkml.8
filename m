Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C54C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FF32137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dGBv4ArK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgIGMIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:08:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729161AbgIGMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:01:17 -0400
X-UUID: c7ef724de52f413bb9faba10b0255837-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JUcVsy413AmOMLtnb12ZVdnEP4NP18Co8XTq92q97QY=;
        b=dGBv4ArKhXRVrE38GMJPo9IAdz7QLP7ZQLzmu2urK9voglcAiup/3P+4Kc6fHzIVvJDL5Bj3k7V4SKIITDizMwOA9rdztuiovQEnf21qx5hL9ZE08L9VqbIozqhyGQPSim8qqzIGVfyYRu3WEhBYywZ+KznA7Hue1sSeHOPFhxo=;
X-UUID: c7ef724de52f413bb9faba10b0255837-20200907
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2139031100; Mon, 07 Sep 2020 20:00:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Sep 2020 20:00:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 20:00:55 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v8] binder: transaction latency tracking for user build
Date:   Mon, 7 Sep 2020 20:00:52 +0800
Message-ID: <1599480055-25781-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20200907070045.GA605692@kroah.com>
References: <20200907070045.GA605692@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5F79E32C4879B498ECC0083901FE108F75D4C54F8D5F705B6889A260DFFCD1A72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIGZyb20gdjg6DQogIC0gY2hhbmdlIHJ0Y190aW1lX3RvX3RtIHRvIHJ0Y190aW1lNjRf
dG9fdG0uDQogIC0gY2hhbmdlIHRpbWV2YWwgdG8gX19rZXJuZWxfb2xkX3RpbWV2YWwgZHVlIHRv
IA0KICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWM3NjZkMTQ3MmM3MGQyNWFkNDc1Y2Y1NjA0MmFm
MTY1MmU3OTJiMjMNCiAgLSBleHBvcnQgdHJhY2Vwb2ludCBzeW1ib2wgZm9yIGJpbmRlcl90eG5f
bGF0ZW5jeV8qIHdoaWNoIGJpbmRlcl90cmFuc2FjdGlvbl9sYXRlbmN5X3RyYWNlciB0byBiZSBr
byBuZWVkZWQuDQoNCkNoYW5nZSBmcm9tIHY3Og0KICAtIFVzZSB0aGUgcGFzc2VkLWluIHZhbHVl
cyBpbnN0ZWFkIG9mIGFjY2Vzc2luZyB2aWEgdC0+ZnJvbS90b19wcm9jL3RvX3RocmVhZA0KICAg
IGZvciB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSwgd2hlbiB0cmFjZV9iaW5kZXJfdHhu
X2xhdGVuY3lfZnJlZV9lbmFibGUoKSByZXR1cm4gdHJ1ZS4NCiAgLSBtYWtlIGEgaGVscGVyIGZ1
bmN0aW9uIHRvIGRvIHRoZSBhYm92ZS4NCg0KQ2hhbmdlIGZyb20gdjY6DQogIC0gY2hhbmdlIENP
TkZJR19CSU5ERVJfVFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORyB0eXBlIGZyb20gYm9vbCB0
byB0cmlzdGF0ZQ0KICAtIGFkZCBjb21tZW50cyB0byBAdGltZXN0YW1wIGFuZCBAdHYgdW5kZXIg
c3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbg0KICAtIG1ha2UgYmluZGVyX3R4bl9sYXRlbmN5IHRo
cmVzaG9sZCBjb25maWd1cmFibGUNCiAgLSBlbmhhbmNlIGxvY2sgcHJvdGVjdGlvbg0KDQpDaGFu
Z2UgZnJvbSB2NToNCiAgLSBjaGFuZ2UgY29uZmlnIG5hbWUgdG8gdGhlIHByb3BlciBvbmUsIENP
TkZJR19CSU5ERVJfVFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORy4NCiAgLSBjaGFuZ2UgdHJh
Y2Vwb2ludCBuYW1lIHRvIG1vcmUgZGVzY3JpcHRpdmUgb25lLCB0cmFjZV9iaW5kZXJfdHhuX2xh
dGVuY3lfKGFsbG9jfGluZm98ZnJlZSkNCiAgLSBlbmhhbmNlIHNvbWUgbG9jayBwcm90ZWN0aW9u
Lg0KDQpDaGFuZ2UgZnJvbSB2NDoNCiAgLSBzcGxpdCB1cCBpbnRvIHBhdGNoIHNlcmllcy4NCg0K
Q2hhbmdlIGZyb20gdjM6DQogIC0gdXNlIHRyYWNlcG9pbnRzIGZvciBiaW5kZXJfdXBkYXRlX2lu
Zm8gYW5kIHByaW50X2JpbmRlcl90cmFuc2FjdGlvbl9leHQsDQogICAgaW5zdGVhZCBvZiBjdXN0
b20gcmVnaXN0cmF0aW9uIGZ1bmN0aW9ucy4NCg0KQ2hhbmdlIGZyb20gdjI6DQogIC0gY3JlYXRl
IHRyYW5zYWN0aW9uIGxhdGVuY3kgbW9kdWxlIHRvIG1vbml0b3Igc2xvdyB0cmFuc2FjdGlvbi4N
Cg0KQ2hhbmdlIGZyb20gdjE6DQogIC0gZmlyc3QgcGF0Y2hzZXQuDQoNCg0KRnJhbmtpZS5DaGFu
ZyAoMyk6DQogIGJpbmRlcjogbW92ZSBzdHJ1Y3RzIGZyb20gY29yZSBmaWxlIHRvIGhlYWRlciBm
aWxlDQogIGJpbmRlcjogYWRkIHRyYWNlIGF0IGZyZWUgdHJhbnNhY3Rpb24uDQogIGJpbmRlcjog
YWRkIHRyYW5zYWN0aW9uIGxhdGVuY3kgdHJhY2VyDQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgfCAgIDggKw0KIGRyaXZlcnMvYW5kcm9pZC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgICAg
ICAgIHwgNDMwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5k
ZXJfaW50ZXJuYWwuaCAgICAgICB8IDQxOCArKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZl
cnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYyB8IDExMiArKysrKysNCiBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX3RyYWNlLmggICAgICAgICAgfCAgNDkgKysrDQogNiBmaWxlcyBjaGFu
Z2VkLCA2MTIgaW5zZXJ0aW9ucygrKSwgNDA2IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2xhdGVuY3lfdHJhY2VyLmMNCg==

