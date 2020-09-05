Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A485C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C452078D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XvgW4L5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgIEIND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33662 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728465AbgIEIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:59 -0400
X-UUID: 714f0e8180064d5e9dfbe0eb5f4336b8-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vzf/IOctNEaxUcVyI0bSixh2bnyH5eoqKF1ExkxJzm4=;
        b=XvgW4L5xTmZPCMnGVk/uLo2i46HBuWJSlJLkIC1kpTZAxKeU1ILf3tnkpxdScS20ruUJKqnpO6ZTNglIH/JkvrmFIZxPY6+IXbMOw5b6wdCL2A7gH95UReyrzTCw0cL6+gRw5WhRnnGVj1B6XP9A2wuGu9OCdJxVsRR7nZDo334=;
X-UUID: 714f0e8180064d5e9dfbe0eb5f4336b8-20200905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1643018157; Sat, 05 Sep 2020 16:12:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:52 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 11/23] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
Date:   Sat, 5 Sep 2020 16:09:08 +0800
Message-ID: <20200905080920.13396-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0YW5kYXJkIGlucHV0IGlvdmEgYml0cyBpcyAzMi4gTWVkaWFUZWsgcXVhZCB0aGUgbHZs
MSBwYWdldGFibGUNCig0ICogbHZsMSkuIE5vIGNoYW5nZSBmb3IgbHZsMiBwYWdldGFibGUuIFRo
ZW4gdGhlIGlvdmEgYml0cyBjYW4gcmVhY2gNCjM0Yml0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25n
IFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJs
ZS1hcm0tdjdzLmMgfCAxMyArKysrKysrKysrLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyAgICAgICAgICB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFy
bS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCmluZGV4IDgzNjJm
ZGY3NjY1Ny4uMGU5N2NhOTc4YzA0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ3Rh
YmxlLWFybS12N3MuYw0KKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0K
QEAgLTUwLDEwICs1MCwxNyBAQA0KICAqLw0KICNkZWZpbmUgQVJNX1Y3U19BRERSX0JJVFMJCTMy
DQogI2RlZmluZSBfQVJNX1Y3U19MVkxfQklUUyhsdmwpCQkoMTYgLSAobHZsKSAqIDQpDQorLyog
TWVkaWFUZWs6IHRvdGFsbHkgMzRiaXRzLCAxNGJpdHMgYXQgbHZsMSBhbmQgOGJpdHMgYXQgbHZs
Mi4gKi8NCisjZGVmaW5lIF9BUk1fVjdTX0xWTF9CSVRTX01USyhsdmwpCSgyMCAtIChsdmwpICog
NikNCiAjZGVmaW5lIEFSTV9WN1NfTFZMX1NISUZUKGx2bCkJCShBUk1fVjdTX0FERFJfQklUUyAt
ICg0ICsgOCAqIChsdmwpKSkNCiAjZGVmaW5lIEFSTV9WN1NfVEFCTEVfU0hJRlQJCTEwDQogDQot
I2RlZmluZSBBUk1fVjdTX1BURVNfUEVSX0xWTChsdmwsIGNmZykJKDEgPDwgX0FSTV9WN1NfTFZM
X0JJVFMobHZsKSkNCisjZGVmaW5lIEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKQkoewkJ
CQlcDQorCWludCBfbCA9IGx2bDsJCQkJCQkJXA0KKwkhYXJtX3Y3c19pc19tdGtfZW5hYmxlZChj
ZmcpID8JCQkJCVwNCisJICgxIDw8IF9BUk1fVjdTX0xWTF9CSVRTKF9sKSkgOiAoMSA8PCBfQVJN
X1Y3U19MVkxfQklUU19NVEsoX2wpKTtcDQorfSkNCisNCiAjZGVmaW5lIEFSTV9WN1NfVEFCTEVf
U0laRShsdmwsIGNmZykJCQkJCVwNCiAJKEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKSAq
IHNpemVvZihhcm1fdjdzX2lvcHRlKSkNCiANCkBAIC02Myw3ICs3MCw3IEBADQogI2RlZmluZSBf
QVJNX1Y3U19JRFhfTUFTSyhsdmwsIGNmZykJKEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2Zn
KSAtIDEpDQogI2RlZmluZSBBUk1fVjdTX0xWTF9JRFgoYWRkciwgbHZsLCBjZmcpCSh7CQkJXA0K
IAlpbnQgX2wgPSBsdmw7CQkJCQkJCVwNCi0JKCh1MzIpKGFkZHIpID4+IEFSTV9WN1NfTFZMX1NI
SUZUKF9sKSkgJiBfQVJNX1Y3U19JRFhfTUFTSyhfbCwgY2ZnKTsgXA0KKwkoKGFkZHIpID4+IEFS
TV9WN1NfTFZMX1NISUZUKF9sKSkgJiBfQVJNX1Y3U19JRFhfTUFTSyhfbCwgY2ZnKTsgXA0KIH0p
DQogDQogLyoNCkBAIC03NTUsNyArNzYyLDcgQEAgc3RhdGljIHN0cnVjdCBpb19wZ3RhYmxlICph
cm1fdjdzX2FsbG9jX3BndGFibGUoc3RydWN0IGlvX3BndGFibGVfY2ZnICpjZmcsDQogew0KIAlz
dHJ1Y3QgYXJtX3Y3c19pb19wZ3RhYmxlICpkYXRhOw0KIA0KLQlpZiAoY2ZnLT5pYXMgPiBBUk1f
VjdTX0FERFJfQklUUykNCisJaWYgKGNmZy0+aWFzID4gKGFybV92N3NfaXNfbXRrX2VuYWJsZWQo
Y2ZnKSA/IDM0IDogQVJNX1Y3U19BRERSX0JJVFMpKQ0KIAkJcmV0dXJuIE5VTEw7DQogDQogCWlm
IChjZmctPm9hcyA+IChhcm1fdjdzX2lzX210a19lbmFibGVkKGNmZykgPyAzNSA6IEFSTV9WN1Nf
QUREUl9CSVRTKSkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggZjZhMmUzZWI1OWQyLi42ZTg1Yzk5NzZhMzMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQpAQCAtMzE2LDcgKzMxNiw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11
X2RvbWFpbl9maW5hbGlzZShzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9tKQ0KIAkJCUlPX1BH
VEFCTEVfUVVJUktfVExCSV9PTl9NQVAgfA0KIAkJCUlPX1BHVEFCTEVfUVVJUktfQVJNX01US19F
WFQsDQogCQkucGdzaXplX2JpdG1hcCA9IG10a19pb21tdV9vcHMucGdzaXplX2JpdG1hcCwNCi0J
CS5pYXMgPSAzMiwNCisJCS5pYXMgPSAzNCwNCiAJCS5vYXMgPSAzNSwNCiAJCS50bGIgPSAmbXRr
X2lvbW11X2ZsdXNoX29wcywNCiAJCS5pb21tdV9kZXYgPSBkYXRhLT5kZXYsDQotLSANCjIuMTgu
MA0K

