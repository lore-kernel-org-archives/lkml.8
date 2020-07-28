Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999CB20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgG1WOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:14:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:10749 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgG1WOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:14:11 -0400
IronPort-SDR: xEyjuCZdsjkdLxYIkgH50JKxnGcnDqnahF+8XJO+kUpEvDGr/Tb9JCjbuH7JzBzL+W7X7MIyIi
 VZhbPUyPnlWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151307322"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="151307322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 15:14:10 -0700
IronPort-SDR: NbnzTPSe2NOhYeGEpnMNwkndvI/jhtemJ2wLW4LcjB092rQNN9oLvHxdDatpCliz6qofE0J4Zc
 bZlNXdQfu8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="434483126"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2020 15:14:09 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 15:14:09 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 01:14:07 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 01:14:07 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: RE: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Topic: [char-misc-next] Revert "mei: hdcp: Replace one-element array
 with flexible-array member"
Thread-Index: AQHWZSfolBoy0+Wd50OY4DSCzkXDIakdV1+AgAAxzgD//9MtAIAAMULw
Date:   Tue, 28 Jul 2020 22:14:06 +0000
Message-ID: <398e20e8c3f7436bb50d671b9aa9f809@intel.com>
References: <20200728214139.3129532-1-tomas.winkler@intel.com>
 <e80a9e75-4497-1587-deab-b5c6a0fcc48f@embeddedor.com>
 <8ec7601780b542c2bc0168e03749ec0e@intel.com>
 <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
