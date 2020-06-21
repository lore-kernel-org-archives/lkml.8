Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34111C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F682491C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U6OCt2dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgFUOSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38162 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730205AbgFUOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:46 -0400
X-UUID: b14a7970e3fd409ab609131b4d12002a-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ln+rkT3dIfrDKNAMp7Uba3liciwtJVa1X9S3XoST1AQ=;
        b=U6OCt2dVTRO0nPOhO1YQQPaJCMz7G5u3P1ace8YKOUDsnjF8LxCGlZIC0ZaYwM0XMEAFmR4m6Jpzw3jh7uRU+78zri0fi3Q+TM9C744Wah1D/QrI3Q22RwgL0zIeHPJb1v6x5RYuMe3gaQdcx+XSSy/KpF+RZFA5wreqQrTAUpM=;
X-UUID: b14a7970e3fd409ab609131b4d12002a-20200621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1015288263; Sun, 21 Jun 2020 22:18:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:30 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v1 06/11] soc: mediatek: cmdq: add write_s value function
Date:   Sun, 21 Jun 2020 22:18:30 +0800
Message-ID: <1592749115-24158-7-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgYSBjb25zdGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGggbGFyZ2UgZG1hDQphY2Nlc3Mgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAgIDE0ICsrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRr
LWNtZHEuaCAgfCAgIDEzICsrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IDU4
MDc1NTg5NTA5Yi4uMmFkNzhkZjQ2NjM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRx
LWhlbHBlci5jDQpAQCAtMjc5LDYgKzI3OSwyMCBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNr
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQogfQ0KIEVYUE9S
VF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc19tYXNrKTsNCiANCitpbnQgY21kcV9wa3Rfd3JpdGVf
c192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkJ
ICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUpDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlv
biBpbnN0ID0ge307DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCisJaW5zdC5z
b3AgPSBoaWdoX2FkZHJfcmVnX2lkeDsNCisJaW5zdC5vZmZzZXQgPSBhZGRyX2xvdzsNCisJaW5z
dC52YWx1ZSA9IHZhbHVlOw0KKw0KKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0
LCBpbnN0KTsNCit9DQorRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKTsNCisN
CiBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQogew0K
IAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggNDBmZTFlYjUyMTkwLi43ZjFjMTE1YTY2YjggMTAw
NjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTUyLDYgKzE1MiwxOSBA
QCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGln
aF9hZGRyX3JlZ19pZHgsDQogCQkJICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCwgdTMy
IG1hc2spOw0KIA0KIC8qKg0KKyAqIGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoKSAtIGFwcGVuZCB3
cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0IHdoaWNoDQorICoJCQkgICAgICB3cml0
ZSB2YWx1ZSB0byBhIHBoeXNpY2FsIGFkZHJlc3MNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQN
CisgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNvbnRh
aW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGEN
CisgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQorICoNCisgKiBSZXR1cm46
IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitp
bnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggaGlnaF9h
ZGRyX3JlZ19pZHgsDQorCQkJICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUpOw0KKw0KKy8qKg0K
ICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhl
IENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQogICogQGV2ZW50Ogl0aGUg
ZGVzaXJlZCBldmVudCB0eXBlIHRvICJ3YWl0IGFuZCBDTEVBUiINCi0tIA0KMS43LjkuNQ0K

