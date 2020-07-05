Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE4C433E3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3217120870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y3A/DejB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGEGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:37:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38247 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbgGEGh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:37:29 -0400
X-UUID: d426e204db8c44c2874b6228d209cf93-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J4IDLpeer4Fj06y4dRqObtm+xonToNceG9cdau6T5vY=;
        b=Y3A/DejBw2uSzE9GllN1r64l+0l3dOXnqD8KluKSvld+xH2yyMZ3kwPdcCH9Ggk4jGiou1ZE4+xwEX8P3h4HxYAsFILW4ZmF3Rtp0rByEyWkh2G6gl2xWcyunIJr1asZ/hSInaMJ2Wd+2PGDNlQMUDHRXTPgha1J10SGTOo1HlM=;
X-UUID: d426e204db8c44c2874b6228d209cf93-20200705
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1613927263; Sun, 05 Jul 2020 14:37:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:37:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:37:17 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v8 3/4] mailbox: cmdq: support mt6779 gce platform definition
Date:   Sun, 5 Jul 2020 14:37:15 +0800
Message-ID: <1593931037-24405-4-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593931037-24405-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1593931037-24405-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4C4972016B373AAADE769840E63A2ADC60DCA1685461B0E36D037F3E5D4640B42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGdjZSB2NCBoYXJkd2FyZSBzdXBwb3J0IHdpdGggZGlmZmVyZW50IHRocmVhZCBudW1iZXIg
YW5kIHNoaWZ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5o
c2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NClJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KUmV2aWV3ZWQtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgICAgMiArKw0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQppbmRleCA0OWQ5MjY0MTQ1YWEuLjA4YmQ0ZjFlYjQ2OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCkBAIC01NjQsMTAgKzU2NCwxMiBAQCBzdGF0aWMgaW50IGNtZHFfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGdj
ZV9wbGF0IGdjZV9wbGF0X3YyID0gey50aHJlYWRfbnIgPSAxNn07DQogc3RhdGljIGNvbnN0IHN0
cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92MyA9IHsudGhyZWFkX25yID0gMjR9Ow0KK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjQgPSB7LnRocmVhZF9uciA9IDI0LCAuc2hp
ZnQgPSAzfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBjbWRxX29mX2lk
c1tdID0gew0KIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0g
KHZvaWQgKikmZ2NlX3BsYXRfdjJ9LA0KIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LWdjZSIsIC5kYXRhID0gKHZvaWQgKikmZ2NlX3BsYXRfdjN9LA0KKwl7LmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQgKikmZ2NlX3BsYXRfdjR9LA0KIAl7
fQ0KIH07DQogDQotLSANCjEuNy45LjUNCg==