In-Reply-To: <d6ef8ca4-6e11-b758-0e24-75301e1a5303@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI5
LCAyMDIwIDAxOjE1DQo+IFRvOiBXaW5rbGVyLCBUb21hcyA8dG9tYXMud2lua2xlckBpbnRlbC5j
b20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBDYzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxn
dXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbY2hhci1taXNjLW5leHRdIFJl
dmVydCAibWVpOiBoZGNwOiBSZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5DQo+IHdpdGggZmxleGli
bGUtYXJyYXkgbWVtYmVyIg0KPiANCj4gDQo+IA0KPiBPbiA3LzI4LzIwIDE3OjAxLCBXaW5rbGVy
LCBUb21hcyB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+
DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyOSwgMjAyMCAwMDo1Nw0KPiA+PiBUbzogV2lu
a2xlciwgVG9tYXMgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPjsgR3JlZyBLcm9haC1IYXJ0bWFu
DQo+ID4+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4gQ2M6IFVzeXNraW4sIEFs
ZXhhbmRlciA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPjsgbGludXgtDQo+ID4+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IEd1c3Rhdm8gQSAuIFIgLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJu
ZWwub3JnPg0KPiA+PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0XSBSZXZlcnQgIm1laTog
aGRjcDogUmVwbGFjZSBvbmUtZWxlbWVudA0KPiA+PiBhcnJheSB3aXRoIGZsZXhpYmxlLWFycmF5
IG1lbWJlciINCj4gPj4NCj4gPj4gSGkgVG9tYXMsDQo+ID4+DQo+ID4+IE9uIDcvMjgvMjAgMTY6
NDEsIFRvbWFzIFdpbmtsZXIgd3JvdGU6DQo+ID4+PiBHcmVnIHBsZWFzZSByZXZlcnQsIHRoaXMg
Y29tbWl0IGl0IGNoYW5nZXMgc2l6ZSBvZiBzdHJ1Y3QNCj4gPj4+IHdpcmVkX2NtZF9yZXBlYXRl
cl9hdXRoX3N0cmVhbV9yZXFfaW4sIHRoaXMgaXMgbm90IHdoYXQgZmlybXdhcmUgaXMNCj4gPj4+
IGV4cGVjdGluZy4NCj4gPj4NCj4gPj4gQ291bGQgeW91IGVsYWJvcmF0ZSBvbiB3aGF0J3MgdGhl
IGZpcm13YXJlIGV4cGVjdGluZywgZXhhY3RseT8NCj4gPiBzdHJ1Y3Qgd2lyZWRfY21kX3JlcGVh
dGVyX2F1dGhfc3RyZWFtX3JlcV9pbiB7DQo+ID4gICAtCXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90
eXBlCXN0cmVhbXNbMV07DQo+ID4gICArIAlzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZQlzdHJl
YW1zW107DQo+ID4gfQ0KPiA+DQo+ID4gQnV0IHRoZW4geW91IGhhdmUsIHdoaWNoIHlvdSBoYXZl
bid0IGNoYW5nZWQgdG8gKyAxIGJ5dGUgPQ0KPiA+IG1laV9jbGRldl9zZW5kKGNsZGV2LCAodTgg
KikmdmVyaWZ5X21wcmltZV9pbiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplb2YodmVyaWZ5X21wcmltZV9pbikpOw0KPiA+DQo+IA0KPiBJIHNlZSwgdGhpcyBpcyB0aGUg
a2luZCBvZiBmZWVkYmFjayBJIG5lZWQgZnJvbSBwZW9wbGUgdGhhdCBrbm93cyB0aGUgY29kZQ0K
PiBiZXR0ZXIuIFRoYW5rcyENCj4gDQo+ID4gQnV0IHRoYXQncyBub3QgdGhlIG1ham9yIHBvaW50
LiBQb2ludCBpcyB0aGF0IHdlIHNob3VsZCBiZSBhYmxlIHRvDQo+ID4gcmV2aWV3IGFuZCB0ZXN0
IHRoZSBjb2RlIGJlZm9yZSBpdCBpcyBtZXJnZWQuICBZb3UgaGF2ZW4ndCBydW4gaXQsIHJpZ2h0
Pw0KPiA+IFRoZXJlIGlzIE1BSU5UQUlORVJTIGZpbGUgZm9yIGEgcmVhc29uLg0KPiA+DQo+IA0K
PiBJJ20gdXNpbmcgdGhpcyBjb21tYW5kOg0KPiANCj4gJCBzY3JpcHRzL2dldF9tYWludGFpbmVy
LnBsIC0tbm9rZXl3b3JkcyAtLW5vZ2l0IC0tbm9naXQtZmFsbGJhY2sNCj4gDQo+IGFuZCB0aGlz
IGlzIHRoZSBvdXRwdXQgZm9yIGJvdGggZmlsZXM6DQo+IA0KPiAkIHNjcmlwdHMvZ2V0X21haW50
YWluZXIucGwgLS1ub2tleXdvcmRzIC0tbm9naXQgLS1ub2dpdC1mYWxsYmFjaw0KPiBkcml2ZXJz
L21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0K
PiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJVkVSUykgR3JlZyBLcm9haC1IYXJ0bWFuDQo+
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gKHN1cHBvcnRlcjpDSEFSIGFuZCBNSVNDIERS
SVZFUlMpIGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3QpICQgc2Ny
aXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLW5va2V5d29yZHMgLS0NCj4gbm9naXQgLS1ub2dpdC1m
YWxsYmFjayBkcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuaCBBcm5kIEJlcmdtYW5uDQo+
IDxhcm5kQGFybmRiLmRlPiAoc3VwcG9ydGVyOkNIQVIgYW5kIE1JU0MgRFJJVkVSUykgR3JlZyBL
cm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gKHN1cHBvcnRlcjpD
SEFSIGFuZCBNSVNDIERSSVZFUlMpIGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnIChv
cGVuIGxpc3QpDQoNCg0KPiBGb3Igc29tZSByZWFzb24geW91IGRvbid0IGFwcGVhciBvbiB0aGUg
bGlzdCBhYm92ZS4gRG8geW91IHNlZSBhbnl0aGluZw0KPiB3cm9uZyB3aXRoIHRoZSBjb21tYW5k
IEknbSBydW5uaW5nIHRvIGdldCB0aGUgbWFpbnRhaW5lcnMgYW5kIGxpc3RzPw0KDQpOb3Qgc3Vy
ZSwgaXQgc2hvdWxkIGJlIGNhdWdodCBieSBkcml2ZXJzL21pc2MvbWVpLyogPyAgDQpNYXliZSBp
dCBpcyBub3QgcmVjdXJzaXZlPyBOZWVkIHRvIGNoZWNrIHRoZSBzY3JpcHQsIA0KZnJhbmtseSBJ
IHVzdWFsbHkgY2hlY2sgdGhpcyBtYW51YWxseS4gDQoNCklOVEVMIE1BTkFHRU1FTlQgRU5HSU5F
IChtZWkpDQpNOiAgICAgIFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0K
TDogICAgICBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTOiAgICAgIFN1cHBvcnRlZA0K
RjogICAgICBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvbWVpLyoNCkY6ICAgICAgZHJpdmVycy9t
aXNjL21laS8qDQpGOiAgICAgIGRyaXZlcnMvd2F0Y2hkb2cvbWVpX3dkdC5jDQpGOiAgICAgIGlu
Y2x1ZGUvbGludXgvbWVpX2NsX2J1cy5oDQpGOiAgICAgIGluY2x1ZGUvdWFwaS9saW51eC9tZWku
aA0KRjogICAgICBzYW1wbGVzL21laS8qDQoNCg0KPiANCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rh
dm8NCj4gDQo+ID4+DQo+ID4+PiBJIHJlYWxseSBkbyBub3QgYXBwcmVjaWF0ZSB0aGF0IHRoZSBj
b2RlIGlzIGJ5cGFzc2luZyBkcml2ZXINCj4gPj4+IG1haW50YW5lciByZXZpZXcsIEkgdGhpbmsg
dGhpcyBpcyBhIG1pbmltdW0gd2UgY2FuIGFzayBmb3IsIHRoaXMgaXMNCj4gPj4+IG5vdCBmb3Ig
YSBmaXJzdCB0aW1lLg0KPiA+Pj4NCj4gPj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYzU2OTY3ZDY3
NGUzNjFlYmU3MTZlNjY5OTJlM2M1MzMyYjI1YWMxZi4NCj4gPj4+DQo+ID4+PiBDYzogR3VzdGF2
byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+ID4+PiAtLS0NCj4g
Pj4+ICBkcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYyB8IDIgKy0NCj4gPj4+IGRyaXZl
cnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oIHwgMiArLQ0KPiA+Pj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+Pj4gYi9kcml2ZXJzL21p
c2MvbWVpL2hkY3AvbWVpX2hkY3AuYw0KPiA+Pj4gaW5kZXggZDFkM2UwMjVjYTBlLi5lNmMzZGM1
OTU2MTcgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2hkY3AvbWVpX2hkY3Au
Yw0KPiA+Pj4gKysrIGIvZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNwLmMNCj4gPj4+IEBA
IC01NzIsNyArNTcyLDcgQEAgc3RhdGljIGludCBtZWlfaGRjcF92ZXJpZnlfbXByaW1lKHN0cnVj
dCBkZXZpY2UNCj4gPj4gKmRldiwNCj4gPj4+ICAJICAgICAgIEhEQ1BfMl8yX01QUklNRV9MRU4p
Ow0KPiA+Pj4gIAlkcm1faGRjcF9jcHVfdG9fYmUyNCh2ZXJpZnlfbXByaW1lX2luLnNlcV9udW1f
bSwgZGF0YS0NCj4gc2VxX251bV9tKTsNCj4gPj4+ICAJbWVtY3B5KHZlcmlmeV9tcHJpbWVfaW4u
c3RyZWFtcywgZGF0YS0+c3RyZWFtcywNCj4gPj4+IC0JICAgICAgIGFycmF5X3NpemUoZGF0YS0+
aywgc2l6ZW9mKCpkYXRhLT5zdHJlYW1zKSkpOw0KPiA+Pj4gKwkgICAgICAgKGRhdGEtPmsgKiBz
aXplb2Yoc3RydWN0IGhkY3AyX3N0cmVhbWlkX3R5cGUpKSk7DQo+ID4+Pg0KPiA+Pj4gIAl2ZXJp
ZnlfbXByaW1lX2luLmsgPSBjcHVfdG9fYmUxNihkYXRhLT5rKTsNCj4gPj4+DQo+ID4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9oZGNwL21laV9oZGNwLmgNCj4gPj4+IGIvZHJpdmVy
cy9taXNjL21laS9oZGNwL21laV9oZGNwLmgNCj4gPj4+IGluZGV4IDgzNDc1N2Y1ZTA3Mi4uMThm
ZmM3NzNmYTE4IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9taXNjL21laS9oZGNwL21laV9o
ZGNwLmgNCj4gPj4+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvaGRjcC9tZWlfaGRjcC5oDQo+ID4+
PiBAQCAtMzU4LDcgKzM1OCw3IEBAIHN0cnVjdCB3aXJlZF9jbWRfcmVwZWF0ZXJfYXV0aF9zdHJl
YW1fcmVxX2luDQo+IHsNCj4gPj4+ICAJdTgNCj4gPj4gCXNlcV9udW1fbVtIRENQXzJfMl9TRVFf
TlVNX0xFTl07DQo+ID4+PiAgCXU4CQkJCW1fcHJpbWVbSERDUF8yXzJfTVBSSU1FX0xFTl07DQo+
ID4+PiAgCV9fYmUxNgkJCQlrOw0KPiA+Pj4gLQlzdHJ1Y3QgaGRjcDJfc3RyZWFtaWRfdHlwZQlz
dHJlYW1zW107DQo+ID4+PiArCXN0cnVjdCBoZGNwMl9zdHJlYW1pZF90eXBlCXN0cmVhbXNbMV07
DQo+ID4+PiAgfSBfX3BhY2tlZDsNCj4gPj4+DQo+ID4+PiAgc3RydWN0IHdpcmVkX2NtZF9yZXBl
YXRlcl9hdXRoX3N0cmVhbV9yZXFfb3V0IHsNCj4gPj4+DQo=
