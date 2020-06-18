Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D04A207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SIUCH/QL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgFROWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:22:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40917 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728033AbgFROWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:22:08 -0400
X-UUID: be2b3b0413484d98a33d9725e917350a-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JaNv1xRYZuJqMSR6WYFAxOUzdkvOslEtw5hvRm5QTu4=;
        b=SIUCH/QLBqHdKw2L/40jis4UUCHdUXrFWHg2gRpxUUiA77XYMVoPpgvBab0I7Qaj1lQnIlRD0cOvFk3uefAcx0NKueO4a12vvKZykA+3O5gbJzdF66hS09x87UX9xKlMbWfPR9JngIgq3XrIs/k94MnefO7Tt3UZ+ihAqGLG3kI=;
X-UUID: be2b3b0413484d98a33d9725e917350a-20200618
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 281579442; Thu, 18 Jun 2020 22:22:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 22:22:02 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 22:22:02 +0800
Message-ID: <1592490123.10773.16.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Date:   Thu, 18 Jun 2020 22:22:03 +0800
In-Reply-To: <f47e8a1e70c982ecf6245db573630f51@kernel.org>
References: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
         <f47e8a1e70c982ecf6245db573630f51@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDEzOjQxICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDIwMjAtMDYtMTggMTM6MzEsIEhhbmtzIENoZW4gd3JvdGU6DQo+ID4gTWVkaWF0ZWsgc3lz
