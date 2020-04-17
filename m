Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0763C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C542063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Miljsmve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDQFXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:23:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39853 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbgDQFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:23:22 -0400
X-UUID: 082516a55c7a46cdb85202acfad585f0-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+zpT5B2IshhZ214mCSGdW/SvpDv7hKMz1rnXfEoTBUc=;
        b=MiljsmvesNAjTzcryn9BOY90EuXWSeTKVZOhLQHv7FCngg8UuCptbyLct3iyvUjQHsqjcgpWRhvQ7ZVVyvIiOt+Merq6p1BTp4CRTecvj1MfPUc1KF5Qbc/GxzTWtJV2dViDX0pLO7hRup40IQzF1hJUtVNaeymY3tKxv0bB9x8=;
X-UUID: 082516a55c7a46cdb85202acfad585f0-20200417
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1199223011; Fri, 17 Apr 2020 13:23:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 13:23:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 13:23:12 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Min Guo <min.Guo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH 2/2] phy: phy-mtk-tphy: introduce force_vbus for u2 phy
Date:   Fri, 17 Apr 2020 13:23:06 +0800
Message-ID: <1587100986-3104-2-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
References: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E815C42225B82684929207EFF6F91564BF86715E507A584A4955B6A5F960DCE12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNvbWUgcGxhdGZvcm1zLCB0aGV5IGRvbid0IGhhdmUgdmJ1cyBwaW4gY29ubmVjdGlvbiBi
ZXR3ZWVuIHVzYiBwaHkgYW5kDQptYWMuIEhlbmNlIHdlIG5lZWQgdG8gY29udHJvbCBmb3JjZV92
YnVzIHJlbGF0ZWQgcmVnaXN0ZXJzIHRvIGtlZXAgaGFyZHdhcmUNCndvcmtzIG5vcm1hbC4NClRo
aXMgcGF0Y2ggYWRkIGNvcnJlc3BvbmRpbmcgYmVoYXZpb3Igb2YgZm9yY2UgdmJ1cyBpbiB1MiBw
aHkgcmVsYXRlZA0KZnVuY3Rpb25zLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFj
cGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10
ay10cGh5LmMgfCAxNiArKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlh
dGVrL3BoeS1tdGstdHBoeS5jIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMN
CmluZGV4IGNkYmNjNDlmNzExNS4uNDZmMGZlYTE3NWU1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9w
aHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMNCisrKyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstdHBoeS5jDQpAQCAtOTksNiArOTksNyBAQA0KIA0KICNkZWZpbmUgVTNQX1UyUEhZRFRN
MQkJMHgwNkMNCiAjZGVmaW5lIFAyQ19SR19VQVJUX0VOCQkJQklUKDE2KQ0KKyNkZWZpbmUgUDJD
X0ZPUkNFX1ZCVVNWQUxJRAkJQklUKDEzKQ0KICNkZWZpbmUgUDJDX0ZPUkNFX0lERElHCQlCSVQo
OSkNCiAjZGVmaW5lIFAyQ19SR19WQlVTVkFMSUQJCUJJVCg1KQ0KICNkZWZpbmUgUDJDX1JHX1NF
U1NFTkQJCQlCSVQoNCkNCkBAIC0zMTgsNiArMzE5LDcgQEAgc3RydWN0IG10a190cGh5IHsNCiAJ
aW50IG5waHlzOw0KIAlpbnQgc3JjX3JlZl9jbGs7IC8qIE1IWiwgcmVmZXJlbmNlIGNsb2NrIGZv
ciBzbGV3IHJhdGUgY2FsaWJyYXRlICovDQogCWludCBzcmNfY29lZjsgLyogY29lZmZpY2llbnQg
Zm9yIHNsZXcgcmF0ZSBjYWxpYnJhdGUgKi8NCisJYm9vbCBmb3JjZV92YnVzOw0KIH07DQogDQog
c3RhdGljIHZvaWQgaHNfc2xld19yYXRlX2NhbGlicmF0ZShzdHJ1Y3QgbXRrX3RwaHkgKnRwaHks
DQpAQCAtNjExLDEzICs2MTMsMjAgQEAgc3RhdGljIHZvaWQgdTJfcGh5X2luc3RhbmNlX3NldF9t
b2RlKHN0cnVjdCBtdGtfdHBoeSAqdHBoeSwNCiAJc3dpdGNoIChtb2RlKSB7DQogCWNhc2UgUEhZ
X01PREVfVVNCX0RFVklDRToNCiAJCXRtcCB8PSBQMkNfRk9SQ0VfSURESUcgfCBQMkNfUkdfSURE
SUc7DQorCQlpZiAodHBoeS0+Zm9yY2VfdmJ1cykNCisJCQl0bXAgfD0gUDJDX1JHX1ZCVVNWQUxJ
RCB8IFAyQ19GT1JDRV9WQlVTVkFMSUQ7DQogCQlicmVhazsNCiAJY2FzZSBQSFlfTU9ERV9VU0Jf
SE9TVDoNCiAJCXRtcCB8PSBQMkNfRk9SQ0VfSURESUc7DQotCQl0bXAgJj0gflAyQ19SR19JRERJ
RzsNCisJCWlmICh0cGh5LT5mb3JjZV92YnVzKQ0KKwkJCXRtcCAmPSB+KFAyQ19SR19WQlVTVkFM
SUQgfCBQMkNfRk9SQ0VfVkJVU1ZBTElEKTsNCisJCWVsc2UNCisJCQl0bXAgJj0gflAyQ19SR19J
RERJRzsNCiAJCWJyZWFrOw0KIAljYXNlIFBIWV9NT0RFX1VTQl9PVEc6DQogCQl0bXAgJj0gfihQ
MkNfRk9SQ0VfSURESUcgfCBQMkNfUkdfSURESUcpOw0KKwkJaWYgKHRwaHktPmZvcmNlX3ZidXMp
DQorCQkJdG1wICY9IH4oUDJDX1JHX1ZCVVNWQUxJRCB8IFAyQ19GT1JDRV9WQlVTVkFMSUQpOw0K
IAkJYnJlYWs7DQogCWRlZmF1bHQ6DQogCQlyZXR1cm47DQpAQCAtMTE4Nyw2ICsxMTk2LDExIEBA
IHN0YXRpYyBpbnQgbXRrX3RwaHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJCQlyZXR2YWwgPSBQVFJfRVJSKGluc3RhbmNlLT5kYV9yZWZfY2xrKTsNCiAJCQlnb3RvIHB1
dF9jaGlsZDsNCiAJCX0NCisNCisJCS8qDQorCQkgKiBPbiBzb21lIHBsYXRmb3JtLCB2YnVzIGlz
IGRpcy1jb25uZWN0ZWQgYmV0d2VlbiBQSFkgYW5kIE1BQy4NCisJCSAqLw0KKwkJdHBoeS0+Zm9y
Y2VfdmJ1cyA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LCAiZm9yY2VfdmJ1cyIpOw0K
IAl9DQogDQogCXByb3ZpZGVyID0gZGV2bV9vZl9waHlfcHJvdmlkZXJfcmVnaXN0ZXIoZGV2LCBt
dGtfcGh5X3hsYXRlKTsNCi0tIA0KMi4xOC4wDQo=

