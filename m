Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC856C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC82E206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l5cznZQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFDJtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:49:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38274 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727993AbgFDJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:49:40 -0400
X-UUID: 579acaf2148b49c6b7566c730229f003-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lBI82O8bEEPgYlNHvOkibX3qdLSsdkxzL1E3PQQA8b0=;
        b=l5cznZQyeF0t8PUXtBPHL8pk3AnSmztorPMyyTSrjhlLqv1+LiJ4TE/ssnITNp2aCsHzYTShTvLxmFL0OjobwAJ8z1zHj8Y1J53i/m96VhNfj5XrWfF2BAQKrUi1kO3GNsTfxg+SvQTp5toCtYcObnVp8pue0TxUoz4GFTToRcM=;
X-UUID: 579acaf2148b49c6b7566c730229f003-20200604
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1162007422; Thu, 04 Jun 2020 17:49:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 17:49:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 17:49:32 +0800
Message-ID: <1591264174.12661.17.camel@mtkswgap22>
Subject: Re: [PATCH] iommu/mediatek: Use totalram_pages to setup enable_4GB
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>, <yingjoe.chen@mediatek.com>
Date:   Thu, 4 Jun 2020 17:49:34 +0800
In-Reply-To: <55820901-430b-14c4-9426-7a4991ca0eed@redhat.com>
References: <20200604080120.2628-1-miles.chen@mediatek.com>
         <55820901-430b-14c4-9426-7a4991ca0eed@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AE948E482C29CD5898F27E00F7D8367EA04E36796E3DBBED3FBA94C5849F28092000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTA0IGF0IDEwOjI1ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMDQuMDYuMjAgMTA6MDEsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gVG8gYnVpbGQg
