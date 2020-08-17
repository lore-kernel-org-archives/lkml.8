Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC78C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE632087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LZMroCEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHQDE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:04:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50481 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726424AbgHQDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:04:55 -0400
X-UUID: 36b69d2164f14983b493d402712a5cb9-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t4ilFaoK0tLBNope3nohB/2oIAVf+4PK2ECy4GhL2WE=;
        b=LZMroCEtDXNUpAbWTI/3dgS5VE/Za5n4BydgC1gARzNP3c8DLV4h+gC97O1K8rxxnrTpoacgiw3dLrhieMdUrbltPc0Rs9kYiCt61/ACF3XZk5M2Eole/HlJ0qWGA5na/AluZNcJKtKJEYmdz9xfD7Fj3ruk/7fbNZeiEwEv6zs=;
X-UUID: 36b69d2164f14983b493d402712a5cb9-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 783053291; Mon, 17 Aug 2020 11:04:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 11:04:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 11:04:49 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v4,1/4] dt-binding: reset-controller: ti: add reset-duration-us property
Date:   Mon, 17 Aug 2020 11:03:21 +0800
Message-ID: <20200817030324.5690-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817030324.5690-1-crystal.guo@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aW50cm9kdWNlICdyZXNldCcgbWV0aG9kIHRvIGFsbG93IGRldmljZSBkbyBzZXJpYWxpemVkIGFz
c2VydCBhbmQNCmRlYXNzZXJ0IG9wZXJhdGlvbnMgaW4gYSBzaW5nbGUgc3RlcCwgd2hpY2ggbmVl
ZHMgYSBtaW5pbXVtIGRlbGF5DQp0byBiZSB3YWl0ZWQgYmV0d2VlbiBhc3NlcnQgYW5kIGRlYXNz
ZXJ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5
c2Nvbi1yZXNldC50eHQgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0
L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggODY5NDU1MDJjY2I1Li5hYjA0MTAzMjMz
OWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
dGktc3lzY29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC01OSw2ICs1OSwxMSBAQCBSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KIFBsZWFzZSBhbHNvIHJlZmVyIHRvIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZXNldC9yZXNldC50eHQgZm9yDQogY29tbW9uIHJlc2V0IGNvbnRyb2xs
ZXIgdXNhZ2UgYnkgY29uc3VtZXJzLg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSByZXNl
dC1kdXJhdGlvbi11czogV2hlbiBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3Bl
cmF0aW9ucywgbWluaW11bSBkZWxheSBpbiBtaWNyb3NlY29uZHMNCitpcyBuZWVkZWQgdG8gYmUg
d2FpdGVkIGJldHdlZW4gYW4gYXNzZXJ0IGFuZCBhIGRlYXNzZXJ0IHRvIHJlc2V0IHRoZSBkZXZp
Y2UuIFRoaXMgdmFsdWUgY2FuIGJlIDAsIDAgbWVhbnMNCit0aGF0IHN1Y2ggYSBkZWxheSBpcyBu
b3QgbmVlZGVkLg0KKw0KIEV4YW1wbGU6DQogLS0tLS0tLS0NCiBUaGUgZm9sbG93aW5nIGV4YW1w
bGUgZGVtb25zdHJhdGVzIGEgc3lzY29uIG5vZGUsIHRoZSByZXNldCBjb250cm9sbGVyIG5vZGUN
Ci0tIA0KMi4xOC4wDQo=

