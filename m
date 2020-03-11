Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC444C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D51208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R/C//83y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgCKHTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:19:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13370 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728245AbgCKHTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:19:11 -0400
X-UUID: e6aee5488f88488db736545ec069e8b3-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8nLyZVk/PhYmrdzTV342CZJrfyCY+3YyqtqMqJ7V3+0=;
        b=R/C//83yzgMDVRQmfq9ukHdSmyOj2yrBax+4BZswesSaaPy/qByw0sqGgDtQWI0zYzo/fikoHmH0+1PvAtkHsQCMJFANx2TgzzVvK5vEz7LsnoULqfhNO7c4wEj5Y9sD/WmsAT/0Av7od87xK8BOR5xxu7hYLYF+4Ozixz/8h8k=;
X-UUID: e6aee5488f88488db736545ec069e8b3-20200311
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1430431296; Wed, 11 Mar 2020 15:18:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:19:01 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:18:05 +0800
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
Subject: [PATCH v13 0/6] mt8183 dpi supports dual edge and pin mode swap
Date:   Wed, 11 Mar 2020 15:18:17 +0800
Message-ID: <20200311071823.117899-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C7E631F0024CEF11B8147BAD69898DD502D82A9C849D73040D0A592C700B9AD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MTI6DQogLSBmaXggbWVkaWF0ZWssZHBpLnlhbWwgbWFrZV9kdF9iaW5k
aW5nX2NoZWNrIGVycm9ycy4NCg0KQ2hhbmdlIHNpbmNlIHYxMToNCiAtIGZpbmUgdHVuZSBtZWRp
YXRlayxkcGkueWFtbC4NCiAtIGFkZCBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4uDQoNCkNoYW5nZSBzaW5jZSB2MTA6DQogLSBjb252ZXJ0IHRoZSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQog
ICB0byB5YW1sIGZvcm1hdC4NCiAtIHJlYWQgdGhlIHBjbGstc2FtcGxlIGluIGVuZHBvaW50Lg0K
DQpDaGFuZ2VzIHNpbmNlIHY5Og0KIC0gcmVuYW1lIHBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUi
LCAiZHBpbW9kZSIgdG8gImFjdGl2ZSIsICJpZGxlIi4NCiAtIGZpeCBzb21lIHR5cG8uDQoNCkNo
YW5nZXMgc2luY2Ugdjg6DQogLSBkcm9wIHBjbGstc2FtcGxlIHJlZGVmaW5lIGluIG1lZGlhdGVr
LGRwaS50eHQNCiAtIG9ubHkgZ2V0IHRoZSBncGlvbW9kZSBhbmQgZHBpbW9kZSB3aGVuIGRwaS0+
cGluY3RybCBpcyBzdWNjZXNzZnVsLg0KDQpDaGFuZ2VzIHNpbmNlIHY3Og0KIC0gc2VwYXJhdGUg
ZHQtYmluZGluZ3MgdG8gaW5kZXBlbmRlbnQgcGF0Y2hlcy4NCiAtIG1vdmUgZHBpIGR1YWwgZWRn
ZSB0byBvbmUgcGF0Y2guDQoNCkNoYW5nZXMgc2luY2UgdjY6DQogLSBjaGFuZ2UgZHVhbF9lZGdl
IHRvIHBjbGstc2FtcGxlDQogLSByZW1vdmUgZHBpX3Bpbl9tb2RlX3N3YXAgYW5kDQoNCkNoYW5n
ZXMgc2luY2UgdjU6DQogLSBmaW5lIHR1bmUgdGhlIGR0LWJpbmRpbmdzIGNvbW1pdCBtZXNzYWdl
Lg0KDQpDaGFuZ2VzIHNpbmNlIHY0Og0KIC0gbW92ZSBwaW4gbW9kZSBjb250cm9sIGFuZCBkdWFs
IGVkZ2UgY29udHJvbCB0byBkZXZlaWNlIHRyZWUuDQogLSB1cGRhdGUgZHQtYmluZGluZ3MgZG9j
dW1lbnQgZm9yIHBpbiBtb2RlIHN3YXAgYW5kIGR1YWwgZWRnZSBjb250cm9sLg0KDQpDaGFuZ2Vz
IHNpbmNlIHYzOg0KIC0gYWRkIGRwaSBwaW4gbW9kZSBjb250cm9sIHdoZW4gZHBpIG9uIG9yIG9m
Zi4NCiAtIHVwZGF0ZSBkcGkgZHVhbCBlZGdlIGNvbW1lbnQuDQoNCkNoYW5nZXMgc2luY2UgdjI6
DQogLSB1cGRhdGUgZHQtYmluZGluZ3MgZG9jdW1lbnQgZm9yIG10ODE4MyBkcGkuDQogLSBzZXBh
cmF0ZSBkdWFsIGVkZ2UgbW9kZmljYXRpb24gYXMgaW5kZXBlbmRlbnQgcGF0Y2guDQoNCkppdGFv
IFNoaSAoNik6DQogIGR0LWJpbmRpbmdzOiBtZWRpYTogYWRkIHBjbGstc2FtcGxlIGR1YWwgZWRn
ZSBwcm9wZXJ0eQ0KICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGNvbnRyb2wgZHBp
IHBpbnMgbW9kZSB0byBhdm9pZCBsZWFrYWdlDQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRp
YXRlazogZHBpIHNhbXBsZSBkYXRhIGluIGR1YWwgZWRnZSBzdXBwb3J0DQogIGR0LWJpbmRpbmdz
OiBkaXNwbGF5OiBtZWRpYXRlazogY29udmVydCB0aGUgZG9jdW1lbnQgZm9ybWF0IGZyb20gdHh0
DQogICAgdG8geWFtbA0KICBkcm0vbWVkaWF0ZWs6IGRwaSBzYW1wbGUgbW9kZSBzdXBwb3J0DQog
IGRybS9tZWRpYXRlazogc2V0IGRwaSBwaW4gbW9kZSB0byBncGlvIGxvdyB0byBhdm9pZCBsZWFr
YWdlIGN1cnJlbnQNCg0KIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAg
ICAgICB8ICAzNiAtLS0tLS0NCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFt
bCAgICAgICAgfCAxMDMgKysrKysrKysrKysrKysrKysrDQogLi4uL2JpbmRpbmdzL21lZGlhL3Zp
ZGVvLWludGVyZmFjZXMudHh0ICAgICAgIHwgICA0ICstDQogZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcGkuYyAgICAgICAgICAgIHwgIDU4ICsrKysrKysrKy0NCiA0IGZpbGVzIGNoYW5n
ZWQsIDE2MSBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KDQotLSANCjIu
MjEuMA0K

