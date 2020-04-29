Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB82DC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61832083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u+zjBT2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2IWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:22:16 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:53718 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgD2IWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:22:16 -0400
X-UUID: aaa594bd0ac242349741668533278a2d-20200429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r4K60kEa5lDUBAjKHGyVAAwYSSOBqLBYXC0FPkYxuWs=;
        b=u+zjBT2gDg4kOTHPSLgpivt6A6G2L9ndSdOFaHuZOse0m/AqaRxRRVyTyZ9COfO0DSNceQfJh90gH7wCfT124diuffFP+x+leGrN7rz/MG8wQEGiuGPfdx0796a5DAeomXMVuLOGP7NopOUua/Z89WhROkDVeC4RoLZVD4C1Ejc=;
X-UUID: aaa594bd0ac242349741668533278a2d-20200429
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <xing.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1511418025; Wed, 29 Apr 2020 16:22:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS32N2.mediatek.inc (172.27.4.72) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Apr 2020 16:22:08 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Apr 2020 16:22:05 +0800
From:   Xing Zhang <Xing.Zhang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Xing Zhang <xing.zhang@mediatek.com>
Subject: [PATCH v1 1/3] dt-bindings: add regulator vibrator documentation
Date:   Wed, 29 Apr 2020 16:17:58 +0800
Message-ID: <20200429081759.26964-2-Xing.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
References: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8AB1F68EA9DBB4C5B88D4232D26893644D6F4DC19E22479C1F1DDDA0E67AF1BF2000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWGluZyBaaGFuZyA8eGluZy56aGFuZ0BtZWRpYXRlay5jb20+DQoNCkFkZCB0aGUgRFQg
YmluZGluZyBkb2N1bWVudGF0aW9uIGZvciByZWd1bGF0b3IgdmlicmF0b3INCg0KQ2hhbmdlLUlk
OiBJNmEyMzUwYjFiYWM0NmNmOTBkNjEyMmM2ZGU2Y2ZlY2RkYjY5NjkyOA0KU2lnbmVkLW9mZi1i
eTogWGluZyBaaGFuZyA8eGluZy56aGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vYmluZGlu
Z3MvbGVkcy9yZWd1bGF0b3ItdmlicmF0b3IudHh0ICAgICAgfCAzOSArKysrKysrKysrKysrKysr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xlZHMvcmVndWxhdG9yLXZpYnJh
dG9yLnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2xlZHMvcmVndWxhdG9yLXZpYnJhdG9yLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9sZWRzL3JlZ3VsYXRvci12aWJyYXRvci50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQppbmRleCAwMDAwMDAwMDAwMDAuLjhmNDVkM2VkMTNiZA0KLS0tIC9kZXYvbnVsbA0KKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2xlZHMvcmVndWxhdG9yLXZpYnJhdG9y
LnR4dA0KQEAgLTAsMCArMSwzOSBAQA0KKyogUmVndWxhdG9yIHZpYnJhdG9yIGRldmljZSB0cmVl
IGJpbmRpbmdzDQorDQorUmVxdWlyZWQgUHJvcGVydGllczoNCisgLSBjb21wYXRpYmxlIDogU2hv
dWxkIGJlICJyZWd1bGF0b3ItdmlicmF0b3IiDQorIC0gdmlici1zdXBwbHkgOiBQb3dlciBzdXBw
bHkgdG8gdGhlIHZpYnJhdG9yLg0KKwlbKl0gcmVmZXIgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3JlZ3VsYXRvci9yZWd1bGF0b3IudHh0DQorDQorIC0gbWF4LXZvbHQgOiBUaGUg
bWF4aW11bSB2b2x0YWdlIHZhbHVlIHN1cHBsaWVkIHRvIHRoZSB2aWJyYXRvciByZWd1bGF0b3Iu
DQorCQlbVGhlIHVuaXQgb2YgdGhlIHZvbHRhZ2UgaXMgYSBtaWNyb10NCisNCisgLSBtaW4tdm9s
dCA6IFRoZSBtaW5pbXVtIHZvbHRhZ2UgdmFsdWUgc3VwcGxpZWQgdG8gdGhlIHZpYnJhdG9yIHJl
Z3VsYXRvci4NCisJCVtUaGUgdW5pdCBvZiB0aGUgdm9sdGFnZSBpcyBhIG1pY3JvXQ0KKw0KK09w
dGlvbmFsIHByb3BlcnRpZXM6DQorIC0gbWluLWxpbWl0IDogU2V0IHRoZSBtaW5pbXVtIHRpbWUg
aW4gbXMgZm9yIHZpYnJhdG9yICwgZGVmYXVsdCBpcyAxNW1zLA0KKwkJaWYgdXNlciByZXF1ZXN0
IGR1cmF0aW9uIGlzIHNtYWxsZXIsIHRoaXMgdmFsdWUgd2lsbCBiZSB1c2VkIGluc3RlYWQuDQor
CQl0aGUgZGVmYXVsdCB2YWx1ZSBjb21lcyBmcm9tIHRoZSBzbWFsbGVzdCB1bml0IHRoYXQgY2Fu
IGJlIHNlbnNlZC4NCisNCisgLSBtYXgtbGltaXQgOiBTZXQgdGhlIG1heGltdW0gdGltZSBpbiBt
cyBmb3IgdmlicmF0b3IuDQorCQlpZiBub3Qgc2V0LCBpdCBtZWFucyBubyBtYXggbGltaXRhdGlv
bi4NCisNCitFeGFtcGxlOg0KKw0KKwltdDYzNTlfdmlicl9sZG9fcmVnOiBsZG9fdmliciB7DQor
CQlyZWd1bGF0b3ItbmFtZSA9ICJ2aWJyIjsNCisJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0g
PDEyMDAwMDA+Ow0KKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQorCQly
ZWd1bGF0b3ItZW5hYmxlLXJhbXAtZGVsYXkgPSA8MjQwPjsNCisJfTsNCisNCisJcmVndWxhdG9y
X3ZpYnJhdG9yIHsNCisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLXZpYnJhdG9yIjsNCisJCW1p
bi12b2x0ID0gPDIzMDAwMDA+Ow0KKwkJbWF4LXZvbHQgPSA8MzIwMDAwMD47DQorCQltYXgtbGlt
aXQgPSA8MTUwMDA+Ow0KKwkJbWluLWxpbWl0ID0gPDE1PjsNCisJCXZpYi1zdXBwbHkgPSA8Jm10
NjM1OV92aWJyX2xkb19yZWc+Ow0KKwl9Ow0KKw0KLS0gDQoyLjE4LjANCg==

