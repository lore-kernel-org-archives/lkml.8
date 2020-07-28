Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A3DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C9820829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgG1Fxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:53:45 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:36589 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726711AbgG1Fxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:53:45 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 28 Jul
 2020 13:53:40 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 28 Jul
 2020 13:53:39 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Tue, 28 Jul 2020 13:53:39 +0800
From:   WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHWYB9U257QN8g5QkeL/njIDTUWtqkTBUEAgAAltoCAAMldgIAAFeWAgAC+AoCAAAr2gIAABd6AgAFUpvCAAGn8AIAF7CVQ
Date:   Tue, 28 Jul 2020 05:53:39 +0000
Message-ID: <0b5dc3873aca42199f769e82288a2b3b@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
        <20200722124414.GA3153105@kroah.com>
        <20200722145913.GB1310843@rowland.harvard.edu>
        <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
        <20200722221817.542971a2@x1.home>
        <20200723153821.GC1352396@rowland.harvard.edu>
        <20200723101735.3222c289@w520.home>
        <20200723163835.GA1357775@rowland.harvard.edu>
        <11a7a3e67d6c40cd9fd06cd4d6300283@zhaoxin.com>
 <20200724131708.0a0f3358@x1.home>
In-Reply-To: <20200724131708.0a0f3358@x1.home>
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

