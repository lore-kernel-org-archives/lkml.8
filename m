Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF66C2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2507B20936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F9grUUsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgIHURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:17:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52761 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729622AbgIHPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:01 -0400
X-UUID: d32e2253dee546139a98e365ebb57e66-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vKVQJoq0ngtrX7X9lUEqQqGl9rFsnjBvVAJAtligKEI=;
        b=F9grUUsztZ4VmHwoI+rY+AnLqjlB7NyijdnAX2Uw34FtKKepFJq0inu+JGFOYGs/FyU8VZVAem2jsvqz/eBiZdUg0k4mlQhhbHW3O3TK+XSGAv/pafEGJcNO+DULToj37xdA4EwNdqBDWT9FGqmvww1d6oulBuOSQ+fbYYtgefU=;
X-UUID: d32e2253dee546139a98e365ebb57e66-20200908
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1906233610; Tue, 08 Sep 2020 22:06:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 22:06:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 22:06:48 +0800
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
Subject: [PATCH v9] binder: transaction latency tracking for user build
Date:   Tue, 8 Sep 2020 22:06:45 +0800
Message-ID: <1599574008-5805-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1599543504.16905.65.camel@mtkswgap22>
References: <1599543504.16905.65.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIGZyb20gdjk6DQogIC0gcmVuYW1lIHRpbWVzdGFtcCB0byB0cyBpbiBiaW5kZXJfaW50
ZXJuYWwuaCBmb3IgY29uY2lzZW5lc3MuDQogIC0gY2hhbmdlICdzdHJ1Y3QgdGltZXZhbCcgdG8g
J3N0cnVjdCB0aW1lc3BlYzY0JyBpbiBiaW5kZXJfaW50ZXJuYWwuaC4NCg0KQ2hhbmdlIGZyb20g
djg6DQogIC0gY2hhbmdlIHJ0Y190aW1lX3RvX3RtIHRvIHJ0Y190aW1lNjRfdG9fdG0uDQogIC0g
Y2hhbmdlIHRpbWV2YWwgdG8gX19rZXJuZWxfb2xkX3RpbWV2YWwgZHVlIHRvIA0KICAgIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPWM3NjZkMTQ3MmM3MGQyNWFkNDc1Y2Y1NjA0MmFmMTY1MmU3OTJiMjMN
CiAgLSBleHBvcnQgdHJhY2Vwb2ludCBzeW1ib2wgZm9yIGJpbmRlcl90eG5fbGF0ZW5jeV8qIHdo
aWNoIGJpbmRlcl90cmFuc2FjdGlvbl9sYXRlbmN5X3RyYWNlciB0byBiZSBrbyBuZWVkZWQuDQoN
CkNoYW5nZSBmcm9tIHY3Og0KICAtIFVzZSB0aGUgcGFzc2VkLWluIHZhbHVlcyBpbnN0ZWFkIG9m
IGFjY2Vzc2luZyB2aWEgdC0+ZnJvbS90b19wcm9jL3RvX3RocmVhZA0KICAgIGZvciB0cmFjZV9i
aW5kZXJfdHhuX2xhdGVuY3lfZnJlZSwgd2hlbiB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJl
ZV9lbmFibGUoKSByZXR1cm4gdHJ1ZS4NCiAgLSBtYWtlIGEgaGVscGVyIGZ1bmN0aW9uIHRvIGRv
IHRoZSBhYm92ZS4NCg0KQ2hhbmdlIGZyb20gdjY6DQogIC0gY2hhbmdlIENPTkZJR19CSU5ERVJf
VFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORyB0eXBlIGZyb20gYm9vbCB0byB0cmlzdGF0ZQ0K
ICAtIGFkZCBjb21tZW50cyB0byBAdGltZXN0YW1wIGFuZCBAdHYgdW5kZXIgc3RydWN0IGJpbmRl
cl90cmFuc2FjdGlvbg0KICAtIG1ha2UgYmluZGVyX3R4bl9sYXRlbmN5IHRocmVzaG9sZCBjb25m
aWd1cmFibGUNCiAgLSBlbmhhbmNlIGxvY2sgcHJvdGVjdGlvbg0KDQpDaGFuZ2UgZnJvbSB2NToN
CiAgLSBjaGFuZ2UgY29uZmlnIG5hbWUgdG8gdGhlIHByb3BlciBvbmUsIENPTkZJR19CSU5ERVJf
VFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORy4NCiAgLSBjaGFuZ2UgdHJhY2Vwb2ludCBuYW1l
IHRvIG1vcmUgZGVzY3JpcHRpdmUgb25lLCB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfKGFsbG9j
fGluZm98ZnJlZSkNCiAgLSBlbmhhbmNlIHNvbWUgbG9jayBwcm90ZWN0aW9uLg0KDQpDaGFuZ2Ug
ZnJvbSB2NDoNCiAgLSBzcGxpdCB1cCBpbnRvIHBhdGNoIHNlcmllcy4NCg0KQ2hhbmdlIGZyb20g
djM6DQogIC0gdXNlIHRyYWNlcG9pbnRzIGZvciBiaW5kZXJfdXBkYXRlX2luZm8gYW5kIHByaW50
X2JpbmRlcl90cmFuc2FjdGlvbl9leHQsDQogICAgaW5zdGVhZCBvZiBjdXN0b20gcmVnaXN0cmF0
aW9uIGZ1bmN0aW9ucy4NCg0KQ2hhbmdlIGZyb20gdjI6DQogIC0gY3JlYXRlIHRyYW5zYWN0aW9u
IGxhdGVuY3kgbW9kdWxlIHRvIG1vbml0b3Igc2xvdyB0cmFuc2FjdGlvbi4NCg0KQ2hhbmdlIGZy
b20gdjE6DQogIC0gZmlyc3QgcGF0Y2hzZXQuDQoNCg0KRnJhbmtpZS5DaGFuZyAoMyk6DQogIGJp
bmRlcjogbW92ZSBzdHJ1Y3RzIGZyb20gY29yZSBmaWxlIHRvIGhlYWRlciBmaWxlDQogIGJpbmRl
cjogYWRkIHRyYWNlIGF0IGZyZWUgdHJhbnNhY3Rpb24uDQogIGJpbmRlcjogYWRkIHRyYW5zYWN0
aW9uIGxhdGVuY3kgdHJhY2VyDQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgIDggKw0KIGRyaXZlcnMvYW5kcm9pZC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8
ICAgMSArDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgICAgICAgIHwgNDMwICsr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50ZXJuYWwu
aCAgICAgICB8IDQxOCArKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvYW5kcm9pZC9i
aW5kZXJfbGF0ZW5jeV90cmFjZXIuYyB8IDEwOCArKysrKysNCiBkcml2ZXJzL2FuZHJvaWQvYmlu
ZGVyX3RyYWNlLmggICAgICAgICAgfCAgNDkgKysrDQogNiBmaWxlcyBjaGFuZ2VkLCA2MDggaW5z
ZXJ0aW9ucygrKSwgNDA2IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX2xhdGVuY3lfdHJhY2VyLmMNCg==

