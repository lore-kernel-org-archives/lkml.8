Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CDC28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17347208B3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vDafAjZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgIDKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:41:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12202 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730180AbgIDKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:40:50 -0400
X-UUID: 64c71c1da95b41f5851dc5712fe4fbac-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+foNOXIgIh1kuuS1RTWqR7W2PgiV9fXKECaUSNGOkmY=;
        b=vDafAjZhBr9b/kXzS0qNaq3RDs99RuSW6YrpiKIdChoe8TQO7mt2uBDWk+92uM/+9gZRLjnCkoK6zbTx7aXf8zJ6bIjOkKKERyhmYW+6RE67OHhLNhhO1V9nTG5Jk4l8BlQ3Tc1vBujjLyDBio9VvAMZDQgF2oAg6W/8mkwIDus=;
X-UUID: 64c71c1da95b41f5851dc5712fe4fbac-20200904
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 789402017; Fri, 04 Sep 2020 18:40:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 18:40:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 18:40:37 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>
Subject: [RESEND PATCHv5] iommu/mediatek: check 4GB mode by reading infracfg
Date:   Fri, 4 Sep 2020 18:40:38 +0800
Message-ID: <20200904104038.4979-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gcHJldmlvdXMgZGlzY3Vzc2lvbiBbMV0gYW5kIFsyXSwgd2UgZm91bmQgdGhhdCBpdCBpcyBy
aXNreSB0bw0KdXNlIG1heF9wZm4gb3IgdG90YWxyYW1fcGFnZXMgdG8gdGVsbCBpZiA0R0IgbW9k
ZSBpcyBlbmFibGVkLg0KDQpDaGVjayA0R0IgbW9kZSBieSByZWFkaW5nIGluZnJhY2ZnIHJlZ2lz
dGVyLCByZW1vdmUgdGhlIHVzYWdlDQpvZiB0aGUgdW4tZXhwb3J0ZWQgc3ltYm9sIG1heF9wZm4u
DQoNClRoaXMgaXMgYSBzdGVwIHRvd2FyZHMgYnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVs
IG1vZHVsZS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA2MDMxNjEx
MzIuMjQ0MS0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tLw0KWzJdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMDA2MDQwODAxMjAuMjYyOC0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29t
Lw0KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA3MTUyMDUxMjAuR0E3Nzg4
NzZAYm9ndXMvDQoNCkNjOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQpDYzog
RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQpDYzogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQpDYzogWWluZ2pvZSBDaGVuIDx5aW5nam9lLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KQ2M6IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCkNjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NClJldmlld2VkLWJ5
OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1i
eTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQoNCi0tLQ0KDQpDaGFuZ2Ug
c2luY2UgdjQNCi0gcmVtb3ZlIHVubmVjZXNzYXJ5IGRhdGEtPmVuYWJsZV80R0IgPSBmYWxzZSwg
c2luY2UgaXQgaXMga3phbGxvYygpZWQuDQoNCkNoYW5nZSBzaW5jZSB2Mw0KLSB1c2UgbG9yZS5r
ZXJuZWwub3JnIGxpbmtzDQotIG1vdmUgImNoYW5nZSBzaW5jZS4uLiIgYWZ0ZXIgIi0tLSINCg0K
Q2hhbmdlIHNpbmNlIHYyOg0KLSBkZXRlcm1pbmUgY29tcGF0aWJsZSBzdHJpbmcgYnkgbTR1X3Bs
YXQNCi0gcmViYXNlIHRvIG5leHQtMjAyMDA3MjANCi0gYWRkICItLS0iDQoNCkNoYW5nZSBzaW5j
ZSB2MToNCi0gcmVtb3ZlIHRoZSBwaGFuZGxlIHVzYWdlLCBzZWFyY2ggZm9yIGluZnJhY2ZnIGlu
c3RlYWQgWzNdDQotIHVzZSBpbmZyYWNmZyBpbnN0ZWFkIG9mIGluZnJhY2ZnX3JlZ21hcA0KLSBt
b3ZlIGluZnJhY2ZnIGRlZmluaXRhaW9ucyB0byBsaW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcu
aA0KLSB1cGRhdGUgZW5hYmxlXzRHQiBvbmx5IHdoZW4gaGFzXzRnYl9tb2RlDQotLS0NCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5jICAgICAgICAgICAgIHwgMzMgKysrKysrKysrKysrKysrKysr
KysrKystLS0tDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCB8ICAzICsr
Kw0KIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQppbmRleCA3ODViMjI4ZDM5YTYuLmU3YjhiMmJiMDhhOSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMNCkBAIC0zLDcgKzMsNiBAQA0KICAqIENvcHlyaWdodCAoYykgMjAxNS0yMDE2IE1lZGlhVGVr
IEluYy4NCiAgKiBBdXRob3I6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KICAqLw0K
LSNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9idWcuaD4NCiAj
aW5jbHVkZSA8bGludXgvY2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KQEAg
LTE1LDEzICsxNCwxNiBAQA0KICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KICNpbmNsdWRlIDxs
aW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0KKyNpbmNsdWRlIDxsaW51
eC9tZmQvc3lzY29uLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVk
ZSA8bGludXgvb2ZfaW9tbXUuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQogI2luY2x1
ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5o
Pg0KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KKyNpbmNsdWRlIDxsaW51eC9zb2MvbWVk
aWF0ZWsvaW5mcmFjZmcuaD4NCiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCiAjaW5jbHVkZSA8
c29jL21lZGlhdGVrL3NtaS5oPg0KIA0KQEAgLTY0MCw4ICs2NDIsMTEgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IHJl
c291cmNlICAgICAgICAgKnJlczsNCiAJcmVzb3VyY2Vfc2l6ZV90CQlpb2FkZHI7DQogCXN0cnVj
dCBjb21wb25lbnRfbWF0Y2ggICptYXRjaCA9IE5VTEw7DQorCXN0cnVjdCByZWdtYXAJCSppbmZy
YWNmZzsNCiAJdm9pZCAgICAgICAgICAgICAgICAgICAgKnByb3RlY3Q7DQogCWludCAgICAgICAg
ICAgICAgICAgICAgIGksIGxhcmJfbnIsIHJldDsNCisJdTMyCQkJdmFsOw0KKwljaGFyICAgICAg
ICAgICAgICAgICAgICAqcDsNCiANCiAJZGF0YSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigq
ZGF0YSksIEdGUF9LRVJORUwpOw0KIAlpZiAoIWRhdGEpDQpAQCAtNjU1LDEwICs2NjAsMjggQEAg
c3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
CiAJCXJldHVybiAtRU5PTUVNOw0KIAlkYXRhLT5wcm90ZWN0X2Jhc2UgPSBBTElHTih2aXJ0X3Rv
X3BoeXMocHJvdGVjdCksIE1US19QUk9URUNUX1BBX0FMSUdOKTsNCiANCi0JLyogV2hldGhlciB0
aGUgY3VycmVudCBkcmFtIGlzIG92ZXIgNEdCICovDQotCWRhdGEtPmVuYWJsZV80R0IgPSAhISht
YXhfcGZuID4gKEJJVF9VTEwoMzIpID4+IFBBR0VfU0hJRlQpKTsNCi0JaWYgKCFNVEtfSU9NTVVf
SEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfNEdCX01PREUpKQ0KLQkJZGF0YS0+ZW5hYmxl
XzRHQiA9IGZhbHNlOw0KKwlpZiAoTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0YSwg
SEFTXzRHQl9NT0RFKSkgew0KKwkJc3dpdGNoIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0KSB7
DQorCQljYXNlIE00VV9NVDI3MTI6DQorCQkJcCA9ICJtZWRpYXRlayxtdDI3MTItaW5mcmFjZmci
Ow0KKwkJCWJyZWFrOw0KKwkJY2FzZSBNNFVfTVQ4MTczOg0KKwkJCXAgPSAibWVkaWF0ZWssbXQ4
MTczLWluZnJhY2ZnIjsNCisJCQlicmVhazsNCisJCWRlZmF1bHQ6DQorCQkJcCA9IE5VTEw7DQor
CQl9DQorDQorCQlpbmZyYWNmZyA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2NvbXBhdGlibGUo
cCk7DQorDQorCQlpZiAoSVNfRVJSKGluZnJhY2ZnKSkNCisJCQlyZXR1cm4gUFRSX0VSUihpbmZy
YWNmZyk7DQorDQorCQlyZXQgPSByZWdtYXBfcmVhZChpbmZyYWNmZywgUkVHX0lORlJBX01JU0Ms
ICZ2YWwpOw0KKwkJaWYgKHJldCkNCisJCQlyZXR1cm4gcmV0Ow0KKwkJZGF0YS0+ZW5hYmxlXzRH
QiA9ICEhKHZhbCAmIEZfRERSXzRHQl9TVVBQT1JUX0VOKTsNCisJfQ0KIA0KIAlyZXMgPSBwbGF0
Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KIAlkYXRhLT5iYXNl
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvaW5mcmFjZmcuaA0KaW5kZXggZmQyNWYwMTQ4NTY2Li4yMzM0NjNkNzg5YzYgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQorKysgYi9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQpAQCAtMzIsNiArMzIsOSBAQA0KICNkZWZp
bmUgTVQ3NjIyX1RPUF9BWElfUFJPVF9FTl9XQgkJKEJJVCgyKSB8IEJJVCg2KSB8IFwNCiAJCQkJ
CQkgQklUKDcpIHwgQklUKDgpKQ0KIA0KKyNkZWZpbmUgUkVHX0lORlJBX01JU0MJCQkJMHhmMDAN
CisjZGVmaW5lIEZfRERSXzRHQl9TVVBQT1JUX0VOCQkJQklUKDEzKQ0KKw0KIGludCBtdGtfaW5m
cmFjZmdfc2V0X2J1c19wcm90ZWN0aW9uKHN0cnVjdCByZWdtYXAgKmluZnJhY2ZnLCB1MzIgbWFz
aywNCiAJCWJvb2wgcmVnX3VwZGF0ZSk7DQogaW50IG10a19pbmZyYWNmZ19jbGVhcl9idXNfcHJv
dGVjdGlvbihzdHJ1Y3QgcmVnbWFwICppbmZyYWNmZywgdTMyIG1hc2ssDQotLSANCjIuMTguMA0K

