Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF45C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969232064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RDCvw7tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgBQJ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:29:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32672 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728773AbgBQJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:29:36 -0500
X-UUID: 62babae891504fdc96b7d46612dea2b6-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+AZRRBU+eXyDNfzUrhQQGTkVM4JM0kpcUBh6dZge9tA=;
        b=RDCvw7tHLfWuqmOGS911L2SXvA9CN9I/QCntQmRrc4VGTjml9DqeQNDiCsMEJAgxO6Vvx9S5J2s8E+8K9iyuOX1LGmyMMP2AiYWwwYl6TeCK8S8zaroegAj8Kw9dj98NG2G/V3WVJ1EIxW9QOrigMu7cTCRUinOPcnsCF7Bter0=;
X-UUID: 62babae891504fdc96b7d46612dea2b6-20200217
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1424113595; Mon, 17 Feb 2020 17:29:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:28:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:27:27 +0800
Message-ID: <1581931765.12547.0.camel@mtksdaap41>
Subject: Re: [PATCH v1 2/3] mailbox: mediatek: implement flush function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Mon, 17 Feb 2020 17:29:25 +0800
In-Reply-To: <20200217090532.16019-3-bibby.hsieh@mediatek.com>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
         <20200217090532.16019-3-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBNb24sIDIwMjAtMDItMTcgYXQgMTc6MDUgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBGb3IgY2xpZW50IGRyaXZlciB3aGljaCBuZWVkIHRvIHJlb3JnYW5pemUg
dGhlIGNvbW1hbmQgYnVmZmVyLCBpdCBjb3VsZA0KPiB1c2UgdGhpcyBmdW5jdGlvbiB0byBmbHVz
aCB0aGUgc2VuZCBjb21tYW5kIGJ1ZmZlci4NCj4gSWYgdGhlIGNoYW5uZWwgZG9lc24ndCBiZSBz
dGFydGVkICh1c3VhbGx5IGluIHdhaXRpbmcgZm9yIGV2ZW50KSwgdGhpcw0KPiBmdW5jdGlvbiB3
aWxsIGFib3J0IGl0IGRpcmVjdGx5Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBt
ZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVo
QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+
IGluZGV4IDlhNmNlOWY1YTdkYi4uMGRhNWUyZGMyYzBlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmMNCj4gQEAgLTQzMiwxMCArNDMyLDYyIEBAIHN0YXRpYyB2b2lkIGNtZHFf
bWJveF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiAgew0KPiAgfQ0KPiAgDQo+
ICtzdGF0aWMgaW50IGNtZHFfbWJveF9mbHVzaChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB1bnNp
Z25lZCBsb25nIHRpbWVvdXQpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQg
PSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ICsJc3RydWN0IGNtZHFf
dGFza19jYiAqY2I7DQo+ICsJc3RydWN0IGNtZHFfY2JfZGF0YSBkYXRhOw0KPiArCXN0cnVjdCBj
bWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQo+ICsJc3RydWN0
IGNtZHFfdGFzayAqdGFzaywgKnRtcDsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCXUz
MiBlbmFibGU7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2Nr
LCBmbGFncyk7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0K
PiArCQlnb3RvIG91dDsNCj4gKw0KPiArCVdBUk5fT04oY21kcV90aHJlYWRfc3VzcGVuZChjbWRx
LCB0aHJlYWQpIDwgMCk7DQo+ICsJaWYgKCFjbWRxX3RocmVhZF9pc19pbl93ZmUodGhyZWFkKSkN
Cj4gKwkJZ290byB3YWl0Ow0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRhc2ss
IHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQo+ICsJCQkJIGxpc3RfZW50cnkpIHsNCj4g
KwkJY2IgPSAmdGFzay0+cGt0LT5hc3luY19jYjsNCj4gKwkJaWYgKGNiLT5jYikgew0KPiArCQkJ
ZGF0YS5zdGEgPSBDTURRX0NCX0VSUk9SOw0KPiArCQkJZGF0YS5kYXRhID0gY2ItPmRhdGE7DQo+
ICsJCQljYi0+Y2IoZGF0YSk7DQo+ICsJCX0NCj4gKwkJbGlzdF9kZWwoJnRhc2stPmxpc3RfZW50
cnkpOw0KPiArCQlrZnJlZSh0YXNrKTsNCj4gKwl9DQo+ICsNCj4gKwljbWRxX3RocmVhZF9yZXN1
bWUodGhyZWFkKTsNCj4gKwljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+ICsJ
Y2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KPiArDQo+ICtvdXQ6DQo+ICsJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJcmV0dXJuIDA7DQo+
ICsNCj4gK3dhaXQ6DQo+ICsJY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQo+ICsJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJaWYgKHJl
YWRsX3BvbGxfdGltZW91dF9hdG9taWModGhyZWFkLT5iYXNlICsgQ01EUV9USFJfRU5BQkxFX1RB
U0ssDQo+ICsJCQkJICAgICAgZW5hYmxlLCBlbmFibGUgPT0gMCwgMSwgdGltZW91dCkpIHsNCj4g
KwkJZGV2X2VycihjbWRxLT5tYm94LmRldiwgIkZhaWwgdG8gd2FpdCBHQ0UgdGhyZWFkIDB4JXgg
ZG9uZVxuIiwNCj4gKwkJCSh1MzIpKHRocmVhZC0+YmFzZSAtIGNtZHEtPmJhc2UpKTsNCj4gKw0K
PiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKwl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7
DQo+ICAJLnNlbmRfZGF0YSA9IGNtZHFfbWJveF9zZW5kX2RhdGEsDQo+ICAJLnN0YXJ0dXAgPSBj
bWRxX21ib3hfc3RhcnR1cCwNCj4gIAkuc2h1dGRvd24gPSBjbWRxX21ib3hfc2h1dGRvd24sDQo+
ICsJLmZsdXNoID0gY21kcV9tYm94X2ZsdXNoLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIHN0cnVj
dCBtYm94X2NoYW4gKmNtZHFfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxlciAqbWJveCwNCg0K

