Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236AAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13E2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d5UVI0cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbgF3LD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:03:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60755 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729924AbgF3LD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:03:26 -0400
X-UUID: b09a279ec0ae4986aea6504e62e75534-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=95kISZUSvb1i6OWzMABsaIUaNlAlruFq+xXF6/0ThCQ=;
        b=d5UVI0cDtCN5mJT9R0W64vMR7q1TVlSamYwBrxPshjmdLLEIgX2V1ZDieKn0VbY3mpE01KjpnKXcOJmX2jQ7XGCv4NvzAZc/8FV2sLjAfJ4lU6856rmkhkxxn4px3AaebX7Z4o39GN0jDBDl6tiDgeLIVsVChX2f/izYb6ZEm3Y=;
X-UUID: b09a279ec0ae4986aea6504e62e75534-20200630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 108669166; Tue, 30 Jun 2020 19:03:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:03:20 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:03:19 +0800
Message-ID: <1593514941.13270.6.camel@mbjsdccf07>
Subject: Re: [PATCH v5 09/10] iommu/mediatek: Modify MMU_CTRL register
 setting
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Yong Wu" <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 30 Jun 2020 19:02:21 +0800
In-Reply-To: <e063a5d2-8edc-9cf9-4872-d3f4abb1e481@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-10-chao.hao@mediatek.com>
         <e063a5d2-8edc-9cf9-4872-d3f4abb1e481@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDEyOjI4ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjkvMDYvMjAyMCAwOToxMywgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gTVQ4MTcz
IGlzIGRpZmZlcmVudCBmcm9tIG90aGVyIFNvQ3MgZm9yIE1NVV9DVFJMIHJlZ2lzdGVyLg0KPiA+
IEZvciBtdDgxNzMsIGl0cyBiaXQ5IGlzIGluX29yZGVyX3dyaXRlX2VuIGFuZCBkb2Vzbid0IHVz
ZSBpdHMNCj4gPiBkZWZhdWx0IDEnYjEuPiBGb3Igb3RoZXIgU29DcywgYml0WzEyXSByZXByZXNl
bnRzIHZpY3RpbV90bGJfZW4gZmVhdHVyZSBhbmQNCj4gPiB2aWN0aW1fdGxiIGlzIGVuYWJsZSBk
ZWZhdWx0bHkoYml0WzEyXT0xKSwgaWYgd2UgdXNlDQo+ID4gInJlZ3ZhbCA9IEZfTU1VX1RGX1BS
T1RfVE9fUFJPR1JBTV9BRERSIiwgdmljdGltX3RsYiB3aWxsIGJlDQo+ID4gZGlzYWJsZWQsIGl0
IHdpbGwgZHJvcCBpb21tdSBwZXJmb3JtYWNlLg0KPiA+IFNvIHdlIG5lZWQgdG8gZGVhbCB3aXRo
IHRoZSBzZXR0aW5nIG9mIE1NVV9DVFJMIHNlcGFyYXRlbHkNCj4gPiBmb3IgbXQ4MTczIGFuZCBv
dGhlcnMuDQo+ID4gDQo+IA0KPiBNeSBwcm9wb3NhbCB0byByZXdyaXRlIHRoZSBjb21taXQgbWVz
c2FnZToNCj4gDQo+IFRoZSBNTVVfQ1RSTCByZWdpc2VyIG9mIE1UODE3MyBpcyBkaWZmZXJlbnQg
ZnJvbSBvdGhlciBTb0NzLiBUaGUgaW5fb3JkZXJfd3JfZW4NCj4gaXMgYml0WzldIHdoaWNoIGlz
IHplcm8gYnkgZGVmYXVsdC4NCj4gT3RoZXIgU29DcyBoYXZlIHRoZSB2aXRjaW1fdGxiX2VuIGZl
YXR1cmUgbWFwcGVkIHRvIGJpdFsxMl0uIFRoaXMgYml0IGlzIHNldCB0bw0KPiBvbmUgYnkgZGVm
YXVsdC4gV2UgbmVlZCB0byBwcmVzZXJ2ZSB0aGUgYml0IHdoZW4gc2V0dGluZw0KPiBGX01NVV9U
Rl9QUk9UX1RPX1BST0dSQU1fQUREUiBhcyBvdGhlcndpc2UgdGhlIGJpdCB3aWxsIGJlIGNsZWFy
ZWQgYW5kIElPTU1VDQo+IHBlcmZvcm1hbmNlIHdpbGwgZHJvcC4NCg0KZ290IGl0LCB0aGFua3Mg
Zm9yIHlvdXIgYWR2aWNlIHZlcnkgbXVjaC4NCg0KPiANCj4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBN
YXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+IFN1Z2dlc3RlZC1i
eTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hh
byBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCA4Mjk5YTMy
OTkwOTAuLmU0NmUyZGVlZTNmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC01NDMs
MTEgKzU0MywxMiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBt
dGtfaW9tbXVfZGF0YSAqZGF0YSkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+ICAN
Cj4gPiArCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfQ1RSTF9S
RUcpOw0KPiANCj4gVGhlIHJlYWQgaXMgb25seSBuZWVkZWQgaW4gdGhlIGVsc2UgYnJhbmNoLg0K
PiANCm9rLCB0aGFua3MNCg0KPiA+ICAJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0g
TTRVX01UODE3MykNCj4gPiAgCQlyZWd2YWwgPSBGX01NVV9QUkVGRVRDSF9SVF9SRVBMQUNFX01P
RCB8DQo+ID4gIAkJCSBGX01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUl9NVDgxNzM7DQo+ID4g
IAllbHNlDQo+ID4gLQkJcmVndmFsID0gRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFI7DQo+
ID4gKwkJcmVndmFsIHw9IEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERSOw0KPiA+ICAJd3Jp
dGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQo+ID4g
IA0KPiA+ICAJcmVndmFsID0gRl9MMl9NVUxJVF9ISVRfRU4gfA0KPiA+IA0KDQo=