dGhpcyBkcml2ZXIgYXMgYSBrZXJuZWwgbW9kdWxlLCB3ZSBjYW5ub3QgdXNlDQo+ID4gdGhlIHVu
ZXhwb3J0ZWQgc3ltYm9sICJtYXhfcGZuIiB0byBzZXR1cCBlbmFibGVfNEdCLg0KPiA+IA0KPiA+
IFVzZSB0b3RhbHJhbV9wYWdlcygpIGluc3RlYWQgdG8gc2V0dXAgZW5hYmxlXzRHQi4NCj4gPiAN
Cj4gPiBTdWdnZXN0ZWQtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4g
PiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gQ2M6IFlvbmcg
V3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNSAr
Ky0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IDVmNGQ2ZGY1OWNmNi4uYzI3OThhNmUw
ZTM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTMsNyArMyw2IEBADQo+ID4gICAq
IENvcHlyaWdodCAoYykgMjAxNS0yMDE2IE1lZGlhVGVrIEluYy4NCj4gPiAgICogQXV0aG9yOiBZ
b25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAgICovDQo+ID4gLSNpbmNsdWRlIDxs
aW51eC9tZW1ibG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvYnVnLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9jbGsuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2NvbXBvbmVudC5oPg0KPiA+
IEBAIC02MjYsOCArNjI1LDggQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgCWRhdGEt
PnByb3RlY3RfYmFzZSA9IEFMSUdOKHZpcnRfdG9fcGh5cyhwcm90ZWN0KSwgTVRLX1BST1RFQ1Rf
UEFfQUxJR04pOw0KPiA+ICANCj4gPiAtCS8qIFdoZXRoZXIgdGhlIGN1cnJlbnQgZHJhbSBpcyBv
dmVyIDRHQiAqLw0KPiA+IC0JZGF0YS0+ZW5hYmxlXzRHQiA9ICEhKG1heF9wZm4gPiAoQklUX1VM
TCgzMikgPj4gUEFHRV9TSElGVCkpOw0KPiA+ICsJLyogV2hldGhlciB0aGUgY3VycmVudCBkcmFt
IGlzIG92ZXIgNEdCLCBub3RlOiBEUkFNIHN0YXJ0IGF0IDFHQiAgKi8NCj4gPiArCWRhdGEtPmVu
YWJsZV80R0IgPSAhISh0b3RhbHJhbV9wYWdlcygpID4gKChTWl8yRyArIFNaXzFHKSA+PiBQQUdF
X1NISUZUKSk7DQo+IA0KPiBBIHNpbWlsYXIgdGhpbmcgc2VlbXMgdG8gYmUgZG9uZSBieQ0KPiBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12cHUvbXRrX3ZwdS5jOg0KPiAJdnB1LT5lbmFibGVf
NEdCID0gISEodG90YWxyYW1fcGFnZXMoKSA+IChTWl8yRyA+PiBQQUdFX1NISUZUKSk7DQo+IA0K
PiBJIGRvIHdvbmRlciBpZiBzb21lIHdlaXJkIG1lbW9yeSBob3RwbHVnIHNldHVwcyBtaWdodCBn
aXZlIHlvdSBmYWxzZQ0KPiBuZWdhdGl2ZXMuDQo+IA0KPiBFLmcuLCBzdGFydCBhIFZNIHdpdGgg
MUdCIGFuZCBob3RwbHVnIDFHQiAtIGl0IHdpbGwgYmUgaG90cGx1Z2dlZCBvbg0KPiB4ODYtNjQg
YWJvdmUgNEdCLCB0dXJuaW5nIG1heF9wZm4gaW50byA1R0IuIHRvdGFscmFtX3BhZ2VzKCkgc2hv
dWxkDQo+IHJldHVybiBzb21ldGhpbmcgPCAyR0IuDQo+IA0KPiBTYW1lIGNhbiBoYXBwZW4gd2hl
biB5b3UgaGF2ZSBhIFZNIGFuZCB1c2UgYmFsbG9vbmluZyB0byBmYWtlLXVucGx1Zw0KPiBtZW1v
cnksIG1ha2luZyB0b3RhbHJhbV9wYWdlcygpIHJldHVybiBzb21ldGhpbmcgPCA0R0IsIGJ1dCBs
ZWF2aW5nDQo+IHVzYWJsZSBwZm5zID49IDRHQg0KDQpZZXMuIFlpbmdqb2UgYWxzbyB0b2xkIG1l
IHRoYXQgdGhpcyBwYXRjaCBpcyBub3QgY29ycmVjdC4NCg0KVGhhbmtzIGZvciBwb2ludGluZyB0
aGlzIG91dC4gdG90YWxyYW1fcGFnZXMoKSBkb2VzIG5vdCB3b3JrIA0KZm9yIHNvbWUgY2FzZXM6
DQoNCmUuZy4sIERSQU0gc3RhcnQgQDB4NDAwMF8wMDAwIGFuZCBEUkFNIHNpemUgaXMgMHgxXzAw
MDBfMDAwMCBidXQgd2UNCnJlc2VydmUgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeSwgd2hpY2ggbWFr
ZXMgdG90YWxyYW1fcGFnZXMoKSA8IDNHQiBidXQNCml0IGlzIHBvc3NpYmxlIHRvIGFsbG9jYXRl
IGEgcGZuID49IDRHQi4NCg0KSSB3aWxsIGRpc2N1c3MgdGhpcyBpbnRlcm5hbGx5Lg0KDQpNaWxl
cw0KPiAuDQo+IA0KPiBidXQNCj4gLi4uIEkgZG9uJ3Qga25vdyBpZiBJIHVuZGVyc3Rvb2Qgd2hh
dCAiZW5hYmxlXzRHQiIgbmVlZHMvaW1wbGllcw0KPiAuLi4gSSBkb24ndCBrbm93IGlmIHRoaXMg
aXMgYXBwbGljYWJsZSB0byBWTXMNCj4gIGF0IGFsbCAob24gcmVhbCBIVyBzdWNoDQo+ICAgICBt
ZW1vcnkgaG90cGx1ZyBzZXR1cHMgc2hvdWxkIG5vdCBleGlzdCkNCj4gLi4uIEkgZG9uJ3Qga25v
dyBob3cgdGhpcyBjb2RlIHdvdWxkIHJlYWN0IHRvIG1lbW9yeSBob3RwbHVnLCBzbyBpZiB0aGUN
Cj4gICAgIGNvbmRpdGlvbiBjaGFuZ2VzIGFmdGVyIHRoZSBkcml2ZXIgbG9hZGVkIGFuZCBlbmFi
bGVfNEdCIHdvdWxkDQo+ICAgICBzdWRkZW5seSBhcHBseS4gQWdhaW4sIG1vc3QgcHJvYmFibHkg
bm90IHJlbGV2YW50IG9uIHJlYWwgSFcsIG9ubHkNCj4gICAgIGZvciBWTXMuDQo+IA0KDQo=

