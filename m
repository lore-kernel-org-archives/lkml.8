Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FCEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FC520825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgGWDOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:14:03 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:31809 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgGWDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:14:02 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 23:14:01 EDT
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 23 Jul
 2020 10:58:55 +0800
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 23 Jul
 2020 10:58:55 +0800
Received: from zxbjmbx2.zhaoxin.com ([fe80::4d77:9dba:64a8:8ec3]) by
 zxbjmbx2.zhaoxin.com ([fe80::4d77:9dba:64a8:8ec3%4]) with mapi id
 15.01.1979.003; Thu, 23 Jul 2020 10:58:55 +0800
From:   "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
CC:     "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
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
Thread-Index: AQHWYB9UCUIuPM0Yq0GNAP42GB7Bv6kTBUEAgAFuGyA=
Date:   Thu, 23 Jul 2020 02:58:54 +0000
Message-ID: <e09986ccb3de4b219d1768e24dd89aa8@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722124414.GA3153105@kroah.com>
In-Reply-To: <20200722124414.GA3153105@kroah.com>
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

oaGhoQ0KT24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgMDI6NDQ6MTRQTSArMDIwMCwgR3JlZyBLSCB3
cm90ZToNCj4gT24gV2VkLCBKdWwgMjIsIDIwMjAgYXQgMDc6NTc6NDhQTSArMDgwMCwgV2VpdGFv
V2FuZ29jIHdyb3RlOg0KPiA+IFRoaXMgYnVnIGlzIGZvdW5kIGluIFpoYW94aW4gcGxhdGZvcm0s
IGJ1dCBpdCdzIGEgY29tbW9tIGNvZGUgYnVnLg0KPiA+IEZhaWwgc2VxdWVuY2U6DQo+ID4gc3Rl
cDE6IFVuYmluZCBVSENJIGNvbnRyb2xsZXIgZnJvbSBuYXRpdmUgZHJpdmVyOw0KPiA+IHN0ZXAy
OiBCaW5kIFVIQ0kgY29udHJvbGxlciB0byB2ZmlvLXBjaSwgd2hpY2ggd2lsbCBwdXQgVUhDSSBj
b250cm9sbGVyIGluIG9uZQ0KPiB2ZmlvDQo+ID4gICAgICAgIGdyb3VwJ3MgZGV2aWNlIGxpc3Qg
YW5kIHNldCBVSENJJ3MgZGV2LT5kcml2ZXJfZGF0YSB0byBzdHJ1Y3QNCj4gdmZpby1wY2koZm9y
IFVIQ0kpDQo+DQo+IEhhaCwgdGhhdCB3b3Jrcz8gIEhvdyBkbyB5b3UgZG8gdGhhdCBwcm9wZXJs
eT8gIFdoYXQgY29kZSBkb2VzIHRoYXQ/DQoNCkRyaXZlcnMvdmZpby92ZmlvLmMNClRoZSBmdW5j
dGlvbiB2ZmlvX2dyb3VwX2NyZWF0ZV9kZXZpY2Ugd2lsbCBzZXQgVUhDSSBkZXYtPmRyaXZlcl9k
YXRhDQp0byB2ZmlvLWRldmljZSBzdHJ1Y3QuDQoNCj4gPiBzdGVwMzogVW5iaW5kIEVIQ0kgY29u
dHJvbGxlciBmcm9tIG5hdGl2ZSBkcml2ZXIsIHdpbGwgdHJ5IHRvIHRlbGwgVUhDSSBuYXRpdmUN
Cj4gZHJpdmVyDQo+ID4gICAgICAgIHRoYXQgIkknbSByZW1vdmVkIGJ5IHNldCBjb21wYW5pb25f
aGNkLT5zZWxmLmhzX2NvbXBhbmlvbiB0bw0KPiBOVUxMLiBIb3dldmVyLA0KPiA+ICAgICAgICBj
b21wYW5pb25faGNkIGdldCBmcm9tIFVIQ0kncyBkZXYtPmRyaXZlcl9kYXRhIHRoYXQgaGFzIG1v
ZGlmaWVkDQo+IGJ5IHZmaW8tcGNpDQo+ID4gICAgICAgIGFscmVhZHkuU28sIHRoZSB2ZmlvLXBj
aSBzdHJ1Y3R1cmUgd2lsbCBiZSBkYW1hZ2VkIQ0KPg0KPiBCZWNhdXNlIHlvdSBhcmUgbWVzc2lu
ZyBhcm91bmQgd2l0aCBiaW5kL3VuYmluZCAiYnkgaGFuZCIsIHdoaWNoIGlzDQo+IG5ldmVyIGd1
YXJhbnRlZWQgdG8gd29yayBwcm9wZXJseS4NCj4NCj4gSXQncyBhbWF6aW5nIGFueSBvZiB0aGF0
IHdvcmtzIGF0IGFsbC4uLg0KDQpJZiBhZGp1c3QgdGhlIHNlcXVlbmNlIG9mIFVIQ0kvRUhDSSB1
bmJpbmQgZm9ybSBuYXRpdmUgZHJpdmVyLCB0aGF0DQpjYW4gYXZvaWQgTnVsbCBQb2ludGVyIGRl
cmVmZXJlbmNlLiBFZy4gU3RlcDMtLT5zdGV0NC0tPnN0ZXAxLS0+c3RlcDIuDQpPdXIgZXhwZXJp
bWVudHMgcHJvdmUgdGhhdCB0aGlzIHNlcXVlbmNlIGlzIGluZGVlZCBnb29kIGFzIGV4cGVjdGVk
Lg0KSG93ZXZlciwgc29tZSBhcHBsaWNhdGlvbiBzb2Z0d2FyZSBzdWNoIGFzIHZpcnQtbWFuYWdl
ci9xZW11IGFzc2lnbg0KL0VIQ0kgdG8gZ3Vlc3QgT1MgaGFzIHRoZSBzYW1lIGJpbmQvdW5iaW5k
IHNlcXVlbmNlIGFzIHRlc3QgobBieSBoYW5kobEuDQoNCj4gNC4xOS42NS0yMDIwMDUxOTE3LXJh
aW5vcyAjMQ0KPg0KPiA0LjE5IGlzIGEgYml0IG9sZCwgd2hhdCBhYm91dCA1Ljc/DQoNCjUuNy43
IGhhcyB0aGUgc2FtZSBpc3N1ZS4NCg0KPiA+ICsjZGVmaW5lIFBDSV9ERVZfRFJWX0ZMQUcgICAg
ICAgMg0KPg0KPiBXaHkgaXMgdGhlIFVTQiBjb3JlIGFsbG93ZWQgdG8gdG91Y2ggYSBwcml2YXRl
IFBDSSBzdHJ1Y3R1cmUgZmllbGQ/DQo+DQo+IEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgYWxsb3dl
ZC4NCj4NCj4gQW5kIHdoeSBpcyB0aGlzIGEgVVNCIGhvc3QgY29udHJvbGxlci1zcGVjaWZpYyBp
c3N1ZSwgc2hvdWxkbid0IHRoaXMNCj4gdHlwZSBvZiB0aGluZyBiZSBmaXhlZCBpbiB0aGUgUENJ
IGNvcmU/DQoNCldoZW4gZWhjaSBoY2RfZHJpdmVyIGJpbmQgb3IgdW5iaW5kIHRvIGVoY2ksIGl0
IHdpbGwgdG91Y2gvbW9kaWZ5IFVIQ0kgdXNiX2hjZA0KdGhhdCBnZXQgZnJvbSBVSENJJ3MgZGV2
LT5kcml2ZXJfZGF0YS4gSG93ZXZlciwgVUhDSSBtYXliZSBiaW5kIHRvIGENCmFub3RoZXIgZHJp
dmVyKHZmaW8tcGNpKSBhbmQgaXQncyBkcml2ZXJfZGF0YSB3aWxsIGJlIHJld3JpdHRlbi4gd2hh
dCB3ZQ0Kc2hvdWxkIGRvIGlzIHRvIHByZXZlbnQgZWhjaV9oY2QgdG8gbW9kaWZ5IFVIQ0kncyBk
ZXYtPmRyaXZlcl9kYXRhIHdoZW4gVUhDSQ0KaGFzIGFscmVhZHkgYm91bmQgdG8gdmZpby1wY2ku
DQoNClRoYW5rcw0Kd2VpdGFvd2FuZw0KDQoNCg0KsaPD3Mn5w/ejug0Ksb7Tyrz+uqzT0LGjw9y7
8teo09DQxc+io6y99rmp1ri2qMrVvP7Iy8q508Oho9HPvfu21LG+08q8/rvyxuTE2sjd1/bIzrrO
zrS+rcrayKi1xLLp1MShosq508Ohori01sa78teqt6Khow0KQ09ORklERU5USUFMIE5PVEU6DQpU
aGlzIGVtYWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZpbGVnZWQgaW5m
b3JtYXRpb24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVkIHJlY2lwaWVu
dC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBmb3J3YXJkaW5nIG9m
IHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9o
aWJpdGVkLg0K
