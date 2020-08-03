Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C0CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F092067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gxlwnNWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHCGRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbgHCGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:13 -0400
X-UUID: 5d072af3c1334bafa496d88ed2da6609-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Qdktd20wLjTcPTyoa06CPYivUPB7aoPo14fqcOex0rA=;
        b=gxlwnNWf6Bx393EXt3JTIModJDINwBcOm+1ZZvCwvoqgOV0GjbQPtIAj+bgujbaXCjY8qHMzLgEC+MxuhiecMix1rxsoGxzhnTmXpfgkuzw5B4rGalaIr+0gkviyZIxs0Lk9fL8llQcNTXDuHwqAJ/RIPEVwbovdLSk00E5LAMo=;
X-UUID: 5d072af3c1334bafa496d88ed2da6609-20200803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2100253353; Mon, 03 Aug 2020 14:17:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:07 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v2,1/6] dt-binding: reset-controller: ti: add assert-deassert-together property
Date:   Mon, 3 Aug 2020 14:15:06 +0800
Message-ID: <20200803061511.29555-2-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803061511.29555-1-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGFzc2VydC1kZWFzc2VydC10b2dldGhlciBwcm9wZXJ0eSB0byBhbGxvdyBkZXZpY2UgdG8g
ZG8gc2VyaWFsaXplZA0KYXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRpb25zIGluIGEgc2luZ2xl
IHN0ZXAgYnkgJ3Jlc2V0JyBtZXRob2QuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxj
cnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dCB8IDMgKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggODY5NDU1
MDJjY2I1Li45MDNkMTk3OTk0MmYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC01OSw2
ICs1OSw5IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogUGxlYXNlIGFsc28gcmVmZXIgdG8gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3Jlc2V0LnR4dCBmb3INCiBjb21t
b24gcmVzZXQgY29udHJvbGxlciB1c2FnZSBieSBjb25zdW1lcnMuDQogDQorT3B0aW9uYWwgcHJv
cGVydGllczoNCistIGFzc2VydC1kZWFzc2VydC10b2dldGhlcjogQWxsb3cgZGV2aWNlIHRvIGRv
IHNlcmlhbGl6ZWQgYXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRpb25zIGluIGEgc2luZ2xlIHN0
ZXAgYnkgJ3Jlc2V0JyBtZXRob2QuDQorDQogRXhhbXBsZToNCiAtLS0tLS0tLQ0KIFRoZSBmb2xs
b3dpbmcgZXhhbXBsZSBkZW1vbnN0cmF0ZXMgYSBzeXNjb24gbm9kZSwgdGhlIHJlc2V0IGNvbnRy
b2xsZXIgbm9kZQ0KLS0gDQoyLjE4LjANCg==

