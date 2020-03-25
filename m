Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D450C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915C2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KPHfVEc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYINe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:13:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26224 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgCYINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:13:33 -0400
X-UUID: 5cca7a9598cc4ad38bc9ca209b44d65f-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dJ7gn4TdaczOjZjHPmp781H0hrs3QHnrPcfrTh+H9UM=;
        b=KPHfVEc2qSFNnAbq7jElZDp6cma6sTHdiB6qXXh5CHfryshgTptuPNG3lm6V+UNr1g959e4bsvJPVaud62LYti4C4VIS5SQmEYbAz/u3TCL/3/H/+k29Qz9F/gns7RRiZKOg7I1MH5iBVkaZRXfE1TW7pvc6n03VFood078Y2wk=;
X-UUID: 5cca7a9598cc4ad38bc9ca209b44d65f-20200325
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1756567163; Wed, 25 Mar 2020 16:13:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 16:13:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 16:13:25 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v4 3/6] pinctrl: mediatek: avoid virtual gpio trying to set reg
Date:   Wed, 25 Mar 2020 16:12:41 +0800
Message-ID: <1585123964-10791-4-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
References: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zm9yIHZpcnR1YWwgZ3Bpb3MsIHRoZXkgc2hvdWxkIG5vdCBkbyByZWcgc2V0dGluZyBhbmQNCnNo
b3VsZCBiZWhhdmUgYXMgZXhwZWN0ZWQgZm9yIGVpbnQgZnVuY3Rpb24uDQoNCkNoYW5nZS1JZDog
STkxMzUwMWYyMWM4NDFjMmNiOTgxNTMwY2QzODczOTU2NDhmODM5ODQNClNpZ25lZC1vZmYtYnk6
IEhhbmtzIENoZW4gPGhhbmtzLmNoZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogTWFy
cyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3BpbmN0cmwv
bWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmMgfCAgIDI4ICsrKysrKysrKysrKysrKysr
KysrKysNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmgg
fCAgICAxICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1wYXJpcy5jICAgICAg
ICAgfCAgICA3ICsrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12
Mi5jIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5jDQpp
bmRleCAyMGUxYzg5Li4wODdkMjMzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0
ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmMNCkBAIC0yMjYsNiArMjI2LDMxIEBAIHN0YXRpYyBp
bnQgbXRrX3h0X2ZpbmRfZWludF9udW0oc3RydWN0IG10a19waW5jdHJsICpodywgdW5zaWduZWQg
bG9uZyBlaW50X24pDQogCXJldHVybiBFSU5UX05BOw0KIH0NCiANCisvKg0KKyAqIFZpcnR1YWwg
R1BJTyBvbmx5IHVzZWQgaW5zaWRlIFNPQyBhbmQgbm90IGJlaW5nIGV4cG9ydGVkIHRvIG91dHNp
ZGUgU09DLg0KKyAqIFNvbWUgbW9kdWxlcyB1c2UgdmlydHVhbCBHUElPIGFzIGVpbnQgKGUuZy4g
cG1pZiBvciB1c2IpLg0KKyAqIEluIE1USyBwbGF0Zm9ybSwgZXh0ZXJuYWwgaW50ZXJydXB0IChF
SU5UKSBhbmQgR1BJTyBpcyAxLTEgbWFwcGluZw0KKyAqIGFuZCB3ZSBjYW4gc2V0IEdQSU8gYXMg
ZWludC4NCisgKiBCdXQgc29tZSBtb2R1bGVzIHVzZSBzcGVjaWZpYyBlaW50IHdoaWNoIGRvZXNu
J3QgaGF2ZSByZWFsIEdQSU8gcGluLg0KKyAqIFNvIHdlIHVzZSB2aXJ0dWFsIEdQSU8gdG8gbWFw
IGl0Lg0KKyAqLw0KKw0KK2Jvb2wgbXRrX2lzX3ZpcnRfZ3BpbyhzdHJ1Y3QgbXRrX3BpbmN0cmwg
Kmh3LCB1bnNpZ25lZCBpbnQgZ3Bpb19uKQ0KK3sNCisJY29uc3Qgc3RydWN0IG10a19waW5fZGVz
YyAqZGVzYzsNCisJYm9vbCB2aXJ0X2dwaW8gPSBmYWxzZTsNCisNCisJaWYgKGdwaW9fbiA+PSBo
dy0+c29jLT5ucGlucykNCisJCXJldHVybiB2aXJ0X2dwaW87DQorDQorCWRlc2MgPSAoY29uc3Qg
c3RydWN0IG10a19waW5fZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9fbl07DQorDQorCWlmIChk
ZXNjLT5mdW5jcyAmJiAhZGVzYy0+ZnVuY3NbZGVzYy0+ZWludC5laW50X21dLm5hbWUpDQorCQl2
aXJ0X2dwaW8gPSB0cnVlOw0KKw0KKwlyZXR1cm4gdmlydF9ncGlvOw0KK30NCisNCiBzdGF0aWMg
aW50IG10a194dF9nZXRfZ3Bpb19uKHZvaWQgKmRhdGEsIHVuc2lnbmVkIGxvbmcgZWludF9uLA0K
IAkJCSAgICAgdW5zaWduZWQgaW50ICpncGlvX24sDQogCQkJICAgICBzdHJ1Y3QgZ3Bpb19jaGlw
ICoqZ3Bpb19jaGlwKQ0KQEAgLTI3OCw2ICszMDMsOSBAQCBzdGF0aWMgaW50IG10a194dF9zZXRf
Z3Bpb19hc19laW50KHZvaWQgKmRhdGEsIHVuc2lnbmVkIGxvbmcgZWludF9uKQ0KIAlpZiAoZXJy
KQ0KIAkJcmV0dXJuIGVycjsNCiANCisJaWYgKG10a19pc192aXJ0X2dwaW8oaHcsIGdwaW9fbikp
DQorCQlyZXR1cm4gMDsNCisNCiAJZGVzYyA9IChjb25zdCBzdHJ1Y3QgbXRrX3Bpbl9kZXNjICop
Jmh3LT5zb2MtPnBpbnNbZ3Bpb19uXTsNCiANCiAJZXJyID0gbXRrX2h3X3NldF92YWx1ZShodywg
ZGVzYywgUElOQ1RSTF9QSU5fUkVHX01PREUsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJs
L21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5oIGIvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5oDQppbmRleCAxYjdkYTQyLi5jZGExYzdhMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIu
aA0KKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5o
DQpAQCAtMjk5LDQgKzI5OSw1IEBAIGludCBtdGtfcGluY29uZl9hZHZfZHJpdmVfc2V0KHN0cnVj
dCBtdGtfcGluY3RybCAqaHcsDQogaW50IG10a19waW5jb25mX2Fkdl9kcml2ZV9nZXQoc3RydWN0
IG10a19waW5jdHJsICpodywNCiAJCQkgICAgICBjb25zdCBzdHJ1Y3QgbXRrX3Bpbl9kZXNjICpk
ZXNjLCB1MzIgKnZhbCk7DQogDQorYm9vbCBtdGtfaXNfdmlydF9ncGlvKHN0cnVjdCBtdGtfcGlu
Y3RybCAqaHcsIHVuc2lnbmVkIGludCBncGlvX24pOw0KICNlbmRpZiAvKiBfX1BJTkNUUkxfTVRL
X0NPTU1PTl9WMl9IICovDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtcGFyaXMuYyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLXBhcmlzLmMN
CmluZGV4IDkyMzI2NGQuLjdmYmE3NmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVk
aWF0ZWsvcGluY3RybC1wYXJpcy5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGlu
Y3RybC1wYXJpcy5jDQpAQCAtNjkzLDYgKzY5MywxMyBAQCBzdGF0aWMgaW50IG10a19ncGlvX2dl
dF9kaXJlY3Rpb24oc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQgaW50IGdwaW8pDQog
CWNvbnN0IHN0cnVjdCBtdGtfcGluX2Rlc2MgKmRlc2M7DQogCWludCB2YWx1ZSwgZXJyOw0KIA0K
KwkvKg0KKwkgKiAiVmlydHVhbCIgR1BJT3MgYXJlIGFsd2F5cyBhbmQgb25seSB1c2VkIGZvciBp
bnRlcnJ1cHRzDQorCSAqIFNpbmNlIHRoZXkgYXJlIG9ubHkgdXNlZCBmb3IgaW50ZXJydXB0cywg
dGhleSBhcmUgYWx3YXlzIGlucHV0cw0KKwkgKi8NCisJaWYgKG10a19pc192aXJ0X2dwaW8oaHcs
IGdwaW8pKQ0KKwkJcmV0dXJuIDE7DQorDQogCWRlc2MgPSAoY29uc3Qgc3RydWN0IG10a19waW5f
ZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9dOw0KIA0KIAllcnIgPSBtdGtfaHdfZ2V0X3ZhbHVl
KGh3LCBkZXNjLCBQSU5DVFJMX1BJTl9SRUdfRElSLCAmdmFsdWUpOw0KLS0gDQoxLjcuOS41DQo=

