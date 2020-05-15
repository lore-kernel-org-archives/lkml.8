Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163CA207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fBojTk2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEOIKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:10:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2295 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgEOIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:10:18 -0400
X-UUID: aaadb563fd2a4076ad9ae7debebafb43-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=SnHDXWhq13xkpGV5Y45+FAXrSStxnyI/+HVQz04AZ8A=;
        b=fBojTk2DxPktUP23pOO4TfvbwyleUQOuKl7YxSW0Ac0PofkKjTTEFgBtILTqUoNRQ94VE87st62W4Oayc4xx3L6IwYQtX5isjHrIel3iEkF6jXVsZQISpD9MkUP+yzGJSgsOeKOiDuMSR017PR3YiPAODC85KvLm9WfcDNjsoHg=;
X-UUID: aaadb563fd2a4076ad9ae7debebafb43-20200515
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1828095223; Fri, 15 May 2020 16:10:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 16:10:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 16:10:10 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>
Subject: [PATCH] iommu/mediatek-v1: Add def_domain_type
Date:   Fri, 15 May 2020 16:08:43 +0800
Message-ID: <1589530123-30240-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIE1lZGlhVGVrIFYxIElPTU1VIGlzIGFybTMyIHdob3NlIGRlZmF1bHQgZG9tYWluIHR5cGUg
aXMNCklPTU1VX0RPTUFJTl9VTk1BTkFHRUQuIEFkZCB0aGlzIHRvIHNhdGlzZnkgdGhlIGJ1c19p
b21tdV9wcm9iZSB0bw0KZW50ZXIgInByb2JlX2ZpbmFsaXplIi4NCg0KVGhlIGlvbW11IGZyYW1l
d29yayB3aWxsIGNyZWF0ZSBhIGlvbW11IGRvbWFpbiBmb3IgZWFjaCBhIGRldmljZS4NCkJ1dCBh
bGwgdGhlIGRldmljZXMgc2hhcmUgYSBpb21tdSBkb21haW4gaGVyZSwgdGh1cyB3ZSBza2lwIGFs
bCB0aGUNCm90aGVyIGRvbWFpbnMgaW4gdGhlICJhdHRhY2hfZGV2aWNlIiBleGNlcHQgdGhlIGRv
bWFpbiB3ZSBjcmVhdGUNCmludGVybmFsbHkgd2l0aCBhcm1faW9tbXVfY3JlYXRlX21hcHBpbmcu
DQoNCkFsc28gYSBtaW5vciBjaGFuZ2U6IGluIHRoZSBhdHRhY2hfZGV2aWNlLCAiZGF0YSIgYWx3
YXlzIGlzIG5vdCBudWxsLg0KUmVtb3ZlICJpZiAoIWRhdGEpIHJldHVybiIuDQoNClNpZ25lZC1v
ZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQphLiByZWJhc2Ugb24g
bGludXgtbmV4dC4NCmIuIEFmdGVyIHRoaXMgcGF0Y2ggYW5kIGZpeGVkIHRoZSBtdXRleCBpc3N1
ZShsb2NhbGx5IEkgb25seSBtb3ZlDQogICBtdXRleF91bmxvY2soJmdyb3VwLT5tdXRleCkgYmVm
b3JlIF9faW9tbXVfZ3JvdXBfZG1hX2F0dGFjaChncm91cCkpLA0KICAgdGhlIG10a19pb21tdV92
MS5jIGNvdWxkIHdvcmsgbm9ybWFsbHkuDQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdV92
MS5jIHwgMTYgKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXVfdjEuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMNCmluZGV4IDdiZGQ3NGMuLmYz
NTNiMDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdV92MS5jDQpAQCAtMjY1LDEwICsyNjUsMTMgQEAgc3RhdGlj
IGludCBtdGtfaW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4s
DQogew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQo
ZGV2KTsNCiAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9t
YWluKTsNCisJc3RydWN0IGRtYV9pb21tdV9tYXBwaW5nICptdGtfbWFwcGluZzsNCiAJaW50IHJl
dDsNCiANCi0JaWYgKCFkYXRhKQ0KLQkJcmV0dXJuIC1FTk9ERVY7DQorCS8qIE9ubHkgYWxsb3cg
dGhlIGRvbWFpbiBjcmVhdGVkIGludGVybmFsbHkuICovDQorCW10a19tYXBwaW5nID0gZGF0YS0+
ZGV2LT5hcmNoZGF0YS5pb21tdTsNCisJaWYgKG10a19tYXBwaW5nLT5kb21haW4gIT0gZG9tYWlu
KQ0KKwkJcmV0dXJuIDA7DQogDQogCWlmICghZGF0YS0+bTR1X2RvbSkgew0KIAkJZGF0YS0+bTR1
X2RvbSA9IGRvbTsNCkBAIC0yODgsOSArMjkxLDYgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X2Rl
dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KIHsNCiAJc3RydWN0IG10
a19pb21tdV9kYXRhICpkYXRhID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7DQogDQotCWlmICgh
ZGF0YSkNCi0JCXJldHVybjsNCi0NCiAJbXRrX2lvbW11X2NvbmZpZyhkYXRhLCBkZXYsIGZhbHNl
KTsNCiB9DQogDQpAQCAtNDE2LDYgKzQxNiwxMSBAQCBzdGF0aWMgaW50IG10a19pb21tdV9jcmVh
dGVfbWFwcGluZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0
aWMgaW50IG10a19pb21tdV9kZWZfZG9tYWluX3R5cGUoc3RydWN0IGRldmljZSAqZGV2KQ0KK3sN
CisJcmV0dXJuIElPTU1VX0RPTUFJTl9VTk1BTkFHRUQ7DQorfQ0KKw0KIHN0YXRpYyBzdHJ1Y3Qg
aW9tbXVfZGV2aWNlICptdGtfaW9tbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikN
CiB7DQogCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNfZ2V0
KGRldik7DQpAQCAtNTI1LDYgKzUzMCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQo
Y29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KIAkucHJvYmVfZGV2aWNlCT0gbXRr
X2lvbW11X3Byb2JlX2RldmljZSwNCiAJLnByb2JlX2ZpbmFsaXplID0gbXRrX2lvbW11X3Byb2Jl
X2ZpbmFsaXplLA0KIAkucmVsZWFzZV9kZXZpY2UJPSBtdGtfaW9tbXVfcmVsZWFzZV9kZXZpY2Us
DQorCS5kZWZfZG9tYWluX3R5cGUgPSBtdGtfaW9tbXVfZGVmX2RvbWFpbl90eXBlLA0KIAkuZGV2
aWNlX2dyb3VwCT0gZ2VuZXJpY19kZXZpY2VfZ3JvdXAsDQogCS5wZ3NpemVfYml0bWFwCT0gfjBV
TCA8PCBNVDI3MDFfSU9NTVVfUEFHRV9TSElGVCwNCiB9Ow0KLS0gDQoxLjkuMQ0K

