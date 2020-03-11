Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDFC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EDD208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rklOp7H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgCKHS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:18:58 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5935 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728422AbgCKHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:18:57 -0400
X-UUID: a78e075567184464a8e90e09701f4585-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=//egP2daUjOgIwpeeyA91Ud79+Z1pS62TEhIP48EiB4=;
        b=rklOp7H7FMh1EiFSYMb+wB4WxJK+/4Z05wood8CTO+v2ftkHmwrRqzPz5IFCOoVXroRjHHk9V2i1YxczhoQYIcP6Ug/MuPHDd+fPOTh6mgj6VA0ns6il24FbI1VoMfdpZC1TR8nvRkOFJ3qSmuUNzHivNRxPvhdHB3Tjc8/4Wag=;
X-UUID: a78e075567184464a8e90e09701f4585-20200311
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 244190126; Wed, 11 Mar 2020 15:18:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:19:09 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:18:12 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v13 6/6] drm/mediatek: set dpi pin mode to gpio low to avoid leakage current
Date:   Wed, 11 Mar 2020 15:18:23 +0800
Message-ID: <20200311071823.117899-7-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311071823.117899-1-jitao.shi@mediatek.com>
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F6443FB13F5E019EB639DC1C9F2F38ACAD898DE332AEB015D24A81251CC07F532000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3aGVuIGRwaSBpcyBk
aXNhYmxlZC4NCkFvdmlkIGxlYWthZ2UgY3VycmVudCBmcm9tIHNvbWUgZHBpIHBpbnMgKEhzeW5j
IFZzeW5jIERFIC4uLiApLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwg
MzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQppbmRleCAyODcxZTY4
ZTc3NjcuLmI2MzU5ZTk3OTU4OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCkBA
IC0xMCw3ICsxMCw5IEBADQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCisjaW5jbHVkZSA8bGlu
dXgvb2ZfZ3Bpby5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KIA0KQEAgLTc0LDYgKzc2LDkgQEAgc3Ry
dWN0IG10a19kcGkgew0KIAllbnVtIG10a19kcGlfb3V0X3ljX21hcCB5Y19tYXA7DQogCWVudW0g
bXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KIAllbnVtIG10a19kcGlfb3V0X2NoYW5uZWxf
c3dhcCBjaGFubmVsX3N3YXA7DQorCXN0cnVjdCBwaW5jdHJsICpwaW5jdHJsOw0KKwlzdHJ1Y3Qg
cGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KKwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19k
cGk7DQogCWludCByZWZjb3VudDsNCiAJdTMyIHBjbGtfc2FtcGxlOw0KIH07DQpAQCAtMzg3LDYg
KzM5Miw5IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtfZHBpICpk
cGkpDQogCWlmICgtLWRwaS0+cmVmY291bnQgIT0gMCkNCiAJCXJldHVybjsNCiANCisJaWYgKGRw
aS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCisJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRw
aS0+cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KKw0KIAltdGtfZHBpX2Rpc2FibGUoZHBpKTsN
CiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+cGl4ZWxfY2xrKTsNCiAJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGRwaS0+ZW5naW5lX2Nsayk7DQpAQCAtNDExLDYgKzQxOSw5IEBAIHN0YXRpYyBp
bnQgbXRrX2RwaV9wb3dlcl9vbihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAkJZ290byBlcnJfcGl4
ZWw7DQogCX0NCiANCisJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZHBpKQ0KKwkJcGlu
Y3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZHBpKTsNCisNCiAJbXRr
X2RwaV9lbmFibGUoZHBpKTsNCiAJcmV0dXJuIDA7DQogDQpAQCAtNzI4LDYgKzczOSwyNiBAQCBz
dGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
b2ZfcHJvcGVydHlfcmVhZF91MzIoZXAsICJwY2xrLXNhbXBsZSIsICZkcGktPnBjbGtfc2FtcGxl
KTsNCiAJb2Zfbm9kZV9wdXQoZXApOw0KIA0KKwlkcGktPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxf
Z2V0KCZwZGV2LT5kZXYpOw0KKwlpZiAoSVNfRVJSKGRwaS0+cGluY3RybCkpIHsNCisJCWRwaS0+
cGluY3RybCA9IE5VTEw7DQorCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5j
dHJsIVxuIik7DQorCX0NCisJaWYgKGRwaS0+cGluY3RybCkgew0KKwkJZHBpLT5waW5zX2dwaW8g
PSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShkcGktPnBpbmN0cmwsICJzbGVlcCIpOw0KKwkJaWYgKElT
X0VSUihkcGktPnBpbnNfZ3BpbykpIHsNCisJCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQorCQkJ
ZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fubm90IGZpbmQgcGluY3RybCBpZGxlIVxuIik7DQorCQl9
DQorCQlpZiAoZHBpLT5waW5zX2dwaW8pDQorCQkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5w
aW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7DQorDQorCQlkcGktPnBpbnNfZHBpID0gcGluY3RybF9s
b29rdXBfc3RhdGUoZHBpLT5waW5jdHJsLCAiZGVmYXVsdCIpOw0KKwkJaWYgKElTX0VSUihkcGkt
PnBpbnNfZHBpKSkgew0KKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KKwkJCWRldl9kYmcoJnBk
ZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgYWN0aXZlIVxuIik7DQorCQl9DQorCX0NCiAJ
bWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJ
ZHBpLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCiAJaWYgKElTX0VS
UihkcGktPnJlZ3MpKSB7DQotLSANCjIuMjEuMA0K

