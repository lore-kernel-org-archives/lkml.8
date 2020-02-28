Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294BC3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728624699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YIp65SgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1PF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:05:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40807 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgB1PF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:05:56 -0500
X-UUID: c0943b4c5a8c4db8a9781917ac9ea4cd-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=afn0AiUTWzXbXY5VokBw7o3NfO+VtwljFnYyh1mt1oc=;
        b=YIp65SgPT8zuhTLBrBE7JlukFDrYR4YVlAm1tCX/nOtttWt7IH8gyh9X3aGUB6TTCUVfo1vqUJTbp0v79npyxx/jfkXUpb+KLO3IEx+PxBMebNim0FQmNWltK4ZFy17Yn3upZrtC0ugD6WdnpzkE86AwhuDpGGYCCSl4PI3fvuA=;
X-UUID: c0943b4c5a8c4db8a9781917ac9ea4cd-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 235942894; Fri, 28 Feb 2020 23:05:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 23:05:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 23:05:33 +0800
Message-ID: <1582902351.14824.10.camel@mtksdaap41>
Subject: Re: [PATCH v3 13/13] soc: mediatek: cmdq: add set event function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Fri, 28 Feb 2020 23:05:51 +0800
In-Reply-To: <1582897461-15105-15-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-15-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBzZXQgZXZlbnQgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIg
ZnVuY3Rpb25zIHRvIHNldCBzcGVjaWZpYyBldmVudC4NCj4gDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMTUgKysrKysrKysrKysrKysrDQo+ICBpbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDEgKw0KPiAgaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICA5ICsrKysrKysrKw0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiBpbmRleCA0MDZlMWQzNGQyMzQuLjczOGY4M2Q5MGI1OSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTMyNiw2ICszMjYs
MjEgQEAgaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
ZXZlbnQpDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2NsZWFyX2V2ZW50KTsNCj4g
IA0KPiAraW50IGNtZHFfcGt0X3NldF9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2
ZW50KQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0K
PiArDQo+ICsJaWYgKGV2ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gKw0KPiArCWluc3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KPiArCWluc3QudmFsdWUgPSBD
TURRX1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFMVUU7DQo+ICsJaW5zdC5ldmVudCA9
IGV2ZW50Ow0KPiArDQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5z
dCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3NldF9ldmVudCk7DQo+ICsNCj4g
IGludCBjbWRxX3BrdF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAJ
CSAgdTE2IG9mZnNldCwgdTMyIHZhbHVlKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmgNCj4gaW5kZXggNDJkMmEzMGU2YTcwLi5iYTJkODExMTgzYTkgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4g
KysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtMTcs
NiArMTcsNyBAQA0KPiAgI2RlZmluZSBDTURRX0pVTVBfUEFTUwkJCUNNRFFfSU5TVF9TSVpFDQo+
ICANCj4gICNkZWZpbmUgQ01EUV9XRkVfVVBEQVRFCQkJQklUKDMxKQ0KPiArI2RlZmluZSBDTURR
X1dGRV9VUERBVEVfVkFMVUUJCUJJVCgxNikNCj4gICNkZWZpbmUgQ01EUV9XRkVfV0FJVAkJCUJJ
VCgxNSkNCj4gICNkZWZpbmUgQ01EUV9XRkVfV0FJVF9WQUxVRQkJMHgxDQo+ICANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IGQ2Mzc0OTQ0MDY5Ny4uY2E3MDI5
NmFlMTIwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gQEAg
LTE2OCw2ICsxNjgsMTUgQEAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
dTE2IGV2ZW50LCBib29sIGNsZWFyKTsNCj4gICAqLw0KPiAgaW50IGNtZHFfcGt0X2NsZWFyX2V2
ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KPiAgDQo+ICsvKioNCj4gKyAq
IGNtZHFfcGt0X3NldF9ldmVudCgpIC0gYXBwZW5kIHNldCBldmVudCBjb21tYW5kIHRvIHRoZSBD
TURRIHBhY2tldA0KPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAZXZlbnQ6CXRo
ZSBkZXNpcmVkIGV2ZW50IHRvIGJlIHNldA0KPiArICoNCj4gKyAqIFJldHVybjogMCBmb3Igc3Vj
Y2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiArICovDQo+ICtpbnQgY21k
cV9wa3Rfc2V0X2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpOw0KPiArDQo+
ICAvKioNCj4gICAqIGNtZHFfcGt0X3BvbGwoKSAtIEFwcGVuZCBwb2xsaW5nIGNvbW1hbmQgdG8g
dGhlIENNRFEgcGFja2V0LCBhc2sgR0NFIHRvDQo+ICAgKgkJICAgICBleGVjdXRlIGFuIGluc3Ry
dWN0aW9uIHRoYXQgd2FpdCBmb3IgYSBzcGVjaWZpZWQNCg0K

