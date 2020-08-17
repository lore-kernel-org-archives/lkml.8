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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF461C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1FA2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MsruNvkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgHQDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:05:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10421 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726424AbgHQDFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:05:04 -0400
X-UUID: 6781fee4fefb444eaf7b6cdbd425634a-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JJlKMP7ee02ays8KbIJqTQ/xkRTBFEVByYajjiFisPk=;
        b=MsruNvkLyuUFU/gLaYnStdITTrk2LG3mKzT9a2QZlaZLbcNu3jtjFeiXGXMB+8G6dxLrtsC0zc8qIxuEuEIln4hGwT6ZuZRE0z6bsmnKQ7Siq8KgWDJbkN5whrXme4HepB0uAvpYkO4oLaY6hiYsVkbesVP6t13haPOwNS8v8m0=;
X-UUID: 6781fee4fefb444eaf7b6cdbd425634a-20200817
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 933729504; Mon, 17 Aug 2020 11:05:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 11:05:00 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 11:04:59 +0800
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
Subject: [v4,2/4] dt-binding: reset-controller: ti: add 'mediatek,infra-reset' to compatible
Date:   Mon, 17 Aug 2020 11:03:22 +0800
Message-ID: <20200817030324.5690-3-crystal.guo@mediatek.com>
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

VGhlIFRJIHN5c2NvbiByZXNldCBjb250cm9sbGVyIHByb3ZpZGVzIGEgY29tbW9uIHJlc2V0IG1h
bmFnZW1lbnQsDQphbmQgaXMgc3VpdGFibGUgZm9yIE1USyBTb0NzLiBBZGQgY29tcGF0aWJsZSAn
bWVkaWF0ZWssaW5mcmEtcmVzZXQnLA0Kd2hpY2ggZGVub3RlcyB0byB1c2UgdGkgcmVzZXQtY29u
dHJvbGxlciBkcml2ZXIgZGlyZWN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxj
cnlzdGFsLmd1b0BtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggYWIwNDEwMzIz
MzliLi41YTBlOTM2NWI1MWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC0yNSw2ICsy
NSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogCQkJICAgICJ0aSxrMmwtcHNjcnN0Ig0KIAkJ
CSAgICAidGksazJoay1wc2Nyc3QiDQogCQkJICAgICJ0aSxzeXNjb24tcmVzZXQiDQorCQkJICAg
ICJtZWRpYXRlayxpbmZyYS1yZXNldCIsICJ0aSxzeXNjb24tcmVzZXQiDQogIC0gI3Jlc2V0LWNl
bGxzCQk6IFNob3VsZCBiZSAxLiBQbGVhc2Ugc2VlIHRoZSByZXNldCBjb25zdW1lciBub2RlIGJl
bG93DQogCQkJICBmb3IgdXNhZ2UgZGV0YWlscw0KICAtIHRpLHJlc2V0LWJpdHMJOiBDb250YWlu
cyB0aGUgcmVzZXQgY29udHJvbCByZWdpc3RlciBpbmZvcm1hdGlvbg0KLS0gDQoyLjE4LjANCg==

