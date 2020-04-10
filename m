Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27332C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC03F21473
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GismMTcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDJEdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:33:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgDJEdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:33:06 -0400
X-UUID: cad6a353866c418a8ecd2f0370e21662-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mHf6jiGpr7KeVe7S0awWVzvSk807Yo2QlCE0YtnWX7w=;
        b=GismMTcnv5BtfTLILJE6ntl/jGOc4Ha7h3YdiVZ8wZBaF39M5sqQVK1cy/9rJ0P33QOVciZLS2ViSO+9yO8DxUwaGWjY4KlkZVUcQ0ilSLodOzmOvFJcchyTNswNtPR8eiFRmNn2ZkODLkSst5Xd16Os+yDKfIBfoE4VtHzwNOo=;
X-UUID: cad6a353866c418a8ecd2f0370e21662-20200410
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1734901447; Fri, 10 Apr 2020 12:32:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Apr
 2020 12:32:57 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 10 Apr 2020 12:32:55 +0800
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
Subject: [PATCH v5 4/4] drm/mediatek: config mipitx impedance with calibration data
Date:   Fri, 10 Apr 2020 12:32:48 +0800
Message-ID: <20200410043248.114384-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200410043248.114384-1-jitao.shi@mediatek.com>
References: <20200410043248.114384-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E7751B2F5E74A0DD2D4F9F4687FC3C9AA570AB677C0BBF1D9A0DD199084342622000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVhZCBjYWxpYnJhdGlvbiBkYXRhIGZyb20gbnZtZW0sIGFuZCBjb25maWcgbWlwaXR4IGltcGVk
YW5jZSB3aXRoDQpjYWxpYnJhdGlvbiBkYXRhIHRvIG1ha2Ugc3VyZSB0aGVpciBpbXBlZGFuY2Ug
YXJlIDEwMG9obS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgICAg
ICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfbWlwaV90eC5oICAgICAgICB8ICAzICsrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19tdDgxODNfbWlwaV90eC5jIHwgMjEgKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgNjQg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19taXBpX3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0KaW5k
ZXggZTMwMWFmNjQ4MDllLi41ZTkxZmMyYzEzMTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX21pcGlfdHguYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19taXBpX3R4LmMNCkBAIC04OCw2ICs4OCw0NCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBo
eV9vcHMgbXRrX21pcGlfdHhfb3BzID0gew0KIAkub3duZXIgPSBUSElTX01PRFVMRSwNCiB9Ow0K
IA0KK3N0YXRpYyB2b2lkIG10a19taXBpX3R4X2dldF9jYWxpYnJhdGlvbl9kYXRhbChzdHJ1Y3Qg
bXRrX21pcGlfdHggKm1pcGlfdHgpDQorew0KKwlzdHJ1Y3QgbnZtZW1fY2VsbCAqY2VsbDsNCisJ
c2l6ZV90IGxlbjsNCisJdTMyICpidWY7DQorDQorCW1lbXNldChtaXBpX3R4LT5ydF9jb2RlLCAw
LCBzaXplb2YobWlwaV90eC0+cnRfY29kZSkpOw0KKwljZWxsID0gbnZtZW1fY2VsbF9nZXQobWlw
aV90eC0+ZGV2LCAiY2FsaWJyYXRpb24tZGF0YSIpOw0KKwlpZiAoSVNfRVJSKGNlbGwpKSB7DQor
CQlkZXZfaW5mbyhtaXBpX3R4LT5kZXYsICJjYW4ndCBnZXQgbnZtZW1fY2VsbF9nZXQsIGlnbm9y
ZSBpdFxuIik7DQorCX0gZWxzZSB7DQorCQlidWYgPSAodTMyICopbnZtZW1fY2VsbF9yZWFkKGNl
bGwsICZsZW4pOw0KKwkJbnZtZW1fY2VsbF9wdXQoY2VsbCk7DQorDQorCQlpZiAoSVNfRVJSKGJ1
ZikpIHsNCisJCQlkZXZfaW5mbyhtaXBpX3R4LT5kZXYsICJjYW4ndCBnZXQgZGF0YSwgaWdub3Jl
IGl0XG4iKTsNCisJCX0gZWxzZSB7DQorCQkJaWYgKGxlbiA8IDMgKiBzaXplb2YodTMyKSkgew0K
KwkJCQlkZXZfaW5mbyhtaXBpX3R4LT5kZXYsICJpbnZhbGlkIGNhbGlicmF0aW9uIGRhdGFcbiIp
Ow0KKwkJCQlrZnJlZShidWYpOw0KKwkJCQlyZXR1cm47DQorCQkJfQ0KKw0KKwkJCW1pcGlfdHgt
PnJ0X2NvZGVbMF0gPSAoKGJ1ZlswXSA+PiA2ICYgMHgxZikgPDwgNSkgfA0KKwkJCQkJICAgICAg
IChidWZbMF0gPj4gMTEgJiAweDFmKTsNCisJCQltaXBpX3R4LT5ydF9jb2RlWzFdID0gKChidWZb
MV0gPj4gMjcgJiAweDFmKSA8PCA1KSB8DQorCQkJCQkgICAgICAgKGJ1ZlswXSA+PiAxICYgMHgx
Zik7DQorCQkJbWlwaV90eC0+cnRfY29kZVsyXSA9ICgoYnVmWzFdID4+IDE3ICYgMHgxZikgPDwg
NSkgfA0KKwkJCQkJICAgICAgIChidWZbMV0gPj4gMjIgJiAweDFmKTsNCisJCQltaXBpX3R4LT5y
dF9jb2RlWzNdID0gKChidWZbMV0gPj4gNyAmIDB4MWYpIDw8IDUpIHwNCisJCQkJCSAgICAgICAo
YnVmWzFdID4+IDEyICYgMHgxZik7DQorCQkJbWlwaV90eC0+cnRfY29kZVs0XSA9ICgoYnVmWzJd
ID4+IDI3ICYgMHgxZikgPDwgNSkgfA0KKwkJCQkJICAgICAgIChidWZbMV0gPj4gMiAmIDB4MWYp
Ow0KKwkJCWtmcmVlKGJ1Zik7DQorCQl9DQorCX0NCit9DQorDQogc3RhdGljIGludCBtdGtfbWlw
aV90eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCkBAIC0xNzQsNiArMjEyLDggQEAgc3RhdGljIGludCBt
dGtfbWlwaV90eF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAltaXBp
X3R4LT5kZXYgPSBkZXY7DQogDQorCW10a19taXBpX3R4X2dldF9jYWxpYnJhdGlvbl9kYXRhbCht
aXBpX3R4KTsNCisNCiAJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIoZGV2LT5vZl9ub2RlLCBv
Zl9jbGtfc3JjX3NpbXBsZV9nZXQsDQogCQkJCSAgIG1pcGlfdHgtPnBsbCk7DQogfQ0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmgNCmluZGV4IGVlYTQ0MzI3ZmU5Zi4uYzc2ZjA3
YzNmZGViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4
LmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oDQpAQCAtMTIs
OSArMTIsMTEgQEANCiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCiAjaW5jbHVkZSA8bGludXgv
aW8uaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQorI2luY2x1ZGUgPGxpbnV4L252bWVt
LWNvbnN1bWVyLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcGh5L3BoeS5oPg0KKyNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQogDQogc3RydWN0IG10a19taXBpdHhfZGF0YSB7DQogCWNv
bnN0IHUzMiBtcHBsbF9wcmVzZXJ2ZTsNCkBAIC0yOCw2ICszMCw3IEBAIHN0cnVjdCBtdGtfbWlw
aV90eCB7DQogCXZvaWQgX19pb21lbSAqcmVnczsNCiAJdTMyIGRhdGFfcmF0ZTsNCiAJdTMyIG1p
cGl0eF9kcml2ZTsNCisJdTMyIHJ0X2NvZGVbNV07DQogCWNvbnN0IHN0cnVjdCBtdGtfbWlwaXR4
X2RhdGEgKmRyaXZlcl9kYXRhOw0KIAlzdHJ1Y3QgY2xrX2h3IHBsbF9odzsNCiAJc3RydWN0IGNs
ayAqcGxsOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgz
X21pcGlfdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHgu
Yw0KaW5kZXggZTRjYzk2Nzc1MGNiLi45ZjNlNTVhZWViYjIgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4LmMNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfbXQ4MTgzX21pcGlfdHguYw0KQEAgLTI4LDYgKzI4LDcgQEANCiAj
ZGVmaW5lIE1JUElUWF9QTExfQ09ONAkJMHgwMDNjDQogI2RlZmluZSBSR19EU0lfUExMX0lCSUFT
CQkoMyA8PCAxMCkNCiANCisjZGVmaW5lIE1JUElUWF9EMlBfUlRDT0RFCTB4MDEwMA0KICNkZWZp
bmUgTUlQSVRYX0QyX1NXX0NUTF9FTgkweDAxNDQNCiAjZGVmaW5lIE1JUElUWF9EMF9TV19DVExf
RU4JMHgwMjQ0DQogI2RlZmluZSBNSVBJVFhfQ0tfQ0tNT0RFX0VOCTB4MDMyOA0KQEAgLTEwOCw2
ICsxMDksMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIG10a19taXBpX3R4X3BsbF9v
cHMgPSB7DQogCS5yZWNhbGNfcmF0ZSA9IG10a19taXBpX3R4X3BsbF9yZWNhbGNfcmF0ZSwNCiB9
Ow0KIA0KK3N0YXRpYyB2b2lkIG10a19taXBpX3R4X2NvbmZpZ19jYWxpYnJhdGlvbl9kYXRhKHN0
cnVjdCBtdGtfbWlwaV90eCAqbWlwaV90eCkNCit7DQorCWludCBpLCBqOw0KKw0KKwlmb3IgKGkg
PSAwOyBpIDwgNTsgaSsrKSB7DQorCQlpZiAoKG1pcGlfdHgtPnJ0X2NvZGVbaV0gJiAweDFmKSA9
PSAwKQ0KKwkJCW1pcGlfdHgtPnJ0X2NvZGVbaV0gfD0gMHgxMDsNCisNCisJCWlmICgobWlwaV90
eC0+cnRfY29kZVtpXSA+PiA1ICYgMHgxZikgPT0gMCkNCisJCQltaXBpX3R4LT5ydF9jb2RlW2ld
IHw9IDB4MTAgPDwgNTsNCisNCisJCWZvciAoaiA9IDA7IGogPCAxMDsgaisrKQ0KKwkJCW10a19t
aXBpX3R4X3VwZGF0ZV9iaXRzKG1pcGlfdHgsDQorCQkJCU1JUElUWF9EMlBfUlRDT0RFICogKGkg
KyAxKSArIGogKiA0LA0KKwkJCQkxLCBtaXBpX3R4LT5ydF9jb2RlW2ldID4+IGogJiAxKTsNCisJ
fQ0KK30NCisNCiBzdGF0aWMgdm9pZCBtdGtfbWlwaV90eF9wb3dlcl9vbl9zaWduYWwoc3RydWN0
IHBoeSAqcGh5KQ0KIHsNCiAJc3RydWN0IG10a19taXBpX3R4ICptaXBpX3R4ID0gcGh5X2dldF9k
cnZkYXRhKHBoeSk7DQpAQCAtMTMwLDYgKzE0OSw4IEBAIHN0YXRpYyB2b2lkIG10a19taXBpX3R4
X3Bvd2VyX29uX3NpZ25hbChzdHJ1Y3QgcGh5ICpwaHkpDQogCQkJCVJHX0RTSV9IU1RYX0xET19S
RUZfU0VMLA0KIAkJCQkobWlwaV90eC0+bWlwaXR4X2RyaXZlIC0gMzAwMCkgLyAyMDAgPDwgNik7
DQogDQorCW10a19taXBpX3R4X2NvbmZpZ19jYWxpYnJhdGlvbl9kYXRhKG1pcGlfdHgpOw0KKw0K
IAltdGtfbWlwaV90eF9zZXRfYml0cyhtaXBpX3R4LCBNSVBJVFhfQ0tfQ0tNT0RFX0VOLCBEU0lf
Q0tfQ0tNT0RFX0VOKTsNCiB9DQogDQotLSANCjIuMjEuMA0K

