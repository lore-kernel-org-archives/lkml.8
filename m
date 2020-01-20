Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D104C33CB8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61932073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EfToTjlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATHrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:47:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55258 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726282AbgATHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:47:52 -0500
X-UUID: 745ca5bc67894f159492b86acb07c8b8-20200120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tl5MhNylOi+W3/i1SxKQyFpCuTnUM6aZ6NWfQC1HAHU=;
        b=EfToTjlRYc1taNoTowGg/FKe4t7ZIlGo8Ifd0HFYtA3DS/naChXIDj3fGCHWmqAn4lQD0PYP8ClcMXo/EnhV/R5iByscsyzbL3QQMPfsN+SAxX578a/ZiEwEJijL+mxoC0UKDoEhJNdcpulrR9qWRRmks4+qyRp+HhgKUobGEWY=;
X-UUID: 745ca5bc67894f159492b86acb07c8b8-20200120
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 798885896; Mon, 20 Jan 2020 15:47:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 Jan 2020 15:47:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 Jan 2020 15:48:39 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [RESEND 1/4] dt-bindings: regulator: Add document for MT6359 regulator
Date:   Mon, 20 Jan 2020 15:47:27 +0800
Message-ID: <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2VuIFN1IDx3ZW4uc3VAbWVkaWF0ZWsuY29tPg0KDQphZGQgZHQtYmluZGluZyBkb2N1
bWVudCBmb3IgTWVkaWFUZWsgTVQ2MzU5IFBNSUMNCg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBXZW4gU3UgPHdlbi5zdUBtZWRpYXRl
ay5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0
ICAgICAgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNTkg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0DQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1
bGF0b3IudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9t
dDYzNTktcmVndWxhdG9yLnR4dA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAu
LjY0NWNlYjYNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci50eHQNCkBAIC0wLDAgKzEsNTkgQEAN
CitNZWRpYXRlayBNVDYzNTkgUmVndWxhdG9yDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCist
IGNvbXBhdGlibGU6ICJtZWRpYXRlayxtdDYzNTktcmVndWxhdG9yIg0KKy0gbXQ2MzU5cmVndWxh
dG9yOiBMaXN0IG9mIHJlZ3VsYXRvcnMgcHJvdmlkZWQgYnkgdGhpcyBjb250cm9sbGVyLiBJdCBp
cyBuYW1lZA0KKyAgYWNjb3JkaW5nIHRvIGl0cyByZWd1bGF0b3IgdHlwZSwgYnVja188bmFtZT4g
YW5kIGxkb188bmFtZT4uDQorICBUaGUgZGVmaW5pdGlvbiBmb3IgZWFjaCBvZiB0aGVzZSBub2Rl
cyBpcyBkZWZpbmVkIHVzaW5nIHRoZSBzdGFuZGFyZCBiaW5kaW5nDQorICBmb3IgcmVndWxhdG9y
cyBhdCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JlZ3VsYXRv
ci50eHQuDQorDQorVGhlIHZhbGlkIG5hbWVzIGZvciByZWd1bGF0b3JzIGFyZTo6DQorQlVDSzoN
CisgIGJ1Y2tfdnMxLCBidWNrX3ZncHUxMSwgYnVja192bW9kZW0sIGJ1Y2tfdnB1LCBidWNrX3Zj
b3JlLCBidWNrX3ZzMiwNCisgIGJ1Y2tfdnBhLCBidWNrX3Zwcm9jMiwgYnVja192cHJvYzEsIGJ1
Y2tfdmNvcmVfc3NodWINCitMRE86DQorICBsZG9fdmF1ZDE4LCBsZG9fdnNpbTEsIGxkb192aWJy
LCBsZG9fdnJmMTIsIGxkb192dXNiLCBsZG9fdnNyYW1fcHJvYzIsDQorICBsZG9fdmlvMTgsIGxk
b192Y2FtaW8sIGxkb192Y24xOCwgbGRvX3ZmZTI4LCBsZG9fdmNuMTMsIGxkb192Y24zM18xX2J0
LA0KKyAgbGRvX3ZjbjEzXzFfd2lmaSwgbGRvX3ZhdXgxOCwgbGRvX3ZzcmFtX290aGVycywgbGRv
X3ZlZnVzZSwgbGRvX3Z4bzIyLA0KKyAgbGRvX3ZyZmNrLCBsZG9fdmJpZjI4LCBsZG9fdmlvMjgs
IGxkb192ZW1jLCBsZG9fdmNuMzNfMl9idCwgbGRvX3ZjbjMzXzJfd2lmaSwNCisgIGxkb192YTEy
LCBsZG9fdmEwOSwgbGRvX3ZyZjE4LCBsZG9fdnNyYW1fbWQsIGxkb192dWZzLCBsZG9fdm0xOCwg
bGRvX3ZiYmNrLA0KKyAgbGRvX3ZzcmFtX3Byb2MxLCBsZG9fdnNpbTIsIGxkb192c3JhbV9vdGhl
cnNfc3NodWINCisNCitFeGFtcGxlOg0KKwlwbWljIHsNCisJCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ2MzU5IjsNCisNCisJCW10NjM1OXJlZ3VsYXRvcjogbXQ2MzU5cmVndWxhdG9yIHsNCisJ
CQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM1OS1yZWd1bGF0b3IiOw0KKw0KKwkJCW10NjM1
OV92czFfYnVja19yZWc6IGJ1Y2tfdnMxIHsNCisJCQkJcmVndWxhdG9yLW5hbWUgPSAidnMxIjsN
CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsNCisJCQkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MjIwMDAwMD47DQorCQkJCXJlZ3VsYXRvci1lbmFibGUtcmFtcC1k
ZWxheSA9IDwwPjsNCisJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCisJCQl9Ow0KKwkJCW10NjM1
OV92Z3B1MTFfYnVja19yZWc6IGJ1Y2tfdmdwdTExIHsNCisJCQkJcmVndWxhdG9yLW5hbWUgPSAi
dmdwdTExIjsNCisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NDAwMDAwPjsNCisJCQkJ
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTE5Mzc1MD47DQorCQkJCXJlZ3VsYXRvci1lbmFi
bGUtcmFtcC1kZWxheSA9IDwyMDA+Ow0KKwkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KKwkJCQly
ZWd1bGF0b3ItYWxsb3dlZC1tb2RlcyA9IDwwIDEgMj47DQorCQkJfTsNCisJCQltdDYzNTlfdmF1
ZDE4X2xkb19yZWc6IGxkb192YXVkMTggew0KKwkJCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1m
aXhlZCI7DQorCQkJCXJlZ3VsYXRvci1uYW1lID0gInZhdWQxOCI7DQorCQkJCXJlZ3VsYXRvci1t
aW4tbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwxODAwMDAwPjsNCisJCQkJcmVndWxhdG9yLWVuYWJsZS1yYW1wLWRlbGF5ID0gPDI0MD47DQor
CQkJfTsNCisJCQltdDYzNTlfdnNpbTFfbGRvX3JlZzogbGRvX3ZzaW0xIHsNCisJCQkJcmVndWxh
dG9yLW5hbWUgPSAidnNpbTEiOw0KKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxNzAw
MDAwPjsNCisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzEwMDAwMD47DQorCQkJCXJl
Z3VsYXRvci1lbmFibGUtcmFtcC1kZWxheSA9IDw0ODA+Ow0KKwkJCX07DQorCQl9Ow0KKwl9Ow0K
Kw0KLS0gDQoxLjkuMQ0K

