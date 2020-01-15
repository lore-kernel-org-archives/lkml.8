Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35385C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077A624656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EX3kdniP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgAOOBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:01:11 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9815 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729579AbgAOOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:09 -0500
X-UUID: c46e1f77c5d0436a8f4f40209f91e052-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PC+y6XVTLynjl5MLpT/PpDxclDZ4cq1uAytMsDKh5DM=;
        b=EX3kdniPtlTtZg+iWH1VUwjCCGrsc3Z8UDZ7IL7a9GKh5yWXQuujAX+XCh5AB4qt7djyHRVyYY+WmV8lZ8NBF0GMAiyq20p5awNMrd4SFthT3vPvAK3ORtsBNgmmqMR6sL70ZPE3IVdkdzJotrZMzK/fiWhxyhOho1/Qixvm/nA=;
X-UUID: c46e1f77c5d0436a8f4f40209f91e052-20200115
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 231691014; Wed, 15 Jan 2020 22:00:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 21:59:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:01:09 +0800
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
Subject: [PATCH v8 3/8] dt-bindings: display: panel: add auo kd101n80-45na panel bindings
Date:   Wed, 15 Jan 2020 21:59:53 +0800
Message-ID: <20200115135958.126303-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115135958.126303-1-jitao.shi@mediatek.com>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A2D720D4539F99368B635022A3D053D9F5FEE61485ACDD382E23B679CE2305882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRvY3VtZW50YXRpb24gZm9yIGF1byBrZDEwMW44MC00NW5hIHBhbmVsLg0KDQpTaWduZWQt
b2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTog
U2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KLS0tDQogLi4uL2Rpc3BsYXkvcGFuZWwv
YXVvLGtkMTAxbjgwLTQ1bmEueWFtbCAgICAgIHwgNzQgKysrKysrKysrKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2F1byxrZDEwMW44MC00
NW5hLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3BhbmVsL2F1byxrZDEwMW44MC00NW5hLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9hdW8sa2QxMDFuODAtNDVuYS55YW1sDQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi42MDQ1NjY4MzIxNTYNCi0t
LSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L3BhbmVsL2F1byxrZDEwMW44MC00NW5hLnlhbWwNCkBAIC0wLDAgKzEsNzQgQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kaXNwbGF5L3BhbmVsL2F1byxrZDEwMW44MC00
NW5hLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9j
b3JlLnlhbWwjDQorDQordGl0bGU6IEFVTyBLRDEwMU44MC00NU5BIERTSSBEaXNwbGF5IFBhbmVs
DQorDQorbWFpbnRhaW5lcnM6DQorICAtIFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0Bn
bWFpbC5jb20+DQorICAtIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4NCisgIC0gUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcGFu
ZWwtY29tbW9uLnlhbWwjDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgICAg
ICBjb25zdDogYXVvLGtkMTAxbjgwLTQ1bmENCisNCisgIHJlZzoNCisgICAgZGVzY3JpcHRpb246
IHRoZSB2aXJ0dWFsIGNoYW5uZWwgbnVtYmVyIG9mIGEgRFNJIHBlcmlwaGVyYWwNCisNCisgIGVu
YWJsZS1ncGlvczoNCisgICAgZGVzY3JpcHRpb246IGEgR1BJTyBzcGVjIGZvciB0aGUgZW5hYmxl
IHBpbg0KKw0KKyAgcHAxODAwLXN1cHBseToNCisgICAgZGVzY3JpcHRpb246IGNvcmUgdm9sdGFn
ZSBzdXBwbHkNCisNCisgIGF2ZGQtc3VwcGx5Og0KKyAgICBkZXNjcmlwdGlvbjogcGhhbmRsZSBv
ZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgcG9zaXRpdmUgdm9sdGFnZQ0KKw0KKyAgYXZl
ZS1zdXBwbHk6DQorICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIG9mIHRoZSByZWd1bGF0b3IgdGhh
dCBwcm92aWRlcyBuZWdhdGl2ZSB2b2x0YWdlDQorDQorICBiYWNrbGlnaHQ6DQorICAgIGRlc2Ny
aXB0aW9uOiBwaGFuZGxlIG9mIHRoZSBiYWNrbGlnaHQgZGV2aWNlIGF0dGFjaGVkIHRvIHRoZSBw
YW5lbA0KKw0KKyAgcG9ydDogdHJ1ZQ0KKw0KK3JlcXVpcmVkOg0KKyAtIGNvbXBhdGlibGUNCisg
LSByZWcNCisgLSBlbmFibGUtZ3Bpb3MNCisgLSBwcDE4MDAtc3VwcGx5DQorIC0gYXZkZC1zdXBw
bHkNCisgLSBhdmVlLXN1cHBseQ0KKyAtIGJhY2tsaWdodA0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0
aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGRzaSB7DQorICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCisgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAg
ICAgcGFuZWxAMCB7DQorICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdW8sa2QxMDFuODAtNDVu
YSI7DQorICAgICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAgICAgIGVuYWJsZS1ncGlvcyA9
IDwmcGlvIDQ1IDA+Ow0KKyAgICAgICAgICAgIGF2ZGQtc3VwcGx5ID0gPCZwcHZhcm5fbGNkPjsN
CisgICAgICAgICAgICBhdmVlLXN1cHBseSA9IDwmcHB2YXJwX2xjZD47DQorICAgICAgICAgICAg
cHAxODAwLXN1cHBseSA9IDwmcHAxODAwX2xjZD47DQorICAgICAgICAgICAgYmFja2xpZ2h0ID0g
PCZiYWNrbGlnaHRfbGNkMD47DQorICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KKyAgICAg
ICAgICAgIHBvcnQgew0KKyAgICAgICAgICAgICAgICBwYW5lbF9pbjogZW5kcG9pbnQgew0KKyAg
ICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkc2lfb3V0PjsNCisgICAgICAg
ICAgICAgICAgfTsNCisgICAgICAgICAgICB9Ow0KKyAgICAgICAgfTsNCisgICAgfTsNCisNCisu
Li4NCi0tIA0KMi4yMS4wDQo=

