Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EF8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134E720721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nije6XlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405391AbgE1RF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:05:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405361AbgE1RFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:17 -0400
X-UUID: 4e470d8b2b944d5082d703d49783522a-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xczzHMcDzH+rvG216/Jzq8vjFMJOFCBUKxolhCXxxQ8=;
        b=Nije6XlXjOWMQQsy98woF1hgFBW6XS4TSwuwUJ48dgw4phy6vtk1KDH45EJt7UGqauwRnqwzb437906TVfHIX5yztgVeuT7HxrlwcyVZ3Ccxv9bYFdJgLRCsnd1oOoWA5a6dANmpw06h4Fy6mt9O2aKOsXEwnLqz6gMPuhI6FEU=;
X-UUID: 4e470d8b2b944d5082d703d49783522a-20200529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 73360311; Fri, 29 May 2020 01:05:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:09 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v6 11/16] soc: mediatek: cmdq: add write_s value function
Date:   Fri, 29 May 2020 01:04:46 +0800
Message-ID: <1590685491-17107-12-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
LmMgfCAxNCArKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmggIHwgMTMgKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMDJhYzBj
YTIzZjZlLi4xMjA5NWExYjcwMWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCkBAIC0yNzksNiArMjc5LDIwIEBAIGludCBjbWRxX3BrdF93cml0ZV9zX21hc2soc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCiB9DQogRVhQT1JUX1NZ
TUJPTChjbWRxX3BrdF93cml0ZV9zX21hc2spOw0KIA0KK2ludCBjbWRxX3BrdF93cml0ZV9zX3Zh
bHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCisJCQkgICB1
MTYgYWRkcl9sb3csIHUzMiB2YWx1ZSkNCit7DQorCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KKw0KKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1M7DQorCWluc3Qu
c29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQorCWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQorCWlu
c3QudmFsdWUgPSB2YWx1ZTsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBr
dCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc192YWx1ZSk7DQor
DQogaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KIHsN
CiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IGMwN2JhYTE1MzRjYS4uYmIzNjc1MGJlNThjIDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTE1Miw2ICsxNTIsMTkg
QEAgaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2Fk
ZHJfcmVnX2lkeCwNCiBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQogCQkJICB1MTYgYWRkcl9sb3csIHUxNiBzcmNf
cmVnX2lkeCwgdTMyIG1hc2spOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUo
KSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0IHdoaWNoDQorICoJ
CQkgICAgICB3cml0ZSB2YWx1ZSB0byBhIHBoeXNpY2FsIGFkZHJlc3MNCisgKiBAcGt0Ogl0aGUg
Q01EUSBwYWNrZXQNCisgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzdGVyIElE
IHdoaWNoIGNvbnRhaW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyX2xvdzoJbG93IGFk
ZHJlc3Mgb2YgcGENCisgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQorICoN
CisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJu
ZWQNCisgKi8NCitpbnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkJICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUp
Ow0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQgZm9yIGV2ZW50IGNv
bW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQotLSAN
CjIuMTguMA0K

