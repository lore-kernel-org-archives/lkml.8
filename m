Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0ABC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FF520855
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Be5BQvJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHTGFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22967 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgHTGFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:37 -0400
X-UUID: 0143b9a8870146e6b2d7a814b6e31741-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bwYl3rcHgTIQ25qpI38KvxgwPkB5MaFcy5ozufwMs3c=;
        b=Be5BQvJka9Mm97Rk9U49bJFJnjMs/kBp8ElXlQHN7bka45biWvLnih3ACe2W29YsPTuy+BEUVa90Rr32f34rwrlIcYJSd3oTm8aSTNz3YNp4Tijk9N+g0ji/kGjco2tcPpJv6bQPwp5Xa15ZfZ9W5z/JIcijg+QimAiJAQcur4Q=;
X-UUID: 0143b9a8870146e6b2d7a814b6e31741-20200820
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1963706133; Thu, 20 Aug 2020 14:05:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:33 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:32 +0800
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
Subject: [PATCH v1 02/21] drm/mediatek: add component POSTMASK
Date:   Thu, 20 Aug 2020 14:03:59 +0800
Message-ID: <1597903458-8055-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29tcG9uZW50IFBPU1RNQVNLDQoNClNpZ25lZC1vZmYtYnk6IFlvbmdx
aWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDMxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8
ICAxICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaCAgICAgIHwgIDEg
Kw0KIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCmluZGV4IDVlOTdjYTUuLjhiOWZiNWUgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQpAQCAtNTgs
NiArNTgsMTAgQEANCiAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAwMzANCiAjZGVmaW5l
IERJU1BfR0FNTUFfTFVUCQkJCTB4MDcwMA0KIA0KKyNkZWZpbmUgRElTUF9QT1NUTUFTS19FTgkJ
CTB4MDAwMA0KKyNkZWZpbmUgRElTUF9QT1NUTUFTS19DRkcJCQkweDAwMjANCisjZGVmaW5lIERJ
U1BfUE9TVE1BU0tfU0laRQkJCTB4MDAzMA0KKw0KICNkZWZpbmUgTFVUXzEwQklUX01BU0sJCQkJ
MHgwM2ZmDQogDQogI2RlZmluZSBPRF9SRUxBWU1PREUJCQkJQklUKDApDQpAQCAtMzE5LDYgKzMy
MywyNCBAQCBzdGF0aWMgdm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNv
bXAsDQogCX0NCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX3Bvc3RtYXNrX2NvbmZpZyhzdHJ1Y3Qg
bXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgdywNCisJCQkgICAgICB1bnNpZ25lZCBp
bnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KKwkJCSAgICAgIHVuc2lnbmVkIGludCBicGMs
IHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQorew0KKwltdGtfZGRwX3dyaXRlKGNtZHFfcGt0
LCB3IDw8IDE2IHwgaCwgY29tcCwgRElTUF9QT1NUTUFTS19TSVpFKTsNCisJbXRrX2RkcF93cml0
ZShjbWRxX3BrdCwgRElUSEVSX1JFTEFZX01PREUsIGNvbXAsIERJU1BfUE9TVE1BU0tfQ0ZHKTsN
Cit9DQorDQorc3RhdGljIHZvaWQgbXRrX3Bvc3RtYXNrX3N0YXJ0KHN0cnVjdCBtdGtfZGRwX2Nv
bXAgKmNvbXApDQorew0KKwl3cml0ZWwoRElUSEVSX0VOLCBjb21wLT5yZWdzICsgRElTUF9QT1NU
TUFTS19FTik7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIG10a19wb3N0bWFza19zdG9wKHN0cnVjdCBt
dGtfZGRwX2NvbXAgKmNvbXApDQorew0KKwl3cml0ZWxfcmVsYXhlZCgweDAsIGNvbXAtPnJlZ3Mg
KyBESVNQX1BPU1RNQVNLX0VOKTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRw
X2NvbXBfZnVuY3MgZGRwX2FhbCA9IHsNCiAJLmdhbW1hX3NldCA9IG10a19nYW1tYV9zZXQsDQog
CS5jb25maWcgPSBtdGtfYWFsX2NvbmZpZywNCkBAIC0zNDYsNiArMzY4LDEyIEBAIHN0YXRpYyB2
b2lkIG10a19nYW1tYV9zZXQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCiAJLnN0b3AgPSBt
dGtfZ2FtbWFfc3RvcCwNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21w
X2Z1bmNzIGRkcF9wb3N0bWFzayA9IHsNCisJLmNvbmZpZyA9IG10a19wb3N0bWFza19jb25maWcs
DQorCS5zdGFydCA9IG10a19wb3N0bWFza19zdGFydCwNCisJLnN0b3AgPSBtdGtfcG9zdG1hc2tf
c3RvcCwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRk
cF9vZCA9IHsNCiAJLmNvbmZpZyA9IG10a19vZF9jb25maWcsDQogCS5zdGFydCA9IG10a19vZF9z
dGFydCwNCkBAIC0zNzIsNiArNDAwLDcgQEAgc3RhdGljIHZvaWQgbXRrX2dhbW1hX3NldChzdHJ1
Y3QgbXRrX2RkcF9jb21wICpjb21wLA0KIAlbTVRLX0RJU1BfTVVURVhdID0gIm11dGV4IiwNCiAJ
W01US19ESVNQX09EXSA9ICJvZCIsDQogCVtNVEtfRElTUF9CTFNdID0gImJscyIsDQorCVtNVEtf
RElTUF9QT1NUTUFTS10gPSAicG9zdG1hc2siLA0KIH07DQogDQogc3RydWN0IG10a19kZHBfY29t
cF9tYXRjaCB7DQpAQCAtNDAyLDYgKzQzMSw4IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXBfbWF0Y2gg
ew0KIAlbRERQX0NPTVBPTkVOVF9PVkxfMkwwXQk9IHsgTVRLX0RJU1BfT1ZMXzJMLAkwLCBOVUxM
IH0sDQogCVtERFBfQ09NUE9ORU5UX09WTF8yTDFdCT0geyBNVEtfRElTUF9PVkxfMkwsCTEsIE5V
TEwgfSwNCiAJW0REUF9DT01QT05FTlRfT1ZMXzJMMl0JPSB7IE1US19ESVNQX09WTF8yTCwJMiwg
TlVMTCB9LA0KKwlbRERQX0NPTVBPTkVOVF9QT1NUTUFTSzBdDQorCQkJCT0geyBNVEtfRElTUF9Q
T1NUTUFTSywJMCwgJmRkcF9wb3N0bWFzayB9LA0KIAlbRERQX0NPTVBPTkVOVF9QV00wXQk9IHsg
TVRLX0RJU1BfUFdNLAkwLCBOVUxMIH0sDQogCVtERFBfQ09NUE9ORU5UX1BXTTFdCT0geyBNVEtf
RElTUF9QV00sCTEsIE5VTEwgfSwNCiAJW0REUF9DT01QT05FTlRfUFdNMl0JPSB7IE1US19ESVNQ
X1BXTSwJMiwgTlVMTCB9LA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmggYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5oDQppbmRleCAxNjEyMDFmLi5hZTExYjQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KQEAgLTI5LDYgKzI5LDcgQEAgZW51bSBtdGtfZGRw
X2NvbXBfdHlwZSB7DQogCU1US19ESVNQX1VGT0UsDQogCU1US19EU0ksDQogCU1US19EUEksDQor
CU1US19ESVNQX1BPU1RNQVNLLA0KIAlNVEtfRElTUF9QV00sDQogCU1US19ESVNQX01VVEVYLA0K
IAlNVEtfRElTUF9PRCwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstbW1zeXMuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5oDQppbmRl
eCAyNjhkOTVhLi5jYzIyYzNlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLW1tc3lzLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5
cy5oDQpAQCAtMzEsNiArMzEsNyBAQCBlbnVtIG10a19kZHBfY29tcF9pZCB7DQogCUREUF9DT01Q
T05FTlRfT1ZMXzJMMSwNCiAJRERQX0NPTVBPTkVOVF9PVkxfMkwyLA0KIAlERFBfQ09NUE9ORU5U
X09WTDEsDQorCUREUF9DT01QT05FTlRfUE9TVE1BU0swLA0KIAlERFBfQ09NUE9ORU5UX1BXTTAs
DQogCUREUF9DT01QT05FTlRfUFdNMSwNCiAJRERQX0NPTVBPTkVOVF9QV00yLA0KLS0gDQoxLjgu
MS4xLmRpcnR5DQo=

