Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6024020774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dojQKfoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgE3IMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:12:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:12:49 -0400
X-UUID: da84064dafd24f1dad25d509d15d93a4-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FVvAj8hrseke26uN4MdXVYbX/cu/UQsw+RdzhV9mMw0=;
        b=dojQKfoU6Nzs4/LGEGXwCARwzd0PhIno8wEVc06NoeijjrrOVuS/Iri870D4j+tNe4YzJaU+Y0xg5/X8xLt6KtpNwUz0nENMPH1RGFsJmaQXaGhNYhifHpCtS4njO87OJ0fzWota/5bRZPsJaxpoaUEgAKXeZA+WtD+nhgek5Fs=;
X-UUID: da84064dafd24f1dad25d509d15d93a4-20200530
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 935374056; Sat, 30 May 2020 16:12:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:12:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:12:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 03/17] iommu/mediatek: Add probe_defer for smi-larb
Date:   Sat, 30 May 2020 16:10:04 +0800
Message-ID: <1590826218-23653-4-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGlvbW11IGNvbnN1bWVyIHNob3VsZCB1c2UgZGV2aWNlX2xpbmsgdG8gY29ubmVjdCB3aXRo
IHRoZQ0Kc21pLWxhcmIoc3VwcGxpZXIpLiB0aGVuIHRoZSBzbWktbGFyYiBzaG91bGQgcnVuIGJl
Zm9yZSB0aGUgaW9tbXUNCmNvbnN1bWVyLiBIZXJlIHdlIGRlbGF5IHRoZSBpb21tdSBkcml2ZXIg
dW50aWwgdGhlIHNtaSBkcml2ZXIgaXMNCnJlYWR5LCB0aGVuIGFsbCB0aGUgaW9tbXUgY29uc3Vt
ZXIgYWx3YXlzIGlzIGFmdGVyIHRoZSBzbWkgZHJpdmVyLg0KDQpXaGVuIHRoZXJlIGlzIG5vIHRo
aXMgcGF0Y2gsIGlmIHNvbWUgY29uc3VtZXIgZHJpdmVycyBydW4gYmVmb3JlDQpzbWktbGFyYiwg
dGhlIHN1cHBsaWVyIGxpbmtfc3RhdHVzIGlzIERMX0RFVl9OT19EUklWRVIoMCkgaW4gdGhlDQpk
ZXZpY2VfbGlua19hZGQsIHRoZW4gZGV2aWNlX2xpbmtzX2RyaXZlcl9ib3VuZCB3aWxsIHVzZSBX
QVJOX09ODQp0byBjb21wbGFpbiB0aGF0IHRoZSBsaW5rX3N0YXR1cyBvZiBzdXBwbGllciBpcyBu
b3QgcmlnaHQuDQoNClRoaXMgaXMgYSBwcmVwYXJpbmcgcGF0Y2ggZm9yIGFkZGluZyBkZXZpY2Vf
bGluay4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jICAgIHwgOCArKysrKysrLQ0KIGRyaXZlcnMv
aW9tbXUvbXRrX2lvbW11X3YxLmMgfCA3ICsrKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggMmJlOTZmMS4u
N2Q4ZjNkMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC02NDMsNiArNjQzLDcgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJZm9yIChpID0g
MDsgaSA8IGxhcmJfbnI7IGkrKykgew0KIAkJc3RydWN0IGRldmljZV9ub2RlICpsYXJibm9kZTsN
CiAJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBsYXJiZGV2Ow0KKwkJYm9vbCBsYXJiZGV2X2lz
X2JvdW5kID0gZmFsc2U7DQogCQl1MzIgaWQ7DQogDQogCQlsYXJibm9kZSA9IG9mX3BhcnNlX3Bo
YW5kbGUoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbGFyYnMiLCBpKTsNCkBAIC02NTksNyArNjYw
LDEyIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogCQkJaWQgPSBpOw0KIA0KIAkJcGxhcmJkZXYgPSBvZl9maW5kX2RldmljZV9ieV9u
b2RlKGxhcmJub2RlKTsNCi0JCWlmICghcGxhcmJkZXYpIHsNCisJCWlmIChwbGFyYmRldikgew0K
KwkJCWRldmljZV9sb2NrKCZwbGFyYmRldi0+ZGV2KTsNCisJCQlsYXJiZGV2X2lzX2JvdW5kID0g
ZGV2aWNlX2lzX2JvdW5kKCZwbGFyYmRldi0+ZGV2KTsNCisJCQlkZXZpY2VfdW5sb2NrKCZwbGFy
YmRldi0+ZGV2KTsNCisJCX0NCisJCWlmICghcGxhcmJkZXYgfHwgIWxhcmJkZXZfaXNfYm91bmQp
IHsNCiAJCQlvZl9ub2RlX3B1dChsYXJibm9kZSk7DQogCQkJcmV0dXJuIC1FUFJPQkVfREVGRVI7
DQogCQl9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11X3YxLmMNCmluZGV4IDEyNDVlMGMuLjAyODU4YTAgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdV92MS5jDQpAQCAtNTkxLDEwICs1OTEsMTUgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJCXBsYXJiZGV2ID0gb2Zf
ZmluZF9kZXZpY2VfYnlfbm9kZShsYXJiX3NwZWMubnApOw0KIAkJaWYgKCFwbGFyYmRldikgew0K
KwkJCWJvb2wgbGFyYmRldl9pc19ib3VuZDsNCisNCiAJCQlwbGFyYmRldiA9IG9mX3BsYXRmb3Jt
X2RldmljZV9jcmVhdGUoDQogCQkJCQkJbGFyYl9zcGVjLm5wLCBOVUxMLA0KIAkJCQkJCXBsYXRm
b3JtX2J1c190eXBlLmRldl9yb290KTsNCi0JCQlpZiAoIXBsYXJiZGV2KSB7DQorCQkJZGV2aWNl
X2xvY2soJnBsYXJiZGV2LT5kZXYpOw0KKwkJCWxhcmJkZXZfaXNfYm91bmQgPSBkZXZpY2VfaXNf
Ym91bmQoJnBsYXJiZGV2LT5kZXYpOw0KKwkJCWRldmljZV91bmxvY2soJnBsYXJiZGV2LT5kZXYp
Ow0KKwkJCWlmICghcGxhcmJkZXYgfHwgIWxhcmJkZXZfaXNfYm91bmQpIHsNCiAJCQkJb2Zfbm9k
ZV9wdXQobGFyYl9zcGVjLm5wKTsNCiAJCQkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQogCQkJfQ0K
LS0gDQoxLjkuMQ0K

