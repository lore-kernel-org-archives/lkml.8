Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5DC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VgOHmY9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgBQJFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:05:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42498 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728272AbgBQJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:05:38 -0500
X-UUID: 37d5a81288844bd48585cebfe0914bbe-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I3Oim7gZHvMV9Qef+8S9vRrpbkNgTWn+GySP5pP9Xs4=;
        b=VgOHmY9/vyqGbxp3NtNb80kXHOXkz99xqU3Yx4wYe6vrpmytUFPPlDuVT+OzLTWxbSMkBZQcqKUm0uIdJvJLN+Viw0nBTG++rjLZPeCKEEvfwAGFis77uCeKiqiVR406C0iGVj7fLH3R/ndUA86k46me5gS5RFfn7nvNINd8N5M=;
X-UUID: 37d5a81288844bd48585cebfe0914bbe-20200217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 567318527; Mon, 17 Feb 2020 17:05:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:04:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:03:36 +0800
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
Subject: [PATCH v1 2/3] mailbox: mediatek: implement flush function
Date:   Mon, 17 Feb 2020 17:05:31 +0800
Message-ID: <20200217090532.16019-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGNsaWVudCBkcml2ZXIgd2hpY2ggbmVlZCB0byByZW9yZ2FuaXplIHRoZSBjb21tYW5kIGJ1
ZmZlciwgaXQgY291bGQNCnVzZSB0aGlzIGZ1bmN0aW9uIHRvIGZsdXNoIHRoZSBzZW5kIGNvbW1h
bmQgYnVmZmVyLg0KSWYgdGhlIGNoYW5uZWwgZG9lc24ndCBiZSBzdGFydGVkICh1c3VhbGx5IGlu
IHdhaXRpbmcgZm9yIGV2ZW50KSwgdGhpcw0KZnVuY3Rpb24gd2lsbCBhYm9ydCBpdCBkaXJlY3Rs
eS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCA1MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCmluZGV4IDlhNmNlOWY1YTdkYi4uMGRh
NWUyZGMyYzBlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KQEAgLTQzMiwxMCAr
NDMyLDYyIEBAIHN0YXRpYyB2b2lkIGNtZHFfbWJveF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFu
ICpjaGFuKQ0KIHsNCiB9DQogDQorc3RhdGljIGludCBjbWRxX21ib3hfZmx1c2goc3RydWN0IG1i
b3hfY2hhbiAqY2hhbiwgdW5zaWduZWQgbG9uZyB0aW1lb3V0KQ0KK3sNCisJc3RydWN0IGNtZHFf
dGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQor
CXN0cnVjdCBjbWRxX3Rhc2tfY2IgKmNiOw0KKwlzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGE7DQor
CXN0cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQor
CXN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ssICp0bXA7DQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQor
CXUzMiBlbmFibGU7DQorDQorCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ss
IGZsYWdzKTsNCisJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KKwkJ
Z290byBvdXQ7DQorDQorCVdBUk5fT04oY21kcV90aHJlYWRfc3VzcGVuZChjbWRxLCB0aHJlYWQp
IDwgMCk7DQorCWlmICghY21kcV90aHJlYWRfaXNfaW5fd2ZlKHRocmVhZCkpDQorCQlnb3RvIHdh
aXQ7DQorDQorCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRh
c2tfYnVzeV9saXN0LA0KKwkJCQkgbGlzdF9lbnRyeSkgew0KKwkJY2IgPSAmdGFzay0+cGt0LT5h
c3luY19jYjsNCisJCWlmIChjYi0+Y2IpIHsNCisJCQlkYXRhLnN0YSA9IENNRFFfQ0JfRVJST1I7
DQorCQkJZGF0YS5kYXRhID0gY2ItPmRhdGE7DQorCQkJY2ItPmNiKGRhdGEpOw0KKwkJfQ0KKwkJ
bGlzdF9kZWwoJnRhc2stPmxpc3RfZW50cnkpOw0KKwkJa2ZyZWUodGFzayk7DQorCX0NCisNCisJ
Y21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQorCWNtZHFfdGhyZWFkX2Rpc2FibGUoY21kcSwg
dGhyZWFkKTsNCisJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KKw0KK291dDoNCisJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQorCXJldHVybiAw
Ow0KKw0KK3dhaXQ6DQorCWNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQpOw0KKwlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCisJaWYgKHJlYWRsX3Bv
bGxfdGltZW91dF9hdG9taWModGhyZWFkLT5iYXNlICsgQ01EUV9USFJfRU5BQkxFX1RBU0ssDQor
CQkJCSAgICAgIGVuYWJsZSwgZW5hYmxlID09IDAsIDEsIHRpbWVvdXQpKSB7DQorCQlkZXZfZXJy
KGNtZHEtPm1ib3guZGV2LCAiRmFpbCB0byB3YWl0IEdDRSB0aHJlYWQgMHgleCBkb25lXG4iLA0K
KwkJCSh1MzIpKHRocmVhZC0+YmFzZSAtIGNtZHEtPmJhc2UpKTsNCisNCisJCXJldHVybiAtRUZB
VUxUOw0KKwl9DQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hf
Y2hhbl9vcHMgY21kcV9tYm94X2NoYW5fb3BzID0gew0KIAkuc2VuZF9kYXRhID0gY21kcV9tYm94
X3NlbmRfZGF0YSwNCiAJLnN0YXJ0dXAgPSBjbWRxX21ib3hfc3RhcnR1cCwNCiAJLnNodXRkb3du
ID0gY21kcV9tYm94X3NodXRkb3duLA0KKwkuZmx1c2ggPSBjbWRxX21ib3hfZmx1c2gsDQogfTsN
CiANCiBzdGF0aWMgc3RydWN0IG1ib3hfY2hhbiAqY21kcV94bGF0ZShzdHJ1Y3QgbWJveF9jb250
cm9sbGVyICptYm94LA0KLS0gDQoyLjE4LjANCg==

