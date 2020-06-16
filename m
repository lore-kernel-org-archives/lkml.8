Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB18207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FBkv0fye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgFPF41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:56:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59079 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbgFPF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:56:26 -0400
X-UUID: 32ef32959a3d407aa3a4c37a0c0ba2ae-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BPShzPSzUBgzvJatHzLV7WF1DWhjMLFlqkFxwyyWS5o=;
        b=FBkv0fyeRgDTyXe8iUwI9IPwb6MaVvXciO2dpce5oXEfL8gxfzyx4UrrNTGJrhmTufqKVirad5KF7nuKkmdkBj6E4agj/CZFBHsGIK36ZvpRWAyceCciyNFHi+nCX/cmPywU5j+VA3BmNSRaELv6746UtnTE+lFC7fJwuQf2noo=;
X-UUID: 32ef32959a3d407aa3a4c37a0c0ba2ae-20200616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 955445625; Tue, 16 Jun 2020 13:56:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 13:56:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 13:56:19 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH] usb: gadget: u_serial.h: increase MAX_U_SERIAL_PORTS to 8
Date:   Tue, 16 Jun 2020 13:56:17 +0800
Message-ID: <1592286977-30483-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsncyBMVEUgbW9kZW0gbmVlZHMgdXAgdG8gOCBwb3J0cyB0byBjb25uZWN0IHRvIFBD
IGZvciBsb2dnaW5nDQphbmQgZGVidWdnaW5nIHVuZGVyIHNvbWUgc2NlbmFyaW9zLiBIZW5jZSB3
ZSBzdWdnZXN0IHRvIGluY3JlYXNlIHRoZQ0KZGVmaW5pdGlvbiBvZiBNQVhfVV9TRVJJQUxfUE9S
VFMgdG8gOCBmb3Igc29tZSBjb21wbGV4IGVtYmVkZGVkIHN5c3RlbXMuDQoNClNpZ25lZC1vZmYt
Ynk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuaCB8ICAgIDIgKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL3Vfc2VyaWFsLmgNCmluZGV4IGU1YjA4YWIuLjdkNjExMTMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuaA0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmgNCkBAIC0xMiw3ICsxMiw3IEBADQogI2luY2x1ZGUgPGxp
bnV4L3VzYi9jb21wb3NpdGUuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNiL2NkYy5oPg0KIA0KLSNk
ZWZpbmUgTUFYX1VfU0VSSUFMX1BPUlRTCTQNCisjZGVmaW5lIE1BWF9VX1NFUklBTF9QT1JUUwk4
DQogDQogc3RydWN0IGZfc2VyaWFsX29wdHMgew0KIAlzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3Rh
bmNlIGZ1bmNfaW5zdDsNCi0tIA0KMS43LjkuNQ0K

