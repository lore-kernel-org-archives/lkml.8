Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F80C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FAA20760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ahZe316A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGBJhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:37:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21681 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726475AbgGBJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:37:30 -0400
X-UUID: eaf6688f8280499c981c850801bb6627-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=srCB5XNrPlYp3HSyZlphU1Xk3HZN3j+BE4+7DogmQy4=;
        b=ahZe316AlRZVKQKpFx8qUSc/9KwNv7eR2m1bhZOhhjy6zwuLS5q+raAqLi/BoTImAln0PWbNIjDX7IHcp22NJbaIwMKQUVQc9J1Xz62N6T4OOMn2ow53jX8ezYmiJGQ5lCKrPDqltBkogMYronch5CCTtYAJxo+7v/X3XvqQyFQ=;
X-UUID: eaf6688f8280499c981c850801bb6627-20200702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1895597495; Thu, 02 Jul 2020 17:37:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 17:37:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 17:37:21 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Thu, 2 Jul 2020 17:37:20 +0800
Message-ID: <20200702093721.6063-4-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200702093721.6063-1-miles.chen@mediatek.com>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A048809BF75A2565D4E6E6BBA7AA1D99F242281B24CA77BCBD8A0D61FB421EA72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gcHJldmlvdXMgZGlzc2N1c2lvbiBbMV0gYW5kIFsyXSwgd2UgZm91bmQgdGhhdCBpdCBpcyBy
aXNreSB0bw0KdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8gdGVsbCBpZiA0R0IgbW9k
ZSBpcyBlbmFibGVkLg0KDQpDaGVjayA0R0IgbW9kZSBieSByZWFkaW5nIGluZnJhY2ZnIHJlZ2lz
dGVyLCByZW1vdmUgdGhlIHVzYWdlDQpvZiB0aGUgdW5leHBvcnRlZCBzeW1ib2wgbWF4X3Bmbi4N
Cg0KWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzYvMy83MzMNClsyXSBodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC82LzQvMTM2DQoNCkNjOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4
LmlibS5jb20+DQpDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQpDYzog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQpDYzogWWluZ2pvZSBDaGVuIDx5aW5nam9l
LmNoZW5AbWVkaWF0ZWsuY29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
U2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCmluZGV4IDJiZTk2ZjFjZGJkMi4uMDliZTU3YmQ4ZDc0IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0K
QEAgLTMsNyArMyw2IEBADQogICogQ29weXJpZ2h0IChjKSAyMDE1LTIwMTYgTWVkaWFUZWsgSW5j
Lg0KICAqIEF1dGhvcjogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQogICovDQotI2lu
Y2x1ZGUgPGxpbnV4L21lbWJsb2NrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2J1Zy5oPg0KICNpbmNs
dWRlIDxsaW51eC9jbGsuaD4NCiAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQpAQCAtMTUs
MTEgKzE0LDEzIEBADQogI2luY2x1ZGUgPGxpbnV4L2lvbW11Lmg+DQogI2luY2x1ZGUgPGxpbnV4
L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L21m
ZC9zeXNjb24uaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KICNpbmNsdWRlIDxs
aW51eC9vZl9pb21tdS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCiAjaW5jbHVkZSA8
bGludXgvb2ZfcGxhdGZvcm0uaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
DQorI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQog
I2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQogI2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQpA
QCAtOTEsNiArOTIsOSBAQA0KICNkZWZpbmUgRl9NTVVfSU5UX0lEX0xBUkJfSUQoYSkJCQkoKChh
KSA+PiA3KSAmIDB4NykNCiAjZGVmaW5lIEZfTU1VX0lOVF9JRF9QT1JUX0lEKGEpCQkJKCgoYSkg
Pj4gMikgJiAweDFmKQ0KIA0KKyNkZWZpbmUgUkVHX0lORlJBX01JU0MJCQkJMHhmMDANCisjZGVm
aW5lIEZfRERSXzRHQl9TVVBQT1JUX0VOCQkJQklUKDEzKQ0KKw0KICNkZWZpbmUgTVRLX1BST1RF
Q1RfUEFfQUxJR04JCQkxMjgNCiANCiAvKg0KQEAgLTU5OSw4ICs2MDMsMTAgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0
IHJlc291cmNlICAgICAgICAgKnJlczsNCiAJcmVzb3VyY2Vfc2l6ZV90CQlpb2FkZHI7DQogCXN0
cnVjdCBjb21wb25lbnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7DQorCXN0cnVjdCByZWdtYXAJCSpp
bmZyYWNmZ19yZWdtYXA7DQogCXZvaWQgICAgICAgICAgICAgICAgICAgICpwcm90ZWN0Ow0KIAlp
bnQgICAgICAgICAgICAgICAgICAgICBpLCBsYXJiX25yLCByZXQ7DQorCXUzMgkJCXZhbDsNCiAN
CiAJZGF0YSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZGF0YSksIEdGUF9LRVJORUwpOw0K
IAlpZiAoIWRhdGEpDQpAQCAtNjE0LDEwICs2MjAsMTggQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCXJldHVybiAtRU5PTUVNOw0K
IAlkYXRhLT5wcm90ZWN0X2Jhc2UgPSBBTElHTih2aXJ0X3RvX3BoeXMocHJvdGVjdCksIE1US19Q
Uk9URUNUX1BBX0FMSUdOKTsNCiANCi0JLyogV2hldGhlciB0aGUgY3VycmVudCBkcmFtIGlzIG92
ZXIgNEdCICovDQotCWRhdGEtPmVuYWJsZV80R0IgPSAhIShtYXhfcGZuID4gKEJJVF9VTEwoMzIp
ID4+IFBBR0VfU0hJRlQpKTsNCi0JaWYgKCFkYXRhLT5wbGF0X2RhdGEtPmhhc180Z2JfbW9kZSkN
CisJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzXzRnYl9tb2RlKSB7DQorCQlpbmZyYWNmZ19yZWdt
YXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKGRldi0+b2Zfbm9kZSwNCisJCQkJ
Im1lZGlhdGVrLGluZnJhY2ZnIik7DQorCQlpZiAoSVNfRVJSKGluZnJhY2ZnX3JlZ21hcCkpDQor
CQkJcmV0dXJuIFBUUl9FUlIoaW5mcmFjZmdfcmVnbWFwKTsNCisJCXJldCA9IHJlZ21hcF9yZWFk
KGluZnJhY2ZnX3JlZ21hcCwgUkVHX0lORlJBX01JU0MsICZ2YWwpOw0KKwkJaWYgKHJldCkNCisJ
CQlyZXR1cm4gcmV0Ow0KKwkJZGF0YS0+ZW5hYmxlXzRHQiA9ICEhKHZhbCAmIEZfRERSXzRHQl9T
VVBQT1JUX0VOKTsNCisJfSBlbHNlIHsNCiAJCWRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZTsNCisJ
fQ0KIA0KIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0s
IDApOw0KIAlkYXRhLT5iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCi0t
IA0KMi4xOC4wDQo=

