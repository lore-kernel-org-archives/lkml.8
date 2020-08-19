Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558652063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHSDkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:40:19 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:59215 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgHSDkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:40:17 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 23:39:03 EDT
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 11:23:53 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 11:23:52 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Wed, 19 Aug 2020 11:23:52 +0800
From:   TimGuo-oc <TimGuo-oc@zhaoxin.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        "wwt8723@163.com" <wwt8723@163.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBVU0I6Rml4IGtlcm5lbCBOVUxMIHBvaW50ZXIgd2hl?=
 =?gb2312?Q?n_unbind_UHCI_form_vfio-pci?=
Thread-Topic: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Thread-Index: AQHWYQdPpMijr9jMqE2P97wKJvHDmakU0WGAgAAF3oCAKhJ/4A==
Date:   Wed, 19 Aug 2020 03:23:52 +0000
Message-ID: <b796fcc26f0b4ce4bc454fee090ad47e@zhaoxin.com>
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
x-originating-ip: [10.29.8.26]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1haWwtLS0tLQ0KPiBTZW5kZXIgOiBBbGFuIFN0ZXJuIDxzdGVybkBy
b3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiBUaW1lIDogMjAyMC83LzI0ICAwOjM5DQo+IFJlY2VpdmVy
IDogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4gQ0MgOiBX
ZWl0YW8gV2FuZyhCSi1SRCkgPFdlaXRhb1dhbmdAemhhb3hpbi5jb20+OyBHcmVnIEtIDQo+IDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFdlaXRhb1dhbmctb2MNCj4gPFdlaXRhb1dhbmct
b2NAemhhb3hpbi5jb20+OyBtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbTsNCj4gdWxmLmhh
bnNzb25AbGluYXJvLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsgaHNsZXN0ZXI5NkBnbWFpbC5jb207
DQo+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IENhcnN0ZW5fU2NobWlkQG1lbnRvci5jb207IGVmcmVtb3ZAbGludXguY29tOyBUb255
IFcuIFdhbmcoWEEtUkQpDQo+IDxUb255V1dhbmdAemhhb3hpbi5jb20+OyBDb2JlIENoZW4oQkot
UkQpIDxDb2JlQ2hlbkB6aGFveGluLmNvbT47DQo+IFRpbSBHdW8oQkotUkQpIDxUaW1HdW9Aemhh
b3hpbi5jb20+OyB3d3Q4NzIzQDE2My5jb20NCj4gU3ViamVjdCA6IFJlOiBbUEFUQ0hdIFVTQjpG
aXgga2VybmVsIE5VTEwgcG9pbnRlciB3aGVuIHVuYmluZCBVSENJIGZvcm0gdmZpby1wY2kNCj4g
DQo+IE9uIFRodSwgSnVsIDIzLCAyMDIwIGF0IDEwOjE3OjM1QU0gLTA2MDAsIEFsZXggV2lsbGlh
bXNvbiB3cm90ZToNCj4gPiBUaGUgSU9NTVUgZ3JvdXBpbmcgcmVzdHJpY3Rpb24gZG9lcyBzb2x2
ZSB0aGUgaGFyZHdhcmUgaXNzdWUsIHNvIGxvbmcNCj4gPiBhcyBvbmUgZHJpdmVyIGRvZXNuJ3Qg
YmxpbmRseSBhc3N1bWUgdGhlIGRyaXZlciBwcml2YXRlIGRhdGEgZm9yDQo+ID4gYW5vdGhlciBk
ZXZpY2UgYW5kIG1vZGlmeSBpdC4NCj4gDQo+IENvcnJlY3Rpb246IFRoZSBJT01NVSBncm91cGlu
ZyByZXN0cmljdGlvbiBzb2x2ZXMgdGhlIGhhcmR3YXJlIGlzc3VlIGZvcg0KPiB2ZmlvLXBjaS4g
IEl0IHdvbid0IG5lY2Vzc2FyaWx5IGhlbHAgaWYgc29tZSBvdGhlciBkcml2ZXIgY29tZXMgYWxv
bmcgYW5kIHdhbnRzDQo+IHRvIGJpbmQgdG8gdGhpcyBoYXJkd2FyZS4NCj4gDQo+ID4gICBJIGRv
IGFncmVlIHRoYXQgeW91ciBzb2x1dGlvbiB3b3VsZA0KPiA+IHdvcmssIHJlcXVpcmluZyBhbGwg
ZGV2aWNlcyBhcmUgdW5ib3VuZCBiZWZvcmUgYW55IGNhbiBiZSBib3VuZCwgYnV0DQo+ID4gaXQg
YWxzbyBzZWVtcyBkaWZmaWN1bHQgdG8gbWFuYWdlLiAgVGhlIGlzc3VlIGlzIGxhcmdlbHkgdW5p
cXVlIHRvIFVTQg0KPiA+IEFGQUlLLiAgT24gdGhlIG90aGVyIGhhbmQsIGRyaXZlcnMgY29vcmRp
bmF0aW5nIHdpdGggZWFjaCBvdGhlciB0bw0KPiA+IHJlZ2lzdGVyIHRoZWlyIF9wcml2YXRlXyBk
YXRhIGFzIHNoYXJlLWFibGUgd2l0aGluIGEgc2V0IG9mIGRyaXZlcnMNCj4gPiBzZWVtcyBsaWtl
IGEgbXVjaCBtb3JlIGRpcmVjdCBhbmQgZXhwbGljaXQgaW50ZXJhY3Rpb24gYmV0d2VlbiB0aGUN
Cj4gPiBkcml2ZXJzLiAgVGhhbmtzLA0KPiANCj4gWWVzLCB0aGF0IG1ha2VzIHNlbnNlLiAgQnV0
IGl0IHdvdWxkIGhhdmUgdG8gYmUgaW1wbGVtZW50ZWQgaW4gdGhlIGRyaXZlciBjb3JlLA0KPiBu
b3QgaW4gcGFydGljdWxhciBzdWJzeXN0ZW1zIGxpa2UgVVNCIG9yIFBDSS4gIEFuZCBpdCBtaWdo
dCBiZSBzZWVuIGFzIG92ZXJraWxsLA0KPiBnaXZlbiB0aGF0IG9ubHkgVUhDSS9PSENJL0VIQ0kg
ZGV2aWNlcyByZXF1aXJlIHRoaXMgc29ydCBvZiBzaGFyaW5nIEFGQUlLLg0KPiANCj4gQWxzbywg
d2hlbiB5b3UgdGhpbmsgYWJvdXQgaXQsIHdoYXQgZm9ybSB3b3VsZCBzdWNoIGNvb3JkaW5hdGlv
biBhbW9uZyBkcml2ZXJzDQo+IHRha2U/ICBGcm9tIHlvdXIgZGVzY3JpcHRpb24sIGl0IHNvdW5k
cyBsaWtlIHRoZSBkcml2ZXJzIHdvdWxkIGFncmVlIHRvIGF2b2lkDQo+IGFjY2Vzc2luZyBlYWNo
IG90aGVyJ3MgcHJpdmF0ZSBkYXRhIGlmIHRoZSBwcm9wZXIgcmVnaXN0cmF0aW9uIHdhc24ndCBp
biBwbGFjZS4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBhIHN0cm9uZ2VyIGFuZCBwZXJoYXBz
IG1vcmUgcm9idXN0IGFwcHJvYWNoIHdvdWxkIGJlIHRvDQo+IGVuZm9yY2UgdGhlIGNvbmRpdGlv
biB0aGF0IG5vbi1jb29wZXJhdGluZyBkcml2ZXJzIGFyZSBuZXZlciBib3VuZCB0byBkZXZpY2Vz
DQo+IGluIHRoZSBzYW1lIGdyb3VwIGF0IHRoZSBzYW1lIHRpbWUuICBUaGF0J3MgYmFzaWNhbGx5
IHdoYXQgSSdtIHByb3Bvc2luZyBoZXJlDQo+IC0tIHRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHRo
ZSBlbmZvcmNlbWVudCBzaG91bGQgYmUgaW5zdGl0dXRlZCBpbiB0aGUga2VybmVsIG9yDQo+IHNo
b3VsZCBtZXJlbHkgYmUgcGFydCBvZiBhIHN0YW5kYXJkIHByb3RvY29sIGZvbGxvd2VkIGJ5IHVz
ZXJzcGFjZSBkcml2ZXJzLg0KPiANCj4gR2l2ZW4gdGhhdCBpdCdzIGN1cnJlbnRseSBuZWVkZWQg
aW4gb25seSBvbmUgcGxhY2UsIGl0IHNlZW1zIHJlYXNvbmFibGUgdG8gbGVhdmUNCj4gdGhpcyBh
cyBhICJnZW50bGVtZW4ncyBhZ3JlZW1lbnQiIGluIHVzZXJzcGFjZSBmb3IgdGhlIHRpbWUgYmVp
bmcgaW5zdGVhZCBvZg0KPiBhZGRpbmcgaXQgdG8gdGhlIGtlcm5lbC4NCkJ1dCBRZW11IGFuZCBW
aXJ0LW1hbmFnZXIgZG9uJ3QgY29tcGx5IHdpdGggdGhpcyAiZ2VudGxlbWVuJ3MgYWdyZWVtZW50
IiBldmVuIGlmIHRoZSBFSENJIGFuZCBVSENJIHNpdCBpbiB0aGUgc2FtZSBJT01NVSBncm91cC4g
DQpBbmQgdGhlIGN1cnJlbnQgYmVoYXZpb3Igb2YgUWVtdSBhbmQgbGludXggVVNCIGRyaXZlciB3
aWxsIGNhdXNlIGEgY2F0YXN0cm9waGUuIA0KTWF5YmUgdGhlIGhhY2tlcnMgY2FuIHVzZSB0aGlz
IEJVRyB0byBhdHRhY2sgdGhlIGNvbXB1dGVyLg0KV2Ugc2hvdWxkbid0IGJlbGlldmUgdGhlIFZN
TSBhbHdheXMgY29tcGx5IHdpdGggdGhlICJnZW50bGVtZW4ncyBhZ3JlZW1lbnQiLCBJIHRoaW5r
Lg0KPiANCj4gQWxhbiBTdGVybg0K
