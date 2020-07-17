Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A713C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CACB206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGQJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:08:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:49450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbgGQJIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:08:05 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id A7392E30ACC198C40E8B;
        Fri, 17 Jul 2020 17:07:59 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Fri, 17 Jul 2020 17:07:48 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling
 for CMD SYNC
Thread-Topic: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling
 for CMD SYNC
Thread-Index: AQHWW8YiwSsIgpwKv0qM0ZdQNf6ByakK8iGAgACG1CA=
Date:   Fri, 17 Jul 2020 09:07:48 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25900C6@DGGEMI525-MBS.china.huawei.com>
References: <20200716230709.32820-1-song.bao.hua@hisilicon.com>
 <35b54698-bd43-a8fc-00db-94ee0dfc789f@arm.com>
In-Reply-To: <35b54698-bd43-a8fc-00db-94ee0dfc789f@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.111]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxNywgMjAy
MCA4OjU1IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT47IHdpbGxAa2VybmVsLm9yZzsNCj4gam9yb0A4Ynl0ZXMub3JnDQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2ls
aWNvbi5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlvbW11L2FybS1zbW11LXYzOiByZW1v
dmUgdGhlIGFwcHJvYWNoIG9mIE1TSQ0KPiBwb2xsaW5nIGZvciBDTUQgU1lOQw0KPiANCj4gT24g
MjAyMC0wNy0xNyAwMDowNywgQmFycnkgU29uZyB3cm90ZToNCj4gPiBCZWZvcmUgY29tbWl0IDU4
N2U2YzEwYTdjZSAoImlvbW11L2FybS1zbW11LXYzOiBSZWR1Y2UgY29udGVudGlvbg0KPiBkdXJp
bmcNCj4gPiBjb21tYW5kLXF1ZXVlIGluc2VydGlvbiIpLCBtc2kgcG9sbGluZyBwZXJoYXBzIHBl
cmZvcm1lZCBiZXR0ZXIgc2luY2UNCj4gPiBpdCBjb3VsZCBydW4gb3V0c2lkZSB0aGUgc3Bpbl9s
b2NrX2lycXNhdmUoKSB3aGlsZSB0aGUgY29kZSBwb2xsaW5nIGNvbnMNCj4gPiByZWcgd2FzIHJ1
bm5pbmcgaW4gdGhlIGxvY2suDQo+ID4NCj4gPiBCdXQgYWZ0ZXIgdGhlIGdyZWF0IHJlb3JnYW5p
emF0aW9uIG9mIHNtbXUgcXVldWUsIG5laXRoZXIgb2YgdGhlc2UgdHdvDQo+ID4gcG9sbGluZyBt
ZXRob2RzIGFyZSBydW5uaW5nIGluIGEgc3BpbmxvY2suIEFuZCByZWFsIHRlc3RzIHNob3cgcG9s
bGluZw0KPiA+IGNvbnMgcmVnIHZpYSBzZXYgbWVhbnMgc21hbGxlciBsYXRlbmN5LiBJdCBpcyBw
cm9iYWJseSBiZWNhdXNlIHBvbGxpbmcNCj4gPiBieSBtc2kgd2lsbCBhc2sgaGFyZHdhcmUgdG8g
d3JpdGUgbWVtb3J5IGJ1dCBzZXYgcG9sbGluZyBkZXBlbmRzIG9uIHRoZQ0KPiA+IHVwZGF0ZSBv
ZiByZWdpc3RlciBvbmx5Lg0KPiA+DQo+ID4gVXNpbmcgMTYgdGhyZWFkcyB0byBydW4gbmV0cGVy
ZiBvbiBobnMzIDEwMEcgTklDIHdpdGggVURQIHBhY2tldCBzaXplDQo+ID4gaW4gMzI3NjhieXRl
cyBhbmQgc2V0IGlvbW11IHRvIHN0cmljdCwgVFggdGhyb3VnaHB1dCBjYW4gaW1wcm92ZSBmcm9t
DQo+ID4gMjUyMjcuNzRNYnBzIHRvIDI3MTQ1LjU5TWJwcyBieSB0aGlzIHBhdGNoLiBJbiB0aGlz
IGNhc2UsIFNNTVUgaXMgc3VwZXINCj4gPiBidXN5IGFzIGhuczMgc2VuZHMgbWFwL3VubWFwIHJl
cXVlc3RzIGV4dHJlbWVseSBmcmVxdWVudGx5Lg0KPiANCj4gSG93IG1hbnkgZGlmZmVyZW50IHN5
c3RlbXMgYW5kIFNNTVUgaW1wbGVtZW50YXRpb25zIGFyZSB0aG9zZSBudW1iZXJzDQo+IHJlcHJl
c2VudGF0aXZlIG9mPyBHaXZlbiB0aGF0IHdlIG1heSBoYXZlIGNhc2VzIHdoZXJlIHRoZSBTTU1V
IGNhbiB1c2UNCj4gTVNJcyBidXQgY2FuJ3QgdXNlIFNFViwgc28gd291bGQgaGF2ZSB0byBmYWxs
IGJhY2sgdG8gaW5lZmZpY2llbnQNCj4gYnVzeS1wb2xsaW5nLCBJJ2QgYmUgd2FyeSBvZiByZW1v
dmluZyB0aGlzIGVudGlyZWx5LiBBbGxvd2luZyBwYXJ0aWN1bGFyDQo+IHBsYXRmb3JtcyBvciBT
TU1VIGltcGxlbWVudGF0aW9ucyB0byBzdXBwcmVzcyBNU0kgZnVuY3Rpb25hbGl0eSBpZiB0aGV5
DQo+IGtub3cgZm9yIHN1cmUgaXQgbWFrZXMgc2Vuc2Ugc2VlbXMgbGlrZSBhIHNhZmVyIGJldC4N
Cj4gDQpIZWxsbyBSb2JpbiwNCg0KVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLiBBY3R1YWxseSBJ
IHdhcyByZWFsbHkgc3RydWdnbGluZyB3aXRoIHRoZSBnb29kIHdheSB0byBtYWtlIGV2ZXJ5IHBs
YXRmb3JtIGhhcHB5Lg0KQW5kIEkgZG9uJ3QgaGF2ZSBvdGhlciBwbGF0Zm9ybXMgdG8gdGVzdCBh
bmQgY2hlY2sgaWYgdGhvc2UgcGxhdGZvcm1zIHJ1biBiZXR0ZXIgYnkgc2V2IHBvbGxpbmcuIEV2
ZW4gdHdvDQpwbGF0Zm9ybXMgaGF2ZSBjb21wbGV0ZWx5IHNhbWUgU01NVSBmZWF0dXJlcywgaXQg
aXMgc3RpbGwgcG9zc2libGUgdGhleSBiZWhhdmUgZGlmZmVyZW50bHkuDQpTbyBJIHNpbXBseSBz
ZW50IHRoaXMgcGF0Y2ggdG8gZ2V0IHRoZSBkaXNjdXNzaW9uIHN0YXJ0ZWQgdG8gZ2V0IG9waW5p
b25zLg0KDQpBdCB0aGUgZmlyc3QgYmVnaW5uaW5nLCBJIHdhbnRlZCB0byBoYXZlIGEgbW9kdWxl
IHBhcmFtZXRlciBmb3IgdXNlcnMgdG8gZGVjaWRlIGlmIG1zaSBwb2xsaW5nIHNob3VsZCBiZSBk
aXNhYmxlZC4NCkJ1dCB0aGUgbW9kdWxlIHBhcmFtZXRlciBtaWdodCBiZSB0b3RhbGx5IGlnbm9y
ZWQgYnkgbGludXggZGlzdHJvLg0KDQotLS0gYS9kcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMN
CisrKyBiL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYw0KQEAgLTQxOCw2ICs0MTgsMTEgQEAg
bW9kdWxlX3BhcmFtX25hbWVkKGRpc2FibGVfYnlwYXNzLCBkaXNhYmxlX2J5cGFzcywgYm9vbCwg
U19JUlVHTyk7ICBNT0RVTEVfUEFSTV9ERVNDKGRpc2FibGVfYnlwYXNzLA0KIAkiRGlzYWJsZSBi
eXBhc3Mgc3RyZWFtcyBzdWNoIHRoYXQgaW5jb21pbmcgdHJhbnNhY3Rpb25zIGZyb20gZGV2aWNl
cyB0aGF0IGFyZSBub3QgYXR0YWNoZWQgdG8gYW4gaW9tbXUgZG9tYWluIHdpbGwgcmVwb3J0IGFu
IGFib3J0IGJhY2sgdG8gdGhlIGRldmljZSBhbmQgd2lsbCBub3QgYmUgYWxsb3dlZCB0byBwYXNz
IHRocm91Z2ggdGhlIFNNTVUuIik7DQogDQorc3RhdGljIGJvb2wgZGlzYWJsZV9tc2lwb2xsaW5n
ID0gMTsNCittb2R1bGVfcGFyYW1fbmFtZWQoZGlzYWJsZV9tc2lwb2xsaW5nLCBkaXNhYmxlX21z
aXBvbGxpbmcsIGJvb2wsIA0KK1NfSVJVR08pOyBNT0RVTEVfUEFSTV9ERVNDKGRpc2FibGVfbXNp
cG9sbGluZywNCisJIkRvbid0IHVzZSBNU0kgdG8gcG9sbCB0aGUgY29tcGxldGlvbiBvZiBDTURf
U1lOQyBpZiBpdCBpcyBzbG93ZXIgdGhhbiANCitTRVYiKTsNCisNCiBlbnVtIHByaV9yZXNwIHsN
CiAJUFJJX1JFU1BfREVOWSA9IDAsDQogCVBSSV9SRVNQX0ZBSUwgPSAxLA0KQEAgLTk5Miw3ICs5
OTcsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9jbWRxX2J1aWxkX3N5bmNfY21kKHU2NCAqY21k
LCBzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LA0KIAkgKiBCZXdhcmUgdGhhdCBIaTE2eHgg
YWRkcyBhbiBleHRyYSAzMiBiaXRzIG9mIGdvb2RuZXNzIHRvIGl0cyBNU0kNCiAJICogcGF5bG9h
ZCwgc28gdGhlIHdyaXRlIHdpbGwgemVybyB0aGUgZW50aXJlIGNvbW1hbmQgb24gdGhhdCBwbGF0
Zm9ybS4NCiAJICovDQotCWlmIChzbW11LT5mZWF0dXJlcyAmIEFSTV9TTU1VX0ZFQVRfTVNJICYm
DQorCWlmICghZGlzYWJsZV9tc2lwb2xsaW5nICYmIHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVf
RkVBVF9NU0kgJiYNCiAJICAgIHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9DT0hFUkVO
Q1kpIHsNCiAJCWVudC5zeW5jLm1zaWFkZHIgPSBxLT5iYXNlX2RtYSArIFFfSURYKCZxLT5sbHEs
IHByb2QpICoNCiAJCQkJICAgcS0+ZW50X2R3b3JkcyAqIDg7DQpAQCAtMTMzMiw3ICsxMzM3LDcg
QEAgc3RhdGljIGludCBfX2FybV9zbW11X2NtZHFfcG9sbF91bnRpbF9jb25zdW1lZChzdHJ1Y3Qg
YXJtX3NtbXVfZGV2aWNlICpzbW11LCAgc3RhdGljIGludCBhcm1fc21tdV9jbWRxX3BvbGxfdW50
aWxfc3luYyhzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LA0KIAkJCQkJIHN0cnVjdCBhcm1f
c21tdV9sbF9xdWV1ZSAqbGxxKQ0KIHsNCi0JaWYgKHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVf
RkVBVF9NU0kgJiYNCisJaWYgKCFkaXNhYmxlX21zaXBvbGxpbmcgJiYgc21tdS0+ZmVhdHVyZXMg
JiBBUk1fU01NVV9GRUFUX01TSSAmJg0KIAkgICAgc21tdS0+ZmVhdHVyZXMgJiBBUk1fU01NVV9G
RUFUX0NPSEVSRU5DWSkNCiAJCXJldHVybiBfX2FybV9zbW11X2NtZHFfcG9sbF91bnRpbF9tc2ko
c21tdSwgbGxxKTsNCg0KDQpBbm90aGVyIG9wdGlvbiBpcyB0aGF0IHdlIGRvbid0IHVzZSBtb2R1
bGUgcGFyYW1ldGVyLCBhbHRlcm5hdGl2ZWx5LCB3ZSBjaGVjayB0aGUgdmVuZG9yL2NoaXAgSUQs
DQppZiB0aGUgY2hpcCBoYXMgYmV0dGVyIHBlcmZvcm1hbmNlIG9uIHNldiBwb2xsaW5nLCBpdCBt
YXkgc2V0IGRpc2FibGVfbXNpcG9sbGluZyB0byB0cnVlLg0KDQpZb3UgYXJlIHZlcnkgd2VsY29t
ZSB0byBnaXZlIHlvdXIgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcw0KQmFycnkNCg==
