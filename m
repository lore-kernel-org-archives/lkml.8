Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25DFC2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDDF2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lON8JTY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgIKCo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:44:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5105 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgIKCoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:44:25 -0400
X-UUID: 0da55f96606c4d7198a071f4c4f8a754-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iAPpf/+IfeWNrnv4nT68Qa9EWJFrb9ALmYG700BS52w=;
        b=lON8JTY2G3UpcWRMvKMJ5usICJPOsp6ElqmPDZ9LTYhU/UF8GkWsuz4zbdUDiLYfnWOh+cUC1HGyRCwGR308cViVb+/qC7nzhgPZl7EBqLbVR4dR4Wpi4e+rIB32FcZI1YYqby0Ky0ENOOP0PkvT8Xops2KMf9CjZSaMhzpgA9c=;
X-UUID: 0da55f96606c4d7198a071f4c4f8a754-20200911
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 840455332; Fri, 11 Sep 2020 10:44:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 10:44:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 10:44:12 +0800
Message-ID: <1599792140.14806.22.camel@mhfsdcap03>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Suman Anna <s-anna@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>
Date:   Fri, 11 Sep 2020 10:42:20 +0800
In-Reply-To: <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-4-crystal.guo@mediatek.com>
         <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
         <1599620279.14806.18.camel@mhfsdcap03>
         <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8500C517F22303B208341FCB4C1D5E487D29F35B29BB79172D43D9C13348FC582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTA5IGF0IDIzOjM5ICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiBP
