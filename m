Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F912072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eIAnJEmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgG0HRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:17:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30757 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727020AbgG0HQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:43 -0400
X-UUID: 9e21685d2bfa4d14a005b76313cdf3ab-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=udxjwRcR6H9qN2bTMph2UQxIL1NJUT+zyNYINSQ2gPM=;
        b=eIAnJEmw/GsQ+kdBEAbrFuvN5VbRhl/abdWJ0aYoCSY1tKRys6Mhm4pC0+3y/NSJQzB4qi+67CVz9oSgF1vmNR8KxSB4LysIORdwVa6TbtjtmoIvQEwPxQz24P/YUCjLKUSf6rTKgBHowFO7MXLKaDTpqUGc6Zenkl6CDlPz1+I=;
X-UUID: 9e21685d2bfa4d14a005b76313cdf3ab-20200727
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1140998356; Mon, 27 Jul 2020 15:16:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:36 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 05/11] usb: mtu3: introduce a funtion to check maximum speed
Date:   Mon, 27 Jul 2020 15:14:54 +0800
Message-ID: <1595834101-13094-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG1heF9zcGVlZCBnb3QgZnJvbSBEVFMgbWF5IGJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlDQpo
YXJkd2FyZSwgc28gbmVlZCBjaGVjayBpdCwgYW5kIGFzc2lnbiBhIHByb3BlciBkZWZhdWx0DQp2
YWx1ZS4gQW5kIG1ha2UgaXQgY2xlYXIgYnkgaW50cm9kdWNpbmcgYSBmdW50aW9uLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL3VzYi9tdHUzL210dTNfY29yZS5jIHwgNDggKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KSwgMjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTNf
Y29yZS5jIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYw0KaW5kZXggZWNlNWIzZS4uOTY5
NDgxMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCisrKyBiL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCkBAIC01NzMsOSArNTczLDYgQEAgc3RhdGljIHZv
aWQgbXR1M19zZXRfc3BlZWQoc3RydWN0IG10dTMgKm10dSkNCiB7DQogCXZvaWQgX19pb21lbSAq
bWJhc2UgPSBtdHUtPm1hY19iYXNlOw0KIA0KLQlpZiAoIW10dS0+aXNfdTNfaXAgJiYgKG10dS0+
bWF4X3NwZWVkID4gVVNCX1NQRUVEX0hJR0gpKQ0KLQkJbXR1LT5tYXhfc3BlZWQgPSBVU0JfU1BF
RURfSElHSDsNCi0NCiAJaWYgKG10dS0+bWF4X3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSB7DQog
CQkvKiBkaXNhYmxlIFUzIFNTIGZ1bmN0aW9uICovDQogCQltdHUzX2NscmJpdHMobWJhc2UsIFUz
RF9VU0IzX0NPTkZJRywgVVNCM19FTik7DQpAQCAtNzYxLDYgKzc1OCwzMiBAQCBzdGF0aWMgaXJx
cmV0dXJuX3QgbXR1M19pcnEoaW50IGlycSwgdm9pZCAqZGF0YSkNCiAJcmV0dXJuIElSUV9IQU5E
TEVEOw0KIH0NCiANCitzdGF0aWMgdm9pZCBtdHUzX2NoZWNrX3BhcmFtcyhzdHJ1Y3QgbXR1MyAq
bXR1KQ0KK3sNCisJLyogY2hlY2sgdGhlIG1heF9zcGVlZCBwYXJhbWV0ZXIgKi8NCisJc3dpdGNo
IChtdHUtPm1heF9zcGVlZCkgew0KKwljYXNlIFVTQl9TUEVFRF9GVUxMOg0KKwljYXNlIFVTQl9T
UEVFRF9ISUdIOg0KKwljYXNlIFVTQl9TUEVFRF9TVVBFUjoNCisJY2FzZSBVU0JfU1BFRURfU1VQ
RVJfUExVUzoNCisJCWJyZWFrOw0KKwlkZWZhdWx0Og0KKwkJZGV2X2VycihtdHUtPmRldiwgImlu
dmFsaWQgbWF4X3NwZWVkOiAlc1xuIiwNCisJCQl1c2Jfc3BlZWRfc3RyaW5nKG10dS0+bWF4X3Nw
ZWVkKSk7DQorCQlmYWxsdGhyb3VnaDsNCisJY2FzZSBVU0JfU1BFRURfVU5LTk9XTjoNCisJCS8q
IGRlZmF1bHQgYXMgU1NQICovDQorCQltdHUtPm1heF9zcGVlZCA9IFVTQl9TUEVFRF9TVVBFUl9Q
TFVTOw0KKwkJYnJlYWs7DQorCX0NCisNCisJaWYgKCFtdHUtPmlzX3UzX2lwICYmIChtdHUtPm1h
eF9zcGVlZCA+IFVTQl9TUEVFRF9ISUdIKSkNCisJCW10dS0+bWF4X3NwZWVkID0gVVNCX1NQRUVE
X0hJR0g7DQorDQorCWRldl9pbmZvKG10dS0+ZGV2LCAibWF4X3NwZWVkOiAlc1xuIiwNCisJCSB1
c2Jfc3BlZWRfc3RyaW5nKG10dS0+bWF4X3NwZWVkKSk7DQorfQ0KKw0KIHN0YXRpYyBpbnQgbXR1
M19od19pbml0KHN0cnVjdCBtdHUzICptdHUpDQogew0KIAl1MzIgdmFsdWU7DQpAQCAtNzc2LDYg
Kzc5OSw4IEBAIHN0YXRpYyBpbnQgbXR1M19od19pbml0KHN0cnVjdCBtdHUzICptdHUpDQogCWRl
dl9pbmZvKG10dS0+ZGV2LCAiSVAgdmVyc2lvbiAweCV4KCVzIElQKVxuIiwgbXR1LT5od192ZXJz
aW9uLA0KIAkJbXR1LT5pc191M19pcCA/ICJVMyIgOiAiVTIiKTsNCiANCisJbXR1M19jaGVja19w
YXJhbXMobXR1KTsNCisNCiAJbXR1M19kZXZpY2VfcmVzZXQobXR1KTsNCiANCiAJcmV0ID0gbXR1
M19kZXZpY2VfZW5hYmxlKG10dSk7DQpAQCAtODU3LDIzICs4ODIsNiBAQCBpbnQgc3N1c2JfZ2Fk
Z2V0X2luaXQoc3RydWN0IHNzdXNiX210ayAqc3N1c2IpDQogCW10dS0+c3N1c2IgPSBzc3VzYjsN
CiAJbXR1LT5tYXhfc3BlZWQgPSB1c2JfZ2V0X21heGltdW1fc3BlZWQoZGV2KTsNCiANCi0JLyog
Y2hlY2sgdGhlIG1heF9zcGVlZCBwYXJhbWV0ZXIgKi8NCi0Jc3dpdGNoIChtdHUtPm1heF9zcGVl
ZCkgew0KLQljYXNlIFVTQl9TUEVFRF9GVUxMOg0KLQljYXNlIFVTQl9TUEVFRF9ISUdIOg0KLQlj
YXNlIFVTQl9TUEVFRF9TVVBFUjoNCi0JY2FzZSBVU0JfU1BFRURfU1VQRVJfUExVUzoNCi0JCWJy
ZWFrOw0KLQlkZWZhdWx0Og0KLQkJZGV2X2VycihkZXYsICJpbnZhbGlkIG1heF9zcGVlZDogJXNc
biIsDQotCQkJdXNiX3NwZWVkX3N0cmluZyhtdHUtPm1heF9zcGVlZCkpOw0KLQkJLyogZmFsbCB0
aHJvdWdoICovDQotCWNhc2UgVVNCX1NQRUVEX1VOS05PV046DQotCQkvKiBkZWZhdWx0IGFzIFNT
UCAqLw0KLQkJbXR1LT5tYXhfc3BlZWQgPSBVU0JfU1BFRURfU1VQRVJfUExVUzsNCi0JCWJyZWFr
Ow0KLQl9DQotDQogCWRldl9kYmcoZGV2LCAibWFjX2Jhc2U9MHglcCwgaXBwY19iYXNlPTB4JXBc
biIsDQogCQltdHUtPm1hY19iYXNlLCBtdHUtPmlwcGNfYmFzZSk7DQogDQotLSANCjEuOS4xDQo=

