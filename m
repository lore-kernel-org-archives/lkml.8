Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79DFC2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694792177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rb6G1CwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgIHJGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:06:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27853 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728547AbgIHJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:06:00 -0400
X-UUID: 61e2ee4daa7a43918bffebf8ccc80dda-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SQD49d6hVayfxN4/ILoTkIw56AypoTBrgE49r+z4QKQ=;
        b=Rb6G1CwMw8w/oVgKzg10L6RmdzueAkHYCWjyvEzegrUjIGTF2mpeWt3KiO6ScuHD8p956NB6HVa4xhia9VE1ZJ3W35tqrcikNJmKxrlNFW1hJttodOEsQ38MXkvvlez2B57sCyKHQQgytIxoRoj6HEYR7gZe5ES46UFq/fQjmjc=;
X-UUID: 61e2ee4daa7a43918bffebf8ccc80dda-20200908
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 413739645; Tue, 08 Sep 2020 17:05:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 17:05:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 17:05:46 +0800
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jing-Ting Wu <jing-ting.wu@mediatek.com>
Subject: [PATCH 1/1] sched/rt: add rt throttled/unthrottled log
Date:   Tue, 8 Sep 2020 17:05:46 +0800
Message-ID: <1599555946-30802-1-git-send-email-jing-ting.wu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWx3YXlzIHByaW50IGxvZ3Mgd2hlbiBydCB0aHJvdHRsZS91bnRocm90dGxlLA0KaXQgaXMgbXVj
aCBlYXNpZXIgdG8gbG9jYXRlIHRoZSB0aHJvdHRsZWQgcGVyaW9kLg0KDQpTaWduZWQtb2ZmLWJ5
OiBKaW5nLVRpbmcgV3UgPGppbmctdGluZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBrZXJuZWwv
c2NoZWQvcnQuYyB8ICAgIDUgKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvcnQuYyBiL2tlcm5l
bC9zY2hlZC9ydC5jDQppbmRleCBmMjE1ZWVhLi41OTgwNDZjIDEwMDY0NA0KLS0tIGEva2VybmVs
L3NjaGVkL3J0LmMNCisrKyBiL2tlcm5lbC9zY2hlZC9ydC5jDQpAQCAtOTAyLDYgKzkwMiw5IEBA
IHN0YXRpYyBpbnQgZG9fc2NoZWRfcnRfcGVyaW9kX3RpbWVyKHN0cnVjdCBydF9iYW5kd2lkdGgg
KnJ0X2IsIGludCBvdmVycnVuKQ0KIAkJCQlydF9ycS0+cnRfdGhyb3R0bGVkID0gMDsNCiAJCQkJ
ZW5xdWV1ZSA9IDE7DQogDQorCQkJCXByaW50a19kZWZlcnJlZCgic2NoZWQ6IFJUIHRocm90dGxp
bmcgaW5hY3RpdmF0ZWQgY3B1PSVkXG4iLA0KKwkJCQkJCWkpOw0KKw0KIAkJCQkvKg0KIAkJCQkg
KiBXaGVuIHdlJ3JlIGlkbGUgYW5kIGEgd29rZW4gKHJ0KSB0YXNrIGlzDQogCQkJCSAqIHRocm90
dGxlZCBjaGVja19wcmVlbXB0X2N1cnIoKSB3aWxsIHNldA0KQEAgLTk3MCw3ICs5NzMsNyBAQCBz
dGF0aWMgaW50IHNjaGVkX3J0X3J1bnRpbWVfZXhjZWVkZWQoc3RydWN0IHJ0X3JxICpydF9ycSkN
CiAJCSAqLw0KIAkJaWYgKGxpa2VseShydF9iLT5ydF9ydW50aW1lKSkgew0KIAkJCXJ0X3JxLT5y
dF90aHJvdHRsZWQgPSAxOw0KLQkJCXByaW50a19kZWZlcnJlZF9vbmNlKCJzY2hlZDogUlQgdGhy
b3R0bGluZyBhY3RpdmF0ZWRcbiIpOw0KKwkJCXByaW50a19kZWZlcnJlZCgic2NoZWQ6IFJUIHRo
cm90dGxpbmcgYWN0aXZhdGVkXG4iKTsNCiAJCX0gZWxzZSB7DQogCQkJLyoNCiAJCQkgKiBJbiBj
YXNlIHdlIGRpZCBhbnl3YXksIG1ha2UgaXQgZ28gYXdheSwNCi0tIA0KMS43LjkuNQ0K

