Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A934C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC8820838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oFi85Z21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBGJXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:23:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:16898 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727446AbgBGJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:23:44 -0500
X-UUID: c48d4d7cd20f4b9fb544ce5828f5ea85-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UbnXG7anPzekXSKoVAsd9UcuJJBevQ2oSv9/xVk+BPE=;
        b=oFi85Z211h5tt1kAgCy396ShlP04yQJioFeQxc6pFE1oBXfl0K5CMrnWSYd7YiMwVXs+ysTsz9uLxGIJF6T3ifwQ+/TWAHuxjQakgnuKs/U5mK48At9qfXllDycqmgLK8h3eOwmRMqyPA+D1anynG8MvrNIYDNsc56zt8hMd7n4=;
X-UUID: c48d4d7cd20f4b9fb544ce5828f5ea85-20200207
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1628606181; Fri, 07 Feb 2020 17:23:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 17:24:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 17:22:59 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v7 7/7] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks
Date:   Fri, 7 Feb 2020 17:20:50 +0800
Message-ID: <1581067250-12744-8-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
References: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT3dlbiBDaGVuIDxvd2VuLmNoZW5AbWVkaWF0ZWsuY29tPg0KDQpFbmFibGUgTVQ2NzY1
IGNsb2NrIGNvbmZpZ3MsIGluY2x1ZGUgdG9wY2tnZW4sIGFwbWl4ZWRzeXMsDQppbmZyYWNmZywg
YW5kIHN1YnN5c3RlbSBjbG9ja3MuDQoNClNpZ25lZC1vZmYtYnk6IE93ZW4gQ2hlbiA8b3dlbi5j
aGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxp
bkBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgNiAr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZp
Zw0KaW5kZXggNmE4M2JhMmFlYTNlLi45ZDNkYTgxZDBkMDggMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmln
DQpAQCAtNDg5LDYgKzQ4OSwxMiBAQCBDT05GSUdfUkVHVUxBVE9SX1FDT01fU01EX1JQTT15DQog
Q09ORklHX1JFR1VMQVRPUl9RQ09NX1NQTUk9eQ0KIENPTkZJR19SRUdVTEFUT1JfUks4MDg9eQ0K
IENPTkZJR19SRUdVTEFUT1JfUzJNUFMxMT15DQorQ09ORklHX0NPTU1PTl9DTEtfTVQ2NzY1X0FV
RElPU1lTPXkNCitDT05GSUdfQ09NTU9OX0NMS19NVDY3NjVfQ0FNU1lTPXkNCitDT05GSUdfQ09N
TU9OX0NMS19NVDY3NjVfTU1TWVM9eQ0KK0NPTkZJR19DT01NT05fQ0xLX01UNjc2NV9JTUdTWVM9
eQ0KK0NPTkZJR19DT01NT05fQ0xLX01UNjc2NV9WQ09ERUNTWVM9eQ0KK0NPTkZJR19DT01NT05f
Q0xLX01UNjc2NV9NSVBJMEFTWVM9eQ0KIENPTkZJR19SRUdVTEFUT1JfVkNUUkw9bQ0KIENPTkZJ
R19SQ19DT1JFPW0NCiBDT05GSUdfUkNfREVDT0RFUlM9eQ0KLS0gDQoyLjE4LjANCg==