biA5LzgvMjAgOTo1NyBQTSwgQ3J5c3RhbCBHdW8gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIwLTA5
LTAzIGF0IDA3OjQwICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiA+PiBIaSBDcnlzdGFsLA0K
PiA+Pg0KPiA+PiBPbiA4LzE2LzIwIDEwOjAzIFBNLCBDcnlzdGFsIEd1byB3cm90ZToNCj4gPj4+
IEludHJvZHVjZSB0aV9zeXNjb25fcmVzZXQoKSB0byBpbnRlZ3JhdGUgYXNzZXJ0IGFuZCBkZWFz
c2VydCB0b2dldGhlci4NCj4gPj4+IElmIHNvbWUgbW9kdWxlcyBuZWVkIGRvIHNlcmlhbGl6ZWQg
YXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRpb25zDQo+ID4+PiB0byByZXNldCBpdHNlbGYsIHJl
c2V0X2NvbnRyb2xfcmVzZXQgY2FuIGJlIGNhbGxlZCBmb3IgY29udmVuaWVuY2UuDQo+ID4+DQo+
ID4+IFRoZXJlIGFyZSBtdWx0aXBsZSBjaGFuZ2VzIGluIHRoaXMgc2FtZSBwYXRjaC4gSSB0aGlu
ayB5b3Ugc2hvdWxkIHNwbGl0IHRoaXMNCj4gPj4gZnVuY3Rpb25hbGl0eSBhd2F5IGZyb20gdGhl
IGNoYW5nZSBmb3IgdGhlIHJlZ21hcF91cGRhdGVfYml0cygpIHRvDQo+ID4+IHJlZ21hcF93cml0
ZV9iaXRzKCksIHNpbWlsYXIgdG8gd2hhdCB5b3UgaGF2ZSBkb25lIGluIHlvdXIgdjIgUGF0Y2gg
NC4NCj4gPj4NCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCj4gPiBJIHdp
bGwgc3BsaXQgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiA+IA0KPiA+Pj4NCj4g
Pj4+IFN1Y2ggYXMgcmVzZXQtcWNvbS1hb3NzLmMsIGl0IGludGVncmF0ZXMgYXNzZXJ0IGFuZCBk
ZWFzc2VydCB0b2dldGhlcg0KPiA+Pj4gYnkgJ3Jlc2V0JyBtZXRob2QuIE1USyBTb2NzIGFsc28g
bmVlZCB0aGlzIG1ldGhvZCB0byBwZXJmb3JtIHJlc2V0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQo+ID4+PiAtLS0N
Cj4gPj4+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9y
ZXNldC10aS1zeXNjb24uYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gPj4+
IGluZGV4IGEyNjM1YzIxZGI3Zi4uMDgyODkzNDJmOWFmIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJp
dmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9yZXNldC9y
ZXNldC10aS1zeXNjb24uYw0KPiA+Pj4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPj4+ICAgKiBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPiA+Pj4gICAqLw0KPiA+
Pj4gIA0KPiA+Pj4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+Pj4gICNpbmNsdWRlIDxs
aW51eC9tZmQvc3lzY29uLmg+DQo+ID4+PiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+
Pj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+Pj4gQEAgLTU2LDYgKzU3LDcgQEAgc3RydWN0
IHRpX3N5c2Nvbl9yZXNldF9kYXRhIHsNCj4gPj4+ICAJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0K
PiA+Pj4gIAlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2NvbnRyb2wgKmNvbnRyb2xzOw0KPiA+Pj4g
IAl1bnNpZ25lZCBpbnQgbnJfY29udHJvbHM7DQo+ID4+PiArCXVuc2lnbmVkIGludCByZXNldF9k
dXJhdGlvbl91czsNCj4gPj4+ICB9Ow0KPiA+Pj4gIA0KPiA+Pj4gICNkZWZpbmUgdG9fdGlfc3lz
Y29uX3Jlc2V0X2RhdGEocmNkZXYpCVwNCj4gPj4+IEBAIC04OSw3ICs5MSw3IEBAIHN0YXRpYyBp
bnQgdGlfc3lzY29uX3Jlc2V0X2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJj
ZGV2LA0KPiA+Pj4gIAltYXNrID0gQklUKGNvbnRyb2wtPmFzc2VydF9iaXQpOw0KPiA+Pj4gIAl2
YWx1ZSA9IChjb250cm9sLT5mbGFncyAmIEFTU0VSVF9TRVQpID8gbWFzayA6IDB4MDsNCj4gPj4+
ICANCj4gPj4+IC0JcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRy
b2wtPmFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gPj4+ICsJcmV0dXJuIHJlZ21hcF93
cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFs
dWUpOw0KPiA+Pj4gIH0NCj4gPj4+ICANCj4gPj4+ICAvKioNCj4gPj4+IEBAIC0xMjAsNyArMTIy
LDcgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQoc3RydWN0IHJlc2V0X2Nv
bnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPj4+ICAJbWFzayA9IEJJVChjb250cm9sLT5kZWFzc2Vy
dF9iaXQpOw0KPiA+Pj4gIAl2YWx1ZSA9IChjb250cm9sLT5mbGFncyAmIERFQVNTRVJUX1NFVCkg
PyBtYXNrIDogMHgwOw0KPiA+Pj4gIA0KPiA+Pj4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRz
KGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+
ID4+PiArCXJldHVybiByZWdtYXBfd3JpdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmRl
YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiA+Pj4gIH0NCj4gPj4+ICANCj4gPj4+ICAv
KioNCj4gPj4+IEBAIC0xNTgsOSArMTYwLDI2IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0
X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+Pj4gIAkJIShj
b250cm9sLT5mbGFncyAmIFNUQVRVU19TRVQpOw0KPiA+Pj4gIH0NCj4gPj4+ICANCj4gPj4+ICtz
dGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJj
ZGV2LA0KPiA+Pj4gKwkJCQkgIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4+PiArew0KPiA+Pj4gKwlz
dHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgKmRhdGEgPSB0b190aV9zeXNjb25fcmVzZXRfZGF0
YShyY2Rldik7DQo+ID4+PiArCWludCByZXQ7DQo+ID4+PiArDQo+ID4+PiArCXJldCA9IHRpX3N5
c2Nvbl9yZXNldF9hc3NlcnQocmNkZXYsIGlkKTsNCj4gPj4+ICsJaWYgKHJldCkNCj4gPj4+ICsJ
CXJldHVybiByZXQ7DQo+ID4+PiArDQo+ID4+PiArCWlmIChkYXRhLT5yZXNldF9kdXJhdGlvbl91
cykNCj4gPj4+ICsJCXVzbGVlcF9yYW5nZShkYXRhLT5yZXNldF9kdXJhdGlvbl91cywgZGF0YS0+
cmVzZXRfZHVyYXRpb25fdXMgKiAyKTsNCj4gPj4+ICsNCj4gPj4+ICsJcmV0dXJuIHRpX3N5c2Nv
bl9yZXNldF9kZWFzc2VydChyY2RldiwgaWQpOw0KPiA+Pg0KPiA+PiBJIGVjaG8gUGhpbGlwcCdz
IGNvbW1lbnRzIFsxXSBmcm9tIHlvdXIgb3JpZ2luYWwgdjEgc2VyaWVzIGFib3V0IHRoaXMuIFdl
IGRvbid0DQo+ID4+IG5lZWQgYSBwcm9wZXJ0eSB0byBkaXN0aW5ndWlzaCB0aGlzLCBidXQgeW91
IGNvdWxkIGFkZCBhIGZsYWcgdXNpbmcgbWF0Y2ggZGF0YQ0KPiA+PiBhbmQgTWVkaWF0ZWsgY29t
cGF0aWJsZSwgYW5kIHVzZSB0aGF0IHdpdGhpbiB0aGlzIGZ1bmN0aW9uLCBvciBvcHRpb25hbGx5
IHNldA0KPiA+PiB0aGlzIG9wcyBiYXNlZCBvbiBjb21wYXRpYmxlICh3aGF0ZXZlciBpcyBwcmVm
ZXJyZWQgYnkgUGhpbGlwcCkuDQo+ID4+DQo+ID4+IHJlZ2FyZHMNCj4gPj4gU3VtYW4NCj4gPj4N
Cj4gPj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY29tbWVudC8yMzUxOTE5My8N
Cj4gPj4NCj4gPiBIaSBTdW1hbiwgUGhpbGlwcA0KPiA+IA0KPiA+IFdoaWNoIG1ldGhvZCB3b3Vs
ZCB5b3UgcmVjb21tZW5kIG1vcmU/DQo+ID4gMS4gbGlrZSB2MiBwYXRjaCwgYnV0IGFzc2lnbiB0
aGUgZmxhZyAiZGF0YS0+YXNzZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyIg0KPiA+IGRpcmVjdGx5ICht
YXliZSByZW5hbWUgImFzc2VydF9kZWFzc2VydF90b2dldGhlciIgdG8NCj4gPiAicmVzZXRfb3Bf
YXZhaWxhYmxlIikNCj4gPiANCj4gPiAyLiB1c2UgTWVkaWF0ZWsgY29tcGF0aWJsZSB0byBkZWNp
ZGUgdGhlIHJlc2V0IGhhbmRsZXIgYXZhaWxhYmxlIG9yIG5vdC4NCj4gDQo+IEkgd291bGQgZ28g
d2l0aCB0aGlzIG9wdGlvbi4gQW55d2F5LCBJIHRoaW5rIHlvdSBtaWdodCBoYXZlIHRvIGFkZCB0
aGUgcmVzZXQgU29DDQo+IGRhdGEgYXMgd2VsbCwgYmFzZWQgb24gUm9iJ3MgY29tbWVudCBvbiB0
aGUgYmluZGluZy4NCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCg0KDQpUaGFua3MgZm9yIHlvdXIg
c3VnZ2VzdGlvbnMNCkkgd2lsbCBhZGQgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIGluIHRoZSBuZXh0
IHZlcnNpb24sIA0KcGxlYXNlIGNvcnJlY3QgbWUgaWYgdGhlcmUgaXMgYW55IG1pc3VuZGVyc3Rh
bmRpbmcuDQoxKS4gcmV2ZXJ0IHRpLXN5c2Nvbi1yZXNldC50eHQgYWRkIGEgbmV3IG1lZGlhdGVr
IHJlc2V0IGJpbmRpbmcgZG9jLg0KMikuIHNwbGl0IHRoZSBwYXRjaCBbdjQsMy80XSB3aXRoIHRo
ZSBjaGFuZ2UgZm9yIHRoZQ0KcmVnbWFwX3VwZGF0ZV9iaXRzKCkgdG8gcmVnbWFwX3dyaXRlX2Jp
dHMoKSBhbmQgdGhlIGNoYW5nZSB0byBpbnRlZ3JhdGUNCmFzc2VydCBhbmQgZGVhc3NlcnQgdG9n
ZXRoZXIuDQozKS4gYWRkIHRoZSByZXNldCBTb0MgZGF0YSwgd2hpY2ggY29udGFpbnMgdGhlIGZs
YWcgInJlc2V0X29wX2F2YWlsYWJsZSINCnRvIGRlY2lkZSB0aGUgcmVzZXQgaGFuZGxlciBhdmFp
bGFibGUgb3Igbm90Lg0KNCkuIHNlcGFyYXRlIHRoZSBkdHMgcGF0Y2ggZnJvbSB0aGlzIHBhdGNo
IHNldHMNCg0KPiA+IA0KPiA+IFRoYW5rcw0KPiA+IENyeXN0YWwNCj4gPiANCj4gPj4+ICt9DQo+
ID4+PiArDQo+ID4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0aV9z
eXNjb25fcmVzZXRfb3BzID0gew0KPiA+Pj4gIAkuYXNzZXJ0CQk9IHRpX3N5c2Nvbl9yZXNldF9h
c3NlcnQsDQo+ID4+PiAgCS5kZWFzc2VydAk9IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydCwNCj4g
Pj4+ICsJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwNCj4gPj4+ICAJLnN0YXR1cwkJPSB0aV9z
eXNjb25fcmVzZXRfc3RhdHVzLA0KPiA+Pj4gIH07DQo+ID4+PiAgDQo+ID4+PiBAQCAtMjA0LDYg
KzIyMyw5IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4+PiAgCQljb250cm9sc1tpXS5mbGFncyA9IGJlMzJfdG9fY3B1
cChsaXN0KyspOw0KPiA+Pj4gIAl9DQo+ID4+PiAgDQo+ID4+PiArCW9mX3Byb3BlcnR5X3JlYWRf
dTMyKHBkZXYtPmRldi5vZl9ub2RlLAkicmVzZXQtZHVyYXRpb24tdXMiLA0KPiA+Pj4gKwkJCQkm
ZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMpOw0KPiA+Pj4gKw0KPiA+Pj4gIAlkYXRhLT5yY2Rldi5v
cHMgPSAmdGlfc3lzY29uX3Jlc2V0X29wczsNCj4gPj4+ICAJZGF0YS0+cmNkZXYub3duZXIgPSBU
SElTX01PRFVMRTsNCj4gPj4+ICAJZGF0YS0+cmNkZXYub2Zfbm9kZSA9IG5wOw0KPiA+Pj4NCj4g
Pj4NCj4gPiANCj4gDQoNCg==

