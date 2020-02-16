Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D0C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E664F22522
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XM6MU3il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgBPGRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 01:17:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32715 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbgBPGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 01:17:32 -0500
X-UUID: 170b37a9e81d49889acedff3c486d878-20200216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PnaAJPfe8UDyZR006OQGPtqV2JRsmbV8fNWy8VRokME=;
        b=XM6MU3illvDe5bPLhOpOVX1QoCU9Lfg7xrXnfwxPhJayfRGZSS3DpKRtp8XUyR5ZtwSSK5pZI1g1EV6097GcEneHlqfUOt2SFspEPvKH7nXXKRpcKvNmEoV4LPOv7f9SVymD4sblLZk59rjFvuhgHWZpc2uu1sRFtYDLSvLIjSM=;
X-UUID: 170b37a9e81d49889acedff3c486d878-20200216
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 13343661; Sun, 16 Feb 2020 14:17:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 16 Feb 2020 14:15:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 16 Feb 2020 14:17:17 +0800
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
Subject: [PATCH v2 1/3] dt-bindings: pwrap: mediatek: add pwrap support for MT6779
Date:   Sun, 16 Feb 2020 14:17:21 +0800
Message-ID: <1581833843-4485-2-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1581833843-4485-1-git-send-email-argus.lin@mediatek.com>
References: <1581833843-4485-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E42B2A5851BA3347534F24890D19F31A2FEBC875C3FF1CB527B8A703235A94082000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmcgZG9jdW1lbnQgb2YgcHdyYXAgZm9yIE1UNjc3OSBTb0NzLg0KDQpTaWduZWQt
b2ZmLWJ5OiBBcmd1cyBMaW4gPGFyZ3VzLmxpbkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvcHdyYXAudHh0IHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvcHdyYXAudHh0DQppbmRleCA3YTMyNDA0Li5lY2FjMmJi
IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRp
YXRlay9wd3JhcC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvcHdyYXAudHh0DQpAQCAtMjAsNiArMjAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0
aWVzIGluIHB3cmFwIGRldmljZSBub2RlLg0KIC0gY29tcGF0aWJsZToNCiAJIm1lZGlhdGVrLG10
MjcwMS1wd3JhcCIgZm9yIE1UMjcwMS83NjIzIFNvQ3MNCiAJIm1lZGlhdGVrLG10Njc2NS1wd3Jh
cCIgZm9yIE1UNjc2NSBTb0NzDQorCSJtZWRpYXRlayxtdDY3NzktcHdyYXAiIGZvciBNVDY3Nzkg
U29Dcw0KIAkibWVkaWF0ZWssbXQ2Nzk3LXB3cmFwIiBmb3IgTVQ2Nzk3IFNvQ3MNCiAJIm1lZGlh
dGVrLG10NzYyMi1wd3JhcCIgZm9yIE1UNzYyMiBTb0NzDQogCSJtZWRpYXRlayxtdDgxMzUtcHdy
YXAiIGZvciBNVDgxMzUgU29Dcw0KLS0NCjEuOC4xLjEuZGlydHkNCg==

