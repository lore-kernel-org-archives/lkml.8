Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4E020825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E0IUHuWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH1FlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:41:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31451 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbgH1FlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:41:05 -0400
X-UUID: a24e78c8ad054f04a41d74d475691cb9-20200828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DsL7JdMQSOP11JNFHpjfppGikrqv3U4BccKwJYOaIIU=;
        b=E0IUHuWuLPw5ApkLG+SVqyr6XYxFH/DHJy4Vyk7jYJ/79udTlts5trKDcol8aYXJes2K7edtgWQwa+6iK8NEjD3Rq0Ry6IT5AJJPTqFDe1WXQCRAREUWxFXTJOTVDeBhhZm+FBhCENX/wjnc45tAZ/pNW1jDquKFlhST9B4yuiA=;
X-UUID: a24e78c8ad054f04a41d74d475691cb9-20200828
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 173352127; Fri, 28 Aug 2020 13:40:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Aug 2020 13:40:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Aug 2020 13:40:58 +0800
From:   Freddy Hsin <freddy.hsin@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Saravana Kannan <saravanak@google.com>,
        <chang-an.chen@mediatek.com>, Baolin Wang <baolin.wang7@gmail.com>,
        <wsd_upstream@mediatek.com>, <kuohong.wang@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH 0/1] Remove redundant condition for MTK_TIMER 
Date:   Fri, 28 Aug 2020 13:40:55 +0800
Message-ID: <1598593256-6719-1-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIHRoZSByZWR1bmRhbnQgY29uZGl0aW9uIG9mIE1US19USU1FUiBiZWNhdXNlIHRoZSBk
cml2ZXINCmNhbiB3b3JrIG9uIE1USyBwbGF0Zm9ybSBub3JtYWxseSwgc28gQ09NUElMRV9URVNU
IGlzIG5vIGxvbmdlcg0KbmVlZGVkIGZvciBkZXZlbG9wbWVudCBwdXJwb3NlDQoNCkZyZWRkeSBI
c2luICgxKToNCiAgdGltZXI6IG10Njg3MzogcmVtb3ZlIENPTVBJTEVfVEVTVCBjb25kaXRpb24g
Zm9yIE1USyB0aW1lcg0KDQogZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnIHwgMiArLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K

