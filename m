Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EACC76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18FD20857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C1kFXJgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgBPGOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 01:14:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11255 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbgBPGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 01:14:49 -0500
X-UUID: 424e2d7138ff489e9839306fa86f7107-20200216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TbzTN9VDopWuQM9WqUfKWtNwI/MMB07r6MYptBp9CNE=;
        b=C1kFXJgghN7biAXSh+10yiLQrMdaShPgpTtDpcS9xvEk4r2baIcfRweCDJw2rplEx6vTOacAhP6j1Y6k3OQexeBmC+TT7e3FdhmvG1USFirEQOkQBcsse8KErQ6Di9yPVJwNZ895uZpSNd/s9IQer3iFC6yWYxSChiqQevGufuw=;
X-UUID: 424e2d7138ff489e9839306fa86f7107-20200216
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 39784462; Sun, 16 Feb 2020 14:14:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 16 Feb 2020 14:13:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 16 Feb 2020 14:14:32 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Chenglin Xu <chenglin.xu@mediatek.com>, <argus.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <henryc.chen@mediatek.com>,
        <flora.fu@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/3] soc: mediatek: pwrap: add pwrap driver for MT6779 SoCs
Date:   Sun, 16 Feb 2020 14:14:36 +0800
Message-ID: <1581833679-4319-1-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2hhbmdlcyBzaW5jZSB2MToNCjEuIE1vZGlmeSBwd3JhcF9tdDY3NzkgYXJiX2VuX2FsbCwgaW50
X2VuX2FsbCwgYW5kIHdkdF9zcmMgdmFsdWUNCndoZW4gaW5pdGlhbGl6YXRpb24uDQoyLiBSZW1v
dmUgUFdSQVBfV0RUX1VOSVQsIFBXUkFQX1dEVF9VTklULCBQV1JBUF9JTlRfRU4sIGFuZA0KUFdS
QVBfQ0FQX0lOVDFfRU4gcmVnaXN0ZXJlZCB2YWx1ZSBjaGVjaywgd2Ugd2lsbCBpbml0aWFsaXpl
IHRoZW0NCmFnYWluIGF0IGtlcm5lbCBsZXZlbC4NCg0KSGVyZSdzIHZlcnNpb24gMSBvZiB0aGUg
cGF0Y2ggc2VyaWVzLCBpbmNsdWRlIDMgcGF0Y2hlczoNCjEuIEFkZCBjb21wYXRpYmxlIGZvciBN
VDY3NzkgcHdyYXANCjIuIEFkZCBwd3JhcCBkcml2ZXIgZm9yIE1UNjc3OSBTb0NzLiBLZWVwIFBX
UkFQX0hJUFJJT19BUkJfRU4sDQpQV1JBUF9XRFRfVU5JVCwgYW5kIFBXUkFQX1dEVF9TUkNfRU4g
dmFsdWUgaWYgaXQgaGFzIGluaXRpYWxpemVkLg0KV2hlbiB3ZSBlbmFibGUgaW50ZXJydXB0IGZs
YWcsIHJlYWQgY3VycmVudCB2YWx1ZSB0aGVuIGRvIGxvZ2ljYWwNCk9SIG9wZXJzaW9uIHdpdGgg
d3JwLT5tYXN0ZXItPmludF9lbl9hbGwuDQozLiBBZGQgTVQ2MzU5IHN1cHBvcnQgZm9yIE1UNjc3
OSBTb0NzLg0KDQpBcmd1cyBMaW4gKDMpOg0KICBkdC1iaW5kaW5nczogcHdyYXA6IG1lZGlhdGVr
OiBhZGQgcHdyYXAgc3VwcG9ydCBmb3IgTVQ2Nzc5DQogIHNvYzogbWVkaWF0ZWs6IHB3cmFwOiBh
ZGQgcHdyYXAgZHJpdmVyIGZvciBNVDY3NzkgU29Dcw0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDog
YWRkIHN1cHBvcnQgZm9yIE1UNjM1OSBQTUlDDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvcHdyYXAudHh0ICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLXBtaWMtd3JhcC5jICAgICAgICAgICAgICAgfCAxMjggKysrKysrKysrKysrKysrKysrKysr
DQogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQ0KDQotLQ0KMS44LjEuMS5kaXJ0
eQ0K

