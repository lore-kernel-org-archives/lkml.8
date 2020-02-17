Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEFBC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236062067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GY5SB8VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgBQJKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:10:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39056 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728696AbgBQJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:10:29 -0500
X-UUID: 8ae754a5fcc64540aac9d6a0a5a0e97a-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ImCAz3u2E546r3KAwme+zGo6Ai4bCEGIJM8L5+zVMqc=;
        b=GY5SB8VDZ9eAcJzlE7RSXeXvfdBsq6cOcz46TPvfP64WNpNY8Nn+4BMNJbyYDQT8zu+eaIn49Fy2IPY+r8ppOp4M1XcV+PgwOAEA5cfZYW2eublcUJ9cr7BXyad54J3tN55nFSvjlPDBlvHgjKn1yZYGnbbsCW+q9DCo9t+UjeU=;
X-UUID: 8ae754a5fcc64540aac9d6a0a5a0e97a-20200217
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1265825195; Mon, 17 Feb 2020 17:10:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:09:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:09:57 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 2/3] drm/mediatek: make sure previous message done or be aborted before send
Date:   Mon, 17 Feb 2020 17:10:19 +0800
Message-ID: <20200217091020.16144-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217091020.16144-1-bibby.hsieh@mediatek.com>
References: <20200217091020.16144-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsgQ01EUSBkcml2ZXIgcmVtb3ZlZCBhdG9taWMgcGFyYW1ldGVyIGFuZCBpbXBsZW1l
bnRhdGlvbg0KcmVsYXRlZCB0byBhdG9taWMuIERSTSBkcml2ZXIgbmVlZCB0byBtYWtlIHN1cmUg
cHJldmlvdXMgbWVzc2FnZQ0KZG9uZSBvciBiZSBhYm9ydGVkIGJlZm9yZSB3ZSBzZW5kIG5leHQg
bWVzc2FnZS4NCg0KSWYgcHJldmlvdXMgbWVzc2FnZSBpcyBzdGlsbCB3YWl0aW5nIGZvciBldmVu
dCwgaXQgbWVhbnMgdGhlDQpzZXR0aW5nIGhhc24ndCBiZWVuIHVwZGF0ZWQgaW50byBkaXNwbGF5
IGhhcmR3YXJlIHJlZ2lzdGVyLA0Kd2UgY2FuIGFib3J0IHRoZSBtZXNzYWdlIGFuZCBzZW5kIG5l
eHQgbWVzc2FnZSB0byB1cGRhdGUgdGhlDQpuZXdlc3Qgc2V0dGluZyBpbnRvIGRpc3BsYXkgaGFy
ZHdhcmUuDQpJZiBwcmV2aW91cyBtZXNzYWdlIGFscmVhZHkgc3RhcnRlZCwgd2UgaGF2ZSB0byB3
YWl0IGl0IHVudGlsDQp0cmFuc21pc3Npb24gaGFzIGJlZW4gY29tcGxldGVkLg0KDQpTbyB3ZSBm
bHVzaCBtYm94IGNsaWVudCBiZWZvcmUgd2Ugc2VuZCBuZXcgbWVzc2FnZSB0byBjb250cm9sbGVy
DQpkcml2ZXIuDQoNClRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBwdGFjaDoNClswLzNdIFJlbW92ZSBh
dG9taWNfZXhlYw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTM4MTY3Ny8N
Cg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4N
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCmlu
ZGV4IDNjNTNlYTIyMjA4Yy4uZTM1YjY2YzViYTBmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMNCkBAIC00OTEsNiArNDkxLDcgQEAgc3RhdGljIHZvaWQgbXRrX2Ry
bV9jcnRjX2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCiAJfQ0KICNp
ZiBJU19FTkFCTEVEKENPTkZJR19NVEtfQ01EUSkNCiAJaWYgKG10a19jcnRjLT5jbWRxX2NsaWVu
dCkgew0KKwkJbWJveF9mbHVzaChtdGtfY3J0Yy0+Y21kcV9jbGllbnQtPmNoYW4sIDIwMDApOw0K
IAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9jcmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQ
QUdFX1NJWkUpOw0KIAkJY21kcV9wa3RfY2xlYXJfZXZlbnQoY21kcV9oYW5kbGUsIG10a19jcnRj
LT5jbWRxX2V2ZW50KTsNCiAJCWNtZHFfcGt0X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNt
ZHFfZXZlbnQpOw0KLS0gDQoyLjE4LjANCg==

