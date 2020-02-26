Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8534C4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1B824653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Iw3TNNK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBZFdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:33:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:37566 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbgBZFdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:33:19 -0500
X-UUID: e2637b430b3a41c08b60d9d4f2b3468b-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nRQYTzjhi5VJ+yL5RODrtCz2oct9vvHn8xRcEXxeiS8=;
        b=Iw3TNNK6/EhCeuDDGA3pj2EwUSf89esSfhPq6VzY5XURqBJY/M0hz1xPL8iGM8poq27aDQXtir/QDgetd3SxtBC9QYnzf72v7Ia+Z6BEb3QQRnZU+zBZMclajIZwHmw2K2SUp3QvHM9+jAW6s+mx9GZY6yTLrFqbgCG96b19lfo=;
X-UUID: e2637b430b3a41c08b60d9d4f2b3468b-20200226
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 139375375; Wed, 26 Feb 2020 13:32:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Feb
 2020 13:28:49 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Feb 2020 13:31:24 +0800
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
Subject: [PATCH v9 2/5] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Wed, 26 Feb 2020 13:32:35 +0800
Message-ID: <20200226053238.31646-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226053238.31646-1-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E03227202C9ABAD3B01A62D4F80E6575F83DBB92742E34792497078C91941B972000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwaW5jdHJsLW5hbWVzIiB0byBzd2FwIHBpbiBtb2RlIGJldHdlZW4gZ3Bp
byBhbmQgZHBpIG1vZGUuIFNldA0KcGluIG1vZGUgdG8gZ3BpbyBvdXBwdXQtbG93IHRvIGF2b2lk
IGxlYWthZ2UgY3VycmVudCB3aGVuIGRwaSBkaXNhYmxlLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hp
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KaW5k
ZXggNTg5MTRjZjY4MWI4Li5hN2IxYjhiZmI2NWUgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkcGkudHh0DQpAQCAtMTcsNiArMTcsMTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
CiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9y
dCBzaG91bGQgYmUgY29ubmVjdGVkDQogICB0byB0aGUgaW5wdXQgcG9ydCBvZiBhbiBhdHRhY2hl
ZCBIRE1JIG9yIExWRFMgZW5jb2RlciBjaGlwLg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQor
LSBwaW5jdHJsLW5hbWVzOiBDb250YWluICJncGlvbW9kZSIgYW5kICJkcGltb2RlIi4NCisgIHBp
bmN0cmwtbmFtZXMgc2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJs
cGluY3RybC1iaW5kaW5ncy50eHQNCisNCiBFeGFtcGxlOg0KIA0KIGRwaTA6IGRwaUAxNDAxZDAw
MCB7DQpAQCAtMjcsNiArMzEsOSBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KIAkJIDwmbW1zeXMg
Q0xLX01NX0RQSV9FTkdJTkU+LA0KIAkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+
Ow0KIAljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCisJcGluY3RybC1u
YW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIjsNCisJcGluY3RybC0wID0gPCZkcGlfcGluX2dw
aW8+Ow0KKwlwaW5jdHJsLTEgPSA8JmRwaV9waW5fZnVuYz47DQogDQogCXBvcnQgew0KIAkJZHBp
MF9vdXQ6IGVuZHBvaW50IHsNCi0tIA0KMi4yMS4wDQo=

