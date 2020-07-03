Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D2220760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CL+hVcQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGCEnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:43:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32643 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgGCEnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:43:00 -0400
X-UUID: c714dccfbcbc42028b2540368722e630-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8qMmwM2uoxTxvPWDvQpY/SHOtQPS3rAHZGZciSo8HQ4=;
        b=CL+hVcQ6FWtGawwo7GzH/XBsh4DqzR/8CG0msMyMgqzgfsaigX/DmMlA7WC9drZgCd8uvW/bokjV6pMjjg+Qe4TjxEBrjxmGcBOXl4JddDzNDkSMcBrE1bdayCJ77cnUlMF4nx3FDCMHEzu7fDRblmiZlX1exhb/xBsHe4nUlbo=;
X-UUID: c714dccfbcbc42028b2540368722e630-20200703
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 114306700; Fri, 03 Jul 2020 12:42:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:44 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:40 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 04/10] iommu/mediatek: Setting MISC_CTRL register
Date:   Fri, 3 Jul 2020 12:41:21 +0800
Message-ID: <20200703044127.27438-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 62FC61D80859CCE8BC6DF8E8BC20DEFB1CFD8B2EDE2E84826E68BEC490F758B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIEZfTU1VX0lOX09SREVSX1dSX0VOX01BU0sgYW5kIEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RF
X0VOX01BU0sNCmRlZmluaXRpb25zIGluIE1JU0NfQ1RSTCByZWdpc3Rlci4NCkZfTU1VX1NUQU5E
QVJEX0FYSV9NT0RFX0VOX01BU0s6DQpJZiB3ZSBzZXQgRl9NTVVfU1RBTkRBUkRfQVhJX01PREVf
RU5fTUFTSyAoYml0WzNdWzE5XSA9IDAsIG5vdCBmb2xsb3cNCnN0YW5kYXJkIEFYSSBwcm90b2Nv
bCksIHRoZSBpb21tdSB3aWxsIHByaW9yaXplIHNlbmRpbmcgb2YgdXJnZW50IHJlYWQNCmNvbW1h
bmQgb3ZlciBhIG5vcm1hbCByZWFkIGNvbW1hbmQuIFRoaXMgaW1wcm92ZXMgdGhlIHBlcmZvcm1h
bmNlLg0KRl9NTVVfSU5fT1JERVJfV1JfRU5fTUFTSzoNCklmIHdlIHNldCBGX01NVV9JTl9PUkRF
Ul9XUl9FTl9NQVNLIChiaXRbMV1bMTddID0gMCwgb3V0LW9mLW9yZGVyIHdyaXRlKSwNCnRoZSBp
b21tdSB3aWxsIHJlLW9yZGVyIHdyaXRlIGNvbW1hbmRzIGFuZCBzZW5kIHRoZSB3cml0ZSBjb21t
YW5kcyB3aXRoDQpoaWdoZXIgcHJpb3JpdHkuIE90aGVyd2lzZSB0aGUgc2VuZGluZyBvZiB3cml0
ZSBjb21tYW5kcyB3aWxsIGJlIGRvbmUgaW4NCm9yZGVyLiBUaGUgZmVhdHVyZSBpcyBjb250cm9s
bGVkIGJ5IE9VVF9PUkRFUl9XUl9FTiBwbGF0Zm9ybSBkYXRhIGZsYWcuDQoNCkNjOiBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU3VnZ2VzdGVkLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhh
b0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTIgKysr
KysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQppbmRleCA0MGNhNTY0ZDk3YWYuLjIxOWQ3YWE2ZjA1OSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCkBAIC00Miw2ICs0Miw5IEBADQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQo
MSkNCiANCiAjZGVmaW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJMHgwNDgNCisjZGVmaW5lIEZfTU1V
X0lOX09SREVSX1dSX0VOX01BU0sJCShCSVQoMSkgfCBCSVQoMTcpKQ0KKyNkZWZpbmUgRl9NTVVf
U1RBTkRBUkRfQVhJX01PREVfTUFTSwkJKEJJVCgzKSB8IEJJVCgxOSkpDQorDQogI2RlZmluZSBS
RUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCiANCiAjZGVmaW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkw
eDExMA0KQEAgLTEwNSw2ICsxMDgsNyBAQA0KICNkZWZpbmUgSEFTX0JDTEsJCQlCSVQoMSkNCiAj
ZGVmaW5lIEhBU19WTERfUEFfUk5HCQkJQklUKDIpDQogI2RlZmluZSBSRVNFVF9BWEkJCQlCSVQo
MykNCisjZGVmaW5lIE9VVF9PUkRFUl9XUl9FTgkJCUJJVCg0KQ0KIA0KICNkZWZpbmUgTVRLX0lP
TU1VX0hBU19GTEFHKHBkYXRhLCBfeCkgXA0KIAkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkg
PT0gKF94KSkNCkBAIC01ODUsOCArNTg5LDE0IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2lu
aXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KIA0KIAlpZiAoTVRLX0lPTU1V
X0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgUkVTRVRfQVhJKSkgew0KIAkJLyogVGhlIHJlZ2lz
dGVyIGlzIGNhbGxlZCBTVEFOREFSRF9BWElfTU9ERSBpbiB0aGlzIGNhc2UgKi8NCi0JCXdyaXRl
bF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQorCQlyZWd2YWwg
PSAwOw0KKwl9IGVsc2Ugew0KKwkJcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsg
UkVHX01NVV9NSVNDX0NUUkwpOw0KKwkJcmVndmFsICY9IH5GX01NVV9TVEFOREFSRF9BWElfTU9E
RV9NQVNLOw0KKwkJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIE9VVF9P
UkRFUl9XUl9FTikpDQorCQkJcmVndmFsICY9IH5GX01NVV9JTl9PUkRFUl9XUl9FTl9NQVNLOw0K
IAl9DQorCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19D
VFJMKTsNCiANCiAJaWYgKGRldm1fcmVxdWVzdF9pcnEoZGF0YS0+ZGV2LCBkYXRhLT5pcnEsIG10
a19pb21tdV9pc3IsIDAsDQogCQkJICAgICBkZXZfbmFtZShkYXRhLT5kZXYpLCAodm9pZCAqKWRh
dGEpKSB7DQotLSANCjIuMTguMA0K

