Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA20CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE95D2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:57:54 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:30619 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726235AbgGXM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:57:54 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 24 Jul
 2020 20:57:50 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 24 Jul
 2020 20:57:49 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Fri, 24 Jul 2020 20:57:49 +0800
From:   WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "hslester96@gmail.com" <hslester96@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carsten_Schmid@mentor.com" <Carsten_Schmid@mentor.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "Tony W. Wang(XA-RD)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBVU0I6Rml4IGtlcm5lbCBOVUxMIHBvaW50ZXIgd2hl?=
 =?gb2312?Q?n_unbind_UHCI_form_vfio-pci?=
Thread-Topic: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Thread-Index: AQHWYB9U257QN8g5QkeL/njIDTUWtqkTBUEAgAAltoCAAMldgIAAFeWAgAC+AoCAAAr2gIAABd6AgAFUpvA=
Date:   Fri, 24 Jul 2020 12:57:49 +0000
Message-ID: <11a7a3e67d6c40cd9fd06cd4d6300283@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722124414.GA3153105@kroah.com>
 <20200722145913.GB1310843@rowland.harvard.edu>
 <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
 <20200722221817.542971a2@x1.home>
 <20200723153821.GC1352396@rowland.harvard.edu>
 <20200723101735.3222c289@w520.home>
 <20200723163835.GA1357775@rowland.harvard.edu>
