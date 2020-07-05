Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD56DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D47A20870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SyBFKzt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGEGh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:37:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbgGEGh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:37:29 -0400
X-UUID: ff88b3d6a95543858b0dd4c0a8e8f9ee-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H8QcGrkRwb9r12g7RW7vRcc+HdqW1TEDVi2UVMczqEw=;
        b=SyBFKzt8HafvmDNlNr/QJY+rNqs1gp4N8QAsXeHSHaQa44Zc7rsfbqekJkaPx3B2hHe8WDrCCgtw8MSoz+swPdnpAmHV4dFPQTZJJwslx1GiGrO63OmL4D9YjD08Qk0AxyegqcnQuOT+fYarnvu7c9G2XbwZMKTejiU5vnU92nw=;
X-UUID: ff88b3d6a95543858b0dd4c0a8e8f9ee-20200705
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1973456499; Sun, 05 Jul 2020 14:37:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:37:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:37:18 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v8 4/4] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Sun, 5 Jul 2020 14:37:16 +0800
Message-ID: <1593931037-24405-5-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593931037-24405-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1593931037-24405-1-git-send-email-dennis-yc.hsieh@mediatek.com>
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
PGNrLmh1QG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBCaWJieSBIc2llaCA8YmliYnkuaHNp
ZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
YyB8ICAgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDM4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQpp
bmRleCAwOGJkNGYxZWI0NjkuLjQ4NGQ0NDM4Y2Q4MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmMNCkBAIC0zNDksNiArMzQ5LDEyIEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3NlbmRf
ZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRhKQ0KIA0KIAlpZiAobGlzdF9l
bXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpIHsNCiAJCVdBUk5fT04oY2xrX2VuYWJsZShj
bWRxLT5jbG9jaykgPCAwKTsNCisJCS8qDQorCQkgKiBUaGUgdGhyZWFkIHJlc2V0IHdpbGwgY2xl
YXIgdGhyZWFkIHJlbGF0ZWQgcmVnaXN0ZXIgdG8gMCwNCisJCSAqIGluY2x1ZGluZyBwYywgZW5k
LCBwcmlvcml0eSwgaXJxLCBzdXNwZW5kIGFuZCBlbmFibGUuIFRodXMNCisJCSAqIHNldCBDTURR
X1RIUl9FTkFCTEVEIHRvIENNRFFfVEhSX0VOQUJMRV9UQVNLIHdpbGwgZW5hYmxlDQorCQkgKiB0
aHJlYWQgYW5kIG1ha2UgaXQgcnVubmluZy4NCisJCSAqLw0KIAkJV0FSTl9PTihjbWRxX3RocmVh
ZF9yZXNldChjbWRxLCB0aHJlYWQpIDwgMCk7DQogDQogCQl3cml0ZWwodGFzay0+cGFfYmFzZSA+
PiBjbWRxLT5zaGlmdF9wYSwNCkBAIC0zOTEsNiArMzk3LDM4IEBAIHN0YXRpYyBpbnQgY21kcV9t
Ym94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiANCiBzdGF0aWMgdm9pZCBjbWRx
X21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiB7DQorCXN0cnVjdCBjbWRx
X3RocmVhZCAqdGhyZWFkID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKWNoYW4tPmNvbl9wcml2Ow0K
KwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShjaGFuLT5tYm94LT5kZXYpOw0K
KwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
Kw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQorCWlm
IChsaXN0X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gZG9uZTsNCisN
CisJV0FSTl9PTihjbWRxX3RocmVhZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkgPCAwKTsNCisNCisJ
LyogbWFrZSBzdXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxsYmFjayAqLw0KKwlj
bWRxX3RocmVhZF9pcnFfaGFuZGxlcihjbWRxLCB0aHJlYWQpOw0KKwlpZiAobGlzdF9lbXB0eSgm
dGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQorCQlnb3RvIGRvbmU7DQorDQorCWxpc3RfZm9yX2Vh
Y2hfZW50cnlfc2FmZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0LA0KKwkJCQkg
bGlzdF9lbnRyeSkgew0KKwkJY21kcV90YXNrX2V4ZWNfZG9uZSh0YXNrLCBDTURRX0NCX0VSUk9S
KTsNCisJCWtmcmVlKHRhc2spOw0KKwl9DQorDQorCWNtZHFfdGhyZWFkX2Rpc2FibGUoY21kcSwg
dGhyZWFkKTsNCisJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KK2RvbmU6DQorCS8qDQorCSAq
IFRoZSB0aHJlYWQtPnRhc2tfYnVzeV9saXN0IGVtcHR5IG1lYW5zIHRocmVhZCBhbHJlYWR5IGRp
c2FibGUuIFRoZQ0KKwkgKiBjbWRxX21ib3hfc2VuZF9kYXRhKCkgYWx3YXlzIHJlc2V0IHRocmVh
ZCB3aGljaCBjbGVhciBkaXNhYmxlIGFuZA0KKwkgKiBzdXNwZW5kIHN0YXR1ZSB3aGVuIGZpcnN0
IHBrdCBzZW5kIHRvIGNoYW5uZWwsIHNvIHRoZXJlIGlzIG5vIG5lZWQNCisJICogdG8gZG8gYW55
IG9wZXJhdGlvbiBoZXJlLCBvbmx5IHVubG9jayBhbmQgbGVhdmUuDQorCSAqLw0KKwlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCiB9DQogDQogc3Rh
dGljIGludCBjbWRxX21ib3hfZmx1c2goc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdW5zaWduZWQg
bG9uZyB0aW1lb3V0KQ0KLS0gDQoxLjcuOS41DQo=

