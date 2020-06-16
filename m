Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB2207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JCHVluwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFPMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:34:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62858 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgFPMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:34:58 -0400
X-UUID: c02764eaeb6245f7bd17e571a64225b0-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1y6jYCU5bn8D2X7/K/Tvzzlj7X36JuNHASO4pxrPu4w=;
        b=JCHVluwvubnAC79HGWfxQzzbZHBAdnggu2+TvgzBhgLQH4zt6HkdYKRLcHgEjSFP1988uVhl5+eAJEQbL0bMrRiwaP9khpc8Xbb1LkhQmOc+g1uDNSo0O1yVDknyGEbVlrFM/wekguEQ6endFEJxhF6jHvaNLC1NPDBnivckaFE=;
X-UUID: c02764eaeb6245f7bd17e571a64225b0-20200616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1283620589; Tue, 16 Jun 2020 20:34:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 20:34:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 20:34:45 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH 1/2] usb: gadget: introduce flag for large request
Date:   Tue, 16 Jun 2020 20:34:43 +0800
Message-ID: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBVU0IgaGFyZHdhcmUgbGlrZSBETUEgZW5naW5lIGNhbiBoZWxwIHRvIHByb2Nlc3MgKHNw
bGl0KSB0aGUgZGF0YQ0Kb2YgZWFjaCBVUkIgcmVxdWVzdCBpbnRvIHNtYWxsIHBhY2tldHMuIEZv
ciBleGFtcGxlLCB0aGUgbWF4IHBhY2tldCBzaXplDQpvZiBoaWdoIHNwZWVkIGlzIDUxMiBieXRl
cy4gVGhlc2Uga2luZHMgb2YgaGFyZHdhcmUgY2FuIGhlbHAgdG8gc3BsaXQNCnRoZSBjb250aW51
ZSBUeC9SeCBkYXRhIHJlcXVlc3RzIGludG8gcGFja2V0cyBqdXN0IGF0IHRoZSBtYXggcGFja2V0
DQpzaXplIGR1cmluZyB0cmFuc21pc3Npb24uIEhlbmNlIHVwcGVyIGxheWVyIHNvZnR3YXJlIGNh
biByZWR1Y2Ugc29tZQ0KZWZmb3J0IGZvciBxdWV1ZWluZyBtYW55IHJlcXVlc3RzIGJhY2sgYW5k
IGZvcnRoIGZvciBsYXJnZXIgZGF0YS4NCg0KSGVyZSB3ZSBpbnRyb2R1Y2UgImNhbl9leGNlZWRf
bWF4cCIgZmxhZyBpbiBnYWRnZXQgd2hlbiB0aGVzZSBraW5kcyBvZg0KaGFyZHdhcmUgaXMgcmVh
ZHkgdG8gc3VwcG9ydCB0aGVzZSBvcGVyYXRpb25zLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVs
IExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvbXR1My9t
dHUzX3FtdS5jIHwgICAxMSArKysrKysrKysrLQ0KIGluY2x1ZGUvbGludXgvdXNiL2dhZGdldC5o
ICB8ICAgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3FtdS5jIGIvZHJpdmVy
cy91c2IvbXR1My9tdHUzX3FtdS5jDQppbmRleCAzZjQxNGY5Li4yYjUxYTIwIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3FtdS5jDQorKysgYi9kcml2ZXJzL3VzYi9tdHUzL210
dTNfcW11LmMNCkBAIC02MjAsNyArNjIwLDcgQEAgaXJxcmV0dXJuX3QgbXR1M19xbXVfaXNyKHN0
cnVjdCBtdHUzICptdHUpDQogDQogaW50IG10dTNfcW11X2luaXQoc3RydWN0IG10dTMgKm10dSkN
CiB7DQotDQorCWludCBpOw0KIAljb21waWxldGltZV9hc3NlcnQoUU1VX0dQRF9TSVpFID09IDE2
LCAiUU1VX0dQRCBzaXplIFNIT1VMRCBiZSAxNkIiKTsNCiANCiAJbXR1LT5xbXVfZ3BkX3Bvb2wg
PSBkbWFfcG9vbF9jcmVhdGUoIlFNVV9HUEQiLCBtdHUtPmRldiwNCkBAIC02MjksMTAgKzYyOSwx
OSBAQCBpbnQgbXR1M19xbXVfaW5pdChzdHJ1Y3QgbXR1MyAqbXR1KQ0KIAlpZiAoIW10dS0+cW11
X2dwZF9wb29sKQ0KIAkJcmV0dXJuIC1FTk9NRU07DQogDQorCS8qIExldCBnYWRnZXQga25vdyB3
ZSBjYW4gcHJvY2VzcyByZXF1ZXN0IGxhcmdlciB0aGFuIG1heCBwYWNrZXQgKi8NCisJZm9yIChp
ID0gMTsgaSA8IG10dS0+bnVtX2VwczsgaSsrKQ0KKwkJbXR1LT5lcF9hcnJheVtpXS5lcC5jYW5f
ZXhjZWVkX21heHAgPSAxOw0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQogdm9pZCBtdHUzX3FtdV9l
eGl0KHN0cnVjdCBtdHUzICptdHUpDQogew0KKwlpbnQgaTsNCiAJZG1hX3Bvb2xfZGVzdHJveSht
dHUtPnFtdV9ncGRfcG9vbCk7DQorDQorCS8qIERpc2FibGUgbGFyZ2UgcmVxdWVzdCBzdXBwb3J0
ICovDQorCWZvciAoaSA9IDE7IGkgPCBtdHUtPm51bV9lcHM7IGkrKykNCisJCW10dS0+ZXBfYXJy
YXlbaV0uZXAuY2FuX2V4Y2VlZF9tYXhwID0gMDsNCiB9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC91c2IvZ2FkZ2V0LmggYi9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KaW5kZXggNmEx
NzgxNy4uNjBlMDY0NSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oDQor
KysgYi9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KQEAgLTIzNiw2ICsyMzYsNyBAQCBzdHJ1
Y3QgdXNiX2VwIHsNCiAJdW5zaWduZWQJCW1heF9zdHJlYW1zOjE2Ow0KIAl1bnNpZ25lZAkJbXVs
dDoyOw0KIAl1bnNpZ25lZAkJbWF4YnVyc3Q6NTsNCisJdW5zaWduZWQJCWNhbl9leGNlZWRfbWF4
cDoxOw0KIAl1OAkJCWFkZHJlc3M7DQogCWNvbnN0IHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3Jp
cHRvcgkqZGVzYzsNCiAJY29uc3Qgc3RydWN0IHVzYl9zc19lcF9jb21wX2Rlc2NyaXB0b3IJKmNv
bXBfZGVzYzsNCi0tIA0KMS43LjkuNQ0K

