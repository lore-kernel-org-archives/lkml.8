Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A110B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hg5v2DaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgHCGRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728205AbgHCGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:15 -0400
X-UUID: ec87b00452484ad6af0d99dcd7668655-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RfzQv3pa23d9FWLkvW15c3MBLQiopuBss1FtZAjoUcY=;
        b=Hg5v2DaHpQFuec7Ne4HnNkFG3nb49tKuXcQlUDruwfwDcnpIx4ZNlhnr3/NNyg7FjwB7qMp0BmPoaoRkkbFzaHbeLVM8yyq4wU9xqL+IgnFrpwQAv5FdMzgbJyI/hylxgaj9R0CUDv2pTs5i0SNyHKGEJt+dCQN4u/F7oW/7J3w=;
X-UUID: ec87b00452484ad6af0d99dcd7668655-20200803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1140123930; Mon, 03 Aug 2020 14:17:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:08 +0800
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
Subject: [v2,2/6] dt-binding: reset-controller: ti: add update-force property
Date:   Mon, 3 Aug 2020 14:15:07 +0800
Message-ID: <20200803061511.29555-3-crystal.guo@mediatek.com>
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

YWRkIHVwZGF0ZS1mb3JjZSBwcm9wZXJ0eSB0byBmb3JjZSB0aGUgd3JpdGUgb3BlcmF0aW9uDQpp
biBjYXNlIHRoZSByZWFkIGFscmVhZHkgaGFwcGVucyB0byByZXR1cm4gdGhlIGNvcnJlY3QgdmFs
dWUuDQoNClNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRpYXRlay5j
b20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lz
Y29uLXJlc2V0LnR4dCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5
c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
dGktc3lzY29uLXJlc2V0LnR4dA0KaW5kZXggOTAzZDE5Nzk5NDJmLi5kNTUxMTYxYWU3ODUgMTAw
NjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lz
Y29uLXJlc2V0LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jl
c2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCkBAIC02MSw2ICs2MSw3IEBAIGNvbW1vbiByZXNldCBj
b250cm9sbGVyIHVzYWdlIGJ5IGNvbnN1bWVycy4NCiANCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
IC0gYXNzZXJ0LWRlYXNzZXJ0LXRvZ2V0aGVyOiBBbGxvdyBkZXZpY2UgdG8gZG8gc2VyaWFsaXpl
ZCBhc3NlcnQgYW5kIGRlYXNzZXJ0IG9wZXJhdGlvbnMgaW4gYSBzaW5nbGUgc3RlcCBieSAncmVz
ZXQnIG1ldGhvZC4NCistIHVwZGF0ZS1mb3JjZTogRm9yY2UgdGhlIHdyaXRlIG9wZXJhdGlvbiBp
biBjYXNlIHRoZSByZWFkIGFscmVhZHkgaGFwcGVucyB0byByZXR1cm4gdGhlIGNvcnJlY3QgdmFs
dWUuDQogDQogRXhhbXBsZToNCiAtLS0tLS0tLQ0KLS0gDQoyLjE4LjANCg==