DQpPbiBGcmksIDI0IEp1bCAyMDIwIDE5OjE3OjQ5ICswMDAwIEFsZXggd3JvdGU6DQo+IE9uIEZy
aSwgMjQgSnVsIDIwMjAgMTI6NTc6NDkgKzAwMDANCj4gV2VpdGFvV2FuZy1vYyA8V2VpdGFvV2Fu
Zy1vY0B6aGFveGluLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIFRodSwgMjMgSnVsIDIwMjAgMTI6
Mzg6MjEgLTA0MDAsIEFsYW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEp1bCAyMywgMjAyMCBhdCAx
MDoxNzozNUFNIC0wNjAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6DQo+ID4gPiA+IFRoZSBJT01N
VSBncm91cGluZyByZXN0cmljdGlvbiBkb2VzIHNvbHZlIHRoZSBoYXJkd2FyZSBpc3N1ZSwgc28g
bG9uZw0KPiA+ID4gPiBhcyBvbmUgZHJpdmVyIGRvZXNuJ3QgYmxpbmRseSBhc3N1bWUgdGhlIGRy
aXZlciBwcml2YXRlIGRhdGEgZm9yDQo+ID4gPiA+IGFub3RoZXIgZGV2aWNlIGFuZCBtb2RpZnkg
aXQuDQo+ID4gPg0KPiA+ID4gQ29ycmVjdGlvbjogVGhlIElPTU1VIGdyb3VwaW5nIHJlc3RyaWN0
aW9uIHNvbHZlcyB0aGUgaGFyZHdhcmUgaXNzdWUgZm9yDQo+ID4gPiB2ZmlvLXBjaS4gIEl0IHdv
bid0IG5lY2Vzc2FyaWx5IGhlbHAgaWYgc29tZSBvdGhlciBkcml2ZXIgY29tZXMgYWxvbmcNCj4g
PiA+IGFuZCB3YW50cyB0byBiaW5kIHRvIHRoaXMgaGFyZHdhcmUuDQo+ID4gPg0KPiA+ID4gPiAg
IEkgZG8gYWdyZWUgdGhhdCB5b3VyIHNvbHV0aW9uIHdvdWxkDQo+ID4gPiA+IHdvcmssIHJlcXVp
cmluZyBhbGwgZGV2aWNlcyBhcmUgdW5ib3VuZCBiZWZvcmUgYW55IGNhbiBiZSBib3VuZCwgYnV0
IGl0DQo+ID4gPiA+IGFsc28gc2VlbXMgZGlmZmljdWx0IHRvIG1hbmFnZS4gIFRoZSBpc3N1ZSBp
cyBsYXJnZWx5IHVuaXF1ZSB0byBVU0INCj4gPiA+ID4gQUZBSUsuICBPbiB0aGUgb3RoZXIgaGFu
ZCwgZHJpdmVycyBjb29yZGluYXRpbmcgd2l0aCBlYWNoIG90aGVyIHRvDQo+ID4gPiA+IHJlZ2lz
dGVyIHRoZWlyIF9wcml2YXRlXyBkYXRhIGFzIHNoYXJlLWFibGUgd2l0aGluIGEgc2V0IG9mIGRy
aXZlcnMNCj4gPiA+ID4gc2VlbXMgbGlrZSBhIG11Y2ggbW9yZSBkaXJlY3QgYW5kIGV4cGxpY2l0
IGludGVyYWN0aW9uIGJldHdlZW4gdGhlDQo+ID4gPiA+IGRyaXZlcnMuICBUaGFua3MsDQo+ID4g
Pg0KPiA+ID4gWWVzLCB0aGF0IG1ha2VzIHNlbnNlLiAgQnV0IGl0IHdvdWxkIGhhdmUgdG8gYmUg
aW1wbGVtZW50ZWQgaW4gdGhlDQo+ID4gPiBkcml2ZXIgY29yZSwgbm90IGluIHBhcnRpY3VsYXIg
c3Vic3lzdGVtcyBsaWtlIFVTQiBvciBQQ0kuICBBbmQgaXQgbWlnaHQNCj4gPiA+IGJlIHNlZW4g
YXMgb3ZlcmtpbGwsIGdpdmVuIHRoYXQgb25seSBVSENJL09IQ0kvRUhDSSBkZXZpY2VzIHJlcXVp
cmUgdGhpcw0KPiA+ID4gc29ydCBvZiBzaGFyaW5nIEFGQUlLLg0KPiA+ID4NCj4gPiA+IEFsc28s
IHdoZW4geW91IHRoaW5rIGFib3V0IGl0LCB3aGF0IGZvcm0gd291bGQgc3VjaCBjb29yZGluYXRp
b24gYW1vbmcNCj4gPiA+IGRyaXZlcnMgdGFrZT8gIEZyb20geW91ciBkZXNjcmlwdGlvbiwgaXQg
c291bmRzIGxpa2UgdGhlIGRyaXZlcnMgd291bGQNCj4gPiA+IGFncmVlIHRvIGF2b2lkIGFjY2Vz
c2luZyBlYWNoIG90aGVyJ3MgcHJpdmF0ZSBkYXRhIGlmIHRoZSBwcm9wZXINCj4gPiA+IHJlZ2lz
dHJhdGlvbiB3YXNuJ3QgaW4gcGxhY2UuDQo+ID4gPg0KPiA+ID4gT24gdGhlIG90aGVyIGhhbmQs
IGEgc3Ryb25nZXIgYW5kIHBlcmhhcHMgbW9yZSByb2J1c3QgYXBwcm9hY2ggd291bGQgYmUNCj4g
PiA+IHRvIGVuZm9yY2UgdGhlIGNvbmRpdGlvbiB0aGF0IG5vbi1jb29wZXJhdGluZyBkcml2ZXJz
IGFyZSBuZXZlciBib3VuZCB0bw0KPiA+ID4gZGV2aWNlcyBpbiB0aGUgc2FtZSBncm91cCBhdCB0
aGUgc2FtZSB0aW1lLiAgVGhhdCdzIGJhc2ljYWxseSB3aGF0IEknbQ0KPiA+ID4gcHJvcG9zaW5n
IGhlcmUgLS0gdGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhlIGVuZm9yY2VtZW50IHNob3VsZCBi
ZQ0KPiA+ID4gaW5zdGl0dXRlZCBpbiB0aGUga2VybmVsIG9yIHNob3VsZCBtZXJlbHkgYmUgcGFy
dCBvZiBhIHN0YW5kYXJkIHByb3RvY29sDQo+ID4gPiBmb2xsb3dlZCBieSB1c2Vyc3BhY2UgZHJp
dmVycy4NCj4gPiA+DQo+ID4gPiBHaXZlbiB0aGF0IGl0J3MgY3VycmVudGx5IG5lZWRlZCBpbiBv
bmx5IG9uZSBwbGFjZSwgaXQgc2VlbXMgcmVhc29uYWJsZQ0KPiA+ID4gdG8gbGVhdmUgdGhpcyBh
cyBhICJnZW50bGVtZW4ncyBhZ3JlZW1lbnQiIGluIHVzZXJzcGFjZSBmb3IgdGhlIHRpbWUNCj4g
PiA+IGJlaW5nIGluc3RlYWQgb2YgYWRkaW5nIGl0IHRvIHRoZSBrZXJuZWwuDQo+ID4gPg0KPiA+
DQo+ID4gUHJvdmlkZWQgdGhhdCBFSENJIGFuZCBVSENJIGhvc3QgY29udHJvbGxlciBkZWNsYXJl
IG5vdCBzdXBwb3J0IFAyUCBhbmQNCj4gPiBBQ1MuIFNvLCB3ZSBjYW4gYXNzaWduIEVIQ0kgYW5k
IFVIQ0kgaG9zdCBjb250cm9sbGVyIHRvIGRpZmZlcmVudCBJT01NVQ0KPiA+IGdyb3VwIHNlcGFy
YXRlbHkuIFdlIGFzc2lnbiBFSENJIGhvc3QgY29udHJvbGxlciB0byBob3N0IGFuZCBhc3NpZ24g
VUhDSQ0KPiA+IGhvc3QgY29udHJvbGxlciB0byBWTS4gVGhlbiwgZWhjaV9oY2QgZHJpdmVyIGxv
YWQvdW5sb2FkIG9wZXJhdGlvbiBpbiBob3N0DQo+ID4gd2lsbCBjYXVzZSB0aGUgc2FtZSBpc3N1
ZSBhcyBkaXNjdXNzZWQNCj4gDQo+IEFuZCB5b3UgaGF2ZSBhbiBleGFtcGxlIG9mIHN1Y2ggYSBk
ZXZpY2U/ICBJIGV4cGVjdCB0aGVzZSBkbyBub3QgZXhpc3QsDQo+IG5vciBzaG91bGQgdGhleS4g
IEl0IHNlZW1zIGxpa2UgaXQgd291bGQgYmUgYW4gaW1wcm9wZXIgdXNlIG9mIEFDUy4NCj4gVGhh
bmtzLA0KDQoNCkluIGtlcm5lbCBzb3VyY2UgY29kZSB0cmVlIGRyaXZlcnMvcGNpL3F1aXJrcy5j
LA0KVGhlcmUgaXMgYSBkZXZpY2UgbGlzdCBkZWNsYXJlZCBieSBwY2lfZGV2X2Fjc19lbmFibGVk
LiBJbiB3aGljaCBsaXN0LCBzdWNoIGFzIA0KbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdpdGhvdXQg
YWNzIGNhcGFiaWxpdHkgbm90IGFsbG93IHBlZXItdG8tcGVlciBiZXd0ZWVuIA0KZnVuY3Rpb25z
LiBUaG9zZSBkZXZpY2UgY2FuIGJlIGFzc2lnbiB0byB0byBkaWZmZXJlbnQgSU9NTVUgZ3JvdXAg
c2VwYXJhdGVseS4NCg0KVGhuYWtzDQp3ZWl0YW8NCg0K
