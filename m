Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1368EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08AB2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KY3IKegX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgF3LAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:00:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50651 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732591AbgF3LAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:00:32 -0400
X-UUID: 45ce0cb4af224ae2b6bdd637800262d0-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Qgf6+KnJU1C/9ERhG+00Cd7X5IE2bZgFvfn2R9N4ujg=;
        b=KY3IKegXO3DSuD/QVvBPekshjSIttVde6VaOcWgugHvPr6vyyUNCcHSuf0jYtu3aHCWyTnywl4IgN78UoCSEECRoHPUNzctSBlnIGY+2AWW91K4tTqrKFzA7qXKv+xxCx9yf0kkwWolAVnzOt2tOojZ+IRh3J21EpOnVt5jV9x4=;
X-UUID: 45ce0cb4af224ae2b6bdd637800262d0-20200630
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 739440965; Tue, 30 Jun 2020 19:00:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:00:23 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:00:23 +0800
Message-ID: <1593514765.13270.3.camel@mbjsdccf07>
Subject: Re: [PATCH v5 07/10] iommu/mediatek: Add REG_MMU_WR_LEN register
 definition
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Yong Wu" <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 30 Jun 2020 18:59:25 +0800
In-Reply-To: <ccb63946-e187-187e-c92c-0423f1831d8f@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-8-chao.hao@mediatek.com>
         <ccb63946-e187-187e-c92c-0423f1831d8f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 329E5CED00E1E6D984FED548CE85F058205BE3EED5886D85F7D19028D1218CCC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDEyOjE2ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjkvMDYvMjAyMCAwOToxMywgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gU29tZSBw
