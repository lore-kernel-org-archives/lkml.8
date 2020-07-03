Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEAC433E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B275A20760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XSyYp1b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCEm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:42:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5179 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgGCEmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:54 -0400
X-UUID: d7807a0c0f8748ee935be528dd3fb0df-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7OUCGY7qnJsLItDGuh21VhCTR9xgtG5lZJHOKQLfyNA=;
        b=XSyYp1b16gV/Eokkz2GGlcOSm5Kxrz7pn3rrKvaZAafHGu6nRycLt3msdiLknC7EVEvPXCdlDOCmqd/mnRj0tnnJGSPreRcCw3IE7BAKKyHkHZays2j49CxPikh0DXYexgzAzh/5ivHi5d5cnf5pRqfA5FTO+anjy6yqLuLCAwE=;
X-UUID: d7807a0c0f8748ee935be528dd3fb0df-20200703
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1375007248; Fri, 03 Jul 2020 12:42:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:46 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:42 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 05/10] iommu/mediatek: Move inv_sel_reg into the plat_data
Date:   Fri, 3 Jul 2020 12:41:22 +0800
Message-ID: <20200703044127.27438-6-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG10Njc3OSwgTU1VX0lOVl9TRUwgcmVnaXN0ZXIncyBvZmZzZXQgaXMgY2hhbmdlZCBmcm9t
DQoweDM4IHRvIDB4MmMsIHNvIHdlIGNhbiBwdXQgaW52X3NlbF9yZWcgaW4gdGhlIHBsYXRfZGF0
YSB0bw0KdXNlIGl0Lg0KSW4gYWRkaXRpb24sIHdlIHJlbmFtZWQgaXQgdG8gUkVHX01NVV9JTlZf
U0VMX0dFTjEgYW5kIHVzZSBpdA0KYmVmb3JlIG10Njc3OS4NCg0KQ2M6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlh
dGVrLmNvbT4NClJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21h
aWwuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDkgKysrKysrLS0tDQog
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDIxOWQ3YWE2ZjA1
OS4uNTMzYjhmNzZmNTkyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0K
KysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTM3LDcgKzM3LDcgQEANCiAjZGVm
aW5lIFJFR19NTVVfSU5WTERfU1RBUlRfQQkJCTB4MDI0DQogI2RlZmluZSBSRUdfTU1VX0lOVkxE
X0VORF9BCQkJMHgwMjgNCiANCi0jZGVmaW5lIFJFR19NTVVfSU5WX1NFTAkJCQkweDAzOA0KKyNk
ZWZpbmUgUkVHX01NVV9JTlZfU0VMX0dFTjEJCQkweDAzOA0KICNkZWZpbmUgRl9JTlZMRF9FTjAJ
CQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCiANCkBAIC0xNzgsNyAr
MTc4LDcgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwodm9pZCAqY29va2ll
KQ0KIA0KIAlmb3JfZWFjaF9tNHUoZGF0YSkgew0KIAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZMRF9F
TjEgfCBGX0lOVkxEX0VOMCwNCi0JCQkgICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WX1NF
TCk7DQorCQkJICAgICAgIGRhdGEtPmJhc2UgKyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVn
KTsNCiAJCXdyaXRlbF9yZWxheGVkKEZfQUxMX0lOVkxELCBkYXRhLT5iYXNlICsgUkVHX01NVV9J
TlZBTElEQVRFKTsNCiAJCXdtYigpOyAvKiBNYWtlIHN1cmUgdGhlIHRsYiBmbHVzaCBhbGwgZG9u
ZSAqLw0KIAl9DQpAQCAtMTk1LDcgKzE5NSw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90bGJf
Zmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0KIAlmb3Jf
ZWFjaF9tNHUoZGF0YSkgew0KIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBm
bGFncyk7DQogCQl3cml0ZWxfcmVsYXhlZChGX0lOVkxEX0VOMSB8IEZfSU5WTERfRU4wLA0KLQkJ
CSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlZfU0VMKTsNCisJCQkgICAgICAgZGF0YS0+
YmFzZSArIGRhdGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0KIA0KIAkJd3JpdGVsX3JlbGF4
ZWQoaW92YSwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RBUlRfQSk7DQogCQl3cml0ZWxf
cmVsYXhlZChpb3ZhICsgc2l6ZSAtIDEsDQpAQCAtNzg0LDE4ICs3ODQsMjEgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIG10a19pb21tdV9wbV9vcHMgPSB7DQogc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KIAkubTR1X3BsYXQg
ICAgID0gTTRVX01UMjcxMiwNCiAJLmZsYWdzICAgICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19C
Q0xLIHwgSEFTX1ZMRF9QQV9STkcsDQorCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxf
R0VOMSwNCiAJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwN
CiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNf
ZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxNzMsDQogCS5mbGFncwkgICAgICA9
IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJLA0KKwkuaW52X3NlbF9yZWcgID0g
UkVHX01NVV9JTlZfU0VMX0dFTjEsDQogCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwg
NX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAgID0gTTRV
X01UODE4MywNCiAJLmZsYWdzICAgICAgICA9IFJFU0VUX0FYSSwNCisJLmludl9zZWxfcmVnICA9
IFJFR19NTVVfSU5WX1NFTF9HRU4xLA0KIAkubGFyYmlkX3JlbWFwID0gezAsIDQsIDUsIDYsIDcs
IDIsIDMsIDF9LA0KIH07DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
aCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IDUyMjVhOTE3MGFhYS4uY2Y1M2Y1
ZTgwZDIyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KKysrIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTQwLDYgKzQwLDcgQEAgZW51bSBtdGtfaW9tbXVf
cGxhdCB7DQogc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgew0KIAllbnVtIG10a19pb21tdV9w
bGF0IG00dV9wbGF0Ow0KIAl1MzIgICAgICAgICAgICAgICAgIGZsYWdzOw0KKwl1MzIgICAgICAg
ICAgICAgICAgIGludl9zZWxfcmVnOw0KIAl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1h
cFtNVEtfTEFSQl9OUl9NQVhdOw0KIH07DQogDQotLSANCjIuMTguMA0K

