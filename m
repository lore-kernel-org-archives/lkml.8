Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2661BC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9A320714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jGoMo7Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYJb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:31:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22729 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgCYJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:31:53 -0400
X-UUID: 6502607f7b5c485a965ec68ac5cc572e-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gcuqKepqLmO7eC+NcTPbHcySQGXOAWJEpP27E4J/m1c=;
        b=jGoMo7MpjbBWTE/eXg0TbDj92WynBlndgVkx5hqaLizPVEWO+sEJtrAs/yBc8qrVh63lJu5HFRi+HZ9Ftdomk4kLsK1CBb0ZD7QfxbC4MFdbgfHmsaGZ1nzlByShDlOUmE0DfD6iQGqw7P8LLQu4+i9OhQ0ECoj6HAFHnPI1U4w=;
X-UUID: 6502607f7b5c485a965ec68ac5cc572e-20200325
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 969955371; Wed, 25 Mar 2020 17:31:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 17:31:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 17:31:41 +0800
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
Subject: [PATCH v5 3/6] pinctrl: mediatek: avoid virtual gpio trying to set reg
Date:   Wed, 25 Mar 2020 17:31:31 +0800
Message-ID: <1585128694-13881-4-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4FA0E5F8D5EAAEC00D93A7DE47850028B31962D46D1324751148755D0B91662E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zm9yIHZpcnR1YWwgZ3Bpb3MsIHRoZXkgc2hvdWxkIG5vdCBkbyByZWcgc2V0dGluZyBhbmQNCnNo
b3VsZCBiZWhhdmUgYXMgZXhwZWN0ZWQgZm9yIGVpbnQgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYt
Ynk6IEhhbmtzIENoZW4gPGhhbmtzLmNoZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTog
TWFycyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmMgfCAgIDI4ICsrKysrKysrKysrKysr
KysrKysrKysNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYy
LmggfCAgICAxICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1wYXJpcy5jICAg
ICAgICAgfCAgICA3ICsrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1v
bi12Mi5jIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5j
DQppbmRleCAyMGUxYzg5Li4wODdkMjMzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVk
aWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmMNCkBAIC0yMjYsNiArMjI2LDMxIEBAIHN0YXRp
YyBpbnQgbXRrX3h0X2ZpbmRfZWludF9udW0oc3RydWN0IG10a19waW5jdHJsICpodywgdW5zaWdu
ZWQgbG9uZyBlaW50X24pDQogCXJldHVybiBFSU5UX05BOw0KIH0NCiANCisvKg0KKyAqIFZpcnR1
YWwgR1BJTyBvbmx5IHVzZWQgaW5zaWRlIFNPQyBhbmQgbm90IGJlaW5nIGV4cG9ydGVkIHRvIG91
dHNpZGUgU09DLg0KKyAqIFNvbWUgbW9kdWxlcyB1c2UgdmlydHVhbCBHUElPIGFzIGVpbnQgKGUu
Zy4gcG1pZiBvciB1c2IpLg0KKyAqIEluIE1USyBwbGF0Zm9ybSwgZXh0ZXJuYWwgaW50ZXJydXB0
IChFSU5UKSBhbmQgR1BJTyBpcyAxLTEgbWFwcGluZw0KKyAqIGFuZCB3ZSBjYW4gc2V0IEdQSU8g
YXMgZWludC4NCisgKiBCdXQgc29tZSBtb2R1bGVzIHVzZSBzcGVjaWZpYyBlaW50IHdoaWNoIGRv
ZXNuJ3QgaGF2ZSByZWFsIEdQSU8gcGluLg0KKyAqIFNvIHdlIHVzZSB2aXJ0dWFsIEdQSU8gdG8g
bWFwIGl0Lg0KKyAqLw0KKw0KK2Jvb2wgbXRrX2lzX3ZpcnRfZ3BpbyhzdHJ1Y3QgbXRrX3BpbmN0
cmwgKmh3LCB1bnNpZ25lZCBpbnQgZ3Bpb19uKQ0KK3sNCisJY29uc3Qgc3RydWN0IG10a19waW5f
ZGVzYyAqZGVzYzsNCisJYm9vbCB2aXJ0X2dwaW8gPSBmYWxzZTsNCisNCisJaWYgKGdwaW9fbiA+
PSBody0+c29jLT5ucGlucykNCisJCXJldHVybiB2aXJ0X2dwaW87DQorDQorCWRlc2MgPSAoY29u
c3Qgc3RydWN0IG10a19waW5fZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9fbl07DQorDQorCWlm
IChkZXNjLT5mdW5jcyAmJiAhZGVzYy0+ZnVuY3NbZGVzYy0+ZWludC5laW50X21dLm5hbWUpDQor
CQl2aXJ0X2dwaW8gPSB0cnVlOw0KKw0KKwlyZXR1cm4gdmlydF9ncGlvOw0KK30NCisNCiBzdGF0
aWMgaW50IG10a194dF9nZXRfZ3Bpb19uKHZvaWQgKmRhdGEsIHVuc2lnbmVkIGxvbmcgZWludF9u
LA0KIAkJCSAgICAgdW5zaWduZWQgaW50ICpncGlvX24sDQogCQkJICAgICBzdHJ1Y3QgZ3Bpb19j
aGlwICoqZ3Bpb19jaGlwKQ0KQEAgLTI3OCw2ICszMDMsOSBAQCBzdGF0aWMgaW50IG10a194dF9z
ZXRfZ3Bpb19hc19laW50KHZvaWQgKmRhdGEsIHVuc2lnbmVkIGxvbmcgZWludF9uKQ0KIAlpZiAo
ZXJyKQ0KIAkJcmV0dXJuIGVycjsNCiANCisJaWYgKG10a19pc192aXJ0X2dwaW8oaHcsIGdwaW9f
bikpDQorCQlyZXR1cm4gMDsNCisNCiAJZGVzYyA9IChjb25zdCBzdHJ1Y3QgbXRrX3Bpbl9kZXNj
ICopJmh3LT5zb2MtPnBpbnNbZ3Bpb19uXTsNCiANCiAJZXJyID0gbXRrX2h3X3NldF92YWx1ZSho
dywgZGVzYywgUElOQ1RSTF9QSU5fUkVHX01PREUsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5j
dHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5oIGIvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5oDQppbmRleCAxYjdkYTQyLi5jZGExYzdhMCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24t
djIuaA0KKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12
Mi5oDQpAQCAtMjk5LDQgKzI5OSw1IEBAIGludCBtdGtfcGluY29uZl9hZHZfZHJpdmVfc2V0KHN0
cnVjdCBtdGtfcGluY3RybCAqaHcsDQogaW50IG10a19waW5jb25mX2Fkdl9kcml2ZV9nZXQoc3Ry
dWN0IG10a19waW5jdHJsICpodywNCiAJCQkgICAgICBjb25zdCBzdHJ1Y3QgbXRrX3Bpbl9kZXNj
ICpkZXNjLCB1MzIgKnZhbCk7DQogDQorYm9vbCBtdGtfaXNfdmlydF9ncGlvKHN0cnVjdCBtdGtf
cGluY3RybCAqaHcsIHVuc2lnbmVkIGludCBncGlvX24pOw0KICNlbmRpZiAvKiBfX1BJTkNUUkxf
TVRLX0NPTU1PTl9WMl9IICovDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVr
L3BpbmN0cmwtcGFyaXMuYyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLXBhcmlz
LmMNCmluZGV4IDkyMzI2NGQuLjdmYmE3NmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BpbmN0cmwv
bWVkaWF0ZWsvcGluY3RybC1wYXJpcy5jDQorKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsv
cGluY3RybC1wYXJpcy5jDQpAQCAtNjkzLDYgKzY5MywxMyBAQCBzdGF0aWMgaW50IG10a19ncGlv
X2dldF9kaXJlY3Rpb24oc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQgaW50IGdwaW8p
DQogCWNvbnN0IHN0cnVjdCBtdGtfcGluX2Rlc2MgKmRlc2M7DQogCWludCB2YWx1ZSwgZXJyOw0K
IA0KKwkvKg0KKwkgKiAiVmlydHVhbCIgR1BJT3MgYXJlIGFsd2F5cyBhbmQgb25seSB1c2VkIGZv
ciBpbnRlcnJ1cHRzDQorCSAqIFNpbmNlIHRoZXkgYXJlIG9ubHkgdXNlZCBmb3IgaW50ZXJydXB0
cywgdGhleSBhcmUgYWx3YXlzIGlucHV0cw0KKwkgKi8NCisJaWYgKG10a19pc192aXJ0X2dwaW8o
aHcsIGdwaW8pKQ0KKwkJcmV0dXJuIDE7DQorDQogCWRlc2MgPSAoY29uc3Qgc3RydWN0IG10a19w
aW5fZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9dOw0KIA0KIAllcnIgPSBtdGtfaHdfZ2V0X3Zh
bHVlKGh3LCBkZXNjLCBQSU5DVFJMX1BJTl9SRUdfRElSLCAmdmFsdWUpOw0KLS0gDQoxLjcuOS41
DQo=