bGF0Zm9ybXMoZXg6IG10Njc3OSkgbmVlZCB0byBpbXByb3ZlIHBlcmZvcm1hbmNlIGJ5IHNldHRp
bmcNCj4gPiBSRUdfTU1VX1dSX0xFTiByZWdpc3Rlci4gQW5kIHdlIGNhbiB1c2UgV1JfVEhST1Rf
RU4gbWFjcm8gdG8gY29udHJvbA0KPiA+IHdoZXRoZXIgd2UgbmVlZCB0byBzZXQgdGhlIHJlZ2lz
dGVyLiBJZiB0aGUgcmVnaXN0ZXIgdXNlcyBkZWZhdWx0IHZhbHVlLA0KPiA+IGlvbW11IHdpbGwg
c2VuZCBjb21tYW5kIHRvIEVNSSB3aXRob3V0IHJlc3RyaWN0aW9uLCB3aGVuIHRoZSBudW1iZXIg
b2YNCj4gPiBjb21tYW5kcyBiZWNvbWUgbW9yZSBhbmQgbW9yZSwgaXQgd2lsbCBkcm9wIHRoZSBF
TUkgcGVyZm9ybWFuY2UuIFNvIHdoZW4NCj4gPiBtb3JlIHRoYW4gdGVuX2NvbW1hbmRzKGRlZmF1
bHQgdmFsdWUpIGRvbid0IGJlIGhhbmRsZWQgZm9yIEVNSSwgaW9tbXUgd2lsbA0KPiA+IHN0b3Ag
c2VuZCBjb21tYW5kIHRvIEVNSSBmb3Iga2VlcGluZyBFTUkncyBwZXJmb3JtYWNlIGJ5IGVuYWJs
aW5nIHdyaXRlDQo+ID4gdGhyb3R0bGluZyBtZWNoYW5pc20oYml0WzVdWzIxXT0wKSBpbiBNTVVf
V1JfTEVOX0NUUkwgcmVnaXN0ZXIuDQo+ID4gDQo+ID4gQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1h
dHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8u
aGFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyB8IDEwICsrKysrKysrKysNCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAyICsr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiA+IGluZGV4IGVjMWY4NjkxMzczOS4uOTIzMTZjNDE3NWE5IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+ID4gQEAgLTQ2LDYgKzQ2LDggQEANCj4gPiAgI2RlZmluZSBGX01NVV9TVEFO
REFSRF9BWElfTU9ERV9CSVQJCShCSVQoMykgfCBCSVQoMTkpKQ0KPiA+ICANCj4gPiAgI2RlZmlu
ZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCj4gPiArI2RlZmluZSBSRUdfTU1VX1dSX0xFTgkJ
CQkweDA1NA0KPiANCj4gVGhlIHJlZ2lzdGVyIG5hbWUgaXMgY29uZnVzaW5nLiBGb3IgbWUgaXQg
c2VlbXMgdG8gZGVzY3JpYmUgdGhlIGxlbmd0aCBvZiBhDQo+IHdyaXRlIGJ1dCBpdCBpcyB1c2Vk
IGZvciBjb250cm9sbGluZyB0aGUgd3JpdGUgdGhyb3R0bGluZy4gSXMgdGhpcyB0aGUgbmFtZQ0K
PiB0aGF0J3MgdXNlZCBpbiB0aGUgZGF0YXNoZWV0Pw0KPiANCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldyBjYXJlZnVsbHksIHdlIGNhbiBuYW1lIGl0IHRvIFJFR19NTVVfV1JfTEVOX0NUUkwNCg0K
DQo+ID4gKyNkZWZpbmUgRl9NTVVfV1JfVEhST1RfRElTX0JJVAkJCShCSVQoNSkgfCAgQklUKDIx
KSkNCj4gDQo+IFRoZXJlIGFyZSB0d28gc3BhY2VzIGJldHdlZW4gJ3wnIGFuZCAnQklUKDIxKScs
IHNob3VsZCBiZSBvbmUuDQo+IA0KPiBSZWdhcmRpbmcgdGhlIG5hbWUgb2YgdGhlIGRlZmluZSwg
d2hhdCBkb2VzIHRoZSAnRl8nIHN0YXRuZHMgZm9yPyANCg0KRl8gaXMgdXNlZCB0byBkZXNjcmli
ZWQgc29tZSBiaXRzIGluIHJlZ2lzdGVyIGFuZCBkb2Vzbid0IGhhdmUgb3RoZXINCm1lYW5pbmdz
LiBUaGUgZm9ybWF0IGlzIHJlZmVyIHRvIG90aGVyIGJpdHMgZGVmaW5pdGlvbg0KDQo+IEFsc28g
SSB0aGluaw0KPiBpdCBzaG91bGQgYmUgY2FsbGVkICdfTUFTSycgaW5zdGVhZCBvZiAnX0JJVCcg
YXMgaXQgZGVmaW5lcyBhIG1hc2sgb2YgYml0cy4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciBhZHZp
Y2UuDQpGb3IgRl9NTVVfV1JfVEhST1RfRElTX0JJVDoNCjEnYjA6IEVuYWJsZSB3cml0ZSB0aHJv
dHRsaW5nIG1lY2hhbmlzbQ0KMSdiMTogRGlzYWJsZSB3cml0ZSB0aHJvdHRsaW5nIG1lY2hhbmlz
bQ0KU28gSSB0aGluayB3ZSBjYW4gbmFtZSAiRl9NTVVfV1JfVEhST1RfRElTICBCSVQoNSkgfCBC
SVQoMjEpIiBkaXJlY3RseSwNCml0IG1heWJlIG1vcmUgY2xlYXJlci4NCg0KPiBSZWdhcmRzLA0K
PiBNYXR0aGlhcw0KPiANCj4gPiAgDQo+ID4gICNkZWZpbmUgUkVHX01NVV9DVFJMX1JFRwkJCTB4
MTEwDQo+ID4gICNkZWZpbmUgRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFIJCSgyIDw8IDQp
DQo+ID4gQEAgLTU4Miw2ICs1ODQsMTIgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChj
b25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQo
cmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9WTERfUEFfUk5HKTsNCj4gPiAgCX0NCj4gPiAg
CXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0KPiA+ICsJ
aWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIFdSX1RIUk9UX0VOKSkgew0K
PiA+ICsJCS8qIHdyaXRlIGNvbW1hbmQgdGhyb3R0bGluZyBtb2RlICovDQo+ID4gKwkJcmVndmFs
ID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsgUkVHX01NVV9XUl9MRU4pOw0KPiA+ICsJCXJl
Z3ZhbCAmPSB+Rl9NTVVfV1JfVEhST1RfRElTX0JJVDsNCj4gPiArCQl3cml0ZWxfcmVsYXhlZChy
ZWd2YWwsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1dSX0xFTik7DQo+ID4gKwl9DQo+ID4gIA0KPiA+
ICAJcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwp
Ow0KPiA+ICAJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIFJFU0VUX0FY
SSkpIHsNCj4gPiBAQCAtNzM3LDYgKzc0NSw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQg
bXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJc3RydWN0IG10a19p
b21tdV9zdXNwZW5kX3JlZyAqcmVnID0gJmRhdGEtPnJlZzsNCj4gPiAgCXZvaWQgX19pb21lbSAq
YmFzZSA9IGRhdGEtPmJhc2U7DQo+ID4gIA0KPiA+ICsJcmVnLT53cl9sZW4gPSByZWFkbF9yZWxh
eGVkKGJhc2UgKyBSRUdfTU1VX1dSX0xFTik7DQo+ID4gIAlyZWctPm1pc2NfY3RybCA9IHJlYWRs
X3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPiAgCXJlZy0+ZGNtX2RpcyA9
IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQo+ID4gIAlyZWctPmN0cmxf
cmVnID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQo+ID4gQEAgLTc2
MSw2ICs3NzAsNyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRv
IGVuYWJsZSBjbGsoJWQpIGluIHJlc3VtZVxuIiwgcmV0KTsNCj4gPiAgCQlyZXR1cm4gcmV0Ow0K
PiA+ICAJfQ0KPiA+ICsJd3JpdGVsX3JlbGF4ZWQocmVnLT53cl9sZW4sIGJhc2UgKyBSRUdfTU1V
X1dSX0xFTik7DQo+ID4gIAl3cml0ZWxfcmVsYXhlZChyZWctPm1pc2NfY3RybCwgYmFzZSArIFJF
R19NTVVfTUlTQ19DVFJMKTsNCj4gPiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+ZGNtX2RpcywgYmFz
ZSArIFJFR19NTVVfRENNX0RJUyk7DQo+ID4gIAl3cml0ZWxfcmVsYXhlZChyZWctPmN0cmxfcmVn
LCBiYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gaW5kZXggYmU2
ZDMyZWU1YmRhLi5jZTRmNGU4ZjAzYWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBAQCAt
MjQsNiArMjQsNyBAQA0KPiA+ICAjZGVmaW5lIFJFU0VUX0FYSQkJCUJJVCgzKQ0KPiA+ICAjZGVm
aW5lIE9VVF9PUkRFUl9FTgkJCUJJVCg0KQ0KPiA+ICAjZGVmaW5lIEhBU19TVUJfQ09NTQkJCUJJ
VCg1KQ0KPiA+ICsjZGVmaW5lIFdSX1RIUk9UX0VOCQkJQklUKDYpDQo+ID4gIA0KPiA+ICAjZGVm
aW5lIE1US19JT01NVV9IQVNfRkxBRyhwZGF0YSwgX3gpIFwNCj4gPiAgCQkoKCgocGRhdGEpLT5m
bGFncykgJiAoX3gpKSA9PSAoX3gpKQ0KPiA+IEBAIC0zNiw2ICszNyw3IEBAIHN0cnVjdCBtdGtf
aW9tbXVfc3VzcGVuZF9yZWcgew0KPiA+ICAJdTMyCQkJCWludF9tYWluX2NvbnRyb2w7DQo+ID4g
IAl1MzIJCQkJaXZycF9wYWRkcjsNCj4gPiAgCXUzMgkJCQl2bGRfcGFfcm5nOw0KPiA+ICsJdTMy
CQkJCXdyX2xlbjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIGVudW0gbXRrX2lvbW11X3BsYXQgew0K
PiA+IA0KDQo=

