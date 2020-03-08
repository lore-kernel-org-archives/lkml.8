Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF533C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A950720848
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sxd+C6H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgCHKxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbgCHKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:07 -0400
X-UUID: 6f359e42dd4d4c46b05d72c003071d9a-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D+dXiJm3APaX+tyDPhHiGjNPGNdy177jnTfCoMxdsUw=;
        b=sxd+C6H/1pJCw+IlJf2+1lPp0CGxZE30QBviNTfBqoTD8JeZjWGixl5rsmWbKUds+RvDXYJj9IptO+GWrF7ILMruAk2SvhoOjgdPEP1MkFxwMxMJ+cYNR6gOMyc5QMGnPmSUykM1Ch6N1E4xzgQyfg2Ro613Pl4rFENkImCBuNo=;
X-UUID: 6f359e42dd4d4c46b05d72c003071d9a-20200308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 278304618; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:52:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:58 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v5 04/13] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Sun, 8 Mar 2020 18:52:46 +0800
Message-ID: <1583664775-19382-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCmluZGV4
IDk5OTRhYzk0MjZkNi4uYjU2ZDM0MGM4OTgyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KQEAgLTM4Nyw2ICszODcsMTIgQEAgc3RhdGljIGludCBjbWRxX21ib3hfc2VuZF9kYXRh
KHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHZvaWQgKmRhdGEpDQogDQogCWlmIChsaXN0X2VtcHR5
KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkgew0KIAkJV0FSTl9PTihjbGtfZW5hYmxlKGNtZHEt
PmNsb2NrKSA8IDApOw0KKwkJLyoNCisJCSAqIFRoZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0
aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0KKwkJICogaW5jbHVkaW5nIHBjLCBlbmQsIHBy
aW9yaXR5LCBpcnEsIHN1c3BlbmQgYW5kIGVuYWJsZS4gVGh1cw0KKwkJICogc2V0IENNRFFfVEhS
X0VOQUJMRUQgdG8gQ01EUV9USFJfRU5BQkxFX1RBU0sgd2lsbCBlbmFibGUNCisJCSAqIHRocmVh
ZCBhbmQgbWFrZSBpdCBydW5uaW5nLg0KKwkJICovDQogCQlXQVJOX09OKGNtZHFfdGhyZWFkX3Jl
c2V0KGNtZHEsIHRocmVhZCkgPCAwKTsNCiANCiAJCXdyaXRlbCh0YXNrLT5wYV9iYXNlID4+IGNt
ZHEtPnNoaWZ0X3BhLA0KQEAgLTQ1MCw2ICs0NTYsMzggQEAgc3RhdGljIGludCBjbWRxX21ib3hf
c3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIA0KIHN0YXRpYyB2b2lkIGNtZHFfbWJv
eF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIHsNCisJc3RydWN0IGNtZHFfdGhy
ZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQorCXN0
cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQorCXN0
cnVjdCBjbWRxX3Rhc2sgKnRhc2ssICp0bXA7DQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQorDQor
CXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCisJaWYgKGxp
c3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KKwkJZ290byBkb25lOw0KKw0KKwlX
QVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KKw0KKwkvKiBt
YWtlIHN1cmUgZXhlY3V0ZWQgdGFza3MgaGF2ZSBzdWNjZXNzIGNhbGxiYWNrICovDQorCWNtZHFf
dGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQorCWlmIChsaXN0X2VtcHR5KCZ0aHJl
YWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gZG9uZTsNCisNCisJbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQorCQkJCSBsaXN0
X2VudHJ5KSB7DQorCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFfQ0JfRVJST1IpOw0K
KwkJa2ZyZWUodGFzayk7DQorCX0NCisNCisJY21kcV90aHJlYWRfZGlzYWJsZShjbWRxLCB0aHJl
YWQpOw0KKwljbGtfZGlzYWJsZShjbWRxLT5jbG9jayk7DQorZG9uZToNCisJLyoNCisJICogVGhl
IHRocmVhZC0+dGFza19idXN5X2xpc3QgZW1wdHkgbWVhbnMgdGhyZWFkIGFscmVhZHkgZGlzYWJs
ZS4gVGhlDQorCSAqIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBhbHdheXMgcmVzZXQgdGhyZWFkIHdo
aWNoIGNsZWFyIGRpc2FibGUgYW5kDQorCSAqIHN1c3BlbmQgc3RhdHVlIHdoZW4gZmlyc3QgcGt0
IHNlbmQgdG8gY2hhbm5lbCwgc28gdGhlcmUgaXMgbm8gbmVlZA0KKwkgKiB0byBkbyBhbnkgb3Bl
cmF0aW9uIGhlcmUsIG9ubHkgdW5sb2NrIGFuZCBsZWF2ZS4NCisJICovDQorCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9tYm94X2NoYW5fb3BzID0gew0KLS0gDQoy
LjE4LjANCg==

