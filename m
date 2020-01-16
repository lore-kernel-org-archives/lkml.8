Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98870C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA922081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N49eJHkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgAPCPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:15:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8509 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729598AbgAPCPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:15:25 -0500
X-UUID: 70ca07e0f4a1444d87b7ba2b4fd7f026-20200116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F462LuZJcy34TtYCZva80mss9EgKryG7r/I9+ALwST4=;
        b=N49eJHkk530AC6bCBoUfE50iMj1gk6izH0E+xit/8mx+DgYjyiqfTx6Y4eEUfTPHwc8PtsvC5Ao1Lr6r4j3xLpP1J0H86kR8kHYNGyiCzmzRFyLfdXfq2K93hW2p3a16a8XLG4S5Y2W2W1oKRssZuwe0EN+55J4wfp3YksbA4z0=;
X-UUID: 70ca07e0f4a1444d87b7ba2b4fd7f026-20200116
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 533027303; Thu, 16 Jan 2020 10:15:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 16 Jan
 2020 10:12:01 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 16 Jan 2020 10:14:23 +0800
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
Subject: [PATCH v9 1/5] dt-bindings: display: panel: Add boe tv101wum-n16 panel bindings
Date:   Thu, 16 Jan 2020 10:15:07 +0800
Message-ID: <20200116021511.22675-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200116021511.22675-1-jitao.shi@mediatek.com>
References: <20200116021511.22675-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 21036B83BB708D1CF0E3FC3487B37E48F2C220B640ABD57B0284D2C68176BDB82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRvY3VtZW50YXRpb24gZm9yICJib2UsdHYxMDF3dW0tbjE2IiwgImF1byxrZDEwMW44MC00
NW5hIiwNCiJib2UsdHYxMDF3dW0tbjUzIiBhbmQgImF1byxiMTAxdWFuMDguMyIgcGFuZWxzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQpSZXZp
ZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KLS0tDQogLi4uL2Rpc3Bs
YXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5sNi55YW1sICAgICAgIHwgODEgKysrKysrKysrKysrKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2JvZSx0
djEwMXd1bS1ubDYueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5sNi55YW1sIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5sNi55
YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5jYzRlMDU4ZjVl
ZWUNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYueWFtbA0KQEAgLTAsMCArMSw4MSBAQA0K
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMv
ZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IEJPRSBUVjEw
MVdVTS1OTDYgRFNJIERpc3BsYXkgUGFuZWwNCisNCittYWludGFpbmVyczoNCisgIC0gVGhpZXJy
eSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCisgIC0gU2FtIFJhdm5ib3JnIDxz
YW1AcmF2bmJvcmcub3JnPg0KKyAgLSBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0K
Kw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwYW5lbC1jb21tb24ueWFtbCMNCisNCitwcm9wZXJ0aWVz
Og0KKyAgY29tcGF0aWJsZToNCisgICAgZW51bToNCisgICAgICAgICMgQk9FIFRWMTAxV1VNLU5M
NiAxMC4xIiBXVVhHQSBURlQgTENEIHBhbmVsDQorICAgICAgLSBib2UsdHYxMDF3dW0tbmw2DQor
ICAgICAgICAjIEFVTyBLRDEwMU44MC00NU5BIDEwLjEiIFdVWEdBIFRGVCBMQ0QgcGFuZWwNCisg
ICAgICAtIGF1byxrZDEwMW44MC00NW5hDQorICAgICAgICAjIEJPRSBUVjEwMVdVTS1ONTMgMTAu
MSIgV1VYR0EgVEZUIExDRCBwYW5lbA0KKyAgICAgIC0gYm9lLHR2MTAxd3VtLW41Mw0KKyAgICAg
ICAgIyBBVU8gQjEwMVVBTjA4LjMgMTAuMSIgV1VYR0EgVEZUIExDRCBwYW5lbA0KKyAgICAgIC0g
YXVvLGIxMDF1YW4wOC4zDQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiB0aGUgdmlydHVh
bCBjaGFubmVsIG51bWJlciBvZiBhIERTSSBwZXJpcGhlcmFsDQorDQorICBlbmFibGUtZ3Bpb3M6
DQorICAgIGRlc2NyaXB0aW9uOiBhIEdQSU8gc3BlYyBmb3IgdGhlIGVuYWJsZSBwaW4NCisNCisg
IHBwMTgwMC1zdXBwbHk6DQorICAgIGRlc2NyaXB0aW9uOiBjb3JlIHZvbHRhZ2Ugc3VwcGx5DQor
DQorICBhdmRkLXN1cHBseToNCisgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgdGhlIHJlZ3Vs
YXRvciB0aGF0IHByb3ZpZGVzIHBvc2l0aXZlIHZvbHRhZ2UNCisNCisgIGF2ZWUtc3VwcGx5Og0K
KyAgICBkZXNjcmlwdGlvbjogcGhhbmRsZSBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMg
bmVnYXRpdmUgdm9sdGFnZQ0KKw0KKyAgYmFja2xpZ2h0Og0KKyAgICBkZXNjcmlwdGlvbjogcGhh
bmRsZSBvZiB0aGUgYmFja2xpZ2h0IGRldmljZSBhdHRhY2hlZCB0byB0aGUgcGFuZWwNCisNCisg
IHBvcnQ6IHRydWUNCisNCityZXF1aXJlZDoNCisgLSBjb21wYXRpYmxlDQorIC0gcmVnDQorIC0g
ZW5hYmxlLWdwaW9zDQorIC0gcHAxODAwLXN1cHBseQ0KKyAtIGF2ZGQtc3VwcGx5DQorIC0gYXZl
ZS1zdXBwbHkNCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoN
CisgIC0gfA0KKyAgICBkc2kgew0KKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisgICAgICAgIHBhbmVsQDAgew0KKyAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAiYm9lLHR2MTAxd3VtLW5sNiI7DQorICAgICAgICAgICAgcmVnID0gPDA+
Ow0KKyAgICAgICAgICAgIGVuYWJsZS1ncGlvcyA9IDwmcGlvIDQ1IDA+Ow0KKyAgICAgICAgICAg
IGF2ZGQtc3VwcGx5ID0gPCZwcHZhcm5fbGNkPjsNCisgICAgICAgICAgICBhdmVlLXN1cHBseSA9
IDwmcHB2YXJwX2xjZD47DQorICAgICAgICAgICAgcHAxODAwLXN1cHBseSA9IDwmcHAxODAwX2xj
ZD47DQorICAgICAgICAgICAgYmFja2xpZ2h0ID0gPCZiYWNrbGlnaHRfbGNkMD47DQorICAgICAg
ICAgICAgc3RhdHVzID0gIm9rYXkiOw0KKyAgICAgICAgICAgIHBvcnQgew0KKyAgICAgICAgICAg
ICAgICBwYW5lbF9pbjogZW5kcG9pbnQgew0KKyAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVu
ZHBvaW50ID0gPCZkc2lfb3V0PjsNCisgICAgICAgICAgICAgICAgfTsNCisgICAgICAgICAgICB9
Ow0KKyAgICAgICAgfTsNCisgICAgfTsNCisNCisuLi4NCi0tIA0KMi4yMS4wDQo=

