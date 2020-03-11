Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E25C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE0021D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IMTp8gc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgCKHlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:41:08 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18327 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgCKHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:07 -0400
X-UUID: 769b7011e41e4c89b8b4c4ba5257be87-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LkxTQ6EkbNDavsaknDTmCujK6P6DkEqHOkdqLklErpk=;
        b=IMTp8gc4JdjYowh4XonGi1wqO7V2sF2CqlOdBQDVULX0o+sh7jPnzTigiIuJ3aJ6BHW/L7MhwDplLFq96QoEmBwIUM4oO5/WJB+YYliE0o5bHpSeeOSILZJZOGlrhuNPWotm1koB2MScXHPT8FJuijA24MGzW4LfMY2SGC+ho00=;
X-UUID: 769b7011e41e4c89b8b4c4ba5257be87-20200311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1845059689; Wed, 11 Mar 2020 15:40:51 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:38:24 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:42:01 +0800
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
Subject: [PATCH v3 1/4] dt-bindings: display: mediatek: add property to control mipi tx drive current
Date:   Wed, 11 Mar 2020 15:40:29 +0800
Message-ID: <20200311074032.119481-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311074032.119481-1-jitao.shi@mediatek.com>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 722E361D831C8C3966132F721EB94F410BBC341B3127202F294AB6C020A316202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgdG8gY29udHJvbCBtaXBpIHR4IGRyaXZlIGN1cnJlbnQ6DQoiZHJpdmUt
c3RyZW5ndGgtbWljcm9hbXAiDQoNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hp
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KaW5k
ZXggYTE5YTZjYzM3NWVkLi5kNTAxZjlmZjRiMWYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkc2kudHh0DQpAQCAtMzMsNiArMzMsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
IC0gI2Nsb2NrLWNlbGxzOiBtdXN0IGJlIDwwPjsNCiAtICNwaHktY2VsbHM6IG11c3QgYmUgPDA+
Lg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBkcml2ZS1zdHJlbmd0aC1taWNyb2FtcDog
YWRqdXN0IGRyaXZpbmcgY3VycmVudCwgc2hvdWxkIGJlIDEgfiAweEYNCisNCiBFeGFtcGxlOg0K
IA0KIG1pcGlfdHgwOiBtaXBpLWRwaHlAMTAyMTUwMDAgew0KQEAgLTQyLDYgKzQ1LDcgQEAgbWlw
aV90eDA6IG1pcGktZHBoeUAxMDIxNTAwMCB7DQogCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJtaXBp
X3R4MF9wbGwiOw0KIAkjY2xvY2stY2VsbHMgPSA8MD47DQogCSNwaHktY2VsbHMgPSA8MD47DQor
CWRyaXZlLXN0cmVuZ3RoLW1pY3JvYW1wID0gPDB4OD47DQogfTsNCiANCiBkc2kwOiBkc2lAMTQw
MWIwMDAgew0KLS0gDQoyLjIxLjANCg==

