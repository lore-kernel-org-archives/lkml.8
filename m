Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABBC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289B020728
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IE5ay7qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgASBqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:46:11 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:52690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727083AbgASBqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:46:11 -0500
X-UUID: 4905bc116a8e49428639ffd5a510ec1d-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7j+j+0QNWPAP+UteC3TV/1LHHgPUUPGgH+f/Ixikhmo=;
        b=IE5ay7qQMYjICWlIs2GKCsiTarIMa7kgq5SL/EZ1xhSURbkYZO16YJOYGIEPMUM3rqmHNTa3QwC8flgMF7/zXqIMPEcwaM8eLqq4bV71a15A202nJSo3PBWvqUqAmTKPsXrkt7yCBozyeBFra1iy5PSwooiSJG8L261zroojCuM=;
X-UUID: 4905bc116a8e49428639ffd5a510ec1d-20200119
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 35788515; Sun, 19 Jan 2020 09:46:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 19 Jan
 2020 09:46:31 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 19 Jan 2020 09:44:53 +0800
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
Subject: [PATCH v10 1/5] dt-bindings: display: panel: Add boe tv101wum-n16 panel bindings
Date:   Sun, 19 Jan 2020 09:45:37 +0800
Message-ID: <20200119014541.64273-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200119014541.64273-1-jitao.shi@mediatek.com>
References: <20200119014541.64273-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F66AEB2A63B21D2EA129CD998EE4A8985F8592889CC4E10B38851A94BF5343272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRvY3VtZW50YXRpb24gZm9yICJib2UsdHYxMDF3dW0tbjE2IiwgImF1byxrZDEwMW44MC00
NW5hIiwNCiJib2UsdHYxMDF3dW0tbjUzIiBhbmQgImF1byxiMTAxdWFuMDguMyIgcGFuZWxzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQpSZXZp
ZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KUmV2aWV3ZWQtYnk6IFNh
bSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4NCi0tLQ0KIC4uLi9kaXNwbGF5L3BhbmVsL2Jv
ZSx0djEwMXd1bS1ubDYueWFtbCAgICAgICB8IDgwICsrKysrKysrKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2
LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYueWFtbA0KbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uNzQwMjEzNDU5MTM0DQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9w
YW5lbC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwNCkBAIC0wLDAgKzEsODAgQEANCisjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAx
LjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvcGFu
ZWwvYm9lLHR2MTAxd3VtLW5sNi55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBCT0UgVFYxMDFXVU0tTkw2IERT
SSBEaXNwbGF5IFBhbmVsDQorDQorbWFpbnRhaW5lcnM6DQorICAtIFRoaWVycnkgUmVkaW5nIDx0
aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+DQorICAtIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3Jn
Lm9yZz4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcGFuZWwtY29tbW9uLnlhbWwjDQorDQorcHJv
cGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQorICAgICAgICAjIEJPRSBUVjEw
MVdVTS1OTDYgMTAuMSIgV1VYR0EgVEZUIExDRCBwYW5lbA0KKyAgICAgIC0gYm9lLHR2MTAxd3Vt
LW5sNg0KKyAgICAgICAgIyBBVU8gS0QxMDFOODAtNDVOQSAxMC4xIiBXVVhHQSBURlQgTENEIHBh
bmVsDQorICAgICAgLSBhdW8sa2QxMDFuODAtNDVuYQ0KKyAgICAgICAgIyBCT0UgVFYxMDFXVU0t
TjUzIDEwLjEiIFdVWEdBIFRGVCBMQ0QgcGFuZWwNCisgICAgICAtIGJvZSx0djEwMXd1bS1uNTMN
CisgICAgICAgICMgQVVPIEIxMDFVQU4wOC4zIDEwLjEiIFdVWEdBIFRGVCBMQ0QgcGFuZWwNCisg
ICAgICAtIGF1byxiMTAxdWFuMDguMw0KKw0KKyAgcmVnOg0KKyAgICBkZXNjcmlwdGlvbjogdGhl
IHZpcnR1YWwgY2hhbm5lbCBudW1iZXIgb2YgYSBEU0kgcGVyaXBoZXJhbA0KKw0KKyAgZW5hYmxl
LWdwaW9zOg0KKyAgICBkZXNjcmlwdGlvbjogYSBHUElPIHNwZWMgZm9yIHRoZSBlbmFibGUgcGlu
DQorDQorICBwcDE4MDAtc3VwcGx5Og0KKyAgICBkZXNjcmlwdGlvbjogY29yZSB2b2x0YWdlIHN1
cHBseQ0KKw0KKyAgYXZkZC1zdXBwbHk6DQorICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIG9mIHRo
ZSByZWd1bGF0b3IgdGhhdCBwcm92aWRlcyBwb3NpdGl2ZSB2b2x0YWdlDQorDQorICBhdmVlLXN1
cHBseToNCisgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgdGhlIHJlZ3VsYXRvciB0aGF0IHBy
b3ZpZGVzIG5lZ2F0aXZlIHZvbHRhZ2UNCisNCisgIGJhY2tsaWdodDoNCisgICAgZGVzY3JpcHRp
b246IHBoYW5kbGUgb2YgdGhlIGJhY2tsaWdodCBkZXZpY2UgYXR0YWNoZWQgdG8gdGhlIHBhbmVs
DQorDQorICBwb3J0OiB0cnVlDQorDQorcmVxdWlyZWQ6DQorIC0gY29tcGF0aWJsZQ0KKyAtIHJl
Zw0KKyAtIGVuYWJsZS1ncGlvcw0KKyAtIHBwMTgwMC1zdXBwbHkNCisgLSBhdmRkLXN1cHBseQ0K
KyAtIGF2ZWUtc3VwcGx5DQorDQorYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhh
bXBsZXM6DQorICAtIHwNCisgICAgZHNpIHsNCisgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorICAgICAgICBwYW5lbEAwIHsNCisgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImJvZSx0djEwMXd1bS1ubDYiOw0KKyAgICAgICAgICAgIHJl
ZyA9IDwwPjsNCisgICAgICAgICAgICBlbmFibGUtZ3Bpb3MgPSA8JnBpbyA0NSAwPjsNCisgICAg
ICAgICAgICBhdmRkLXN1cHBseSA9IDwmcHB2YXJuX2xjZD47DQorICAgICAgICAgICAgYXZlZS1z
dXBwbHkgPSA8JnBwdmFycF9sY2Q+Ow0KKyAgICAgICAgICAgIHBwMTgwMC1zdXBwbHkgPSA8JnBw
MTgwMF9sY2Q+Ow0KKyAgICAgICAgICAgIGJhY2tsaWdodCA9IDwmYmFja2xpZ2h0X2xjZDA+Ow0K
KyAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCisgICAgICAgICAgICBwb3J0IHsNCisgICAg
ICAgICAgICAgICAgcGFuZWxfaW46IGVuZHBvaW50IHsNCisgICAgICAgICAgICAgICAgICAgIHJl
bW90ZS1lbmRwb2ludCA9IDwmZHNpX291dD47DQorICAgICAgICAgICAgICAgIH07DQorICAgICAg
ICAgICAgfTsNCisgICAgICAgIH07DQorICAgIH07DQorDQorLi4uDQotLSANCjIuMjEuMA0K

