Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6802071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xj4+5wTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgHZFQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:16:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40377 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725764AbgHZFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:16:15 -0400
X-UUID: 392dc6a20bc64b52951449721d79efb2-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=k/lzlNQfUA+eaAvH30M5cVyH3/6TlNm4huvvLtGsZks=;
        b=Xj4+5wTQUzeqvFk67KFuXVdmOX2liX2DYTo0uGNEsOkusr9G6B1x6TfDfd8C1iA31jIlntIuqjg9Po3FrPm4yPKkzRKbxT3PgQBFdfpUIyYmGOzQnZq6+rz+inxa+t/4sWY6GKKuBTvD5WdcXaMatfc6yGq3j479tnS1aMb5tHk=;
X-UUID: 392dc6a20bc64b52951449721d79efb2-20200826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 28928350; Wed, 26 Aug 2020 13:16:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 13:16:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 13:16:02 +0800
Message-ID: <1598418963.20150.2.camel@mtksdaap41>
Subject: Re: [PATCH] nvmem: mtk-efuse: Remove EFUSE register write support
From:   CK Hu <ck.hu@mediatek.com>
To:     Chih-En Hsu <chih-en.hsu@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <Andrew-CT.Chen@mediatek.com>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 13:16:03 +0800
In-Reply-To: <20200826050145.24655-1-chih-en.hsu@mediatek.com>
References: <20200826050145.24655-1-chih-en.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENoaWgtRW46DQoNCk9uIFdlZCwgMjAyMC0wOC0yNiBhdCAxMzowMSArMDgwMCwgQ2hpaC1F
biBIc3Ugd3JvdGU6DQo+IFRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIGZ1bmN0aW9uICJtdGtfcmVn
X3dyaXRlIiBzaW5jZQ0KPiBNZWRpYXRlayBFRlVTRSBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzIHJl
YWQgZnVuY3Rpb25hbGl0eQ0KPiBmb3IgTlZNRU0gY29uc3VtZXJzLg0KPiANCg0KVGhpcyBpcyBh
IGJ1Zy1maXggcGF0Y2gsIHNvIG5lZWQgYSAnRml4ZXMnIHRhZy4gWW91IGNvdWxkIHJlZmVyIHRv
IFsxXS4NCg0KWzFdDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9j
ZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rlc2NyaWJlLWNoYW5nZXMNCg0KUmVnYXJkcywN
CkNLLg0KDQo+IFNpZ25lZC1vZmYtYnk6IENoaWgtRW4gSHN1IDxjaGloLWVuLmhzdUBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYyB8IDE0IC0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYyBiL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNl
LmMNCj4gaW5kZXggODU2ZDljM2ZjMzhlLi42YTUzN2Q5NTlmMTQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lbS9tdGstZWZ1c2Uu
Yw0KPiBAQCAtMjgsMTkgKzI4LDYgQEAgc3RhdGljIGludCBtdGtfcmVnX3JlYWQodm9pZCAqY29u
dGV4dCwNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBtdGtfcmVnX3dy
aXRlKHZvaWQgKmNvbnRleHQsDQo+IC0JCQkgdW5zaWduZWQgaW50IHJlZywgdm9pZCAqX3ZhbCwg
c2l6ZV90IGJ5dGVzKQ0KPiAtew0KPiAtCXN0cnVjdCBtdGtfZWZ1c2VfcHJpdiAqcHJpdiA9IGNv
bnRleHQ7DQo+IC0JdTMyICp2YWwgPSBfdmFsOw0KPiAtCWludCBpID0gMCwgd29yZHMgPSBieXRl
cyAvIDQ7DQo+IC0NCj4gLQl3aGlsZSAod29yZHMtLSkNCj4gLQkJd3JpdGVsKCp2YWwrKywgcHJp
di0+YmFzZSArIHJlZyArIChpKysgKiA0KSk7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4g
LQ0KPiAgc3RhdGljIGludCBtdGtfZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAt
NjEsNyArNDgsNiBAQCBzdGF0aWMgaW50IG10a19lZnVzZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCWVjb25maWcuc3RyaWRlID0gNDsNCj4gIAllY29uZmlnLndvcmRf
c2l6ZSA9IDQ7DQo+ICAJZWNvbmZpZy5yZWdfcmVhZCA9IG10a19yZWdfcmVhZDsNCj4gLQllY29u
ZmlnLnJlZ193cml0ZSA9IG10a19yZWdfd3JpdGU7DQo+ICAJZWNvbmZpZy5zaXplID0gcmVzb3Vy
Y2Vfc2l6ZShyZXMpOw0KPiAgCWVjb25maWcucHJpdiA9IHByaXY7DQo+ICAJZWNvbmZpZy5kZXYg
PSBkZXY7DQoNCg==

