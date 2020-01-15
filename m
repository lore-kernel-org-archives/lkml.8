Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10946C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD324656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JmgJQc3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgAOOBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:01:21 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:38283 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729133AbgAOOBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:18 -0500
X-UUID: 5b56a25171ea4de8be2b2551f0f22d19-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H5OZq43lseoJbAte5FGzei/it0uT9wMq/wUce9c8DTk=;
        b=JmgJQc3/hSwa48Q+/GaXplBGTW5etoyFta+WFutOWKAhAIlFat3CQykCD0JXHo9wZZSPYtanrmAzQcofSUpjXKs4ceavhureOKTQiibcJXbRe2FNFNxCm7nQIqiHAkOkVqPwAGsrqkLtIYdSUAUtUxRexMz4MzNornXZ/BvAFaY=;
X-UUID: 5b56a25171ea4de8be2b2551f0f22d19-20200115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 365432629; Wed, 15 Jan 2020 22:01:11 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 21:57:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:01:20 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v8 7/8] dt-bindings: display: panel: add AUO auo, b101uan08.3 panel documentation
Date:   Wed, 15 Jan 2020 21:59:57 +0800
Message-ID: <20200115135958.126303-8-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115135958.126303-1-jitao.shi@mediatek.com>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 47C1A3B39FDDA9CF03CE43C5B4524C4A83E3DB78B2107AD5C928EC188B01A65A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRjdW1lbnRhdGlvbiBmb3IgYXVvLGIxMDF1YW4wOC4zLCB3aGljaCBpcyBtaXBpIGRzaSB2
aWRlbyBwYW5lbA0KYW5kIHJlc29sdXRpb24gaXMgMTIwMHgxOTIwLg0KDQpTaWduZWQtb2ZmLWJ5
OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGlzcGxheS9w
YW5lbC9hdW8sYjEwMXVhbjA4LjMueWFtbCAgICAgICAgfCA3NCArKysrKysrKysrKysrKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGIxMDF1
YW4wOC4zLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L3BhbmVsL2F1byxiMTAxdWFuMDguMy55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGIxMDF1YW4wOC4zLnlhbWwNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmNhZmE4NzAxMjBmYg0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvcGFuZWwvYXVvLGIxMDF1YW4wOC4zLnlhbWwNCkBAIC0wLDAgKzEsNzQgQEANCisjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kaXNwbGF5L3BhbmVsL2F1byxiMTAxdWFuMDguMy55
YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KKw0KK3RpdGxlOiBBVU8gQjEwMVVBTjA4LjMgRFNJIERpc3BsYXkgUGFuZWwNCisNCitt
YWludGFpbmVyczoNCisgIC0gVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNv
bT4NCisgIC0gU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KKyAgLSBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwYW5lbC1jb21t
b24ueWFtbCMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgICAgIGNvbnN0
OiBhdW8sYjEwMXVhbjA4LjMNCisNCisgIHJlZzoNCisgICAgZGVzY3JpcHRpb246IHRoZSB2aXJ0
dWFsIGNoYW5uZWwgbnVtYmVyIG9mIGEgRFNJIHBlcmlwaGVyYWwNCisNCisgIGVuYWJsZS1ncGlv
czoNCisgICAgZGVzY3JpcHRpb246IGEgR1BJTyBzcGVjIGZvciB0aGUgZW5hYmxlIHBpbg0KKw0K
KyAgcHAxODAwLXN1cHBseToNCisgICAgZGVzY3JpcHRpb246IGNvcmUgdm9sdGFnZSBzdXBwbHkN
CisNCisgIGF2ZGQtc3VwcGx5Og0KKyAgICBkZXNjcmlwdGlvbjogcGhhbmRsZSBvZiB0aGUgcmVn
dWxhdG9yIHRoYXQgcHJvdmlkZXMgcG9zaXRpdmUgdm9sdGFnZQ0KKw0KKyAgYXZlZS1zdXBwbHk6
DQorICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIG9mIHRoZSByZWd1bGF0b3IgdGhhdCBwcm92aWRl
cyBuZWdhdGl2ZSB2b2x0YWdlDQorDQorICBiYWNrbGlnaHQ6DQorICAgIGRlc2NyaXB0aW9uOiBw
aGFuZGxlIG9mIHRoZSBiYWNrbGlnaHQgZGV2aWNlIGF0dGFjaGVkIHRvIHRoZSBwYW5lbA0KKw0K
KyAgcG9ydDogdHJ1ZQ0KKw0KK3JlcXVpcmVkOg0KKyAtIGNvbXBhdGlibGUNCisgLSByZWcNCisg
LSBlbmFibGUtZ3Bpb3MNCisgLSBwcDE4MDAtc3VwcGx5DQorIC0gYXZkZC1zdXBwbHkNCisgLSBh
dmVlLXN1cHBseQ0KKyAtIGJhY2tsaWdodA0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGRzaSB7DQorICAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCisgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgcGFuZWxA
MCB7DQorICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdW8sYjEwMXVhbjA4LjMiOw0KKyAgICAg
ICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICBlbmFibGUtZ3Bpb3MgPSA8JnBpbyA0NSAw
PjsNCisgICAgICAgICAgICBhdmRkLXN1cHBseSA9IDwmcHB2YXJuX2xjZD47DQorICAgICAgICAg
ICAgYXZlZS1zdXBwbHkgPSA8JnBwdmFycF9sY2Q+Ow0KKyAgICAgICAgICAgIHBwMTgwMC1zdXBw
bHkgPSA8JnBwMTgwMF9sY2Q+Ow0KKyAgICAgICAgICAgIGJhY2tsaWdodCA9IDwmYmFja2xpZ2h0
X2xjZDA+Ow0KKyAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCisgICAgICAgICAgICBwb3J0
IHsNCisgICAgICAgICAgICAgICAgcGFuZWxfaW46IGVuZHBvaW50IHsNCisgICAgICAgICAgICAg
ICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmZHNpX291dD47DQorICAgICAgICAgICAgICAgIH07
DQorICAgICAgICAgICAgfTsNCisgICAgICAgIH07DQorICAgIH07DQorDQorLi4uDQotLSANCjIu
MjEuMA0K

