Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B48AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6A2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I+RgWdni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgBNEdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:33:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728741AbgBNEdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:33:35 -0500
X-UUID: a2a0bbdc6c314c0a8ee71fe6eded9450-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w2NhLJ3fxw83KsKgFIdEJoeGbAL7h1s87A7XGio1z9k=;
        b=I+RgWdnimSZez7CAoQ848R5Z0iXfgkdhj0mGQy4AvGtzYsHU4zRfVCtn687h1RG0ekbgyd2YfYIuRPEyELIGs+znAvi+k6T+o2HqJldVr+6UCMCEUDQkYGZd7/gI4kdJuEGYZ4n318wPxS1sQ/OJhh+i3LmN2Sb1wSUvjsS58Ew=;
X-UUID: a2a0bbdc6c314c0a8ee71fe6eded9450-20200214
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 274340782; Fri, 14 Feb 2020 12:33:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:32:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:33:19 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 2/3] mailbox: mediatek: remove implementation related to atomic_exec
Date:   Fri, 14 Feb 2020 12:33:24 +0800
Message-ID: <20200214043325.16618-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgaW1wbGVtZW50IGZsdXNoLCBjbGllbnQgY2FuIGZsdXNoIHRoZSBleGVjdXRpbmcNCmNv
bW1hbmQgYnVmZmVyIG9yIGFib3J0IHRoZSBzdGlsbCB3YWl0aW5nIGZvciBldmVudA0KY29tbWFu
ZCBidWZmZXIsIHNvIGNvbnRyb2xsZXIgZG8gbm90IG5lZWQgdG8gaW1wbGVtZW50DQphdG9taWNf
ZXhlIGZlYXR1cmUuIHJlbW92ZSBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJp
YmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmMgfCA3NiArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jDQppbmRleCAwM2U1OGZmNjIwMDcuLjNjZTc3NzAwMWFhNSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCkBAIC01Nyw3ICs1Nyw2IEBAIHN0cnVjdCBjbWRxX3Ro
cmVhZCB7DQogCXZvaWQgX19pb21lbQkJKmJhc2U7DQogCXN0cnVjdCBsaXN0X2hlYWQJdGFza19i
dXN5X2xpc3Q7DQogCXUzMgkJCXByaW9yaXR5Ow0KLQlib29sCQkJYXRvbWljX2V4ZWM7DQogfTsN
CiANCiBzdHJ1Y3QgY21kcV90YXNrIHsNCkBAIC0xNjMsNDggKzE2MiwxMSBAQCBzdGF0aWMgdm9p
ZCBjbWRxX3Rhc2tfaW5zZXJ0X2ludG9fdGhyZWFkKHN0cnVjdCBjbWRxX3Rhc2sgKnRhc2spDQog
CWNtZHFfdGhyZWFkX2ludmFsaWRhdGVfZmV0Y2hlZF9kYXRhKHRocmVhZCk7DQogfQ0KIA0KLXN0
YXRpYyBib29sIGNtZHFfY29tbWFuZF9pc193ZmUodTY0IGNtZCkNCi17DQotCXU2NCB3ZmVfb3B0
aW9uID0gQ01EUV9XRkVfVVBEQVRFIHwgQ01EUV9XRkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFM
VUU7DQotCXU2NCB3ZmVfb3AgPSAodTY0KShDTURRX0NPREVfV0ZFIDw8IENNRFFfT1BfQ09ERV9T
SElGVCkgPDwgMzI7DQotCXU2NCB3ZmVfbWFzayA9ICh1NjQpQ01EUV9PUF9DT0RFX01BU0sgPDwg
MzIgfCAweGZmZmZmZmZmOw0KLQ0KLQlyZXR1cm4gKChjbWQgJiB3ZmVfbWFzaykgPT0gKHdmZV9v
cCB8IHdmZV9vcHRpb24pKTsNCi19DQotDQotLyogd2UgYXNzdW1lIHRhc2tzIGluIHRoZSBzYW1l
IGRpc3BsYXkgR0NFIHRocmVhZCBhcmUgd2FpdGluZyB0aGUgc2FtZSBldmVudC4gKi8NCi1zdGF0
aWMgdm9pZCBjbWRxX3Rhc2tfcmVtb3ZlX3dmZShzdHJ1Y3QgY21kcV90YXNrICp0YXNrKQ0KLXsN
Ci0Jc3RydWN0IGRldmljZSAqZGV2ID0gdGFzay0+Y21kcS0+bWJveC5kZXY7DQotCXU2NCAqYmFz
ZSA9IHRhc2stPnBrdC0+dmFfYmFzZTsNCi0JaW50IGk7DQotDQotCWRtYV9zeW5jX3NpbmdsZV9m
b3JfY3B1KGRldiwgdGFzay0+cGFfYmFzZSwgdGFzay0+cGt0LT5jbWRfYnVmX3NpemUsDQotCQkJ
CURNQV9UT19ERVZJQ0UpOw0KLQlmb3IgKGkgPSAwOyBpIDwgQ01EUV9OVU1fQ01EKHRhc2stPnBr
dCk7IGkrKykNCi0JCWlmIChjbWRxX2NvbW1hbmRfaXNfd2ZlKGJhc2VbaV0pKQ0KLQkJCWJhc2Vb
aV0gPSAodTY0KUNNRFFfSlVNUF9CWV9PRkZTRVQgPDwgMzIgfA0KLQkJCQkgIENNRFFfSlVNUF9Q
QVNTOw0KLQlkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZShkZXYsIHRhc2stPnBhX2Jhc2UsIHRh
c2stPnBrdC0+Y21kX2J1Zl9zaXplLA0KLQkJCQkgICBETUFfVE9fREVWSUNFKTsNCi19DQotDQog
c3RhdGljIGJvb2wgY21kcV90aHJlYWRfaXNfaW5fd2ZlKHN0cnVjdCBjbWRxX3RocmVhZCAqdGhy
ZWFkKQ0KIHsNCiAJcmV0dXJuIHJlYWRsKHRocmVhZC0+YmFzZSArIENNRFFfVEhSX1dBSVRfVE9L
RU4pICYgQ01EUV9USFJfSVNfV0FJVElORzsNCiB9DQogDQotc3RhdGljIHZvaWQgY21kcV90aHJl
YWRfd2FpdF9lbmQoc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQsDQotCQkJCSB1bnNpZ25lZCBs
b25nIGVuZF9wYSkNCi17DQotCXN0cnVjdCBkZXZpY2UgKmRldiA9IHRocmVhZC0+Y2hhbi0+bWJv
eC0+ZGV2Ow0KLQl1bnNpZ25lZCBsb25nIGN1cnJfcGE7DQotDQotCWlmIChyZWFkbF9wb2xsX3Rp
bWVvdXRfYXRvbWljKHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUiwNCi0JCQljdXJy
X3BhLCBjdXJyX3BhID09IGVuZF9wYSwgMSwgMjApKQ0KLQkJZGV2X2VycihkZXYsICJHQ0UgdGhy
ZWFkIGNhbm5vdCBydW4gdG8gZW5kLlxuIik7DQotfQ0KLQ0KIHN0YXRpYyB2b2lkIGNtZHFfdGFz
a19leGVjX2RvbmUoc3RydWN0IGNtZHFfdGFzayAqdGFzaywgZW51bSBjbWRxX2NiX3N0YXR1cyBz
dGEpDQogew0KIAlzdHJ1Y3QgY21kcV90YXNrX2NiICpjYiA9ICZ0YXNrLT5wa3QtPmFzeW5jX2Ni
Ow0KQEAgLTM4NCwzNiArMzQ2LDE1IEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3NlbmRfZGF0YShz
dHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRhKQ0KIAkJV0FSTl9PTihjbWRxX3RocmVh
ZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkgPCAwKTsNCiAJCWN1cnJfcGEgPSByZWFkbCh0aHJlYWQt
PmJhc2UgKyBDTURRX1RIUl9DVVJSX0FERFIpOw0KIAkJZW5kX3BhID0gcmVhZGwodGhyZWFkLT5i
YXNlICsgQ01EUV9USFJfRU5EX0FERFIpOw0KLQ0KLQkJLyoNCi0JCSAqIEF0b21pYyBleGVjdXRp
b24gc2hvdWxkIHJlbW92ZSB0aGUgZm9sbG93aW5nIHdmZSwgaS5lLiBvbmx5DQotCQkgKiB3YWl0
IGV2ZW50IGF0IGZpcnN0IHRhc2ssIGFuZCBwcmV2ZW50IHRvIHBhdXNlIHdoZW4gcnVubmluZy4N
Ci0JCSAqLw0KLQkJaWYgKHRocmVhZC0+YXRvbWljX2V4ZWMpIHsNCi0JCQkvKiBHQ0UgaXMgZXhl
Y3V0aW5nIGlmIGNvbW1hbmQgaXMgbm90IFdGRSAqLw0KLQkJCWlmICghY21kcV90aHJlYWRfaXNf
aW5fd2ZlKHRocmVhZCkpIHsNCi0JCQkJY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQotCQkJ
CWNtZHFfdGhyZWFkX3dhaXRfZW5kKHRocmVhZCwgZW5kX3BhKTsNCi0JCQkJV0FSTl9PTihjbWRx
X3RocmVhZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkgPCAwKTsNCi0JCQkJLyogc2V0IHRvIHRoaXMg
dGFzayBkaXJlY3RseSAqLw0KLQkJCQl3cml0ZWwodGFzay0+cGFfYmFzZSwNCi0JCQkJICAgICAg
IHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUik7DQotCQkJfSBlbHNlIHsNCi0JCQkJ
Y21kcV90YXNrX2luc2VydF9pbnRvX3RocmVhZCh0YXNrKTsNCi0JCQkJY21kcV90YXNrX3JlbW92
ZV93ZmUodGFzayk7DQotCQkJCXNtcF9tYigpOyAvKiBtb2RpZnkganVtcCBiZWZvcmUgZW5hYmxl
IHRocmVhZCAqLw0KLQkJCX0NCisJCS8qIGNoZWNrIGJvdW5kYXJ5ICovDQorCQlpZiAoY3Vycl9w
YSA9PSBlbmRfcGEgLSBDTURRX0lOU1RfU0laRSB8fA0KKwkJICAgIGN1cnJfcGEgPT0gZW5kX3Bh
KSB7DQorCQkJLyogc2V0IHRvIHRoaXMgdGFzayBkaXJlY3RseSAqLw0KKwkJCXdyaXRlbCh0YXNr
LT5wYV9iYXNlLA0KKwkJCSAgICAgICB0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9DVVJSX0FERFIp
Ow0KIAkJfSBlbHNlIHsNCi0JCQkvKiBjaGVjayBib3VuZGFyeSAqLw0KLQkJCWlmIChjdXJyX3Bh
ID09IGVuZF9wYSAtIENNRFFfSU5TVF9TSVpFIHx8DQotCQkJICAgIGN1cnJfcGEgPT0gZW5kX3Bh
KSB7DQotCQkJCS8qIHNldCB0byB0aGlzIHRhc2sgZGlyZWN0bHkgKi8NCi0JCQkJd3JpdGVsKHRh
c2stPnBhX2Jhc2UsDQotCQkJCSAgICAgICB0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9DVVJSX0FE
RFIpOw0KLQkJCX0gZWxzZSB7DQotCQkJCWNtZHFfdGFza19pbnNlcnRfaW50b190aHJlYWQodGFz
ayk7DQotCQkJCXNtcF9tYigpOyAvKiBtb2RpZnkganVtcCBiZWZvcmUgZW5hYmxlIHRocmVhZCAq
Lw0KLQkJCX0NCisJCQljbWRxX3Rhc2tfaW5zZXJ0X2ludG9fdGhyZWFkKHRhc2spOw0KKwkJCXNt
cF9tYigpOyAvKiBtb2RpZnkganVtcCBiZWZvcmUgZW5hYmxlIHRocmVhZCAqLw0KIAkJfQ0KIAkJ
d3JpdGVsKHRhc2stPnBhX2Jhc2UgKyBwa3QtPmNtZF9idWZfc2l6ZSwNCiAJCSAgICAgICB0aHJl
YWQtPmJhc2UgKyBDTURRX1RIUl9FTkRfQUREUik7DQpAQCAtNDk1LDcgKzQzNiw2IEBAIHN0YXRp
YyBzdHJ1Y3QgbWJveF9jaGFuICpjbWRxX3hsYXRlKHN0cnVjdCBtYm94X2NvbnRyb2xsZXIgKm1i
b3gsDQogDQogCXRocmVhZCA9IChzdHJ1Y3QgY21kcV90aHJlYWQgKiltYm94LT5jaGFuc1tpbmRd
LmNvbl9wcml2Ow0KIAl0aHJlYWQtPnByaW9yaXR5ID0gc3AtPmFyZ3NbMV07DQotCXRocmVhZC0+
YXRvbWljX2V4ZWMgPSAoc3AtPmFyZ3NbMl0gIT0gMCk7DQogCXRocmVhZC0+Y2hhbiA9ICZtYm94
LT5jaGFuc1tpbmRdOw0KIA0KIAlyZXR1cm4gJm1ib3gtPmNoYW5zW2luZF07DQotLSANCjIuMTgu
MA0K

