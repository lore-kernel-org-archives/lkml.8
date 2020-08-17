Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D4CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6669220658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YVJsx2Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgHQCuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:50:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46429 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgHQCuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:17 -0400
X-UUID: 123f6e4c5eaa4592bfa01aface8a5e91-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nXcU1Hc02thK0kndiWW9wjNDJvWYN5PNOdsuyKQXNMw=;
        b=YVJsx2MkcK/1OskF3r85MZd+NidokJyZh5apF5CZHL2nHJdPbSQ3EiUpRCdCgO/j4IZmtXd7e9PkgWaMZaRPnqBL5OLgQMLFdIcWT5zboE33h4aJry6miniFuv/TD0ceJkyR8MPg2cjlOXDvS24S3dX40s+1V3Zhzf3LEMOZCW0=;
X-UUID: 123f6e4c5eaa4592bfa01aface8a5e91-20200817
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1442053350; Mon, 17 Aug 2020 10:50:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 10:50:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 10:50:08 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>
Subject: [v3,0/6] introduce TI reset controller for MT8192 SoC
Date:   Mon, 17 Aug 2020 10:48:38 +0800
Message-ID: <20200817024842.5289-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djM6DQoxLiByZXZlcnQgdjIgY2hhbmdlcy4NCjIuIGFkZCAncmVzZXQtZHVyYXRpb24tdXMnIHBy
b3BlcnR5IHRvIGRlY2xhcmUgYSBtaW5pbXVtIGRlbGF5LA0Kd2hpY2ggbmVlZHMgdG8gYmUgd2Fp
dGVkIGJldHdlZW4gYXNzZXJ0IGFuZCBkZWFzc2VydC4NCjMuIGFkZCAnbWVkaWF0ZWssaW5mcmEt
cmVzZXQnIHRvIGNvbXBhdGlibGUuDQoNCnYyIGNoYW5nZXM6DQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3BhdGNoLzExNjk3MzcxLw0KMS4gYWRkICdhc3NlcnQtZGVhc3NlcnQtdG9nZXRo
ZXInIHByb3BlcnR5IHRvIGludHJvZHVjZSBhIG5ldyByZXNldCBoYW5kbGVyLA0Kd2hpY2ggYWxs
b3dzIGRldmljZSB0byBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0aW9u
cyBpbiBhIHNpbmdsZQ0Kc3RlcCBieSAncmVzZXQnIG1ldGhvZC4NCjIuIGFkZCAndXBkYXRlLWZv
cmNlJyBwcm9wZXJ0eSB0byBpbnRyb2R1Y2UgZm9yY2UtdXBkYXRlIG1ldGhvZCwgd2hpY2ggZm9y
Y2VzDQp0aGUgd3JpdGUgb3BlcmF0aW9uIGluIGNhc2UgdGhlIHJlYWQgYWxyZWFkeSBoYXBwZW5z
IHRvIHJldHVybiB0aGUgY29ycmVjdCB2YWx1ZS4NCjMuIGFkZCAnZ2VuZXJpYy1yZXNldCcgdG8g
Y29tcGF0aWJsZQ0KDQp2MSBjaGFuZ2VzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xMTY5MDUyMy8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE2OTA1
MjcvDQoNCkNyeXN0YWwgR3VvICg0KToNCiAgZHQtYmluZGluZzogcmVzZXQtY29udHJvbGxlcjog
dGk6IGFkZCByZXNldC1kdXJhdGlvbi11cyBwcm9wZXJ0eQ0KICBkdC1iaW5kaW5nOiByZXNldC1j
b250cm9sbGVyOiB0aTogYWRkICdtZWRpYXRlayxpbmZyYS1yZXNldCcgdG8NCiAgICBjb21wYXRp
YmxlDQogIHJlc2V0LWNvbnRyb2xsZXI6IHRpOiBpbnRyb2R1Y2UgYSBuZXcgcmVzZXQgaGFuZGxl
cg0KICBhcm02NDogZHRzOiBtdDgxOTI6IGFkZCBpbmZyYWNmZ19yc3Qgbm9kZQ0KDQogLi4uL2Jp
bmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgICAgICAgIHwgIDYgKysrKysNCiBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpICAgICAgfCAxMSArKysrKysrLQ0K
IGRyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgICAgICAgICAgICAgICB8IDI2ICsrKysr
KysrKysrKysrKysrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQoNCg==