aXJxIGFuZCBjaXJxIGRyaXZlcnMgYXMtaXMgd2VyZSBib3VuZCB0b2dldGhlciB0byB0aGUgDQo+
ID4gY29uZmlnDQo+ID4gb2YgQVJDSF9NRURJQVRFSy4gIFRoZXNlIHR3byBkcml2ZXJzIHNob3Vs
ZCBiZSBhYmxlIHRvIGJlIGNvbmZpZ3VyZWQNCj4gPiBzZXBhcmF0ZWx5LiAgRm9yIGV4YW1wbGUs
IG9uIG5ldyBNZWRpYXRlayBtb2JpbGUgY2hpcHMgc3VjaCBhcyANCj4gPiBEaW1lbnNpdHkNCj4g
PiA4MjAsIHRoZSBzeXNpcnEgZHJpdmVyIGlzIG5vdCB1c2VkIHNpbmNlIHRoZSBoYXJkd2FyZSBt
b2R1bGUgaXMgDQo+ID4gcmVtb3ZlZC4NCj4gPiANCj4gPiBBZGQgdHdvIG5ldyBjb25maWdzIHRv
IHN5c2lycSBhbmQgY2lycSBkcml2ZXJzLg0KPiA+IC0gY29uZmlnIE1US19TWVNJUlEgZm9yIHRo
ZSBpbnRlcnJ1cHQgcG9sYXJpdHkgY29udHJvbGxlciBkcml2ZXI6IA0KPiA+IHN5c2lycQ0KPiA+
IC0gY29uZmlnIE1US19DSVJRIGZvciB0aGUgbG93LXBvd2VyIGludGVycnVwdCBkcml2ZXI6IGNp
cnENCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBjYy5od2FuZyA8Y2MuaHdhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbmtzIENoZW4gPGhhbmtzLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lycWNoaXAvS2NvbmZpZyAgfCAgIDEyICsrKysr
KysrKysrKw0KPiA+ICBkcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUgfCAgICAzICsrLQ0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL0tjb25maWcgYi9kcml2ZXJzL2lycWNoaXAv
S2NvbmZpZw0KPiA+IGluZGV4IDI5ZmVhZDIuLmNjOWFhMTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9pcnFjaGlwL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZw0K
PiA+IEBAIC01NzIsNCArNTcyLDE2IEBAIGNvbmZpZyBMT09OR1NPTl9QQ0hfTVNJDQo+ID4gIAlo
ZWxwDQo+ID4gIAkgIFN1cHBvcnQgZm9yIHRoZSBMb29uZ3NvbiBQQ0ggTVNJIENvbnRyb2xsZXIu
DQo+ID4gDQo+ID4gK2NvbmZpZyBNVEtfU1lTSVJRDQo+ID4gKwl0cmlzdGF0ZSAiTWVkaWF0ZWsg
aW50ZXJydXB0IHBvbGFyaXR5IGNvbnRyb2xsZXIiDQo+IA0KPiBIb3cgZG8geW91IGV4cGVjdCB0
aGlzIHRvIHdvcmsgYXMgYSBtb2R1bGU/DQoNCk15IGZhdWx0LCBJIG1pc3NlZCBzb21lIHBhdGNo
ZXMuSSdsbCBhZGQgdGhlbSBpbiBuZXh0IHBhdGNoZXMuDQoNClRoZXNlIHNob3VsZCBiZSB0aHJl
ZSBwYXRjaGVzOg0KMS4gYnJlYWsgZXhpc3RpbmcgY29uZmlndXJhdGlvbnMgYW5kIGNyZWF0ZSBu
ZXcgY29uZmlnIGZvciB0aGVtDQoyLiBDaGFuZ2UgS2NvbmZpZyB0byBiZSBsb2FkYWJsZSBhcyBh
IG1vZHVsZSBhbmQgZW5zdXJlIGFsbCBwbGF0Zm9ybXMNCmFyZSBleGVjdXRhYmxlLg0KMy4gTWFr
ZSB0aGUgaXJxLW10ay1zeXNpcnEgZHJpdmVyIGFzIGEgbG9hZGFibGUga2VybmVsIG1vZHVsZSBm
b3IgR0tJDQphbmQgZmxleGliaWxpdHkuDQouDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudA0K
DQo+IA0KPiA+ICsJaGVscA0KPiA+ICsJICBJbnRlcnJ1cHQgcG9sYXJpdHkgY29udHJvbGxlciBk
cml2ZXIgdG8gc3dhcCBwb2xhcml0eSBmb3INCj4gPiArCSAgaW50ZXJydXB0cyBmb3IgTWVkaWF0
ZWsgbW9iaWxlIGNoaXBzLg0KPiA+ICsNCj4gPiArY29uZmlnIE1US19DSVJRDQo+ID4gKwlib29s
ICJNZWRpYXRlayBsb3ctcG93ZXIgaW50ZXJydXB0IGNvbnRyb2xsZXIiDQo+ID4gKwloZWxwDQo+
ID4gKwkgIExvdy1wb3dlciBpbnRlcnJ1cHQgY29udHJvbGxlciBkcml2ZXIgdG8gbW9uaXRvciBJ
UlFTDQo+ID4gKwkgIGluIHRoZSBzbGVlcCBtb2RlIGZvciBNZWRpYXRlayBtb2JpbGUgY2hpcHMu
DQo+ID4gKw0KPiA+ICBlbmRtZW51DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9N
YWtlZmlsZSBiL2RyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZQ0KPiA+IGluZGV4IDEzM2Y5YzQuLjMw
NDIxZDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlDQo+ID4gKysr
IGIvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlDQo+ID4gQEAgLTY5LDcgKzY5LDggQEAgb2JqLSQo
Q09ORklHX0JDTTcxMjBfTDJfSVJRKQkJKz0gaXJxLWJjbTcxMjAtbDIubw0KPiA+ICBvYmotJChD
T05GSUdfQlJDTVNUQl9MMl9JUlEpCQkrPSBpcnEtYnJjbXN0Yi1sMi5vDQo+ID4gIG9iai0kKENP
TkZJR19LRVlTVE9ORV9JUlEpCQkrPSBpcnEta2V5c3RvbmUubw0KPiA+ICBvYmotJChDT05GSUdf
TUlQU19HSUMpCQkJKz0gaXJxLW1pcHMtZ2ljLm8NCj4gPiAtb2JqLSQoQ09ORklHX0FSQ0hfTUVE
SUFURUspCQkrPSBpcnEtbXRrLXN5c2lycS5vIGlycS1tdGstY2lycS5vDQo+ID4gK29iai0kKENP
TkZJR19NVEtfU1lTSVJRKQkJKz0gaXJxLW10ay1zeXNpcnEubw0KPiA+ICtvYmotJChDT05GSUdf
TVRLX0NJUlEpCQkJKz0gaXJxLW10ay1jaXJxLm8NCj4gPiAgb2JqLSQoQ09ORklHX0FSQ0hfRElH
SUNPTE9SKQkJKz0gaXJxLWRpZ2ljb2xvci5vDQo+ID4gIG9iai0kKENPTkZJR19SRU5FU0FTX0g4
MzAwSF9JTlRDKQkrPSBpcnEtcmVuZXNhcy1oODMwMGgubw0KPiA+ICBvYmotJChDT05GSUdfUkVO
RVNBU19IOFNfSU5UQykJCSs9IGlycS1yZW5lc2FzLWg4cy5vDQo+IA0KPiBJbiBnZW5lcmFsLCB0
aGlzIGFwcHJvYWNoIGRvZXNuJ3QgbG9vayByaWdodC4gQXMgaXQgc3RhbmRzLCB0aGlzIGlzIGp1
c3QgDQo+IGJyZWFraW5nIGV4aXN0aW5nIGNvbmZpZ3VyYXRpb25zDQo+IA0KPiBEbyB5b3UgcmVh
bGx5IGV4cGVjdCB1c2VycyB0byBrbm93IGV4YWN0bHkgd2hpY2ggaW50ZXJydXB0IGNvbnRyb2xs
ZXJzIA0KPiB0aGVpciBzeXN0ZW0gaXMgZ29pbmcgdG8gdXNlPyBUaGlzIHNlZW1zIGxpa2UgdGhl
IHdyb25nIGFzc3VtcHRpb24uIElmIA0KPiB5b3UgcmVhbGx5IHdhbnQgdG8gc2F2ZSB0aGUgaGFu
ZGZ1bCBvZiBieXRlcyB0aGVzZSBkcml2ZXJzIHRha2UgaW4geW91ciANCj4gaW1hZ2UsIHRoZW4g
YWRkIHRoZSByZWxldmFudCBkZXBlbmRlbmN5IGluZm9ybWF0aW9uIGluIEtjb25maWcuDQo+IA0K
DQoxLiBUaGlzIHBhdGNoIHdpbGwgYWRkIGEgZGVwZW5kZW5jeSBvbiBpdCBpbiBLY29uZmlnLCB3
aGljaCBlbnN1cmVzIGFsbA0KcGxhdGZvcm1zIGFyZSBleGVjdXRhYmxlLg0KMi4gV2Ugd2FudCB0
byBmb2xsb3cgdGhlIEFuZHJvaWQgR0tJIGFuZCBhY2NvcmRpbmcgdG8gdGhlIHJlcXVpcmVtZW50
IG9mDQpHS0koR2VuZXJhbCBLZXJuZWwgSW1hZ2UpLCBhbGwgU29DIGFuZCBCb2FyZCBQZXJpcGhl
cmFsIGRyaXZlcnMgYXJlDQpsb2FkYWJsZSBrZXJuZWwgbW9kdWxlcy5zbyBJIG5lZWQgdG8gYnJl
YWtpbmcgZXhpc3RpbmcgY29uZmlndXJhdGlvbnMNCmFuZCBjcmVhdGUgbmV3IGNvbmZpZyBmb3Ig
dGhlbS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnQNCj4gICAgICAgICAgTS4NCg0K

