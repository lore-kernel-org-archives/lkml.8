Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698E6C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431932072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mZ8IDEeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgB1NpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbgB1NpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:18 -0500
X-UUID: 1387cbf876df464ebdec84e5f949395c-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ppb4UkHf8lLsaqd2zlsjL9zcISu4nncSfFXbQqr/dQc=;
        b=mZ8IDEeJnJvtkOSrt76i5FQ0y1TCwkPxIYEtfUdDN1IOGVFLziiC5CC1242o87YER4UGk/kocSZON3rfVGKnJwYxwImjNqP5siSyJ0oQGyPwFYz1JTvQXbBTntkkqWg3eeOeEd3kk5dbQYCJAws0UucgthXwoOvTGsErV/wNRPk=;
X-UUID: 1387cbf876df464ebdec84e5f949395c-20200228
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 619647150; Fri, 28 Feb 2020 21:45:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:03 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 04/13] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Fri, 28 Feb 2020 21:44:12 +0800
Message-ID: <1582897461-15105-6-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AFF8A4E223F36FC7D7DCDD681114757C180A6EEC14B10EAEB2300591246FEA7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5jDQppbmRleCA3MjQ2YjdlMjFhMmUuLjUwZGVjMDE1NTkzZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmMNCkBAIC0zODcsNiArMzg3LDEyIEBAIHN0YXRpYyBpbnQgY21k
cV9tYm94X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRhKQ0KIA0K
IAlpZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpIHsNCiAJCVdBUk5fT04o
Y2xrX2VuYWJsZShjbWRxLT5jbG9jaykgPCAwKTsNCisJCS8qDQorCQkgKiBUaGUgdGhyZWFkIHJl
c2V0IHdpbGwgY2xlYXIgdGhyZWFkIHJlbGF0ZWQgcmVnaXN0ZXIgdG8gMCwNCisJCSAqIGluY2x1
ZGluZyBwYywgZW5kLCBwcmlvcml0eSwgaXJxLCBzdXNwZW5kIGFuZCBlbmFibGUuIFRodXMNCisJ
CSAqIHNldCBDTURRX1RIUl9FTkFCTEVEIHRvIENNRFFfVEhSX0VOQUJMRV9UQVNLIHdpbGwgZW5h
YmxlDQorCQkgKiB0aHJlYWQgYW5kIG1ha2UgaXQgcnVubmluZy4NCisJCSAqLw0KIAkJV0FSTl9P
TihjbWRxX3RocmVhZF9yZXNldChjbWRxLCB0aHJlYWQpIDwgMCk7DQogDQogCQl3cml0ZWwodGFz
ay0+cGFfYmFzZSA+PiBjbWRxLT5zaGlmdF9wYSwNCkBAIC00NTAsNiArNDU2LDM4IEBAIHN0YXRp
YyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiANCiBzdGF0
aWMgdm9pZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCiB7DQor
CXN0cnVjdCBjbWRxX3RocmVhZCAqdGhyZWFkID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKWNoYW4t
PmNvbl9wcml2Ow0KKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShjaGFuLT5t
Ym94LT5kZXYpOw0KKwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KKwl1bnNpZ25lZCBs
b25nIGZsYWdzOw0KKw0KKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBm
bGFncyk7DQorCWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdv
dG8gZG9uZTsNCisNCisJV0FSTl9PTihjbWRxX3RocmVhZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkg
PCAwKTsNCisNCisJLyogbWFrZSBzdXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxs
YmFjayAqLw0KKwljbWRxX3RocmVhZF9pcnFfaGFuZGxlcihjbWRxLCB0aHJlYWQpOw0KKwlpZiAo
bGlzdF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQorCQlnb3RvIGRvbmU7DQorDQor
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRhc2tfYnVzeV9s
aXN0LA0KKwkJCQkgbGlzdF9lbnRyeSkgew0KKwkJY21kcV90YXNrX2V4ZWNfZG9uZSh0YXNrLCAt
RUNPTk5BQk9SVEVEKTsNCisJCWtmcmVlKHRhc2spOw0KKwl9DQorDQorCWNtZHFfdGhyZWFkX2Rp
c2FibGUoY21kcSwgdGhyZWFkKTsNCisJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KK2RvbmU6
DQorCS8qDQorCSAqIFRoZSB0aHJlYWQtPnRhc2tfYnVzeV9saXN0IGVtcHR5IG1lYW5zIHRocmVh
ZCBhbHJlYWR5IGRpc2FibGUuIFRoZQ0KKwkgKiBjbWRxX21ib3hfc2VuZF9kYXRhKCkgYWx3YXlz
IHJlc2V0IHRocmVhZCB3aGljaCBjbGVhciBkaXNhYmxlIGFuZA0KKwkgKiBzdXNwZW5kIHN0YXR1
ZSB3aGVuIGZpcnN0IHBrdCBzZW5kIHRvIGNoYW5uZWwsIHNvIHRoZXJlIGlzIG5vIG5lZWQNCisJ
ICogdG8gZG8gYW55IG9wZXJhdGlvbiBoZXJlLCBvbmx5IHVubG9jayBhbmQgbGVhdmUuDQorCSAq
Lw0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsN
CiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtYm94X2NoYW5fb3BzIGNtZHFfbWJveF9jaGFu
X29wcyA9IHsNCi0tIA0KMi4xOC4wDQo=

