Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B057C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0043220774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RfOQHU1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgE3INC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26156 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3INA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:00 -0400
X-UUID: b63df20561ea4050b73b0b2952e3ce3b-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xCqWi5z6+Xboewg72YASIv16teQ3+/TFq1FrFtej2K8=;
        b=RfOQHU1fv5UUkq8SuaR6jDUbZzp2s6doDwQ9yrLWgq/y8HyuW6XdQbNXJzGotupRADLgyiYiBmGzC7bS7o6uYOfMPBQX5ASohmVqjh7fmcVmwh/H5QnQoMly+07zk4LY+nJGoYkSZbTG6LF18Gm8FZ/no4y3MzXSByKZ5fQCiDc=;
X-UUID: b63df20561ea4050b73b0b2952e3ce3b-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1261379275; Sat, 30 May 2020 16:12:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:12:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:12:54 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 04/17] iommu/mediatek: Add device_link between the consumer and the larb devices
Date:   Sat, 30 May 2020 16:10:05 +0800
Message-ID: <1590826218-23653-5-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWFUZWsgSU9NTVUgZG9uJ3QgaGF2ZSBpdHMgcG93ZXItZG9tYWluLiBhbGwgdGhlIGNvbnN1
bWVyIGNvbm5lY3QNCndpdGggc21pLWxhcmIsIHRoZW4gY29ubmVjdCB3aXRoIHNtaS1jb21tb24u
DQoNCiAgICAgICAgTTRVDQogICAgICAgICB8DQogICAgc21pLWNvbW1vbg0KICAgICAgICAgfA0K
ICAtLS0tLS0tLS0tLS0tDQogIHwgICAgICAgICB8ICAgIC4uLg0KICB8ICAgICAgICAgfA0KbGFy
YjEgICAgIGxhcmIyDQogIHwgICAgICAgICB8DQp2ZGVjICAgICAgIHZlbmMNCg0KV2hlbiB0aGUg
Y29uc3VtZXIgd29ya3MsIGl0IHNob3VsZCBlbmFibGUgdGhlIHNtaS1sYXJiJ3MgcG93ZXIgd2hp
Y2gNCmFsc28gbmVlZCBlbmFibGUgdGhlIHNtaS1jb21tb24ncyBwb3dlciBmaXJzdGx5Lg0KDQpU
aHVzLCBGaXJzdCBvZiBhbGwsIHVzZSB0aGUgZGV2aWNlIGxpbmsgY29ubmVjdCB0aGUgY29uc3Vt
ZXIgYW5kIHRoZQ0Kc21pLWxhcmJzLiB0aGVuIGFkZCBkZXZpY2UgbGluayBiZXR3ZWVuIHRoZSBz
bWktbGFyYiBhbmQgc21pLWNvbW1vbi4NCg0KVGhpcyBwYXRjaCBhZGRzIGRldmljZV9saW5rIGJl
dHdlZW4gdGhlIGNvbnN1bWVyIGFuZCB0aGUgbGFyYnMuDQoNCldoZW4gZGV2aWNlX2xpbmtfYWRk
LCBJIGFkZCB0aGUgZmxhZyBETF9GTEFHX1NUQVRFTEVTUyB0byBhdm9pZCBjYWxsaW5nDQpwbV9y
dW50aW1lX3h4IHRvIGtlZXAgdGhlIG9yaWdpbmFsIHN0YXR1cyBvZiBjbG9ja3MuIEl0IGNhbiBh
dm9pZCB0d28NCmlzc3VlczoNCjEpIERpc3BsYXkgSFcgc2hvdyBmYXN0bG9nbyBhYm5vcm1hbGx5
IHJlcG9ydGVkIGluIFsxXS4gQXQgdGhlIGJlZ2dpbmluZywNCmFsbCB0aGUgY2xvY2tzIGFyZSBl
bmFibGVkIGJlZm9yZSBlbnRlcmluZyBrZXJuZWwsIGJ1dCB0aGUgY2xvY2tzIGZvcg0KZGlzcGxh
eSBIVyhhbHdheXMgaW4gbGFyYjApIHdpbGwgYmUgZ2F0ZWQgYWZ0ZXIgY2xrX2VuYWJsZSBhbmQg
Y2xrX2Rpc2FibGUNCmNhbGxlZCBmcm9tIGRldmljZV9saW5rX2FkZCgtPnBtX3J1bnRpbWVfcmVz
dW1lKSBhbmQgcnBtX2lkbGUuIFRoZSBjbG9jaw0Kb3BlcmF0aW9uIGhhcHBlbmVkIGJlZm9yZSBk
aXNwbGF5IGRyaXZlciBwcm9iZS4gQXQgdGhhdCB0aW1lLCB0aGUgZGlzcGxheQ0KSFcgd2lsbCBi
ZSBhYm5vcm1hbC4NCg0KMikgQSBkZWFkbG9jayBpc3N1ZSByZXBvcnRlZCBpbiBbMl0uIFVzZSBE
TF9GTEFHX1NUQVRFTEVTUyB0byBza2lwDQpwbV9ydW50aW1lX3h4IHRvIGF2b2lkIHRoZSBkZWFk
bG9jay4NCg0KQ29ycmVzcG9uZGluZywgRExfRkxBR19BVVRPUkVNT1ZFX0NPTlNVTUVSIGNhbid0
IGJlIGFkZGVkLCB0aGVuDQpkZXZpY2VfbGlua19yZW1vdmVkIHNob3VsZCBiZSBhZGRlZCBleHBs
aWNpdGx5Lg0KDQpbMV0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4
LW1lZGlhdGVrLzIwMTktSnVseS8NCjAyMTUwMC5odG1sDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEwODY1NjkvDQoNClN1Z2dlc3RlZC1ieTogVG9tYXN6IEZp
Z2EgPHRmaWdhQGNocm9taXVtLm9yZz4NClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICB8IDE4ICsr
KysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMgfCAyMCArKysr
KysrKysrKysrKysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDdkOGYzZDAuLjVjM2E2YmEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQpAQCAtNDQ1LDIyICs0NDUsNDAgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9kZXZpY2Ug
Km10a19pb21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0
IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KTsNCiAJc3Ry
dWN0IG10a19pb21tdV9kYXRhICpkYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7DQor
CXN0cnVjdCBkZXZpY2UgKmxhcmJkZXY7DQorCXVuc2lnbmVkIGludCBsYXJiaWQ7DQogDQogCWlm
ICghZndzcGVjIHx8IGZ3c3BlYy0+b3BzICE9ICZtdGtfaW9tbXVfb3BzKQ0KIAkJcmV0dXJuIEVS
Ul9QVFIoLUVOT0RFVik7IC8qIE5vdCBhIGlvbW11IGNsaWVudCBkZXZpY2UgKi8NCiANCiAJZGF0
YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KIA0KKwkvKiBMaW5rIHRoZSBjb25zdW1lciBk
ZXZpY2Ugd2l0aCB0aGUgc21pLWxhcmIgZGV2aWNlKHN1cHBsaWVyKSAqLw0KKwlsYXJiaWQgPSBN
VEtfTTRVX1RPX0xBUkIoZndzcGVjLT5pZHNbMF0pOw0KKwlsYXJiZGV2ID0gZGF0YS0+bGFyYl9p
bXVbbGFyYmlkXS5kZXY7DQorCWxpbmsgPSBkZXZpY2VfbGlua19hZGQoZGV2LCBsYXJiZGV2LA0K
KwkJCSAgICAgICBETF9GTEFHX1BNX1JVTlRJTUUgfCBETF9GTEFHX1NUQVRFTEVTUyk7DQorCWlm
ICghbGluaykNCisJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIGxpbmsgJXNcbiIsIGRldl9uYW1l
KGxhcmJkZXYpKTsNCiAJcmV0dXJuICZkYXRhLT5pb21tdTsNCiB9DQogDQogc3RhdGljIHZvaWQg
bXRrX2lvbW11X3JlbGVhc2VfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVj
dCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7DQorCXN0
cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YTsNCisJc3RydWN0IGRldmljZSAqbGFyYmRldjsNCisJ
dW5zaWduZWQgaW50IGxhcmJpZDsNCiANCiAJaWYgKCFmd3NwZWMgfHwgZndzcGVjLT5vcHMgIT0g
Jm10a19pb21tdV9vcHMpDQogCQlyZXR1cm47DQogDQorCWRhdGEgPSBkZXZfaW9tbXVfcHJpdl9n
ZXQoZGV2KTsNCisJbGFyYmlkID0gTVRLX000VV9UT19MQVJCKGZ3c3BlYy0+aWRzWzBdKTsNCisJ
bGFyYmRldiA9IGRhdGEtPmxhcmJfaW11W2xhcmJpZF0uZGV2Ow0KKwlkZXZpY2VfbGlua19yZW1v
dmUoZGV2LCBsYXJiZGV2KTsNCisNCiAJaW9tbXVfZndzcGVjX2ZyZWUoZGV2KTsNCiB9DQogDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11X3YxLmMNCmluZGV4IDAyODU4YTAuLjI2YjZjNzkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2lvbW11L210a19pb21tdV92MS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdV92
MS5jDQpAQCAtNDIyLDcgKzQyMiw5IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlICptdGtf
aW9tbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJc3RydWN0IG9mX3BoYW5k
bGVfYXJncyBpb21tdV9zcGVjOw0KIAlzdHJ1Y3Qgb2ZfcGhhbmRsZV9pdGVyYXRvciBpdDsNCiAJ
c3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhOw0KLQlpbnQgZXJyOw0KKwlzdHJ1Y3QgZGV2aWNl
X2xpbmsgKmxpbms7DQorCXN0cnVjdCBkZXZpY2UgKmxhcmJkZXY7DQorCWludCBlcnIsIGxhcmJp
ZDsNCiANCiAJb2ZfZm9yX2VhY2hfcGhhbmRsZSgmaXQsIGVyciwgZGV2LT5vZl9ub2RlLCAiaW9t
bXVzIiwNCiAJCQkiI2lvbW11LWNlbGxzIiwgLTEpIHsNCkBAIC00NDQsNiArNDQ2LDE0IEBAIHN0
YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlICptdGtfaW9tbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBk
ZXZpY2UgKmRldikNCiANCiAJZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KIA0KKwkv
KiBMaW5rIHRoZSBjb25zdW1lciBkZXZpY2Ugd2l0aCB0aGUgc21pLWxhcmIgZGV2aWNlKHN1cHBs
aWVyKSAqLw0KKwlsYXJiaWQgPSBtdDI3MDFfbTR1X3RvX2xhcmIoZndzcGVjLT5pZHNbMF0pOw0K
KwlsYXJiZGV2ID0gZGF0YS0+bGFyYl9pbXVbbGFyYmlkXS5kZXY7DQorCWxpbmsgPSBkZXZpY2Vf
bGlua19hZGQoZGV2LCBsYXJiZGV2LA0KKwkJCSAgICAgICBETF9GTEFHX1BNX1JVTlRJTUUgfCBE
TF9GTEFHX1NUQVRFTEVTUyk7DQorCWlmICghbGluaykNCisJCWRldl9lcnIoZGV2LCAiVW5hYmxl
IHRvIGxpbmsgJXNcbiIsIGRldl9uYW1lKGxhcmJkZXYpKTsNCisNCiAJcmV0dXJuICZkYXRhLT5p
b21tdTsNCiB9DQogDQpAQCAtNDY1LDEwICs0NzUsMTggQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11
X3Byb2JlX2ZpbmFsaXplKHN0cnVjdCBkZXZpY2UgKmRldikNCiBzdGF0aWMgdm9pZCBtdGtfaW9t
bXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGlvbW11
X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KTsNCisJc3RydWN0IG10
a19pb21tdV9kYXRhICpkYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlICpsYXJiZGV2Ow0KKwl1bnNpZ25l
ZCBpbnQgbGFyYmlkOw0KIA0KIAlpZiAoIWZ3c3BlYyB8fCBmd3NwZWMtPm9wcyAhPSAmbXRrX2lv
bW11X29wcykNCiAJCXJldHVybjsNCiANCisJZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYp
Ow0KKwlsYXJiaWQgPSBtdDI3MDFfbTR1X3RvX2xhcmIoZndzcGVjLT5pZHNbMF0pOw0KKwlsYXJi
ZGV2ID0gZGF0YS0+bGFyYl9pbXVbbGFyYmlkXS5kZXY7DQorCWRldmljZV9saW5rX3JlbW92ZShk
ZXYsIGxhcmJkZXYpOw0KKw0KIAlpb21tdV9md3NwZWNfZnJlZShkZXYpOw0KIH0NCiANCi0tIA0K
MS45LjENCg==

