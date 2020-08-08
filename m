Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D55C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684DA22CF8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rIcx7A+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHHCyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:54:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64198 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726400AbgHHCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:54:51 -0400
X-UUID: 2fea0030feb54e7db70c9e9e35070abe-20200808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m7FXqhl+q1+Ta/5MGULD8omxHcaYllRsWSCL96ZV9os=;
        b=rIcx7A+ViYlodzpyY0z8HeRgwE4TZ9xaxXCO37BKvcJcp1N+ZpIKVvuZdTiMpHxQR0dzZSg26j43kcRy6Ka8OCABrVuHuUJqQpHMRmJHkz4s3pFYGKg5FsxZWBqAmaFG43I4EMeTAPig1yvjKiWQ8EG/lRT313Y9H6+iZ/m80XY=;
X-UUID: 2fea0030feb54e7db70c9e9e35070abe-20200808
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1625627258; Sat, 08 Aug 2020 10:54:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Aug 2020 10:54:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Aug 2020 10:54:40 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND v7, PATCH 2/7] drm/mediatek: move ddp component define into mtk_mmsys.h
Date:   Sat, 8 Aug 2020 10:53:46 +0800
Message-ID: <1596855231-5782-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bW1zeXMgaXMgdGhlIGRyaXZlciB3aGljaCBjb250cm9sIHRoZSByb3V0aW5nIG9mIHRoZXNlIGRk
cCBjb21wb25lbnQsDQpzbyB0aGUgZGVmaW5pdGlvbiBvZiBtdGtfZGRwX2NvbXBfaWQgc2hvdWxk
IGJlIHBsYWNlZCBpbiBtdGstbW1zeXMuaA0KDQpTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1
IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAzNCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5jICAgICAgICAgICAgfCAgNCArLS0t
DQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmggICAgICB8IDMzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMo
KyksIDM2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmgNCmluZGV4IGRlYmUzNjMuLjE2MTIwMWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQpAQCAtNyw2ICs3LDcgQEANCiAjZGVmaW5l
IE1US19EUk1fRERQX0NPTVBfSA0KIA0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRl
IDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQogDQogc3RydWN0IGRldmljZTsNCiBz
dHJ1Y3QgZGV2aWNlX25vZGU7DQpAQCAtMzUsMzkgKzM2LDYgQEAgZW51bSBtdGtfZGRwX2NvbXBf
dHlwZSB7DQogCU1US19ERFBfQ09NUF9UWVBFX01BWCwNCiB9Ow0KIA0KLWVudW0gbXRrX2RkcF9j
b21wX2lkIHsNCi0JRERQX0NPTVBPTkVOVF9BQUwwLA0KLQlERFBfQ09NUE9ORU5UX0FBTDEsDQot
CUREUF9DT01QT05FTlRfQkxTLA0KLQlERFBfQ09NUE9ORU5UX0NDT1JSLA0KLQlERFBfQ09NUE9O
RU5UX0NPTE9SMCwNCi0JRERQX0NPTVBPTkVOVF9DT0xPUjEsDQotCUREUF9DT01QT05FTlRfRElU
SEVSLA0KLQlERFBfQ09NUE9ORU5UX0RQSTAsDQotCUREUF9DT01QT05FTlRfRFBJMSwNCi0JRERQ
X0NPTVBPTkVOVF9EU0kwLA0KLQlERFBfQ09NUE9ORU5UX0RTSTEsDQotCUREUF9DT01QT05FTlRf
RFNJMiwNCi0JRERQX0NPTVBPTkVOVF9EU0kzLA0KLQlERFBfQ09NUE9ORU5UX0dBTU1BLA0KLQlE
RFBfQ09NUE9ORU5UX09EMCwNCi0JRERQX0NPTVBPTkVOVF9PRDEsDQotCUREUF9DT01QT05FTlRf
T1ZMMCwNCi0JRERQX0NPTVBPTkVOVF9PVkxfMkwwLA0KLQlERFBfQ09NUE9ORU5UX09WTF8yTDEs
DQotCUREUF9DT01QT05FTlRfT1ZMMSwNCi0JRERQX0NPTVBPTkVOVF9QV00wLA0KLQlERFBfQ09N
UE9ORU5UX1BXTTEsDQotCUREUF9DT01QT05FTlRfUFdNMiwNCi0JRERQX0NPTVBPTkVOVF9SRE1B
MCwNCi0JRERQX0NPTVBPTkVOVF9SRE1BMSwNCi0JRERQX0NPTVBPTkVOVF9SRE1BMiwNCi0JRERQ
X0NPTVBPTkVOVF9VRk9FLA0KLQlERFBfQ09NUE9ORU5UX1dETUEwLA0KLQlERFBfQ09NUE9ORU5U
X1dETUExLA0KLQlERFBfQ09NUE9ORU5UX0lEX01BWCwNCi19Ow0KLQ0KIHN0cnVjdCBtdGtfZGRw
X2NvbXA7DQogc3RydWN0IGNtZHFfcGt0Ow0KIHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3Mgew0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1tbXN5cy5jIGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCmluZGV4IGE1NWYyNTUuLjM2YWQ2NmIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYw0KKysrIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLW1tc3lzLmMNCkBAIC01LDEzICs1LDExIEBADQogICovDQogDQogI2luY2x1
ZGUgPGxpbnV4L2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KICNpbmNsdWRlIDxs
aW51eC9vZl9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQog
I2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaD4NCiANCi0jaW5jbHVkZSAi
Li4vLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5oIg0KLSNpbmNsdWRlICIuLi8uLi9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCINCi0NCiAjZGVmaW5lIERJU1BfUkVH
X0NPTkZJR19ESVNQX09WTDBfTU9VVF9FTgkweDA0MA0KICNkZWZpbmUgRElTUF9SRUdfQ09ORklH
X0RJU1BfT1ZMMV9NT1VUX0VOCTB4MDQ0DQogI2RlZmluZSBESVNQX1JFR19DT05GSUdfRElTUF9P
RF9NT1VUX0VOCQkweDA0OA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1tbXN5cy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmgNCmlu
ZGV4IDdiYWI1ZDkuLjIyMjhiZjYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstbW1zeXMuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1t
c3lzLmgNCkBAIC05LDYgKzksMzkgQEANCiBlbnVtIG10a19kZHBfY29tcF9pZDsNCiBzdHJ1Y3Qg
ZGV2aWNlOw0KIA0KK2VudW0gbXRrX2RkcF9jb21wX2lkIHsNCisJRERQX0NPTVBPTkVOVF9BQUww
LA0KKwlERFBfQ09NUE9ORU5UX0FBTDEsDQorCUREUF9DT01QT05FTlRfQkxTLA0KKwlERFBfQ09N
UE9ORU5UX0NDT1JSLA0KKwlERFBfQ09NUE9ORU5UX0NPTE9SMCwNCisJRERQX0NPTVBPTkVOVF9D
T0xPUjEsDQorCUREUF9DT01QT05FTlRfRElUSEVSLA0KKwlERFBfQ09NUE9ORU5UX0RQSTAsDQor
CUREUF9DT01QT05FTlRfRFBJMSwNCisJRERQX0NPTVBPTkVOVF9EU0kwLA0KKwlERFBfQ09NUE9O
RU5UX0RTSTEsDQorCUREUF9DT01QT05FTlRfRFNJMiwNCisJRERQX0NPTVBPTkVOVF9EU0kzLA0K
KwlERFBfQ09NUE9ORU5UX0dBTU1BLA0KKwlERFBfQ09NUE9ORU5UX09EMCwNCisJRERQX0NPTVBP
TkVOVF9PRDEsDQorCUREUF9DT01QT05FTlRfT1ZMMCwNCisJRERQX0NPTVBPTkVOVF9PVkxfMkww
LA0KKwlERFBfQ09NUE9ORU5UX09WTF8yTDEsDQorCUREUF9DT01QT05FTlRfT1ZMMSwNCisJRERQ
X0NPTVBPTkVOVF9QV00wLA0KKwlERFBfQ09NUE9ORU5UX1BXTTEsDQorCUREUF9DT01QT05FTlRf
UFdNMiwNCisJRERQX0NPTVBPTkVOVF9SRE1BMCwNCisJRERQX0NPTVBPTkVOVF9SRE1BMSwNCisJ
RERQX0NPTVBPTkVOVF9SRE1BMiwNCisJRERQX0NPTVBPTkVOVF9VRk9FLA0KKwlERFBfQ09NUE9O
RU5UX1dETUEwLA0KKwlERFBfQ09NUE9ORU5UX1dETUExLA0KKwlERFBfQ09NUE9ORU5UX0lEX01B
WCwNCit9Ow0KKw0KIHZvaWQgbXRrX21tc3lzX2RkcF9jb25uZWN0KHN0cnVjdCBkZXZpY2UgKmRl
diwNCiAJCQkgICBlbnVtIG10a19kZHBfY29tcF9pZCBjdXIsDQogCQkJICAgZW51bSBtdGtfZGRw
X2NvbXBfaWQgbmV4dCk7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

