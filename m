Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848E520767
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BtdjxSGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHZHej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:34:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42415 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgHZHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:34:39 -0400
X-UUID: de0e2075e069470eb3b21b3fc0d4ebf2-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5F2u2VX8q773AZrGxIKFo0mNHhzUD6g58juvoBIk0sM=;
        b=BtdjxSGo7DqQ8It57yghfwy3OZ4a3Qsiz53axPWMPW2MUmBQUw58pejoy/uCk7MZ7q6jODzMSVv+67nlpyoNyiA70XPlsKpvPJjIpB6WE6JqTLAMaHBTYrjJUbhtZIpMZvRVu0j+wnpO/BTPoqqoEtwHFcHYOO10pJkCqRPJXIo=;
X-UUID: de0e2075e069470eb3b21b3fc0d4ebf2-20200826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1021931807; Wed, 26 Aug 2020 15:34:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 15:34:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 15:34:31 +0800
Message-ID: <1598427273.27965.0.camel@mtksdaap41>
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Remove EFUSE register write support
From:   CK Hu <ck.hu@mediatek.com>
To:     Chih-En Hsu <chih-en.hsu@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <Andrew-CT.Chen@mediatek.com>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 15:34:33 +0800
In-Reply-To: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
References: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENoaWgtRW46DQoNCk9uIFdlZCwgMjAyMC0wOC0yNiBhdCAxNDoyMSArMDgwMCwgQ2hpaC1F
biBIc3Ugd3JvdGU6DQo+IFRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIGZ1bmN0aW9uICJtdGtfcmVn
X3dyaXRlIiBzaW5jZQ0KPiBNZWRpYXRlayBFRlVTRSBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzIHJl
YWQgZnVuY3Rpb25hbGl0eQ0KPiBmb3IgTlZNRU0gY29uc3VtZXJzLg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gRml4ZXM6IDRjN2U0ZmUzNzc2NiAo
Im52bWVtOiBtZWRpYXRlazogQWRkIE1lZGlhdGVrIEVGVVNFIGRyaXZlciIpDQo+IFNpZ25lZC1v
ZmYtYnk6IENoaWgtRW4gSHN1IDxjaGloLWVuLmhzdUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
bS9tdGstZWZ1c2UuYyBiL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMNCj4gaW5kZXggODU2ZDlj
M2ZjMzhlLi42YTUzN2Q5NTlmMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZW0vbXRrLWVm
dXNlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYw0KPiBAQCAtMjgsMTkgKzI4
LDYgQEAgc3RhdGljIGludCBtdGtfcmVnX3JlYWQodm9pZCAqY29udGV4dCwNCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBtdGtfcmVnX3dyaXRlKHZvaWQgKmNvbnRleHQs
DQo+IC0JCQkgdW5zaWduZWQgaW50IHJlZywgdm9pZCAqX3ZhbCwgc2l6ZV90IGJ5dGVzKQ0KPiAt
ew0KPiAtCXN0cnVjdCBtdGtfZWZ1c2VfcHJpdiAqcHJpdiA9IGNvbnRleHQ7DQo+IC0JdTMyICp2
YWwgPSBfdmFsOw0KPiAtCWludCBpID0gMCwgd29yZHMgPSBieXRlcyAvIDQ7DQo+IC0NCj4gLQl3
aGlsZSAod29yZHMtLSkNCj4gLQkJd3JpdGVsKCp2YWwrKywgcHJpdi0+YmFzZSArIHJlZyArIChp
KysgKiA0KSk7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCBt
dGtfZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtNjEsNyArNDgsNiBAQCBzdGF0
aWMgaW50IG10a19lZnVzZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CWVjb25maWcuc3RyaWRlID0gNDsNCj4gIAllY29uZmlnLndvcmRfc2l6ZSA9IDQ7DQo+ICAJZWNv
bmZpZy5yZWdfcmVhZCA9IG10a19yZWdfcmVhZDsNCj4gLQllY29uZmlnLnJlZ193cml0ZSA9IG10
a19yZWdfd3JpdGU7DQo+ICAJZWNvbmZpZy5zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiAg
CWVjb25maWcucHJpdiA9IHByaXY7DQo+ICAJZWNvbmZpZy5kZXYgPSBkZXY7DQoNCg==

