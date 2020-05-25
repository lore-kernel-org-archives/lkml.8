Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF41207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vAcp9De3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgEYGNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:13:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33069 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgEYGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:13:16 -0400
X-UUID: 1689848e2ef64c158ed97b7d0f06d0f0-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4/4tyFF13ExXdeCjudAPME2PjshhSd+G5yUb+3jQX6c=;
        b=vAcp9De36AsutujK+9KbaHTnQbyL9LOdmqnpYpQFuEUFDKkGvBW5jjoG5WOBOJIGwHDpb1mshel7U/Wsact9KWkzaPsX3G12OCjSlPBOGyHy6XyFWRiXI52Wo2XZhHmD+tSjBY8tYMzY1t4pBjssw3zl8K2LVevujgfM+eUbfic=;
X-UUID: 1689848e2ef64c158ed97b7d0f06d0f0-20200525
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 139799003; Mon, 25 May 2020 14:13:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 May
 2020 14:13:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:13:07 +0800
Message-ID: <1590387086.13912.4.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/7] iommu/mediatek: Rename the register
 STANDARD_AXI_MODE(0x48) to MISC_CTRL
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>
Date:   Mon, 25 May 2020 14:11:26 +0800
In-Reply-To: <20200509083654.5178-3-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
         <20200509083654.5178-3-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F19ACAE1B3DEF7E5400D3D9BC819389FFCDC31F868E03319EA154150F0F08962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTA5IGF0IDE2OjM2ICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gRm9y
IGlvbW11IG9mZnNldD0weDQ4IHJlZ2lzdGVyLCBvbmx5IHRoZSBwcmV2aW91cyBtdDgxNzMvbXQ4
MTgzIHVzZSB0aGUNCj4gbmFtZSBTVEFOREFSRF9BWElfTU9ERSwgYWxsIHRoZSBsYXRlc3QgU29D
IGV4dGVuZCB0aGUgcmVnaXN0ZXIgbW9yZQ0KPiBmZWF0dXJlIGJ5IGRpZmZlcmVudCBiaXRzLCBm
b3IgZXhhbXBsZTogYXhpX21vZGUsIGluX29yZGVyX2VuLCBjb2hlcmVudF9lbg0KPiBhbmQgc28g
b24uIFNvIHJlbmFtZSBSRUdfTU1VX01JU0NfQ1RSTCBtYXkgYmUgbW9yZSBwcm9wZXIuDQo+IA0K
PiBUaGlzIHBhdGNoIG9ubHkgcmVuYW1lIHRoZSByZWdpc3RlciBuYW1lLCBubyBmdW5jdGlvbmFs
IGNoYW5nZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRl
ay5jb20+DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxNCArKysrKysrLS0tLS0tLQ0K
PiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRl
eCA1ZjRkNmRmNTljZjYuLmU3ZTdjNzY5NWVkMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC00
MSw3ICs0MSw3IEBADQo+ICAjZGVmaW5lIEZfSU5WTERfRU4wCQkJCUJJVCgwKQ0KPiAgI2RlZmlu
ZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCj4gIA0KPiAtI2RlZmluZSBSRUdfTU1VX1NUQU5EQVJE
X0FYSV9NT0RFCQkweDA0OA0KPiArI2RlZmluZSBSRUdfTU1VX01JU0NfQ1RSTAkJCTB4MDQ4DQo+
ICAjZGVmaW5lIFJFR19NTVVfRENNX0RJUwkJCQkweDA1MA0KPiAgDQo+ICAjZGVmaW5lIFJFR19N
TVVfQ1RSTF9SRUcJCQkweDExMA0KPiBAQCAtNTg1LDggKzU4NSwxMCBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCj4gIAl9
DQo+ICAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQo+
ICANCj4gLQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5yZXNldF9heGkpDQo+IC0JCXdyaXRlbF9yZWxh
eGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1NUQU5EQVJEX0FYSV9NT0RFKTsNCj4gKwlpZiAo
ZGF0YS0+cGxhdF9kYXRhLT5yZXNldF9heGkpIHsNCj4gKwkJLyogVGhlIHJlZ2lzdGVyIGlzIGNh
bGxlZCBTVEFOREFSRF9BWElfTU9ERSBpbiB0aGlzIGNhc2UgKi8NCj4gKwkJd3JpdGVsX3JlbGF4
ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gKwl9DQo+ICANCj4gIAlp
ZiAoZGV2bV9yZXF1ZXN0X2lycShkYXRhLT5kZXYsIGRhdGEtPmlycSwgbXRrX2lvbW11X2lzciwg
MCwNCj4gIAkJCSAgICAgZGV2X25hbWUoZGF0YS0+ZGV2KSwgKHZvaWQgKilkYXRhKSkgew0KPiBA
QCAtNzMwLDggKzczMiw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9y
ZWcgKnJlZyA9ICZkYXRhLT5yZWc7DQo+ICAJdm9pZCBfX2lvbWVtICpiYXNlID0gZGF0YS0+YmFz
ZTsNCj4gIA0KPiAtCXJlZy0+c3RhbmRhcmRfYXhpX21vZGUgPSByZWFkbF9yZWxheGVkKGJhc2Ug
Kw0KPiAtCQkJCQkgICAgICAgUkVHX01NVV9TVEFOREFSRF9BWElfTU9ERSk7DQo+ICsJcmVnLT5t
aXNjX2N0cmwgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ICAJ
cmVnLT5kY21fZGlzID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4g
IAlyZWctPmN0cmxfcmVnID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7
DQo+ICAJcmVnLT5pbnRfY29udHJvbDAgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0lO
VF9DT05UUk9MMCk7DQo+IEBAIC03NTUsOCArNzU2LDcgQEAgc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAkJZGV2X2Vycihk
YXRhLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNsayglZCkgaW4gcmVzdW1lXG4iLCByZXQpOw0K
PiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gLQl3cml0ZWxfcmVsYXhlZChyZWctPnN0YW5kYXJk
X2F4aV9tb2RlLA0KPiAtCQkgICAgICAgYmFzZSArIFJFR19NTVVfU1RBTkRBUkRfQVhJX01PREUp
Ow0KPiArCXdyaXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBiYXNlICsgUkVHX01NVV9NSVND
X0NUUkwpOw0KPiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+ZGNtX2RpcywgYmFzZSArIFJFR19NTVVf
RENNX0RJUyk7DQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVnLT5jdHJsX3JlZywgYmFzZSArIFJFR19N
TVVfQ1RSTF9SRUcpOw0KPiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+aW50X2NvbnRyb2wwLCBiYXNl
ICsgUkVHX01NVV9JTlRfQ09OVFJPTDApOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gaW5kZXggZWE5NDlhMzI0
ZTMzLi4xYjZlYTgzOWI5MmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmgNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiBAQCAtMTgsNyArMTgsNyBA
QA0KPiAgI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gIA0KPiAgc3RydWN0IG10a19p
b21tdV9zdXNwZW5kX3JlZyB7DQo+IC0JdTMyCQkJCXN0YW5kYXJkX2F4aV9tb2RlOw0KPiArCXUz
MgkJCQltaXNjX2N0cmw7DQo+ICAJdTMyCQkJCWRjbV9kaXM7DQo+ICAJdTMyCQkJCWN0cmxfcmVn
Ow0KPiAgCXUzMgkJCQlpbnRfY29udHJvbDA7DQoNCg==