In-Reply-To: <20200723163835.GA1357775@rowland.harvard.edu>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.32]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIzIEp1bCAyMDIwIDEyOjM4OjIxIC0wNDAwLCBBbGFuIHdyb3RlOg0KPiBPbiBU
aHUsIEp1bCAyMywgMjAyMCBhdCAxMDoxNzozNUFNIC0wNjAwLCBBbGV4IFdpbGxpYW1zb24gd3Jv
dGU6DQo+ID4gVGhlIElPTU1VIGdyb3VwaW5nIHJlc3RyaWN0aW9uIGRvZXMgc29sdmUgdGhlIGhh
cmR3YXJlIGlzc3VlLCBzbyBsb25nDQo+ID4gYXMgb25lIGRyaXZlciBkb2Vzbid0IGJsaW5kbHkg
YXNzdW1lIHRoZSBkcml2ZXIgcHJpdmF0ZSBkYXRhIGZvcg0KPiA+IGFub3RoZXIgZGV2aWNlIGFu
ZCBtb2RpZnkgaXQuDQo+IA0KPiBDb3JyZWN0aW9uOiBUaGUgSU9NTVUgZ3JvdXBpbmcgcmVzdHJp
Y3Rpb24gc29sdmVzIHRoZSBoYXJkd2FyZSBpc3N1ZSBmb3INCj4gdmZpby1wY2kuICBJdCB3b24n
dCBuZWNlc3NhcmlseSBoZWxwIGlmIHNvbWUgb3RoZXIgZHJpdmVyIGNvbWVzIGFsb25nDQo+IGFu
ZCB3YW50cyB0byBiaW5kIHRvIHRoaXMgaGFyZHdhcmUuDQo+IA0KPiA+ICAgSSBkbyBhZ3JlZSB0
aGF0IHlvdXIgc29sdXRpb24gd291bGQNCj4gPiB3b3JrLCByZXF1aXJpbmcgYWxsIGRldmljZXMg
YXJlIHVuYm91bmQgYmVmb3JlIGFueSBjYW4gYmUgYm91bmQsIGJ1dCBpdA0KPiA+IGFsc28gc2Vl
bXMgZGlmZmljdWx0IHRvIG1hbmFnZS4gIFRoZSBpc3N1ZSBpcyBsYXJnZWx5IHVuaXF1ZSB0byBV
U0INCj4gPiBBRkFJSy4gIE9uIHRoZSBvdGhlciBoYW5kLCBkcml2ZXJzIGNvb3JkaW5hdGluZyB3
aXRoIGVhY2ggb3RoZXIgdG8NCj4gPiByZWdpc3RlciB0aGVpciBfcHJpdmF0ZV8gZGF0YSBhcyBz
aGFyZS1hYmxlIHdpdGhpbiBhIHNldCBvZiBkcml2ZXJzDQo+ID4gc2VlbXMgbGlrZSBhIG11Y2gg
bW9yZSBkaXJlY3QgYW5kIGV4cGxpY2l0IGludGVyYWN0aW9uIGJldHdlZW4gdGhlDQo+ID4gZHJp
dmVycy4gIFRoYW5rcywNCj4gDQo+IFllcywgdGhhdCBtYWtlcyBzZW5zZS4gIEJ1dCBpdCB3b3Vs
ZCBoYXZlIHRvIGJlIGltcGxlbWVudGVkIGluIHRoZQ0KPiBkcml2ZXIgY29yZSwgbm90IGluIHBh
cnRpY3VsYXIgc3Vic3lzdGVtcyBsaWtlIFVTQiBvciBQQ0kuICBBbmQgaXQgbWlnaHQNCj4gYmUg
c2VlbiBhcyBvdmVya2lsbCwgZ2l2ZW4gdGhhdCBvbmx5IFVIQ0kvT0hDSS9FSENJIGRldmljZXMg
cmVxdWlyZSB0aGlzDQo+IHNvcnQgb2Ygc2hhcmluZyBBRkFJSy4NCj4gDQo+IEFsc28sIHdoZW4g
eW91IHRoaW5rIGFib3V0IGl0LCB3aGF0IGZvcm0gd291bGQgc3VjaCBjb29yZGluYXRpb24gYW1v
bmcNCj4gZHJpdmVycyB0YWtlPyAgRnJvbSB5b3VyIGRlc2NyaXB0aW9uLCBpdCBzb3VuZHMgbGlr
ZSB0aGUgZHJpdmVycyB3b3VsZA0KPiBhZ3JlZSB0byBhdm9pZCBhY2Nlc3NpbmcgZWFjaCBvdGhl
cidzIHByaXZhdGUgZGF0YSBpZiB0aGUgcHJvcGVyDQo+IHJlZ2lzdHJhdGlvbiB3YXNuJ3QgaW4g
cGxhY2UuDQo+IA0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgYSBzdHJvbmdlciBhbmQgcGVyaGFwcyBt
b3JlIHJvYnVzdCBhcHByb2FjaCB3b3VsZCBiZQ0KPiB0byBlbmZvcmNlIHRoZSBjb25kaXRpb24g
dGhhdCBub24tY29vcGVyYXRpbmcgZHJpdmVycyBhcmUgbmV2ZXIgYm91bmQgdG8NCj4gZGV2aWNl
cyBpbiB0aGUgc2FtZSBncm91cCBhdCB0aGUgc2FtZSB0aW1lLiAgVGhhdCdzIGJhc2ljYWxseSB3
aGF0IEknbQ0KPiBwcm9wb3NpbmcgaGVyZSAtLSB0aGUgcXVlc3Rpb24gaXMgd2hldGhlciB0aGUg
ZW5mb3JjZW1lbnQgc2hvdWxkIGJlDQo+IGluc3RpdHV0ZWQgaW4gdGhlIGtlcm5lbCBvciBzaG91
bGQgbWVyZWx5IGJlIHBhcnQgb2YgYSBzdGFuZGFyZCBwcm90b2NvbA0KPiBmb2xsb3dlZCBieSB1
c2Vyc3BhY2UgZHJpdmVycy4NCj4gDQo+IEdpdmVuIHRoYXQgaXQncyBjdXJyZW50bHkgbmVlZGVk
IGluIG9ubHkgb25lIHBsYWNlLCBpdCBzZWVtcyByZWFzb25hYmxlDQo+IHRvIGxlYXZlIHRoaXMg
YXMgYSAiZ2VudGxlbWVuJ3MgYWdyZWVtZW50IiBpbiB1c2Vyc3BhY2UgZm9yIHRoZSB0aW1lDQo+
IGJlaW5nIGluc3RlYWQgb2YgYWRkaW5nIGl0IHRvIHRoZSBrZXJuZWwuDQo+IAkNCg0KUHJvdmlk
ZWQgdGhhdCBFSENJIGFuZCBVSENJIGhvc3QgY29udHJvbGxlciBkZWNsYXJlIG5vdCBzdXBwb3J0
IFAyUCBhbmQNCkFDUy4gU28sIHdlIGNhbiBhc3NpZ24gRUhDSSBhbmQgVUhDSSBob3N0IGNvbnRy
b2xsZXIgdG8gZGlmZmVyZW50IElPTU1VIA0KZ3JvdXAgc2VwYXJhdGVseS4gV2UgYXNzaWduIEVI
Q0kgaG9zdCBjb250cm9sbGVyIHRvIGhvc3QgYW5kIGFzc2lnbiBVSENJDQpob3N0IGNvbnRyb2xs
ZXIgdG8gVk0uIFRoZW4sIGVoY2lfaGNkIGRyaXZlciBsb2FkL3VubG9hZCBvcGVyYXRpb24gaW4g
aG9zdA0Kd2lsbCBjYXVzZSB0aGUgc2FtZSBpc3N1ZSBhcyBkaXNjdXNzZWQNCg0KVGhhbmtzDQpX
ZWl0YW8NCg0K
