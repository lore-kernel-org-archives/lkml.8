Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F57F206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QY77KP/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIDHLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:11:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47363 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727795AbgIDHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:11:19 -0400
X-UUID: e9ce884ed9b14b899a923bdd79913ccf-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CyHUeypPO/Ndn/UWpqExQLdOaqCCxuHfTXODMb4fNLY=;
        b=QY77KP/GPYLBitsHIpnBNeB3FQ67IpyyY9NmFS2Z24kMHBNBVcPxFgVXXDwv1lxCf+j1t4txJlifnOIuI3ZeZAXJDUGkw+qy3FC49dFHbO+4fiNQCL39PppoqOHj2eqXbgLd9GaCJ6QuWeBL298+N30sBe/YEa0XroQZSnctOOU=;
X-UUID: e9ce884ed9b14b899a923bdd79913ccf-20200904
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1393952801; Fri, 04 Sep 2020 15:11:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 15:11:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 15:11:11 +0800
Message-ID: <1599203472.23494.3.camel@mtksdaap41>
Subject: Re: [RFC PATCH 3/4] usb: xhci-mtk: add support runtime pm
From:   CK Hu <ck.hu@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Date:   Fri, 4 Sep 2020 15:11:12 +0800
In-Reply-To: <1599104065-8009-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1599104065-8009-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599104065-8009-3-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 96AC799E9DAA4A371347207BBDCE3525EE2928E9616996B2C6A4D0A8CF3D57042000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENodW5mZW5nOg0KDQpPbiBUaHUsIDIwMjAtMDktMDMgYXQgMTE6MzQgKzA4MDAsIENodW5m
ZW5nIFl1biB3cm90ZToNCj4gRnJvbTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gDQo+
IGFkZCBzdXBwb3J0IHJ1bnRpbWUgcG0gZmVhdHVyZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhh
bnlvbmcgV2FuZyA8emhhbnlvbmcud2FuZ0BtZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCA0NDYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuaCB8ICAxNCAr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgZHJpdmVycy91c2IvaG9zdC94aGNpLW10
ay5oDQo+IA0KDQpbc25pcF0NCg0KPiBAQCAtNTYyLDYgKzc5NCwzMSBAQCBzdGF0aWMgaW50IHho
Y2lfbXRrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCkN
Cj4gIAkJZ290byBkZWFsbG9jX3VzYjJfaGNkOw0KPiAgDQo+ICsJSU5JVF9ERUxBWUVEX1dPUkso
Jm10ay0+c2VhbCwgeGhjaV9tdGtfc2VhbF93b3JrKTsNCj4gKwlzbnByaW50ZihtdGstPnNlYWxf
ZGVzY3IsIHNpemVvZihtdGstPnNlYWxfZGVzY3IpLCAic2VhbCVzOnVzYiVkIiwNCj4gKwkJIGhj
ZC0+ZHJpdmVyLT5kZXNjcmlwdGlvbiwgaGNkLT5zZWxmLmJ1c251bSk7DQo+ICsJcmV0ID0gZGV2
bV9yZXF1ZXN0X2lycShtdGstPnNlYWxfaXJxLCAmeGhjaV9tdGtfc2VhbF9pcnEsDQo+ICsJCQkg
IElSUUZfVFJJR0dFUl9GQUxMSU5HLAltdGstPnNlYWxfZGVzY3IsIG10ayk7DQoNCkluIGludGVy
cnVwdC5oIFsxXSwgZGV2bV9yZXF1ZXN0X2lycSgpIG5lZWQgNiBwYXJhbWV0ZXJzOg0KDQpzdGF0
aWMgaW5saW5lIGludCBfX211c3RfY2hlY2sNCmRldm1fcmVxdWVzdF9pcnEoc3RydWN0IGRldmlj
ZSAqZGV2LCB1bnNpZ25lZCBpbnQgaXJxLCBpcnFfaGFuZGxlcl90DQpoYW5kbGVyLA0KCQkgdW5z
aWduZWQgbG9uZyBpcnFmbGFncywgY29uc3QgY2hhciAqZGV2bmFtZSwgdm9pZCAqZGV2X2lkKQ0K
ew0KCXJldHVybiBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgaXJxLCBoYW5kbGVyLCBO
VUxMLCBpcnFmbGFncywNCgkJCQkJIGRldm5hbWUsIGRldl9pZCk7DQp9DQoNCg0KWzFdDQpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZS9pbmNsdWRlL2xpbnV4L2ludGVycnVwdC5oP2g9djUuOS1yYzENCg0KUmVnYXJk
cywNCkNLDQoNCj4gKwlpZiAocmV0ICE9IDApIHsNCj4gKwkJZGV2X2VycihkZXYsICJzZWFsIHJl
cXVlc3QgaW50ZXJydXB0ICVkIGZhaWxlZFxuIiwNCj4gKwkJCW10ay0+c2VhbF9pcnEpOw0KPiAr
CQlnb3RvIGRlYWxsb2NfdXNiMl9oY2Q7DQo+ICsJfQ0KPiArCXhoY2lfbXRrX3NlYWxfd2FrZXVw
X2VuYWJsZShtdGssIGZhbHNlKTsNCj4gKw0KPiArCWRldmljZV9lbmFibGVfYXN5bmNfc3VzcGVu
ZChkZXYpOw0KPiArCXhoY2lfbXRrX3J1bnRpbWVfcmVhZHkgPSAxOw0KPiArDQo+ICsJcmV0ID0g
YWRkX3Bvd2VyX2F0dHJpYnV0ZXMoZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGRlYWxs
b2NfdXNiMl9oY2Q7DQo+ICsNCj4gKwlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldik7DQo+
ICsJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2KTsNCj4gKw0KPiArCWRldl9kYmcoZGV2
LCAiJXM6IHhoY2lfbXRrX3J1bnRpbWVfcmVhZHkgJWkiLA0KPiArCQkgX19mdW5jX18sIHhoY2lf
bXRrX3J1bnRpbWVfcmVhZHkpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gIGRlYWxsb2Nf
dXNiMl9oY2Q6DQo+IEBAIC01ODQsNyArODQxLDcgQEAgc3RhdGljIGludCB4aGNpX210a19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXhoY2lfbXRrX2xkb3NfZGlzYWJs
ZShtdGspOw0KPiAgDQo+ICBkaXNhYmxlX3BtOg0KPiAtCXBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2
KTsNCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5jX2F1dG9zdXNwZW5kKGRldik7DQo+ICAJcG1fcnVu
dGltZV9kaXNhYmxlKGRldik7DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCg0KDQo=

