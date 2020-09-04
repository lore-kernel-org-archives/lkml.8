Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E79C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8792206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LFBdQODW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgIDHWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:22:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:32160 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgIDHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:22:07 -0400
X-UUID: 8743fc3680b14612b417bbee3ffd7d44-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qpQfU16O8C6LhsM/nHrr7bte2XTuSnob/XP3/krDZwg=;
        b=LFBdQODWlAP4WUYvMo2Tpc0YorgB3w0r58vyorJ7wT4DC0SZaEJUEhRQmIgwvbUr/xidIMfBTHnUpp+tFhjN1Czz5w7jnX92JANxgbmpPIarmD7bqWlMdWSKbgWiKlGVv1OQ5GkDH0z4qCWFyljEHssakIfimfSWQdlnIHG5unI=;
X-UUID: 8743fc3680b14612b417bbee3ffd7d44-20200904
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1879205951; Fri, 04 Sep 2020 15:22:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Sep
 2020 15:22:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 15:21:59 +0800
Message-ID: <1599204018.11403.34.camel@mhfsdcap03>
Subject: Re: [RFC PATCH 3/4] usb: xhci-mtk: add support runtime pm
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Date:   Fri, 4 Sep 2020 15:20:18 +0800
In-Reply-To: <1599203472.23494.3.camel@mtksdaap41>
References: <1599104065-8009-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599104065-8009-3-git-send-email-chunfeng.yun@mediatek.com>
         <1599203472.23494.3.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 049290813177FBCC7EF5C33060E3EF56D8F1174D51B04365B5F5824B1702E5142000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQpPbiBGcmksIDIwMjAtMDktMDQgYXQgMTU6MTEgKzA4MDAsIENLIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBPbiBUaHUsIDIwMjAtMDktMDMgYXQgMTE6MzQgKzA4MDAs
IENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBGcm9tOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KPiA+IA0KPiA+IGFkZCBzdXBwb3J0IHJ1bnRpbWUgcG0gZmVhdHVyZQ0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFpoYW55b25nIFdhbmcgPHpoYW55b25nLndhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIHwgNDQ2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvdXNi
L2hvc3QveGhjaS1tdGsuaCB8ICAxNCArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ1NSBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ICBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAw
NzU1IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuaA0KPiA+IA0KPiANCj4gW3NuaXBdDQo+IA0K
PiA+IEBAIC01NjIsNiArNzk0LDMxIEBAIHN0YXRpYyBpbnQgeGhjaV9tdGtfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290byBkZWFs
bG9jX3VzYjJfaGNkOw0KPiA+ICANCj4gPiArCUlOSVRfREVMQVlFRF9XT1JLKCZtdGstPnNlYWws
IHhoY2lfbXRrX3NlYWxfd29yayk7DQo+ID4gKwlzbnByaW50ZihtdGstPnNlYWxfZGVzY3IsIHNp
emVvZihtdGstPnNlYWxfZGVzY3IpLCAic2VhbCVzOnVzYiVkIiwNCj4gPiArCQkgaGNkLT5kcml2
ZXItPmRlc2NyaXB0aW9uLCBoY2QtPnNlbGYuYnVzbnVtKTsNCj4gPiArCXJldCA9IGRldm1fcmVx
dWVzdF9pcnEobXRrLT5zZWFsX2lycSwgJnhoY2lfbXRrX3NlYWxfaXJxLA0KPiA+ICsJCQkgIElS
UUZfVFJJR0dFUl9GQUxMSU5HLAltdGstPnNlYWxfZGVzY3IsIG10ayk7DQo+IA0KPiBJbiBpbnRl
cnJ1cHQuaCBbMV0sIGRldm1fcmVxdWVzdF9pcnEoKSBuZWVkIDYgcGFyYW1ldGVyczoNCj4gDQo+
IHN0YXRpYyBpbmxpbmUgaW50IF9fbXVzdF9jaGVjaw0KPiBkZXZtX3JlcXVlc3RfaXJxKHN0cnVj
dCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlycSwgaXJxX2hhbmRsZXJfdA0KPiBoYW5kbGVy
LA0KPiAJCSB1bnNpZ25lZCBsb25nIGlycWZsYWdzLCBjb25zdCBjaGFyICpkZXZuYW1lLCB2b2lk
ICpkZXZfaWQpDQo+IHsNCj4gCXJldHVybiBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwg
aXJxLCBoYW5kbGVyLCBOVUxMLCBpcnFmbGFncywNCj4gCQkJCQkgZGV2bmFtZSwgZGV2X2lkKTsN
Cj4gfQ0KPiANCldpbGwgZml4IGl0LCB0aGFua3MNCj4gDQo+IFsxXQ0KPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJl
ZS9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oP2g9djUuOS1yYzENCj4gDQo+IFJlZ2FyZHMsDQo+
IENLDQo+IA0KPiA+ICsJaWYgKHJldCAhPSAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJzZWFs
IHJlcXVlc3QgaW50ZXJydXB0ICVkIGZhaWxlZFxuIiwNCj4gPiArCQkJbXRrLT5zZWFsX2lycSk7
DQo+ID4gKwkJZ290byBkZWFsbG9jX3VzYjJfaGNkOw0KPiA+ICsJfQ0KPiA+ICsJeGhjaV9tdGtf
c2VhbF93YWtldXBfZW5hYmxlKG10aywgZmFsc2UpOw0KPiA+ICsNCj4gPiArCWRldmljZV9lbmFi
bGVfYXN5bmNfc3VzcGVuZChkZXYpOw0KPiA+ICsJeGhjaV9tdGtfcnVudGltZV9yZWFkeSA9IDE7
DQo+ID4gKw0KPiA+ICsJcmV0ID0gYWRkX3Bvd2VyX2F0dHJpYnV0ZXMoZGV2KTsNCj4gPiArCWlm
IChyZXQpDQo+ID4gKwkJZ290byBkZWFsbG9jX3VzYjJfaGNkOw0KPiA+ICsNCj4gPiArCXBtX3J1
bnRpbWVfbWFya19sYXN0X2J1c3koZGV2KTsNCj4gPiArCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNw
ZW5kKGRldik7DQo+ID4gKw0KPiA+ICsJZGV2X2RiZyhkZXYsICIlczogeGhjaV9tdGtfcnVudGlt
ZV9yZWFkeSAlaSIsDQo+ID4gKwkJIF9fZnVuY19fLCB4aGNpX210a19ydW50aW1lX3JlYWR5KTsN
Cj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgDQo+ID4gIGRlYWxsb2NfdXNiMl9oY2Q6DQo+
ID4gQEAgLTU4NCw3ICs4NDEsNyBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAl4aGNpX210a19sZG9zX2Rpc2FibGUobXRrKTsN
Cj4gPiAgDQo+ID4gIGRpc2FibGVfcG06DQo+ID4gLQlwbV9ydW50aW1lX3B1dF9zeW5jKGRldik7
DQo+ID4gKwlwbV9ydW50aW1lX3B1dF9zeW5jX2F1dG9zdXNwZW5kKGRldik7DQo+ID4gIAlwbV9y
dW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gDQo+IA0K
PiANCg0K

